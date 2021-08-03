# newusers(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

newusers - update and create new users in batch

<a name="synopsis"></a>

# Synopsis

```
.HP \w'newusers&nbsp;'u newusers [options] [file]
```

<a name="description"></a>

# Description


The
**newusers**
command reads a
_file_
(or the standard input by default) and uses this information to update a set of existing users or to create new users. Each line is in the same format as the standard password file (see
**passwd**(5)) with the exceptions explained below:

pw_name:pw_passwd:pw_uid:pw_gid:pw_gecos:pw_dir:pw_shell

_pw\_name_
This is the name of the user.

It can be the name of a new user or the name of an existing user (or a user created before by
**newusers**). In case of an existing user, the users information will be changed, otherwise a new user will be created.

_pw\_passwd_
This field will be encrypted and used as the new value of the encrypted password.

_pw\_uid_
This field is used to define the UID of the user.

If the field is empty, a new (unused) UID will be defined automatically by
**newusers**.

If this field contains a number, this number will be used as the UID.

If this field contains the name of an existing user (or the name of a user created before by
**newusers**), the UID of the specified user will be used.

If the UID of an existing user is changed, the files ownership of the users file should be fixed manually.

_pw\_gid_
This field is used to define the primary group ID for the user.

If this field contains the name of an existing group (or a group created before by
**newusers**), the GID of this group will be used as the primary group ID for the user.

If this field is a number, this number will be used as the primary group ID of the user. If no groups exist with this GID, a new group will be created with this GID, and the name of the user.

If this field is empty, a new group will be created with the name of the user and a GID will be automatically defined by
**newusers**
to be used as the primary group ID for the user and as the GID for the new group.

If this field contains the name of a group which does not exist (and was not created before by
**newusers**), a new group will be created with the specified name and a GID will be automatically defined by
**newusers**
to be used as the primary group ID for the user and GID for the new group.

_pw\_gecos_
This field is copied in the GECOS field of the user.

_pw\_dir_
This field is used to define the home directory of the user.

If this field does not specify an existing directory, the specified directory is created, with ownership set to the user being created or updated and its primary group. Note that newusers does not create parent directories of the new users home directory. The newusers command will fail to create the home directory if the parent directories do not exist, and will send a message to stderr informing the user of the failure. The newusers command will not halt or return a failure to the calling shell if it fails to create the home directory, it will continue to process the batch of new users specified.

If the home directory of an existing user is changed,
**newusers**
does not move or copy the content of the old directory to the new location. This should be done manually.

_pw\_shell_
This field defines the shell of the user. No checks are performed on this field.

**newusers**
first tries to create or change all the specified users, and then write these changes to the user or group databases. If an error occurs (except in the final writes to the databases), no changes are committed to the databases.

This command is intended to be used in a large system environment where many accounts are updated at a single time.

<a name="options"></a>

# Options


The options which apply to the
**newusers**
command are:

**--badname**&nbsp;Allow names that do not conform to standards.

**-c**, **--crypt-method**
Use the specified method to encrypt the passwords.

The available methods are DES, MD5, NONE, and SHA256 or SHA512 if your libc support these methods.

**-h**, **--help**
Display help message and exit.

**-r**, **--system**
Create a system account.

System users will be created with no aging information in
/etc/shadow, and their numeric identifiers are chosen in the
**SYS\_UID\_MIN**-**SYS\_UID\_MAX**
range, defined in
login.defs, instead of
**UID\_MIN**-**UID\_MAX**
(and their
**GID**
counterparts for the creation of groups).

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

**-s**, **--sha-rounds**
Use the specified number of rounds to encrypt the passwords.

The value 0 means that the system will choose the default number of rounds for the crypt method (5000).

A minimal value of 1000 and a maximal value of 999,999,999 will be enforced.

You can only use this option with the SHA256 or SHA512 crypt method.

By default, the number of rounds is defined by the SHA_CRYPT_MIN_ROUNDS and SHA_CRYPT_MAX_ROUNDS variables in
/etc/login.defs.

<a name="caveats"></a>

# Caveats


The input file must be protected since it contains unencrypted passwords.

You should make sure the passwords and the encryption method respect the systems password policy.

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

**PASS\_MAX\_DAYS** (number)
The maximum number of days a password may be used. If the password is older than this, a password change will be forced. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_MIN\_DAYS** (number)
The minimum number of days allowed between password changes. Any password changes attempted sooner than this will be rejected. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_WARN\_AGE** (number)
The number of days warning given before a password expires. A zero means warning is given only upon the day of expiration, a negative value means no warning is given. If not specified, no warning will be provided.

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

/etc/login.defs
Shadow password suite configuration.

/etc/subgid
Per user subordinate group IDs.

/etc/subuid
Per user subordinate user IDs.

<a name="see-also"></a>

# See Also


**login.defs**(5),
**passwd**(1),
**subgid**(5), **subuid**(5),
**useradd**(8).
