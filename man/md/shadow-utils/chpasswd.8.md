# chpasswd(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

chpasswd - update passwords in batch mode

<a name="synopsis"></a>

# Synopsis

```
.HP \w'chpasswd&nbsp;'u chpasswd [options]
```

<a name="description"></a>

# Description


The
**chpasswd**
command reads a list of user name and password pairs from standard input and uses this information to update a group of existing users. Each line is of the format:

_user\_name_:_password_

By default the passwords must be supplied in clear-text, and are encrypted by
**chpasswd**. Also the password age will be updated, if present.

The default encryption algorithm can be defined for the system with the
**ENCRYPT\_METHOD**
or
**MD5\_CRYPT\_ENAB**
variables of
/etc/login.defs, and can be overwritten with the
**-e**,
**-m**, or
**-c**
options.

**chpasswd**
first updates all the passwords in memory, and then commits all the changes to disk if no errors occurred for any user.

This command is intended to be used in a large system environment where many accounts are created at a single time.

<a name="options"></a>

# Options


The options which apply to the
**chpasswd**
command are:

**-c**, **--crypt-method**&nbsp;_METHOD_
Use the specified method to encrypt the passwords.

The available methods are DES, MD5, NONE, and SHA256 or SHA512 if your libc support these methods.

By default (if none of the
**-c**,
**-m**, or
**-e**
options are specified), the encryption method is defined by the
**ENCRYPT\_METHOD**
or
**MD5\_CRYPT\_ENAB**
variables of
/etc/login.defs.

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

**-s**, **--sha-rounds**&nbsp;_ROUNDS_
Use the specified number of rounds to encrypt the passwords.

The value 0 means that the system will choose the default number of rounds for the crypt method (5000).

A minimal value of 1000 and a maximal value of 999,999,999 will be enforced.

You can only use this option with the SHA256 or SHA512 crypt method.

By default, the number of rounds is defined by the
**SHA\_CRYPT\_MIN\_ROUNDS**
and
**SHA\_CRYPT\_MAX\_ROUNDS**
variables in
/etc/login.defs.

<a name="caveats"></a>

# Caveats


Remember to set permissions or umask to prevent readability of unencrypted files by other users.

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


/etc/passwd
User account information.

/etc/shadow
Secure user account information.

/etc/login.defs
Shadow password suite configuration.

<a name="see-also"></a>

# See Also


**passwd**(1),
**newusers**(8),
**login.defs**(5),
**useradd**(8).
