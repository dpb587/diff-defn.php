<?php

namespace DPB\DefDiff\Util;

use DPB\DefDiff\Definition\Definition;

class Processor
{
    static public function process(Definition $scope, $code)
    {
        $parser = new \PHPParser_Parser(new \PHPParser_Lexer());

        $traverser = new \PHPParser_NodeTraverser();
        $traverser->addVisitor(new \PHPParser_NodeVisitor_NameResolver());
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\ClassScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\ClassConstScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\ClassFunctionScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\ClassFunctionParamScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\ConstScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\FunctionScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\FunctionParamScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\InterfaceScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\InterfaceConstScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\InterfaceFunctionScanner($scope));

        $traverser->traverse($parser->parse($code));
    }
}
