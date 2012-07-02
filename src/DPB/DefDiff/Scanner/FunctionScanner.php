<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\DefnDefinition;
use DPB\DefDiff\Definition\FunctionDefinition;

class FunctionScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Function) {
            $defn = $this->scope
                ->assert(new FunctionDefinition($node->namespacedName->toString()))
            ;

            #$source = $defn->assert(new DefnDefinition('source'));
            #$source->setAttribute('file', '/dev/null');
            #$source->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
