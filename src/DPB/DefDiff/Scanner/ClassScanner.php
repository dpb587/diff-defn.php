<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\ClassDefinition;
use DPB\DefDiff\Definition\DefnDefinition;

class ClassScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            $defn = $this->scope
                ->assert(new ClassDefinition($node->namespacedName->toString()))
            ;

            #$source = $defn->assert(new DefnDefinition('source'));
            #$source->setAttribute('file', '/dev/null');
            #$source->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
