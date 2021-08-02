# xfs_growfs(8) - expand an XFS filesystem

```
xfs_growfs [ -dilnrx ] [ -D size ] [ -e rtextsize ] [ -L size ] [ -m maxpct ] [ -t mtab ] [ -R size ] [ mount-point | block-device ]
</synopsis>

<synopsis>

xfs_growfs -V
```

<a name="description"></a>

# Description

**xfs_growfs**
expands an existing XFS filesystem (see
**xfs**(5)).
The
_mount-point_
argument is the pathname of the directory where the filesystem
is mounted. The
_block-device_
argument is the device name of a mounted XFS filesystem.
The filesystem must be mounted to be grown (see
**mount**(8)).
The existing contents of the filesystem are undisturbed, and the added space
becomes available for additional file storage.

<a name="options"></a>

# Options


* **-d | -D **_size_  
  Specifies that the data section of the filesystem should be grown. If the
  **-D**
  _size_
  option is given, the data section is grown to that
  _size_,
  otherwise the data section is grown to the largest size possible with the
  **-d**
  option. The size is expressed in filesystem blocks.
* **-e**  
  Allows the real-time extent size to be specified. In
  **mkfs.xfs**(8)
  this is specified with
  **-r extsize=\c**
  _nnnn_.
* **-i**  
  The new log is an internal log (inside the data section).
  **[NOTE: This option is not implemented]**
* **-l | -L **_size_  
  Specifies that the log section of the filesystem should be grown,
  shrunk, or moved. If the
  **-L**
  _size_
  option is given, the log section is changed to be that
  _size_,
  if possible. The size is expressed in filesystem blocks.
  The size of an internal log must be smaller than the size
  of an allocation group (this value is printed at
  **mkfs**(8)
  time). If neither
  **-i**
  nor
  **-x**
  is given with
  **-l**,
  the log continues to be internal or external as it was before.
  **[NOTE: These options are not implemented]**
* **-m**  
  Specify a new value for the maximum percentage
  of space in the filesystem that can be allocated as inodes. In
  **mkfs.xfs**(8)
  this is specified with
  **-i maxpct=\c**
  _nn_.
* **-n**  
  Specifies that no change to the filesystem is to be made.
  The filesystem geometry is printed, and argument checking is performed,
  but no growth occurs.
  **See output examples below.**
* **-r | -R **_size_  
  Specifies that the real-time section of the filesystem should be grown. If the
  **-R**
  _size_
  option is given, the real-time section is grown to that size, otherwise
  the real-time section is grown to the largest size possible with the
  **-r**
  option. The size is expressed in filesystem blocks.
  The filesystem does not need to have contained a real-time section before
  the
  **xfs_growfs**
  operation.
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
* **-V**  
  Prints the version number and exits. The
  _mount-point_
  argument is not required with
  **-V**.

**xfs_growfs**
is most often used in conjunction with
logical volumes
(see
**md**(4)
and
**lvm**(8)
on Linux).
However, it can also be used on a regular disk partition, for example if a
partition has been enlarged while retaining the same starting block.

<a name="practical-use"></a>

# Practical Use

Filesystems normally occupy all of the space on the device where they
reside. In order to grow a filesystem, it is necessary to provide added
space for it to occupy. Therefore there must be at least one spare new
disk partition available. Adding the space is often done through the use
of a logical volume manager.

<a name="see-also"></a>

# See Also

**mkfs.xfs**(8),
**xfs_info**(8),
**md**(4),
**lvm**(8),
**mount**(8).
