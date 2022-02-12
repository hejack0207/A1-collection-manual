# genhomedircon(8) - generate SELinux file context configuration entries for user home directories

Security Enhanced Linux, Sep 2011


<a name="description"></a>

# Description

**genhomedircon**
is a script that executes
**semodule**
to rebuild the currently active SELinux policy (without reloading it) and to create the
labels for each user home directory based on directory paths returned by calls to getpwent().

The latter functionality depends on the "usepasswd" parameter being set to "true" (default)
in /etc/selinux/semanage.conf.

This script is usually executed by
**semanage**
although this default behavior can be optionally modified by setting to "true" the
"disable-genhomedircon" in /etc/selinux/semanage.conf.


<a name="author"></a>

# Author

This manual page was written by
_Dan Walsh &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;_


<a name="see-also"></a>

# See Also

semanage.conf(5), semodule(8), semanage(8), getpwent(3), getpwent_r(3)
