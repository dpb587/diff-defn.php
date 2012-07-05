<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\AttrDefinition;
use DPB\DiffDefn\Definition\ClassDefinition;
use DPB\DiffDefn\Definition\DefnDefinition;
use DPB\DiffDefn\Definition\DefnSourceDefinition;
use DPB\DiffDefn\Definition\Definition;
use DPB\DiffDefn\Definition\FunctionDefinition;

class ClassFunctionScanner extends Scanner
{
    protected $currClass;

    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            $this->currClass = $node->namespacedName->toString();
        } elseif ($node instanceof \PHPParser_Node_Stmt_ClassMethod && isset($this->currClass)) {
            $defn = $this->scope
                ->assert(new ClassDefinition($this->currClass))
                ->assert(new FunctionDefinition($node->name))
            ;

            $source = $defn->assert(new DefnSourceDefinition('source'));

            if ($this->scope->hasAttribute('file')) {
                $source->setAttribute('file', $this->scope->getAttribute('file'));
            }

            $source->setAttribute('line', $node->getAttribute('startLine'));

            $attr = $defn->assert(new AttrDefinition('visibility'));

            if ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_PUBLIC) {
                $attr->setAttribute('value', 'public');
            } elseif ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_PROTECTED) {
                $attr->setAttribute('value', 'protected');
            } elseif ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_PRIVATE) {
                $attr->setAttribute('value', 'private');
            }

            $defn->assert(new AttrDefinition('final'))->setAttribute('value', (bool) ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_FINAL));
            $defn->assert(new AttrDefinition('static'))->setAttribute('value', (bool) ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_STATIC));
            $defn->assert(new AttrDefinition('abstract'))->setAttribute('value', (bool) ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_ABSTRACT));
        }
    }

    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            unset($this->currClass);
        }
    }
}
