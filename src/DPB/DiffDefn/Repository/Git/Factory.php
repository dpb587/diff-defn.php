<?php

namespace DPB\DiffDefn\Repository\Git;

class Factory
{
    public function create($url)
    {
        if ('file://' == substr($url, 0, 7)) {
            $url = substr($url, 7);

            if (is_dir($url . '/.git')) {
                return new LocalRepository($url);
            }
        } elseif ('git://' == substr($url, 0, 6)) {
            return new RemoteRepository($url);
        }

        throw new \InvalidArgumentException(sprintf('No git repository support for "%s".', $url));
    }
}
