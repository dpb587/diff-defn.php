<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\AttrDefinition;
use DPB\DiffDefn\Definition\InterfaceDefinition;
use DPB\DiffDefn\Definition\DefnDefinition;
use DPB\DiffDefn\Definition\DefnSourceDefinition;
use DPB\DiffDefn\Definition\Definition;
use DPB\DiffDefn\Definition\FunctionDefinition;

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
