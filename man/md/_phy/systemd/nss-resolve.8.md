# nss\-resolve(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nss-resolve, libnss_resolve.so.2 - Provide hostname resolution via systemd-resolved.service

<a name="synopsis"></a>

# Synopsis

```

 libnss_resolve.so.2
```

<a name="description"></a>

# Description


**nss-resolve**
is a plug-in module for the GNU Name Service Switch (NSS) functionality of the GNU C Library (**glibc**) enabling it to resolve host names via the
**systemd-resolved**(8)
local network name resolution service. It replaces the
**nss-dns**
plug-in module that traditionally resolves hostnames via DNS.

To activate the NSS module, add
"resolve"
to the line starting with
"hosts:"
in
/etc/nsswitch.conf. Specifically, it is recommended to place
"resolve"
early in
/etc/nsswitch.confs
"hosts:"
line (but after the
"files"
or
"mymachines"
entries), right before the
"dns"
entry if it exists, followed by
"[!UNAVAIL=return]", to ensure DNS queries are always routed via
**systemd-resolved**(8)
if it is running, but are routed to
**nss-dns**
if this service is not available.

Note that
**systemd-resolved**
will synthesize DNS resource records in a few cases, for example for
"localhost"
and the current hostname, see
**systemd-resolved**(8)
for the full list. This duplicates the functionality of
**nss-myhostname**(8), but it is still recommended (see examples below) to keep
**nss-myhostname**
configured in
/etc/nsswitch.conf, to keep those names resolveable if
**systemd-resolved**
is not running.

<a name="example"></a>

# Example


Here is an example
/etc/nsswitch.conf
file that enables
**nss-resolve**
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
**systemd-resolved**(8),
**nss-systemd**(8),
**nss-myhostname**(8),
**nss-mymachines**(8),
**nsswitch.conf**(5)
