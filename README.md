dpb587/diff-defn.php
====================

Version control systems provide great insight into files and lines that change over time. Oftentimes, the more important
piece is how application definitions change (e.g. classes, interfaces, and functions) - especially when libraries are
used as third-party dependencies.

I wrote a post describing a bit of how it works at [dpb587.me](http://dpb587.me/blog/2013/03/07/comparing-php-application-definitions.html).


Setup
-----

    $ git clone git://github.com/dpb587/opengrok-cli.git opengrok-cli && cd !$
    $ composer.phar install


Usage
-----

    ./bin/diff-defn.php diff:show --exclude='/Tests/' git://github.com/symfony/Console.git v2.0.22 v2.2.0


License
-------

[MIT License](./LICENSE)
