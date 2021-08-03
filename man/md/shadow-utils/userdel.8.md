# userdel(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

userdel - delete a user account and related files

<a name="synopsis"></a>

# Synopsis

```
.HP \w'userdel&nbsp;'u userdel [options] LOGIN
```

<a name="description"></a>

# Description


The
**userdel**
command modifies the system account files, deleting all entries that refer to the user name
_LOGIN_. The named user must exist.

<a name="options"></a>

# Options


The options which apply to the
**userdel**
command are:

**-f**, **--force**
This option forces the removal of the user account, even if the user is still logged in. It also forces
**userdel**
to remove the users home directory and mail spool, even if another user uses the same home directory or if the mail spool is not owned by the specified user. If
**USERGROUPS\_ENAB**
is defined to
_yes_
in
/etc/login.defs
and if a group exists with the same name as the deleted user, then this group will be removed, even if it is still the primary group of another user.

_Note:_
This option is dangerous and may leave your system in an inconsistent state.

**-h**, **--help**
Display help message and exit.

**-r**, **--remove**
Files in the users home directory will be removed along with the home directory itself and the user\*(Aqs mail spool. Files located in other file systems will have to be searched for and deleted manually.

The mail spool is defined by the
**MAIL\_DIR**
variable in the
login.defs
file.

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

**-Z**, **--selinux-user**
Remove any SELinux user mapping for the users login.

<a name="configuration"></a>

# Configuration


The following configuration variables in
/etc/login.defs
change the behavior of this tool:

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

**USERDEL\_CMD** (string)
If defined, this command is run when removing a user. It should remove any at/cron/print jobs etc. owned by the user to be removed (passed as the first argument).

The return code of the script is not taken into account.

Here is an example script, which removes the users cron, at and print jobs:

.if n \{.RS 4
.\}
    #! /bin/sh
    
    # Check for the required argument.
    if [ $# != 1 ]; then
    	echo "Usage: $0 username"
    	exit 1
    fi
    
    # Remove cron jobs.
    crontab -r -u $1
    
    # Remove at jobs.
    # Note that it will remove any jobs owned by the same UID,
    # even if it was shared by a different username.
    AT_SPOOL_DIR=/var/spool/cron/atjobs
    find $AT_SPOOL_DIR -name "[^.]*" -type f -user $1 -delete e;
    
    # Remove print jobs.
    lprm $1
    
    # All done.
    exit 0
          
.if n \{.RE
.\}


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


/etc/group
Group account information.

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

<a name="exit-values"></a>

# Exit Values


The
**userdel**
command exits with the following values:

_0_
success

_1_
cant update password file

_2_
invalid command syntax

_6_
specified user doesnt exist

_8_
user currently logged in

_10_
cant update group file

_12_
cant remove home directory

<a name="caveats"></a>

# Caveats


**userdel**
will not allow you to remove an account if there are running processes which belong to this account. In that case, you may have to kill those processes or lock the users password or account and remove the account later. The
**-f**
option can force the deletion of this account.

You should manually check all file systems to ensure that no files remain owned by this user.

You may not remove any NIS attributes on a NIS client. This must be performed on the NIS server.

If
**USERGROUPS\_ENAB**
is defined to
_yes_
in
/etc/login.defs,
**userdel**
will delete the group with the same name as the user. To avoid inconsistencies in the passwd and group databases,
**userdel**
will check that this group is not used as a primary group for another user, and will just warn without deleting the group otherwise. The
**-f**
option can force the deletion of this group.

<a name="see-also"></a>

# See Also


**chfn**(1),
**chsh**(1),
**passwd**(1),
**login.defs**(5),
**gpasswd**(8),
**groupadd**(8),
**groupdel**(8),
**groupmod**(8),
**subgid**(5), **subuid**(5),
**useradd**(8),
**usermod**(8).
