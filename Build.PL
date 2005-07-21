# @(#) $Id: Build.PL,v 1.6 2005/07/21 20:10:06 dom Exp $
use strict;
use Module::Build;

Module::Build->new(
    module_name => 'Test::XML',
    license     => 'perl',
    requires    => {
        'perl'              => '5.6.0',
        'Test::More'        => 0,
        'XML::SemanticDiff' => 0.95,
        'XML::Parser'       => 2.34,
    },
    recommends => {
        'XML::SAX'         => 0,
        'XML::SAX::Writer' => 0,
        'XML::Twig'        => 0,
        'XML::XPath'       => 0,
    },
)->create_build_script;
