# fsck.cramfs(8) - fsck compressed ROM file system

util-linux, April 2013

```
fsck.cramfs [options] file
```

<a name="description"></a>

# Description

_fsck.cramfs_
is used to check the cramfs file system.

<a name="options"></a>

# Options


* **-v**, **--verbose**  
  Enable verbose messaging.
* **-b**, **--blocksize** _blocksize_  
  Use this blocksize, defaults to page size. Must be equal to what was set at
  creation time. Only used for --extract.
* **--extract**[=_directory_]  
  Test to uncompress the whole file system. Optionally extract contents of the
  _file_
  to
  _directory_.
* **-a**  
  This option is silently ignored.
* **-y**  
  This option is silently ignored.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="exit-status"></a>

# Exit Status


* **0**
  success
* **4**
  file system was left uncorrected
* **8**
  operation error, such as unable to allocate memory
* **16**
  usage information was printed

<a name="see-also"></a>

# See Also

**mount**(8),
**mkfs.cramfs**(8)

<a name="availability"></a>

# Availability

The example command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
