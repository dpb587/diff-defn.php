<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\ClassDefinition;
use DPB\DiffDefn\Definition\ClassExtendsDefinition;

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
