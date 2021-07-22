# pam_nologin(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_nologin - Prevent non-root users from login

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_nologin.so&nbsp;'u pam_nologin.so [file=/path/nologin] [successok]
```

<a name="description"></a>

# Description


pam_nologin is a PAM module that prevents users from logging into the system when
/var/run/nologin
or
/etc/nologin
exists. The contents of the file are displayed to the user. The pam_nologin module has no effect on the root users ability to log in.

<a name="options"></a>

# Options


**file=****/path/nologin**
Use this file instead the default
/var/run/nologin
or
/etc/nologin.

**successok**
Return PAM_SUCCESS if no file exists, the default is PAM_IGNORE.

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
The user is not root and
/etc/nologin
exists, so the user is not permitted to log in.

PAM_BUF_ERR
Memory buffer error.

PAM_IGNORE
This is the default return value.

PAM_SUCCESS
Success: either the user is root or the nologin file does not exist.

PAM_USER_UNKNOWN
User not known to the underlying authentication module.

<a name="examples"></a>

# Examples


The suggested usage for
/etc/pam.d/login
is:

.if n \{.RS 4
.\}
    auth  required  pam_nologin.so
          
.if n \{.RE
.\}


<a name="notes"></a>

# Notes


In order to make this module effective, all login methods should be secured by it. It should be used as a
_required_
method listed before any
_sufficient_
methods in order to get standard Unix nologin semantics. Note, the use of
**successok**
module argument causes the module to return
_PAM\_SUCCESS_
and as such would break such a configuration - failing
_sufficient_
modules would lead to a successful login because the nologin module
_succeeded_.

<a name="see-also"></a>

# See Also


**nologin**(5),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_nologin was written by Michael K. Johnson &lt;[johnsonm@redhat.com](mailto:johnsonm@redhat.com)&gt;.
