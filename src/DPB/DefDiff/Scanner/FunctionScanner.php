<?php

namespace DPB\DefDiff\Scanner;

class FunctionScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Function) {
            $defn = $this->scope
                ->assert('function')
                ->assert($node->namespacedName->toString())
            ;

            $defn->setAttribute('file', '/dev/null');
            $defn->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
