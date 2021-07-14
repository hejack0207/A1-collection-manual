# mkfs.minix(8) - make a Minix filesystem

util-linux, June 2015

```
mkfs.minix [options] device [size-in-blocks]
```

<a name="description"></a>

# Description

**mkfs.minix**
creates a Linux MINIX filesystem on a device (usually a disk partition).

The
_device_
is usually of the following form:

    .RS
    /dev/hda[1–8] (IDE disk 1)
    /dev/hdb[1–8] (IDE disk 2)
    /dev/sda[1–8] (SCSI disk 1)
    /dev/sdb[1–8] (SCSI disk 2)
    .RE

The device may be a block device or an image file of one, but this is not
enforced.  Expect not much fun on a character device :-).

The
_size-in-blocks_
parameter is the desired size of the file system, in blocks.
It is present only for backwards compatibility.
If omitted the size will be determined automatically.
Only block counts strictly greater than 10 and strictly less than
65536 are allowed.

<a name="options"></a>

# Options


* **-c**, **--check**  
  Check the device for bad blocks before creating the filesystem.  If any
  are found, the count is printed.
* **-n**, **--namelength** _length_  
  Specify the maximum length of filenames.  Currently, the only allowable
  values are 14 and 30 for file system versions 1 and 2.  Version 3 allows
  only value 60.  The default is 30.
* **-i**, **--inodes** _number_  
  Specify the number of inodes for the filesystem.
* **-l**, **--badblocks** _filename_  
  Read the list of bad blocks from
  _filename_.
  The file has one bad-block number per line.  The count of bad blocks read
  is printed.
* **-1**  
  Make a Minix version 1 filesystem.  This is the default.
* **-2**,** -v**  
  Make a Minix version 2 filesystem.
* **-3**  
  Make a Minix version 3 filesystem.
* **-V**, **--version**  
  Display version information and exit.  The long option cannot be combined
  with other options.
* **-h**, **--help**  
  Display help text and exit.

<a name="exit-codes"></a>

# Exit Codes

The exit code returned by
**mkfs.minix**
is one of the following:

* 0  
  No errors
* 8  
  Operational error
* 16  
  Usage or syntax error

<a name="see-also"></a>

# See Also

**fsck**(8),
**mkfs**(8),
**reboot**(8)

<a name="availability"></a>

# Availability

The mkfs.minix command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
