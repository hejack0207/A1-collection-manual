# systemd\-system\-update\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-system-update-generator - Generator for redirecting boot to offline update mode

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-system-update-generator
```

<a name="description"></a>

# Description


systemd-system-update-generator
is a generator that automatically redirects the boot process to
system-update.target, if
/system-update
exists. This is required to implement the logic explained in the
**systemd.offline-updates**(7).

systemd-system-update-generator
implements
**systemd.generator**(7).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.special**(7)
