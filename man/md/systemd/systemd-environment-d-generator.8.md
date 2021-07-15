# systemd\-environment\-d\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-environment-d-generator, 30-systemd-environment-d-generator - Load variables specified by environment.d

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator
```

<a name="description"></a>

# Description


systemd-environment-d-generator
is a
**systemd.environment-generator**(7)
that reads environment configuration specified by
**environment.d**(7)
configuration files and passes it to the
**systemd**(1)
user manager instance.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd.environment-generator**(7),
**systemd.generator**(7)
