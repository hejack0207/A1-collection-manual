# mkfs.cramfs(8) - make compressed ROM file system

util-linux, April 2013

```
mkfs.cramfs [options] directory file
```

<a name="description"></a>

# Description

Files on cramfs file systems are zlib-compressed one page at a time to
allow random read access.  The metadata is not compressed, but is
expressed in a terse representation that is more space-efficient than
conventional file systems.

The file system is intentionally read-only to simplify its design; random
write access for compressed files is difficult to implement.  cramfs
ships with a utility (mkcramfs) to pack files into new cramfs images.

File sizes are limited to less than 16&nbsp;MB.

Maximum file system size is a little under 272&nbsp;MB.  (The last file on the
file system must begin before the 256&nbsp;MB block, but can extend past it.)

<a name="arguments"></a>

# Arguments

The
_directory_
is simply the root of the directory tree that we want to generate a
compressed filesystem out of.

The
_file_
will contain the cram file system, which later can be mounted.

<a name="options"></a>

# Options


* **-v**  
  Enable verbose messaging.
* **-E**  
  Treat all warnings as errors, which are reflected as command return value.
* **-b** _blocksize_  
  Use defined block size, which has to be divisible by page size.
* **-e** _edition_  
  Use defined file system edition number in superblock.
* **-N** _big, little, host_  
  Use defined endianness.  Value defaults to
  _host_.
* **-i** _file_  
  Insert a
  _file_
  to cramfs file system.
* **-n** _name_  
  Set name of the cramfs file system.
* **-p**  
  Pad by 512 bytes for boot code.
* **-s**  
  This option is ignored.  Originally the -s turned on directory entry
  sorting.
* **-z**  
  Make explicit holes.
* **-h**, **--help**  
  Display help text and exit.
* **-V**, **--version**  
  Display version information and exit.

<a name="exit-status"></a>

# Exit Status


* **0**
  success
* **8**
  operation error, such as unable to allocate memory

<a name="see-also"></a>

# See Also

**fsck.cramfs**(8),
**mount**(8)

<a name="availability"></a>

# Availability

The example command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
