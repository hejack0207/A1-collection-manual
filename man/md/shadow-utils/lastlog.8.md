# lastlog(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

lastlog - reports the most recent login of all users or of a given user

<a name="synopsis"></a>

# Synopsis

```
.HP \w'lastlog&nbsp;'u lastlog [options]
```

<a name="description"></a>

# Description


**lastlog**
formats and prints the contents of the last login log
/var/log/lastlog
file. The
_login-name_,
_port_, and
_last login time_
will be printed. The default (no flags) causes lastlog entries to be printed, sorted by their order in
/etc/passwd.

<a name="options"></a>

# Options


The options which apply to the
**lastlog**
command are:

**-b**, **--before**&nbsp;_DAYS_
Print only lastlog records older than
_DAYS_.

**-C**, **--clear**
Clear lastlog record of a user. This option can be used only together with
**-u**
(**--user**)).

**-h**, **--help**
Display help message and exit.

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

**-S**, **--set**
Set lastlog record of a user to the current time. This option can be used only together with
**-u**
(**--user**)).

**-t**, **--time**&nbsp;_DAYS_
Print the lastlog records more recent than
_DAYS_.

**-u**, **--user**&nbsp;_LOGIN_|_RANGE_
Print the lastlog record of the specified user(s).

The users can be specified by a login name, a numerical user ID, or a
_RANGE_
of users. This
_RANGE_
of users can be specified with a min and max values (_UID\_MIN-UID\_MAX_), a max value (_-UID\_MAX_), or a min value (_UID\_MIN-_).

If the user has never logged in the message
_** Never logged in**_
will be displayed instead of the port and time.

Only the entries for the current users of the system will be displayed. Other entries may exist for users that were deleted previously.

<a name="note"></a>

# Note


The
lastlog
file is a database which contains info on the last login of each user. You should not rotate it. It is a sparse file, so its size on the disk is usually much smaller than the one shown by "**ls -l**" (which can indicate a really big file if you have in
passwd
users with a high UID). You can display its real size with "**ls -s**".

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

<a name="files"></a>

# Files


/var/log/lastlog
Database times of previous user logins.

<a name="caveats"></a>

# Caveats


Large gaps in UID numbers will cause the lastlog program to run longer with no output to the screen (i.e. if in lastlog database there is no entries for users with UID between 170 and 800 lastlog will appear to hang as it processes entries with UIDs 171-799).
