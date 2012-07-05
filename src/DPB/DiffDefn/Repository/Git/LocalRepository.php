<?php

namespace DPB\DiffDefn\Repository\Git;

use Symfony\Component\Process\Process;

class LocalRepository
{
    protected $url;

    public function __construct($url)
    {
        $this->url = $url;
    }

    public function getChangedFiles($start, $end)
    {
        $p = new Process(
            'git diff --name-only ' . escapeshellarg($start) . ' ' . escapeshellarg($end),
            $this->url
        );
        $p->run();

        return explode("\n", trim($p->getOutput()));
    }

    public function getFileContent($commit, $path)
    {
        $p = new Process(
            'git show ' . escapeshellarg($commit) . ':' . escapeshellarg($path),
            $this->url
        );
        $p->run();

        return $p->getOutput();
    }

    public function resolveCommit($commit)
    {
        $p = new Process(
            'git rev-parse ' . escapeshellarg($commit) . '^0',
            $this->url
        );
        $p->run();

        if ($p->getExitCode()) {
            throw new \InvalidArgumentException(sprintf('Unable to resolve commit "%s".', $commit));
        }

        $absolute = trim($p->getOutput());

        $p = new Process(
            'git describe --tags ' . escapeshellarg($absolute),
            $this->url
        );
        $p->run();

        if ($p->getOutput()) {
            return array($absolute, trim($p->getOutput()));
        }

        return array($absolute, substr($absolute, 0, 10));
    }

    public function getLinks()
    {
        $p = new Process(
            'git remote -v',
            $this->url
        );
        $p->run();

        preg_match('#^origin\s+(.*)\s+\(fetch\)#', $p->getOutput(), $match);

        if ($match) {
            if (preg_match('#(git|ssh)://github.com/([^/]+/[^/]+)#', $match[1], $match)) {
                return array(
                    'web' => 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/',
                    'file' => 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/blob/%commit%/%file%#L%line%',
                    'commit' => 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/tree/%commit%',
                );
            }
        }

        return array();
    }
}
