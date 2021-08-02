# xfs_admin(8) - change parameters of an XFS filesystem

```
xfs_admin [ -eflpu ] [ -c 0|1 ] [ -L label ] [ -U uuid ] device [ logdev ]
xfs_admin -V
```

<a name="description"></a>

# Description

**xfs_admin**
uses the
**xfs_db**(8)
command to modify various parameters of a filesystem.

Devices that are mounted cannot be modified.
Administrators must unmount filesystems before
**xfs_admin** or **xfs_db**(8)
can convert parameters.
A number of parameters of a mounted filesystem can be examined
and modified using the
**xfs_growfs**(8)
command.

The optional
**logdev**
parameter specifies the device special file where the filesystem's external
log resides.
This is required only for filesystems that use an external log.
See the
**mkfs.xfs -l**
option, and refer to
**xfs**(5)
for a detailed description of the XFS log.

<a name="options"></a>

# Options


* **-e**  
  Enables unwritten extent support on a filesystem that does not
  already have this enabled (for legacy filesystems, it can't be
  disabled anymore at mkfs time).
* **-f**  
  Specifies that the filesystem image to be processed is stored in a
  regular file at
  _device_
  (see the
  **mkfs.xfs -d**
  _file_
  option).
* **-j**  
  Enables version 2 log format (journal format supporting larger
  log buffers).
* **-l**  
  Print the current filesystem label.
* **-p**  
  Enable 32bit project identifier support (PROJID32BIT feature).
* **-u**  
  Print the current filesystem UUID (Universally Unique IDentifier).
* **-c 0**|**1**  
  Enable (1) or disable (0) lazy-counters in the filesystem.
* Lazy-counters may not be disabled on Version 5 superblock filesystems
  (i.e. those with metadata CRCs enabled).
* This operation may take quite a bit of time on large filesystems as the
  entire filesystem needs to be scanned when this option is changed.
* With lazy-counters enabled, the superblock is not modified or logged on
  every change of the free-space and inode counters. Instead, enough
  information is kept in other parts of the filesystem to be able to
  maintain the counter values without needing to keep them in the
  superblock. This gives significant improvements in performance on some
  configurations and metadata intensive workloads.
* **-L**_ label_  
  Set the filesystem label to
  _label_.
  XFS filesystem labels can be at most 12 characters long; if
  _label_
  is longer than 12 characters,
  **xfs_admin**
  will truncate it and print a warning message.
  The filesystem label can be cleared using the special "\c
  **--\c**
  " value for
  _label_.
* **-U**_ uuid_  
  Set the UUID of the filesystem to
  _uuid_.
  A sample UUID looks like this: "c1b9d5a2-f162-11cf-9ece-0020afc76f16".
  The
  _uuid_
  may also be
  **nil**,
  which will set the filesystem UUID to the null UUID.
  The
  _uuid_
  may also be
  **generate**,
  which will generate a new UUID for the filesystem.  Note that on CRC-enabled
  filesystems, this will set an incompatible flag such that older kernels will
  not be able to mount the filesystem.  To remove this incompatible flag, use
  **restore**,
  which will restore the original UUID and remove the incompatible
  feature flag as needed.
* **-V**  
  Prints the version number and exits.

The
**mount**(8)
manual entry describes how to mount a filesystem using its label or UUID,
rather than its block special device name.

<a name="see-also"></a>

# See Also

**mkfs.xfs**(8),
**mount**(8),
**xfs_db**(8),
**xfs_growfs**(8),
**xfs_repair**(8),
**xfs**(5).
