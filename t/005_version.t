
use strict;
use warnings;

use Test::More;

use lib qw( t/lib );
use My::Redis;

use_ok( "Redis::Fast::DistLock" );


# version not recent enough
ok( ! eval {
    Redis::Fast::DistLock->new(
        servers => [ bless( { version => "1.2.3" }, "My::Redis" ) ]
    );
}, "version check fail" );

ok( eval {
    Redis::Fast::DistLock->new(
        servers => [ bless( { version => "1.2.3" }, "My::Redis" ) ],
        version_check => 0,
    );
}, "do no version check" );


# exact version match
ok( Redis::Fast::DistLock->new(
        servers => [ bless( { version => "2.6.12" }, "My::Redis" ) ],
), "version match" );

ok( Redis::Fast::DistLock->new(
        servers => [ bless( { version => "2.6.12" }, "My::Redis" ) ],
        version_check => 0,
), "version match without check" );


# higher version
ok( Redis::Fast::DistLock->new(
        servers => [ bless( { version => "12.34.56" }, "My::Redis" ) ],
), "version way " );

ok( Redis::Fast::DistLock->new(
        servers => [ bless( { version => "12.34.56" }, "My::Redis" ) ],
        version_check => 0,
), "version match without check" );


done_testing();

# vim: ts=4 sw=4 et:
