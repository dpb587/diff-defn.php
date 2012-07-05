<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\ConstDefinition;
use DPB\DiffDefn\Definition\DefnSourceDefinition;

class ConstScanner extends Scanner
{
    protected $stmtScope = array();

    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            array_push($this->stmtScope, 'class');
        } elseif ($node instanceof \PHPParser_Node_Stmt_Interface) {
            array_push($this->stmtScope, 'interface');
        } elseif (($node instanceof \PHPParser_Node_Const) && (0 == count($this->stmtScope))) {
            if (isset($node->_classScope)) {
                return;
            }

            $defn = $this->scope
                ->assert(new ConstDefinition($node->name))
            ;

            $source = $defn->assert(new DefnSourceDefinition('source'));

            if ($this->scope->hasAttribute('file')) {
                $source->setAttribute('file', $this->scope->getAttribute('file'));
            }

            $source->setAttribute('line', $node->getAttribute('startLine'));
        }
    }

    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            array_shift($this->stmtScope);
        } elseif ($node instanceof \PHPParser_Node_Stmt_Interface) {
            array_shift($this->stmtScope);
        }
    }
}
