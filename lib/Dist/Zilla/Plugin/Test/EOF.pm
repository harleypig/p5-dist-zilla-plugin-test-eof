package Dist::Zilla::Plugin::Test::EOF;

use strict;
use Moose;
use 5.010;
use namespace::autoclean;

our $VERSION = '0.03';

extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::TextTemplate';

has minimum_newlines => (
    is => 'ro',
    isa => 'Int',
    default => 1,
);
has maximum_newlines => (
    is => 'ro',
    isa => 'Int',
    lazy => 1,
    default => sub { shift->minimum_newlines + 3 },
);
has strict => (
    is => 'ro',
    isa => 'Bool',
    default => 0,
);

around add_file => sub {
    my ($orig, $self, $file) = @_;

    return $self->$orig(
        Dist::Zilla::File::InMemory->new({
            name    => $file->name,
            content => $self->fill_in_string(
                $file->content, {
                    name    => __PACKAGE__,
                    version => __PACKAGE__->VERSION || 'unknown version',
                    minimum_newlines => ($self->strict ? \1 : \$self->minimum_newlines),
                    maximum_newlines => ($self->strict ? \1 : \$self->maximum_newlines),
                },
            ),
        }),
    );
};

__PACKAGE__->meta->make_immutable;

1;

=encoding utf-8

=head1 NAME

Dist::Zilla::Plugin::Test::EOF - Check that all files in the projects end correctly

=head1 SYNOPSIS

  [Test::EOF]
  strict = 1

=head1 DESCRIPTION

Generates author tests using L<Test::EOF>. It checks that all Perl files end with the requested amount of new lines. It assumes that all linebreaks only consist of C<\n>. It does not check
for any other line break character - use L<Dist::Zilla::Plugin::Test::EOL> for that.

=head2 ATTRIBUTES

The following attributes are accepted:

B<C<minimum_newlines>>

Default: C<1>

The lowest amount of newlines acceptable at end-of-file.

B<C<maximum_newlines>>

Default: C<minimum_newlines + 3>

The highest amount of newlines acceptable at end-of-file.

B<C<strict>>

Default: C<0>

If true, sets both C<minimum_newlines> and C<maximum_newlines> to C<1>. This option has precedence.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014- Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut


__DATA__
___[ xt/author/test-eof.t ]___
use strict;
use warnings;
use Test::More;

# Generated by {{ $name }} {{ $version }}
eval "use Test::EOF";
plan skip_all => 'Test::EOF required to test for correct end of file flag' if $@;

all_perl_files_ok({ minimum_newlines => {{ $minimum_newlines }}, maximum_newlines => {{ $maximum_newlines }} });

done_testing();

