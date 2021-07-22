# unix_chkpwd(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

unix_chkpwd - Helper binary that verifies the password of the current user

<a name="synopsis"></a>

# Synopsis

```
.HP \w'unix_chkpwd&nbsp;'u unix_chkpwd [...]
```

<a name="description"></a>

# Description


_unix\_chkpwd_
is a helper program for the
_pam\_unix_
module that verifies the password of the current user. It also checks password and account expiration dates in
_shadow_. It is not intended to be run directly from the command line and logs a security violation if done so.

It is typically installed setuid root or setgid shadow.

The interface of the helper - command line options, and input/output data format are internal to the
_pam\_unix_
module and it should not be called directly from applications.

<a name="see-also"></a>

# See Also


**pam\_unix**(8)

<a name="author"></a>

# Author


Written by Andrew Morgan and other various people.
