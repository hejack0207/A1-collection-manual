# systemd\-portabled\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-portabled.service, systemd-portabled - Portable service manager

<a name="synopsis"></a>

# Synopsis

```

 systemd-portabled.service 
 /usr/lib/systemd/systemd-portabled
```

<a name="description"></a>

# Description


**systemd-portabled**
is a system service that may be used to attach, detach and inspect portable service images.

Most of
**systemd-portabled**s functionality is accessible through the
**portablectl**(1)
command.

See the
\m[blue]**Portable Services Documentation**\m[]\s-2\u[1]\d\s+2
for details about the concepts this service implements.

<a name="see-also"></a>

# See Also


**systemd**(1),
**portablectl**(1)

<a name="notes"></a>

# Notes


*  1.  
  Portable Services Documentation
      https://systemd.io/PORTABLE_SERVICES
