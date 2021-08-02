# systemd\&.dnssd(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.dnssd - DNS-SD configuration

<a name="synopsis"></a>

# Synopsis

```

 network_service.dnssd
```

<a name="description"></a>

# Description


DNS-SD setup is performed by
**systemd-resolved**(8).

The main network service file must have the extension
.dnssd; other extensions are ignored.

The
.dnssd
files are read from the files located in the system network directory
/usr/lib/systemd/dnssd, the volatile runtime network directory
/run/systemd/dnssd
and the local administration network directory
/etc/systemd/dnssd. All configuration files are collectively sorted and processed in lexical order, regardless of the directories in which they live. However, files with identical filenames replace each other. Files in
/etc
have the highest priority, files in
/run
take precedence over files with the same name in
/usr/lib. This can be used to override a system-supplied configuration file with a local file if needed.

Along with the network service file
foo.dnssd, a "drop-in" directory
foo.dnssd.d/
may exist. All files with the suffix
".conf"
from this directory will be parsed after the file itself is parsed. This is useful to alter or add configuration settings, without having to modify the main configuration file. Each drop-in file must have appropriate section headers.

In addition to
/etc/systemd/dnssd, drop-in
".d"
directories can be placed in
/usr/lib/systemd/dnssd
or
/run/systemd/dnssd
directories. Drop-in files in
/etc
take precedence over those in
/run
which in turn take precedence over those in
/usr/lib. Drop-in files under any of these directories take precedence over the main network service file wherever located. (Of course, since
/run
is temporary and
/usr/lib
is for vendors, it is unlikely drop-ins should be used in either of those places.)

<a name="service-section-options"></a>

# [Service] Section Options


The network service file contains a
"[Service]"
section, which specifies a discoverable network service announced in a local network with Multicast DNS broadcasts.

_Name=_
An instance name of the network service as defined in the section 4.1.1 of
\m[blue]**RFC 6763**\m[]\s-2\u[1]\d\s+2, e.g.
"webserver".

The option supports simple specifier expansion. The following expansions are understood:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Specifiers available**
.TS
allbox tab(:);
lB lB lB.
T{
Specifier
T}:T{
Meaning
T}:T{
Details
T}
.T&
l l l
l l l
l l l
l l l.
T{
"%m"
T}:T{
Machine ID
T}:T{
The machine ID of the running system, formatted as string. See **machine-id**(5) for more information.
T}
T{
"%b"
T}:T{
Boot ID
T}:T{
The boot ID of the running system, formatted as string. See **random**(4) for more information.
T}
T{
"%H"
T}:T{
Host name
T}:T{
The hostname of the running system.
T}
T{
"%v"
T}:T{
Kernel release
T}:T{
Identical to **uname -r** output.
T}
.TE


_Type=_
A type of the network service as defined in the section 4.1.2 of
\m[blue]**RFC 6763**\m[]\s-2\u[1]\d\s+2, e.g.
"_http._tcp".

_Port=_
An IP port number of the network service.

_Priority=_
A priority number set in SRV resource records corresponding to the network service.

_Weight=_
A weight number set in SRV resource records corresponding to the network service.

_TxtText=_
A whitespace-separated list of arbitrary key/value pairs conveying additional information about the named service in the corresponding TXT resource record, e.g.
"path=/portal/index.html". Keys and values can contain C-style escape sequences which get translated upon reading configuration files.

This option together with
_TxtData=_
may be specified more than once, in which case multiple TXT resource records will be created for the service. If the empty string is assigned to this option, the list is reset and all prior assignments will have no effect.

_TxtData=_
A whitespace-separated list of arbitrary key/value pairs conveying additional information about the named service in the corresponding TXT resource record where values are base64-encoded string representing any binary data, e.g.
"data=YW55IGJpbmFyeSBkYXRhCg==". Keys can contain C-style escape sequences which get translated upon reading configuration files.

This option together with
_TxtText=_
may be specified more than once, in which case multiple TXT resource records will be created for the service. If the empty string is assigned to this option, the list is reset and all prior assignments will have no effect.

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;HTTP service**

.if n \{.RS 4
.\}
    # /etc/systemd/dnssd/http.dnssd
    [Service]
    Name=%H
    Type=_http._tcp
    Port=80
    TxtText=path=/stats/index.html t=temperature_sensor
.if n \{.RE
.\}

This makes the http server running on the host discoverable in the local network given MulticastDNS is enabled on the network interface.

Now the utility
"resolvectl"
should be able to resolve the service to the hosts name:

.if n \{.RS 4
.\}
    $ resolvectl service meteo._http._tcp.local
    meteo._http._tcp.local: meteo.local:80 [priority=0, weight=0]
                            169.254.208.106%senp0s21f0u2u4
                            fe80::213:3bff:fe49:8aa%senp0s21f0u2u4
                            path=/stats/index.html
                            t=temperature_sensor
                            (meteo/_http._tcp/local)
    
    -- Information acquired via protocol mDNS/IPv6 in 4.0ms.
    -- Data is authenticated: yes
.if n \{.RE
.\}

"Avahi"
running on a different host in the same local network should see the service as well:

.if n \{.RS 4
.\}
    $ avahi-browse -a -r
    + enp3s0 IPv6 meteo                                         Web Site             local
    + enp3s0 IPv4 meteo                                         Web Site             local
    = enp3s0 IPv6 meteo                                         Web Site             local
       hostname = [meteo.local]
       address = [fe80::213:3bff:fe49:8aa]
       port = [80]
       txt = ["path=/stats/index.html" "t=temperature_sensor"]
    = enp3s0 IPv4 meteo                                         Web Site             local
       hostname = [meteo.local]
       address = [169.254.208.106]
       port = [80]
       txt = ["path=/stats/index.html" "t=temperature_sensor"]
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-resolved.service**(8),
**resolvectl**(1)

<a name="notes"></a>

# Notes


*  1.  
  RFC 6763
      https://tools.ietf.org/html/rfc6763
