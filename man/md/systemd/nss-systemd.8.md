# nss\-systemd(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nss-systemd, libnss_systemd.so.2 - Provide UNIX user and group name resolution for dynamic users and groups.

<a name="synopsis"></a>

# Synopsis

```

 libnss_systemd.so.2
```

<a name="description"></a>

# Description


**nss-systemd**
is a plug-in module for the GNU Name Service Switch (NSS) functionality of the GNU C Library (**glibc**), providing UNIX user and group name resolution for dynamic users and groups allocated through the
_DynamicUser=_
option in systemd unit files. See
**systemd.exec**(5)
for details on this option.

This module also ensures that the root and nobody users and groups (i.e. the users/groups with the UIDs/GIDs 0 and 65534) remain resolvable at all times, even if they arent listed in
/etc/passwd
or
/etc/group, or if these files are missing.

To activate the NSS module, add
"systemd"
to the lines starting with
"passwd:"
and
"group:"
in
/etc/nsswitch.conf.

It is recommended to place
"systemd"
after the
"files"
or
"compat"
entry of the
/etc/nsswitch.conf
lines so that
/etc/passwd
and
/etc/group
based mappings take precedence.

<a name="example"></a>

# Example


Here is an example
/etc/nsswitch.conf
file that enables
**nss-systemd**
correctly:

.if n \{.RS 4
.\}
    passwd:         compat mymachines systemd
    group:          compat mymachines systemd
    shadow:         compat
    
    hosts:          files mymachines resolve [!UNAVAIL=return] dns myhostname
    networks:       files
    
    protocols:      db files
    services:       db files
    ethers:         db files
    rpc:            db files
    
    netgroup:       nis
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.exec**(5),
**nss-resolve**(8),
**nss-myhostname**(8),
**nss-mymachines**(8),
**nsswitch.conf**(5),
**getent**(1)
