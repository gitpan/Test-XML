# @(#) $Id: xpath.t,v 1.1 2003/05/11 19:06:53 dom Exp $

use strict;
use warnings;

use Test::More;

BEGIN {
    foreach ( qw( XML::XPath ) ) {
        eval "use $_";
        plan skip_all => "$_ not present" if $@;
    }
}

plan tests => 19;

BEGIN {
    use_ok( 'Test::XML::XPath' );
}

eval { like_xpath() };
like( $@, qr/^usage: /, 'like_xpath() no args failure' );
eval { like_xpath( '<foo />' ) };
like( $@, qr/^usage: /, 'like_xpath() 1 args failure' );
eval { like_xpath( undef, '/foo' ) };
like( $@, qr/^usage: /, 'like_xpath() undef first arg failure' );

# Test everything mentioned in the docs...
my $silly_xml = '<foo attrib="1"><bish><bosh args="42">pub</bosh></bish></foo>';
my @tests = (
    [ '<foo/>', '/foo', 1 ],
    [ '<foo/>', '/bar', 0 ],
    [ '<foo/>', '/bar', 0 ],
    [ $silly_xml, '/foo[@attrib="1"]', 1 ],
    [ $silly_xml, '//bosh', 1 ],
    [ $silly_xml, '//bosh[@args="42"]', 1 ],
    [ '<foo/>', '/foo', 1 ],
    [ '<foo/>', 'foo', 1 ],
);

foreach my $t ( @tests ) {
    my $func = $t->[2] ? 'like_xpath' : 'unlike_xpath';
    my $name = "$func( $t->[0] => $t->[1] )";
    if ($t->[2]) {
        eval { like_xpath( $t->[0], $t->[1], $name ) };
    } else {
        eval { unlike_xpath( $t->[0], $t->[1], $name ) };
    }
    is( $@, '', "$name did not blow up" );
}

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 syntax=perl :
