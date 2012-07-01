<?php

namespace DPB\DefDiff\Definition;

class Definition
{
    private $defnId;
    private $defnParent;
    protected $nodes = array();
    protected $attrs = array();

    public function __construct($defnId)
    {
        $this->defnId = $defnId;
    }

    public function getDefnId()
    {
        return $this->defnId;
    }

    public function setDefnParent(Definition $defnParent)
    {
        $this->defnParent = $defnParent;
    }

    public function getDefnParent()
    {
        return $this->defnParent;
    }

    public function setAttribute($name, $value)
    {
        $this->attrs[$name] = $value;
    }

    public function getAttribute($name)
    {
        if (!isset($this->attrs[$name])) {
            throw new \InvalidArgumentException(sprintf('The attribute "%s" does not exist.', $name));
        }

        return $this->attrs[$name];
    }

    public function assert($defn)
    {
        if (is_string($defn)) {
            $defn = new Definition($defn);
        } elseif (!$defn instanceof Definition) {
            throw new \InvalidArgumentException('Argument 1 of assert must be a string or Definition.');
        }

        $id = sha1($defn->getDefnId(), true);

        if (isset($this->nodes[$id])) {
            return $this->nodes[$id];
        }

        return $this->nodes[$id] = $defn;
    }

    public function dump()
    {
        $dump = array();

        if (0 < count($this->attrs)) {
            $dump['attr'] = $this->attrs;
        }

        foreach ($this->nodes as $node) {
            $dump[$node->getDefnId()] = $node->dump();
        }

        return $dump;
    }
}
