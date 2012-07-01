<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\ConstDefinition;

class ConstScanner extends Scanner
{
    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Const) {
            $defn = $this->scope
                ->assert(new ConstDefinition($node->name))
            ;

            $defn->setAttribute('file', '/dev/null');
            $defn->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
