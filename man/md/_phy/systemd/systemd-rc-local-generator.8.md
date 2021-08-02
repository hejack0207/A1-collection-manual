# systemd\-rc\-local\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-rc-local-generator - Compatibility generator for starting /etc/rc.local and /usr/sbin/halt.local during boot and shutdown

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-rc-local-generator
```

<a name="description"></a>

# Description


systemd-rc-local-generator
is a generator that checks whether
/etc/rc.local
exists and is executable, and if it is pulls the
rc-local.service
unit into the boot process. This unit is responsible for running this script during late boot. Note that the script will be run with slightly different semantics than the original System V version, which was run "last" in the boot process, which is a concept that does not translate to systemd. The script is run after
network.target, but in parallel with most other regular system services.

systemd-rc-local-generator
also checks whether
/usr/sbin/halt.local
exists and is executable, and if it is pulls the
halt-local.service
unit into the shutdown process. This unit is responsible for running this script during later shutdown.

Support for both
/etc/rc.local
and
/usr/sbin/halt.local
is provided for compatibility with specific System V systems only. However, it is strongly recommended to avoid making use of these scripts today, and instead provide proper unit files with appropriate dependencies for any scripts to run during the boot or shutdown processes.

systemd-rc-local-generator
implements
**systemd.generator**(7).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1)
