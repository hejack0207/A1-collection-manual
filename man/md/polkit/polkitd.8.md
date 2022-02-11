# polkitd(8)

polkit, May 2009

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

polkitd - The polkit system daemon

<a name="synopsis"></a>

# Synopsis

```
.HP \w'polkitd&nbsp;'u polkitd
```

<a name="description"></a>

# Description


**polkitd**
provides the
_org.freedesktop.PolicyKit1_
D-Bus service on the system message bus. Users or administrators should never need to start this daemon as it will be automatically started by
**dbus-daemon**(1)
or
**systemd**(1)
whenever an application calls into the service.

**polkitd**
must be started with superuser privileges but drops privileges early by switching to the unprivileged
_polkitd_
system user.

See the
**polkit**(8)
man page for more information.

<a name="author"></a>

# Author


Written by David Zeuthen
&lt;[davidz@redhat.com](mailto:davidz@redhat.com)&gt;
with a lot of help from many others.

<a name="bugs"></a>

# Bugs


Please send bug reports to either the distribution or the polkit-devel mailing list, see the link
\m[blue]**http://lists.freedesktop.org/mailman/listinfo/polkit-devel**\m[]
on how to subscribe.

<a name="see-also"></a>

# See Also


**polkit**(8),
**pkaction**(1),
**pkcheck**(1),
**pkexec**(1),
**pkttyagent**(1),
**dbus-daemon**(1),
**systemd**(1)
