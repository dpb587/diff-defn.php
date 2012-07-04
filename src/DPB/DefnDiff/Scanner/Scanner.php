<?php

namespace DPB\DefnDiff\Scanner;

use DPB\DefnDiff\Definition\Definition;

abstract class Scanner extends \PHPParser_NodeVisitorAbstract
{
    protected $scope;

    public function __construct(Definition $scope)
    {
        $this->scope = $scope;
    }
}
