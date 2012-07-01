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

        $str = str_repeat('  ', $depth) . '<defdiff:' . $basename . ' id="' . $defn->getDefnId() . '">' . "\n";

        foreach ($defn->getAttributes() as $key => $value) {
            $type = gettype($value);

            if (is_bool($value)) {
                $type = 'boolean';
                $value = $value ? 'true' : 'false';
            }

            $str .= str_repeat('  ', $depth + 1) . '<defdiff:attr name="' . $key . '" type="' . $type . '" value="' . $value . '" />' . "\n";
        }

        foreach ($defn as $subdefn) {
            $str .= $this->dumpDefinition($subdefn, $depth + 1);
        }

        $str .= str_repeat('  ', $depth) . '</defdiff:' . $basename . '>' . "\n";

        return $str;
    }
}
