# pam_sepermit(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_sepermit - PAM module to allow/deny login depending on SELinux enforcement state

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_sepermit.so&nbsp;'u pam_sepermit.so [debug] [conf=/path/to/config/file]
```

<a name="description"></a>

# Description


The pam_sepermit module allows or denies login depending on SELinux enforcement state.

When the user which is logging in matches an entry in the config file he is allowed access only when the SELinux is in enforcing mode. Otherwise he is denied access. For users not matching any entry in the config file the pam_sepermit module returns PAM_IGNORE return value.

The config file contains a list of user names one per line with optional arguments. If the
_name_
is prefixed with
_@_
character it means that all users in the group
_name_
match. If it is prefixed with a
_%_
character the SELinux user is used to match against the
_name_
instead of the account name. Note that when SELinux is disabled the SELinux user assigned to the account cannot be determined. This means that such entries are never matched when SELinux is disabled and pam_sepermit will return PAM_IGNORE.

See
**sepermit.conf**(5)
for details.

<a name="options"></a>

# Options


**debug**
Turns on debugging via
**syslog**(3).

**conf=****/path/to/config/file**
Path to alternative config file overriding the default.

<a name="module-types-provided"></a>

# Module Types Provided


The
**auth**
and
**account**
module types are provided.

<a name="return-values"></a>

# Return Values


PAM_AUTH_ERR
SELinux is disabled or in the permissive mode and the user matches.

PAM_SUCCESS
SELinux is in the enforcing mode and the user matches.

PAM_IGNORE
The user does not match any entry in the config file.

PAM_USER_UNKNOWN
The module was unable to determine the users name.

PAM_SERVICE_ERR
Error during reading or parsing the config file.

<a name="files"></a>

# Files


/etc/security/sepermit.conf
Default configuration file

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    auth     [success=done ignore=ignore default=bad] pam_sepermit.so
    auth     required  pam_unix.so
    account  required  pam_unix.so
    session  required  pam_permit.so
        
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**sepermit.conf**(5),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)
**selinux**(8)

<a name="author"></a>

# Author


pam_sepermit and this manual page were written by Tomas Mraz &lt;[tmraz@redhat.com](mailto:tmraz@redhat.com)&gt;.
