<?php

namespace DPB\DefDiff\Scanner;

use DPB\DefDiff\Definition\Definition;

class ClassMethodArgumentScanner extends Scanner
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
                ->assert('class')
                ->assert($this->currClass)
                ->assert('method')
                ->assert($this->currMethod)
                ->assert('params')
                ->assert($node->name)
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
                } else {
                    die(print_r($node->default, true));
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
