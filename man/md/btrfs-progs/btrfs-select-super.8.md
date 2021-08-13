# btrfs\-select\-super(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-select-super - overwrite primary superblock with a backup copy

<a name="synopsis"></a>

# Synopsis

```

 btrfs-select-super -s number <device>
```

<a name="description"></a>

# Description


Destructively overwrite all copies of the superblock with a specified copy. This helps in certain cases, for example when write barriers were disabled during a power failure and not all superblocks were written, or if the primary superblock is damaged, eg. accidentally overwritten.

The filesystem specified by _device_ must not be mounted.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

**Prior to overwriting the primary superblock, please make sure that the backup copies are valid!**


To dump a superblock use the **btrfs inspect-internal dump-super** command.

Then run the check (in the non-repair mode) using the command **btrfs check -s** where _-s_ specifies the superblock copy to use.

Superblock copies exist in the following offsets on the device:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  primary:
  _64KiB_
  (65536)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  1st copy:
  _64MiB_
  (67108864)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  2nd copy:
  _256GiB_
  (274877906944)

A superblock size is _4KiB_ (4096).

<a name="options"></a>

# Options


-s|--super _&lt;superblock&gt;_
use superblock’th superblock copy, valid values are 0 1 or 2 if the respective superblock offset is within the device size

<a name="see-also"></a>

# See Also


**btrfs-inspect-internal**(8), **btrfsck check**(8)
