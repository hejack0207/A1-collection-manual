# filefrag(8) - report on file fragmentation

E2fsprogs version 1.45.6, March 2020

```
filefrag [ -bblocksize ] [ -BeksvxX ] [ files... ]
```

<a name="description"></a>

# Description

**filefrag**
reports on how badly fragmented a particular file might be.  It makes
allowances for indirect blocks for ext2 and ext3 filesystems, but can be
used on files for any filesystem.

The
**filefrag**
program initially attempts to get the
extent information using FIEMAP ioctl which is more efficient and faster.
If FIEMAP is not supported then filefrag will fall back to using FIBMAP.

<a name="options"></a>

# Options


* **-B**  
  Force the use of the older FIBMAP ioctl instead of the FIEMAP ioctl for
  testing purposes.
* **-b**_blocksize_  
  Use
  _blocksize_
  in bytes, or with [KMG] suffix, up to 1GB for output instead of the
  filesystem blocksize.  For compatibility with earlier versions of
  **filefrag**,
  if
  _blocksize_
  is unspecified it defaults to 1024 bytes.
* **-e**  
  Print output in extent format, even for block-mapped files.
* **-k**  
  Use 1024-byte blocksize for output (identical to '-b 1024').
* **-s**  
  Sync the file before requesting the mapping.
* **-v**  
  Be verbose when checking for file fragmentation.
* **-x**  
  Display mapping of extended attributes.
* **-X**  
  Display extent block numbers in hexadecimal format.

<a name="author"></a>

# Author

**filefrag**
was written by Theodore Ts'o &lt;[tytso@mit.edu](mailto:tytso@mit.edu)&gt;.
