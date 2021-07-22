# issue(5) - prelogin message and identification file

Linux, 1993-07-24


<a name="description"></a>

# Description

_/etc/issue_
is a text file which contains a message or
system identification to be printed before the login prompt.
It may contain various **@**_char_ and **\e**_char_
sequences, if supported by the
**getty**-type
program employed on the system.

<a name="files"></a>

# Files

_/etc/issue_

<a name="see-also"></a>

# See Also

**motd**(5),
**agetty**(8),
**mingetty**(8)

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
