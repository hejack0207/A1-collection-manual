# groupdel(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

groupdel - delete a group

<a name="synopsis"></a>

# Synopsis

```
.HP \w'groupdel&nbsp;'u groupdel [options] GROUP
```

<a name="description"></a>

# Description


The
**groupdel**
command modifies the system account files, deleting all entries that refer to
_GROUP_. The named group must exist.

<a name="options"></a>

# Options


The options which apply to the
**groupdel**
command are:

**-h**, **--help**
Display help message and exit.

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

<a name="caveats"></a>

# Caveats


You may not remove the primary group of any existing user. You must remove the user before you remove the group.

You should manually check all file systems to ensure that no files remain owned by this group.

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

<a name="exit-values"></a>

# Exit Values


The
**groupdel**
command exits with the following values:

_0_
success

_2_
invalid command syntax

_6_
specified group doesnt exist

_8_
cant remove user\*(Aqs primary group

_10_
cant update group file

<a name="see-also"></a>

# See Also


**chfn**(1),
**chsh**(1),
**passwd**(1),
**gpasswd**(8),
**groupadd**(8),
**groupmod**(8),
**useradd**(8),
**userdel**(8),
**usermod**(8).
