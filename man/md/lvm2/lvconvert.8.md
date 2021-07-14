# lvconvert(8) - Change logical volume layout

Red Hat, Inc., LVM TOOLS 2.02.183(2) (2018-12-07)


<a name="synopsis"></a>

# Synopsis

```
lvconvert option_args position_args
[ option_args ]
[ position_args ]

     --alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit
-b|--background
-H|--cache
--cachemetadataformat auto|1|2
--cachemode writethrough|writeback|passthrough
--cachepolicy String
--cachepool LV
--cachesettings String
-c|--chunksize Size[k|UNIT]
--commandprofile String
--config String
-d|--debug
--discards passdown|nopassdown|ignore
--driverloaded y|n
-f|--force
-h|--help
-i|--interval Number
--lockopt String
--longhelp
--merge
--mergemirrors
--mergesnapshot
--mergethin
--metadataprofile String
--mirrorlog core|disk
-m|--mirrors [+|-]Number
-n|--name String
--noudevsync
--originname LV
--poolmetadata LV
--poolmetadatasize Size[m|UNIT]
--poolmetadataspare y|n
--profile String
-q|--quiet
-r|--readahead auto|none|Number
-R|--regionsize Size[m|UNIT]
--repair
--replace PV
-s|--snapshot
--splitcache
--splitmirrors Number
--splitsnapshot
--startpoll
--stripes Number
-I|--stripesize Size[k|UNIT]
--swapmetadata
-t|--test
-T|--thin
--thinpool LV
--trackchanges
--type linear|striped|snapshot|mirror|raid|thin|cache|thin-pool|cache-pool
--uncache
--usepolicies
-v|--verbose
--version
-y|--yes
-Z|--zero y|n
```

<a name="description"></a>

# Description

lvconvert changes the LV type and includes utilities for LV data
maintenance. The LV type controls data layout and redundancy.
The LV type is also called the segment type or segtype.

To display the current LV type, run the command:

**lvs -o name,segtype**
_LV_

In some cases, an LV is a single device mapper (dm) layer above physical
devices.  In other cases, hidden LVs (dm devices) are layered between the
visible LV and physical devices.  LVs in the middle layers are called sub LVs.
A command run on a visible LV sometimes operates on a sub LV rather than
the specified LV.  In other cases, a sub LV must be specified directly on
the command line.

Sub LVs can be displayed with the command:

**lvs -a**

The
**linear**
type is equivalent to the
**striped**
type when one stripe exists.
In that case, the types can sometimes be used interchangably.

In most cases, the
**mirror**
type is deprecated and the
**raid1**
type should be used.  They are both implementations of mirroring.

Striped raid types are
**raid0/raid0\_meta**,
**raid5** (an alias for raid5_ls),
**raid6** (an alias for raid6_zr) and
**raid10** (an alias for raid10_near).

As opposed to mirroring, raid5 and raid6 stripe data and calculate parity
blocks. The parity blocks can be used for data block recovery in case
devices fail. A maximum number of one device in a raid5 LV may fail, and
two in case of raid6. Striped raid types typically rotate the parity and
data blocks for performance reasons, thus avoiding contention on a single
device. Specific arrangements of parity and data blocks (layouts) can be
used to optimize I/O performance, or to convert between raid levels.  See
**lvmraid**(7) for more information.

Layouts of raid5 rotating parity blocks can be: left-asymmetric
(raid5_la), left-symmetric (raid5_ls with alias raid5), right-asymmetric
(raid5_ra), right-symmetric (raid5_rs) and raid5_n, which doesn't rotate
parity blocks. Layouts of raid6 are: zero-restart (raid6_zr with alias
raid6), next-restart (raid6_nr), and next-continue (raid6_nc).

Layouts including _n allow for conversion between raid levels (raid5_n to
raid6 or raid5_n to striped/raid0/raid0_meta). Additionally, special raid6
layouts for raid level conversions between raid5 and raid6 are:
raid6_ls_6, raid6_rs_6, raid6_la_6 and raid6_ra_6. Those correspond to
their raid5 counterparts (e.g. raid5_rs can be directly converted to
raid6_rs_6 and vice-versa).

raid10 (an alias for raid10_near) is currently limited to one data copy
and even number of sub LVs. This is a mirror group layout, thus a single
sub LV may fail per mirror group without data loss.

Striped raid types support converting the layout, their stripesize and
their number of stripes.

The striped raid types combined with raid1 allow for conversion from
linear-&gt; striped/raid0/raid0_meta and vice-versa by e.g. linear &lt;-&gt; raid1
&lt;-&gt; raid5_n (then adding stripes) &lt;-&gt; striped/raid0/raid0_meta.

<a name="usage"></a>

# Usage

Convert LV to linear.  

**lvconvert** **--type** **linear** _LV_  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Convert LV to striped.  

**lvconvert** **--type** **striped** _LV_  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[ **-i**|**--interval** _Number_ ]  
[    **--stripes** _Number_ ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Convert LV to raid or change raid layout   
(a specific raid level must be used, e.g. raid1).  

**lvconvert** **--type** **raid** _LV_  
[ **-m**|**--mirrors** [**+**|**-**]_Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[ **-i**|**--interval** _Number_ ]  
[    **--stripes** _Number_ ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Convert LV to raid1 or mirror, or change number of mirror images.  

**lvconvert** **-m**|**--mirrors** [**+**|**-**]_Number_ _LV_  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[ **-i**|**--interval** _Number_ ]  
[    **--mirrorlog** **core**|**disk** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Convert raid LV to change number of stripe images.  

**lvconvert** **--stripes** _Number_ _LV__\_raid_  
[ **-i**|**--interval** _Number_ ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Convert raid LV to change the stripe size.  

**lvconvert** **-I**|**--stripesize** _Size_[k|UNIT] _LV__\_raid_  
[ **-i**|**--interval** _Number_ ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[ COMMON_OPTIONS ]  
-

Split images from a raid1 or mirror LV and use them to create a new LV.  

**lvconvert** **--splitmirrors** _Number_ **-n**|**--name** _LV__\_new_ _LV__\_cache\_mirror\_raid1_  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Split images from a raid1 LV and track changes to origin for later merge.  

**lvconvert** **--splitmirrors** _Number_ **--trackchanges** _LV__\_cache\_raid1_  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Merge LV images that were split from a raid1 LV.  

**lvconvert** **--mergemirrors** _VG_|_LV__\_linear\_raid_|_Tag_ ...  
[ COMMON_OPTIONS ]  
-

Convert LV to a thin LV, using the original LV as an external origin.  

**lvconvert** **--type** **thin** **--thinpool** _LV_ _LV__\_linear\_striped\_thin\_cache\_raid_  
[ **-T**|**--thin** ]  
[ **-r**|**--readahead** **auto**|**none**|_Number_ ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-Z**|**--zero** **y**|**n** ]  
[    **--originname** _LV__\_new_ ]  
[    **--poolmetadata** _LV_ ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--metadataprofile** _String_ ]  
[ COMMON_OPTIONS ]  
-

Convert LV to type cache.  

**lvconvert** **--type** **cache** **--cachepool** _LV_ _LV__\_linear\_striped\_thinpool\_raid_  
[ **-H**|**--cache** ]  
[ **-Z**|**--zero** **y**|**n** ]  
[ **-r**|**--readahead** **auto**|**none**|_Number_ ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--poolmetadata** _LV_ ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--metadataprofile** _String_ ]  
[ COMMON_OPTIONS ]  
-

Convert LV to type thin-pool.  

**lvconvert** **--type** **thin-pool** _LV__\_linear\_striped\_cache\_raid_  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ **-r**|**--readahead** **auto**|**none**|_Number_ ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-Z**|**--zero** **y**|**n** ]  
[    **--stripes** _Number_ ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--poolmetadata** _LV_ ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--metadataprofile** _String_ ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Convert LV to type cache-pool.  

**lvconvert** **--type** **cache-pool** _LV__\_linear\_striped\_raid_  
[ **-Z**|**--zero** **y**|**n** ]  
[ **-r**|**--readahead** **auto**|**none**|_Number_ ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--poolmetadata** _LV_ ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--metadataprofile** _String_ ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Separate and keep the cache pool from a cache LV.  

**lvconvert** **--splitcache** _LV__\_thinpool\_cache\_cachepool_  
[ COMMON_OPTIONS ]  
-

Merge thin LV into its origin LV.  

**lvconvert** **--mergethin** _LV__\_thin_ ...  
[ COMMON_OPTIONS ]  
-

Merge COW snapshot LV into its origin.  

**lvconvert** **--mergesnapshot** _LV__\_snapshot_ ...  
[ **-i**|**--interval** _Number_ ]  
[ COMMON_OPTIONS ]  
-

Combine a former COW snapshot (second arg) with a former   
origin LV (first arg) to reverse a splitsnapshot command.  

**lvconvert** **--type** **snapshot** _LV_ _LV__\_linear\_striped_  
[ **-s**|**--snapshot** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-Z**|**--zero** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Replace failed PVs in a raid or mirror LV.   
Repair a thin pool.   
Repair a cache pool.  

**lvconvert** **--repair** _LV__\_thinpool\_cache\_cachepool\_mirror\_raid_  
[ **-i**|**--interval** _Number_ ]  
[    **--usepolicies** ]  
[    **--poolmetadataspare** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Replace specific PV(s) in a raid LV with another PV.  

**lvconvert** **--replace** _PV_ _LV__\_raid_  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Poll LV to continue conversion.  

**lvconvert** **--startpoll** _LV__\_mirror\_raid_  
[ COMMON_OPTIONS ]  
-

Common options for command:
[ **-b**|**--background** ]  
[ **-f**|**--force** ]  
[    **--alloc** **contiguous**|**cling**|**cling\_by\_tags**|**normal**|**anywhere**|**inherit** ]  
[    **--noudevsync** ]

Common options for lvm:
[ **-d**|**--debug** ]  
[ **-h**|**--help** ]  
[ **-q**|**--quiet** ]  
[ **-t**|**--test** ]  
[ **-v**|**--verbose** ]  
[ **-y**|**--yes** ]  
[    **--commandprofile** _String_ ]  
[    **--config** _String_ ]  
[    **--driverloaded** **y**|**n** ]  
[    **--lockopt** _String_ ]  
[    **--longhelp** ]  
[    **--profile** _String_ ]  
[    **--version** ]

<a name="options"></a>

# Options

.HP
**--alloc** **contiguous**|**cling**|**cling\_by\_tags**|**normal**|**anywhere**|**inherit**  
Determines the allocation policy when a command needs to allocate
Physical Extents (PEs) from the VG. Each VG and LV has an allocation policy
which can be changed with vgchange/lvchange, or overriden on the
command line.
**normal** applies common sense rules such as not placing parallel stripes
on the same PV.
**inherit** applies the VG policy to an LV.
**contiguous** requires new PEs be placed adjacent to existing PEs.
**cling** places new PEs on the same PV as existing PEs in the same
stripe of the LV.
If there are sufficient PEs for an allocation, but normal does not
use them, **anywhere** will use them even if it reduces performance,
e.g. by placing two stripes on the same PV.
Optional positional PV args on the command line can also be used to limit
which PVs the command will use for allocation.
See **lvm**(8) for more information about allocation.
.HP
**-b**|**--background**  
If the operation requires polling, this option causes the command to
return before the operation is complete, and polling is done in the
background.
.HP
**-H**|**--cache**  
Specifies the command is handling a cache LV or cache pool.
See --type cache and --type cache-pool.
See **lvmcache**(7) for more information about LVM caching.
.HP
**--cachemetadataformat** **auto**|**1**|**2**  
Specifies the cache metadata format used by cache target.
.HP
**--cachemode** **writethrough**|**writeback**|**passthrough**  
Specifies when writes to a cache LV should be considered complete.
**writeback** considers a write complete as soon as it is
stored in the cache pool.
**writethough** considers a write complete only when it has
been stored in both the cache pool and on the origin LV.
While writethrough may be slower for writes, it is more
resilient if something should happen to a device associated with the
cache pool LV. With **passthrough**, all reads are served
from the origin LV (all reads miss the cache) and all writes are
forwarded to the origin LV; additionally, write hits cause cache
block invalidates. See **lvmcache**(7) for more information.
.HP
**--cachepolicy** _String_  
Specifies the cache policy for a cache LV.
See **lvmcache**(7) for more information.
.HP
**--cachepool** _LV_  
The name of a cache pool LV.
.HP
**--cachesettings** _String_  
Specifies tunable values for a cache LV in "Key = Value" form.
Repeat this option to specify multiple values.
(The default values should usually be adequate.)
The special string value **default** switches
settings back to their default kernel values and removes
them from the list of settings stored in LVM metadata.
See **lvmcache**(7) for more information.
.HP
**-c**|**--chunksize** _Size_[k|UNIT]  
The size of chunks in a snapshot, cache pool or thin pool.
For snapshots, the value must be a power of 2 between 4KiB and 512KiB
and the default value is 4.
For a cache pool the value must be between 32KiB and 1GiB
and the default value is 64.
For a thin pool the value must be between 64KiB and 1GiB
and the default value starts with 64 and scales up to fit the
pool metadata size within 128MiB, if the pool metadata size is not specified.
The value must be a multiple of 64KiB.
See **lvmthin**(7) and **lvmcache**(7) for more information.
.HP
**--commandprofile** _String_  
The command profile to use for command configuration.
See **lvm.conf**(5) for more information about profiles.
.HP
**--config** _String_  
Config settings for the command. These override lvm.conf settings.
The String arg uses the same format as lvm.conf,
or may use section/field syntax.
See **lvm.conf**(5) for more information about config.
.HP
**-d**|**--debug** ...  
Set debug level. Repeat from 1 to 6 times to increase the detail of
messages sent to the log file and/or syslog (if configured).
.HP
**--discards** **passdown**|**nopassdown**|**ignore**  
Specifies how the device-mapper thin pool layer in the kernel should
handle discards.
**ignore** causes the thin pool to ignore discards.
**nopassdown** causes the thin pool to process discards itself to
allow reuse of unneeded extents in the thin pool.
**passdown** causes the thin pool to process discards itself
(like nopassdown) and pass the discards to the underlying device.
See **lvmthin**(7) for more information.
.HP
**--driverloaded** **y**|**n**  
If set to no, the command will not attempt to use device-mapper.
For testing and debugging.
.HP
**-f**|**--force** ...  
Override various checks, confirmations and protections.
Use with extreme caution.
.HP
**-h**|**--help**  
Display help text.
.HP
**-i**|**--interval** _Number_  
Report progress at regular intervals.
.HP
**--lockopt** _String_  
Used to pass options for special cases to lvmlockd.
See **lvmlockd**(8) for more information.
.HP
**--longhelp**  
Display long help text.
.HP
**--merge**  
An alias for --mergethin, --mergemirrors, or --mergesnapshot,
depending on the type of LV.
.HP
**--mergemirrors**  
Merge LV images that were split from a raid1 LV.
See --splitmirrors with --trackchanges.
.HP
**--mergesnapshot**  
Merge COW snapshot LV into its origin.
When merging a snapshot, if both the origin and snapshot LVs are not open,
the merge will start immediately. Otherwise, the merge will start the
first time either the origin or snapshot LV are activated and both are
closed. Merging a snapshot into an origin that cannot be closed, for
example a root filesystem, is deferred until the next time the origin
volume is activated. When merging starts, the resulting LV will have the
origin's name, minor number and UUID. While the merge is in progress,
reads or writes to the origin appear as being directed to the snapshot
being merged. When the merge finishes, the merged snapshot is removed.
Multiple snapshots may be specified on the command line or a @tag may be
used to specify multiple snapshots be merged to their respective origin.
.HP
**--mergethin**  
Merge thin LV into its origin LV.
The origin thin LV takes the content of the thin snapshot,
and the thin snapshot LV is removed.
See **lvmthin**(7) for more information.
.HP
**--metadataprofile** _String_  
The metadata profile to use for command configuration.
See **lvm.conf**(5) for more information about profiles.
.HP
**--mirrorlog** **core**|**disk**  
Specifies the type of mirror log for LVs with the "mirror" type
(does not apply to the "raid1" type.)
**disk** is a persistent log and requires a small amount of
storage space, usually on a separate device from the data being mirrored.
**core** is not persistent; the log is kept only in memory.
In this case, the mirror must be synchronized (by copying LV data from
the first device to others) each time the LV is activated, e.g. after reboot.
**mirrored** is a persistent log that is itself mirrored, but
should be avoided. Instead, use the raid1 type for log redundancy.
.HP
**-m**|**--mirrors** [**+**|**-**]_Number_  
Specifies the number of mirror images in addition to the original LV
image, e.g. --mirrors 1 means there are two images of the data, the
original and one mirror image.
Optional positional PV args on the command line can specify the devices
the images should be placed on.
There are two mirroring implementations: "raid1" and "mirror".
These are the names of the corresponding LV types, or "segment types".
Use the --type option to specify which to use (raid1 is default,
and mirror is legacy)
Use lvm.conf global/mirror_segtype_default and
global/raid10_segtype_default to configure the default types.
The plus prefix **+** can be used, in which case
the number is added to the current number of images,
or the minus prefix **-** can be used, in which case
the number is subtracted from the current number of images.
See **lvmraid**(7) for more information.
.HP
**-n**|**--name** _String_  
Specifies the name of a new LV.
When unspecified, a default name of "lvol#" is
generated, where # is a number generated by LVM.
.HP
**--noudevsync**  
Disables udev synchronisation. The process will not wait for notification
from udev. It will continue irrespective of any possible udev processing
in the background. Only use this if udev is not running or has rules that
ignore the devices LVM creates.
.HP
**--originname** _LV_  
Specifies the name to use for the external origin LV when converting an LV
to a thin LV. The LV being converted becomes a read-only external origin
with this name.
.HP
**--poolmetadata** _LV_  
The name of a an LV to use for storing pool metadata.
.HP
**--poolmetadatasize** _Size_[m|UNIT]  
Specifies the size of the new pool metadata LV.
.HP
**--poolmetadataspare** **y**|**n**  
Enable or disable the automatic creation and management of a
spare pool metadata LV in the VG. A spare metadata LV is reserved
space that can be used when repairing a pool.
.HP
**--profile** _String_  
An alias for --commandprofile or --metadataprofile, depending
on the command.
.HP
**-q**|**--quiet** ...  
Suppress output and log messages. Overrides --debug and --verbose.
Repeat once to also suppress any prompts with answer 'no'.
.HP
**-r**|**--readahead** **auto**|**none**|_Number_  
Sets read ahead sector count of an LV.
**auto** is the default which allows the kernel to choose
a suitable value automatically.
**none** is equivalent to zero.
.HP
**-R**|**--regionsize** _Size_[m|UNIT]  
Size of each raid or mirror synchronization region.
lvm.conf activation/raid_region_size can be used to
configure a default.
.HP
**--repair**  
Replace failed PVs in a raid or mirror LV, or run a repair
utility on a thin pool. See **lvmraid**(7) and **lvmthin**(7)
for more information.
.HP
**--replace** _PV_  
Replace a specific PV in a raid LV with another PV.
The new PV to use can be optionally specified after the LV.
Multiple PVs can be replaced by repeating this option.
See **lvmraid**(7) for more information.
.HP
**-s**|**--snapshot**  
Combine a former COW snapshot LV with a former origin LV to reverse
a previous --splitsnapshot command.
.HP
**--splitcache**  
Separates a cache pool from a cache LV, and keeps the unused cache pool LV.
Before the separation, the cache is flushed. Also see --uncache.
.HP
**--splitmirrors** _Number_  
Splits the specified number of images from a raid1 or mirror LV
and uses them to create a new LV. If --trackchanges is also specified,
changes to the raid1 LV are tracked while the split LV remains detached.
If --name is specified, then the images are permanently split from the
original LV and changes are not tracked.
.HP
**--splitsnapshot**  
Separates a COW snapshot from its origin LV. The LV that is split off
contains the chunks that differ from the origin LV along with metadata
describing them. This LV can be wiped and then destroyed with lvremove.
.HP
**--startpoll**  
Start polling an LV to continue processing a conversion.
.HP
**--stripes** _Number_  
Specifies the number of stripes in a striped LV. This is the number of
PVs (devices) that a striped LV is spread across. Data that
appears sequential in the LV is spread across multiple devices in units of
the stripe size (see --stripesize). This does not apply to
existing allocated space, only newly allocated space can be striped.
.HP
**-I**|**--stripesize** _Size_[k|UNIT]  
The amount of data that is written to one device before
moving to the next in a striped LV.
.HP
**--swapmetadata**  
Extracts the metadata LV from a pool and replaces it with another specified LV.
The extracted LV is preserved and given the name of the LV that replaced it.
Use for repair only. When the metadata LV is swapped out of the pool, it can
be activated directly and used with thin provisioning tools:
**cache\_dump**(8), **cache\_repair**(8), **cache\_restore**(8),
**thin\_dump**(8), **thin\_repair**(8), **thin\_restore**(8).
.HP
**-t**|**--test**  
Run in test mode. Commands will not update metadata.
This is implemented by disabling all metadata writing but nevertheless
returning success to the calling function. This may lead to unusual
error messages in multi-stage operations if a tool relies on reading
back metadata it believes has changed but hasn't.
.HP
**-T**|**--thin**  
Specifies the command is handling a thin LV or thin pool.
See --type thin, --type thin-pool, and --virtualsize.
See **lvmthin**(7) for more information about LVM thin provisioning.
.HP
**--thinpool** _LV_  
The name of a thin pool LV.
.HP
**--trackchanges**  
Can be used with --splitmirrors on a raid1 LV. This causes
changes to the original raid1 LV to be tracked while the split images
remain detached. This is a temporary state that allows the read-only
detached image to be merged efficiently back into the raid1 LV later.
Only the regions with changed data are resynchronized during merge.
While a raid1 LV is tracking changes, operations on it are limited to
merging the split image (see --mergemirrors) or permanently splitting
the image (see --splitmirrors with --name.
.HP
**--type** **linear**|**striped**|**snapshot**|**mirror**|**raid**|**thin**|**cache**|**thin-pool**|**cache-pool**  
The LV type, also known as "segment type" or "segtype".
See usage descriptions for the specific ways to use these types.
For more information about redundancy and performance (**raid**&lt;N&gt;, **mirror**, **striped**, **linear**) see **lvmraid**(7).
For thin provisioning (**thin**, **thin-pool**) see **lvmthin**(7).
For performance caching (**cache**, **cache-pool**) see **lvmcache**(7).
For copy-on-write snapshots (**snapshot**) see usage definitions.
Several commands omit an explicit type option because the type
is inferred from other options or shortcuts
(e.g. --stripes, --mirrors, --snapshot, --virtualsize, --thin, --cache).
Use inferred types with care because it can lead to unexpected results.
.HP
**--uncache**  
Separates a cache pool from a cache LV, and deletes the unused cache pool LV.
Before the separation, the cache is flushed. Also see --splitcache.
.HP
**--usepolicies**  
Perform an operation according to the policy configured in lvm.conf
or a profile.
.HP
**-v**|**--verbose** ...  
Set verbose level. Repeat from 1 to 4 times to increase the detail
of messages sent to stdout and stderr.
.HP
**--version**  
Display version information.
.HP
**-y**|**--yes**  
Do not prompt for confirmation interactively but always assume the
answer yes. Use with extreme caution.
(For automatic no, see -qq.)
.HP
**-Z**|**--zero** **y**|**n**  
For snapshots, this controls zeroing of the first 4KiB of data in the
snapshot. If the LV is read-only, the snapshot will not be zeroed.
For thin pools, this controls zeroing of provisioned blocks.
Provisioning of large zeroed chunks negatively impacts performance.

<a name="variables"></a>

# Variables

.HP
_VG_  
Volume Group name.  See **lvm**(8) for valid names.
.HP
_LV_  
Logical Volume name.  See **lvm**(8) for valid names.
An LV positional arg generally includes the VG name and LV name, e.g. VG/LV.
LV followed by _&lt;type&gt; indicates that an LV of the
given type is required. (raid represents raid&lt;N&gt; type)
.HP
_PV_  
Physical Volume name, a device path under /dev.
For commands managing physical extents, a PV positional arg
generally accepts a suffix indicating a range (or multiple ranges)
of physical extents (PEs). When the first PE is omitted, it defaults
to the start of the device, and when the last PE is omitted it defaults to end.
Start and end range (inclusive): _PV_[**:**_PE_**-**_PE_]...
Start and length range (counting from 0): _PV_[**:**_PE_**+**_PE_]...
.HP
_Tag_  
Tag name.  See **lvm**(8) for information about tag names and using tags
in place of a VG, LV or PV.
.HP
_String_  
See the option description for information about the string content.
.HP
_Size_[UNIT]  
Size is an input number that accepts an optional unit.
Input units are always treated as base two values, regardless of
capitalization, e.g. 'k' and 'K' both refer to 1024.
The default input unit is specified by letter, followed by |UNIT.
UNIT represents other possible input units: **bBsSkKmMgGtTpPeE**.
b|B is bytes, s|S is sectors of 512 bytes, k|K is kilobytes,
m|M is megabytes, g|G is gigabytes, t|T is terabytes,
p|P is petabytes, e|E is exabytes.
(This should not be confused with the output control --units, where
capital letters mean multiple of 1000.)

<a name="environment-variables"></a>

# Environment Variables

See **lvm**(8) for information about environment variables used by lvm.
For example, LVM_VG_NAME can generally be substituted for a required VG parameter.

<a name="advanced-usage"></a>

# Advanced Usage

Alternate command forms, advanced command usage, and listing of all valid syntax for completeness.

Convert LV to type mirror (also see type raid1),   
(also see lvconvert --mirrors).  

**lvconvert** **--type** **mirror** _LV_  
[ **-m**|**--mirrors** [**+**|**-**]_Number_ ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[ **-i**|**--interval** _Number_ ]  
[    **--mirrorlog** **core**|**disk** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Change the region size of an LV.  

**lvconvert** **-R**|**--regionsize** _Size_[m|UNIT] _LV__\_raid_  
[ COMMON_OPTIONS ]  
-

Change the type of mirror log used by a mirror LV.  

**lvconvert** **--mirrorlog** **core**|**disk** _LV__\_mirror_  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Convert LV to a thin LV, using the original LV as an external origin   
(infers --type thin).  

**lvconvert** **-T**|**--thin** **--thinpool** _LV_ _LV__\_linear\_striped\_thin\_cache\_raid_  
[ **-r**|**--readahead** **auto**|**none**|_Number_ ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-Z**|**--zero** **y**|**n** ]  
[    **--type** **thin** ]  
[    **--originname** _LV__\_new_ ]  
[    **--poolmetadata** _LV_ ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--metadataprofile** _String_ ]  
[ COMMON_OPTIONS ]  
-

Convert LV to type cache (infers --type cache).  

**lvconvert** **-H**|**--cache** **--cachepool** _LV_ _LV__\_linear\_striped\_thinpool\_raid_  
[ **-Z**|**--zero** **y**|**n** ]  
[ **-r**|**--readahead** **auto**|**none**|_Number_ ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--type** **cache** ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--poolmetadata** _LV_ ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--metadataprofile** _String_ ]  
[ COMMON_OPTIONS ]  
-

Separate and delete the cache pool from a cache LV.  

**lvconvert** **--uncache** _LV__\_thinpool\_cache_  
[ COMMON_OPTIONS ]  
-

Swap metadata LV in a thin pool or cache pool (for repair only).  

**lvconvert** **--swapmetadata** **--poolmetadata** _LV_ _LV__\_thinpool\_cachepool_  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
-

Merge LV that was split from a mirror (variant, use --mergemirrors).   
Merge thin LV into its origin LV (variant, use --mergethin).   
Merge COW snapshot LV into its origin (variant, use --mergesnapshot).  

**lvconvert** **--merge** _VG_|_LV__\_linear\_striped\_snapshot\_thin\_raid_|_Tag_ ...  
[ **-i**|**--interval** _Number_ ]  
[ COMMON_OPTIONS ]  
-

Separate a COW snapshot from its origin LV.  

**lvconvert** **--splitsnapshot** _LV__\_snapshot_  
[ COMMON_OPTIONS ]  
-

Combine a former COW snapshot (second arg) with a former   
origin LV (first arg) to reverse a splitsnapshot command.  

**lvconvert** **-s**|**--snapshot** _LV_ _LV__\_linear\_striped_  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-Z**|**--zero** **y**|**n** ]  
[    **--type** **snapshot** ]  
[ COMMON_OPTIONS ]  
-

Poll LV to continue conversion (also see --startpoll)   
or waits till conversion/mirror syncing is finished  

**lvconvert** _LV__\_mirror\_raid_  
[ COMMON_OPTIONS ]  
-


<a name="notes"></a>

# Notes

This previous command syntax would perform two different operations:  
**lvconvert --thinpool** _LV1_ **--poolmetadata** _LV2_  
If LV1 was not a thin pool, the command would convert LV1 to
a thin pool, optionally using a specified LV for metadata.
But, if LV1 was already a thin pool, the command would swap
the current metadata LV with LV2 (for repair purposes.)

In the same way, this previous command syntax would perform two different
operations:  
**lvconvert --cachepool** _LV1_ **--poolmetadata** _LV2_  
If LV1 was not a cache pool, the command would convert LV1 to
a cache pool, optionally using a specified LV for metadata.
But, if LV1 was already a cache pool, the command would swap
the current metadata LV with LV2 (for repair purposes.)

<a name="examples"></a>

# Examples

Convert a linear LV to a two-way mirror LV.  
**lvconvert --type mirror --mirrors 1 vg/lvol1**

Convert a linear LV to a two-way RAID1 LV.  
**lvconvert --type raid1 --mirrors 1 vg/lvol1**

Convert a mirror LV to use an in-memory log.  
**lvconvert --mirrorlog core vg/lvol1**

Convert a mirror LV to use a disk log.  
**lvconvert --mirrorlog disk vg/lvol1**

Convert a mirror or raid1 LV to a linear LV.  
**lvconvert --type linear vg/lvol1**

Convert a mirror LV to a raid1 LV with the same number of images.  
**lvconvert --type raid1 vg/lvol1**

Convert a linear LV to a two-way mirror LV, allocating new extents from specific
PV ranges.  
**lvconvert --mirrors 1 vg/lvol1 /dev/sda:0-15 /dev/sdb:0-15**

Convert a mirror LV to a linear LV, freeing physical extents from a specific PV.  
**lvconvert --type linear vg/lvol1 /dev/sda**

Split one image from a mirror or raid1 LV, making it a new LV.  
**lvconvert --splitmirrors 1 --name lv_split vg/lvol1**

Split one image from a raid1 LV, and track changes made to the raid1 LV
while the split image remains detached.  
**lvconvert --splitmirrors 1 --trackchanges vg/lvol1**

Merge an image (that was previously created with --splitmirrors and
--trackchanges) back into the original raid1 LV.  
**lvconvert --mergemirrors vg/lvol1_rimage_1**

Replace PV /dev/sdb1 with PV /dev/sdf1 in a raid1/4/5/6/10 LV.  
**lvconvert --replace /dev/sdb1 vg/lvol1 /dev/sdf1**

Replace 3 PVs /dev/sd[b-d]1 with PVs /dev/sd[f-h]1 in a raid1 LV.  
**lvconvert --replace /dev/sdb1 --replace /dev/sdc1 --replace /dev/sdd1**
**vg/lvol1 /dev/sd[fgh]1**

Replace the maximum of 2 PVs /dev/sd[bc]1 with PVs /dev/sd[gh]1 in a raid6 LV.  
**lvconvert --replace /dev/sdb1 --replace /dev/sdc1 vg/lvol1 /dev/sd[gh]1**

Convert an LV into a thin LV in the specified thin pool.  The existing LV
is used as an external read-only origin for the new thin LV.  
**lvconvert --type thin --thinpool vg/tpool1 vg/lvol1**

Convert an LV into a thin LV in the specified thin pool.  The existing LV
is used as an external read-only origin for the new thin LV, and is
renamed "external".  
**lvconvert --type thin --thinpool vg/tpool1**
**--originname external vg/lvol1**

Convert an LV to a cache pool LV using another specified LV for cache pool
metadata.  
**lvconvert --type cache-pool --poolmetadata vg/poolmeta1 vg/lvol1**

Convert an LV to a cache LV using the specified cache pool and chunk size.  
**lvconvert --type cache --cachepool vg/cpool1 -c 128 vg/lvol1**

Detach and keep the cache pool from a cache LV.  
**lvconvert --splitcache vg/lvol1**

Detach and remove the cache pool from a cache LV.  
**lvconvert --uncache vg/lvol1**

<a name="see-also"></a>

# See Also


**lvm**(8)
**lvm.conf**(5)
**lvmconfig**(8)

**pvchange**(8)
**pvck**(8)
**pvcreate**(8)
**pvdisplay**(8)
**pvmove**(8)
**pvremove**(8)
**pvresize**(8)
**pvs**(8)
**pvscan**(8)

**vgcfgbackup**(8)
**vgcfgrestore**(8)
**vgchange**(8)
**vgck**(8)
**vgcreate**(8)
**vgconvert**(8)
**vgdisplay**(8)
**vgexport**(8)
**vgextend**(8)
**vgimport**(8)
**vgimportclone**(8)
**vgmerge**(8)
**vgmknodes**(8)
**vgreduce**(8)
**vgremove**(8)
**vgrename**(8)
**vgs**(8)
**vgscan**(8)
**vgsplit**(8)

**lvcreate**(8)
**lvchange**(8)
**lvconvert**(8)
**lvdisplay**(8)
**lvextend**(8)
**lvreduce**(8)
**lvremove**(8)
**lvrename**(8)
**lvresize**(8)
**lvs**(8)
**lvscan**(8)

**lvm-fullreport**(8)
**lvm-lvpoll**(8)
**lvm2-activation-generator**(8)
**blkdeactivate**(8)
**lvmdump**(8)

**dmeventd**(8)
**lvmetad**(8)
**lvmpolld**(8)
**lvmlockd**(8)
**lvmlockctl**(8)
**clvmd**(8)
**cmirrord**(8)
**lvmdbusd**(8)

**lvmsystemid**(7)
**lvmreport**(7)
**lvmraid**(7)
**lvmthin**(7)
**lvmcache**(7)
