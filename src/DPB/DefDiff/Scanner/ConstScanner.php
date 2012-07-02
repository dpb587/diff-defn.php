<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\ConstDefinition;
use DPB\DefDiff\Definition\DefnDefinition;

class ConstScanner extends Scanner
{
    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Const) {
            $defn = $this->scope
                ->assert(new ConstDefinition($node->name))
            ;

            #$source = $defn->assert(new DefnDefinition('source'));
            #$source->setAttribute('file', '/dev/null');
            #$source->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
