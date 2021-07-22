# pwhistory_helper(8)

Linux-PAM Manual, 08/04/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pwhistory_helper - Helper binary that transfers password hashes from passwd or shadow to opasswd

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pwhistory_helper&nbsp;'u pwhistory_helper [...]
```

<a name="description"></a>

# Description


_pwhistory\_helper_
is a helper program for the
_pam\_pwhistory_
module that transfers password hashes from passwd or shadow file to the opasswd file and checks a password supplied by user against the existing hashes in the opasswd file.

The purpose of the helper is to enable tighter confinement of login and password changing services. The helper is thus called only when SELinux is enabled on the system.

The interface of the helper - command line options, and input/output data format are internal to the
_pam\_pwhistory_
module and it should not be called directly from applications.

<a name="see-also"></a>

# See Also


**pam\_pwhistory**(8)

<a name="author"></a>

# Author


Written by Tomas Mraz based on the code originally in
_pam_pwhistory and pam\_unix_
modules.
