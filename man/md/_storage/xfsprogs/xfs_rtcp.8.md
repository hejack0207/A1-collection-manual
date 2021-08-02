# xfs_rtcp(8) - XFS realtime copy command

```
xfs_rtcp [ -e extsize ] [ -p ] source ... target
xfs_rtcp -V
```

<a name="description"></a>

# Description

**xfs_rtcp**
copies a file to the realtime partition on an XFS filesystem.
If there is more than one
_source_
and
_target_,
the final argument (the
_target_)
must be a directory which already exists.

<a name="options"></a>

# Options


* **-e**_ extsize_  
  Sets the extent size of the destination realtime file.
* **-p**  
  Use if the size of the source file is not an even multiple of
  the block size of the destination filesystem. When
  **-p**
  is specified
  **xfs_rtcp**
  will pad the destination file to a size which is an even multiple
  of the filesystem block size.
  This is necessary since the realtime file is created using
  direct I/O and the minimum I/O is the filesystem block size.
* **-V**  
  Prints the version number and exits.

<a name="see-also"></a>

# See Also

**xfs**(5),
**mkfs.xfs**(8),
**mount**(8).

<a name="caveats"></a>

# Caveats

Currently, realtime partitions are not supported under the Linux
version of XFS, and use of a realtime partition
**WILL CAUSE CORRUPTION**
on the data partition. As such, this command is made available for curious
**DEVELOPERS ONLY**
at this point in time.
