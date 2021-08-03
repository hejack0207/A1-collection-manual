# groupadd(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

groupadd - create a new group

<a name="synopsis"></a>

# Synopsis

```
.HP \w'groupadd&nbsp;'u groupadd [options] group
```

<a name="description"></a>

# Description


The
**groupadd**
command creates a new group account using the values specified on the command line plus the default values from the system. The new group will be entered into the system files as needed.

<a name="options"></a>

# Options


The options which apply to the
**groupadd**
command are:

**-f**, **--force**
This option causes the command to simply exit with success status if the specified group already exists. When used with
**-g**, and the specified GID already exists, another (unique) GID is chosen (i.e.
**-g**
is turned off).

**-g**, **--gid**&nbsp;_GID_
The numerical value of the groups ID. This value must be unique, unless the
**-o**
option is used. The value must be non-negative. The default is to use the smallest ID value greater than or equal to
**GID\_MIN**
and greater than every other group.

See also the
**-r**
option and the
**GID\_MAX**
description.

**-h**, **--help**
Display help message and exit.

**-K**, **--key**&nbsp;_KEY_=_VALUE_
Overrides
/etc/login.defs
defaults (GID_MIN, GID_MAX and others). Multiple
**-K**
options can be specified.

Example:
**-K**&nbsp;_GID\_MIN_=_100_&nbsp;**-K**&nbsp;_GID\_MAX_=_499_

Note:
**-K**&nbsp;_GID\_MIN_=_10_,_GID\_MAX_=_499_
doesnt work yet.

**-o**, **--non-unique**
This option permits to add a group with a non-unique GID.

**-p**, **--password**&nbsp;_PASSWORD_
The encrypted password, as returned by
**crypt**(3). The default is to disable the password.

**Note:**
This option is not recommended because the password (or encrypted password) will be visible by users listing the processes.

You should make sure the password respects the systems password policy.

**-r**, **--system**
Create a system group.

The numeric identifiers of new system groups are chosen in the
**SYS\_GID\_MIN**-**SYS\_GID\_MAX**
range, defined in
login.defs, instead of
**GID\_MIN**-**GID\_MAX**.

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

**GID\_MAX** (number), **GID\_MIN** (number)
Range of group IDs used for the creation of regular groups by
**useradd**,
**groupadd**, or
**newusers**.

The default value for
**GID\_MIN**
(resp.
**GID\_MAX**) is 1000 (resp. 60000).

**MAX\_MEMBERS\_PER\_GROUP** (number)
Maximum members per group entry. When the maximum is reached, a new group entry (line) is started in
/etc/group
(with the same name, same password, and same GID).

The default value is 0, meaning that there are no limits in the number of members in a group.

This feature (split group) permits to limit the length of lines in the group file. This is useful to make sure that lines for NIS groups are not larger than 1024 characters.

If you need to enforce such limit, you can use 25.

Note: split groups may not be supported by all tools (even in the Shadow toolsuite). You should not use this variable unless you really need it.

**SYS\_GID\_MAX** (number), **SYS\_GID\_MIN** (number)
Range of group IDs used for the creation of system groups by
**useradd**,
**groupadd**, or
**newusers**.

The default value for
**SYS\_GID\_MIN**
(resp.
**SYS\_GID\_MAX**) is 101 (resp.
**GID\_MIN**-1).

<a name="files"></a>

# Files


/etc/group
Group account information.

/etc/gshadow
Secure group account information.

/etc/login.defs
Shadow password suite configuration.

<a name="caveats"></a>

# Caveats


Groupnames may contain only lower and upper case letters, digits, underscores, or dashes. They can end with a dollar sign. Dashes are not allowed at the beginning of the groupname. Fully numeric groupnames and groupnames . or .. are also disallowed.

Groupnames may only be up to 32 characters long.

You may not add a NIS or LDAP group. This must be performed on the corresponding server.

If the groupname already exists in an external group database such as NIS or LDAP,
**groupadd**
will deny the group creation request.

<a name="exit-values"></a>

# Exit Values


The
**groupadd**
command exits with the following values:

_0_
success

_2_
invalid command syntax

_3_
invalid argument to option

_4_
GID is already used (when called without
**-o**)

_9_
group name is already used

_10_
cant update group file

<a name="see-also"></a>

# See Also


**chfn**(1),
**chsh**(1),
**passwd**(1),
**gpasswd**(8),
**groupdel**(8),
**groupmod**(8),
**login.defs**(5),
**useradd**(8),
**userdel**(8),
**usermod**(8).
