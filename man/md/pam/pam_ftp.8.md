# pam_ftp(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_ftp - PAM module for anonymous access module

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_ftp.so&nbsp;'u pam_ftp.so [debug] [ignore] [users=XXX,YYY,...]
```

<a name="description"></a>

# Description


pam_ftp is a PAM module which provides a pluggable anonymous ftp mode of access.

This module intercepts the users name and password. If the name is
_ftp_
or
_anonymous_, the users password is broken up at the
_@_
delimiter into a
_PAM\_RUSER_
and a
_PAM\_RHOST_
part; these pam-items being set accordingly. The username (_PAM\_USER_) is set to
_ftp_. In this case the module succeeds. Alternatively, the module sets the
_PAM\_AUTHTOK_
item with the entered password and fails.

This module is not safe and easily spoofable.

<a name="options"></a>

# Options



**debug**
Print debug information.

**ignore**
Pay no attention to the email address of the user (if supplied).

**ftp=****XXX,YYY,...**
Instead of
_ftp_
or
_anonymous_, provide anonymous login to the comma separated list of users:
**XXX,YYY,...**. Should the applicant enter one of these usernames the returned username is set to the first in the list:
_XXX_.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**auth**
module type is provided.

<a name="return-values"></a>

# Return Values



PAM_SUCCESS
The authentication was successful.

PAM_USER_UNKNOWN
User not known.

<a name="examples"></a>

# Examples


Add the following line to
/etc/pam.d/ftpd
to handle ftp style anonymous login:

.if n \{.RS 4
.\}
    #
    # ftpd; add ftp-specifics. These lines enable anonymous ftp over
    #       standard UN*X access (the listfile entry blocks access to
    #       users listed in /etc/ftpusers)
    #
    auth    sufficient  pam_ftp.so
    auth    required    pam_unix.so use_first_pass
    auth    required    pam_listfile.so e
               onerr=succeed item=user sense=deny file=/etc/ftpusers
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_ftp was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
