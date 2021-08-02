# systemd\-localed\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-localed.service, systemd-localed - Locale bus mechanism

<a name="synopsis"></a>

# Synopsis

```

 systemd-localed.service 
 /usr/lib/systemd/systemd-localed
```

<a name="description"></a>

# Description


systemd-localed
is a system service that may be used as mechanism to change the system locale settings, as well as the console key mapping and default X11 key mapping.
systemd-localed
is automatically activated on request and terminates itself when it is unused.

The tool
**localectl**(1)
is a command line client to this service.

See the
\m[blue]**developer documentation**\m[]\s-2\u[1]\d\s+2
for information about the APIs
systemd-localed
provides.

<a name="see-also"></a>

# See Also


**systemd**(1),
**locale.conf**(5),
**vconsole.conf**(5),
**localectl**(1),
**loadkeys**(1)

<a name="notes"></a>

# Notes


*  1.  
  developer documentation
      https://www.freedesktop.org/wiki/Software/systemd/localed
