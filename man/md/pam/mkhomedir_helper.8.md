# mkhomedir_helper(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

mkhomedir_helper - Helper binary that creates home directories

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mkhomedir_helper&nbsp;'u mkhomedir_helper {user} [umask&nbsp;[&nbsp;path-to-skel&nbsp;]]
```

<a name="description"></a>

# Description


_mkhomedir\_helper_
is a helper program for the
_pam\_mkhomedir_
module that creates home directories and populates them with contents of the specified skel directory.

The default value of
_umask_
is 0022 and the default value of
_path-to-skel_
is
_/etc/skel_.

The helper is separated from the module to not require direct access from login SELinux domains to the contents of user home directories. The SELinux domain transition happens when the module is executing the
_mkhomedir\_helper_.

The helper never touches home directories if they already exist.

<a name="see-also"></a>

# See Also


**pam\_mkhomedir**(8)

<a name="author"></a>

# Author


Written by Tomas Mraz based on the code originally in
_pam\_mkhomedir_
module.
