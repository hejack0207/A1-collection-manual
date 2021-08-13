# btrfstune(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfstune - tune various filesystem parameters

<a name="synopsis"></a>

# Synopsis

```

 btrfstune [options] <device> [<device>...]
```

<a name="description"></a>

# Description


**btrfstune** can be used to enable, disable, or set various filesystem parameters. The filesystem must be unmounted.

The common usecase is to enable features that were not enabled at mkfs time. Please make sure that you have kernel support for the features. You can find a complete list of features and kernel version of their introduction at \m[blue]**https://btrfs.wiki.kernel.org/index.php/Changelog#By\_feature**\m[] . Also, the manual page **mkfs.btrfs**(8) contains more details about the features.

Some of the features could be also enabled on a mounted filesystem by other means. Please refer to the _FILESYSTEM FEATURES_ in **btrfs**(5).

<a name="options"></a>

# Options


-f
Allow dangerous changes, e.g. clear the seeding flag or change fsid. Make sure that you are aware of the dangers.

-m
(since kernel: 5.0)

change fsid stored as
_metadata\_uuid_
to a randomly generated UUID, see also
_-U_

-M _&lt;UUID&gt;_
(since kernel: 5.0)

change fsid stored as
_metadata\_uuid_
to a given UUID, see also
_-U_

The metadata_uuid is stored only in the superblock and is a backward incompatible change. The fsid in metadata blocks remains unchanged and is not overwritten, thus the whole operation is significantly faster than
_-U_.

The new metadata_uuid can be used for mount by UUID and is also used to identify devices of a multi-device filesystem.

-n
(since kernel: 3.14)

Enable no-holes feature (more efficient representation of file holes), enabled by mkfs feature
_no-holes_.

-r
(since kernel: 3.7)

Enable extended inode refs (hardlink limit per file in a directory is 65536), enabled by mkfs feature
_extref_.

-S _&lt;0|1&gt;_
Enable seeding on a given device. Value 1 will enable seeding, 0 will disable it.

A seeding filesystem is forced to be mounted read-only. A new device can be added to the filesystem and will capture all writes keeping the seeding device intact.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Clearing the seeding flag on a device may be dangerous. If a previously-seeding device is changed, all filesystems that used that device will become unmountable. Setting the seeding flag back will not fix that.

A valid usecase is
_seeding device as a base image_. Clear the seeding flag, update the filesystem and make it seeding again, provided that it’s OK to throw away all filesystems built on top of the previous base.


-u
Change fsid to a randomly generated UUID or continue previous fsid change operation in case it was interrupted.

-U _&lt;UUID&gt;_
Change fsid to
_UUID_
in all metadata blocks.

The
_UUID_
should be a 36 bytes string in
**printf**(3) format
_"%08x-%04x-%04x-%04x-%012x"_. If there is a previous unfinished fsid change, it will continue only if the
_UUID_
matches the unfinished one or if you use the option
_-u_.

All metadata blocks are rewritten, this may take some time, but the final filesystem compatibility is unaffected, unlike
_-M_.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Cancelling or interrupting a UUID change operation will make the filesystem temporarily unmountable. To fix it, rerun
_btrfstune -u_
and let it complete.


-x
(since kernel: 3.10)

Enable skinny metadata extent refs (more efficient representation of extents), enabled by mkfs feature
_skinny-metadata_.

All newly created extents will use the new representation. To completely switch the entire filesystem, run a full balance of the metadata. Please refer to
**btrfs-balance**(8).

<a name="exit-status"></a>

# Exit Status


**btrfstune** returns 0 if no error happened, 1 otherwise.

<a name="compatibility-note"></a>

# Compatibility Note


This deprecated tool exists for historical reasons but is still in use today. Its functionality will be merged to the main tool, at which time **btrfstune** will be declared obsolete and scheduled for removal.

<a name="see-also"></a>

# See Also


**btrfs**(5), **btrfs-balance**(8), **mkfs.btrfs**(8)
