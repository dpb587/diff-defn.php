<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\DefnAttrDefinition;
use DPB\DiffDefn\Definition\FunctionDefinition;
use DPB\DiffDefn\Definition\FunctionParamDefinition;

class FunctionParamScanner extends Scanner
{
    protected $currFunction;

    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Function) {
            $this->currFunction = $node->name;
        } elseif ($node instanceof \PHPParser_Node_Param && isset($this->currClass) && isset($this->currMethod)) {
            $defn = $this->scope
                ->assert(new FunctionDefinition($this->currFunction))
                ->assert(new FunctionParamDefinition($node->name))
            ;

            if ($node->default) {
                $attr = $defn->assert(new DefnAttrDefinition('default'));

                if ($node->default instanceof \PHPParser_Node_Scalar) {
                    $attr->setAttribute('type', 'string');
                    $attr->setAttribute('value', json_encode($node->default->value));
                } elseif ($node->default instanceof \PHPParser_Node_Expr_ConstFetch) {
                    $attr->setAttribute('type', 'const');
                    $attr->setAttribute('value', implode('', $node->default->name->parts)); // @todo correct?
                } elseif ($node->default instanceof \PHPParser_Node_Expr_ClassConstFetch) {
                    $attr->setAttribute('type', 'const');
                    $attr->setAttribute('value', implode('', $node->default->class->parts) . '::' . $node->default->name);
                } elseif ($node->default instanceof \PHPParser_Node_Expr_Array) {
                    $attr->setAttribute('type', 'array');
                    $attr->setAttribute('value', json_encode($node->default->items));
                } elseif ($node->default instanceof \PHPParser_Node_Expr_UnaryMinus) {
                    $attr->setAttribute('type', 'literal');
                    $attr->setAttribute('value', json_encode($node->default->expr->value));
                } else {
                    die(print_r($node->default, true));
                    throw new \LogicException('unhandled');
                }
            }

            if ($node->type) {
                $attr = $defn->assert(new DefnAttrDefinition('typehint'));
                $attr->setAttribute('value', (string) $node->type);
            }
        }
    }

    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Function) {
            unset($this->currFunction);
        }
    }
}
