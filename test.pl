use Devel::LexAlias qw(lexalias);

use Test::More tests => 6;

sub steal_my_x {
    my $foo = 1;
    lexalias(\&foo, '$x', \$foo);
    lexalias(\&foo, '@y', [qw( foo bar baz )]);

    eval { lexalias(\&foo, '$x', $foo) };
    ok( $@, "blew an error" );
    like( $@, qr/^ref is not a reference/, "useful error" );
}

sub foo {
    my $x = 22;
    my @y = qw( a b c );


    is( $x, 22, "x before" );
    is_deeply( \@y, [qw( a b c )], "y before" );

    steal_my_x;

    is( $x, 1, "x after" );
    is_deeply( \@y, [qw( foo bar baz )], "y after" );
}

foo;
