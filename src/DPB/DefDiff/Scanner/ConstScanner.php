<?php

namespace DPB\DefDiff\Scanner;

class ConstScanner extends Scanner
{
    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Const) {
            $defn = $this->scope
                ->assert('constant')
                ->assert($node->name)
            ;

            $defn->setAttribute('file', '/dev/null');
            $defn->setAttribute('line', $node->getAttribute('startLine'));
        }
    }
}
