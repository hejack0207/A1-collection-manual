# systemd\-debug\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-debug-generator - Generator for enabling a runtime debug shell and masking specific units at boot

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-debug-generator
```

<a name="description"></a>

# Description


systemd-debug-generator
is a generator that reads the kernel command line and understands three options:

If the
**systemd.mask=**
or
**rd.systemd.mask=**
option is specified and followed by a unit name, this unit is masked for the runtime, similar to the effect of
**systemctl**(1)s
**mask**
command. This is useful to boot with certain units removed from the initial boot transaction for debugging system startup. May be specified more than once.
**rd.systemd.mask=**
is honored only by initial RAM disk (initrd) while
**systemd.mask=**
is honored only in the main system.

If the
**systemd.wants=**
or
**rd.systemd.wants=**
option is specified and followed by a unit name, a start job for this unit is added to the initial transaction. This is useful to start one or more additional units at boot. May be specified more than once.
**rd.systemd.wants=**
is honored only by initial RAM disk (initrd) while
**systemd.wants=**
is honored only in the main system.

If the
**systemd.debug\_shell**
or
**rd.systemd.debug\_shell**
option is specified, the debug shell service
"debug-shell.service"
is pulled into the boot transaction. It will spawn a debug shell on tty9 during early system startup. Note that the shell may also be turned on persistently by enabling it with
**systemctl**(1)s
**enable**
command.
**rd.systemd.debug\_shell=**
is honored only by initial RAM disk (initrd) while
**systemd.debug\_shell**
is honored only in the main system.

systemd-debug-generator
implements
**systemd.generator**(7).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**kernel-command-line**(7)
