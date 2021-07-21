# xfs_info(8) - display XFS filesystem geometry information

```
xfs_info [ -t mtab ] [ mount-point | block-device | file-image ]
xfs_info -V
```

<a name="description"></a>

# Description

**xfs_info**
displays geometry information about an existing XFS filesystem.
The
_mount-point_
argument is the pathname of a directory where the filesystem
is mounted.
The
_block-device_
or
_file-image_
contain a raw XFS filesystem.
The existing contents of the filesystem are undisturbed.

<a name="options"></a>

# Options


* **-t**  
  Specifies an alternate mount table file (default is
  _/proc/mounts_
  if it exists, else
  _/etc/mtab_).
  This is used when working with filesystems mounted without writing to
  _/etc/mtab_
  file - refer to
  **mount**(8)
  for further details.
  This option has no effect with the
  _block-device_ or _file-image_
  parameters.
* **-V**  
  Prints the version number and exits. The
  _mount-point_
  argument is not required with
  **-V**.

<a name="examples"></a>

# Examples


Understanding xfs_info output.

Suppose one has the following "xfs_info /dev/sda" output:

.Vb
meta-data=/dev/pmem0             isize=512    agcount=8, agsize=5974144 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1
data     =                       bsize=4096   blocks=47793152, imaxpct=25
         =                       sunit=32     swidth=128 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=23336, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
.Ve


Here, the data section of the output indicates "bsize=4096",
meaning the data block size for this filesystem is 4096 bytes.
This section also shows "sunit=32 swidth=128 blks", which means
the stripe unit is 32*4096 bytes = 128 kibibytes and the stripe
width is 128*4096 bytes = 512 kibibytes.
A single stripe of this filesystem therefore consists
of four stripe units (128 blocks / 32 blocks per unit).

<a name="see-also"></a>

# See Also

**mkfs.xfs**(8),
**md**(4),
**lvm**(8),
**mount**(8).
