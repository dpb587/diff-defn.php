<?php

namespace DPB\DefnDiff\Util;

use DPB\DefnDiff\Definition\Definition;

class Processor
{
    static public function process(Definition $scope, $code)
    {
        $parser = new \PHPParser_Parser(new \PHPParser_Lexer());

        $traverser = new \PHPParser_NodeTraverser();
        $traverser->addVisitor(new \PHPParser_NodeVisitor_NameResolver());
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\ClassScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\ClassConstScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\ClassExtendsScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\ClassFunctionScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\ClassFunctionParamScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\ClassImplementsScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\ConstScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\FunctionScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\FunctionParamScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\InterfaceScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\InterfaceConstScanner($scope));
        $traverser->addVisitor(new \DPB\DefnDiff\Scanner\InterfaceFunctionScanner($scope));

        $traverser->traverse($parser->parse($code));
    }
}
