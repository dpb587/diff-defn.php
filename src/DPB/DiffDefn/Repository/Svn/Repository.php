<?php

namespace DPB\DiffDefn\Repository\Svn;

use Symfony\Component\Process\Process;

class Repository
{
    protected $url;

    public function __construct($url)
    {
        $this->url = $url;
    }

    public function getChangedFiles($start, $end)
    {
        $p = new Process('svn diff -r ' . escapeshellarg($start) . ':' . escapeshellarg($end) . ' --summarize ' . escapeshellarg($this->url));
        $p->run();

        return explode("\n", preg_replace('@(.*)(' . preg_quote($this->url) . '/?)@', '', trim($p->getOutput())));
    }

    public function getFileContent($commit, $path)
    {
        $p = new Process('svn cat -r ' . escapeshellarg($commit) . ' ' . escapeshellarg($this->url . '/' . $path));
        $p->run();

        return $p->getOutput();
    }

    public function resolveCommit($commit)
    {
        return $commit;
    }

    public function getFileLink()
    {
        $p = new Process(
            'git remote -v',
            $this->url
        );
        $p->run();

        preg_match('#^origin\s+(.*)\s+\(fetch\)#', $p->getOutput(), $match);

        if ($match) {
            if (preg_match('#(git|ssh)://github.com/([^/]+/[^/]+)#', $match[1], $match)) {
                return 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/blob/%commit%/%file%#L%line%';
            }
        }
    }

    public function getCommitLink($repository)
    {
        $p = new Process(
            'git remote -v',
            $this->url
        );
        $p->run();

        preg_match('#^origin\s+(.*)\s+\(fetch\)#', $p->getOutput(), $match);

        if ($match) {
            if (preg_match('#(git|ssh)://github.com/([^/]+/[^/]+)#', $match[1], $match)) {
                return 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/tree/%commit%';
            }
        }
    }

    public function getLink($repository)
    {
        $p = new Process(
            'git remote -v',
            $this->url
        );
        $p->run();

        preg_match('#^origin\s+(.*)\s+\(fetch\)#', $p->getOutput(), $match);

        if ($match) {
            if (preg_match('#(git|ssh)://github.com/([^/]+/[^/]+)#', $match[1], $match)) {
                return 'https://github.com/' . preg_replace('#\.git$#', '', $match[2]) . '/';
            }
        }
    }
}
