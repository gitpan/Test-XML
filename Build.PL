# @(#) $Id: Build.PL,v 1.4 2003/05/11 19:06:52 dom Exp $
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
        'XML::SAX'         => 0,
        'XML::SAX::Writer' => 0,
        'XML::Twig'        => 0,
        'XML::XPath'       => 0,
    },
)->create_build_script;
