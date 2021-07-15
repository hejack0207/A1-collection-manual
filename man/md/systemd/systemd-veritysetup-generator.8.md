# systemd\-veritysetup\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-veritysetup-generator - Unit generator for integrity protected block devices

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-veritysetup-generator
```

<a name="description"></a>

# Description


systemd-veritysetup-generator
is a generator that translates kernel command line options configuring integrity protected block devices (verity) into native systemd units early at boot and when configuration of the system manager is reloaded. This will create
**systemd-veritysetup@.service**(8)
units as necessary.

Currently, only a single verity device may be se up with this generator, backing the root file system of the OS.

systemd-veritysetup-generator
implements
**systemd.generator**(7).

<a name="kernel-command-line"></a>

# Kernel Command Line


systemd-veritysetup-generator
understands the following kernel command line parameters:

_systemd.verity=_, _rd.systemd.verity=_
Takes a boolean argument. Defaults to
"yes". If
"no", disables the generator entirely.
_rd.systemd.verity=_
is honored only by the initial RAM disk (initrd) while
_systemd.verity=_
is honored by both the host system and the initrd.

_roothash=_
Takes a root hash value for the root file system. Expects a hash value formatted in hexadecimal characters, of the appropriate length (i.e. most likely 256 bit/64 characters, or longer). If not specified via
_systemd.verity\_root\_data=_
and
_systemd.verity\_root\_hash=_, the hash and data devices to use are automatically derived from the specified hash value. Specifically, the data partition device is looked for under a GPT partition UUID derived from the first 128bit of the root hash, the hash partition device is looked for under a GPT partition UUID derived from the last 128bit of the root hash. Hence it is usually sufficient to specify the root hash to boot from an integrity protected root file system, as device paths are automatically determined from it — as long as the partition table is properly set up.

_systemd.verity\_root\_data=_, _systemd.verity\_root\_hash=_
These two settings take block device paths as arguments, and may be use to explicitly configure the data partition and hash partition to use for setting up the integrity protection for the root file system. If not specified, these paths are automatically derived from the
_roothash=_
argument (see above).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-veritysetup@.service**(8),
**veritysetup**(8),
**systemd-fstab-generator**(8)
