<?php

namespace DPB\DiffDefn\Dumper;

use DPB\DiffDefn\Definition\Definition;

class XmlDumper
{
    public function dump(Definition $defn)
    {
        $document = new \DOMDocument('1.0');
        $document->appendChild($this->dumpDefinition($document, $defn));

        return $document->saveXML();
    }

    protected function dumpDefinition(\DOMDocument $document, Definition $defn)
    {
        $basename = strtolower(
            preg_replace(
                '/([a-z])([A-Z])/',
                '$1-$2',
                preg_replace('/Definition$/', '', basename(strtr(get_class($defn), '\\', '/')))
            )
        );

        $element = $document->createElement($basename);
        $element->setAttribute('id', $defn->getDefnId());

        foreach ($defn->getAttributes() as $name => $value) {
            if (is_bool($value)) {
                $value = $value ? 'true' : 'false';
            }

            $element->setAttribute($name, $value);
        }

        foreach ($defn as $subdefn) {
            $element->appendChild($this->dumpDefinition($document, $subdefn));
        }

        return $element;
    }
}
