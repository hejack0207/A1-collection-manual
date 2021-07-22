# shells(5) - pathnames of valid login shells

"", 2017-11-26


<a name="description"></a>

# Description

_/etc/shells_
is a text file which contains the full pathnames of valid login shells.
This file is consulted by
**chsh**(1)
and available to be queried by other programs.

Be aware that there are programs which consult this file to
find out if a user is a normal user;
for example,
FTP daemons traditionally
disallow access to users with shells not included in this file.

<a name="files"></a>

# Files

_/etc/shells_

<a name="example"></a>

# Example

_/etc/shells_
may contain the following paths:

.in +4n
.EX
_/bin/sh_
_/bin/bash_
_/bin/csh_
.EE
.in

<a name="see-also"></a>

# See Also

**chsh**(1),
**getusershell**(3),
**pam_shells**(8)

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
