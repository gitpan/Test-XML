# @(#) $Id: Makefile.PL,v 1.2 2003/03/14 16:01:01 dom Exp $

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
    AUTHOR   => 'Dominic Mitchell <cpan@semantico.com>',
    PL_FILES => {},                                        # To ignore Build.PL.
);

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 :
