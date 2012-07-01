<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\ClassDefinition;
use DPB\DefDiff\Definition\FunctionDefinition;
use DPB\DefDiff\Definition\FunctionParamDefinition;

class ClassMethodParamScanner extends Scanner
{
    protected $currClass;
    protected $currMethod;

    public function enterNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_Class) {
            $this->currClass = $node->namespacedName->toString();
        } elseif ($node instanceof \PHPParser_Node_Stmt_ClassMethod) {
            $this->currMethod = $node->name;
        } elseif ($node instanceof \PHPParser_Node_Param && $this->currClass && $this->currMethod) {
            $defn = $this->scope
                ->assert(new ClassDefinition($this->currClass))
                ->assert(new FunctionDefinition($this->currMethod))
                ->assert(new FunctionParamDefinition($node->name))
            ;

            if ($node->default) {
                if ($node->default instanceof \PHPParser_Node_Scalar_String) {
                    $defn->setAttribute(
                        'default',
                        array(
                            'type' => 'string',
                            'value' => $node->default->value,
                        )
                    );
                } elseif ($node->default instanceof \PHPParser_Node_Expr_ConstFetch) {
                    $defn->setAttribute(
                        'default',
                        array(
                            'type' => 'const',
                            'value' => implode('', $node->default->name->parts), // @todo correct?
                        )
                    );
                } elseif ($node->default instanceof \PHPParser_Node_Expr_Array) {
                    $defn->setAttribute(
                        'default',
                        array(
                            'type' => 'array',
                            'value' => $node->default->items,
                        )
                    );
                } elseif ($node->default instanceof \PHPParser_Node_Scalar) {
                    $defn->setAttribute(
                        'default',
                        array(
                            'type' => 'literal',
                            'value' => $node->default->value,
                        )
                    );
                } else {
                    throw new \LogicException('unhandled');
                }
            }

            if ($node->type) {
                $defn->setAttribute('type', (string) $node->type);
            }
        }
    }

    public function leaveNode(\PHPParser_Node $node)
    {
        if ($node instanceof \PHPParser_Node_Stmt_ClassMethod) {
            unset($this->currMethod);
        } elseif ($node instanceof \PHPParser_Node_Stmt_Class) {
            unset($this->currClass);
        }
    }
}
