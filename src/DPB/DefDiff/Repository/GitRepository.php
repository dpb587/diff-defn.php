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

    public function resolveCommit($repository, $commit)
    {
        if ('file://' == substr($repository, 0, 7)) {
            $p = new Process(
                'git rev-parse ' . escapeshellarg($commit) . '^0',
                substr($repository, 7)
            );
            $p->run();

            return trim($p->getOutput());
        }

        throw new \RuntimeException(sprintf('Unable to resolve commit for "%s".', $repository));
    }

    public function getFileLink($repository)
    {
        if ('file://' == substr($repository, 0, 7)) {
            $p = new Process(
                'git remote -v',
                substr($repository, 7)
            );
            $p->run();

            preg_match('#^origin\s+(.*)\s+\(fetch\)#', $p->getOutput(), $match);

            if ($match) {
                if (preg_match('#(git|ssh)://github.com/([^/]+/[^/]+)#', $match[1], $match)) {
                    return 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/blob/%commit%/%file%#L%line%';
                }
            }
        }

        throw new \RuntimeException(sprintf('Unable to get code link for "%s".', $repository));
    }

    public function getCommitLink($repository)
    {
        if ('file://' == substr($repository, 0, 7)) {
            $p = new Process(
                'git remote -v',
                substr($repository, 7)
            );
            $p->run();

            preg_match('#^origin\s+(.*)\s+\(fetch\)#', $p->getOutput(), $match);

            if ($match) {
                if (preg_match('#(git|ssh)://github.com/([^/]+/[^/]+)#', $match[1], $match)) {
                    return 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/tree/%commit%';
                }
            }
        }

        throw new \RuntimeException(sprintf('Unable to get code link for "%s".', $repository));
    }

    public function getLink($repository)
    {
        if ('file://' == substr($repository, 0, 7)) {
            $p = new Process(
                'git remote -v',
                substr($repository, 7)
            );
            $p->run();

            preg_match('#^origin\s+(.*)\s+\(fetch\)#', $p->getOutput(), $match);

            if ($match) {
                if (preg_match('#(git|ssh)://github.com/([^/]+/[^/]+)#', $match[1], $match)) {
                    return 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/';
                }
            }
        }

        throw new \RuntimeException(sprintf('Unable to get code link for "%s".', $repository));
    }
}
