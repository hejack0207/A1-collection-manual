# btrfs\-man5(5)

Btrfs v5\&.7, 07/27/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-man5 - topics about the BTRFS filesystem (mount options, supported file attributes and other)

<a name="description"></a>

# Description


This document describes topics related to BTRFS that are not specific to the tools. Currently covers:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  mount options

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  filesystem features

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  checksum algorithms

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  filesystem limits

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  bootloader support

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  file attributes

.ie n \{\h'-04' 7.\h'+01'\c
.\}
.el \{.sp -1

*   7.  
  .\}
  control device

.ie n \{\h'-04' 8.\h'+01'\c
.\}
.el \{.sp -1

*   8.  
  .\}
  filesystems with multiple block group profiles

<a name="mount-options"></a>

# Mount Options


This section describes mount options specific to BTRFS. For the generic mount options please refer to **mount**(8) manpage. The options are sorted alphabetically (discarding the _no_ prefix).
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

most mount options apply to the whole filesystem and only options in the first mounted subvolume will take effect. This is due to lack of implementation and may change in the future. This means that (for example) you can’t set per-subvolume _nodatacow_, _nodatasum_, or _compress_ using mount options. This should eventually be fixed, but it has proved to be difficult to implement correctly within the Linux VFS framework.


Mount options are processed in order, only the last occurence of an option takes effect and may disable other options due to constraints (see eg. _nodatacow_ and _compress_). The output of _mount_ command shows which options have been applied.

**acl**, **noacl**
(default: on)

Enable/disable support for Posix Access Control Lists (ACLs). See the
**acl**(5) manual page for more information about ACLs.

The support for ACL is build-time configurable (BTRFS_FS_POSIX_ACL) and mount fails if
_acl_
is requested but the feature is not compiled in.

**autodefrag**, **noautodefrag**
(since: 3.0, default: off)

Enable automatic file defragmentation. When enabled, small random writes into files (in a range of tens of kilobytes, currently it’s 64K) are detected and queued up for the defragmentation process. Not well suited for large database workloads.

The read latency may increase due to reading the adjacent blocks that make up the range for defragmentation, successive write will merge the blocks in the new location.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Defragmenting with Linux kernel versions &lt; 3.9 or \(&gt;= 3.14-rc2 as well as with Linux stable kernel versions \(&gt;= 3.10.31, \(&gt;= 3.12.12 or \(&gt;= 3.13.4 will break up the reflinks of COW data (for example files copied with
**cp --reflink**, snapshots or de-duplicated data). This may cause considerable increase of space usage depending on the broken up reflinks.


**barrier**, **nobarrier**
(default: on)

Ensure that all IO write operations make it through the device cache and are stored permanently when the filesystem is at its consistency checkpoint. This typically means that a flush command is sent to the device that will synchronize all pending data and ordinary metadata blocks, then writes the superblock and issues another flush.

The write flushes incur a slight hit and also prevent the IO block scheduler to reorder requests in a more effective way. Disabling barriers gets rid of that penalty but will most certainly lead to a corrupted filesystem in case of a crash or power loss. The ordinary metadata blocks could be yet unwritten at the time the new superblock is stored permanently, expecting that the block pointers to metadata were stored permanently before.

On a device with a volatile battery-backed write-back cache, the
_nobarrier_
option will not lead to filesystem corruption as the pending blocks are supposed to make it to the permanent storage.

**check\_int**, **check\_int\_data**, **check\_int\_print\_mask=****value**
(since: 3.0, default: off)

These debugging options control the behavior of the integrity checking module (the BTRFS_FS_CHECK_INTEGRITY config option required). The main goal is to verify that all blocks from a given transaction period are properly linked.

_check\_int_
enables the integrity checker module, which examines all block write requests to ensure on-disk consistency, at a large memory and CPU cost.

_check\_int\_data_
includes extent data in the integrity checks, and implies the
_check\_int_
option.

_check\_int\_print\_mask_
takes a bitmask of BTRFSIC_PRINT_MASK_* values as defined in
_fs/btrfs/check-integrity.c_, to control the integrity checker module behavior.

See comments at the top of
_fs/btrfs/check-integrity.c_
for more information.

**clear\_cache**
Force clearing and rebuilding of the disk space cache if something has gone wrong. See also:
_space\_cache_.

**commit=****seconds**
(since: 3.12, default: 30)

Set the interval of periodic transaction commit when data are synchronized to permanent storage. Higher interval values lead to larger amount of unwritten data, which has obvious consequences when the system crashes. The upper bound is not forced, but a warning is printed if it’s more than 300 seconds (5 minutes). Use with care.

**compress**, **compress=****type[:level]**, **compress-force**, **compress-force=****type[:level]**
(default: off, level support since: 5.1)

Control BTRFS file data compression. Type may be specified as
_zlib_,
_lzo_,
_zstd_
or
_no_
(for no compression, used for remounting). If no type is specified,
_zlib_
is used. If
_compress-force_
is specified, then compression will always be attempted, but the data may end up uncompressed if the compression would make them larger.

Both
_zlib_
and
_zstd_
(since version 5.1) expose the compression level as a tunable knob with higher levels trading speed and memory (_zstd_) for higher compression ratios. This can be set by appending a colon and the desired level. Zlib accepts the range [1, 9] and zstd accepts [1, 15]. If no level is set, both currently use a default level of 3. The value 0 is an alias for the default level.

Otherwise some simple heuristics are applied to detect an incompressible file. If the first blocks written to a file are not compressible, the whole file is permanently marked to skip compression. As this is too simple, the
_compress-force_
is a workaround that will compress most of the files at the cost of some wasted CPU cycles on failed attempts. Since kernel 4.15, a set of heuristic algorithms have been improved by using frequency sampling, repeated pattern detection and Shannon entropy calculation to avoid that.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If compression is enabled,
_nodatacow_
and
_nodatasum_
are disabled.


**datacow**, **nodatacow**
(default: on)

Enable data copy-on-write for newly created files.
_Nodatacow_
implies
_nodatasum_, and disables
_compression_. All files created under
_nodatacow_
are also set the NOCOW file attribute (see
**chattr**(1)).
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If
_nodatacow_
or
_nodatasum_
are enabled, compression is disabled.

Updates in-place improve performance for workloads that do frequent overwrites, at the cost of potential partial writes, in case the write is interrupted (system crash, device failure).

**datasum**, **nodatasum**
(default: on)

Enable data checksumming for newly created files.
_Datasum_
implies
_datacow_, ie. the normal mode of operation. All files created under
_nodatasum_
inherit the "no checksums" property, however there’s no corresponding file attribute (see
**chattr**(1)).
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If
_nodatacow_
or
_nodatasum_
are enabled, compression is disabled.

There is a slight performance gain when checksums are turned off, the corresponding metadata blocks holding the checksums do not need to updated. The cost of checksumming of the blocks in memory is much lower than the IO, modern CPUs feature hardware support of the checksumming algorithm.

**degraded**
(default: off)

Allow mounts with less devices than the RAID profile constraints require. A read-write mount (or remount) may fail when there are too many devices missing, for example if a stripe member is completely missing from RAID0.

Since 4.14, the constraint checks have been improved and are verified on the chunk level, not an the device level. This allows degraded mounts of filesystems with mixed RAID profiles for data and metadata, even if the device number constraints would not be satisfied for some of the profiles.

Example: metadata — raid1, data — single, devices — /dev/sda, /dev/sdb

Suppose the data are completely stored on
_sda_, then missing
_sdb_
will not prevent the mount, even if 1 missing device would normally prevent (any)
_single_
profile to mount. In case some of the data chunks are stored on
_sdb_, then the constraint of single/data is not satisfied and the filesystem cannot be mounted.

**device=****devicepath**
Specify a path to a device that will be scanned for BTRFS filesystem during mount. This is usually done automatically by a device manager (like udev) or using the
**btrfs device scan**
command (eg. run from the initial ramdisk). In cases where this is not possible the
_device_
mount option can help.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
booting eg. a RAID1 system may fail even if all filesystem’s
_device_
paths are provided as the actual device nodes may not be discovered by the system at that point.


**discard**, **discard=sync**, **discard=async**, **nodiscard**
(default: off, async support since: 5.6)

Enable discarding of freed file blocks. This is useful for SSD devices, thinly provisioned LUNs, or virtual machine images; however, every storage layer must support discard for it to work.

In the synchronous mode (_sync_
or without option value), lack of asynchronous queued TRIM on the backing device TRIM can severely degrade performance, because a synchronous TRIM operation will be attempted instead. Queued TRIM requires newer than SATA revision 3.1 chipsets and devices.

The asynchronous mode (_async_) gathers extents in larger chunks before sending them to the devices for TRIM. The overhead and performance impact should be negligible compared to the previous mode and it’s supposed to be the preferred mode if needed.

If it is not necessary to immediately discard freed blocks, then the
**fstrim**
tool can be used to discard all free blocks in a batch. Scheduling a TRIM during a period of low system activity will prevent latent interference with the performance of other operations. Also, a device may ignore the TRIM command if the range is too small, so running a batch discard has a greater probability of actually discarding the blocks.

**enospc\_debug**, **noenospc\_debug**
(default: off)

Enable verbose output for some ENOSPC conditions. It’s safe to use but can be noisy if the system reaches near-full state.

**fatal\_errors=****action**
(since: 3.4, default: bug)

Action to take when encountering a fatal error.

**bug**
_BUG()_
on a fatal error, the system will stay in the crashed state and may be still partially usable, but reboot is required for full operation

**panic**
_panic()_
on a fatal error, depending on other system configuration, this may be followed by a reboot. Please refer to the documentation of kernel boot parameters, eg.
_panic_,
_oops_
or
_crashkernel_.

**flushoncommit**, **noflushoncommit**
(default: off)

This option forces any data dirtied by a write in a prior transaction to commit as part of the current commit, effectively a full filesystem sync.

This makes the committed state a fully consistent view of the file system from the application’s perspective (i.e. it includes all completed file system operations). This was previously the behavior only when a snapshot was created.

When off, the filesystem is consistent but buffered writes may last more than one transaction commit.

**fragment=****type**
(depends on compile-time option BTRFS_DEBUG, since: 4.4, default: off)

A debugging helper to intentionally fragment given
_type_
of block groups. The type can be
_data_,
_metadata_
or
_all_. This mount option should not be used outside of debugging environments and is not recognized if the kernel config option
_BTRFS\_DEBUG_
is not enabled.

**inode\_cache**, **noinode\_cache**
(since: 3.0, default: off)

Enable free inode number caching. Not recommended to use unless files on your filesystem get assigned inode numbers that are approaching 2^64. Normally, new files in each subvolume get assigned incrementally (plus one from the last time) and are not reused. The mount option turns on caching of the existing inode numbers and reuse of inode numbers of deleted files.

This option may slow down your system at first run, or after mounting without the option.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
Defaults to off due to a potential overflow problem when the free space checksums don’t fit inside a single page.

Don’t use this option unless you really need it. The inode number limit on 64bit system is 2^64, which is practically enough for the whole filesystem lifetime. Due to implementation of linux VFS layer, the inode numbers on 32bit systems are only 32 bits wide. This lowers the limit significantly and makes it possible to reach it. In such case, this mount option will help. Alternatively, files with high inode numbers can be copied to a new subvolume which will effectively start the inode numbers from the beginning again.

**nologreplay**
(default: off, even read-only)

The tree-log contains pending updates to the filesystem until the full commit. The log is replayed on next mount, this can be disabled by this option. See also
_treelog_. Note that
_nologreplay_
is the same as
_norecovery_.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
currently, the tree log is replayed even with a read-only mount! To disable that behaviour, mount also with
_nologreplay_.


**max\_inline=****bytes**
(default: min(2048, page size) )

Specify the maximum amount of space, that can be inlined in a metadata B-tree leaf. The value is specified in bytes, optionally with a K suffix (case insensitive). In practice, this value is limited by the filesystem block size (named
_sectorsize_
at mkfs time), and memory page size of the system. In case of sectorsize limit, there’s some space unavailable due to leaf headers. For example, a 4k sectorsize, maximum size of inline data is about 3900 bytes.

Inlining can be completely turned off by specifying 0. This will increase data block slack if file sizes are much smaller than block size but will reduce metadata consumption in return.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
the default value has changed to 2048 in kernel 4.6.


**metadata\_ratio=****value**
(default: 0, internal logic)

Specifies that 1 metadata chunk should be allocated after every
_value_
data chunks. Default behaviour depends on internal logic, some percent of unused metadata space is attempted to be maintained but is not always possible if there’s not enough space left for chunk allocation. The option could be useful to override the internal logic in favor of the metadata allocation if the expected workload is supposed to be metadata intense (snapshots, reflinks, xattrs, inlined files).

**norecovery**
(since: 4.5, default: off)

Do not attempt any data recovery at mount time. This will disable
_logreplay_
and avoids other write operations. Note that this option is the same as
_nologreplay_.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
The opposite option
_recovery_
used to have different meaning but was changed for consistency with other filesystems, where
_norecovery_
is used for skipping log replay. BTRFS does the same and in general will try to avoid any write operations.


**rescan\_uuid\_tree**
(since: 3.12, default: off)

Force check and rebuild procedure of the UUID tree. This should not normally be needed.

**skip\_balance**
(since: 3.3, default: off)

Skip automatic resume of an interrupted balance operation. The operation can later be resumed with
**btrfs balance resume**, or the paused state can be removed with
**btrfs balance cancel**. The default behaviour is to resume an interrupted balance immediately after a volume is mounted.

**space\_cache**, **space\_cache=****version**, **nospace\_cache**
(_nospace\_cache_
since: 3.2,
_space\_cache=v1_
and
_space\_cache=v2_
since 4.5, default:
_space\_cache=v1_)

Options to control the free space cache. The free space cache greatly improves performance when reading block group free space into memory. However, managing the space cache consumes some resources, including a small amount of disk space.

There are two implementations of the free space cache. The original one, referred to as
_v1_, is the safe default. The
_v1_
space cache can be disabled at mount time with
_nospace\_cache_
without clearing.

On very large filesystems (many terabytes) and certain workloads, the performance of the
_v1_
space cache may degrade drastically. The
_v2_
implementation, which adds a new B-tree called the free space tree, addresses this issue. Once enabled, the
_v2_
space cache will always be used and cannot be disabled unless it is cleared. Use
_clear\_cache,space\_cache=v1_
or
_clear\_cache,nospace\_cache_
to do so. If
_v2_
is enabled, kernels without
_v2_
support will only be able to mount the filesystem in read-only mode. The
**btrfs**(8) command currently only has read-only support for
_v2_. A read-write command may be run on a
_v2_
filesystem by clearing the cache, running the command, and then remounting with
_space\_cache=v2_.

If a version is not explicitly specified, the default implementation will be chosen, which is
_v1_.

**ssd**, **ssd\_spread**, **nossd**, **nossd\_spread**
(default: SSD autodetected)

Options to control SSD allocation schemes. By default, BTRFS will enable or disable SSD optimizations depending on status of a device with respect to rotational or non-rotational type. This is determined by the contents of
_/sys/block/DEV/queue/rotational_). If it is 0, the
_ssd_
option is turned on. The option
_nossd_
will disable the autodetection.

The optimizations make use of the absence of the seek penalty that’s inherent for the rotational devices. The blocks can be typically written faster and are not offloaded to separate threads.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
Since 4.14, the block layout optimizations have been dropped. This used to help with first generations of SSD devices. Their FTL (flash translation layer) was not effective and the optimization was supposed to improve the wear by better aligning blocks. This is no longer true with modern SSD devices and the optimization had no real benefit. Furthermore it caused increased fragmentation. The layout tuning has been kept intact for the option
_ssd\_spread_.

The
_ssd\_spread_
mount option attempts to allocate into bigger and aligned chunks of unused space, and may perform better on low-end SSDs.
_ssd\_spread_
implies
_ssd_, enabling all other SSD heuristics as well. The option
_nossd_
will disable all SSD options while
_nossd\_spread_
only disables
_ssd\_spread_.

**subvol=****path**
Mount subvolume from
_path_
rather than the toplevel subvolume. The
_path_
is always treated as relative to the toplevel subvolume. This mount option overrides the default subvolume set for the given filesystem.

**subvolid=****subvolid**
Mount subvolume specified by a
_subvolid_
number rather than the toplevel subvolume. You can use
**btrfs subvolume list**
of
**btrfs subvolume show**
to see subvolume ID numbers. This mount option overrides the default subvolume set for the given filesystem.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
if both
_subvolid_
and
_subvol_
are specified, they must point at the same subvolume, otherwise the mount will fail.


**thread\_pool=****number**
(default: min(NRCPUS + 2, 8) )

The number of worker threads to start. NRCPUS is number of on-line CPUs detected at the time of mount. Small number leads to less parallelism in processing data and metadata, higher numbers could lead to a performance hit due to increased locking contention, process scheduling, cache-line bouncing or costly data transfers between local CPU memories.

**treelog**, **notreelog**
(default: on)

Enable the tree logging used for
_fsync_
and
_O\_SYNC_
writes. The tree log stores changes without the need of a full filesystem sync. The log operations are flushed at sync and transaction commit. If the system crashes between two such syncs, the pending tree log operations are replayed during mount.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
currently, the tree log is replayed even with a read-only mount! To disable that behaviour, also mount with
_nologreplay_.

The tree log could contain new files/directories, these would not exist on a mounted filesystem if the log is not replayed.

**usebackuproot**, **nousebackuproot**
(since: 4.6, default: off)

Enable autorecovery attempts if a bad tree root is found at mount time. Currently this scans a backup list of several previous tree roots and tries to use the first readable. This can be used with read-only mounts as well.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
This option has replaced
_recovery_.


**user\_subvol\_rm\_allowed**
(default: off)

Allow subvolumes to be deleted by their respective owner. Otherwise, only the root user can do that.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
historically, any user could create a snapshot even if he was not owner of the source subvolume, the subvolume deletion has been restricted for that reason. The subvolume creation has been restricted but this mount option is still required. This is a usability issue. Since 4.18, the
**rmdir**(2) syscall can delete an empty subvolume just like an ordinary directory. Whether this is possible can be detected at runtime, see
_rmdir\_subvol_
feature in
_FILESYSTEM FEATURES_.


<a name="deprecated-mount-options"></a>

### DEPRECATED MOUNT OPTIONS


List of mount options that have been removed, kept for backward compatibility.

**alloc\_start=****bytes**
(default: 1M, minimum: 1M, deprecated since: 4.13)

Debugging option to force all block allocations above a certain byte threshold on each block device. The value is specified in bytes, optionally with a K, M, or G suffix (case insensitive).

**recovery**
(since: 3.2, default: off, deprecated since: 4.5)
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
this option has been replaced by
_usebackuproot_
and should not be used but will work on 4.5+ kernels.


**subvolrootid=****objectid**
(irrelevant since: 3.2, formally deprecated since: 3.10)

A workaround option from times (pre 3.2) when it was not possible to mount a subvolume that did not reside directly under the toplevel subvolume.

<a name="notes-on-generic-mount-options"></a>

### NOTES ON GENERIC MOUNT OPTIONS


Some of the general mount options from **mount**(8) that affect BTRFS and are worth mentioning.

**noatime**
under read intensive work-loads, specifying
_noatime_
significantly improves performance because no new access time information needs to be written. Without this option, the default is
_relatime_, which only reduces the number of inode atime updates in comparison to the traditional
_strictatime_. The worst case for atime updates under
_relatime_
occurs when many files are read whose atime is older than 24 h and which are freshly snapshotted. In that case the atime is updated
_and_
COW happens - for each file - in bulk. See also
\m[blue]**https://lwn.net/Articles/499293/**\m[]
-
_Atime and btrfs: a bad combination? (LWN, 2012-05-31)_.

Note that
_noatime_
may break applications that rely on atime uptimes like the venerable Mutt (unless you use maildir mailboxes).

<a name="filesystem-features"></a>

# Filesystem Features


The basic set of filesystem features gets extended over time. The backward compatibility is maintained and the features are optional, need to be explicitly asked for so accidental use will not create incompatibilities.

There are several classes and the respective tools to manage the features:

at mkfs time only
This is namely for core structures, like the b-tree nodesize or checksum algorithm, see
**mkfs.btrfs**(8) for more details.

after mkfs, on an unmounted filesystem
Features that may optimize internal structures or add new structures to support new functionality, see
**btrfstune**(8). The command
**btrfs inspect-internal dump-super device**
will dump a superblock, you can map the value of
_incompat\_flags_
to the features listed below

after mkfs, on a mounted filesystem
The features of a filesystem (with a given UUID) are listed in
**/sys/fs/btrfs/UUID/features/**, one file per feature. The status is stored inside the file. The value
_1_
is for enabled and active, while
_0_
means the feature was enabled at mount time but turned off afterwards.

Whether a particular feature can be turned on a mounted filesystem can be found in the directory
**/sys/fs/btrfs/features/**, one file per feature. The value
_1_
means the feature can be enabled.

List of features (see also **mkfs.btrfs**(8) section _FILESYSTEM FEATURES_):

**big\_metadata**
(since: 3.4)

the filesystem uses
_nodesize_
for metadata blocks, this can be bigger than the page size

**compress\_lzo**
(since: 2.6.38)

the
_lzo_
compression has been used on the filesystem, either as a mount option or via
**btrfs filesystem defrag**.

**compress\_zstd**
(since: 4.14)

the
_zstd_
compression has been used on the filesystem, either as a mount option or via
**btrfs filesystem defrag**.

**default\_subvol**
(since: 2.6.34)

the default subvolume has been set on the filesystem

**extended\_iref**
(since: 3.7)

increased hardlink limit per file in a directory to 65536, older kernels supported a varying number of hardlinks depending on the sum of all file name sizes that can be stored into one metadata block

**free\_space\_tree**
(since: 4.5)

free space representation using a dedicated b-tree, successor of v1 space cache

**metadata\_uuid**
(since: 5.0)

the main filesystem UUID is the metadata_uuid, which stores the new UUID only in the superblock while all metadata blocks still have the UUID set at mkfs time, see
**btrfstune**(8) for more

**mixed\_backref**
(since: 2.6.31)

the last major disk format change, improved backreferences, now default

**mixed\_groups**
(since: 2.6.37)

mixed data and metadata block groups, ie. the data and metadata are not separated and occupy the same block groups, this mode is suitable for small volumes as there are no constraints how the remaining space should be used (compared to the split mode, where empty metadata space cannot be used for data and vice versa)

on the other hand, the final layout is quite unpredictable and possibly highly fragmented, which means worse performance

**no\_holes**
(since: 3.14)

improved representation of file extents where holes are not explicitly stored as an extent, saves a few percent of metadata if sparse files are used

**raid1c34**
(since: 5.5)

extended RAID1 mode with copies on 3 or 4 devices respectively

**raid56**
(since: 3.9)

the filesystem contains or contained a raid56 profile of block groups

**rmdir\_subvol**
(since: 4.18)

indicate that
**rmdir**(2) syscall can delete an empty subvolume just like an ordinary directory. Note that this feature only depends on the kernel version.

**skinny\_metadata**
(since: 3.10)

reduced-size metadata for extent references, saves a few percent of metadata

**supported\_checksums**
(since: 5.5)

list of checksum algorithms supported by the kernel module, the respective modules or built-in implementing the algorithms need to be present to mount the filesystem

<a name="swapfile-support"></a>

### SWAPFILE SUPPORT


The swapfile is supported since kernel 5.0. Use **swapon**(8) to activate the swapfile. There are some limitations of the implementation in btrfs and linux swap subsystem:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  filesystem - must be only single device

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  swapfile - the containing subvolume cannot be snapshotted

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  swapfile - must be preallocated

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  swapfile - must be nodatacow (ie. also nodatasum)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  swapfile - must not be compressed

The limitations come namely from the COW-based design and mapping layer of blocks that allows the advanced features like relocation and multi-device filesystems. However, the swap subsystem expects simpler mapping and no background changes of the file blocks once they’ve been attached to swap.

With active swapfiles, the following whole-filesystem operations will skip swapfile extents or may fail:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  balance - block groups with swapfile extents are skipped and reported, the rest will be processed normally

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  resize grow - unaffected

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  resize shrink - works as long as the extents are outside of the shrunk range

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  device add - a new device does not interfere with existing swapfile and this operation will work, though no new swapfile can be activated afterwards

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  device delete - if the device has been added as above, it can be also deleted

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  device replace - ditto

When there are no active swapfiles and a whole-filesystem exclusive operation is running (ie. balance, device delete, shrink), the swapfiles cannot be temporarily activated. The operation must finish first.

.if n \{.RS 4
.\}
    # truncate -s 0 swapfile
    # chattr +C swapfile
    # fallocate -l 2G swapfile
    # chmod 0600 swapfile
    # mkswap swapfile
    # swapon swapfile
.if n \{.RE
.\}

<a name="checksum-algorithms"></a>

# Checksum Algorithms


There are several checksum algorithms supported. The default and backward compatible is _crc32c_. Since kernel 5.5 there are three more with different characteristics and trade-offs regarding speed and strength. The following list may help you to decide which one to select.

**CRC32C** (32bit digest)
default, best backward compatibility, very fast, modern CPUs have instruction-level support, not collision-resistant but still good error detection capabilities

**XXHASH** (64bit digest)
can be used as CRC32C successor, very fast, optimized for modern CPUs utilizing instruction pipelining, good collision resistance and error detection

**SHA256** (256bit digest)
a cryptographic-strength hash, relatively slow but with possible CPU instruction acceleration or specialized hardware cards, FIPS certified and in wide use

**BLAKE2b** (256bit digest)
a cryptographic-strength hash, relatively fast with possible CPU acceleration using SIMD extensions, not standardized but based on BLAKE which was a SHA3 finalist, in wide use, the algorithm used is BLAKE2b-256 that’s optimized for 64bit platforms

The _digest size_ affects overall size of data block checksums stored in the filesystem. The metadata blocks have a fixed area up to 256bits (32 bytes), so there’s no increase. Each data block has a separate checksum stored, with additional overhead of the b-tree leaves.

Approximate relative performance of the algorithms, measured against CRC32C using reference software implementations on a 3.5GHz intel CPU:
.TS
allbox tab(:);
ct rt rt
ct rt rt
ct rt rt
ct rt rt
ct rt rt.
T{

**Digest**
T}:T{

**Cycles/4KiB**
T}:T{

**Ratio**
T}
T{

CRC32C
T}:T{

1700
T}:T{

1.00
T}
T{

XXHASH
T}:T{

2500
T}:T{

1.44
T}
T{

SHA256
T}:T{

105000
T}:T{

61
T}
T{

BLAKE2b
T}:T{

22000
T}:T{

13
T}
.TE


<a name="filesystem-limits"></a>

# Filesystem Limits


maximum file name length
255

maximum symlink target length
depends on the
_nodesize_
value, for 4k it’s 3949 bytes, for larger nodesize it’s 4095 due to the system limit PATH_MAX

The symlink target may not be a valid path, ie. the path name components can exceed the limits (NAME_MAX), there’s no content validation at
**symlink**(3) creation.

maximum number of inodes
2^64 but depends on the available metadata space as the inodes are created dynamically

inode numbers
minimum number: 256 (for subvolumes), regular files and directories: 257

maximum file length
inherent limit of btrfs is 2^64 (16 EiB) but the linux VFS limit is 2^63 (8 EiB)

maximum number of subvolumes
the subvolume ids can go up to 2^64 but the number of actual subvolumes depends on the available metadata space, the space consumed by all subvolume metadata includes bookkeeping of shared extents can be large (MiB, GiB)

maximum number of hardlinks of a file in a directory
65536 when the
**extref**
feature is turned on during mkfs (default), roughly 100 otherwise

<a name="bootloader-support"></a>

# Bootloader Support


GRUB2 (\m[blue]**https://www.gnu.org/software/grub**\m[]) has the most advanced support of booting from BTRFS with respect to features.

U-boot (\m[blue]**https://www.denx.de/wiki/U-Boot/**\m[]) has decent support for booting but not all BTRFS features are implemented, check the documentation.

EXTLINUX (from the \m[blue]**https://syslinux.org**\m[] project) can boot but does not support all features. Please check the upstream documentation before you use it.

The first 1MiB on each device is unused with the exception of primary superblock that is on the offset 64KiB and spans 4KiB.

<a name="file-attributes"></a>

# File Attributes


The btrfs filesystem supports setting file attributes or flags. Note there are old and new interfaces, with confusing names. The following list should clarify that:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _attributes_:
  **chattr**(1) or
  **lsattr**(1) utilities (the ioctls are FS_IOC_GETFLAGS and FS_IOC_SETFLAGS), due to the ioctl names the attributes are also called flags

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _xflags_: to distinguish from the previous, it’s extended flags, with tunable bits similar to the attributes but extensible and new bits will be added in the future (the ioctls are FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR but they are not related to extended attributes that are also called xattrs), there’s no standard tool to change the bits, there’s support in
  **xfs\_io**(8) as command
  **xfs_io -c chattr**

<a name="attributes"></a>

### ATTRIBUTES


**a**
_append only_, new writes are always written at the end of the file

**A**
_no atime updates_

**c**
_compress data_, all data written after this attribute is set will be compressed. Please note that compression is also affected by the mount options or the parent directory attributes.

When set on a directory, all newly created files will inherit this attribute.

**C**
_no copy-on-write_, file data modifications are done in-place

When set on a directory, all newly created files will inherit this attribute.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
due to implementation limitations, this flag can be set/unset only on empty files.


**d**
_no dump_, makes sense with 3rd party tools like
**dump**(8), on BTRFS the attribute can be set/unset but no other special handling is done

**D**
_synchronous directory updates_, for more details search
**open**(2) for
_O\_SYNC_
and
_O\_DSYNC_

**i**
_immutable_, no file data and metadata changes allowed even to the root user as long as this attribute is set (obviously the exception is unsetting the attribute)

**S**
_synchronous updates_, for more details search
**open**(2) for
_O\_SYNC_
and
_O\_DSYNC_

**X**
_no compression_, permanently turn off compression on the given file. Any compression mount options will not affect this file.

When set on a directory, all newly created files will inherit this attribute.

No other attributes are supported. For the complete list please refer to the **chattr**(1) manual page.

<a name="xflags"></a>

### XFLAGS


There’s overlap of letters assigned to the bits with the attributes, this list refers to what **xfs\_io**(8) provides:

**i**
_immutable_, same as the attribute

**a**
_append only_, same as the attribute

**s**
_synchronous updates_, same as the atribute
_S_

**A**
_no atime updates_, same as the attribute

**d**
_no dump_, same as the attribute

<a name="control-device"></a>

# Control Device


There’s a character special device **/dev/btrfs-control** with major and minor numbers 10 and 234 (the device can be found under the _misc_ category).

.if n \{.RS 4
.\}
    $ ls -l /dev/btrfs-control
    crw------- 1 root root 10, 234 Jan  1 12:00 /dev/btrfs-control
.if n \{.RE
.\}

The device accepts some ioctl calls that can perform following actions on the filesystem module:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  scan devices for btrfs filesystem (ie. to let multi-device filesystems mount automatically) and register them with the kernel module

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  similar to scan, but also wait until the device scanning process is finished for a given filesystem

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  get the supported features (can be also found under
  _/sys/fs/btrfs/features_)

The device is usually created by a system device node manager (eg. udev), but can be created manually:

.if n \{.RS 4
.\}
    # mknod --mode=600 c 10 234 /dev/btrfs-control
.if n \{.RE
.\}

The control device is not strictly required but the device scanning will not work and a workaround would need to be used to mount a multi-device filesystem. The mount option _device_ can trigger the device scanning during mount.

<a name="filesystem-with-multiple-profiles"></a>

# Filesystem with Multiple Profiles


It is possible that a btrfs filesystem contains multiple block group profiles of the same type. This could happen when a profile conversion using balance filters is interrupted (see **btrfs-balance**(8)). Some _btrfs_ commands perform a test to detect this kind of condition and print a warning like this:

.if n \{.RS 4
.\}
    WARNING: Multiple block group profiles detected, see man btrfs(5)*(Aq.
    WARNING:   Data: single, raid1
    WARNING:   Metadata: single, raid1
.if n \{.RE
.\}

The corresponding output of **btrfs filesystem df** might look like:

.if n \{.RS 4
.\}
    WARNING: Multiple block group profiles detected, see man btrfs(5)*(Aq.
    WARNING:   Data: single, raid1
    WARNING:   Metadata: single, raid1
    Data, RAID1: total=832.00MiB, used=0.00B
    Data, single: total=1.63GiB, used=0.00B
    System, single: total=4.00MiB, used=16.00KiB
    Metadata, single: total=8.00MiB, used=112.00KiB
    Metadata, RAID1: total=64.00MiB, used=32.00KiB
    GlobalReserve, single: total=16.25MiB, used=0.00B
.if n \{.RE
.\}

There’s more than one line for type _Data_ and _Metadata_, while the profiles are _single_ and _RAID1_.

This state of the filesystem OK but most likely needs the user/administrator to take an action and finish the interrupted tasks. This cannot be easily done automatically, also the user knows the expected final profiles.

In the example above, the filesystem started as a single device and _single_ block group profile. Then another device was added, followed by balance with _convert=raid1_ but for some reason hasn’t finished. Restarting the balance with _convert=raid1_ will continue and end up with filesystem with all block group profiles _RAID1_.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

If you’re familiar with balance filters, you can use _convert=raid1,profiles=single,soft_, which will take only the unconverted _single_ profiles and convert them to _raid1_. This may speed up the conversion as it would not try to rewrite the already convert _raid1_ profiles.


Having just one profile is desired as this also clearly defines the profile of newly allocated block groups, otherwise this depends on internal allocation policy. When there are multiple profiles present, the order of selection is RAID6, RAID5, RAID10, RAID1, RAID0 as long as the device number constraints are satisfied.

Commands that print the warning were chosen so they’re brought to user attention when the filesystem state is being changed in that regard. This is: _device add_, _device delete_, _balance cancel_, _balance pause_. Commands that report space usage: _filesystem df_, _device usage_. The command _filesystem usage_ provides a line in the overall summary:

.if n \{.RS 4
.\}
        Multiple profiles:                 yes (data, metadata)
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**acl**(5), **btrfs**(8), **chattr**(1), **fstrim**(8), **ioctl**(2), **mkfs.btrfs**(8), **mount**(8), **swapon**(8)
