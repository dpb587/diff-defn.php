<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\AttrDefinition;
use DPB\DefDiff\Definition\InterfaceDefinition;
use DPB\DefDiff\Definition\ConstDefinition;
use DPB\DefDiff\Definition\DefnDefinition;
use DPB\DefDiff\Definition\DefnSourceDefinition;
use DPB\DefDiff\Definition\Definition;
use DPB\DefDiff\Definition\FunctionDefinition;

class InterfaceConstScanner extends Scanner
{
    protected $currInterface;

    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Interface) {
            $this->currInterface = $node->namespacedName->toString();
        } elseif ($node instanceof \PHPParser_Node_Stmt_ClassConst && isset($this->currInterface)) {
            $defn = $this->scope
                ->assert(new InterfaceDefinition($this->currInterface))
                ->assert(new ConstDefinition($node->consts[0]->name))
            ;

            $source = $defn->assert(new DefnSourceDefinition('source'));

            if ($this->scope->hasAttribute('file')) {
                $source->setAttribute('file', $this->scope->getAttribute('file'));
            }

            $source->setAttribute('line', $node->consts[0]->getAttribute('startLine'));

            $attr = $defn->assert(new AttrDefinition('visibility'));

            if ($node->consts[0]->type & \PHPParser_Node_Stmt_Class::MODIFIER_PUBLIC) {
                $attr->setAttribute('value', 'public');
            } elseif ($node->consts[0]->type & \PHPParser_Node_Stmt_Class::MODIFIER_PROTECTED) {
                $attr->setAttribute('value', 'protected');
            } elseif ($node->consts[0]->type & \PHPParser_Node_Stmt_Class::MODIFIER_PRIVATE) {
                $attr->setAttribute('value', 'private');
            }
        }
    }

    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Interface) {
            unset($this->currInterface);
        }
    }
}
