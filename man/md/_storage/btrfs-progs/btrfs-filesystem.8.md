# btrfs\-filesystem(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-filesystem - command group that primarily does work on the whole filesystems

<a name="synopsis"></a>

# Synopsis

```

 btrfs filesystem <subcommand> <args>
```

<a name="description"></a>

# Description


**btrfs filesystem** is used to perform several whole filesystem level tasks, including all the regular filesystem operations like resizing, space stats, label setting/getting, and defragmentation. There are other whole filesystem tasks like scrub or balance that are grouped in separate commands.

<a name="subcommand"></a>

# Subcommand


**df** [options] _&lt;path&gt;_
Show a terse summary information about allocation of block group types of a given mount point. The original purpose of this command was a debugging helper. The output needs to be further interpreted and is not suitable for quick overview.

An example with description:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  device size:
  _1.9TiB_, one device, no RAID

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  filesystem size:
  _1.9TiB_

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  created with:
  _mkfs.btrfs -d single -m single_

.if n \{.RS 4
.\}
    $ btrfs filesystem df /path
    Data, single: total=1.15TiB, used=1.13TiB
    System, single: total=32.00MiB, used=144.00KiB
    Metadata, single: total=12.00GiB, used=6.45GiB
    GlobalReserve, single: total=512.00MiB, used=0.00B
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Data_,
  _System_
  and
  _Metadata_
  are separate block group types.
  _GlobalReserve_
  is an artificial and internal emergency space, see below.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _single_ — the allocation profile, defined at mkfs time

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _total_ — sum of space reserved for all allocation profiles of the given type, ie. all Data/single. Note that it’s not total size of filesystem.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _used_ — sum of used space of the above, ie. file extents, metadata blocks

_GlobalReserve_
is an artificial and internal emergency space. It is used eg. when the filesystem is full. Its
_total_
size is dynamic based on the filesystem size, usually not larger than 512MiB,
_used_
may fluctuate.

The GlobalReserve is a portion of Metadata. In case the filesystem metadata is exhausted,
_GlobalReserve/total + Metadata/used = Metadata/total_. Otherwise there appears to be some unused space of Metadata.

**Options**

-b|--raw
raw numbers in bytes, without the
_B_
suffix

-h|--human-readable
print human friendly numbers, base 1024, this is the default

-H
print human friendly numbers, base 1000

--iec
select the 1024 base for the following options, according to the IEC standard

--si
select the 1000 base for the following options, according to the SI standard

-k|--kbytes
show sizes in KiB, or kB with --si

-m|--mbytes
show sizes in MiB, or MB with --si

-g|--gbytes
show sizes in GiB, or GB with --si

-t|--tbytes
show sizes in TiB, or TB with --si

If conflicting options are passed, the last one takes precedence.

**defragment** [options] _&lt;file&gt;_|_&lt;dir&gt;_ [_&lt;file&gt;_|_&lt;dir&gt;_...]
Defragment file data on a mounted filesystem. Requires kernel 2.6.33 and newer.

If
_-r_
is passed, files in dir will be defragmented recursively (not descending to subvolumes, mount points and directory symlinks). The start position and the number of bytes to defragment can be specified by start and length using
_-s_
and
_-l_
options below. Extents bigger than value given by
_-t_
will be skipped, otherwise this value is used as a target extent size, but is only advisory and may not be reached if the free space is too fragmented. Use 0 to take the kernel default, which is 256kB but may change in the future. You can also turn on compression in defragment operations.
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

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
Directory arguments without
_-r_
do not defragment files recursively but will defragment certain internal trees (extent tree and the subvolume tree). This has been confusing and could be removed in the future.

For
_start_,
_len_,
_size_
it is possible to append units designator: K\*(Aq, \*(AqM\*(Aq, \*(AqG\*(Aq, \*(AqT\*(Aq, \*(AqP\*(Aq, or \*(AqE\*(Aq, which represent KiB, MiB, GiB, TiB, PiB, or EiB, respectively (case does not matter).

**Options**

-c[_&lt;algo&gt;_]
compress file contents while defragmenting. Optional argument selects the compression algorithm,
_zlib_
(default),
_lzo_
or
_zstd_. Currently it’s not possible to select no compression. See also section
_EXAMPLES_.

-r
defragment files recursively in given directories, does not descend to subvolumes or mount points

-f
flush data for each file before going to the next file.

This will limit the amount of dirty data to current file, otherwise the amount accumulates from several files and will increase system load. This can also lead to ENOSPC if there’s too much dirty data to write and it’s not possible to make the reservations for the new data (ie. how the COW design works).

-s _&lt;start&gt;_[kKmMgGtTpPeE]
defragmentation will start from the given offset, default is beginning of a file

-l _&lt;len&gt;_[kKmMgGtTpPeE]
defragment only up to
_len_
bytes, default is the file size

-t _&lt;size&gt;_[kKmMgGtTpPeE]
target extent size, do not touch extents bigger than
_size_, default: 32M

The value is only advisory and the final size of the extents may differ, depending on the state of the free space and fragmentation or other internal logic. Reasonable values are from tens to hundreds of megabytes.

-v
(deprecated) alias for global
_-v_
option

**du** [options] _&lt;path&gt;_ [_&lt;path&gt;_..]
Calculate disk usage of the target files using FIEMAP. For individual files, it will report a count of total bytes, and exclusive (not shared) bytes. We also calculate a
_set shared_
value which is described below.

Each argument to
_btrfs filesystem du_
will have a
_set shared_
value calculated for it. We define each
_set_
as those files found by a recursive search of an argument (recursion descends to subvolumes but not mount points). The
_set shared_
value then is a sum of all shared space referenced by the set.

_set shared_
takes into account overlapping shared extents, hence it isn’t as simple as adding up shared extents.

**Options**

-s|--summarize
display only a total for each argument

--raw
raw numbers in bytes, without the
_B_
suffix.

--human-readable
print human friendly numbers, base 1024, this is the default

--iec
select the 1024 base for the following options, according to the IEC standard.

--si
select the 1000 base for the following options, according to the SI standard.

--kbytes
show sizes in KiB, or kB with --si.

--mbytes
show sizes in MiB, or MB with --si.

--gbytes
show sizes in GiB, or GB with --si.

--tbytes
show sizes in TiB, or TB with --si.

**label** [_&lt;device&gt;_|_&lt;mountpoint&gt;_] [_&lt;newlabel&gt;_]
Show or update the label of a filesystem. This works on a mounted filesystem or a filesystem image.

The
_newlabel_
argument is optional. Current label is printed if the argument is omitted.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
the maximum allowable length shall be less than 256 chars and must not contain a newline. The trailing newline is stripped automatically.


**resize** [_&lt;devid&gt;_:][+/-]_&lt;size&gt;_[kKmMgGtTpPeE]|[_&lt;devid&gt;_:]max _&lt;path&gt;_
Resize a mounted filesystem identified by
_path_. A particular device can be resized by specifying a
_devid_.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
If
_path_
is a file containing a BTRFS image then resize does not work as expected and does not resize the image. This would resize the underlying filesystem instead.

The
_devid_
can be found in the output of
**btrfs filesystem show**
and defaults to 1 if not specified. The
_size_
parameter specifies the new size of the filesystem. If the prefix
_+_
or
_-_
is present the size is increased or decreased by the quantity
_size_. If no units are specified, bytes are assumed for
_size_. Optionally, the size parameter may be suffixed by one of the following unit designators: K\*(Aq, \*(AqM\*(Aq, \*(AqG\*(Aq, \*(AqT\*(Aq, \*(AqP\*(Aq, or \*(AqE\*(Aq, which represent KiB, MiB, GiB, TiB, PiB, or EiB, respectively (case does not matter).

If
_max_
is passed, the filesystem will occupy all available space on the device respecting
_devid_
(remember, devid 1 by default).

The resize command does not manipulate the size of underlying partition. If you wish to enlarge/reduce a filesystem, you must make sure you can expand the partition before enlarging the filesystem and shrink the partition after reducing the size of the filesystem. This can done using
**fdisk**(8) or
**parted**(8) to delete the existing partition and recreate it with the new desired size. When recreating the partition make sure to use the same starting partition offset as before.

Growing is usually instant as it only updates the size. However, shrinking could take a long time if there are data in the device area that’s beyond the new end. Relocation of the data takes time.

See also section
_EXAMPLES_.

**show** [options] [_&lt;path&gt;_|_&lt;uuid&gt;_|_&lt;device&gt;_|_&lt;label&gt;_]
Show the btrfs filesystem with some additional info about devices and space allocation.

If no option none of
_path_/_uuid_/_device_/_label_
is passed, information about all the BTRFS filesystems is shown, both mounted and unmounted.

**Options**

-m|--mounted
probe kernel for mounted BTRFS filesystems

-d|--all-devices
scan all devices under /dev, otherwise the devices list is extracted from the /proc/partitions file. This is a fallback option if there’s no device node manager (like udev) available in the system.

--raw
raw numbers in bytes, without the
_B_
suffix

--human-readable
print human friendly numbers, base 1024, this is the default

--iec
select the 1024 base for the following options, according to the IEC standard

--si
select the 1000 base for the following options, according to the SI standard

--kbytes
show sizes in KiB, or kB with --si

--mbytes
show sizes in MiB, or MB with --si

--gbytes
show sizes in GiB, or GB with --si

--tbytes
show sizes in TiB, or TB with --si

**sync** _&lt;path&gt;_
Force a sync of the filesystem at
_path_, similar to the
**sync**(1) command. In addition, it starts cleaning of deleted subvolumes. To wait for the subvolume deletion to complete use the
**btrfs subvolume sync**
command.

**usage** [options] _&lt;path&gt;_ [_&lt;path&gt;_...]
Show detailed information about internal filesystem usage. This is supposed to replace the
**btrfs filesystem df**
command in the long run.

The level of detail can differ if the command is run under a regular or the root user (due to use of restricted ioctl). For both there’s a summary section with information about space usage:

.if n \{.RS 4
.\}
    $ btrfs filesystem usage /path
    WARNING: cannot read detailed chunk info, RAID5/6 numbers will be incorrect, run as root
    Overall:
        Device size:                   1.82TiB
        Device allocated:              1.17TiB
        Device unallocated:          669.99GiB
        Device missing:                  0.00B
        Used:                          1.14TiB
        Free (estimated):            692.57GiB      (min: 692.57GiB)
        Data ratio:                       1.00
        Metadata ratio:                   1.00
        Global reserve:              512.00MiB      (used: 0.00B)
        Multiple profiles:                  no
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Device size_ — sum of raw device capacity available to the filesystem

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Device allocated_ — sum of total space allocated for data/metadata/system profiles, this also accounts space reserved but not yet used for extents

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Device unallocated_ — the remaining unallocated space for future allocations (difference of the above two numbers)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Device missing_ — sum of capacity of all missing devices

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Used_ — sum of the used space of data/metadata/system profiles, not including the reserved space

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Free (estimated)_ — approximate size of the remaining free space usable for data, including currently allocated space and estimating the usage of the unallocated space based on the block group profiles, the
  _min_
  is the lower bound of the estimate in case multiple profiles are present

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Data ratio_ — ratio of total space for data including redundancy or parity to the effectively usable data space, eg. single is 1.0, RAID1 is 2.0 and for RAID5/6 it depends on the number of devices

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Metadata ratio_ — dtto, for metadata

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Global reserve_ — portion of metadata currently used for global block reserve, used for emergency purposes (like deletion on a full filesystem)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Multiple profiles_ — what block group types (data, metadata) have more than one profile (single, raid1, ...), see
  **btrfs**(5) section
  _FILESYSTEMS WITH MULTIPLE BLOCK GROUP PROFILES_.

The root user will also see stats broken down by block group types:

.if n \{.RS 4
.\}
    Data,single: Size:1.15TiB, Used:1.13TiB (98.26%)
       /dev/sdb        1.15TiB
    
    Metadata,single: Size:12.00GiB, Used:6.45GiB (53.75%)
       /dev/sdb       12.00GiB
    
    System,single: Size:32.00MiB, Used:144.00KiB (0.44%)
       /dev/sdb       32.00MiB
    
    Unallocated:
       /dev/sdb      669.99GiB
.if n \{.RE
.\}

_Data_
is block group type,
_single_
is block group profile,
_Size_
is total size occupied by this type,
_Used_
is the actually used space, the percent is ratio of
_Used/Size_. The
_Unallocated_
is remaining space.

**Options**

-b|--raw
raw numbers in bytes, without the
_B_
suffix

-h|--human-readable
print human friendly numbers, base 1024, this is the default

-H
print human friendly numbers, base 1000

--iec
select the 1024 base for the following options, according to the IEC standard

--si
select the 1000 base for the following options, according to the SI standard

-k|--kbytes
show sizes in KiB, or kB with --si

-m|--mbytes
show sizes in MiB, or MB with --si

-g|--gbytes
show sizes in GiB, or GB with --si

-t|--tbytes
show sizes in TiB, or TB with --si

-T
show data in tabular format

If conflicting options are passed, the last one takes precedence.

<a name="examples"></a>

# Examples


**$ btrfs filesystem defrag -v -r dir/**

Recursively defragment files under _dir/_, print files as they are processed. The file names will be printed in batches, similarly the amount of data triggered by defragmentation will be proportional to last N printed files. The system dirty memory throttling will slow down the defragmentation but there can still be a lot of IO load and the system may stall for a moment.

**$ btrfs filesystem defrag -v -r -f dir/**

Recursively defragment files under _dir/_, be verbose and wait until all blocks are flushed before processing next file. You can note slower progress of the output and lower IO load (proportional to currently defragmented file).

**$ btrfs filesystem defrag -v -r -f -clzo dir/**

Recursively defragment files under _dir/_, be verbose, wait until all blocks are flushed and force file compression.

**$ btrfs filesystem defrag -v -r -t 64M dir/**

Recursively defragment files under _dir/_, be verbose and try to merge extents to be about 64MiB. As stated above, the success rate depends on actual free space fragmentation and the final result is not guaranteed to meet the target even if run repeatedly.

**$ btrfs filesystem resize -1G /path**

**$ btrfs filesystem resize 1:-1G /path**

Shrink size of the filesystem’s device id 1 by 1GiB. The first syntax expects a device with id 1 to exist, otherwise fails. The second is equivalent and more explicit. For a single-device filesystem it’s typically not necessary to specify the devid though.

**$ btrfs filesystem resize max /path**

**$ btrfs filesystem resize 1:max /path**

Let’s assume that devid 1 exists and the filesystem does not occupy the whole block device, eg. it has been enlarged and we want to grow the filesystem. By simply using _max_ as size we will achieve that.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

There are two ways to minimize the filesystem on a given device. The **btrfs inspect-internal min-dev-size** command, or iteratively shrink in steps.


<a name="exit-status"></a>

# Exit Status


**btrfs filesystem** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**btrfs-subvolume**(8), **mkfs.btrfs**(8),
