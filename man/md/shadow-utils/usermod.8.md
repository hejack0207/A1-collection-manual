# usermod(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

usermod - modify a user account

<a name="synopsis"></a>

# Synopsis

```
.HP \w'usermod&nbsp;'u usermod [options] LOGIN
```

<a name="description"></a>

# Description


The
**usermod**
command modifies the system account files to reflect the changes that are specified on the command line.

<a name="options"></a>

# Options


The options which apply to the
**usermod**
command are:

**-a**, **--append**
Add the user to the supplementary group(s). Use only with the
**-G**
option.

**-b**, **--badnames**
Allow names that do not conform to standards.

**-c**, **--comment**&nbsp;_COMMENT_
The new value of the users password file comment field. It is normally modified using the
**chfn**(1)
utility.

**-d**, **--home**&nbsp;_HOME\_DIR_
The users new login directory.

If the
**-m**
option is given, the contents of the current home directory will be moved to the new home directory, which is created if it does not already exist. If the current home directory does not exist the new home directory will not be created.

**-e**, **--expiredate**&nbsp;_EXPIRE\_DATE_
The date on which the user account will be disabled. The date is specified in the format
_YYYY-MM-DD_.

An empty
_EXPIRE\_DATE_
argument will disable the expiration of the account.

This option requires a
/etc/shadow
file. A
/etc/shadow
entry will be created if there were none.

**-f**, **--inactive**&nbsp;_INACTIVE_
The number of days after a password expires until the account is permanently disabled.

A value of 0 disables the account as soon as the password has expired, and a value of -1 disables the feature.

This option requires a
/etc/shadow
file. A
/etc/shadow
entry will be created if there were none.

**-g**, **--gid**&nbsp;_GROUP_
The group name or number of the users new initial login group. The group must exist.

Any file from the users home directory owned by the previous primary group of the user will be owned by this new group.

The group ownership of files outside of the users home directory must be fixed manually.

The change of the group ownership of files inside of the users home directory is also not done if the home dir owner uid is different from the current or new user id. This is safety measure for special home directories such as
/.

**-G**, **--groups**&nbsp;_GROUP1_[_,GROUP2,..._[_,GROUPN_]]]
A list of supplementary groups which the user is also a member of. Each group is separated from the next by a comma, with no intervening whitespace. The groups are subject to the same restrictions as the group given with the
**-g**
option.

If the user is currently a member of a group which is not listed, the user will be removed from the group. This behaviour can be changed via the
**-a**
option, which appends the user to the current supplementary group list.

**-l**, **--login**&nbsp;_NEW\_LOGIN_
The name of the user will be changed from
_LOGIN_
to
_NEW\_LOGIN_. Nothing else is changed. In particular, the users home directory or mail spool should probably be renamed manually to reflect the new login name.

**-L**, **--lock**
Lock a users password. This puts a \*(Aq!\*(Aq in front of the encrypted password, effectively disabling the password. You can\*(Aqt use this option with
**-p**
or
**-U**.

Note: if you wish to lock the account (not only access with a password), you should also set the
_EXPIRE\_DATE_
to
_1_.

**-m**, **--move-home**
Move the content of the users home directory to the new location. If the current home directory does not exist the new home directory will not be created.

This option is only valid in combination with the
**-d**
(or
**--home**) option.

**usermod**
will try to adapt the ownership of the files and to copy the modes, ACL and extended attributes, but manual changes might be needed afterwards.

**-o**, **--non-unique**
When used with the
**-u**
option, this option allows to change the user ID to a non-unique value.

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

**-s**, **--shell**&nbsp;_SHELL_
The name of the users new login shell. Setting this field to blank causes the system to select the default login shell.

**-u**, **--uid**&nbsp;_UID_
The new numerical value of the users ID.

This value must be unique, unless the
**-o**
option is used. The value must be non-negative.

The users mailbox, and any files which the user owns and which are located in the user\*(Aqs home directory will have the file user ID changed automatically.

The ownership of files outside of the users home directory must be fixed manually.

The change of the user ownership of files inside of the users home directory is also not done if the home dir owner uid is different from the current or new user id. This is safety measure for special home directories such as
/.

No checks will be performed with regard to the
**UID\_MIN**,
**UID\_MAX**,
**SYS\_UID\_MIN**, or
**SYS\_UID\_MAX**
from
/etc/login.defs.

**-U**, **--unlock**
Unlock a users password. This removes the \*(Aq!\*(Aq in front of the encrypted password. You can\*(Aqt use this option with
**-p**
or
**-L**.

Note: if you wish to unlock the account (not only access with a password), you should also set the
_EXPIRE\_DATE_
(for example to
_99999_, or to the
**EXPIRE**
value from
/etc/default/useradd).

**-v**, **--add-subuids**&nbsp;_FIRST_-_LAST_
Add a range of subordinate uids to the users account.

This option may be specified multiple times to add multiple ranges to a users account.

No checks will be performed with regard to
**SUB\_UID\_MIN**,
**SUB\_UID\_MAX**, or
**SUB\_UID\_COUNT**
from /etc/login.defs.

**-V**, **--del-subuids**&nbsp;_FIRST_-_LAST_
Remove a range of subordinate uids from the users account.

This option may be specified multiple times to remove multiple ranges to a users account. When both
**--del-subuids**
and
**--add-subuids**
are specified, the removal of all subordinate uid ranges happens before any subordinate uid range is added.

No checks will be performed with regard to
**SUB\_UID\_MIN**,
**SUB\_UID\_MAX**, or
**SUB\_UID\_COUNT**
from /etc/login.defs.

**-w**, **--add-subgids**&nbsp;_FIRST_-_LAST_
Add a range of subordinate gids to the users account.

This option may be specified multiple times to add multiple ranges to a users account.

No checks will be performed with regard to
**SUB\_GID\_MIN**,
**SUB\_GID\_MAX**, or
**SUB\_GID\_COUNT**
from /etc/login.defs.

**-W**, **--del-subgids**&nbsp;_FIRST_-_LAST_
Remove a range of subordinate gids from the users account.

This option may be specified multiple times to remove multiple ranges to a users account. When both
**--del-subgids**
and
**--add-subgids**
are specified, the removal of all subordinate gid ranges happens before any subordinate gid range is added.

No checks will be performed with regard to
**SUB\_GID\_MIN**,
**SUB\_GID\_MAX**, or
**SUB\_GID\_COUNT**
from /etc/login.defs.

**-Z**, **--selinux-user**&nbsp;_SEUSER_
The new SELinux user for the users login.

A blank
_SEUSER_
will remove the SELinux user mapping for user
_LOGIN_
(if any).

<a name="caveats"></a>

# Caveats


You must make certain that the named user is not executing any processes when this command is being executed if the users numerical user ID, the user\*(Aqs name, or the user\*(Aqs home directory is being changed.
**usermod**
checks this on Linux. On other platforms it only uses utmp to check if the user is logged in.

You must change the owner of any
**crontab**
files or
**at**
jobs manually.

You must make any changes involving NIS on the NIS server.

<a name="configuration"></a>

# Configuration


The following configuration variables in
/etc/login.defs
change the behavior of this tool:

**LASTLOG\_UID\_MAX** (number)
Highest user ID number for which the lastlog entries should be updated. As higher user IDs are usually tracked by remote user identity and authentication services there is no need to create a huge sparse lastlog file for them.

No
**LASTLOG\_UID\_MAX**
option present in the configuration means that there is no user ID limit for writing lastlog entries.

**MAIL\_DIR** (string)
The mail spool directory. This is needed to manipulate the mailbox when its corresponding user account is modified or deleted. If not specified, a compile-time default is used.

**MAIL\_FILE** (string)
Defines the location of the users mail spool files relatively to their home directory.

The
**MAIL\_DIR**
and
**MAIL\_FILE**
variables are used by
**useradd**,
**usermod**, and
**userdel**
to create, move, or delete the users mail spool.

If
**MAIL\_CHECK\_ENAB**
is set to
_yes_, they are also used to define the
**MAIL**
environment variable.

**MAX\_MEMBERS\_PER\_GROUP** (number)
Maximum members per group entry. When the maximum is reached, a new group entry (line) is started in
/etc/group
(with the same name, same password, and same GID).

The default value is 0, meaning that there are no limits in the number of members in a group.

This feature (split group) permits to limit the length of lines in the group file. This is useful to make sure that lines for NIS groups are not larger than 1024 characters.

If you need to enforce such limit, you can use 25.

Note: split groups may not be supported by all tools (even in the Shadow toolsuite). You should not use this variable unless you really need it.

**SUB\_GID\_MIN** (number), **SUB\_GID\_MAX** (number), **SUB\_GID\_COUNT** (number)
If
/etc/subuid
exists, the commands
**useradd**
and
**newusers**
(unless the user already have subordinate group IDs) allocate
**SUB\_GID\_COUNT**
unused group IDs from the range
**SUB\_GID\_MIN**
to
**SUB\_GID\_MAX**
for each new user.

The default values for
**SUB\_GID\_MIN**,
**SUB\_GID\_MAX**,
**SUB\_GID\_COUNT**
are respectively 100000, 600100000 and 65536.

**SUB\_UID\_MIN** (number), **SUB\_UID\_MAX** (number), **SUB\_UID\_COUNT** (number)
If
/etc/subuid
exists, the commands
**useradd**
and
**newusers**
(unless the user already have subordinate user IDs) allocate
**SUB\_UID\_COUNT**
unused user IDs from the range
**SUB\_UID\_MIN**
to
**SUB\_UID\_MAX**
for each new user.

The default values for
**SUB\_UID\_MIN**,
**SUB\_UID\_MAX**,
**SUB\_UID\_COUNT**
are respectively 100000, 600100000 and 65536.

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

/etc/shadow
Secure user account information.

/etc/subgid
Per user subordinate group IDs.

/etc/subuid
Per user subordinate user IDs.

<a name="see-also"></a>

# See Also


**chfn**(1),
**chsh**(1),
**passwd**(1),
**crypt**(3),
**gpasswd**(8),
**groupadd**(8),
**groupdel**(8),
**groupmod**(8),
**login.defs**(5),
**subgid**(5), **subuid**(5),
**useradd**(8),
**userdel**(8).
