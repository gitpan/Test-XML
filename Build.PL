# @(#) $Id: Build.PL,v 1.2 2003/03/14 15:24:34 dom Exp $
use strict;
use Module::Build;

Module::Build->new(
    module_name => 'Test::XML',
    license     => 'perl',
    requires    => {
        'Test::More'        => 0,
        'XML::SemanticDiff' => 0.95,
    },
    recommends => {
	'XML::SAX'  => 0.11,
	'XML::Twig' => 3.09,
    },
)->create_build_script;
