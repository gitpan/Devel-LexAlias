package Devel::LexAlias;
require DynaLoader;

require 5.005003;

@ISA = qw(Exporter DynaLoader);
@EXPORT_OK = qw(lexalias);

$VERSION = '0.01';

bootstrap Devel::LexAlias $VERSION;

1;
__END__

=head1 NAME

Devel::LexAlias - alias lexical variables

=head1 SYNOPSIS

 use Devel::LexAlias qw(lexalias);

 sub steal_my_x {
     my $foo = 1;
     lexalias(\&foo, '$x', \$foo);
 }

 sub foo {
     my $x = 22;
     print $x; # prints 22

     steal_my_x;
     print $x; # prints 1
 }

=head1 DESCRIPTION

Devel::LexAlias provides the ability to alias a lexical variable in a
subroutines scope to one of your choosing.

If you don't know why you'd want to do this, I'd suggest that you skip
this module.  If you think you have a use for it, I'd insist on it.

Still here?

=over

=item lexalias( $coderef, $name, $variable )

C<$coderef> refers to the subroutine in which to alias the lexical

C<$name> is the name of the lexical within that subroutine

C<$variable> is a reference to the variable to install at that location

=back

=head1 BUGS

lexalias delves into the internals of the interpreter to perform it's
actions and is so very sensitive to bad data, which will likely result
in flaming death, or a core dump.  Consider this a warning.

There is no checking that you are attaching a suitable variable back
into the pad as implied by the name of the variable, so it is possible
to do the following:

 lexalias( $sub, '$foo', [qw(an array)] );

The behaviour of this is untested, I imagine badness is very close on
the horizon though.

=head1 SEE ALSO

peek_sub from L<PadWalker>, L<Devel::Peek>

=head1 AUTHOR

Richard Clamp E<lt>richardc@unixbeard.netE<gt> with close reference to
PadWalker by Robin Houston

=head1 COPYRIGHT

Copyright (c) 2002, Richard Clamp. All Rights Reserved.  This module
is free software. It may be used, redistributed and/or modified under
the same terms as Perl itself.

=cut
