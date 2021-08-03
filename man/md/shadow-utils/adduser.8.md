# useradd(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

useradd - create a new user or update default new user information

<a name="synopsis"></a>

# Synopsis

```
.HP \w'useradd&nbsp;'u useradd [options] LOGIN .HP \w'useradd&nbsp;'u useradd -D .HP \w'useradd&nbsp;'u useradd -D [options]
```

<a name="description"></a>

# Description


When invoked without the
**-D**
option, the
**useradd**
command creates a new user account using the values specified on the command line plus the default values from the system. Depending on command line options, the
**useradd**
command will update system files and may also create the new users home directory and copy initial files.

By default, a group will also be created for the new user (see
**-g**,
**-N**,
**-U**, and
**USERGROUPS\_ENAB**).

<a name="options"></a>

# Options


The options which apply to the
**useradd**
command are:

**--badname**&nbsp;Allow names that do not conform to standards.

**-b**, **--base-dir**&nbsp;_BASE\_DIR_
The default base directory for the system if
**-d**&nbsp;_HOME\_DIR_
is not specified.
_BASE\_DIR_
is concatenated with the account name to define the home directory. If the
**-m**
option is not used,
_BASE\_DIR_
must exist.

If this option is not specified,
**useradd**
will use the base directory specified by the
**HOME**
variable in
/etc/default/useradd, or
/home
by default.

**-c**, **--comment**&nbsp;_COMMENT_
Any text string. It is generally a short description of the login, and is currently used as the field for the users full name.

**-d**, **--home-dir**&nbsp;_HOME\_DIR_
The new user will be created using
_HOME\_DIR_
as the value for the users login directory. The default is to append the
_LOGIN_
name to
_BASE\_DIR_
and use that as the login directory name. If the directory
_HOME\_DIR_
does not exist, then it will be created unless the
**-M**
option is specified.

**-D**, **--defaults**
See below, the subsection "Changing the default values".

**-e**, **--expiredate**&nbsp;_EXPIRE\_DATE_
The date on which the user account will be disabled. The date is specified in the format
_YYYY-MM-DD_.

If not specified,
**useradd**
will use the default expiry date specified by the
**EXPIRE**
variable in
/etc/default/useradd, or an empty string (no expiry) by default.

**-f**, **--inactive**&nbsp;_INACTIVE_
The number of days after a password expires until the account is permanently disabled. A value of 0 disables the account as soon as the password has expired, and a value of -1 disables the feature.

If not specified,
**useradd**
will use the default inactivity period specified by the
**INACTIVE**
variable in
/etc/default/useradd, or -1 by default.

**-g**, **--gid**&nbsp;_GROUP_
The group name or number of the users initial login group. The group name must exist. A group number must refer to an already existing group.

If not specified, the behavior of
**useradd**
will depend on the
**USERGROUPS\_ENAB**
variable in
/etc/login.defs. If this variable is set to
_yes_
(or
**-U/--user-group**
is specified on the command line), a group will be created for the user, with the same name as her loginname. If the variable is set to
_no_
(or
**-N/--no-user-group**
is specified on the command line), useradd will set the primary group of the new user to the value specified by the
**GROUP**
variable in
/etc/default/useradd, or 100 by default.

**-G**, **--groups**&nbsp;_GROUP1_[_,GROUP2,..._[_,GROUPN_]]]
A list of supplementary groups which the user is also a member of. Each group is separated from the next by a comma, with no intervening whitespace. The groups are subject to the same restrictions as the group given with the
**-g**
option. The default is for the user to belong only to the initial group.

**-h**, **--help**
Display help message and exit.

**-k**, **--skel**&nbsp;_SKEL\_DIR_
The skeleton directory, which contains files and directories to be copied in the users home directory, when the home directory is created by
**useradd**.

This option is only valid if the
**-m**
(or
**--create-home**) option is specified.

If this option is not set, the skeleton directory is defined by the
**SKEL**
variable in
/etc/default/useradd
or, by default,
/etc/skel.

If possible, the ACLs and extended attributes are copied.

**-K**, **--key**&nbsp;_KEY_=_VALUE_
Overrides
/etc/login.defs
defaults (**UID\_MIN**,
**UID\_MAX**,
**UMASK**,
**PASS\_MAX\_DAYS**
and others).

Example:
**-K**&nbsp;_PASS\_MAX\_DAYS_=_-1_
can be used when creating system account to turn off password aging, even though system account has no password at all. Multiple
**-K**
options can be specified, e.g.:
**-K**&nbsp;_UID\_MIN_=_100_&nbsp;**-K**&nbsp;_UID\_MAX_=_499_

**-l**, **--no-log-init**
Do not add the user to the lastlog and faillog databases.

By default, the users entries in the lastlog and faillog databases are reset to avoid reusing the entry from a previously deleted user.

**-m**, **--create-home**
Create the users home directory if it does not exist. The files and directories contained in the skeleton directory (which can be defined with the
**-k**
option) will be copied to the home directory.

By default, if this option is not specified and
**CREATE\_HOME**
is not enabled, no home directories are created.

The directory where the users home directory is created must exist and have proper SELinux context and permissions. Otherwise the user\*(Aqs home directory cannot be created or accessed.

**-M**, **--no-create-home**
Do no create the users home directory, even if the system wide setting from
/etc/login.defs
(**CREATE\_HOME**) is set to
_yes_.

**-N**, **--no-user-group**
Do not create a group with the same name as the user, but add the user to the group specified by the
**-g**
option or by the
**GROUP**
variable in
/etc/default/useradd.

The default behavior (if the
**-g**,
**-N**, and
**-U**
options are not specified) is defined by the
**USERGROUPS\_ENAB**
variable in
/etc/login.defs.

**-o**, **--non-unique**
Allow the creation of a user account with a duplicate (non-unique) UID.

This option is only valid in combination with the
**-u**
option.

**-p**, **--password**&nbsp;_PASSWORD_
The encrypted password, as returned by
**crypt**(3). The default is to disable the password.

**Note:**
This option is not recommended because the password (or encrypted password) will be visible by users listing the processes.

You should make sure the password respects the systems password policy.

**-r**, **--system**
Create a system account.

System users will be created with no aging information in
/etc/shadow, and their numeric identifiers are chosen in the
**SYS\_UID\_MIN**-**SYS\_UID\_MAX**
range, defined in
/etc/login.defs, instead of
**UID\_MIN**-**UID\_MAX**
(and their
**GID**
counterparts for the creation of groups).

Note that
**useradd**
will not create a home directory for such a user, regardless of the default setting in
/etc/login.defs
(**CREATE\_HOME**). You have to specify the
**-m**
options if you want a home directory for a system account to be created.

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
The name of the users login shell. The default is to leave this field blank, which causes the system to select the default login shell specified by the
**SHELL**
variable in
/etc/default/useradd, or an empty string by default.

**-u**, **--uid**&nbsp;_UID_
The numerical value of the users ID. This value must be unique, unless the
**-o**
option is used. The value must be non-negative. The default is to use the smallest ID value greater than or equal to
**UID\_MIN**
and greater than every other user.

See also the
**-r**
option and the
**UID\_MAX**
description.

**-U**, **--user-group**
Create a group with the same name as the user, and add the user to this group.

The default behavior (if the
**-g**,
**-N**, and
**-U**
options are not specified) is defined by the
**USERGROUPS\_ENAB**
variable in
/etc/login.defs.

**-Z**, **--selinux-user**&nbsp;_SEUSER_
The SELinux user for the users login. The default is to leave this field blank, which causes the system to select the default SELinux user.

<a name="changing-the-default-values"></a>

### Changing the default values


When invoked with only the
**-D**
option,
**useradd**
will display the current default values. When invoked with
**-D**
plus other options,
**useradd**
will update the default values for the specified options. Valid default-changing options are:

**-b**, **--base-dir**&nbsp;_BASE\_DIR_
The path prefix for a new users home directory. The user\*(Aqs name will be affixed to the end of
_BASE\_DIR_
to form the new users home directory name, if the
**-d**
option is not used when creating a new account.

This option sets the
**HOME**
variable in
/etc/default/useradd.

**-e**, **--expiredate**&nbsp;_EXPIRE\_DATE_
The date on which the user account is disabled.

This option sets the
**EXPIRE**
variable in
/etc/default/useradd.

**-f**, **--inactive**&nbsp;_INACTIVE_
The number of days after a password has expired before the account will be disabled.

This option sets the
**INACTIVE**
variable in
/etc/default/useradd.

**-g**, **--gid**&nbsp;_GROUP_
The group name or ID for a new users initial group (when the
**-N/--no-user-group**
is used or when the
**USERGROUPS\_ENAB**
variable is set to
_no_
in
/etc/login.defs). The named group must exist, and a numerical group ID must have an existing entry.

This option sets the
**GROUP**
variable in
/etc/default/useradd.

**-s**, **--shell**&nbsp;_SHELL_
The name of a new users login shell.

This option sets the
**SHELL**
variable in
/etc/default/useradd.

<a name="notes"></a>

# Notes


The system administrator is responsible for placing the default user files in the
/etc/skel/
directory (or any other skeleton directory specified in
/etc/default/useradd
or on the command line).

<a name="caveats"></a>

# Caveats


You may not add a user to a NIS or LDAP group. This must be performed on the corresponding server.

Similarly, if the username already exists in an external user database such as NIS or LDAP,
**useradd**
will deny the user account creation request.

Usernames may contain only lower and upper case letters, digits, underscores, or dashes. They can end with a dollar sign. Dashes are not allowed at the beginning of the username. Fully numeric usernames and usernames . or .. are also disallowed. It is not recommended to use usernames beginning with . character as their home directories will be hidden in the
**ls**
output.

Usernames may only be up to 32 characters long.

<a name="configuration"></a>

# Configuration


The following configuration variables in
/etc/login.defs
change the behavior of this tool:

**CREATE\_HOME** (boolean)
Indicate if a home directory should be created by default for new users.

This setting does not apply to system users, and can be overridden on the command line.

**GID\_MAX** (number), **GID\_MIN** (number)
Range of group IDs used for the creation of regular groups by
**useradd**,
**groupadd**, or
**newusers**.

The default value for
**GID\_MIN**
(resp.
**GID\_MAX**) is 1000 (resp. 60000).

**HOME\_MODE** (number)
The mode for new home directories. If not specified, the
**UMASK**
is used to create the mode.

**useradd**
and
**newusers**
use this to set the mode of the home directory they create.

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

**PASS\_MAX\_DAYS** (number)
The maximum number of days a password may be used. If the password is older than this, a password change will be forced. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_MIN\_DAYS** (number)
The minimum number of days allowed between password changes. Any password changes attempted sooner than this will be rejected. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_WARN\_AGE** (number)
The number of days warning given before a password expires. A zero means warning is given only upon the day of expiration, a negative value means no warning is given. If not specified, no warning will be provided.

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

**SYS\_UID\_MAX** (number), **SYS\_UID\_MIN** (number)
Range of user IDs used for the creation of system users by
**useradd**
or
**newusers**.

The default value for
**SYS\_UID\_MIN**
(resp.
**SYS\_UID\_MAX**) is 101 (resp.
**UID\_MIN**-1).

**UID\_MAX** (number), **UID\_MIN** (number)
Range of user IDs used for the creation of regular users by
**useradd**
or
**newusers**.

The default value for
**UID\_MIN**
(resp.
**UID\_MAX**) is 1000 (resp. 60000).

**UMASK** (number)
The file mode creation mask is initialized to this value. If not specified, the mask will be initialized to 022.

**useradd**
and
**newusers**
use this mask to set the mode of the home directory they create if
**HOME\_MODE**
is not set.

It is also used by
**login**
to define users initial umask. Note that this mask can be overridden by the user\*(Aqs GECOS line (if
**QUOTAS\_ENAB**
is set) or by the specification of a limit with the
_K_
identifier in
**limits**(5).

**USERGROUPS\_ENAB** (boolean)
Enable setting of the umask group bits to be the same as owner bits (examples: 022 -&gt; 002, 077 -&gt; 007) for non-root users, if the uid is the same as gid, and username is the same as the primary group name.

If set to
_yes_,
**userdel**
will remove the users group if it contains no more members, and
**useradd**
will create by default a group with the name of the user.

<a name="files"></a>

# Files


/etc/passwd
User account information.

/etc/shadow
Secure user account information.

/etc/group
Group account information.

/etc/gshadow
Secure group account information.

/etc/default/useradd
Default values for account creation.

/etc/skel/
Directory containing default files.

/etc/subgid
Per user subordinate group IDs.

/etc/subuid
Per user subordinate user IDs.

/etc/login.defs
Shadow password suite configuration.

<a name="exit-values"></a>

# Exit Values


The
**useradd**
command exits with the following values:

_0_
success

_1_
cant update password file

_2_
invalid command syntax

_3_
invalid argument to option

_4_
UID already in use (and no
**-o**)

_6_
specified group doesnt exist

_9_
username already in use

_10_
cant update group file

_12_
cant create home directory

_14_
cant update SELinux user mapping

<a name="see-also"></a>

# See Also


**chfn**(1),
**chsh**(1),
**passwd**(1),
**crypt**(3),
**groupadd**(8),
**groupdel**(8),
**groupmod**(8),
**login.defs**(5),
**newusers**(8),
**subgid**(5), **subuid**(5),
**userdel**(8),
**usermod**(8).
