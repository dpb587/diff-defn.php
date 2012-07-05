<?php

namespace DPB\DiffDefn\Scanner;

use DPB\DiffDefn\Definition\AttrDefinition;
use DPB\DiffDefn\Definition\ClassDefinition;
use DPB\DiffDefn\Definition\FunctionDefinition;
use DPB\DiffDefn\Definition\FunctionParamDefinition;

class ClassFunctionParamScanner extends Scanner
{
    protected $currClass;
    protected $currFunction;

    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            $this->currClass = $node->namespacedName->toString();
        } elseif ($node instanceof \PHPParser_Node_Stmt_ClassMethod) {
            $this->currFunction = $node->name;
        } elseif ($node instanceof \PHPParser_Node_Param && isset($this->currClass, $this->currFunction)) {
            $defn = $this->scope
                ->assert(new ClassDefinition($this->currClass))
                ->assert(new FunctionDefinition($this->currFunction))
                ->assert(new FunctionParamDefinition($node->name))
            ;

            if ($node->default) {
                $attr = $defn->assert(new AttrDefinition('default'));

                if ($node->default instanceof \PHPParser_Node_Scalar) {
                    $attr->setAttribute('type', 'literal');
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
                $attr = $defn->assert(new AttrDefinition('typehint'));
                $attr->setAttribute('value', (string) $node->type);
            }
        }
    }

    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_ClassMethod) {
            unset($this->currFunction);
        } elseif ($node instanceof \PHPParser_Node_Stmt_Class) {
            unset($this->currClass);
        }
    }
}
