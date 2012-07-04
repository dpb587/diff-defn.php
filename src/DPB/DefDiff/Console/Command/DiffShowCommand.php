<?php

namespace DPB\DefDiff\Console\Command;

use DPB\DefDiff\Definition\DefnDefinition;
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
            ->addArgument('commit-final', InputArgument::REQUIRED, 'Commit (final)')
            ->addArgument('commit-begin', InputArgument::REQUIRED, 'Commit (begin)')
            ->addOption('stylesheet', null, InputOption::VALUE_REQUIRED, 'Stylesheet for output', null)
            ->addOption('output', null, InputOption::VALUE_REQUIRED, 'Output transformed file', '-')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $mt = microtime(true);

        $inputRepository = $input->getArgument('repository');
        $inputCommitStart = $input->getArgument('commit-final');
        $inputCommitEnd = $input->getArgument('commit-begin');

        $repoFactory = new \DPB\DefDiff\Repository\Factory();

        $repo = $repoFactory->create($inputRepository);

        $inputCommitStart = $repo->resolveCommit($inputCommitStart);
        $inputCommitEnd = $repo->resolveCommit($inputCommitEnd);

        $output->writeln(sprintf('Comparing <info>%s</info> to <info>%s</info>', $inputCommitStart, $inputCommitEnd));

        $diffs = $repo->getChangedFiles($inputCommitStart, $inputCommitEnd);

        $output->writeln('Found ' . count($diffs) . ' changed file' . (1 != count($diffs) ? 's' : ''));

        $defnRepository = new DefnDefinition(
            'source',
            array(
                'repository' => $inputRepository,
                'repository-link' => $repo->getLink($inputRepository),
                'file-link' => $repo->getFileLink($inputRepository),
                'commit-link' => $repo->getCommitLink($inputRepository)
            )
        );

        $finalScope = new RootDefinition('root');
        $finalScope->assert($defnRepository)->assert(new DefnDefinition('commit'))->setAttribute('value', $inputCommitStart);
        
        $beginScope = new RootDefinition('root');
        $beginScope->assert($defnRepository)->assert(new DefnDefinition('commit'))->setAttribute('value', $inputCommitEnd);

        foreach ($diffs as $file) {
            $finalScope->setAttribute('file', $file);
            $beginScope->setAttribute('file', $file);

            $output->write($file . '...');

            if ('php' != pathinfo($file, PATHINFO_EXTENSION)) {
                $output->writeln('skipped');

                continue;
            }

            try {

                Processor::process(
                    $finalScope,
                    $repo->getFileContent(
                        $input->getArgument('commit-final'),
                        $file
                    )
                );
    
                $output->write('...');
    
                Processor::process(
                    $beginScope,
                    $repo->getFileContent(
                        $input->getArgument('commit-begin'),
                        $file
                    )
                );
    
                $output->writeln('done');
            } catch (\PHPParser_Error $e) {
                $output->writeln('<error>error</error>');
                $output->writeln('  ' . $e->getMessage());
            }
        }

        $finalScope->unsetAttribute('file');
        $beginScope->unsetAttribute('file');

        $dumper = new XmlDumper();
        $comparator = new \DPB\DefDiff\Comparator\DefinitionComparator();

        file_put_contents('/tmp/defdiff-final.xml', $dumper->dump($finalScope));
        file_put_contents('/tmp/defdiff-begin.xml', $dumper->dump($beginScope));

        $diff = $dumper->dump($comparator->compare($finalScope, $beginScope));

        file_put_contents('/tmp/defdiff-diff.xml', $diff);

        $xsl = new \DOMDocument();
        $xsl->load($input->getOption('stylesheet') ?: (__DIR__ . '/../../Resources/xsl/default.xsl'));

        $xslt = new \XSLTProcessor();
        $xslt->registerPHPFunctions('str_replace');
        $xslt->importStylesheet($xsl);

        $xml = new \DOMDocument();
        $xml->loadXML($diff);

        $result = $xslt->transformToXML($xml);

        $output->writeln(sprintf('Finished in <info>%01.2f</info> seconds, <info>%01.1f</info> MB.', microtime(true) - $mt, (memory_get_usage(true) / (1024 * 1024))));

        if ('-' == $input->getOption('output')) {
            $output->write($result);
        } elseif ($input->getOption('output')) {
            file_put_contents($input->getOption('output'), $result);
        }
    }
}
