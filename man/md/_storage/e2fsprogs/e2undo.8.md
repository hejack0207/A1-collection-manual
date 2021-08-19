# e2undo(8) - Replay an undo log for an ext2/ext3/ext4 filesystem

E2fsprogs version 1.45.6, March 2020

```
e2undo [ -f ] [ -h ] [ -n ] [ -o offset ] [ -v ] [ -z undo_file ] undo_log device
```

<a name="description"></a>

# Description

**e2undo**
will replay the undo log
_undo_log_
for an ext2/ext3/ext4 filesystem found on
_device_.
This can be
used to undo a failed operation by an e2fsprogs program.

<a name="options"></a>

# Options


* **-f**  
  Normally,
  **e2undo**
  will check the filesystem superblock to make sure the undo log matches
  with the filesystem on the device.  If they do not match,
  **e2undo**
  will refuse to apply the undo log as a safety mechanism.  The
  **-f**
  option disables this safety mechanism.
* **-h**  
  Display a usage message.
* **-n**  
  Dry-run; do not actually write blocks back to the filesystem.
* **-o**_ offset_  
  Specify the filesystem's
  _offset_
  (in bytes) from the beginning of the device or file.
* **-v**  
  Report which block we're currently replaying.
* **-z**_ undo_file_  
  Before overwriting a file system block, write the old contents of the block to
  an undo file.  This undo file can be used with e2undo(8) to restore the old
  contents of the file system should something go wrong.  If the empty string is
  passed as the undo_file argument, the undo file will be written to a file named
  e2undo-_device_.e2undo in the directory specified via the
  _E2FSPROGS\_UNDO\_DIR_ environment variable.
  
  WARNING: The undo file cannot be used to recover from a power or system crash.

<a name="author"></a>

# Author

**e2undo**
was written by Aneesh Kumar K.V. ([aneesh.kumar@linux.vnet](mailto:aneesh.kumar@linux.vnet).ibm.com)

<a name="availability"></a>

# Availability

**e2undo**
is part of the e2fsprogs package and is available from
http://e2fsprogs.sourceforge.net.

<a name="see-also"></a>

# See Also

**mke2fs**(8),
**tune2fs**(8)

