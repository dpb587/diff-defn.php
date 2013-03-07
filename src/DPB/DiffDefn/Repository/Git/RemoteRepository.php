<?php

namespace DPB\DiffDefn\Repository\Git;

use Symfony\Component\Process\Process;

class RemoteRepository extends LocalRepository
{
    protected $urlraw;

    public function __construct($url)
    {
        $this->urlraw = $url;

        parent::__construct($this->getTempPath($url));
    }

    protected function getTempPath($url)
    {
        return '/tmp/' . preg_replace('@(-+)@', '-', preg_replace('@([^a-z0-9\._])@i', '-', $this->urlraw));
    }

    protected function requireLocal()
    {
        if (!is_dir($this->url)) {
            $p = new Process('git clone -n ' . escapeshellarg($this->urlraw) . ' ' . $this->url, null, null, null, 600);
            $p->run();
        }
    }

    public function getChangedFiles($start, $end)
    {
        $this->requireLocal();

        return parent::getChangedFiles($start, $end);
    }

    public function getFileContent($commit, $path)
    {
        $this->requireLocal();

        return parent::getFileContent($commit, $path);
    }

    public function resolveCommit($commit)
    {
        $this->requireLocal();

        return parent::resolveCommit($commit);
    }

    public function getLinks()
    {
        $this->requireLocal();

        return parent::getLinks();
    }
}
