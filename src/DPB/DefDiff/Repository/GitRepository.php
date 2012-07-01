<?php

namespace DPB\DefDiff\Repository;

use Symfony\Component\Process\Process;

class GitRepository
{
    public function getChangedFiles($repository, $start, $end)
    {
        if ('file://' == substr($repository, 0, 7)) {
            $p = new Process(
                'git diff --name-only ' . escapeshellarg($start) . ' ' . escapeshellarg($end),
                substr($repository, 7)
            );
            $p->run();

            return explode("\n", trim($p->getOutput()));
        }

        throw new \RuntimeException(sprintf('Unable to get changed files for "%s".', $repository));
    }

    public function getFileContent($repository, $commit, $path)
    {
        if ('file://' == substr($repository, 0, 7)) {
            $p = new Process(
                'git show ' . escapeshellarg($commit) . ':' . escapeshellarg($path),
                substr($repository, 7)
            );
            $p->run();

            return $p->getOutput();
        }

        throw new \RuntimeException(sprintf('Unable to get file contents for "%s".', $repository));
    }
}
