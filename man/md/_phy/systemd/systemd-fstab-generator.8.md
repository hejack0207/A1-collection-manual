# systemd\-fstab\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-fstab-generator - Unit generator for /etc/fstab

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-fstab-generator
```

<a name="description"></a>

# Description


systemd-fstab-generator
is a generator that translates
/etc/fstab
(see
**fstab**(5)
for details) into native systemd units early at boot and when configuration of the system manager is reloaded. This will instantiate mount and swap units as necessary.

The
_passno_
field is treated like a simple boolean, and the ordering information is discarded. However, if the root file system is checked, it is checked before all the other file systems.

See
**systemd.mount**(5)
and
**systemd.swap**(5)
for more information about special
/etc/fstab
mount options this generator understands.

One special topic is handling of symbolic links. Historical init implementations supported symlinks in
/etc/fstab. Because mount units will refuse mounts where the target is a symbolic link, this generator will resolve any symlinks as far as possible when processing
/etc/fstab
in order to enhance backwards compatibility. If a symlink target does not exist at the time that this generator runs, it is assumed that the symlink target is the final target of the mount.

systemd-fstab-generator
implements
**systemd.generator**(7).

<a name="kernel-command-line"></a>

# Kernel Command Line


systemd-fstab-generator
understands the following kernel command line parameters:

_fstab=_, _rd.fstab=_
Takes a boolean argument. Defaults to
"yes". If
"no", causes the generator to ignore any mounts or swap devices configured in
/etc/fstab.
_rd.fstab=_
is honored only by the initial RAM disk (initrd) while
_fstab=_
is honored by both the main system and the initrd.

_root=_
Takes the root filesystem to mount in the initrd.
_root=_
is honored by the initrd.

_rootfstype=_
Takes the root filesystem type that will be passed to the mount command.
_rootfstype=_
is honored by the initrd.

_rootflags=_
Takes the root filesystem mount options to use.
_rootflags=_
is honored by the initrd.

_mount.usr=_
Takes the
/usr
filesystem to be mounted by the initrd. If
_mount.usrfstype=_
or
_mount.usrflags=_
is set, then
_mount.usr=_
will default to the value set in
_root=_.

Otherwise, this parameter defaults to the
/usr
entry found in
/etc/fstab
on the root filesystem.

_mount.usr=_
is honored by the initrd.

_mount.usrfstype=_
Takes the
/usr
filesystem type that will be passed to the mount command. If
_mount.usr=_
or
_mount.usrflags=_
is set, then
_mount.usrfstype=_
will default to the value set in
_rootfstype=_.

Otherwise, this value will be read from the
/usr
entry in
/etc/fstab
on the root filesystem.

_mount.usrfstype=_
is honored by the initrd.

_mount.usrflags=_
Takes the
/usr
filesystem mount options to use. If
_mount.usr=_
or
_mount.usrfstype=_
is set, then
_mount.usrflags=_
will default to the value set in
_rootflags=_.

Otherwise, this value will be read from the
/usr
entry in
/etc/fstab
on the root filesystem.

_mount.usrflags=_
is honored by the initrd.

_systemd.volatile=_
Controls whether the system shall boot up in volatile mode. Takes a boolean argument or the special value
**state**.

If false (the default), this generator makes no changes to the mount tree and the system is booted up in normal mode.

If true the generator ensures
**systemd-volatile-root.service**(8)
is run as part of the initial RAM disk ("initrd"). This service changes the mount table before transitioning to the host system, so that a volatile memory file system ("tmpfs") is used as root directory, with only
/usr
mounted into it from the configured root file system, in read-only mode. This way the system operates in fully stateless mode, with all configuration and state reset at boot and lost at shutdown, as
/etc
and
/var
will be served from the (initially unpopulated) volatile memory file system.

If set to
**state**
the generator will leave the root directory mount point unaltered, however will mount a
"tmpfs"
file system to
/var. In this mode the normal system configuration (i.e. the contents of
"/etc") is in effect (and may be modified during system runtime), however the system state (i.e. the contents of
"/var") is reset at boot and lost at shutdown.

Note that in none of these modes the root directory,
/etc,
/var
or any other resources stored in the root file system are physically removed. Its thus safe to boot a system that is normally operated in non-volatile mode temporarily into volatile mode, without losing data.

Note that enabling this setting will only work correctly on operating systems that can boot up with only
/usr
mounted, and are able to automatically populate
/etc, and also
/var
in case of
"systemd.volatile=yes".

<a name="see-also"></a>

# See Also


**systemd**(1),
**fstab**(5),
**systemd.mount**(5),
**systemd.swap**(5),
**systemd-cryptsetup-generator**(8),
**kernel-command-line**(7)
