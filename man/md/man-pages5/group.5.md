# group(5) - user group file

Linux, 2018-04-30


<a name="description"></a>

# Description

The
_/etc/group_
file is a text file that defines the groups on the system.
There is one entry per line, with the following format:

.in +4n
.EX
group_name:password:GID:user_list
.EE
.in

The fields are as follows:

* _group_name_  
  the name of the group.
* _password_  
  the (encrypted) group password.
  If this field is empty, no password is needed.
* _GID_  
  the numeric group ID.
* _user_list_  
  a list of the usernames that are members of this group, separated by commas.

<a name="files"></a>

# Files

_/etc/group_

<a name="bugs"></a>

# Bugs

As the 4.2BSD
**initgroups**(3)
man page says: no one seems to keep
_/etc/group_
up-to-date.

<a name="see-also"></a>

# See Also

**chgrp**(1),
**gpasswd**(1),
**groups**(1),
**login**(1),
**newgrp**(1),
**sg**(1),
**getgrent**(3),
**getgrnam**(3),
**gshadow**(5),
**passwd**(5),
**vigr**(8)

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
