# groupmod(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

groupmod - modify a group definition on the system

<a name="synopsis"></a>

# Synopsis

```
.HP \w'groupmod&nbsp;'u groupmod [options] GROUP
```

<a name="description"></a>

# Description


The
**groupmod**
command modifies the definition of the specified
_GROUP_
by modifying the appropriate entry in the group database.

<a name="options"></a>

# Options


The options which apply to the
**groupmod**
command are:

**-g**, **--gid**&nbsp;_GID_
The group ID of the given
_GROUP_
will be changed to
_GID_.

The value of
_GID_
must be a non-negative decimal integer. This value must be unique, unless the
**-o**
option is used.

Users who use the group as primary group will be updated to keep the group as their primary group.

Any files that have the old group ID and must continue to belong to
_GROUP_, must have their group ID changed manually.

No checks will be performed with regard to the
**GID\_MIN**,
**GID\_MAX**,
**SYS\_GID\_MIN**, or
**SYS\_GID\_MAX**
from
/etc/login.defs.

**-h**, **--help**
Display help message and exit.

**-n**, **--new-name**&nbsp;_NEW\_GROUP_
The name of the group will be changed from
_GROUP_
to
_NEW\_GROUP_
name.

**-o**, **--non-unique**
When used with the
**-g**
option, allow to change the group
_GID_
to a non-unique value.

**-p**, **--password**&nbsp;_PASSWORD_
The encrypted password, as returned by
**crypt**(3).

**Note:**
This option is not recommended because the password (or encrypted password) will be visible by users listing the processes.

You should make sure the password respects the systems password policy.

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

**-P**, **--prefix**&nbsp;_PREFIX\_DIR_
Apply changes in the
_PREFIX\_DIR_
directory and use the configuration files from the
_PREFIX\_DIR_
directory. This option does not chroot and is intended for preparing a cross-compilation target. Some limitations: NIS and LDAP users/groups are not verified. PAM authentication is using the host files. No SELINUX support.

<a name="configuration"></a>

# Configuration


The following configuration variables in
/etc/login.defs
change the behavior of this tool:

**MAX\_MEMBERS\_PER\_GROUP** (number)
Maximum members per group entry. When the maximum is reached, a new group entry (line) is started in
/etc/group
(with the same name, same password, and same GID).

The default value is 0, meaning that there are no limits in the number of members in a group.

This feature (split group) permits to limit the length of lines in the group file. This is useful to make sure that lines for NIS groups are not larger than 1024 characters.

If you need to enforce such limit, you can use 25.

Note: split groups may not be supported by all tools (even in the Shadow toolsuite). You should not use this variable unless you really need it.

<a name="files"></a>

# Files


/etc/group
Group account information.

/etc/gshadow
Secure group account information.

/etc/login.defs
Shadow password suite configuration.

/etc/passwd
User account information.

<a name="exit-values"></a>

# Exit Values


The
**groupmod**
command exits with the following values:

_0_
E_SUCCESS: success

_2_
E_USAGE: invalid command syntax

_3_
E_BAD_ARG: invalid argument to option

_4_
E_GID_IN_USE: specified group doesnt exist

_6_
E_NOTFOUND: specified group doesnt exist

_9_
E_NAME_IN_USE: group name already in use

_10_
E_GRP_UPDATE: cant update group file

_11_
E_CLEANUP_SERVICE: cant setup cleanup service

_12_
E_PAM_USERNAME: cant determine your username for use with pam

_13_
E_PAM_ERROR: pam returned an error, see syslog facility id groupmod for the PAM error message

<a name="see-also"></a>

# See Also


**chfn**(1),
**chsh**(1),
**passwd**(1),
**gpasswd**(8),
**groupadd**(8),
**groupdel**(8),
**login.defs**(5),
**useradd**(8),
**userdel**(8),
**usermod**(8).
