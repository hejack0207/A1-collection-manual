# btrfs\-check(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-check - check or repair a btrfs filesystem

<a name="synopsis"></a>

# Synopsis

```

 btrfs check [options] <device>
```

<a name="description"></a>

# Description


The filesystem checker is used to verify structural integrity of a filesystem and attempt to repair it if requested. It is recommended to unmount the filesystem prior to running the check, but it is possible to start checking a mounted filesystem (see _--force_).

By default, **btrfs check** will not modify the device but you can reaffirm that by the option _--readonly_.

**btrfsck** is an alias of **btrfs check** command and is now deprecated.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

Do not use _--repair_ unless you are advised to do so by a developer or an experienced user, and then only after having accepted that no _fsck_ successfully repair all types of filesystem corruption. Eg. some other software or hardware bugs can fatally damage a volume.


The structural integrity check verifies if internal filesystem objects or data structures satisfy the constraints, point to the right objects or are correctly connected together.

There are several cross checks that can detect wrong reference counts of shared extents, backreferences, missing extents of inodes, directory and inode connectivity etc.

The amount of memory required can be high, depending on the size of the filesystem, similarly the run time. Check the modes that can also affect that.

<a name="safe-or-advisory-options"></a>

# Safe or Advisory Options


-b|--backup
use the first valid set of backup roots stored in the superblock

This can be combined with
_--super_
if some of the superblocks are damaged.

--check-data-csum
verify checksums of data blocks

This expects that the filesystem is otherwise OK, and is basically and offline
_scrub_
but does not repair data from spare copies.

--chunk-root _&lt;bytenr&gt;_
use the given offset
_bytenr_
for the chunk tree root

-E|--subvol-extents _&lt;subvolid&gt;_
show extent state for the given subvolume

-p|--progress
indicate progress at various checking phases

-Q|--qgroup-report
verify qgroup accounting and compare against filesystem accounting

-r|--tree-root _&lt;bytenr&gt;_
use the given offset
_bytenr_
for the tree root

--readonly
(default) run in read-only mode, this option exists to calm potential panic when users are going to run the checker

-s|--super _&lt;superblock&gt;_
use superblock’th superblock copy, valid values are 0, 1 or 2 if the respective superblock offset is within the device size

This can be used to use a different starting point if some of the primary superblock is damaged.

--clear-space-cache v1|v2
completely wipe all free space cache of given type

For free space cache
_v1_, the
_clear\_cache_
kernel mount option only rebuilds the free space cache for block groups that are modified while the filesystem is mounted with that option. Thus, using this option with
_v1_
makes it possible to actually clear the entire free space cache.

For free space cache
_v2_, the
_clear\_cache_
kernel mount option destroys the entire free space cache. This option, with
_v2_
provides an alternative method of clearing the free space cache that doesn’t require mounting the filesystem.

<a name="dangerous-options"></a>

# Dangerous Options


--repair
enable the repair mode and attempt to fix problems where possible
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
there’s a warning and 10 second delay when this option is run without
_--force_
to give users a chance to think twice before running repair, the warnings in documentation have shown to be insufficient


--init-csum-tree
create a new checksum tree and recalculate checksums in all files
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
Do not blindly use this option to fix checksum mismatch problems.


--init-extent-tree
build the extent tree from scratch
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
Do not use unless you know what you’re doing.


--mode _&lt;MODE&gt;_
select mode of operation regarding memory and IO

The
_MODE_
can be one of:

_original_
The metadata are read into memory and verified, thus the requirements are high on large filesystems and can even lead to out-of-memory conditions. The possible workaround is to export the block device over network to a machine with enough memory.

_lowmem_
This mode is supposed to address the high memory consumption at the cost of increased IO when it needs to re-read blocks. This may increase run time.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
_lowmem_
mode does not work with
_--repair_
yet, and is still considered experimental.


--force
allow work on a mounted filesystem. Note that this should work fine on a quiescent or read-only mounted filesystem but may crash if the device is changed externally, eg. by the kernel module. Repair without mount checks is not supported right now.

This option also skips the delay and warning in the repair mode (see
_--repair_).

<a name="exit-status"></a>

# Exit Status


**btrfs check** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **btrfs-scrub**(8), **btrfs-rescue**(8)
