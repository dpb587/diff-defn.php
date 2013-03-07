<?php

namespace DPB\DiffDefn\Cache;

class FileCache
{
    protected $path;

    public function __construct($path)
    {
        $this->path = $path;
    }

    public function retrieve($key)
    {
        $path = $this->path . '/' . $this->getUsableKey($key);

        if (file_exists($path)) {
            return unserialize(file_get_contents($path));
        }

        return null;
    }

    public function store($key, $data)
    {
        if (!is_dir($this->path)) {
            mkdir($this->path, 0777, true);
        }

        file_put_contents($this->path . '/' . $this->getUsableKey($key), serialize($data));
    }

    protected function getUsableKey($key)
    {
        return preg_replace('/[^a-z0-9]/', '', $key);
    }
}
