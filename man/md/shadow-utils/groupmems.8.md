# groupmems(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

groupmems - administer members of a users primary group

<a name="synopsis"></a>

# Synopsis

```
.HP \w'groupmems&nbsp;'u groupmems -a&nbsp;user_name | -d&nbsp;user_name | [-g&nbsp;group_name] | -l | -p 
```

<a name="description"></a>

# Description


The
**groupmems**
command allows a user to administer their own group membership list without the requirement of superuser privileges. The
**groupmems**
utility is for systems that configure its users to be in their own name sake primary group (i.e., guest / guest).

Only the superuser, as administrator, can use
**groupmems**
to alter the memberships of other groups.

<a name="options"></a>

# Options


The options which apply to the
**groupmems**
command are:

**-a**, **--add**&nbsp;_user\_name_
Add a user to the group membership list.

If the
/etc/gshadow
file exist, and the group has no entry in the
/etc/gshadow
file, a new entry will be created.

**-d**, **--delete**&nbsp;_user\_name_
Delete a user from the group membership list.

If the
/etc/gshadow
file exist, the user will be removed from the list of members and administrators of the group.

If the
/etc/gshadow
file exist, and the group has no entry in the
/etc/gshadow
file, a new entry will be created.

**-g**, **--group**&nbsp;_group\_name_
The superuser can specify which group membership list to modify.

**-h**, **--help**
Display help message and exit.

**-l**, **--list**
List the group membership list.

**-p**, **--purge**
Purge all users from the group membership list.

If the
/etc/gshadow
file exist, and the group has no entry in the
/etc/gshadow
file, a new entry will be created.

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

<a name="setup"></a>

# Setup


In this operating system the
**groupmems**
executable is not setuid and regular users cannot use it to manipulate the membership of their own group.

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
secure group account information

<a name="see-also"></a>

# See Also


**chfn**(1),
**chsh**(1),
**passwd**(1),
**groupadd**(8),
**groupdel**(8),
**useradd**(8),
**userdel**(8),
**usermod**(8).
