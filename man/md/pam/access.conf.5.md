# access\&.conf(5)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

access.conf - the login access control table file

<a name="description"></a>

# Description


The
/etc/security/access.conf
file specifies (_user/group_,
_host_), (_user/group_,
_network/netmask_), (_user/group_,
_tty_), (_user/group_,
_X-$DISPLAY-value_), or (_user/group_,
_pam-service-name_) combinations for which a login will be either accepted or refused.

When someone logs in, the file
access.conf
is scanned for the first entry that matches the (_user/group_,
_host_) or (_user/group_,
_network/netmask_) combination, or, in case of non-networked logins, the first entry that matches the (_user/group_,
_tty_) combination, or in the case of non-networked logins without a tty, the first entry that matches the (_user/group_,
_X-$DISPLAY-value_) or (_user/group_,
_pam-service-name/_) combination. The permissions field of that table entry determines whether the login will be accepted or refused.

Each line of the login access control table has three fields separated by a ":" character (colon):

_permission_:_users/groups_:_origins_

The first field, the
_permission_
field, can be either a "_+_" character (plus) for access granted or a "_-_" character (minus) for access denied.

The second field, the
_users_/_group_
field, should be a list of one or more login names, group names, or
_ALL_
(which always matches). To differentiate user entries from group entries, group entries should be written with brackets, e.g.
_(group)_.

The third field, the
_origins_
field, should be a list of one or more tty names (for non-networked logins), X
_$DISPLAY_
values or PAM service names (for non-networked logins without a tty), host names, domain names (begin with "."), host addresses, internet network numbers (end with "."), internet network addresses with network mask (where network mask can be a decimal number or an internet address also),
_ALL_
(which always matches) or
_LOCAL_. The
_LOCAL_
keyword matches if and only if
**pam\_get\_item**(3), when called with an
_item\_type_
of
_PAM\_RHOST_, returns
NULL
or an empty string (and therefore the
_origins_
field is compared against the return value of
**pam\_get\_item**(3)
called with an
_item\_type_
of
_PAM\_TTY_
or, absent that,
_PAM\_SERVICE_).

If supported by the system you can use
_@netgroupname_
in host or user patterns. The
_@@netgroupname_
syntax is supported in the user pattern only and it makes the local system hostname to be passed to the netgroup match call in addition to the user name. This might not work correctly on some libc implementations causing the match to always fail.

The
_EXCEPT_
operator makes it possible to write very compact rules.

If the
**nodefgroup**
is not set, the group file is searched when a name does not match that of the logged-in user. Only groups are matched in which users are explicitly listed. However the PAM module does not look at the primary group id of a user.

The "_#_" character at start of line (no space at front) can be used to mark this line as a comment line.

<a name="examples"></a>

# Examples


These are some example lines which might be specified in
/etc/security/access.conf.

User
_root_
should be allowed to get access via
_cron_, X11 terminal
_:0_,
_tty1_, ...,
_tty5_,
_tty6_.

+:root:crond :0 tty1 tty2 tty3 tty4 tty5 tty6

User
_root_
should be allowed to get access from hosts which own the IPv4 addresses. This does not mean that the connection have to be a IPv4 one, a IPv6 connection from a host with one of this IPv4 addresses does work, too.

+:root:192.168.200.1 192.168.200.4 192.168.200.9

+:root:127.0.0.1

User
_root_
should get access from network
192.168.201.
where the term will be evaluated by string matching. But it might be better to use network/netmask instead. The same meaning of
192.168.201.
is
_192.168.201.0/24_
or
_192.168.201.0/255.255.255.0_.

+:root:192.168.201.

User
_root_
should be able to have access from hosts
_foo1.bar.org_
and
_foo2.bar.org_
(uses string matching also).

+:root:foo1.bar.org foo2.bar.org

User
_root_
should be able to have access from domain
_foo.bar.org_
(uses string matching also).

+:root:.foo.bar.org

User
_root_
should be denied to get access from all other sources.

-:root:ALL

User
_foo_
and members of netgroup
_admins_
should be allowed to get access from all sources. This will only work if netgroup service is available.

+:@admins foo:ALL

User
_john_
and
_foo_
should get access from IPv6 host address.

+:john foo:2001:db8:0:101::1

User
_john_
should get access from IPv6 net/mask.

+:john:2001:db8:0:101::/64

Members of group
_wheel_
should be allowed to get access from all sources.

+:(wheel):ALL

Disallow console logins to all but the shutdown, sync and all other accounts, which are a member of the wheel group.

-:ALL EXCEPT (wheel) shutdown sync:LOCAL

All other users should be denied to get access from all sources.

-:ALL:ALL

<a name="notes"></a>

# Notes


The default separators of list items in a field are space, ,\*(Aq, and tabulator characters. Thus conveniently if spaces are put at the beginning and the end of the fields they are ignored. However if the list separator is changed with the
_listsep_
option, the spaces will become part of the actual item and the line will be most probably ignored. For this reason, it is not recommended to put spaces around the :\*(Aq characters.

<a name="see-also"></a>

# See Also


**pam\_access**(8),
**pam.d**(5),
**pam**(8)

<a name="authors"></a>

# Authors


Original
**login.access**(5)
manual was provided by Guido van Rooij which was renamed to
**access.conf**(5)
to reflect relation to default config file.

Network address / netmask description and example text was introduced by Mike Becher &lt;[mike.becher@lrz-muenchen.de](mailto:mike.becher@lrz-muenchen.de)&gt;.
