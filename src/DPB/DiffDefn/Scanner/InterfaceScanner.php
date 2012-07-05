<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\InterfaceDefinition;
use DPB\DiffDefn\Definition\DefnSourceDefinition;

class InterfaceScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Interface) {
            $defn = $this->scope
                ->assert(new InterfaceDefinition($node->namespacedName->toString()))
            ;

            $source = $defn->assert(new DefnSourceDefinition('source'));

            if ($this->scope->hasAttribute('file')) {
                $source->setAttribute('file', $this->scope->getAttribute('file'));
            }

            $source->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
