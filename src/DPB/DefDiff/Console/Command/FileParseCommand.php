<?php

namespace DPB\DefDiff\Console\Command;

use DPB\DefDiff\Definition\Definition;
use DPB\DefDiff\Util\Processor;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Yaml\Yaml;

class FileParseCommand extends Command
{
    protected function configure()
    {
        $this
            ->setName('file:parse')
            ->setDescription('Parse a given file and display definitions.')
            ->addArgument('path', InputArgument::REQUIRED | InputArgument::IS_ARRAY, 'File path')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $scope = new Definition('.');

        foreach ($input->getArgument('path') as $path) {
            if (is_dir($path)) {
                $iterable = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($path), \RecursiveIteratorIterator::LEAVES_ONLY);
            } else {
                $iterable = array($path);
            }

            foreach ($iterable as $path) {
                if ('php' != pathinfo($path, PATHINFO_EXTENSION)) {
                    continue;
                }

                try {
                    Processor::process($scope, file_get_contents($path));
                } catch (\PHPParser_Error $e) {
                    throw new \RuntimeException(sprintf('Failed to parse file "%s".', $path), null, $e);
                }
            }
        }
    
        $output->write(Yaml::dump($scope->dump(), 8));
    }
}
