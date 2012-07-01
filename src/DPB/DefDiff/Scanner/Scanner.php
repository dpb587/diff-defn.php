<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\Definition;

abstract class Scanner extends \PHPParser_NodeVisitorAbstract
{
    protected $scope;

    public function __construct(Definition $scope)
    {
        $this->scope = $scope;
    }
}
