# btrfs\-convert(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-convert - convert from ext2/3/4 or reiserfs filesystem to btrfs in-place

<a name="synopsis"></a>

# Synopsis

```

 btrfs-convert [options] <device>
```

<a name="description"></a>

# Description


**btrfs-convert** is used to convert existing source filesystem image to a btrfs filesystem in-place. The original filesystem image is accessible in subvolume named like _ext2\_saved_ as file _image_.

Supported filesystems:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ext2, ext3, ext4 — original feature, always built in

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  reiserfs — since version 4.13, optionally built, requires libreiserfscore 3.6.27

The list of supported source filesystem by a given binary is listed at the end of help (option _--help_).
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

If you are going to perform rollback to the original filesystem, you should not execute **btrfs balance** command on the converted filesystem. This will change the extent layout and make **btrfs-convert** unable to rollback.


The conversion utilizes free space of the original filesystem. The exact estimate of the required space cannot be foretold. The final btrfs metadata might occupy several gigabytes on a hundreds-gigabyte filesystem.

If the ability to rollback is no longer important, the it is recommended to perform a few more steps to transition the btrfs filesystem to a more compact layout. This is because the conversion inherits the original data blocks fragmentation, and also because the metadata blocks are bound to the original free space layout.

Due to different constraints, it is only possible to convert filesystems that have a supported data block size (ie. the same that would be valid for _mkfs.btrfs_). This is typically the system page size (4KiB on x86_64 machines).
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

The source filesystem should be clean, you are encouraged to run the _fsck_ tool if you’re not sure.


**REMOVE THE ORIGINAL FILESYSTEM METADATA**

By removing the subvolume named like _ext2\_saved_ or _reiserfs\_saved_, all metadata of the original filesystem will be removed:

.if n \{.RS 4
.\}
    # btrfs subvolume delete /mnt/ext2_saved
.if n \{.RE
.\}

At this point it is not possible to do a rollback. The filesystem is usable but may be impacted by the fragmentation inherited from the original filesystem.

**MAKE FILE DATA MORE CONTIGUOUS**

An optional but recommended step is to run defragmentation on the entire filesystem. This will attempt to make file extents more contiguous.

.if n \{.RS 4
.\}
    # btrfs filesystem defrag -v -r -f -t 32M /mnt/btrfs
.if n \{.RE
.\}

Verbose recursive defragmentation (_-v_, _-r_), flush data per-file (_-f_) with target extent size 32MiB (_-t_).

**ATTEMPT TO MAKE BTRFS METADATA MORE COMPACT**

Optional but recommended step.

The metadata block groups after conversion may be smaller than the default size (256MiB or 1GiB). Running a balance will attempt to merge the block groups. This depends on the free space layout (and fragmentation) and may fail due to lack of enough work space. This is a soft error leaving the filesystem usable but the block group layout may remain unchanged.

Note that balance operation takes a lot of time, please see also **btrfs-balance**(8).

.if n \{.RS 4
.\}
    # btrfs balance start -m /mnt/btrfs
.if n \{.RE
.\}

<a name="options"></a>

# Options


--csum _&lt;type&gt;_, --checksum _&lt;type&gt;_
Specify the checksum algorithm. Default is
_crc32c_. Valid values are
_crc32c_,
_xxhash_,
_sha256_
or
_blake2_. To mount such filesystem kernel must support the checksums as well.

-d|--no-datasum
disable data checksum calculations and set the NODATASUM file flag, this can speed up the conversion

-i|--no-xattr
ignore xattrs and ACLs of files

-n|--no-inline
disable inlining of small files to metadata blocks, this will decrease the metadata consumption and may help to convert a filesystem with low free space

-N|--nodesize _&lt;SIZE&gt;_
set filesystem nodesize, the tree block size in which btrfs stores its metadata. The default value is 16KB (16384) or the page size, whichever is bigger. Must be a multiple of the sectorsize, but not larger than 65536. See
**mkfs.btrfs**(8) for more details.

-r|--rollback
rollback to the original ext2/3/4 filesystem if possible

-l|--label _&lt;LABEL&gt;_
set filesystem label during conversion

-L|--copy-label
use label from the converted filesystem

-O|--features _&lt;feature1&gt;_[,_&lt;feature2&gt;_...]
A list of filesystem features enabled the at time of conversion. Not all features are supported by old kernels. To disable a feature, prefix it with
_^_. Description of the features is in section
_FILESYSTEM FEATURES_
of
**mkfs.btrfs**(8).

To see all available features that btrfs-convert supports run:

**btrfs-convert -O list-all**

-p|--progress
show progress of conversion (a heartbeat indicator and number of inodes processed), on by default

--no-progress
disable progress and show only the main phases of conversion

<a name="exit-status"></a>

# Exit Status


**btrfs-convert** will return 0 if no error happened. If any problems happened, 1 will be returned.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8)
