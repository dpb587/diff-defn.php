<?php

namespace DPB\DiffDefn\Console\Command;

use DPB\DiffDefn\Cache\FileCache;
use DPB\DiffDefn\Definition\DefnDefinition;
use DPB\DiffDefn\Definition\RootDefinition;
use DPB\DiffDefn\Dumper\XmlDumper;
use DPB\DiffDefn\Util\Processor;
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
            ->addArgument('commit-begin', InputArgument::REQUIRED, 'Commit (begin)')
            ->addArgument('commit-final', InputArgument::REQUIRED, 'Commit (final)')
            ->addOption('exclude', null, InputOption::VALUE_REQUIRED | InputOption::VALUE_IS_ARRAY, 'Exclude pattern', null)
            ->addOption('stylesheet', null, InputOption::VALUE_REQUIRED, 'Stylesheet for output', null)
            ->addOption('output', null, InputOption::VALUE_REQUIRED, 'Output transformed file', '-')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $mt = microtime(true);

        $inputRepository = $input->getArgument('repository');
        $inputCommitBegin = $input->getArgument('commit-begin');
        $inputCommitFinal = $input->getArgument('commit-final');
        $inputExclude = $input->getOption('exclude');

        $outputVerbose = OutputInterface::VERBOSITY_VERBOSE === $output->getVerbosity();

        $repoFactory = new \DPB\DiffDefn\Repository\Factory();

        $repo = $repoFactory->create($inputRepository);

        $inputCommitBegin = $repo->resolveCommit($inputCommitBegin);
        $inputCommitFinal = $repo->resolveCommit($inputCommitFinal);

        if ($outputVerbose) {
            $output->writeln(sprintf('Comparing <info>%s</info> to <info>%s</info>', $inputCommitBegin[0], $inputCommitFinal[0]));
        }

        $diffs = $repo->getChangedFiles($inputCommitBegin[0], $inputCommitFinal[0]);

        if ($outputVerbose) {
            $output->writeln('Found ' . count($diffs) . ' changed file' . (1 != count($diffs) ? 's' : ''));
        }

        $links = $repo->getLinks();
        $attrs = array(
            'repository' => $inputRepository,
        );

        if (isset($links['web'])) {
            $attrs['repository-link'] = $links['web'];
        }

        if (isset($links['file'])) {
            $attrs['file-link'] = $links['file'];
        }

        if (isset($links['commit'])) {
            $attrs['commit-link'] = $links['commit'];
        }

        $defnRepository = new DefnDefinition('source', $attrs);

        $cache = new FileCache(__DIR__ . '/../../../../../tmp');
        $cacheKey = md5(serialize(array($input->getArguments(), $input->getOptions())));

        if (null === $diff = $cache->retrieve($cacheKey)) {
            $beginScope = new RootDefinition('root');
            $beginScope->assert($defnRepository)->assert(
                new DefnDefinition(
                    'commit',
                    array(
                        'value' => $inputCommitBegin[0],
                        'friendly' => $inputCommitBegin[1],
                    )
                )
            );
    
            $finalScope = new RootDefinition('root');
            $finalScope->assert($defnRepository)->assert(
                new DefnDefinition(
                    'commit',
                    array(
                        'value' => $inputCommitFinal[0],
                        'friendly' => $inputCommitFinal[1],
                    )
                )
            );
    
            foreach ($diffs as $file) {
                $finalScope->setAttribute('file', $file);
                $beginScope->setAttribute('file', $file);
    
                if ($outputVerbose) {
                    $output->write($file . '...');
                }
    
                if ('php' != pathinfo($file, PATHINFO_EXTENSION)) {
                    if ($outputVerbose) {
                        $output->writeln('skipped');
                    }
    
                    continue;
                }
    
                foreach ($inputExclude as $exclude) {
                    if (preg_match('!' . $exclude . '!', '/' . $file)) {
                        if ($outputVerbose) {
                            $output->writeln('skipped');
                        }
    
                        continue 2;
                    }
                }
    
                try {
                    Processor::process(
                        $finalScope,
                        $repo->getFileContent(
                            $input->getArgument('commit-final'),
                            $file
                        )
                    );
    
                    if ($outputVerbose) {
                        $output->write('...');
                    }
    
                    Processor::process(
                        $beginScope,
                        $repo->getFileContent(
                            $input->getArgument('commit-begin'),
                            $file
                        )
                    );
    
                    if ($outputVerbose) {
                        $output->writeln('done');
                    }
                } catch (\PHPParser_Error $e) {
                    if ($outputVerbose) {
                        $output->writeln('<error>error</error>');
                        $output->writeln('  ' . $e->getMessage());
                    }
                }
            }
    
            $finalScope->unsetAttribute('file');
            $beginScope->unsetAttribute('file');
    
            $dumper = new XmlDumper();
            $comparator = new \DPB\DiffDefn\Comparator\DefinitionComparator();
    
            file_put_contents('/tmp/defdiff-final.xml', $dumper->dump($finalScope));
            file_put_contents('/tmp/defdiff-begin.xml', $dumper->dump($beginScope));
    
            $diff = $dumper->dump($comparator->compare($finalScope, $beginScope));
    
            $cache->store($cacheKey, $diff);
        }

        $xsl = new \DOMDocument();
        $xsl->load($input->getOption('stylesheet') ?: (__DIR__ . '/../../Resources/stylesheets/default.html.xslt'));

        $xslt = new \XSLTProcessor();
        $xslt->registerPHPFunctions('str_replace');
        $xslt->importStylesheet($xsl);

        $xml = new \DOMDocument();
        $xml->loadXML($diff);

        $result = $xslt->transformToXML($xml);

        if ($outputVerbose) {
            $output->writeln(
                sprintf(
                    'Finished in <info>%01.2f</info> seconds, <info>%01.1f</info> MB.',
                    microtime(true) - $mt,
                    (memory_get_usage(true) / (1024 * 1024))
                )
            );
        }

        if ('-' == $input->getOption('output')) {
            if ($outputVerbose) {
                $output->write($result);
            }
        } elseif ($input->getOption('output')) {
            file_put_contents($input->getOption('output'), $result);
        }
    }
}
