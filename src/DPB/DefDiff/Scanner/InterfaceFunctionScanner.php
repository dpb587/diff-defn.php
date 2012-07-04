<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\AttrDefinition;
use DPB\DefDiff\Definition\InterfaceDefinition;
use DPB\DefDiff\Definition\DefnDefinition;
use DPB\DefDiff\Definition\DefnSourceDefinition;
use DPB\DefDiff\Definition\Definition;
use DPB\DefDiff\Definition\FunctionDefinition;

class InterfaceFunctionScanner extends Scanner
{
    protected $currInterface;

    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Interface) {
            $this->currInterface = $node->namespacedName->toString();
        } elseif ($node instanceof \PHPParser_Node_Stmt_ClassMethod && isset($this->currInterface)) {
            $defn = $this->scope
                ->assert(new InterfaceDefinition($this->currInterface))
                ->assert(new FunctionDefinition($node->name))
            ;

            $source = $defn->assert(new DefnSourceDefinition('source'));

            if ($this->scope->hasAttribute('file')) {
                $source->setAttribute('file', $this->scope->getAttribute('file'));
            }

            $source->setAttribute('line', $node->getAttribute('startLine'));
        }
    }

    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Interface) {
            unset($this->currInterface);
        }
    }
}
