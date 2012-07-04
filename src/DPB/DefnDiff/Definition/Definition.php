<?php

namespace DPB\DefnDiff\Definition;

class Definition implements \IteratorAggregate
{
    private $defnId;
    private $defnParent;

    protected $nodes = array();
    protected $attrs;

    public function __construct($defnId, array $attrs = array())
    {
        $this->defnId = $defnId;

        $this->attrs = $attrs;
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

    public function unsetAttribute($name)
    {
        unset($this->attrs[$name]);
    }

    public function hasAttribute($name)
    {
        return isset($this->attrs[$name]);
    }

    public function getAttributes()
    {
        return $this->attrs;
    }

    public function assert($defn)
    {
        if (is_string($defn)) {
            $defn = new Definition($defn);
        } elseif (!$defn instanceof Definition) {
            throw new \InvalidArgumentException('Argument 1 of assert must be a string or Definition.');
        }

        $id = (string) $defn;

        if (!isset($this->nodes[$id])) {
            $this->nodes[$id] = clone $defn;
        }

        return $this->nodes[$id];
    }

    public function has(Definition $defn)
    {
        return isset($this->nodes[(string) $defn]);
    }

    public function get(Definition $defn)
    {
        if (!isset($this->nodes[(string) $defn])) {
            throw new \InvalidArgumentException(sprintf('Node "%s" does not exist.', (string) $defn));
        }

        return $this->nodes[(string) $defn];
    }

    public function all()
    {
        return $this->nodes;
    }

    public function getIterator()
    {
        return new \ArrayIterator($this->nodes);
    }

    public function __toString()
    {
        return get_class($this) . ':' . $this->defnId;
    }

    public function isComparable()
    {
        return true;
    }
}
