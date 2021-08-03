# grpck(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

grpck - verify integrity of group files

<a name="synopsis"></a>

# Synopsis

```
.HP \w'grpck&nbsp;'u grpck [options] [group&nbsp;[&nbsp;shadow&nbsp;]]
```

<a name="description"></a>

# Description


The
**grpck**
command verifies the integrity of the groups information. It checks that all entries in
/etc/group
and /etc/gshadow
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
  a unique and valid group name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a valid group identifier
  (/etc/group only)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a valid list of members
  and administrators

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  a corresponding entry in the
  /etc/gshadow
  file (respectively
  /etc/group
  for the
  gshadow
  checks)

The checks for correct number of fields and unique group name are fatal. If an entry has the wrong number of fields, the user will be prompted to delete the entire line. If the user does not answer affirmatively, all further checks are bypassed. An entry with a duplicated group name is prompted for deletion, but the remaining checks will still be made. All other errors are warnings and the user is encouraged to run the
**groupmod**
command to correct the error.

The commands which operate on the
/etc/group
and /etc/gshadow files
are not able to alter corrupted or duplicated entries.
**grpck**
should be used in those circumstances to remove the offending entries.

<a name="options"></a>

# Options


The
**-r**
and
**-s**
options cannot be combined.

The options which apply to the
**grpck**
command are:

**-h**, **--help**
Display help message and exit.

**-r**, **--read-only**
Execute the
**grpck**
command in read-only mode. This causes all questions regarding changes to be answered
_no_
without user intervention.

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

**-s**, **--sort**
Sort entries in
/etc/group
and /etc/gshadow
by GID.

By default,
**grpck**
operates on
/etc/group
and /etc/gshadow. The user may select alternate files with the
_group_
and _shadow_ parameters.

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

/etc/passwd
User account information.

<a name="exit-values"></a>

# Exit Values


The
**grpck**
command exits with the following values:

_0_
success

_1_
invalid command syntax

_2_
one or more bad group entries

_3_
cant open group files

_4_
cant lock group files

_5_
cant update group files

<a name="see-also"></a>

# See Also


**group**(5),
**groupmod**(8),
**gshadow**(5),
**passwd**(5),
**pwck**(8),
**shadow**(5).
