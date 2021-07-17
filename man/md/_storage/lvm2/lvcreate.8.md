# lvcreate(8) - Create a logical volume

Red Hat, Inc., LVM TOOLS 2.02.183(2) (2018-12-07)


<a name="synopsis"></a>

# Synopsis

```
lvcreate option_args position_args
[ option_args ]
[ position_args ]

  -a|--activate y|n|ay
--addtag Tag
--alloc contiguous|cling|cling_by_tags|normal|anywhere|inherit
-A|--autobackup y|n
-H|--cache
--cachemetadataformat auto|1|2
--cachemode writethrough|writeback|passthrough
--cachepolicy String
--cachepool LV
--cachesettings String
-c|--chunksize Size[k|UNIT]
--commandprofile String
--config String
-C|--contiguous y|n
-d|--debug
--discards passdown|nopassdown|ignore
--driverloaded y|n
--errorwhenfull y|n
-l|--extents Number[PERCENT]
-h|--help
-K|--ignoreactivationskip
--ignoremonitoring
--lockopt String
--longhelp
-j|--major Number
--[raid]maxrecoveryrate Size[k|UNIT]
--metadataprofile String
--minor Number
--[raid]minrecoveryrate Size[k|UNIT]
--mirrorlog core|disk
-m|--mirrors Number
--monitor y|n
-n|--name String
--nosync
--noudevsync
-p|--permission rw|r
-M|--persistent y|n
--poolmetadatasize Size[m|UNIT]
--poolmetadataspare y|n
--profile String
-q|--quiet
-r|--readahead auto|none|Number
-R|--regionsize Size[m|UNIT]
--reportformat basic|json
-k|--setactivationskip y|n
-L|--size Size[m|UNIT]
-s|--snapshot
-i|--stripes Number
-I|--stripesize Size[k|UNIT]
-t|--test
-T|--thin
--thinpool LV
--type linear|striped|snapshot|mirror|raid|thin|cache|thin-pool|cache-pool
-v|--verbose
--version
-V|--virtualsize Size[m|UNIT]
-W|--wipesignatures y|n
-y|--yes
-Z|--zero y|n
```

<a name="description"></a>

# Description

lvcreate creates a new LV in a VG. For standard LVs, this requires
allocating logical extents from the VG's free physical extents. If there
is not enough free space, the VG can be extended with other PVs
(**vgextend**(8)), or existing LVs can be reduced or removed
(**lvremove**(8), **lvreduce**(8).)

To control which PVs a new LV will use, specify one or more PVs as
position args at the end of the command line. lvcreate will allocate
physical extents only from the specified PVs.

lvcreate can also create snapshots of existing LVs, e.g. for backup
purposes. The data in a new snapshot LV represents the content of the
original LV from the time the snapshot was created.

RAID LVs can be created by specifying an LV type when creating the LV (see
**lvmraid**(7)). Different RAID levels require different numbers of
unique PVs be available in the VG for allocation.

Thin pools (for thin provisioning) and cache pools (for caching) are
represented by special LVs with types thin-pool and cache-pool (see
**lvmthin**(7) and **lvmcache**(7)). The pool LVs are not usable as
standard block devices, but the LV names act as references to the pools.

Thin LVs are thinly provisioned from a thin pool, and are created with a
virtual size rather than a physical size. A cache LV is the combination of
a standard LV with a cache pool, used to cache active portions of the LV
to improve performance.

<a name="usage-notes"></a>

### Usage notes

In the usage section below, **--size** _Size_ can be replaced
with **--extents** _Number_. See descriptions in the options section.

In the usage section below, **--name** is omitted from the required
options, even though it is typically used. When the name is not
specified, a new LV name is generated with the "lvol" prefix and a unique
numeric suffix.

<a name="usage"></a>

# Usage

Create a linear LV.  

**lvcreate** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[    **--type** **linear** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a striped LV (infers --type striped).  

**lvcreate** **-i**|**--stripes** _Number_ **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a raid1 or mirror LV (infers --type raid1|mirror).  

**lvcreate** **-m**|**--mirrors** _Number_ **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[    **--mirrorlog** **core**|**disk** ]  
[    **--[raid]minrecoveryrate** _Size_[k|UNIT] ]  
[    **--[raid]maxrecoveryrate** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a raid LV (a specific raid level must be used, e.g. raid1).  

**lvcreate** **--type** **raid** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-m**|**--mirrors** _Number_ ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[    **--[raid]minrecoveryrate** _Size_[k|UNIT] ]  
[    **--[raid]maxrecoveryrate** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a raid10 LV.  

**lvcreate** **-m**|**--mirrors** _Number_ **-i**|**--stripes** _Number_
 **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[    **--[raid]minrecoveryrate** _Size_[k|UNIT] ]  
[    **--[raid]maxrecoveryrate** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a COW snapshot LV of an origin LV.  

**lvcreate** **-s**|**--snapshot** **-L**|**--size** _Size_[m|UNIT] _LV_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--type** **snapshot** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin pool.  

**lvcreate** **--type** **thin-pool** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--thinpool** _LV__\_new_ ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a cache pool.  

**lvcreate** **--type** **cache-pool** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-H**|**--cache** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin LV in a thin pool (infers --type thin).  

**lvcreate** **-V**|**--virtualsize** _Size_[m|UNIT] **--thinpool** _LV__\_thinpool_ _VG_  
[ **-T**|**--thin** ]  
[    **--type** **thin** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV that is a snapshot of an existing thin LV   
(infers --type thin).  

**lvcreate** **-s**|**--snapshot** _LV__\_thin_  
[    **--type** **thin** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV that is a snapshot of an external origin LV.  

**lvcreate** **--type** **thin** **--thinpool** _LV__\_thinpool_ _LV_  
[ **-T**|**--thin** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV, first creating a thin pool for it,   
where the new thin pool is named by the --thinpool arg.  

**lvcreate** **--type** **thin** **-V**|**--virtualsize** _Size_[m|UNIT]
 **-L**|**--size** _Size_[m|UNIT] **--thinpool** _LV__\_new_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-T**|**--thin** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a cache LV, first creating a new origin LV,   
then combining it with the existing cache pool named   
by the --cachepool arg.  

**lvcreate** **--type** **cache** **-L**|**--size** _Size_[m|UNIT]
 **--cachepool** _LV__\_cachepool_ _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-H**|**--cache** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Common options for command:
[ **-a**|**--activate** **y**|**n**|**ay** ]  
[ **-A**|**--autobackup** **y**|**n** ]  
[ **-C**|**--contiguous** **y**|**n** ]  
[ **-K**|**--ignoreactivationskip** ]  
[ **-j**|**--major** _Number_ ]  
[ **-n**|**--name** _String_ ]  
[ **-p**|**--permission** **rw**|**r** ]  
[ **-M**|**--persistent** **y**|**n** ]  
[ **-r**|**--readahead** **auto**|**none**|_Number_ ]  
[ **-k**|**--setactivationskip** **y**|**n** ]  
[ **-W**|**--wipesignatures** **y**|**n** ]  
[ **-Z**|**--zero** **y**|**n** ]  
[    **--addtag** _Tag_ ]  
[    **--alloc** **contiguous**|**cling**|**cling\_by\_tags**|**normal**|**anywhere**|**inherit** ]  
[    **--ignoremonitoring** ]  
[    **--metadataprofile** _String_ ]  
[    **--minor** _Number_ ]  
[    **--monitor** **y**|**n** ]  
[    **--nosync** ]  
[    **--noudevsync** ]  
[    **--reportformat** **basic**|**json** ]

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
**-a**|**--activate** **y**|**n**|**ay**  
Controls the active state of the new LV.
**y** makes the LV active, or available.
New LVs are made active by default.
**n** makes the LV inactive, or unavailable, only when possible.
In some cases, creating an LV requires it to be active.
For example, COW snapshots of an active origin LV can only
be created in the active state (this does not apply to thin snapshots).
The --zero option normally requires the LV to be active.
If autoactivation **ay** is used, the LV is only activated
if it matches an item in lvm.conf activation/auto_activation_volume_list.
**ay** implies --zero n and --wipesignatures n.
See **lvmlockd**(8) for more information about activation options for shared VGs.
See **clvmd**(8) for more information about activation options for clustered VGs.
.HP
**--addtag** _Tag_  
Adds a tag to a PV, VG or LV. This option can be repeated to add
multiple tags at once. See **lvm**(8) for information about tags.
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
**-A**|**--autobackup** **y**|**n**  
Specifies if metadata should be backed up automatically after a change.
Enabling this is strongly advised! See **vgcfgbackup**(8) for more information.
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
**-C**|**--contiguous** **y**|**n**  
Sets or resets the contiguous allocation policy for LVs.
Default is no contiguous allocation based on a next free principle.
It is only possible to change a non-contiguous allocation policy
to contiguous if all of the allocated physical extents in the LV
are already contiguous.
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
**--errorwhenfull** **y**|**n**  
Specifies thin pool behavior when data space is exhausted.
When yes, device-mapper will immediately return an error
when a thin pool is full and an I/O request requires space.
When no, device-mapper will queue these I/O requests for a
period of time to allow the thin pool to be extended.
Errors are returned if no space is available after the timeout.
(Also see dm-thin-pool kernel module option no_space_timeout.)
See **lvmthin**(7) for more information.
.HP
**-l**|**--extents** _Number_[PERCENT]  
Specifies the size of the new LV in logical extents.
The --size and --extents options are alternate methods of specifying size.
The total number of physical extents used will be
greater when redundant data is needed for RAID levels.
An alternate syntax allows the size to be determined indirectly
as a percentage of the size of a related VG, LV, or set of PVs. The
suffix **%VG** denotes the total size of the VG, the suffix **%FREE**
the remaining free space in the VG, and the suffix **%PVS** the free
space in the specified PVs.  For a snapshot, the size
can be expressed as a percentage of the total size of the origin LV
with the suffix **%ORIGIN** (**100%ORIGIN** provides space for
the whole origin).
When expressed as a percentage, the size defines an upper limit for the
number of logical extents in the new LV. The precise number of logical
extents in the new LV is not determined until the command has completed.
.HP
**-h**|**--help**  
Display help text.
.HP
**-K**|**--ignoreactivationskip**  
Ignore the "activation skip" LV flag during activation
to allow LVs with the flag set to be activated.
.HP
**--ignoremonitoring**  
Do not interact with dmeventd unless --monitor is specified.
Do not use this if dmeventd is already monitoring a device.
.HP
**--lockopt** _String_  
Used to pass options for special cases to lvmlockd.
See **lvmlockd**(8) for more information.
.HP
**--longhelp**  
Display long help text.
.HP
**-j**|**--major** _Number_  
Sets the major number of an LV block device.
.HP
**--[raid]maxrecoveryrate** _Size_[k|UNIT]  
Sets the maximum recovery rate for a RAID LV.  The rate value
is an amount of data per second for each device in the array.
Setting the rate to 0 means it will be unbounded.
See **lvmraid**(7) for more information.
.HP
**--metadataprofile** _String_  
The metadata profile to use for command configuration.
See **lvm.conf**(5) for more information about profiles.
.HP
**--minor** _Number_  
Sets the minor number of an LV block device.
.HP
**--[raid]minrecoveryrate** _Size_[k|UNIT]  
Sets the minimum recovery rate for a RAID LV.  The rate value
is an amount of data per second for each device in the array.
Setting the rate to 0 means it will be unbounded.
See **lvmraid**(7) for more information.
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
**-m**|**--mirrors** _Number_  
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
See the --nosync option for avoiding initial image synchronization.
See **lvmraid**(7) for more information.
.HP
**--monitor** **y**|**n**  
Start (yes) or stop (no) monitoring an LV with dmeventd.
dmeventd monitors kernel events for an LV, and performs
automated maintenance for the LV in reponse to specific events.
See **dmeventd**(8) for more information.
.HP
**-n**|**--name** _String_  
Specifies the name of a new LV.
When unspecified, a default name of "lvol#" is
generated, where # is a number generated by LVM.
.HP
**--nosync**  
Causes the creation of mirror, raid1, raid4, raid5 and raid10 to skip the
initial synchronization. In case of mirror, raid1 and raid10, any data
written afterwards will be mirrored, but the original contents will not be
copied. In case of raid4 and raid5, no parity blocks will be written,
though any data written afterwards will cause parity blocks to be stored.
This is useful for skipping a potentially long and resource intensive initial
sync of an empty mirror/raid1/raid4/raid5 and raid10 LV.
This option is not valid for raid6, because raid6 relies on proper parity
(P and Q Syndromes) being created during initial synchronization in order
to reconstruct proper user date in case of device failures.
raid0 and raid0_meta do not provide any data copies or parity support
and thus do not support initial synchronization.
.HP
**--noudevsync**  
Disables udev synchronisation. The process will not wait for notification
from udev. It will continue irrespective of any possible udev processing
in the background. Only use this if udev is not running or has rules that
ignore the devices LVM creates.
.HP
**-p**|**--permission** **rw**|**r**  
Set access permission to read only **r** or read and write **rw**.
.HP
**-M**|**--persistent** **y**|**n**  
When yes, makes the specified minor number persistent.
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
**--reportformat** **basic**|**json**  
Overrides current output format for reports which is defined globally by
the report/output_format setting in lvm.conf.
**basic** is the original format with columns and rows.
If there is more than one report per command, each report is prefixed
with the report name for identification. **json** produces report
output in JSON format. See **lvmreport**(7) for more information.
.HP
**-k**|**--setactivationskip** **y**|**n**  
Persistently sets (yes) or clears (no) the "activation skip" flag on an LV.
An LV with this flag set is not activated unless the
--ignoreactivationskip option is used by the activation command.
This flag is set by default on new thin snapshot LVs.
The flag is not applied to deactivation.
The current value of the flag is indicated in the lvs lv_attr bits.
.HP
**-L**|**--size** _Size_[m|UNIT]  
Specifies the size of the new LV.
The --size and --extents options are alternate methods of specifying size.
The total number of physical extents used will be
greater when redundant data is needed for RAID levels.
.HP
**-s**|**--snapshot**  
Create a snapshot. Snapshots provide a "frozen image" of an origin LV.
The snapshot LV can be used, e.g. for backups, while the origin LV
continues to be used.
This option can create a COW (copy on write) snapshot,
or a thin snapshot (in a thin pool.)
Thin snapshots are created when the origin is a thin LV and
the size option is NOT specified. Thin snapshots share the same blocks
in the thin pool, and do not allocate new space from the VG.
Thin snapshots are created with the "activation skip" flag,
see --setactivationskip.
A thin snapshot of a non-thin "external origin" LV is created
when a thin pool is specified. Unprovisioned blocks in the thin snapshot
LV are read from the external origin LV. The external origin LV must
be read-only.
See **lvmthin**(7) for more information about LVM thin provisioning.
COW snapshots are created when a size is specified. The size is allocated
from space in the VG, and is the amount of space that can be used
for saving COW blocks as writes occur to the origin or snapshot.
The size chosen should depend upon the amount of writes that are expected;
often 20% of the origin LV is enough. If COW space runs low, it can
be extended with lvextend (shrinking is also allowed with lvreduce.)
A small amount of the COW snapshot LV size is used to track COW block
locations, so the full size is not available for COW data blocks.
Use lvs to check how much space is used, and see --monitor to
to automatically extend the size to avoid running out of space.
.HP
**-i**|**--stripes** _Number_  
Specifies the number of stripes in a striped LV. This is the number of
PVs (devices) that a striped LV is spread across. Data that
appears sequential in the LV is spread across multiple devices in units of
the stripe size (see --stripesize). This does not change existing
allocated space, but only applies to space being allocated by the command.
When creating a RAID 4/5/6 LV, this number does not include the extra
devices that are required for parity. The largest number depends on
the RAID type (raid0: 64, raid10: 32, raid4/5: 63, raid6: 62), and
when unspecified, the default depends on the RAID type
(raid0: 2, raid10: 2, raid4/5: 3, raid6: 5.)
To stripe a new raid LV across all PVs by default,
see lvm.conf allocation/raid_stripe_all_devices.
.HP
**-I**|**--stripesize** _Size_[k|UNIT]  
The amount of data that is written to one device before
moving to the next in a striped LV.
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
**-v**|**--verbose** ...  
Set verbose level. Repeat from 1 to 4 times to increase the detail
of messages sent to stdout and stderr.
.HP
**--version**  
Display version information.
.HP
**-V**|**--virtualsize** _Size_[m|UNIT]  
The virtual size of a new thin LV.
See **lvmthin**(7) for more information about LVM thin provisioning.
Using virtual size (-V) and actual size (-L) together creates
a sparse LV.
lvm.conf global/sparse_segtype_default determines the
default segment type used to create a sparse LV.
Anything written to a sparse LV will be returned when reading from it.
Reading from other areas of the LV will return blocks of zeros.
When using a snapshot to create a sparse LV, a hidden virtual device
is created using the zero target, and the LV has the suffix _vorigin.
Snapshots are less efficient than thin provisioning when creating
large sparse LVs (GiB).
.HP
**-W**|**--wipesignatures** **y**|**n**  
Controls detection and subsequent wiping of signatures on new LVs.
There is a prompt for each signature detected to confirm its wiping
(unless --yes is used to override confirmations.)
When not specified, signatures are wiped whenever zeroing is done
(see --zero). This behaviour can be configured with
lvm.conf allocation/wipe_signatures_when_zeroing_new_lvs.
If blkid wiping is used (lvm.conf allocation/use_blkid_wiping)
and LVM is compiled with blkid wiping support, then the blkid(8)
library is used to detect the signatures (use blkid -k to list the
signatures that are recognized).
Otherwise, native LVM code is used to detect signatures
(only MD RAID, swap and LUKS signatures are detected in this case.)
The LV is not wiped if the read only flag is set.
.HP
**-y**|**--yes**  
Do not prompt for confirmation interactively but always assume the
answer yes. Use with extreme caution.
(For automatic no, see -qq.)
.HP
**-Z**|**--zero** **y**|**n**  
Controls zeroing of the first 4KiB of data in the new LV.
Default is **y**.
Snapshot COW volumes are always zeroed.
LV is not zeroed if the read only flag is set.
Warning: trying to mount an unzeroed LV can cause the system to hang.

<a name="variables"></a>

# Variables

.HP
_VG_  
Volume Group name.  See **lvm**(8) for valid names.
For lvcreate, the required VG positional arg may be
omitted when the VG name is included in another option,
e.g. --name VG/LV.
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

Create an LV that returns errors when used.  

**lvcreate** **--type** **error** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ COMMON_OPTIONS ]  
-

Create an LV that returns zeros when read.  

**lvcreate** **--type** **zero** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ COMMON_OPTIONS ]  
-

Create a linear LV.  

**lvcreate** **--type** **linear** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a striped LV (also see lvcreate --stripes).  

**lvcreate** **--type** **striped** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a mirror LV (also see --type raid1).  

**lvcreate** **--type** **mirror** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-m**|**--mirrors** _Number_ ]  
[ **-R**|**--regionsize** _Size_[m|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--mirrorlog** **core**|**disk** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a COW snapshot LV of an origin LV   
(also see --snapshot).  

**lvcreate** **--type** **snapshot** **-L**|**--size** _Size_[m|UNIT] _LV_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-s**|**--snapshot** ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a sparse COW snapshot LV of a virtual origin LV   
(also see --snapshot).  

**lvcreate** **--type** **snapshot** **-L**|**--size** _Size_[m|UNIT]
 **-V**|**--virtualsize** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-s**|**--snapshot** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a sparse COW snapshot LV of a virtual origin LV.  

**lvcreate** **-s**|**--snapshot** **-L**|**--size** _Size_[m|UNIT]
 **-V**|**--virtualsize** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--type** **snapshot** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin pool (infers --type thin-pool).  

**lvcreate** **-T**|**--thin** **-L**|**--size** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--type** **thin-pool** ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin pool named by the --thinpool arg   
(infers --type thin-pool).  

**lvcreate** **-L**|**--size** _Size_[m|UNIT] **--thinpool** _LV__\_new_ _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-T**|**--thin** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--type** **thin-pool** ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a cache pool named by the --cachepool arg   
(variant, uses --cachepool in place of --name).  

**lvcreate** **--type** **cache-pool** **-L**|**--size** _Size_[m|UNIT]
 **--cachepool** _LV__\_new_ _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-H**|**--cache** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin LV in a thin pool.  

**lvcreate** **--type** **thin** **-V**|**--virtualsize** _Size_[m|UNIT]
 **--thinpool** _LV__\_thinpool_ _VG_  
[ **-T**|**--thin** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV in a thin pool named in the first arg   
(variant, also see --thinpool for naming pool).  

**lvcreate** **--type** **thin** **-V**|**--virtualsize** _Size_[m|UNIT] _LV__\_thinpool_  
[ **-T**|**--thin** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV in the thin pool named in the first arg   
(variant, infers --type thin, also see --thinpool for   
naming pool.)  

**lvcreate** **-V**|**--virtualsize** _Size_[m|UNIT] _LV__\_thinpool_  
[ **-T**|**--thin** ]  
[    **--type** **thin** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV that is a snapshot of an existing thin LV.  

**lvcreate** **--type** **thin** _LV__\_thin_  
[ **-T**|**--thin** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV that is a snapshot of an existing thin LV   
(infers --type thin).  

**lvcreate** **-T**|**--thin** _LV__\_thin_  
[    **--type** **thin** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV that is a snapshot of an external origin LV   
(infers --type thin).  

**lvcreate** **-s**|**--snapshot** **--thinpool** _LV__\_thinpool_ _LV_  
[    **--type** **thin** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
-

Create a thin LV, first creating a thin pool for it,   
where the new thin pool is named by the --thinpool arg   
(variant, infers --type thin).  

**lvcreate** **-V**|**--virtualsize** _Size_[m|UNIT] **-L**|**--size** _Size_[m|UNIT]
 **--thinpool** _LV__\_new_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-T**|**--thin** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin LV, first creating a thin pool for it,   
where the new thin pool is named by the --thinpool arg   
(variant, infers --type thin).  

**lvcreate** **-V**|**--virtualsize** _Size_[m|UNIT] **-L**|**--size** _Size_[m|UNIT]
 **--thinpool** _LV__\_new_ _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-T**|**--thin** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin LV, first creating a thin pool for it,   
where the new thin pool is named in the first arg,   
or the new thin pool name is generated when the first   
arg is a VG name.  

**lvcreate** **--type** **thin** **-V**|**--virtualsize** _Size_[m|UNIT]
 **-L**|**--size** _Size_[m|UNIT] _VG_|_LV__\_new_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-T**|**--thin** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin LV, first creating a thin pool for it,   
where the new thin pool is named in the first arg,   
or the new thin pool name is generated when the first   
arg is a VG name (variant, infers --type thin).  

**lvcreate** **-T**|**--thin** **-V**|**--virtualsize** _Size_[m|UNIT]
 **-L**|**--size** _Size_[m|UNIT] _VG_|_LV__\_new_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a thin LV, first creating a thin pool for it   
(infers --type thin).   
Create a sparse snapshot of a virtual origin LV   
(infers --type snapshot).   
Chooses --type thin or --type snapshot according to   
config setting sparse_segtype_default.  

**lvcreate** **-L**|**--size** _Size_[m|UNIT] **-V**|**--virtualsize** _Size_[m|UNIT] _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-s**|**--snapshot** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--type** **snapshot** ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--discards** **passdown**|**nopassdown**|**ignore** ]  
[    **--errorwhenfull** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a cache LV, first creating a new origin LV,   
then combining it with the existing cache pool named   
by the --cachepool arg (variant, infers --type cache).  

**lvcreate** **-L**|**--size** _Size_[m|UNIT] **--cachepool** _LV__\_cachepool_ _VG_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-H**|**--cache** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--type** **cache** ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

Create a cache LV, first creating a new origin LV,   
then combining it with the existing cache pool named   
in the first arg (variant, also use --cachepool).  

**lvcreate** **--type** **cache** **-L**|**--size** _Size_[m|UNIT] _LV__\_cachepool_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-H**|**--cache** ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-

When LV is a cache pool, create a cache LV,   
first creating a new origin LV, then combining it with   
the existing cache pool named in the first arg   
(variant, infers --type cache, also use --cachepool).   
When LV is not a cache pool, convert the specified LV   
to type cache after creating a new cache pool LV to use   
(use lvconvert).  

**lvcreate** **-H**|**--cache** **-L**|**--size** _Size_[m|UNIT] _LV_  
[ **-l**|**--extents** _Number_[PERCENT] ]  
[ **-c**|**--chunksize** _Size_[k|UNIT] ]  
[ **-i**|**--stripes** _Number_ ]  
[ **-I**|**--stripesize** _Size_[k|UNIT] ]  
[    **--cachemode** **writethrough**|**writeback**|**passthrough** ]  
[    **--cachepolicy** _String_ ]  
[    **--cachesettings** _String_ ]  
[    **--cachemetadataformat** **auto**|**1**|**2** ]  
[    **--poolmetadatasize** _Size_[m|UNIT] ]  
[    **--poolmetadataspare** **y**|**n** ]  
[ COMMON_OPTIONS ]  
[ _PV_ ... ]
-


<a name="examples"></a>

# Examples


Create a striped LV with 3 stripes, a stripe size of 8KiB and a size of 100MiB.
The LV name is chosen by lvcreate.  
**lvcreate -i 3 -I 8 -L 100m vg00**

Create a raid1 LV with two images, and a useable size of 500 MiB. This
operation requires two devices, one for each mirror image. RAID metadata
(superblock and bitmap) is also included on the two devices.  
**lvcreate --type raid1 -m1 -L 500m -n mylv vg00**

Create a mirror LV with two images, and a useable size of 500 MiB.
This operation requires three devices: two for mirror images and
one for a disk log.  
**lvcreate --type mirror -m1 -L 500m -n mylv vg00**

Create a mirror LV with 2 images, and a useable size of 500 MiB.
This operation requires 2 devices because the log is in memory.  
**lvcreate --type mirror -m1 --mirrorlog core -L 500m -n mylv vg00**

Create a copy-on-write snapshot of an LV:  
**lvcreate --snapshot --size 100m --name mysnap vg00/mylv**

Create a copy-on-write snapshot with a size sufficient
for overwriting 20% of the size of the original LV.  
**lvcreate -s -l 20%ORIGIN -n mysnap vg00/mylv**

Create a sparse LV with 1TiB of virtual space, and actual space just under
100MiB.  
**lvcreate --snapshot --virtualsize 1t --size 100m --name mylv vg00**

Create a linear LV with a usable size of 64MiB on specific physical extents.  
**lvcreate -L 64m -n mylv vg00 /dev/sda:0-7 /dev/sdb:0-7**

Create a RAID5 LV with a usable size of 5GiB, 3 stripes, a stripe size of
64KiB, using a total of 4 devices (including one for parity).  
**lvcreate --type raid5 -L 5G -i 3 -I 64 -n mylv vg00**

Create a RAID5 LV using all of the free space in the VG and spanning all the
PVs in the VG (note that the command will fail if there are more than 8 PVs in
the VG, in which case **-i 7** must be used to get to the current maximum of
8 devices including parity for RaidLVs).  
**lvcreate --config allocation/raid_stripe_all_devices=1**
**--type raid5 -l 100%FREE -n mylv vg00**

Create RAID10 LV with a usable size of 5GiB, using 2 stripes, each on
a two-image mirror. (Note that the **-i** and **-m** arguments behave
differently:
**-i** specifies the total number of stripes,
but **-m** specifies the number of images in addition
to the first image).  
**lvcreate --type raid10 -L 5G -i 2 -m 1 -n mylv vg00**

Create a 1TiB thin LV, first creating a new thin pool for it, where
the thin pool has 100MiB of space, uses 2 stripes, has a 64KiB stripe
size, and 256KiB chunk size.  
**lvcreate --type thin --name mylv --thinpool mypool**
**-V 1t -L 100m -i 2 -I 64 -c 256 vg00**

Create a thin snapshot of a thin LV (the size option must not be
used, otherwise a copy-on-write snapshot would be created).  
**lvcreate --snapshot --name mysnap vg00/thinvol**

Create a thin snapshot of the read-only inactive LV named "origin"
which becomes an external origin for the thin snapshot LV.  
**lvcreate --snapshot --name mysnap --thinpool mypool vg00/origin**

Create a cache pool from a fast physical device. The cache pool can
then be used to cache an LV.  
**lvcreate --type cache-pool -L 1G -n my_cpool vg00 /dev/fast1**

Create a cache LV, first creating a new origin LV on a slow physical device,
then combining the new origin LV with an existing cache pool.  
**lvcreate --type cache --cachepool my_cpool**
**-L 100G -n mylv vg00 /dev/slow1**

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
