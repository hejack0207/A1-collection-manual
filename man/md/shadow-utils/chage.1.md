# chage(1)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

chage - change user password expiry information

<a name="synopsis"></a>

# Synopsis

```
.HP \w'chage&nbsp;'u chage [options] LOGIN
```

<a name="description"></a>

# Description


The
**chage**
command changes the number of days between password changes and the date of the last password change. This information is used by the system to determine when a user must change their password.

<a name="options"></a>

# Options


The options which apply to the
**chage**
command are:

**-d**, **--lastday**&nbsp;_LAST\_DAY_
Set the number of days since January 1st, 1970 when the password was last changed. The date may also be expressed in the format YYYY-MM-DD (or the format more commonly used in your area). If the
_LAST\_DAY_
is set to
_0_
the user is forced to change his password on the next log on.

**-E**, **--expiredate**&nbsp;_EXPIRE\_DATE_
Set the date or number of days since January 1, 1970 on which the users account will no longer be accessible. The date may also be expressed in the format YYYY-MM-DD (or the format more commonly used in your area). A user whose account is locked must contact the system administrator before being able to use the system again.

For example the following can be used to set an account to expire in 180 days:

.if n \{.RS 4
.\}
    	    chage -E $(date -d +180days +%Y-%m-%d)
    	  
.if n \{.RE
.\}

Passing the number
_-1_
as the
_EXPIRE\_DATE_
will remove an account expiration date.

**-h**, **--help**
Display help message and exit.

**-i**, **--iso8601**
When printing dates, use YYYY-MM-DD format.

**-I**, **--inactive**&nbsp;_INACTIVE_
Set the number of days of inactivity after a password has expired before the account is locked. The
_INACTIVE_
option is the number of days of inactivity. A user whose account is locked must contact the system administrator before being able to use the system again.

Passing the number
_-1_
as the
_INACTIVE_
will remove an accounts inactivity.

**-l**, **--list**
Show account aging information.

**-m**, **--mindays**&nbsp;_MIN\_DAYS_
Set the minimum number of days between password changes to
_MIN\_DAYS_. A value of zero for this field indicates that the user may change their password at any time.

**-M**, **--maxdays**&nbsp;_MAX\_DAYS_
Set the maximum number of days during which a password is valid. When
_MAX\_DAYS_
plus
_LAST\_DAY_
is less than the current day, the user will be required to change their password before being able to use their account. This occurrence can be planned for in advance by use of the
**-W**
option, which provides the user with advance warning.

Passing the number
_-1_
as
_MAX\_DAYS_
will remove checking a passwords validity.

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

**-W**, **--warndays**&nbsp;_WARN\_DAYS_
Set the number of days of warning before a password change is required. The
_WARN\_DAYS_
option is the number of days prior to the password expiring that a user will be warned their password is about to expire.

If none of the options are selected,
**chage**
operates in an interactive fashion, prompting the user with the current values for all of the fields. Enter the new value to change the field, or leave the line blank to use the current value. The current value is displayed between a pair of
_[ ]_
marks.

<a name="note"></a>

# Note


The
**chage**
program requires a shadow password file to be available.

The chage program will report only the information from the shadow password file. This implies that configuration from other sources (e.g. LDAP or empty password hash field from the passwd file) that affect the users login will not be shown in the chage output.

The
**chage**
program will also not report any inconsistency between the shadow and passwd files (e.g. missing x in the passwd file). The
**pwck**
can be used to check for this kind of inconsistencies.

The
**chage**
command is restricted to the root user, except for the
**-l**
option, which may be used by an unprivileged user to determine when their password or account is due to expire.

<a name="configuration"></a>

# Configuration


The following configuration variables in
/etc/login.defs
change the behavior of this tool:

<a name="files"></a>

# Files


/etc/passwd
User account information.

/etc/shadow
Secure user account information.

<a name="exit-values"></a>

# Exit Values


The
**chage**
command exits with the following values:

_0_
success

_1_
permission denied

_2_
invalid command syntax

_15_
cant find the shadow password file

<a name="see-also"></a>

# See Also


**passwd**(5),
**shadow**(5).
