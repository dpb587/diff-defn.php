<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\DefnDefinition;
use DPB\DefDiff\Definition\DefnSourceDefinition;
use DPB\DefDiff\Definition\FunctionDefinition;

class FunctionScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Function) {
            $defn = $this->scope
                ->assert(new FunctionDefinition($node->namespacedName->toString()))
            ;

            $source = $defn->assert(new DefnSourceDefinition('source'));

            if ($this->scope->hasAttribute('file')) {
                $source->setAttribute('file', $this->scope->getAttribute('file'));
            }

            $source->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
