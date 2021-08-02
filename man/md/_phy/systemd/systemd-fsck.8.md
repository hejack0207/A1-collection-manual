# systemd\-fsck@\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-fsck@.service, systemd-fsck-root.service, systemd-fsck - File system checker logic

<a name="synopsis"></a>

# Synopsis

```

 systemd-fsck@.service 
 systemd-fsck-root.service 
 /usr/lib/systemd/systemd-fsck
```

<a name="description"></a>

# Description


systemd-fsck@.service
and
systemd-fsck-root.service
are services responsible for file system checks. They are instantiated for each device that is configured for file system checking.
systemd-fsck-root.service
is responsible for file system checks on the root file system, but only if the root filesystem was not checked in the initramfs.
systemd-fsck@.service
is used for all other file systems and for the root file system in the initramfs.

These services are started at boot if
**passno**
in
/etc/fstab
for the file system is set to a value greater than zero. The file system check for root is performed before the other file systems. Other file systems may be checked in parallel, except when they are on the same rotating disk.

systemd-fsck
does not know any details about specific filesystems, and simply executes file system checkers specific to each filesystem type (/sbin/fsck.*). These checkers will decide if the filesystem should actually be checked based on the time since last check, number of mounts, unclean unmount, etc.

If a file system check fails for a service without
**nofail**, emergency mode is activated, by isolating to
emergency.target.

<a name="kernel-command-line"></a>

# Kernel Command Line


systemd-fsck
understands these kernel command line parameters:

_fsck.mode=_
One of
"auto",
"force",
"skip". Controls the mode of operation. The default is
"auto", and ensures that file system checks are done when the file system checker deems them necessary.
"force"
unconditionally results in full file system checks.
"skip"
skips any file system checks.

_fsck.repair=_
One of
"preen",
"yes",
"no". Controls the mode of operation. The default is
"preen", and will automatically repair problems that can be safely fixed.
"yes"
will answer yes to all questions by fsck and
"no"
will answer no to all questions.

<a name="see-also"></a>

# See Also


**systemd**(1),
**fsck**(8),
**systemd-quotacheck.service**(8),
**fsck.btrfs**(8),
**fsck.cramfs**(8),
**fsck.ext4**(8),
**fsck.fat**(8),
**fsck.hfsplus**(8),
**fsck.minix**(8),
**fsck.ntfs**(8),
**fsck.xfs**(8)
