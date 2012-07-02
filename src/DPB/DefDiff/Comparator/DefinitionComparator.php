<?php

namespace DPB\DefDiff\Comparator;

use DPB\DefDiff\Definition\Definition;
use DPB\DefDiff\Definition\DiffDefinition;
use DPB\DefDiff\Definition\DiffNewDefinition;
use DPB\DefDiff\Definition\DiffOldDefinition;

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

        $c = new $baseclass($a->getDefnId());

        foreach ($a->getAttributes() as $name => $value) {
            if ($a->getAttribute($name) != $b->getAttribute($name)) {
                $c->setAttribute('diff', 'changed');
            }

            $c->setAttribute($name, $value);
        }

        foreach ($a as $sub) {
            if ($b->has($sub)) {
                $sub = $this->compare($sub, $b->get($sub), $depth + 1);

                if ($sub) {
                    if ($sub->getAttribute('diff') != 'touched') {
                        $bc = clone $b->get($sub);
                        $sub->assert(new DiffOldDefinition('old'))->assert($bc);
                    }

                    $c->assert($sub);
                    $c->setAttribute('diff', 'touched');
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
