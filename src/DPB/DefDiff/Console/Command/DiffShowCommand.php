<?php

namespace DPB\DefDiff\Console\Command;

use DPB\DefDiff\Definition\Definition;
use DPB\DefDiff\Util\Processor;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Yaml\Yaml;

class DiffShowCommand extends Command
{
    protected function configure()
    {
        $this
            ->setName('diff:show')
            ->setDescription('Parse files from a given commit.')
            ->addArgument('repository', InputArgument::REQUIRED, 'Repository')
            ->addArgument('commit-start', InputArgument::REQUIRED, 'Commit (start)')
            ->addArgument('commit-end', InputArgument::REQUIRED, 'Commit (end)')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $repo = new \DPB\DefDiff\Repository\GitRepository();
        $diffs = $repo->getChangedFiles(
            $input->getArgument('repository'),
            $input->getArgument('commit-start'),
            $input->getArgument('commit-end')
        );

        $startScope = new Definition('start');
        $endScope = new Definition('end');

        foreach ($diffs as $file) {
            $output->write($file . '...');

            Processor::process(
                $startScope,
                $repo->getFileContent(
                    $input->getArgument('repository'),
                    $input->getArgument('commit-start'),
                    $file
                )
            );

            $output->write('...');

            Processor::process(
                $startScope,
                $repo->getFileContent(
                    $input->getArgument('repository'),
                    $input->getArgument('commit-end'),
                    $file
                )
            );

            $output->writeln('done');
        }
    }
}
