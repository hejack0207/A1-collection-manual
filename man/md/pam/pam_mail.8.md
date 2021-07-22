# pam_mail(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_mail - Inform about available mail

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_mail.so&nbsp;'u pam_mail.so [close] [debug] [dir=maildir] [empty] [hash=count] [noenv] [nopen] [quiet] [standard]
```

<a name="description"></a>

# Description


The pam_mail PAM module provides the "you have new mail" service to the user. It can be plugged into any application that has credential or session hooks. It gives a single message indicating the
_newness_
of any mail it finds in the users mail folder. This module also sets the PAM environment variable,
**MAIL**, to the users mail directory.

If the mail spool file (be it
/var/mail/$USER
or a pathname given with the
**dir=**
parameter) is a directory then pam_mail assumes it is in the
_Maildir_
format.

<a name="options"></a>

# Options



**close**
Indicate if the user has any mail also on logout.

**debug**
Print debug information.

**dir=****maildir**
Look for the users mail in an alternative location defined by
maildir/&lt;login&gt;. The default location for mail is
/var/mail/&lt;login&gt;. Note, if the supplied
maildir
is prefixed by a ~\*(Aq, the directory is interpreted as indicating a file in the user\*(Aqs home directory.

**empty**
Also print message if user has no mail.

**hash=****count**
Mail directory hash depth. For example, a
_hashcount_
of 2 would make the mail file be
/var/spool/mail/u/s/user.

**noenv**
Do not set the
**MAIL**
environment variable.

**nopen**
Dont print any mail information on login. This flag is useful to get the
**MAIL**
environment variable set, but to not display any information about it.

**quiet**
Only report when there is new mail.

**standard**
Old style "You have..." format which doesnt show the mail spool being used. This also implies "empty".

<a name="module-types-provided"></a>

# Module Types Provided


The
**session**
and
**auth**
(on establishment and deletion of credentials) module types are provided.

<a name="return-values"></a>

# Return Values


PAM_BUF_ERR
Memory buffer error.

PAM_SERVICE_ERR
Badly formed arguments.

PAM_SUCCESS
Success.

PAM_USER_UNKNOWN
User not known.

<a name="examples"></a>

# Examples


Add the following line to
/etc/pam.d/login
to indicate that the user has new mail when they login to the system.

.if n \{.RS 4
.\}
    session  optional  pam_mail.so standard
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_mail was written by Andrew G. Morgan &lt;[morgan@kernel.org](mailto:morgan@kernel.org)&gt;.
