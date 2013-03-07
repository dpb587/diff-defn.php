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
        // nop
    }

    public function getCommitLink($repository)
    {
        // nop
    }

    public function getLink($repository)
    {
        // nop
    }
}
