<?php

namespace DPB\DefDiff\Repository\Svn;

use Symfony\Component\Process\Process;

class Factory
{
    public function create($url)
    {
        if ('file://' == substr($url, 0, 7)) {
            $url = substr($url, 7);

            if (is_dir($url . '/.svn')) {
                $p = new Process('svn info', $url);
                $p->run();

                preg_match('@URL: (.*)@', $p->getOutput(), $match);

                if ($match[1]) {
                    return new Repository($match[1]);
                }
            } else {
                return new Repository($url);
            }
        }

        throw new \InvalidArgumentException(sprintf('No git repository support for "%s".', $url));
    }
}
