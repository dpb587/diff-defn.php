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
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\ClassMethodScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\ClassMethodParamScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\ConstScanner($scope));
        $traverser->addVisitor(new \DPB\DefDiff\Scanner\FunctionScanner($scope));

        $traverser->traverse($parser->parse($code));
    }
}
