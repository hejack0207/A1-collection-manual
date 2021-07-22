# pam_listfile(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_listfile - deny or allow services based on an arbitrary file

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_listfile.so&nbsp;'u pam_listfile.so item=[tty|user|rhost|ruser|group|shell] sense=[allow|deny] file=/path/filename onerr=[succeed|fail] [apply=[user|@group]] [quiet]
```

<a name="description"></a>

# Description


pam_listfile is a PAM module which provides a way to deny or allow services based on an arbitrary file.

The module gets the
**item**
of the type specified --
_user_
specifies the username,
_PAM\_USER_; tty specifies the name of the terminal over which the request has been made,
_PAM\_TTY_; rhost specifies the name of the remote host (if any) from which the request was made,
_PAM\_RHOST_; and ruser specifies the name of the remote user (if available) who made the request,
_PAM\_RUSER_
-- and looks for an instance of that item in the
**file=****filename**.
filename
contains one line per item listed. If the item is found, then if
**sense=****allow**,
_PAM\_SUCCESS_
is returned, causing the authorization request to succeed; else if
**sense=****deny**,
_PAM\_AUTH\_ERR_
is returned, causing the authorization request to fail.

If an error is encountered (for instance, if
filename
does not exist, or a poorly-constructed argument is encountered), then if
_onerr=succeed_,
_PAM\_SUCCESS_
is returned, otherwise if
_onerr=fail_,
_PAM\_AUTH\_ERR_
or
_PAM\_SERVICE\_ERR_
(as appropriate) will be returned.

An additional argument,
**apply=**, can be used to restrict the application of the above to a specific user (**apply=****username**) or a given group (**apply=****@groupname**). This added restriction is only meaningful when used with the
_tty_,
_rhost_
and
_shell_
items.

Besides this last one, all arguments should be specified; do not count on any default behavior.

No credentials are awarded by this module.

<a name="options"></a>

# Options



**item=[tty|user|rhost|ruser|group|shell]**
What is listed in the file and should be checked for.

**sense=[allow|deny]**
Action to take if found in file, if the item is NOT found in the file, then the opposite action is requested.

**file=****/path/filename**
File containing one item per line. The file needs to be a plain file and not world writable.

**onerr=[succeed|fail]**
What to do if something weird happens like being unable to open the file.

**apply=[****user****|****@group****]**
Restrict the user class for which the restriction apply. Note that with
**item=[user|ruser|group]**
this does not make sense, but for
**item=[tty|rhost|shell]**
it have a meaning.

**quiet**
Do not treat service refusals or missing list files as errors that need to be logged.

<a name="module-types-provided"></a>

# Module Types Provided


All module types (**auth**,
**account**,
**password**
and
**session**) are provided.

<a name="return-values"></a>

# Return Values



PAM_AUTH_ERR
Authentication failure.

PAM_BUF_ERR
Memory buffer error.

PAM_IGNORE
The rule does not apply to the
**apply**
option.

PAM_SERVICE_ERR
Error in service module.

PAM_SUCCESS
Success.

<a name="examples"></a>

# Examples


Classic ftpusers\*(Aq authentication can be implemented with this entry in
/etc/pam.d/ftpd:

.if n \{.RS 4
.\}
    #
    # deny ftp-access to users listed in the /etc/ftpusers file
    #
    auth    required       pam_listfile.so e
            onerr=succeed item=user sense=deny file=/etc/ftpusers
          
.if n \{.RE
.\}

Note, users listed in
/etc/ftpusers
file are (counterintuitively)
_not_
allowed access to the ftp service.

To allow login access only for certain users, you can use a
/etc/pam.d/login
entry like this:

.if n \{.RS 4
.\}
    #
    # permit login to users listed in /etc/loginusers
    #
    auth    required       pam_listfile.so e
            onerr=fail item=user sense=allow file=/etc/loginusers
          
.if n \{.RE
.\}

For this example to work, all users who are allowed to use the login service should be listed in the file
/etc/loginusers. Unless you are explicitly trying to lock out root, make sure that when you do this, you leave a way for root to log in, either by listing root in
/etc/loginusers, or by listing a user who is able to
_su_
to the root account.

<a name="see-also"></a>

# See Also


**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_listfile was written by Michael K. Johnson &lt;[johnsonm@redhat.com](mailto:johnsonm@redhat.com)&gt; and Elliot Lee &lt;sopwith@cuc.edu&gt;.
