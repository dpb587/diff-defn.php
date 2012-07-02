<?php

namespace DPB\DefDiff\Dumper;

use DPB\DefDiff\Definition\Definition;

class XmlDumper
{
    public function dump(Definition $defn)
    {
        return 
            '<?xml version="1.0" encoding="UTF-8" ?>' . "\n"
            . $this->dumpDefinition($defn)
        ;
    }

    protected function dumpDefinition(Definition $defn, $depth = 0)
    {
        $basename = strtolower(
            preg_replace(
                '/([a-z])([A-Z])/',
                '$1-$2',
                preg_replace('/Definition$/', '', basename(strtr(get_class($defn), '\\', '/')))
            )
        );

        $str = str_repeat('  ', $depth) . '<' . $basename . ' id="' . $defn->getDefnId() . '"';

        foreach ($defn->getAttributes() as $name => $value) {
            if (is_bool($value)) {
                $value = $value ? 'true' : 'false';
            }

            $str .= ' ' . $name . '="' . $value . '"';
        }

        $nodes = iterator_to_array($defn);

        if ($nodes) {
            $str .= '>' . "\n";
    
            foreach ($nodes as $subdefn) {
                $str .= $this->dumpDefinition($subdefn, $depth + 1);
            }

            $str .= str_repeat('  ', $depth) . '</' . $basename . '>' . "\n";
        } else {
            $str .= ' />' . "\n";
        }

        return $str;
    }
}
