# pwck(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pwck - verify integrity of password files

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pwck&nbsp;'u pwck [options] [passwd&nbsp;[&nbsp;shadow&nbsp;]]
```

<a name="description"></a>

# Description


The
**pwck**
command verifies the integrity of the users and authentication information. It checks that all entries in
/etc/passwd
and
/etc/shadow
have the proper format and contain valid data. The user is prompted to delete entries that are improperly formatted or which have other uncorrectable errors.

Checks are made to verify that each entry has:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the correct number of fields

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a unique and valid user name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a valid user and group identifier

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a valid primary group

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a valid home directory

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a valid login shell

shadow
checks are enabled when a second file parameter is specified or when
/etc/shadow
exists on the system.

These checks are the following:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  every passwd entry has a matching shadow entry, and every shadow entry has a matching passwd entry

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  passwords are specified in the shadowed file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  shadow entries have the correct number of fields

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  shadow entries are unique in shadow

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the last password changes are not in the future

The checks for correct number of fields and unique user name are fatal. If the entry has the wrong number of fields, the user will be prompted to delete the entire line. If the user does not answer affirmatively, all further checks are bypassed. An entry with a duplicated user name is prompted for deletion, but the remaining checks will still be made. All other errors are warning and the user is encouraged to run the
**usermod**
command to correct the error.

The commands which operate on the
/etc/passwd
file are not able to alter corrupted or duplicated entries.
**pwck**
should be used in those circumstances to remove the offending entry.

<a name="options"></a>

# Options


The
**-r**
and
**-s**
options cannot be combined.

The options which apply to the
**pwck**
command are:

**--badname**&nbsp;Allow names that do not conform to standards.

**-h**, **--help**
Display help message and exit.

**-q**, **--quiet**
Report errors only. The warnings which do not require any action from the user wont be displayed.

**-r**, **--read-only**
Execute the
**pwck**
command in read-only mode.

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

**-s**, **--sort**
Sort entries in
/etc/passwd
and
/etc/shadow
by UID.

By default,
**pwck**
operates on the files
/etc/passwd
and
/etc/shadow. The user may select alternate files with the
_passwd_
and
_shadow_
parameters.

<a name="configuration"></a>

# Configuration


The following configuration variables in
/etc/login.defs
change the behavior of this tool:

**PASS\_MAX\_DAYS** (number)
The maximum number of days a password may be used. If the password is older than this, a password change will be forced. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_MIN\_DAYS** (number)
The minimum number of days allowed between password changes. Any password changes attempted sooner than this will be rejected. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_WARN\_AGE** (number)
The number of days warning given before a password expires. A zero means warning is given only upon the day of expiration, a negative value means no warning is given. If not specified, no warning will be provided.

<a name="files"></a>

# Files


/etc/group
Group account information.

/etc/passwd
User account information.

/etc/shadow
Secure user account information.

<a name="exit-values"></a>

# Exit Values


The
**pwck**
command exits with the following values:

_0_
success

_1_
invalid command syntax

_2_
one or more bad password entries

_3_
cant open password files

_4_
cant lock password files

_5_
cant update password files

_6_
cant sort password files

<a name="see-also"></a>

# See Also


**group**(5),
**grpck**(8),
**passwd**(5),
**shadow**(5),
**usermod**(8).
