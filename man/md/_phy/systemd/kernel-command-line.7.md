# kernel\-command\-line(7)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

kernel-command-line - Kernel command line parameters

<a name="synopsis"></a>

# Synopsis

```

 /proc/cmdline
```

<a name="description"></a>

# Description


The kernel, the initial RAM disk (initrd) and basic userspace functionality may be configured at boot via kernel command line arguments.

For command line parameters understood by the kernel, please see
\m[blue]**kernel-parameters.html**\m[]\s-2\u[1]\d\s+2
and
**bootparam**(7).

For command line parameters understood by the initial RAM disk, please see
**dracut.cmdline**(7), or the documentation of the specific initrd implementation of your installation.

<a name="core-os-command-line-arguments"></a>

# Core Os Command Line Arguments


_systemd.unit=_, _rd.systemd.unit=_, _systemd.dump\_core_, _systemd.early\_core\_pattern=_, _systemd.crash\_chvt_, _systemd.crash\_shell_, _systemd.crash\_reboot_, _systemd.confirm\_spawn_, _systemd.service\_watchdogs_, _systemd.show\_status_, _systemd.log\_target=_, _systemd.log\_level=_, _systemd.log\_location=_, _systemd.log\_color_, _systemd.default\_standard\_output=_, _systemd.default\_standard\_error=_, _systemd.setenv=_, _systemd.machine\_id=_, _systemd.unified\_cgroup\_hierarchy_, _systemd.legacy\_systemd\_cgroup\_controller_
Parameters understood by the system and service manager to control system behavior. For details, see
**systemd**(1).

_systemd.mask=_, _systemd.wants=_, _systemd.debug\_shell_
Additional parameters understood by
**systemd-debug-generator**(8), to mask or start specific units at boot, or invoke a debug shell on tty9.

_systemd.run=_, _systemd.run\_success\_action=_, _systemd.run\_failure\_action=_
Additional parameters understood by
**systemd-run-generator**(8), to run a command line specified on the kernel command line as system service after booting up.

_systemd.early\_core\_pattern=_
During early boot, the generation of core dump files is disabled until a core dump handler (if any) takes over. This parameter allows to specifies an absolute path where core dump files should be stored until a handler is installed. The path should be absolute and may contain specifiers, see
**core**(5)
for details.

_systemd.restore\_state=_
This parameter is understood by several system tools to control whether or not they should restore system state from the previous boot. For details, see
**systemd-backlight@.service**(8)
and
**systemd-rfkill.service**(8).

_systemd.volatile=_
This parameter controls whether the system shall boot up in volatile mode. Takes a boolean argument, or the special value
"state". If false (the default), normal boot mode is selected, the root directory and
/var
are mounted as specified on the kernel command line or
/etc/fstab, or otherwise configured. If true, full state-less boot mode is selected. In this case the root directory is mounted as volatile memory file system ("tmpfs"), and only
/usr
is mounted from the file system configured as root device, in read-only mode. This enables fully state-less boots were the vendor-supplied OS is used as shipped, with only default configuration and no stored state in effect, as
/etc
and
/var
(as well as all other resources shipped in the root file system) are reset at boot and lost on shutdown. If this setting is set to
"state"
the root file system is mounted as usual, however
/var
is mounted as a volatile memory file system ("tmpfs"), so that the system boots up with the normal configuration applied, but all state reset at boot and lost at shutdown. For details, see
**systemd-volatile-root.service**(8)
and
**systemd-fstab-generator**(8).

_quiet_
Parameter understood by both the kernel and the system and service manager to control console log verbosity. For details, see
**systemd**(1).

_debug_
Parameter understood by both the kernel and the system and service manager to control console log verbosity. For details, see
**systemd**(1).

_-b_, _rd.emergency_, _emergency_, _rd.rescue_, _rescue_, _single_, _s_, _S_, _1_, _2_, _3_, _4_, _5_
Parameters understood by the system and service manager, as compatibility and convenience options. For details, see
**systemd**(1).

_locale.LANG=_, _locale.LANGUAGE=_, _locale.LC\_CTYPE=_, _locale.LC\_NUMERIC=_, _locale.LC\_TIME=_, _locale.LC\_COLLATE=_, _locale.LC\_MONETARY=_, _locale.LC\_MESSAGES=_, _locale.LC\_PAPER=_, _locale.LC\_NAME=_, _locale.LC\_ADDRESS=_, _locale.LC\_TELEPHONE=_, _locale.LC\_MEASUREMENT=_, _locale.LC\_IDENTIFICATION=_
Parameters understood by the system and service manager to control locale and language settings. For details, see
**systemd**(1).

_fsck.mode=_, _fsck.repair=_
Parameters understood by the file system checker services. For details, see
**systemd-fsck@.service**(8).

_quotacheck.mode=_
Parameter understood by the file quota checker service. For details, see
**systemd-quotacheck.service**(8).

_systemd.journald.forward\_to\_syslog=_, _systemd.journald.forward\_to\_kmsg=_, _systemd.journald.forward\_to\_console=_, _systemd.journald.forward\_to\_wall=_
Parameters understood by the journal service. For details, see
**systemd-journald.service**(8).

_vconsole.keymap=_, _vconsole.keymap\_toggle=_, _vconsole.font=_, _vconsole.font\_map=_, _vconsole.font\_unimap=_
Parameters understood by the virtual console setup logic. For details, see
**vconsole.conf**(5).

_udev.log\_priority=_, _rd.udev.log\_priority=_, _udev.children\_max=_, _rd.udev.children\_max=_, _udev.exec\_delay=_, _rd.udev.exec\_delay=_, _udev.event\_timeout=_, _rd.udev.event\_timeout=_, _net.ifnames=_, _net.naming-scheme=_
Parameters understood by the device event managing daemon. For details, see
**systemd-udevd.service**(8).

_plymouth.enable=_
May be used to disable the Plymouth boot splash. For details, see
**plymouth**(8).

_luks=_, _rd.luks=_, _luks.crypttab=_, _rd.luks.crypttab=_, _luks.name=_, _rd.luks.name=_, _luks.uuid=_, _rd.luks.uuid=_, _luks.options=_, _rd.luks.options=_, _luks.key=_, _rd.luks.key=_
Configures the LUKS full-disk encryption logic at boot. For details, see
**systemd-cryptsetup-generator**(8).

_fstab=_, _rd.fstab=_
Configures the
/etc/fstab
logic at boot. For details, see
**systemd-fstab-generator**(8).

_root=_, _rootfstype=_, _rootflags=_, _ro_, _rw_
Configures the root file system and its file system type and mount options, as well as whether it shall be mounted read-only or read-writable initially. For details, see
**systemd-fstab-generator**(8).

_mount.usr=_, _mount.usrfstype=_, _mount.usrflags=_
Configures the /usr file system (if required) and its file system type and mount options. For details, see
**systemd-fstab-generator**(8).

_roothash=_, _systemd.verity=_, _rd.systemd.verity=_, _systemd.verity\_root\_data=_, _systemd.verity\_root\_hash=_
Configures the integrity protection root hash for the root file system, and other related parameters. For details, see
**systemd-veritysetup-generator**(8).

_systemd.gpt\_auto=_, _rd.systemd.gpt\_auto=_
Configures whether GPT based partition auto-discovery shall be attempted. For details, see
**systemd-gpt-auto-generator**(8).

_systemd.default\_timeout\_start\_sec=_
Overwrites the default start job timeout
_DefaultTimeoutStartSec=_
at boot. For details, see
**systemd-system.conf**(5).

_systemd.watchdog\_device=_
Overwrites the watchdog device path
_WatchdogDevice=_. For details, see
**systemd-system.conf**(5).

_modules\_load=_, _rd.modules\_load=_
Load a specific kernel module early at boot. For details, see
**systemd-modules-load.service**(8).

_resume=_
Enables resume from hibernation using the specified device. All
**fstab**(5)-like paths are supported. For details, see
**systemd-hibernate-resume-generator**(8).

_systemd.firstboot=_
Takes a boolean argument, defaults to on. If off,
**systemd-firstboot.service**(8)
will not query the user for basic system settings, even if the system boots up for the first time and the relevant settings are not initialized yet.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-system.conf**(5),
**bootparam**(7),
**dracut.cmdline**(7),
**systemd-debug-generator**(8),
**systemd-fsck@.service**(8),
**systemd-quotacheck.service**(8),
**systemd-journald.service**(8),
**systemd-vconsole-setup.service**(8),
**systemd-udevd.service**(8),
**plymouth**(8),
**systemd-cryptsetup-generator**(8),
**systemd-veritysetup-generator**(8),
**systemd-fstab-generator**(8),
**systemd-gpt-auto-generator**(8),
**systemd-volatile-root.service**(8),
**systemd-modules-load.service**(8),
**systemd-backlight@.service**(8),
**systemd-rfkill.service**(8),
**systemd-hibernate-resume-generator**(8),
**systemd-firstboot.service**(8)

<a name="notes"></a>

# Notes


*  1.  
  kernel-parameters.html
      https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
