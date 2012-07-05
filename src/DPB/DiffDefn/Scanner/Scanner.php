<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\Definition;

abstract class Scanner extends \PHPParser_NodeVisitorAbstract
{
    protected $scope;

    public function __construct(Definition $scope)
    {
        $this->scope = $scope;
    }
}
