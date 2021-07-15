# systemd\-bless\-boot\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-bless-boot-generator - Pull systemd-bless-boot.service into the initial boot transaction when boot counting is in effect.

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-bless-boot-generator
```

<a name="description"></a>

# Description


systemd-bless-boot-generator
is a generator that pulls
systemd-bless-boot.service
into the initial boot transaction when boot counting, as implemented by
**systemd-boot**(7), is enabled.

systemd-bless-boot-generator
implements
**systemd.generator**(7).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-bless-boot.service**(8),
**systemd-boot**(7)
