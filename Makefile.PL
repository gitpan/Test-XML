# @(#) $Id: Makefile.PL,v 1.1.1.1 2003/03/14 15:01:51 dom Exp $

use strict;

use ExtUtils::MakeMaker;

my $main_module = 'lib/Test/XML.pm';
WriteMakefile(
    NAME         => 'Test::XML',
    VERSION_FROM => $main_module,
    PREREQ_PM    => {
        'Test::More'        => 0,
        'XML::SemanticDiff' => 0.95,
    },
    AUTHOR        => 'Dominic Mitchell <cpan@semantico.com>'
);

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 :
