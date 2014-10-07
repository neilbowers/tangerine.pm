package Tangerine::hook::testloading;
use strict;
use warnings;
use List::MoreUtils qw/any/;
use Tangerine::HookData;
use Tangerine::Occurence;
use Tangerine::Utils qw(stripquotelike);

sub run {
    my $s = shift;
    if (scalar(@$s) >= 2 && any { $s->[0] eq $_ } qw/require_ok use_ok/) {
        my @modules = stripquotelike((@$s)[1..$#$s]);
        return Tangerine::HookData->new(
            children => [ 
                    ($s->[0] eq 'require_ok' ?
                        ('require', $modules[0]) :
                        ('use', @modules)
                    )

                ],
            );
    }
    return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tangerine::hook::testloading - Process various test-suite module loading
statements.

=head1 DESCRIPTION

Detect <use_ok()> and <require_ok()> subroutine calls.  This is
C<require>-style dependency.

=head1 SEE ALSO

L<Tangerine>, L<Tangerine::hook::tests>

=head1 AUTHOR

Petr Šabata <contyk@redhat.com>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2014 Petr Šabata

See LICENSE for licensing details.

=cut
