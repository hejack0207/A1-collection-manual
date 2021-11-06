# systemd\-cryptsetup\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-cryptsetup-generator - Unit generator for /etc/crypttab

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-cryptsetup-generator
```

<a name="description"></a>

# Description


systemd-cryptsetup-generator
is a generator that translates
/etc/crypttab
into native systemd units early at boot and when configuration of the system manager is reloaded. This will create
**systemd-cryptsetup@.service**(8)
units as necessary.

systemd-cryptsetup-generator
implements
**systemd.generator**(7).

<a name="kernel-command-line"></a>

# Kernel Command Line


systemd-cryptsetup-generator
understands the following kernel command line parameters:

_luks=_, _rd.luks=_
Takes a boolean argument. Defaults to
"yes". If
"no", disables the generator entirely.
_rd.luks=_
is honored only by initial RAM disk (initrd) while
_luks=_
is honored by both the main system and the initrd.

_luks.crypttab=_, _rd.luks.crypttab=_
Takes a boolean argument. Defaults to
"yes". If
"no", causes the generator to ignore any devices configured in
/etc/crypttab
(_luks.uuid=_
will still work however).
_rd.luks.crypttab=_
is honored only by initial RAM disk (initrd) while
_luks.crypttab=_
is honored by both the main system and the initrd.

_luks.uuid=_, _rd.luks.uuid=_
Takes a LUKS superblock UUID as argument. This will activate the specified device as part of the boot process as if it was listed in
/etc/crypttab. This option may be specified more than once in order to set up multiple devices.
_rd.luks.uuid=_
is honored only by initial RAM disk (initrd) while
_luks.uuid=_
is honored by both the main system and the initrd.

If /etc/crypttab contains entries with the same UUID, then the name, keyfile and options specified there will be used. Otherwise, the device will have the name
"luks-UUID".

If /etc/crypttab exists, only those UUIDs specified on the kernel command line will be activated in the initrd or the real root.

_luks.name=_, _rd.luks.name=_
Takes a LUKS super block UUID followed by an
"="
and a name. This implies
_rd.luks.uuid=_
or
_luks.uuid=_
and will additionally make the LUKS device given by the UUID appear under the provided name.

_rd.luks.name=_
is honored only by initial RAM disk (initrd) while
_luks.name=_
is honored by both the main system and the initrd.

_luks.options=_, _rd.luks.options=_
Takes a LUKS super block UUID followed by an
"="
and a string of options separated by commas as argument. This will override the options for the given UUID.

If only a list of options, without an UUID, is specified, they apply to any UUIDs not specified elsewhere, and without an entry in
/etc/crypttab.

_rd.luks.options=_
is honored only by initial RAM disk (initrd) while
_luks.options=_
is honored by both the main system and the initrd.

_luks.key=_, _rd.luks.key=_
Takes a password file name as argument or a LUKS super block UUID followed by a
"="
and a password file name.

For those entries specified with
_rd.luks.uuid=_
or
_luks.uuid=_, the password file will be set to the one specified by
_rd.luks.key=_
or
_luks.key=_
of the corresponding UUID, or the password file that was specified without a UUID.

It is also possible to specify an external device which should be mounted before we attempt to unlock the LUKS device. systemd-cryptsetup will use password file stored on that device. Device containing password file is specified by appending colon and a device identifier to the password file path. For example,
_rd.luks.uuid=_b40f1abf-2a53-400a-889a-2eccc27eaa40
_rd.luks.key=_b40f1abf-2a53-400a-889a-2eccc27eaa40=/keyfile:LABEL=keydev. Hence, in this case, we will attempt to mount file system residing on the block device with label
"keydev". This syntax is for now only supported on a per-device basis, i.e. you have to specify LUKS device UUID.

_rd.luks.key=_
is honored only by initial RAM disk (initrd) while
_luks.key=_
is honored by both the main system and the initrd.

<a name="see-also"></a>

# See Also


**systemd**(1),
**crypttab**(5),
**systemd-cryptsetup@.service**(8),
**cryptsetup**(8),
**systemd-fstab-generator**(8)
