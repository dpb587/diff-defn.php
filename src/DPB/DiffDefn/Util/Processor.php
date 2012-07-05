<?php

namespace DPB\DiffDefn\Util;

use DPB\DiffDefn\Definition\Definition;

class Processor
{
    static public function process(Definition $scope, $code)
    {
        $parser = new \PHPParser_Parser(new \PHPParser_Lexer());

        $traverser = new \PHPParser_NodeTraverser();
        $traverser->addVisitor(new \PHPParser_NodeVisitor_NameResolver());
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\ClassScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\ClassConstScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\ClassExtendsScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\ClassFunctionScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\ClassFunctionParamScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\ClassImplementsScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\ConstScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\FunctionScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\FunctionParamScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\InterfaceScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\InterfaceConstScanner($scope));
        $traverser->addVisitor(new \DPB\DiffDefn\Scanner\InterfaceFunctionScanner($scope));

        $traverser->traverse($parser->parse($code));
    }
}
