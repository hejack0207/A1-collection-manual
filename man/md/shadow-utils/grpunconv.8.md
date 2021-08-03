# pwconv(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pwconv, pwunconv, grpconv, grpunconv - convert to and from shadow passwords and groups

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pwconv&nbsp;'u pwconv [options] .HP \w'pwunconv&nbsp;'u pwunconv [options] .HP \w'grpconv&nbsp;'u grpconv [options] .HP \w'grpunconv&nbsp;'u grpunconv [options]
```

<a name="description"></a>

# Description


The
**pwconv**
command creates
_shadow_
from
_passwd_
and an optionally existing
_shadow_.

The
**pwunconv**
command creates
_passwd_
from
_passwd_
and
_shadow_
and then removes
_shadow_.

The
**grpconv**
command creates
_gshadow_
from
_group_
and an optionally existing
_gshadow_.

The
**grpunconv**
command creates
_group_
from
_group_
and
_gshadow_
and then removes
_gshadow_.

These four programs all operate on the normal and shadow password and group files:
/etc/passwd,
/etc/group,
/etc/shadow, and
/etc/gshadow.

Each program acquires the necessary locks before conversion.
**pwconv**
and
**grpconv**
are similar. First, entries in the shadowed file which dont exist in the main file are removed. Then, shadowed entries which don\*(Aqt have \`x\*(Aq as the password in the main file are updated. Any missing shadowed entries are added. Finally, passwords in the main file are replaced with \`x\*(Aq. These programs can be used for initial conversion as well to update the shadowed file if the main file is edited by hand.

**pwconv**
will use the values of
_PASS\_MIN\_DAYS_,
_PASS\_MAX\_DAYS_, and
_PASS\_WARN\_AGE_
from
/etc/login.defs
when adding new entries to
/etc/shadow.

Likewise
**pwunconv**
and
**grpunconv**
are similar. Passwords in the main file are updated from the shadowed file. Entries which exist in the main file but not in the shadowed file are left alone. Finally, the shadowed file is removed. Some password aging information is lost by
**pwunconv**. It will convert what it can.

<a name="options"></a>

# Options


The options which apply to the
**pwconv**,
**pwunconv**,
**grpconv**, and
**grpunconv**
commands are:

**-h**, **--help**
Display help message and exit.

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

<a name="bugs"></a>

# Bugs


Errors in the password or group files (such as invalid or duplicate entries) may cause these programs to loop forever or fail in other strange ways. Please run
**pwck**
and
**grpck**
to correct any such errors before converting to or from shadow passwords or groups.

<a name="configuration"></a>

# Configuration


The following configuration variable in
/etc/login.defs
changes the behavior of
**grpconv**
and
**grpunconv**:

**MAX\_MEMBERS\_PER\_GROUP** (number)
Maximum members per group entry. When the maximum is reached, a new group entry (line) is started in
/etc/group
(with the same name, same password, and same GID).

The default value is 0, meaning that there are no limits in the number of members in a group.

This feature (split group) permits to limit the length of lines in the group file. This is useful to make sure that lines for NIS groups are not larger than 1024 characters.

If you need to enforce such limit, you can use 25.

Note: split groups may not be supported by all tools (even in the Shadow toolsuite). You should not use this variable unless you really need it.

The following configuration variables in
/etc/login.defs
change the behavior of
**pwconv**:

**PASS\_MAX\_DAYS** (number)
The maximum number of days a password may be used. If the password is older than this, a password change will be forced. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_MIN\_DAYS** (number)
The minimum number of days allowed between password changes. Any password changes attempted sooner than this will be rejected. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_WARN\_AGE** (number)
The number of days warning given before a password expires. A zero means warning is given only upon the day of expiration, a negative value means no warning is given. If not specified, no warning will be provided.

<a name="files"></a>

# Files


/etc/login.defs
Shadow password suite configuration.

<a name="see-also"></a>

# See Also


**grpck**(8),
**login.defs**(5),
**pwck**(8).
