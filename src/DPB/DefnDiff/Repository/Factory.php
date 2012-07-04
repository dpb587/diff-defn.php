<?php

namespace DPB\DefnDiff\Repository;

class Factory
{
    public function __construct()
    {
        $this->factories = array(
            new Git\Factory(),
            new Svn\Factory(),
        );
    }

    public function create($url)
    {
        foreach ($this->factories as $factory) {
            try {
                return $factory->create($url);
            } catch (\InvalidArgumentException $e) {
                continue;
            }
        }

        throw new \InvalidArgumentException(sprintf('No repository support for "%s".', $url));
    }
}
