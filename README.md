# NAME

Dist::Zilla::Plugin::Test::EOF - Check that all files in the projects end correctly

# SYNOPSIS

    [Test::EOF]
    strict = 1

# DESCRIPTION

Generates author tests using [Test::EOF](https://metacpan.org/pod/Test::EOF). It checks that all Perl files end with the requested amount of new lines. It assumes that all linebreaks only consist of `\n`. It does not check
for any other line break character - use [Dist::Zilla::Plugin::Test::EOL](https://metacpan.org/pod/Dist::Zilla::Plugin::Test::EOL) for that.

## ATTRIBUTES

The following attributes are accepted:

**`minimum_newlines`**

Default: `1`

The lowest amount of newlines acceptable at end-of-file.

**`maximum_newlines`**

Default: `minimum_newlines + 3`

The highest amount of newlines acceptable at end-of-file.

**`strict`**

Default: `0`

If true, sets both `minimum_newlines` and `maximum_newlines` to `1`. This option has precedence.

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT

Copyright 2014- Erik Carlsson

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
