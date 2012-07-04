<?php

namespace DPB\DefnDiff\Scanner;

use DPB\DefnDiff\Definition\ClassDefinition;
use DPB\DefnDiff\Definition\ClassExtendsDefinition;
use DPB\DefnDiff\Definition\DefnDefinition;
use DPB\DefnDiff\Definition\DefnSourceDefinition;

class ClassExtendsScanner extends Scanner
{
    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            if ($node->extends) {
                $this->scope
                    ->assert(new ClassDefinition($node->namespacedName->toString()))
                    ->assert(new ClassExtendsDefinition(implode('\\', $node->extends->parts)))
                ;
            }
        }
    }
}
