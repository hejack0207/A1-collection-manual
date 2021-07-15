# systemd\-hostnamed\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-hostnamed.service, systemd-hostnamed - Host name bus mechanism

<a name="synopsis"></a>

# Synopsis

```

 systemd-hostnamed.service 
 /usr/lib/systemd/systemd-hostnamed
```

<a name="description"></a>

# Description


systemd-hostnamed
is a system service that may be used as a mechanism to change the systems hostname.
systemd-hostnamed
is automatically activated on request and terminates itself when it is unused.

The tool
**hostnamectl**(1)
is a command line client to this service.

See the
\m[blue]**developer documentation**\m[]\s-2\u[1]\d\s+2
for information about the APIs
systemd-hostnamed
provides.

<a name="see-also"></a>

# See Also


**systemd**(1),
**hostname**(5),
**machine-info**(5),
**hostnamectl**(1),
**sethostname**(2)

<a name="notes"></a>

# Notes


*  1.  
  developer documentation
      https://www.freedesktop.org/wiki/Software/systemd/hostnamed
