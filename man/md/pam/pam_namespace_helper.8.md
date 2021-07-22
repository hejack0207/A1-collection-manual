# pam_namespace_helper(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_namespace_helper - Helper binary that creates home directories

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_namespace_helper&nbsp;'u pam_namespace_helper
```

<a name="description"></a>

# Description


_pam\_namespace\_helper_
is a helper program for the
_pam\_namespace_
module that sets up a private namespace for a session with polyinstantiated directories. The helper ensures that the namespace mount points exist before they are started to be used for the polyinstantiated directories. Mount points for home directories (lines with $HOME) are not created.

_pam\_namespace\_helper_
should be run by systemd at system startup. It should also be run by the administrator after defining the polyinstantiated directories but before enabling them.

<a name="see-also"></a>

# See Also


**pam\_namespace**(8)

<a name="author"></a>

# Author


Written by Topi Miettinen.
