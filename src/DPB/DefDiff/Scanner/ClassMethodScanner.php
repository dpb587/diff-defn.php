<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\ClassDefinition;
use DPB\DefDiff\Definition\Definition;
use DPB\DefDiff\Definition\FunctionDefinition;

class ClassMethodScanner extends Scanner
{
    protected $currClass;

    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            $this->currClass = $node->namespacedName->toString();
        } elseif ($node instanceof \PHPParser_Node_Stmt_ClassMethod) {
            $defn = $this->scope
                ->assert(new ClassDefinition($this->currClass))
                ->assert(new FunctionDefinition($node->name))
            ;

            $defn->setAttribute('line', $node->getAttribute('startLine'));

            if ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_PUBLIC) {
                $defn->setAttribute('visibility', 'public');
            } elseif ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_PROTECTED) {
                $defn->setAttribute('visibility', 'protected');
            } elseif ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_PRIVATE) {
                $defn->setAttribute('visibility', 'private');
            }

            $defn->setAttribute('final', (bool) ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_FINAL));
            $defn->setAttribute('static', (bool) ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_STATIC));
            $defn->setAttribute('abstract', (bool) ($node->type & \PHPParser_Node_Stmt_Class::MODIFIER_ABSTRACT));
        }
    }

    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            unset($this->currClass);
        }
    }
}
