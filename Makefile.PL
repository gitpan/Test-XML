# @(#) $Id: Makefile.PL,v 1.4 2005/07/21 20:10:07 dom Exp $

use strict;
require 5.006;

use ExtUtils::MakeMaker;

my $main_module = 'lib/Test/XML.pm';
WriteMakefile(
    NAME         => 'Test::XML',
    VERSION_FROM => $main_module,
    PREREQ_PM    => {
        'Test::More'        => 0,
        'XML::SemanticDiff' => 0.95,
        'XML::Parser'       => 2.34,
    },
    AUTHOR => 'Dominic Mitchell <cpan2 (at) semantico.com>',
    PL_FILES => {},    # To ignore Build.PL.
);

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 :
