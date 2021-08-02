# machine\-info(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

machine-info - Local machine information file

<a name="synopsis"></a>

# Synopsis

```

 /etc/machine-info
```

<a name="description"></a>

# Description


The
/etc/machine-info
file contains machine metadata.

The basic file format of
machine-info
is a newline-separated list of environment-like shell-compatible variable assignments. It is possible to source the configuration from shell scripts, however, beyond mere variable assignments no shell features are supported, allowing applications to read the file without implementing a shell compatible execution engine.

/etc/machine-info
contains metadata about the machine that is set by the user or administrator.

Depending on the operating system other configuration files might be checked for machine information as well, however only as fallback.

You may use
**hostnamectl**(1)
to change the settings of this file from the command line.

<a name="options"></a>

# Options


The following machine metadata parameters may be set using
/etc/machine-info:

_PRETTY\_HOSTNAME=_
A pretty human-readable UTF-8 machine identifier string. This should contain a name like
"Lennarts Laptop"
which is useful to present to the user and does not suffer by the syntax limitations of internet domain names. If possible, the internet hostname as configured in
/etc/hostname
should be kept similar to this one. Example: if this value is
"Lennarts Computer"
an Internet hostname of
"lennarts-computer"
might be a good choice. If this parameter is not set, an application should fall back to the Internet host name for presentation purposes.

_ICON\_NAME=_
An icon identifying this machine according to the
\m[blue]**XDG Icon Naming Specification**\m[]\s-2\u[1]\d\s+2. If this parameter is not set, an application should fall back to
"computer"
or a similar icon name.

_CHASSIS=_
The chassis type. Currently, the following chassis types are defined:
"desktop",
"laptop",
"convertible",
"server",
"tablet",
"handset",
"watch", and
"embedded", as well as the special chassis types
"vm"
and
"container"
for virtualized systems that lack an immediate physical chassis. Note that many systems allow detection of the chassis type automatically (based on firmware information or suchlike). This setting (if set) shall take precedence over automatically detected information and is useful to override misdetected configuration or to manually configure the chassis type where automatic detection is not available.

_DEPLOYMENT=_
Describes the system deployment environment. One of the following is suggested:
"development",
"integration",
"staging",
"production".

_LOCATION=_
Describes the system location if applicable and known. Takes a human-friendly, free-form string. This may be as generic as
"Berlin, Germany"
or as specific as
"Left Rack, 2nd Shelf".

<a name="example"></a>

# Example


.if n \{.RS 4
.\}
    PRETTY_HOSTNAME="Lennarts Tablet"
    ICON_NAME=computer-tablet
    CHASSIS=tablet
    DEPLOYMENT=production
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**os-release**(5),
**hostname**(5),
**machine-id**(5),
**hostnamectl**(1),
**systemd-hostnamed.service**(8)

<a name="notes"></a>

# Notes


*  1.  
  XDG Icon Naming Specification
      http://standards.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html
