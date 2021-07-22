# pam_lastlog(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_lastlog - PAM module to display date of last login and perform inactive account lock out

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_lastlog.so&nbsp;'u pam_lastlog.so [debug] [silent] [never] [nodate] [nohost] [noterm] [nowtmp] [noupdate] [showfailed] [inactive=<days>] [unlimited]
```

<a name="description"></a>

# Description


pam_lastlog is a PAM module to display a line of information about the last login of the user. In addition, the module maintains the
/var/log/lastlog
file.

Some applications may perform this function themselves. In such cases, this module is not necessary.

The module checks
**LASTLOG\_UID\_MAX**
option in
/etc/login.defs
and does not update or display last login records for users with UID higher than its value. If the option is not present or its value is invalid, no user ID limit is applied.

If the module is called in the auth or account phase, the accounts that were not used recently enough will be disallowed to log in. The check is not performed for the root account so the root is never locked out. It is also not performed for users with UID higher than the
**LASTLOG\_UID\_MAX**
value.

<a name="options"></a>

# Options


**debug**
Print debug information.

**silent**
Dont inform the user about any previous login, just update the
/var/log/lastlog
file. This option does not affect display of bad login attempts.

**never**
If the
/var/log/lastlog
file does not contain any old entries for the user, indicate that the user has never previously logged in with a welcome message.

**nodate**
Dont display the date of the last login.

**noterm**
Dont display the terminal name on which the last login was attempted.

**nohost**
Dont indicate from which host the last login was attempted.

**nowtmp**
Dont update the wtmp entry.

**noupdate**
Dont update any file.

**showfailed**
Display number of failed login attempts and the date of the last failed attempt from btmp. The date is not displayed when
**nodate**
is specified.

**inactive=&lt;days&gt;**
This option is specific for the auth or account phase. It specifies the number of days after the last login of the user when the user will be locked out by the module. The default value is 90.

**unlimited**
If the
_fsize_
limit is set, this option can be used to override it, preventing failures on systems with large UID values that lead lastlog to become a huge sparse file.

<a name="module-types-provided"></a>

# Module Types Provided


The
**auth**
and
**account**
module type allows one to lock out users who did not login recently enough. The
**session**
module type is provided for displaying the information about the last login and/or updating the lastlog and wtmp files.

<a name="return-values"></a>

# Return Values



PAM_SUCCESS
Everything was successful.

PAM_SERVICE_ERR
Internal service module error.

PAM_USER_UNKNOWN
User not known.

PAM_AUTH_ERR
User locked out in the auth or account phase due to inactivity.

PAM_IGNORE
There was an error during reading the lastlog file in the auth or account phase and thus inactivity of the user cannot be determined.

<a name="examples"></a>

# Examples


Add the following line to
/etc/pam.d/login
to display the last login time of an user:

.if n \{.RS 4
.\}
        session  required  pam_lastlog.so nowtmp
          
.if n \{.RE
.\}

To reject the user if he did not login during the previous 50 days the following line can be used:

.if n \{.RS 4
.\}
        auth  required  pam_lastlog.so inactive=50
          
.if n \{.RE
.\}

<a name="files"></a>

# Files


/var/log/lastlog
Lastlog logging file

<a name="see-also"></a>

# See Also


**limits.conf**(5),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_lastlog was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.

Inactive account lock out added by Tomáš Mráz &lt;[tm@t8m.info](mailto:tm@t8m.info)&gt;.
