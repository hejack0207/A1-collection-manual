# systemd\-modules\-load\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-modules-load.service, systemd-modules-load - Load kernel modules at boot

<a name="synopsis"></a>

# Synopsis

```

 systemd-modules-load.service 
 /usr/lib/systemd/systemd-modules-load
```

<a name="description"></a>

# Description


systemd-modules-load.service
is an early boot service that loads kernel modules based on static configuration.

See
**modules-load.d**(5)
for information about the configuration of this service.

<a name="kernel-command-line"></a>

# Kernel Command Line


systemd-modules-load.service
understands the following kernel command line parameters:

_modules\_load=_, _rd.modules\_load=_
Takes a comma-separated list of kernel modules to statically load during early boot. The option prefixed with
"rd."
is read by the initial RAM disk only.

<a name="see-also"></a>

# See Also


**systemd**(1),
**modules-load.d**(5),
