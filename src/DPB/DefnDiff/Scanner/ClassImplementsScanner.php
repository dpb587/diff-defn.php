<?php

namespace DPB\DefnDiff\Scanner;

use DPB\DefnDiff\Definition\ClassDefinition;
use DPB\DefnDiff\Definition\ClassImplementsDefinition;
use DPB\DefnDiff\Definition\DefnDefinition;
use DPB\DefnDiff\Definition\DefnSourceDefinition;

class ClassImplementsScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            if ($node->implements) {
                $defn = $this->scope
                    ->assert(new ClassDefinition($node->namespacedName->toString()))
                ;
    
                foreach ($node->implements as $subnode) {
                    $defn->assert(new ClassImplementsDefinition(implode('\\', $subnode->parts)));
                }
            }
        }
    }
}
