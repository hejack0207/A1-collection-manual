# login\&.defs(5)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

login.defs - shadow password suite configuration

<a name="description"></a>

# Description


The
/etc/login.defs
file defines the site-specific configuration for the shadow password suite. This file is required. Absence of this file will not prevent system operation, but will probably result in undesirable operation.

This file is a readable text file, each line of the file describing one configuration parameter. The lines consist of a configuration name and value, separated by whitespace. Blank lines and comment lines are ignored. Comments are introduced with a "#" pound sign and the pound sign must be the first non-white character of the line.

Parameter values may be of four types: strings, booleans, numbers, and long numbers. A string is comprised of any printable characters. A boolean should be either the value
_yes_
or
_no_. An undefined boolean parameter or one with a value other than these will be given a
_no_
value. Numbers (both regular and long) may be either decimal values, octal values (precede the value with
_0_) or hexadecimal values (precede the value with
_0x_). The maximum value of the regular and long numeric parameters is machine-dependent.

Please note that the parameters in this configuration file control the behavior of the tools from the shadow-utils component. None of these tools uses the PAM mechanism, and the utilities that use PAM (such as the passwd command) should be configured elsewhere. The only values that affect PAM modules are
_ENCRYPT\_METHOD_
and
_SHA\_CRYPT\_MAX\_ROUNDS_
for pam_unix module,
_FAIL\_DELAY_
for pam_faildelay module, and
_UMASK_
for pam_umask module. Refer to pam(8) for more information.

The following configuration items are provided:

**CHFN\_AUTH** (boolean)
If
_yes_, the
**chfn**
program will require authentication before making any changes, unless run by the superuser.

**CHFN\_RESTRICT** (string)
This parameter specifies which values in the
_gecos_
field of the
/etc/passwd
file may be changed by regular users using the
**chfn**
program. It can be any combination of letters
_f_,
_r_,
_w_,
_h_, for Full name, Room number, Work phone, and Home phone, respectively. For backward compatibility,
_yes_
is equivalent to
_rwh_
and
_no_
is equivalent to
_frwh_. If not specified, only the superuser can make any changes. The most restrictive setting is better achieved by not installing
**chfn**
SUID.

**CHSH\_AUTH** (boolean)
If
_yes_, the
**chsh**
program will require authentication before making any changes, unless run by the superuser.

**CONSOLE** (string)
If defined, either full pathname of a file containing device names (one per line) or a ":" delimited list of device names. Root logins will be allowed only upon these devices.

If not defined, root will be allowed on any device.

The device should be specified without the /dev/ prefix.

**CONSOLE\_GROUPS** (string)
List of groups to add to the users supplementary groups set when logging in on the console (as determined by the CONSOLE setting). Default is none.

Use with caution - it is possible for users to gain permanent access to these groups, even when not logged in on the console.

**CREATE\_HOME** (boolean)
Indicate if a home directory should be created by default for new users.

This setting does not apply to system users, and can be overridden on the command line.

**DEFAULT\_HOME** (boolean)
Indicate if login is allowed if we cant cd to the home directory. Default is no.

If set to
_yes_, the user will login in the root (/) directory if it is not possible to cd to her home directory.

**ENCRYPT\_METHOD** (string)
This defines the system default encryption algorithm for encrypting passwords (if no algorithm are specified on the command line).

It can take one of these values:
_DES_
(default),
_MD5_, _SHA256_, _SHA512_.

Note: this parameter overrides the
**MD5\_CRYPT\_ENAB**
variable.

**ENV\_HZ** (string)
If set, it will be used to define the HZ environment variable when a user login. The value must be preceded by
_HZ=_. A common value on Linux is
_HZ=100_.

**ENV\_PATH** (string)
If set, it will be used to define the PATH environment variable when a regular user login. The value is a colon separated list of paths (for example
_/bin:/usr/bin_) and can be preceded by
_PATH=_. The default value is
_PATH=/bin:/usr/bin_.

**ENV\_SUPATH** (string)
If set, it will be used to define the PATH environment variable when the superuser login. The value is a colon separated list of paths (for example
_/sbin:/bin:/usr/sbin:/usr/bin_) and can be preceded by
_PATH=_. The default value is
_PATH=/sbin:/bin:/usr/sbin:/usr/bin_.

**ENV\_TZ** (string)
If set, it will be used to define the TZ environment variable when a user login. The value can be the name of a timezone preceded by
_TZ=_
(for example
_TZ=CST6CDT_), or the full path to the file containing the timezone specification (for example
/etc/tzname).

If a full path is specified but the file does not exist or cannot be read, the default is to use
_TZ=CST6CDT_.

**ENVIRON\_FILE** (string)
If this file exists and is readable, login environment will be read from it. Every line should be in the form name=value.

Lines starting with a # are treated as comment lines and ignored.

**ERASECHAR** (number)
Terminal ERASE character (_010_
= backspace,
_0177_
= DEL).

The value can be prefixed "0" for an octal value, or "0x" for an hexadecimal value.

**FAIL\_DELAY** (number)
Delay in seconds before being allowed another attempt after a login failure.

**FAILLOG\_ENAB** (boolean)
Enable logging and display of
/var/log/faillog
login failure info.

**FAKE\_SHELL** (string)
If set,
**login**
will execute this shell instead of the users shell specified in
/etc/passwd.

**FTMP\_FILE** (string)
If defined, login failures will be logged in this file in a utmp format.

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

**HUSHLOGIN\_FILE** (string)
If defined, this file can inhibit all the usual chatter during the login sequence. If a full pathname is specified, then hushed mode will be enabled if the users name or shell are found in the file. If not a full pathname, then hushed mode will be enabled if the file exists in the user\*(Aqs home directory.

**ISSUE\_FILE** (string)
If defined, this file will be displayed before each login prompt.

**KILLCHAR** (number)
Terminal KILL character (_025_
= CTRL/U).

The value can be prefixed "0" for an octal value, or "0x" for an hexadecimal value.

**LASTLOG\_ENAB** (boolean)
Enable logging and display of /var/log/lastlog login time info.

**LASTLOG\_UID\_MAX** (number)
Highest user ID number for which the lastlog entries should be updated. As higher user IDs are usually tracked by remote user identity and authentication services there is no need to create a huge sparse lastlog file for them.

No
**LASTLOG\_UID\_MAX**
option present in the configuration means that there is no user ID limit for writing lastlog entries.

**LOG\_OK\_LOGINS** (boolean)
Enable logging of successful logins.

**LOG\_UNKFAIL\_ENAB** (boolean)
Enable display of unknown usernames when login failures are recorded.

Note: logging unknown usernames may be a security issue if an user enter her password instead of her login name.

**LOGIN\_RETRIES** (number)
Maximum number of login retries in case of bad password.

**LOGIN\_STRING** (string)
The string used for prompting a password. The default is to use "Password: ", or a translation of that string. If you set this variable, the prompt will not be translated.

If the string contains
_%s_, this will be replaced by the users name.

**LOGIN\_TIMEOUT** (number)
Max time in seconds for login.

**MAIL\_CHECK\_ENAB** (boolean)
Enable checking and display of mailbox status upon login.

You should disable it if the shell startup files already check for mail ("mailx -e" or equivalent).

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

**MOTD\_FILE** (string)
If defined, ":" delimited list of "message of the day" files to be displayed upon login.

**NOLOGINS\_FILE** (string)
If defined, name of file whose presence will inhibit non-root logins. The contents of this file should be a message indicating why logins are inhibited.

**OBSCURE\_CHECKS\_ENAB** (boolean)
Enable additional checks upon password changes.

**PASS\_ALWAYS\_WARN** (boolean)
Warn about weak passwords (but still allow them) if you are root.

**PASS\_CHANGE\_TRIES** (number)
Maximum number of attempts to change password if rejected (too easy).

**PASS\_MAX\_DAYS** (number)
The maximum number of days a password may be used. If the password is older than this, a password change will be forced. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_MIN\_DAYS** (number)
The minimum number of days allowed between password changes. Any password changes attempted sooner than this will be rejected. If not specified, -1 will be assumed (which disables the restriction).

**PASS\_WARN\_AGE** (number)
The number of days warning given before a password expires. A zero means warning is given only upon the day of expiration, a negative value means no warning is given. If not specified, no warning will be provided.

**PASS\_MAX\_DAYS**,
**PASS\_MIN\_DAYS**
and
**PASS\_WARN\_AGE**
are only used at the time of account creation. Any changes to these settings wont affect existing accounts.

**PASS\_MAX\_LEN** (number), **PASS\_MIN\_LEN** (number)
Number of significant characters in the password for crypt().
**PASS\_MAX\_LEN**
is 8 by default. Dont change unless your crypt() is better. This is ignored if
**MD5\_CRYPT\_ENAB**
set to
_yes_.

**PORTTIME\_CHECKS\_ENAB** (boolean)
Enable checking of time restrictions specified in
/etc/porttime.

**QUOTAS\_ENAB** (boolean)
Enable setting of resource limits from
/etc/limits
and ulimit, umask, and niceness from the users passwd gecos field.

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

**SULOG\_FILE** (string)
If defined, all su activity is logged to this file.

**SU\_NAME** (string)
If defined, the command name to display when running "su -". For example, if this is defined as "su" then a "ps" will display the command is "-su". If not defined, then "ps" would display the name of the shell actually being run, e.g. something like "-sh".

**SU\_WHEEL\_ONLY** (boolean)
If
_yes_, the user must be listed as a member of the first gid 0 group in
/etc/group
(called
_root_
on most Linux systems) to be able to
**su**
to uid 0 accounts. If the group doesnt exist or is empty, no one will be able to
**su**
to uid 0.

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

**SYSLOG\_SG\_ENAB** (boolean)
Enable "syslog" logging of
**sg**
activity.

**SYSLOG\_SU\_ENAB** (boolean)
Enable "syslog" logging of
**su**
activity - in addition to sulog file logging.

**TTYGROUP** (string), **TTYPERM** (string)
The terminal permissions: the login tty will be owned by the
**TTYGROUP**
group, and the permissions will be set to
**TTYPERM**.

By default, the ownership of the terminal is set to the users primary group and the permissions are set to
_0600_.

**TTYGROUP**
can be either the name of a group or a numeric group identifier.

If you have a
**write**
program which is "setgid" to a special group which owns the terminals, define TTYGROUP to the group number and TTYPERM to 0620. Otherwise leave TTYGROUP commented out and assign TTYPERM to either 622 or 600.

**TTYTYPE\_FILE** (string)
If defined, file which maps tty line to TERM environment parameter. Each line of the file is in a format something like "vt100 tty01".

**UID\_MAX** (number), **UID\_MIN** (number)
Range of user IDs used for the creation of regular users by
**useradd**
or
**newusers**.

The default value for
**UID\_MIN**
(resp.
**UID\_MAX**) is 1000 (resp. 60000).

**ULIMIT** (number)
Default
**ulimit**
value.

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

<a name="cross-references"></a>

# Cross References


The following cross references show which programs in the shadow password suite use which parameters.

chgpasswd
ENCRYPT_METHOD MAX_MEMBERS_PER_GROUP MD5_CRYPT_ENAB
SHA_CRYPT_MAX_ROUNDS SHA_CRYPT_MIN_ROUNDS

chpasswd
ENCRYPT_METHOD MD5_CRYPT_ENAB
SHA_CRYPT_MAX_ROUNDS SHA_CRYPT_MIN_ROUNDS

gpasswd
ENCRYPT_METHOD MAX_MEMBERS_PER_GROUP MD5_CRYPT_ENAB
SHA_CRYPT_MAX_ROUNDS SHA_CRYPT_MIN_ROUNDS

groupadd
GID_MAX GID_MIN MAX_MEMBERS_PER_GROUP SYS_GID_MAX SYS_GID_MIN

groupdel
MAX_MEMBERS_PER_GROUP

groupmems
MAX_MEMBERS_PER_GROUP

groupmod
MAX_MEMBERS_PER_GROUP

grpck
MAX_MEMBERS_PER_GROUP

grpconv
MAX_MEMBERS_PER_GROUP

grpunconv
MAX_MEMBERS_PER_GROUP

lastlog
LASTLOG_UID_MAX

newgrp / sg
SYSLOG_SG_ENAB

newusers
ENCRYPT_METHOD GID_MAX GID_MIN MAX_MEMBERS_PER_GROUP MD5_CRYPT_ENAB HOME_MODE PASS_MAX_DAYS PASS_MIN_DAYS PASS_WARN_AGE
SHA_CRYPT_MAX_ROUNDS SHA_CRYPT_MIN_ROUNDS
SUB_GID_COUNT SUB_GID_MAX SUB_GID_MIN SUB_UID_COUNT SUB_UID_MAX SUB_UID_MIN SYS_GID_MAX SYS_GID_MIN SYS_UID_MAX SYS_UID_MIN UID_MAX UID_MIN UMASK

pwck
PASS_MAX_DAYS PASS_MIN_DAYS PASS_WARN_AGE

pwconv
PASS_MAX_DAYS PASS_MIN_DAYS PASS_WARN_AGE

useradd
CREATE_HOME GID_MAX GID_MIN HOME_MODE LASTLOG_UID_MAX MAIL_DIR MAX_MEMBERS_PER_GROUP PASS_MAX_DAYS PASS_MIN_DAYS PASS_WARN_AGE SUB_GID_COUNT SUB_GID_MAX SUB_GID_MIN SUB_UID_COUNT SUB_UID_MAX SUB_UID_MIN SYS_GID_MAX SYS_GID_MIN SYS_UID_MAX SYS_UID_MIN UID_MAX UID_MIN UMASK

userdel
MAIL_DIR MAIL_FILE MAX_MEMBERS_PER_GROUP USERDEL_CMD USERGROUPS_ENAB

usermod
LASTLOG_UID_MAX MAIL_DIR MAIL_FILE MAX_MEMBERS_PER_GROUP

<a name="see-also"></a>

# See Also


**login**(1),
**passwd**(1),
**su**(1),
**passwd**(5),
**shadow**(5),
**pam**(8).
