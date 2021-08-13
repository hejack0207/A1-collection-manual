# btrfs\-balance(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-balance - balance block groups on a btrfs filesystem

<a name="synopsis"></a>

# Synopsis

```

 btrfs balance <subcommand> <args>
```

<a name="description"></a>

# Description


The primary purpose of the balance feature is to spread block groups across all devices so they match constraints defined by the respective profiles. See **mkfs.btrfs**(8) section _PROFILES_ for more details. The scope of the balancing process can be further tuned by use of filters that can select the block groups to process. Balance works only on a mounted filesystem. Extent sharing is preserved and reflinks are not broken. Files are not defragmented nor recompressed, file extents are preserved but the physical location on devices will change.

The balance operation is cancellable by the user. The on-disk state of the filesystem is always consistent so an unexpected interruption (eg. system crash, reboot) does not corrupt the filesystem. The progress of the balance operation is temporarily stored as an internal state and will be resumed upon mount, unless the mount option _skip\_balance_ is specified.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

running balance without filters will take a lot of time as it basically move data/metadata from the whol filesystem and needs to update all block pointers.


The filters can be used to perform following actions:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  convert block group profiles (filter
  _convert_)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  make block group usage more compact (filter
  _usage_)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  perform actions only on a given device (filters
  _devid_,
  _drange_)

The filters can be applied to a combination of block group types (data, metadata, system). Note that changing only the _system_ type needs the force option. Otherwise _system_ gets automatically converted whenver _metadata_ profile is converted.

When metadata redundancy is reduced (eg. from RAID1 to single) the force option is also required and it is noted in system log.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

the balance operation needs enough work space, ie. space that is completely unused in the filesystem, otherwise this may lead to ENOSPC reports. See the section _ENOSPC_ for more details.


<a name="compatibility"></a>

# Compatibility

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

The balance subcommand also exists under the **btrfs filesystem** namespace. This still works for backward compatibility but is deprecated and should not be used any more.

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

A short syntax **btrfs balance ****&lt;path&gt;** works due to backward compatibility but is deprecated and should not be used any more. Use **btrfs balance start** command instead.


<a name="performance-implications"></a>

# Performance Implications


Balancing operations are very IO intensive and can also be quite CPU intensive, impacting other ongoing filesystem operations. Typically large amounts of data are copied from one location to another, with corresponding metadata updates.

Depending upon the block group layout, it can also be seek heavy. Performance on rotational devices is noticeably worse compared to SSDs or fast arrays.

<a name="subcommand"></a>

# Subcommand


**cancel** _&lt;path&gt;_
cancels a running or paused balance, the command will block and wait until the current blockgroup being processed completes

Since kernel 5.7 the response time of the cancellation is significantly improved, on older kernels it might take a long time until currently processed chunk is completely finished.

**pause** _&lt;path&gt;_
pause running balance operation, this will store the state of the balance progress and used filters to the filesystem

**resume** _&lt;path&gt;_
resume interrupted balance, the balance status must be stored on the filesystem from previous run, eg. after it was paused or forcibly interrupted and mounted again with
_skip\_balance_

**start** [options] _&lt;path&gt;_
start the balance operation according to the specified filters, without any filters the data and metadata from the whole filesystem are moved. The process runs in the foreground.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
the balance command without filters will basically move everything in the filesystem to a new physical location on devices (ie. it does not affect the logical properties of file extents like offsets within files and extent sharing). The run time is potentially very long, depending on the filesystem size. To prevent starting a full balance by accident, the user is warned and has a few seconds to cancel the operation before it starts. The warning and delay can be skipped with
_--full-balance_
option.

Please note that the filters must be written together with the
_-d_,
_-m_
and
_-s_
options, because they’re optional and bare
_-d_
and
_-m_
also work and mean no filters.

**Options**

-d[_&lt;filters&gt;_]
act on data block groups, see
**FILTERS**
section for details about
_filters_

-m[_&lt;filters&gt;_]
act on metadata chunks, see
**FILTERS**
section for details about
_filters_

-s[_&lt;filters&gt;_]
act on system chunks (requires
_-f_), see
**FILTERS**
section for details about
_filters_.

-f
force a reduction of metadata integrity, eg. when going from
_raid1_
to
_single_

--background|--bg
run the balance operation asynchronously in the background, uses
**fork**(2) to start the process that calls the kernel ioctl

-v
(deprecated) alias for global
_-v_
option

**status** [-v] _&lt;path&gt;_
Show status of running or paused balance.

**Options**

-v
(deprecated) alias for global
_-v_
option

<a name="filters"></a>

# Filters


From kernel 3.3 onwards, btrfs balance can limit its action to a subset of the whole filesystem, and can be used to change the replication configuration (e.g. moving data from single to RAID1). This functionality is accessed through the _-d_, _-m_ or _-s_ options to btrfs balance start, which filter on data, metadata and system blocks respectively.

A filter has the following structure: _type_[=_params_][,_type_=...]

The available types are:

**profiles=****&lt;profiles&gt;**
Balances only block groups with the given profiles. Parameters are a list of profile names separated by "_|_" (pipe).

**usage=****&lt;percent&gt;**, **usage=****&lt;range&gt;**
Balances only block groups with usage under the given percentage. The value of 0 is allowed and will clean up completely unused block groups, this should not require any new work space allocated. You may want to use
_usage=0_
in case balance is returning ENOSPC and your filesystem is not too full.

The argument may be a single value or a range. The single value
_N_
means
_at most N percent used_, equivalent to
_..N_
range syntax. Kernels prior to 4.4 accept only the single value format. The minimum range boundary is inclusive, maximum is exclusive.

**devid=****&lt;id&gt;**
Balances only block groups which have at least one chunk on the given device. To list devices with ids use
**btrfs filesystem show**.

**drange=****&lt;range&gt;**
Balance only block groups which overlap with the given byte range on any device. Use in conjunction with
_devid_
to filter on a specific device. The parameter is a range specified as
_start..end_.

**vrange=****&lt;range&gt;**
Balance only block groups which overlap with the given byte range in the filesystem’s internal virtual address space. This is the address space that most reports from btrfs in the kernel log use. The parameter is a range specified as
_start..end_.

**convert=****&lt;profile&gt;**
Convert each selected block group to the given profile name identified by parameters.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
starting with kernel 4.5, the
_data_
chunks can be converted to/from the
_DUP_
profile on a single device.

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
starting with kernel 4.6, all profiles can be converted to/from
_DUP_
on multi-device filesystems.


**limit=****&lt;number&gt;**, **limit=****&lt;range&gt;**
Process only given number of chunks, after all filters are applied. This can be used to specifically target a chunk in connection with other filters (_drange_,
_vrange_) or just simply limit the amount of work done by a single balance run.

The argument may be a single value or a range. The single value
_N_
means
_at most N chunks_, equivalent to
_..N_
range syntax. Kernels prior to 4.4 accept only the single value format. The range minimum and maximum are inclusive.

**stripes=****&lt;range&gt;**
Balance only block groups which have the given number of stripes. The parameter is a range specified as
_start..end_. Makes sense for block group profiles that utilize striping, ie. RAID0/10/5/6. The range minimum and maximum are inclusive.

**soft**
Takes no parameters. Only has meaning when converting between profiles. When doing convert from one profile to another and soft mode is on, chunks that already have the target profile are left untouched. This is useful e.g. when half of the filesystem was converted earlier but got cancelled.

The soft mode switch is (like every other filter) per-type. For example, this means that we can convert metadata chunks the "hard" way while converting data chunks selectively with soft switch.

Profile names, used in _profiles_ and _convert_ are one of: _raid0_, _raid1_, _raid10_, _raid5_, _raid6_, _dup_, _single_. The mixed data/metadata profiles can be converted in the same way, but it’s conversion between mixed and non-mixed is not implemented. For the constraints of the profiles please refer to **mkfs.btrfs**(8), section _PROFILES_.

<a name="enospc"></a>

# Enospc


The way balance operates, it usually needs to temporarily create a new block group and move the old data there, before the old block group can be removed. For that it needs the work space, otherwise it fails for ENOSPC reasons. This is not the same ENOSPC as if the free space is exhausted. This refers to the space on the level of block groups, which are bigger parts of the filesystem that contain many file extents.

The free work space can be calculated from the output of the **btrfs filesystem show** command:

.if n \{.RS 4
.\}
       Label: BTRFS*(Aq  uuid: 8a9d72cd-ead3-469d-b371-9c7203276265
               Total devices 2 FS bytes used 77.03GiB
               devid    1 size 53.90GiB used 51.90GiB path /dev/sdc2
               devid    2 size 53.90GiB used 51.90GiB path /dev/sde1
.if n \{.RE
.\}

_size_ - _used_ = _free work space_ _53.90GiB_ - _51.90GiB_ = _2.00GiB_

An example of a filter that does not require workspace is _usage=0_. This will scan through all unused block groups of a given type and will reclaim the space. After that it might be possible to run other filters.

**CONVERSIONS ON MULTIPLE DEVICES**

Conversion to profiles based on striping (RAID0, RAID5/6) require the work space on each device. An interrupted balance may leave partially filled block groups that consume the work space.

<a name="examples"></a>

# Examples


A more comprehensive example when going from one to multiple devices, and back, can be found in section _TYPICAL USECASES_ of **btrfs-device**(8).

<a name="making-block-group-layout-more-compact"></a>

### MAKING BLOCK GROUP LAYOUT MORE COMPACT


The layout of block groups is not normally visible; most tools report only summarized numbers of free or used space, but there are still some hints provided.

Let’s use the following real life example and start with the output:

.if n \{.RS 4
.\}
    $ btrfs filesystem df /path
    Data, single: total=75.81GiB, used=64.44GiB
    System, RAID1: total=32.00MiB, used=20.00KiB
    Metadata, RAID1: total=15.87GiB, used=8.84GiB
    GlobalReserve, single: total=512.00MiB, used=0.00B
.if n \{.RE
.\}

Roughly calculating for data, _75G - 64G = 11G_, the used/total ratio is about _85%_. How can we can interpret that:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  chunks are filled by 85% on average, ie. the
  _usage_
  filter with anything smaller than 85 will likely not affect anything

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  in a more realistic scenario, the space is distributed unevenly, we can assume there are completely used chunks and the remaining are partially filled

Compacting the layout could be used on both. In the former case it would spread data of a given chunk to the others and removing it. Here we can estimate that roughly 850 MiB of data have to be moved (85% of a 1 GiB chunk).

In the latter case, targeting the partially used chunks will have to move less data and thus will be faster. A typical filter command would look like:

.if n \{.RS 4
.\}
    # btrfs balance start -dusage=50 /path
    Done, had to relocate 2 out of 97 chunks
    
    $ btrfs filesystem df /path
    Data, single: total=74.03GiB, used=64.43GiB
    System, RAID1: total=32.00MiB, used=20.00KiB
    Metadata, RAID1: total=15.87GiB, used=8.84GiB
    GlobalReserve, single: total=512.00MiB, used=0.00B
.if n \{.RE
.\}

As you can see, the _total_ amount of data is decreased by just 1 GiB, which is an expected result. Let’s see what will happen when we increase the estimated usage filter.

.if n \{.RS 4
.\}
    # btrfs balance start -dusage=85 /path
    Done, had to relocate 13 out of 95 chunks
    
    $ btrfs filesystem df /path
    Data, single: total=68.03GiB, used=64.43GiB
    System, RAID1: total=32.00MiB, used=20.00KiB
    Metadata, RAID1: total=15.87GiB, used=8.85GiB
    GlobalReserve, single: total=512.00MiB, used=0.00B
.if n \{.RE
.\}

Now the used/total ratio is about 94% and we moved about _74G - 68G = 6G_ of data to the remaining blockgroups, ie. the 6GiB are now free of filesystem structures, and can be reused for new data or metadata block groups.

We can do a similar exercise with the metadata block groups, but this should not typically be necessary, unless the used/total ratio is really off. Here the ratio is roughly 50% but the difference as an absolute number is "a few gigabytes", which can be considered normal for a workload with snapshots or reflinks updated frequently.

.if n \{.RS 4
.\}
    # btrfs balance start -musage=50 /path
    Done, had to relocate 4 out of 89 chunks
    
    $ btrfs filesystem df /path
    Data, single: total=68.03GiB, used=64.43GiB
    System, RAID1: total=32.00MiB, used=20.00KiB
    Metadata, RAID1: total=14.87GiB, used=8.85GiB
    GlobalReserve, single: total=512.00MiB, used=0.00B
.if n \{.RE
.\}

Just 1 GiB decrease, which possibly means there are block groups with good utilization. Making the metadata layout more compact would in turn require updating more metadata structures, ie. lots of IO. As running out of metadata space is a more severe problem, it’s not necessary to keep the utilization ratio too high. For the purpose of this example, let’s see the effects of further compaction:

.if n \{.RS 4
.\}
    # btrfs balance start -musage=70 /path
    Done, had to relocate 13 out of 88 chunks
    
    $ btrfs filesystem df .
    Data, single: total=68.03GiB, used=64.43GiB
    System, RAID1: total=32.00MiB, used=20.00KiB
    Metadata, RAID1: total=11.97GiB, used=8.83GiB
    GlobalReserve, single: total=512.00MiB, used=0.00B
.if n \{.RE
.\}

<a name="getting-rid-of-completely-unused-block-groups"></a>

### GETTING RID OF COMPLETELY UNUSED BLOCK GROUPS


Normally the balance operation needs a work space, to temporarily move the data before the old block groups gets removed. If there’s no work space, it ends with _no space left_.

There’s a special case when the block groups are completely unused, possibly left after removing lots of files or deleting snapshots. Removing empty block groups is automatic since 3.18. The same can be achieved manually with a notable exception that this operation does not require the work space. Thus it can be used to reclaim unused block groups to make it available.

.if n \{.RS 4
.\}
    # btrfs balance start -dusage=0 /path
.if n \{.RE
.\}

This should lead to decrease in the _total_ numbers in the **btrfs filesystem df** output.

<a name="exit-status"></a>

# Exit Status


Unless indicated otherwise below, all **btrfs balance** subcommands return a zero exit status if they succeed, and non zero in case of failure.

The **pause**, **cancel**, and **resume** subcommands exit with a status of **2** if they fail because a balance operation was not running.

The **status** subcommand exits with a status of **0** if a balance operation is not running, **1** if the command-line usage is incorrect or a balance operation is still running, and **2** on other errors.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **btrfs-device**(8)
