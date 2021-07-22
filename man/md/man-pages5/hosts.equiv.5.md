# hosts.equiv(5) - list of hosts and users that are granted "trusted"

Linux, 2015-07-23

**r**
command access to your system

<a name="description"></a>

# Description

The file
_/etc/hosts.equiv_
allows or denies hosts and users to use
the **r**-commands (e.g.,
**rlogin**,
**rsh**,
or
**rcp**)
without
supplying a password.

The file uses the following format:

* _+|[-]hostname|+@netgroup|-@netgroup_ _[+|[-]username|+@netgroup|-@netgroup]_  

The
_hostname_
is the name of a host which is logically equivalent
to the local host.
Users logged into that host are allowed to access
like-named user accounts on the local host without supplying a password.
The
_hostname_
may be (optionally) preceded by a plus (+) sign.
If the plus sign is used alone, it allows any host to access your system.
You can explicitly deny access to a host by preceding the
_hostname_
by a minus (-) sign.
Users from that host must always supply additional credentials,
including possibly a password. For security reasons you should always
use the FQDN of the hostname and not the short hostname.

The
_username_
entry grants a specific user access to all user
accounts (except root) without supplying a password.
That means the
user is NOT restricted to like-named accounts.
The
_username_
may
be (optionally) preceded by a plus (+) sign.
You can also explicitly
deny access to a specific user by preceding the
_username_
with
a minus (-) sign.
This says that the user is not trusted no matter
what other entries for that host exist.

Netgroups can be specified by preceding the netgroup by an @ sign.

Be extremely careful when using the plus (+) sign.
A simple typographical
error could result in a standalone plus sign.
A standalone plus sign is
a wildcard character that means "any host"!

<a name="files"></a>

# Files

_/etc/hosts.equiv_

<a name="notes"></a>

# Notes

Some systems will honor the contents of this file only when it has owner
root and no write permission for anybody else.
Some exceptionally
paranoid systems even require that there be no other hard links to the file.

Modern systems use the Pluggable Authentication Modules library (PAM).
With PAM a standalone plus sign is considered a wildcard
character which means "any host" only when the word
_promiscuous_
is added to the auth component line in your PAM file for
the particular service
(e.g., **rlogin**).

<a name="example"></a>

# Example

Below are some example
_/etc/host.equiv_
or
_~/.rhosts_
files.

Allow any user to log in from any host:

    +

Allow any user from
_host_
with a matching local account to log in:

    host

Note: the use of
_+host_
is never a valid syntax,
including attempting to specify that any user from the host is allowed.

Allow any user from
_host_
to log in:

    host +

Note: this is distinct from the previous example
since it does not require a matching local account.

Allow
_user_
from
_host_
to log in as any non-root user:

    host user

Allow all users with matching local accounts from
_host_
to log in except for
_baduser_:

    host -baduser
    host

Deny all users from
_host_:

    -host

Note: the use of
_-host&nbsp;-user_
is never a valid syntax,
including attempting to specify that a particular user from the host
is not trusted.

Allow all users with matching local accounts on all hosts in a
_netgroup_:

    +@netgroup

Disallow all users on all hosts in a
_netgroup_:

    -@netgroup

Allow all users in a
_netgroup_
to log in from
_host_
as any non-root user:

    host +@netgroup

Allow all users with matching local accounts on all hosts in a
_netgroup_
except
_baduser_:

    +@netgroup -baduser
    +@netgroup

Note: the deny statements must always precede the allow statements because
the file is processed sequentially until the first matching rule is found.

<a name="see-also"></a>

# See Also

**rhosts**(5),
**rlogind**(8),
**rshd**(8)

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
