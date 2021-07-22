# pam_pwhistory(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_pwhistory - PAM module to remember last passwords

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_pwhistory.so&nbsp;'u pam_pwhistory.so [debug] [use_authtok] [enforce_for_root] [remember=N] [retry=N] [authtok_type=STRING]
```

<a name="description"></a>

# Description


This module saves the last passwords for each user in order to force password change history and keep the user from alternating between the same password too frequently.

This module does not work together with kerberos. In general, it does not make much sense to use this module in conjunction with NIS or LDAP, since the old passwords are stored on the local machine and are not available on another machine for password history checking.

<a name="options"></a>

# Options


**debug**
Turns on debugging via
**syslog**(3).

**use\_authtok**
When password changing enforce the module to use the new password provided by a previously stacked
**password**
module (this is used in the example of the stacking of the
**pam\_cracklib**
module documented below).

**enforce\_for\_root**
If this option is set, the check is enforced for root, too.

**remember=****N**
The last
_N_
passwords for each user are saved in
/etc/security/opasswd. The default is
_10_. Value of
_0_
makes the module to keep the existing contents of the
opasswd
file unchanged.

**retry=****N**
Prompt user at most
_N_
times before returning with error. The default is
_1_.

**authtok\_type=****STRING**
See
**pam\_get\_authtok**(3)
for more details.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**password**
module type is provided.

<a name="return-values"></a>

# Return Values


PAM_AUTHTOK_ERR
No new password was entered, the user aborted password change or new password couldnt be set.

PAM_IGNORE
Password history was disabled.

PAM_MAXTRIES
Password was rejected too often.

PAM_USER_UNKNOWN
User is not known to system.

<a name="examples"></a>

# Examples


An example password section would be:

.if n \{.RS 4
.\}
    #%PAM-1.0
    password     required       pam_pwhistory.so
    password     required       pam_unix.so        use_authtok
          
.if n \{.RE
.\}

In combination with
**pam\_cracklib**:

.if n \{.RS 4
.\}
    #%PAM-1.0
    password     required       pam_cracklib.so    retry=3
    password     required       pam_pwhistory.so   use_authtok
    password     required       pam_unix.so        use_authtok
          
.if n \{.RE
.\}


<a name="files"></a>

# Files


/etc/security/opasswd
File with password history

<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)
**pam\_get\_authtok**(3)

<a name="author"></a>

# Author


pam_pwhistory was written by Thorsten Kukuk &lt;[kukuk@thkukuk.de](mailto:kukuk@thkukuk.de)&gt;
