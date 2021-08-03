# chgpasswd(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

chgpasswd - update group passwords in batch mode

<a name="synopsis"></a>

# Synopsis

```
.HP \w'chgpasswd&nbsp;'u chgpasswd [options]
```

<a name="description"></a>

# Description


The
**chgpasswd**
command reads a list of group name and password pairs from standard input and uses this information to update a set of existing groups. Each line is of the format:

_group\_name_:_password_

By default the supplied password must be in clear-text, and is encrypted by
**chgpasswd**.

The default encryption algorithm can be defined for the system with the
**ENCRYPT\_METHOD**
variable of
/etc/login.defs, and can be overwritten with the
**-e**,
**-m**, or
**-c**
options.

This command is intended to be used in a large system environment where many accounts are created at a single time.

<a name="options"></a>

# Options


The options which apply to the
**chgpasswd**
command are:

**-c**, **--crypt-method**
Use the specified method to encrypt the passwords.

The available methods are DES, MD5, NONE, and SHA256 or SHA512 if your libc support these methods.

**-e**, **--encrypted**
Supplied passwords are in encrypted form.

**-h**, **--help**
Display help message and exit.

**-m**, **--md5**
Use MD5 encryption instead of DES when the supplied passwords are not encrypted.

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


Remember to set permissions or umask to prevent readability of unencrypted files by other users.

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

/etc/login.defs
Shadow password suite configuration.

<a name="see-also"></a>

# See Also


**gpasswd**(1),
**groupadd**(8),
**login.defs**(5).
