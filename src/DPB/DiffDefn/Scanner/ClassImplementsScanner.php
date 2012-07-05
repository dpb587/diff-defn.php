<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\ClassDefinition;
use DPB\DiffDefn\Definition\ClassImplementsDefinition;
use DPB\DiffDefn\Definition\DefnDefinition;
use DPB\DiffDefn\Definition\DefnSourceDefinition;

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
