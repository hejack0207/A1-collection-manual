# unix_update(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

unix_update - Helper binary that updates the password of a given user

<a name="synopsis"></a>

# Synopsis

```
.HP \w'unix_update&nbsp;'u unix_update [...]
```

<a name="description"></a>

# Description


_unix\_update_
is a helper program for the
_pam\_unix_
module that updates the password of a given user. It is not intended to be run directly from the command line and logs a security violation if done so.

The purpose of the helper is to enable tighter confinement of login and password changing services. The helper is thus called only when SELinux is enabled on the system.

The interface of the helper - command line options, and input/output data format are internal to the
_pam\_unix_
module and it should not be called directly from applications.

<a name="see-also"></a>

# See Also


**pam\_unix**(8)

<a name="author"></a>

# Author


Written by Tomas Mraz and other various people.
