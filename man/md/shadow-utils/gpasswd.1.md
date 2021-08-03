# gpasswd(1)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

gpasswd - administer /etc/group and /etc/gshadow

<a name="synopsis"></a>

# Synopsis

```
.HP \w'gpasswd&nbsp;'u gpasswd [option] group
```

<a name="description"></a>

# Description


The
**gpasswd**
command is used to administer
/etc/group, and /etc/gshadow. Every group can have
administrators,
members and a password.

System administrators can use the
**-A**
option to define group administrator(s) and the
**-M**
option to define members. They have all rights of group administrators and members.

**gpasswd**
called by
a group administrator
with a group name only prompts for the new password of the
_group_.

If a password is set the members can still use
**newgrp**(1)
without a password, and non-members must supply the password.

<a name="notes-about-group-passwords"></a>

### Notes about group passwords


Group passwords are an inherent security problem since more than one person is permitted to know the password. However, groups are a useful tool for permitting co-operation between different users.

<a name="options"></a>

# Options


Except for the
**-A**
and
**-M**
options, the options cannot be combined.

The options which apply to the
**gpasswd**
command are:

**-a**, **--add**&nbsp;_user_
Add the
_user_
to the named
_group_.

**-d**, **--delete**&nbsp;_user_
Remove the
_user_
from the named
_group_.

**-h**, **--help**
Display help message and exit.

**-Q**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

**-r**, **--remove-password**
Remove the password from the named
_group_. The group password will be empty. Only group members will be allowed to use
**newgrp**
to join the named
_group_.

**-R**, **--restrict**
Restrict the access to the named
_group_. The group password is set to "!". Only group members with a password will be allowed to use
**newgrp**
to join the named
_group_.

**-A**, **--administrators**&nbsp;_user_,...
Set the list of administrative users.

**-M**, **--members**&nbsp;_user_,...
Set the list of group members.

<a name="caveats"></a>

# Caveats


This tool only operates on the
/etc/group
and /etc/gshadow files.
Thus you cannot change any NIS or LDAP group. This must be performed on the corresponding server.

<a name="configuration"></a>

# Configuration


The following configuration variables in
/etc/login.defs
change the behavior of this tool:

**ENCRYPT\_METHOD** (string)
This defines the system default encryption algorithm for encrypting passwords (if no algorithm are specified on the command line).

It can take one of these values:
_DES_
(default),
_MD5_, _SHA256_, _SHA512_.

Note: this parameter overrides the
**MD5\_CRYPT\_ENAB**
variable.

**MAX\_MEMBERS\_PER\_GROUP** (number)
Maximum members per group entry. When the maximum is reached, a new group entry (line) is started in
/etc/group
(with the same name, same password, and same GID).

The default value is 0, meaning that there are no limits in the number of members in a group.

This feature (split group) permits to limit the length of lines in the group file. This is useful to make sure that lines for NIS groups are not larger than 1024 characters.

If you need to enforce such limit, you can use 25.

Note: split groups may not be supported by all tools (even in the Shadow toolsuite). You should not use this variable unless you really need it.

**MD5\_CRYPT\_ENAB** (boolean)
Indicate if passwords must be encrypted using the MD5-based algorithm. If set to
_yes_, new passwords will be encrypted using the MD5-based algorithm compatible with the one used by recent releases of FreeBSD. It supports passwords of unlimited length and longer salt strings. Set to
_no_
if you need to copy encrypted passwords to other systems which dont understand the new algorithm. Default is
_no_.

This variable is superseded by the
**ENCRYPT\_METHOD**
variable or by any command line option used to configure the encryption algorithm.

This variable is deprecated. You should use
**ENCRYPT\_METHOD**.

**SHA\_CRYPT\_MIN\_ROUNDS** (number), **SHA\_CRYPT\_MAX\_ROUNDS** (number)
When
**ENCRYPT\_METHOD**
is set to
_SHA256_
or
_SHA512_, this defines the number of SHA rounds used by the encryption algorithm by default (when the number of rounds is not specified on the command line).

With a lot of rounds, it is more difficult to brute forcing the password. But note also that more CPU resources will be needed to authenticate users.

If not specified, the libc will choose the default number of rounds (5000).

The values must be inside the 1000-999,999,999 range.

If only one of the
**SHA\_CRYPT\_MIN\_ROUNDS**
or
**SHA\_CRYPT\_MAX\_ROUNDS**
values is set, then this value will be used.

If
**SHA\_CRYPT\_MIN\_ROUNDS**
&gt;
**SHA\_CRYPT\_MAX\_ROUNDS**, the highest value will be used.

<a name="files"></a>

# Files


/etc/group
Group account information.

/etc/gshadow
Secure group account information.

<a name="see-also"></a>

# See Also


**newgrp**(1),
**groupadd**(8),
**groupdel**(8),
**groupmod**(8),
**grpck**(8),
**group**(5), **gshadow**(5).
