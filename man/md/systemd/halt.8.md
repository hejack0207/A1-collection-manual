# halt(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

halt, poweroff, reboot - Halt, power-off or reboot the machine

<a name="synopsis"></a>

# Synopsis

```
.HP \w'halt&nbsp;'u halt [OPTIONS...] .HP \w'poweroff&nbsp;'u poweroff [OPTIONS...] .HP \w'reboot&nbsp;'u reboot [OPTIONS...]
```

<a name="description"></a>

# Description


**halt**,
**poweroff**,
**reboot**
may be used to halt, power-off or reboot the machine.

<a name="options"></a>

# Options


The following options are understood:

**--help**
Print a short help text and exit.

**--halt**
Halt the machine, regardless of which one of the three commands is invoked.

**-p**, **--poweroff**
Power-off the machine, regardless of which one of the three commands is invoked.

**--reboot**
Reboot the machine, regardless of which one of the three commands is invoked.

**-f**, **--force**
Force immediate halt, power-off, or reboot. When specified once, this results in an immediate but clean shutdown by the system manager. When specified twice, this results in an immediate shutdown without contacting the system manager. See the description of
**--force**
in
**systemctl**(1)
for more details.

**-w**, **--wtmp-only**
Only write wtmp shutdown entry, do not actually halt, power-off, reboot.

**-d**, **--no-wtmp**
Do not write wtmp shutdown entry.

**-n**, **--no-sync**
Dont sync hard disks/storage media before halt, power-off, reboot.

**--no-wall**
Do not send wall message before halt, power-off, reboot.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="notes"></a>

# Notes


These commands are implemented in a way that preserves compatibility with the original SysV commands.
**systemctl**(1)
verbs
**halt**,
**poweroff**,
**reboot**
provide the same functionality with some additional features.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**shutdown**(8),
**wall**(1)
