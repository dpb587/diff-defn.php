<?php

namespace DPB\DefnDiff\Scanner;

use DPB\DefnDiff\Definition\AttrDefinition;
use DPB\DefnDiff\Definition\ClassDefinition;
use DPB\DefnDiff\Definition\DefnDefinition;
use DPB\DefnDiff\Definition\DefnSourceDefinition;
use DPB\DefnDiff\Definition\Definition;
use DPB\DefnDiff\Definition\FunctionDefinition;

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
