<?php

namespace DPB\DefDiff\Console\Command;

use DPB\DefDiff\Definition\RootDefinition;
use DPB\DefDiff\Dumper\XmlDumper;
use DPB\DefDiff\Util\Processor;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

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
            ->addOption('stylesheet', null, InputOption::VALUE_REQUIRED, 'Stylesheet for output', null)
            ->addOption('output', null, InputOption::VALUE_REQUIRED, 'Output transformed file', '-')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {/*
        $repo = new \DPB\DefDiff\Repository\GitRepository();
        $diffs = $repo->getChangedFiles(
            $input->getArgument('repository'),
            $input->getArgument('commit-start'),
            $input->getArgument('commit-end')
        );

        $output->writeln('Found ' . count($diffs) . ' changed file' . (1 != count($diffs) ? 's' : ''));

        $startScope = new RootDefinition('root');
        $endScope = new RootDefinition('root');

        foreach ($diffs as $file) {
            $output->write($file . '...');

            if ('php' != pathinfo($file, PATHINFO_EXTENSION)) {
                $output->writeln('skipped');

                continue;
            }

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
                $endScope,
                $repo->getFileContent(
                    $input->getArgument('repository'),
                    $input->getArgument('commit-end'),
                    $file
                )
            );

            $output->writeln('done');
        }

        $dumper = new XmlDumper();
        $comparator = new \DPB\DefDiff\Comparator\DefinitionComparator();

        file_put_contents('/tmp/defdiff-start.xml', $dumper->dump($startScope));
        file_put_contents('/tmp/defdiff-end.xml', $dumper->dump($endScope));

        $diff = $dumper->dump($comparator->compare($startScope, $endScope));
*/
    $diff = file_get_contents('/tmp/defdiff-diff.xml');

        $xsl = new \DOMDocument();
        $xsl->load($input->getOption('stylesheet') ?: (__DIR__ . '/../../Resources/xsl/default.xsl'));

        $xslt = new \XSLTProcessor();
        $xslt->importStylesheet($xsl);

        $xml = new \DOMDocument();
        $xml->loadXML($diff);

        $result = $xslt->transformToXML($xml);

        file_put_contents('/tmp/defdiff-diff.xml', $diff);

        if ('-' == $input->getOption('output')) {
            $output->write($result);
        } elseif ($input->getOption('output')) {
            file_put_contents($input->getOption('output'), $result);
        }
    }
}
