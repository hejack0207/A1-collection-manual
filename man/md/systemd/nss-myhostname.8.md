# nss\-myhostname(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nss-myhostname, libnss_myhostname.so.2 - Provide hostname resolution for the locally configured system hostname.

<a name="synopsis"></a>

# Synopsis

```

 libnss_myhostname.so.2
```

<a name="description"></a>

# Description


**nss-myhostname**
is a plug-in module for the GNU Name Service Switch (NSS) functionality of the GNU C Library (**glibc**), primarily providing hostname resolution for the locally configured system hostname as returned by
**gethostname**(2). The precise hostnames resolved by this module are:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The local, configured hostname is resolved to all locally configured IP addresses ordered by their scope, or — if none are configured — the IPv4 address 127.0.0.2 (which is on the local loopback) and the IPv6 address ::1 (which is the local host).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The hostnames
  "localhost"
  and
  "localhost.localdomain"
  (as well as any hostname ending in
  ".localhost"
  or
  ".localhost.localdomain") are resolved to the IP addresses 127.0.0.1 and ::1.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The hostname
  "_gateway"
  is resolved to all current default routing gateway addresses, ordered by their metric. This assigns a stable hostname to the current gateway, useful for referencing it independently of the current network configuration state.

Various software relies on an always-resolvable local hostname. When using dynamic hostnames, this is traditionally achieved by patching
/etc/hosts
at the same time as changing the hostname. This is problematic since it requires a writable
/etc
file system and is fragile because the file might be edited by the administrator at the same time. With
**nss-myhostname**
enabled, changing
/etc/hosts
is unnecessary, and on many systems, the file becomes entirely optional.

To activate the NSS modules, add
"myhostname"
to the line starting with
"hosts:"
in
/etc/nsswitch.conf.

It is recommended to place
"myhostname"
last in the
nsswitch.conf
"hosts:"
line to make sure that this mapping is only used as fallback, and that any DNS or
/etc/hosts
based mapping takes precedence.

<a name="example"></a>

# Example


Here is an example
/etc/nsswitch.conf
file that enables
**nss-myhostname**
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

To test, use
**glibc**s
**getent**
tool:

.if n \{.RS 4
.\}
    $ getent ahosts `hostname`
    ::1       STREAM omega
    ::1       DGRAM
    ::1       RAW
    127.0.0.2       STREAM
    127.0.0.2       DGRAM
    127.0.0.2       RAW
.if n \{.RE
.\}

In this case, the local hostname is
_omega_.

<a name="see-also"></a>

# See Also


**systemd**(1),
**nss-systemd**(8),
**nss-resolve**(8),
**nss-mymachines**(8),
**nsswitch.conf**(5),
**getent**(1)
