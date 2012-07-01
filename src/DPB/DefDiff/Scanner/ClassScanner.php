<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\ClassDefinition;

class ClassScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            $defn = $this->scope
                ->assert(new ClassDefinition($node->namespacedName->toString()))
            ;

            $defn->setAttribute('file', '/dev/null');
            $defn->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
