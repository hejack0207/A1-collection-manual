# mkfs\&.btrfs(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

mkfs.btrfs - create a btrfs filesystem

<a name="synopsis"></a>

# Synopsis

```

 mkfs.btrfs [options] <device> [<device>...]
```

<a name="description"></a>

# Description


**mkfs.btrfs** is used to create the btrfs filesystem on a single or multiple devices. _&lt;device&gt;_ is typically a block device but can be a file-backed image as well. Multiple devices are grouped by UUID of the filesystem.

Before mounting such filesystem, the kernel module must know all the devices either via preceding execution of **btrfs device scan** or using the **device** mount option. See section **MULTIPLE DEVICES** for more details.

<a name="options"></a>

# Options


**-b|--byte-count ****&lt;size&gt;**
Specify the size of the filesystem. If this option is not used, then mkfs.btrfs uses the entire device space for the filesystem.

**--csum ****&lt;type&gt;**, **--checksum ****&lt;type&gt;**
Specify the checksum algorithm. Default is
_crc32c_. Valid values are
_crc32c_,
_xxhash_,
_sha256_
or
_blake2_. To mount such filesystem kernel must support the checksums as well. See
_CHECKSUM ALGORITHMS_
in
**btrfs**(5).

**-d|--data ****&lt;profile&gt;**
Specify the profile for the data block groups. Valid values are
_raid0_,
_raid1_,
_raid5_,
_raid6_,
_raid10_
or
_single_
or
_dup_
(case does not matter).

See
_DUP PROFILES ON A SINGLE DEVICE_
for more details.

**-m|--metadata ****&lt;profile&gt;**
Specify the profile for the metadata block groups. Valid values are
_raid0_,
_raid1_,
_raid5_,
_raid6_,
_raid10_,
_single_
or
_dup_
(case does not matter).

A single device filesystem will default to
_DUP_, unless an SSD is detected, in which case it will default to
_single_. The detection is based on the value of
**/sys/block/DEV/queue/rotational**, where
_DEV_
is the short name of the device.

Note that the rotational status can be arbitrarily set by the underlying block device driver and may not reflect the true status (network block device, memory-backed SCSI devices etc). Use the options
_--data/--metadata_
to avoid confusion.

See
_DUP PROFILES ON A SINGLE DEVICE_
for more details.

**-M|--mixed**
Normally the data and metadata block groups are isolated. The
_mixed_
mode will remove the isolation and store both types in the same block group type. This helps to utilize the free space regardless of the purpose and is suitable for small devices. The separate allocation of block groups leads to a situation where the space is reserved for the other block group type, is not available for allocation and can lead to ENOSPC state.

The recommended size for the mixed mode is for filesystems less than 1GiB. The soft recommendation is to use it for filesystems smaller than 5GiB. The mixed mode may lead to degraded performance on larger filesystems, but is otherwise usable, even on multiple devices.

The
_nodesize_
and
_sectorsize_
must be equal, and the block group types must match.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
versions up to 4.2.x forced the mixed mode for devices smaller than 1GiB. This has been removed in 4.3+ as it caused some usability issues.


**-l|--leafsize ****&lt;size&gt;**
Alias for --nodesize. Deprecated.

**-n|--nodesize ****&lt;size&gt;**
Specify the nodesize, the tree block size in which btrfs stores metadata. The default value is 16KiB (16384) or the page size, whichever is bigger. Must be a multiple of the sectorsize and a power of 2, but not larger than 64KiB (65536). Leafsize always equals nodesize and the options are aliases.

Smaller node size increases fragmentation but leads to taller b-trees which in turn leads to lower locking contention. Higher node sizes give better packing and less fragmentation at the cost of more expensive memory operations while updating the metadata blocks.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
versions up to 3.11 set the nodesize to 4k.


**-s|--sectorsize ****&lt;size&gt;**
Specify the sectorsize, the minimum data block allocation unit.

The default value is the page size and is autodetected. If the sectorsize differs from the page size, the created filesystem may not be mountable by the kernel. Therefore it is not recommended to use this option unless you are going to mount it on a system with the appropriate page size.

**-L|--label ****&lt;string&gt;**
Specify a label for the filesystem. The
_string_
should be less than 256 bytes and must not contain newline characters.

**-K|--nodiscard**
Do not perform whole device TRIM operation on devices that are capable of that. This does not affect discard/trim operation when the filesystem is mounted. Please see the mount option
_discard_
for that in
**btrfs**(5).

**-r|--rootdir ****&lt;rootdir&gt;**
Populate the toplevel subvolume with files from
_rootdir_. This does not require root permissions to write the new files or to mount the filesystem.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
This option may enlarge the image or file to ensure it’s big enough to contain the files from
_rootdir_. Since version 4.14.1 the filesystem size is not minimized. Please see option
_--shrink_
if you need that functionality.


**--shrink**
Shrink the filesystem to its minimal size, only works with
_--rootdir_
option.

If the destination is a regular file, this option will also truncate the file to the minimal size. Otherwise it will reduce the filesystem available space. Extra space will not be usable unless the filesystem is mounted and resized using
_btrfs filesystem resize_.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
prior to version 4.14.1, the shrinking was done automatically.


**-O|--features ****&lt;feature1&gt;****[,****&lt;feature2&gt;****...]**
A list of filesystem features turned on at mkfs time. Not all features are supported by old kernels. To disable a feature, prefix it with
_^_.

See section
**FILESYSTEM FEATURES**
for more details. To see all available features that mkfs.btrfs supports run:

**mkfs.btrfs -O list-all**

**-R|--runtime-features ****&lt;feature1&gt;****[,****&lt;feature2&gt;****...]**
A list of features that be can enabled at mkfs time, otherwise would have to be turned on a mounted filesystem. Although no runtime feature is enabled by default, to disable a feature, prefix it with
_^_.

See section
**RUNTIME FEATURES**
for more details. To see all available runtime features that mkfs.btrfs supports run:

**mkfs.btrfs -R list-all**

**-f|--force**
Forcibly overwrite the block devices when an existing filesystem is detected. By default, mkfs.btrfs will utilize
_libblkid_
to check for any known filesystem on the devices. Alternatively you can use the
**wipefs**
utility to clear the devices.

**-q|--quiet**
Print only error or warning messages. Options --features or --help are unaffected.

**-U|--uuid ****&lt;UUID&gt;**
Create the filesystem with the given
_UUID_. The UUID must not exist on any filesystem currently present.

**-V|--version**
Print the
**mkfs.btrfs**
version and exit.

**--help**
Print help.

<a name="size-units"></a>

# Size Units


The default unit is _byte_. All size parameters accept suffixes in the 1024 base. The recognized suffixes are: _k_, _m_, _g_, _t_, _p_, _e_, both uppercase and lowercase.

<a name="multiple-devices"></a>

# Multiple Devices


Before mounting a multiple device filesystem, the kernel module must know the association of the block devices that are attached to the filesystem UUID.

There is typically no action needed from the user. On a system that utilizes a udev-like daemon, any new block device is automatically registered. The rules call **btrfs device scan**.

The same command can be used to trigger the device scanning if the btrfs kernel module is reloaded (naturally all previous information about the device registration is lost).

Another possibility is to use the mount options **device** to specify the list of devices to scan at the time of mount.

.if n \{.RS 4
.\}
    # mount -o device=/dev/sdb,device=/dev/sdc /dev/sda /mnt
.if n \{.RE
.\}

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

that this means only scanning, if the devices do not exist in the system, mount will fail anyway. This can happen on systems without initramfs/initrd and root partition created with RAID1/10/5/6 profiles. The mount action can happen before all block devices are discovered. The waiting is usually done on the initramfs/initrd systems.


As of kernel 4.14, RAID5/6 is still considered experimental and shouldn’t be employed for production use.

<a name="filesystem-features"></a>

# Filesystem Features


Features that can be enabled during creation time. See also **btrfs**(5) section _FILESYSTEM FEATURES_.

**mixed-bg**
(kernel support since 2.6.37)

mixed data and metadata block groups, also set by option
_--mixed_

**extref**
(default since btrfs-progs 3.12, kernel support since 3.7)

increased hardlink limit per file in a directory to 65536, older kernels supported a varying number of hardlinks depending on the sum of all file name sizes that can be stored into one metadata block

**raid56**
(kernel support since 3.9)

extended format for RAID5/6, also enabled if raid5 or raid6 block groups are selected

**skinny-metadata**
(default since btrfs-progs 3.18, kernel support since 3.10)

reduced-size metadata for extent references, saves a few percent of metadata

**no-holes**
(kernel support since 3.14)

improved representation of file extents where holes are not explicitly stored as an extent, saves a few percent of metadata if sparse files are used

<a name="runtime-features"></a>

# Runtime Features


Features that are typically enabled on a mounted filesystem, eg. by a mount option or by an ioctl. Some of them can be enabled early, at mkfs time. This applies to features that need to be enabled once and then the status is permanent, this does not replace mount options.

**quota**
(kernel support since 3.4)

Enable quota support (qgroups). The qgroup accounting will be consistent, can be used together with
_--rootdir_. See also
**btrfs-quota**(8).

<a name="block-groups-chunks-raid"></a>

# Block Groups, Chunks, Raid


The highlevel organizational units of a filesystem are block groups of three types: data, metadata and system.

**DATA**
store data blocks and nothing else

**METADATA**
store internal metadata in b-trees, can store file data if they fit into the inline limit

**SYSTEM**
store structures that describe the mapping between the physical devices and the linear logical space representing the filesystem

Other terms commonly used:

**block group**, **chunk**
a logical range of space of a given profile, stores data, metadata or both; sometimes the terms are used interchangeably

A typical size of metadata block group is 256MiB (filesystem smaller than 50GiB) and 1GiB (larger than 50GiB), for data it’s 1GiB. The system block group size is a few megabytes.

**RAID**
a block group profile type that utilizes RAID-like features on multiple devices: striping, mirroring, parity

**profile**
when used in connection with block groups refers to the allocation strategy and constraints, see the section
_PROFILES_
for more details

<a name="profiles"></a>

# Profiles


There are the following block group types available:
.TS
allbox tab(:);
ct c s s ct ct
^ c c ct ^ ^
lt ct ct ct rt ct
lt ct ct ct rt ct
lt ct ct ct rt ct
lt ct ct ct rt ct
lt ct ct ct rt ct
lt ct ct ct rt ct
lt ct ct ct rt ct
lt ct ct ct rt ct
lt ct ct ct rt ct.
T{

**Profile**
T}:T{

**Redundancy**
T}:T{

**Space utilization**
T}:T{

**Min/max devices**
T}
:T{

**Copies**
T}:T{

**Parity**
T}:T{

**Striping**
T}::
T{

single
T}:T{

1
T}:T{

T}:T{

T}:T{

100%
T}:T{

1/any
T}
T{

DUP
T}:T{

2 / 1 device
T}:T{

T}:T{

T}:T{

50%
T}:T{

1/any ^(see note 1)
T}
T{

RAID0
T}:T{

T}:T{

T}:T{

1 to N
T}:T{

100%
T}:T{

2/any
T}
T{

RAID1
T}:T{

2
T}:T{

T}:T{

T}:T{

50%
T}:T{

2/any
T}
T{

RAID1C3
T}:T{

3
T}:T{

T}:T{

T}:T{

33%
T}:T{

3/any
T}
T{

RAID1C4
T}:T{

4
T}:T{

T}:T{

T}:T{

25%
T}:T{

4/any
T}
T{

RAID10
T}:T{

2
T}:T{

T}:T{

1 to N
T}:T{

50%
T}:T{

4/any
T}
T{

RAID5
T}:T{

1
T}:T{

1
T}:T{

2 to N-1
T}:T{

(N-1)/N
T}:T{

2/any ^(see note 2)
T}
T{

RAID6
T}:T{

1
T}:T{

2
T}:T{

3 to N-2
T}:T{

(N-2)/N
T}:T{

3/any ^(see note 3)
T}
.TE

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

It’s not recommended to create filesystems with RAID0/1/10/5/6 profiles on partitions from the same device. Neither redundancy nor performance will be improved.


_Note 1:_ DUP may exist on more than 1 device if it starts on a single device and another one is added. Since version 4.5.1, **mkfs.btrfs** will let you create DUP on multiple devices without restrictions.

_Note 2:_ It’s not recommended to use 2 devices with RAID5. In that case, parity stripe will contain the same data as the data stripe, making RAID5 degraded to RAID1 with more overhead.

_Note 3:_ It’s also not recommended to use 3 devices with RAID6, unless you want to get effectively 3 copies in a RAID1-like manner (but not exactly that).

_Note 4:_ Since kernel 5.5 it’s possible to use RAID1C3 as replacement for RAID6, higher space cost but reliable.

<a name="profile-layout"></a>

### PROFILE LAYOUT


For the following examples, assume devices numbered by 1, 2, 3 and 4, data or metadata blocks A, B, C, D, with possible stripes eg. A1, A2 that would be logically A, etc. For parity profiles PA and QA are parity and syndrom, associated with the given stripe. The simple layouts single or DUP are left out. Actual physical block placement on devices depends on current state of the free/allocated space and may appear random. All devices are assumed to be present at the time of the blocks would have been written.

RAID1
.TS
allbox tab(:);
ctB ctB ctB ctB.
T{
device 1
T}:T{
device 2
T}:T{
device 3
T}:T{
device 4
T}
.T&
ct ct ct ct
ct ct ct ct
ct ct ct ct
ct ct ct ct.
T{

A
T}:T{

D
T}:T{

T}:T{

T}
T{

B
T}:T{

T}:T{

T}:T{

C
T}
T{

C
T}:T{

T}:T{

T}:T{

T}
T{

D
T}:T{

A
T}:T{

B
T}:T{

T}
.TE


RAID1C3
.TS
allbox tab(:);
ctB ctB ctB ctB.
T{
device 1
T}:T{
device 2
T}:T{
device 3
T}:T{
device 4
T}
.T&
ct ct ct ct
ct ct ct ct
ct ct ct ct
ct ct ct ct.
T{

A
T}:T{

A
T}:T{

D
T}:T{

T}
T{

B
T}:T{

T}:T{

B
T}:T{

T}
T{

C
T}:T{

T}:T{

A
T}:T{

C
T}
T{

D
T}:T{

D
T}:T{

C
T}:T{

B
T}
.TE


RAID0
.TS
allbox tab(:);
ctB ctB ctB ctB.
T{
device 1
T}:T{
device 2
T}:T{
device 3
T}:T{
device 4
T}
.T&
ct ct ct ct
ct ct ct ct
ct ct ct ct
ct ct ct ct.
T{

A2
T}:T{

C3
T}:T{

A3
T}:T{

C2
T}
T{

B1
T}:T{

A1
T}:T{

D2
T}:T{

B3
T}
T{

C1
T}:T{

D3
T}:T{

B4
T}:T{

D1
T}
T{

D4
T}:T{

B2
T}:T{

C4
T}:T{

A4
T}
.TE


RAID5
.TS
allbox tab(:);
ctB ctB ctB ctB.
T{
device 1
T}:T{
device 2
T}:T{
device 3
T}:T{
device 4
T}
.T&
ct ct ct ct
ct ct ct ct
ct ct ct ct
ct ct ct ct.
T{

A2
T}:T{

C3
T}:T{

A3
T}:T{

C2
T}
T{

B1
T}:T{

A1
T}:T{

D2
T}:T{

B3
T}
T{

C1
T}:T{

D3
T}:T{

PB
T}:T{

D1
T}
T{

PD
T}:T{

B2
T}:T{

PC
T}:T{

PA
T}
.TE


RAID6
.TS
allbox tab(:);
ctB ctB ctB ctB.
T{
device 1
T}:T{
device 2
T}:T{
device 3
T}:T{
device 4
T}
.T&
ct ct ct ct
ct ct ct ct
ct ct ct ct
ct ct ct ct.
T{

A2
T}:T{

QC
T}:T{

QA
T}:T{

C2
T}
T{

B1
T}:T{

A1
T}:T{

D2
T}:T{

QB
T}
T{

C1
T}:T{

QD
T}:T{

PB
T}:T{

D1
T}
T{

PD
T}:T{

B2
T}:T{

PC
T}:T{

PA
T}
.TE


<a name="dup-profiles-on-a-single-device"></a>

# Dup Profiles on a Single Device


The mkfs utility will let the user create a filesystem with profiles that write the logical blocks to 2 physical locations. Whether there are really 2 physical copies highly depends on the underlying device type.

For example, a SSD drive can remap the blocks internally to a single copy—thus deduplicating them. This negates the purpose of increased redundancy and just wastes filesystem space without providing the expected level of redundancy.

The duplicated data/metadata may still be useful to statistically improve the chances on a device that might perform some internal optimizations. The actual details are not usually disclosed by vendors. For example we could expect that not all blocks get deduplicated. This will provide a non-zero probability of recovery compared to a zero chance if the single profile is used. The user should make the tradeoff decision. The deduplication in SSDs is thought to be widely available so the reason behind the mkfs default is to not give a false sense of redundancy.

As another example, the widely used USB flash or SD cards use a translation layer between the logical and physical view of the device. The data lifetime may be affected by frequent plugging. The memory cells could get damaged, hopefully not destroying both copies of particular data in case of DUP.

The wear levelling techniques can also lead to reduced redundancy, even if the device does not do any deduplication. The controllers may put data written in a short timespan into the same physical storage unit (cell, block etc). In case this unit dies, both copies are lost. BTRFS does not add any artificial delay between metadata writes.

The traditional rotational hard drives usually fail at the sector level.

In any case, a device that starts to misbehave and repairs from the DUP copy should be replaced! **DUP is not backup**.

<a name="known-issues"></a>

# Known Issues


**SMALL FILESYSTEMS AND LARGE NODESIZE**

The combination of small filesystem size and large nodesize is not recommended in general and can lead to various ENOSPC-related issues during mount time or runtime.

Since mixed block group creation is optional, we allow small filesystem instances with differing values for _sectorsize_ and _nodesize_ to be created and could end up in the following situation:

.if n \{.RS 4
.\}
    # mkfs.btrfs -f -n 65536 /dev/loop0
    btrfs-progs v3.19-rc2-405-g976307c
    See http://btrfs.wiki.kernel.org for more information.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Performing full device TRIM (512.00MiB) ...
    Label:              (null)
    UUID:               49fab72e-0c8b-466b-a3ca-d1bfe56475f0
    Node size:          65536
    Sector size:        4096
    Filesystem size:    512.00MiB
    Block group profiles:
      Data:             single            8.00MiB
      Metadata:         DUP              40.00MiB
      System:           DUP              12.00MiB
    SSD detected:       no
    Incompat features:  extref, skinny-metadata
    Number of devices:  1
    Devices:
      ID        SIZE  PATH
       1   512.00MiB  /dev/loop0
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    # mount /dev/loop0 /mnt/
    mount: mount /dev/loop0 on /mnt failed: No space left on device
.if n \{.RE
.\}

The ENOSPC occurs during the creation of the UUID tree. This is caused by large metadata blocks and space reservation strategy that allocates more than can fit into the filesystem.

<a name="availability"></a>

# Availability


**mkfs.btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**btrfs**(5), **btrfs**(8), **wipefs**(8)
