# nologin(5) - prevent unprivileged users from logging into the system

Linux, 2017-09-15


<a name="description"></a>

# Description

If the file _/etc/nologin_ exists and is readable,
**login**(1)
will allow access only to root.
Other users will
be shown the contents of this file and their logins will be refused.
This provides a simple way of temporarily disabling all unprivileged logins.

<a name="files"></a>

# Files

_/etc/nologin_

<a name="see-also"></a>

# See Also

**login**(1),
**shutdown**(8)

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
