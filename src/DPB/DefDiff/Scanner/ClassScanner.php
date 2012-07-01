<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\Definition;

class ClassScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            $defn = $this->scope
                ->assert('class')
                ->assert(new Definition($node->namespacedName->toString()))
            ;

            $defn->setAttribute('file', '/dev/null');
            $defn->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
