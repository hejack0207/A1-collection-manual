# securetty(5) - file which lists terminals from which root can log in

Linux, 2015-03-29


<a name="description"></a>

# Description

The file
_/etc/securetty_
contains the names of terminals
(one per line, without leading
_/dev/_)
which are considered secure for the transmission of certain authentication
tokens.

It is used by (some versions of)
**login**(1)
to restrict the terminals
on which root is allowed to login.
See
**login.defs**(5)
if you use the shadow suite.

On PAM enabled systems, it is used for the same purpose by
**pam_securetty**(8)
to restrict the terminals on which empty passwords are accepted.

<a name="files"></a>

# Files

_/etc/securetty_

<a name="see-also"></a>

# See Also

**login**(1),
**login.defs**(5),
**pam_securetty**(8)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
