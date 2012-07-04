<?php

namespace DPB\DefnDiff\Comparator;

use DPB\DefnDiff\Definition\Definition;
use DPB\DefnDiff\Definition\DiffDefinition;
use DPB\DefnDiff\Definition\DiffNewDefinition;
use DPB\DefnDiff\Definition\DiffOldDefinition;

class DefinitionComparator
{
    public function compare(Definition $a, Definition $b, $depth = 0)
    {
        $baseclass = get_class($a);

        if ($baseclass != get_class($b)) {
            throw new \LogicException(sprintf('Definitions are different (%s vs %s)', get_class($a), get_class($b)));
        } elseif ($a->getDefnId() != $b->getDefnId()) {
            throw new \LogicException(sprintf('Definitions have different IDs (%s vs %s)', $a->getDefnId(), $b->getDefnId()));
        }

        if (!$a->isComparable()) {
            return $a;
        }

        $c = new $baseclass($a->getDefnId(), $a->getAttributes());

        foreach ($a->getAttributes() as $name => $value) {
            if ((!$b->hasAttribute($name)) || ($value != $b->getAttribute($name))) {
                $c->setAttribute('diff', 'changed');
            }
        }

        foreach ($a as $sub) {
            if ($b->has($sub)) {
                $sub = $this->compare($sub, $b->get($sub), $depth + 1);

                if ($sub) {
                    if ($sub->hasAttribute('diff')) {
                        $bc = clone $b->get($sub);
                        $sub->assert(new DiffOldDefinition('old'))->assert($bc);

                        $c->setAttribute('diff', 'touched');
                    }

                    $c->assert($sub);
                }
            } else {
                $sub = $c->assert($sub);
                $sub->setAttribute('diff', 'added');
            }
        }

        foreach ($b as $sub) {
            if (!$a->has($sub)) {
                $sub = $c->assert($sub);
                $sub->setAttribute('diff', 'removed');
            }
        }

        if ($c->hasAttribute('diff')) {
            return $c;
        } else if (0 == $depth) {
            return $c;
        }

        return null;
    }
}
