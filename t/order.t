# @(#) $Id: order.t,v 1.3 2005/07/21 20:10:16 dom Exp $
use strict;
use warnings;

use Test::More tests => 3;
use Test::XML;

{
    local $TODO = 'make order significant';

    isnt_xml(
        '<p>a<b/>c<d/>e</p>',
        '<p>ace<b/><d/></p>',
        'characters are not clustered',
    );

    isnt_xml(
        '<p>a<b/>c<d/>e</p>',
        '<p>a<d/>c<b/>e</p>',
        'order is significant',
    );

    isnt_xml(
        '<p><a/><b/></p>',
        '<p><b/><a/></p>',
        'order is significant when not mixed content',
    );

}

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 syntax=perl :
