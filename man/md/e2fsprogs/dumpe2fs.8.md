# dumpe2fs(8) - dump ext2/ext3/ext4 filesystem information

E2fsprogs version 1.45.6, March 2020

```
dumpe2fs [ -bfghixV ] [ -o superblock=superblock ] [ -o blocksize=blocksize ] device
```

<a name="description"></a>

# Description

**dumpe2fs**
prints the super block and blocks group information for the filesystem
present on
_device._

**Note:**
When used with a mounted filesystem, the printed
information may be old or inconsistent.

<a name="options"></a>

# Options


* **-b**  
  print the blocks which are reserved as bad in the filesystem.
* **-o superblock=superblock**  
  use the block
  _superblock_
  when examining the filesystem.
  This option is not usually needed except by a filesystem wizard who
  is examining the remains of a very badly corrupted filesystem.
* **-o blocksize=blocksize**  
  use blocks of
  _blocksize_
  bytes when examining the filesystem.
  This option is not usually needed except by a filesystem wizard who
  is examining the remains of a very badly corrupted filesystem.
* **-f**  
  force dumpe2fs to display a filesystem even though it may have some
  filesystem feature flags which dumpe2fs may not understand (and which
  can cause some of dumpe2fs's display to be suspect).
* **-g**  
  display the group descriptor information in a machine readable colon-separated
  value format.  The fields displayed are the group number; the number of the
  first block in the group; the superblock location (or -1 if not present); the
  range of blocks used by the group descriptors (or -1 if not present); the block
  bitmap location; the inode bitmap location; and the range of blocks used by the
  inode table.
* **-h**  
  only display the superblock information and not any of the block
  group descriptor detail information.
* **-i**  
  display the filesystem data from an image file created by
  **e2image**,
  using
  _device_
  as the pathname to the image file.
* **-m**  
  If the
  **mmp**
  feature is enabled on the filesystem, check if
  _device_
  is in use by another node, see
  **e2mmpstatus**(8)
  for full details.  If used together with the
  **-i**
  option, only the MMP block information is printed.
* **-x**  
  print the detailed group information block numbers in hexadecimal format
* **-V**  
  print the version number of
  **dumpe2fs**
  and exit.

<a name="exit-code"></a>

# Exit Code

**dumpe2fs**
exits with a return code of 0 if the operation completed without errors.
It will exit with a non-zero return code if there are any errors, such
as problems reading a valid superblock, bad checksums, or if the device
is in use by another node and
**-m**
is specified.

<a name="bugs"></a>

# Bugs

You may need to know the physical filesystem structure to understand the
output.

<a name="author"></a>

# Author

**dumpe2fs**
was written by Remy Card &lt;[Remy.Card@linux.org](mailto:Remy.Card@linux.org)&gt;.  It is currently being
maintained by Theodore Ts'o &lt;[tytso@alum.mit](mailto:tytso@alum.mit).edu&gt;.

<a name="availability"></a>

# Availability

**dumpe2fs**
is part of the e2fsprogs package and is available from
http://e2fsprogs.sourceforge.net.

<a name="see-also"></a>

# See Also

**e2fsck**(8),
**e2mmpstatus**(8),
**mke2fs**(8),
**tune2fs**(8).
**ext4**(5)

