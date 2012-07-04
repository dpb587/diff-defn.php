<?php

namespace DPB\DefnDiff\Console;

use DPB\DefnDiff\Manifest;
use Symfony\Component\Console\Application as BaseApplication;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class Application extends BaseApplication
{
    public function __construct()
    {
        parent::__construct(Manifest::NAME, Manifest::VERSION);
    }

    public function doRun(InputInterface $input, OutputInterface $output)
    {
        $this->add(new Command\DiffShowCommand());
        $this->add(new Command\FileParseCommand());

        return parent::doRun($input, $output);
    }
}
