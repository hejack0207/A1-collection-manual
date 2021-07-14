# wipefs(8) - wipe a signature from a device

util-linux, December 2014

```
wipefs [options] device... 
 wipefs [--backup] -o offset device... 
 wipefs [--backup] -a device...
```

<a name="description"></a>

# Description

**wipefs**
can erase filesystem, raid or partition-table signatures (magic strings) from
the specified
_device_
to make the signatures invisible for libblkid.
**wipefs**
does not erase the filesystem itself nor any other data from the device.

When used without any options, wipefs lists all visible filesystems and the
offsets of their basic signatures.  The default output is subject to change.
So whenever possible, you should avoid using default outputs in your scripts.
Always explicitly define expected columns by using
**--output**
_columns-list_
in environments where a stable output is required.

**wipefs**
calls the BLKRRPART ioctl when it has erased a partition-table signature
to inform the kernel about the change. The ioctl is called as the last step
and when all specified signatures from all specified devices are already erased.

Note that some filesystems and some partition tables store more magic strings on
the device (e.g. FAT, ZFS, GPT).  The
**wipefs**
command (since v2.31) lists all the offset where a magic strings have been
detected.

When option **-a** is used, all magic strings that are visible for libblkid are
erased. In this case the
**wipefs**
scans the device again after each modification (erase) until no magic string is found.

Note that by default
**wipefs**
does not erase nested partition tables on non-whole disk devices.
For this the option **--force** is required.


<a name="options"></a>

# Options


* **-a**,** --all**  
  Erase all available signatures.  The set of erased signatures can be
  restricted with the **-t** option.
* **-b**,** --backup**  
  Create a signature backup to the file $HOME/wipefs-&lt;devname&gt;-&lt;offset&gt;.bak.
  For more details see the **EXAMPLES** section.
* **-f**,** --force**  
  Force erasure, even if the filesystem is mounted.  This is required in
  order to erase a partition-table signature on a block device.
* **-h**,** --help**  
  Display help text and exit.
* **-J**,** --json**  
  Use JSON output format.
* **-n**,** --noheadings**  
  Do not print a header line.
* **-O**,** --output **_list_  
  Specify which output columns to print.  Use --help to
  get a list of all supported columns.
* **-n**,** --no-act**  
  Causes everything to be done except for the write() call.
* **-o**,** --offset **_offset_  
  Specify the location (in bytes) of the signature which should be erased from the
  device.  The _offset_ number may include a "0x" prefix; then the number will be
  interpreted as a hex value.  It is possible to specify multiple **-o** options.

The _offset_ argument may be followed by the multiplicative
suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
(the "iB" is optional, e.g. "K" has the same meaning as "KiB"), or the suffixes
KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.

* **-p**,** --parsable**  
  Print out in parsable instead of printable format.  Encode all potentially unsafe
  characters of a string to the corresponding hex value prefixed by '\\x'.
* **-q**,** --quiet**  
  Suppress any messages after a successful signature wipe.
* **-t**,** --types **_list_  
  Limit the set of printed or erased signatures.  More than one type may
  be specified in a comma-separated list.  The list or individual types
  can be prefixed with 'no' to specify the types on which no action should be
  taken.  For more details see mount(8).
* **-V**,** --version**  
  Display version information and exit.

<a name="examples"></a>

# Examples


* **wipefs /dev/sda***  
  Prints information about sda and all partitions on sda.
* **wipefs --all --backup /dev/sdb**  
  Erases all signatures from the device /dev/sdb and creates a signature backup
  file ~/wipefs-sdb-&lt;offset&gt;.bak for each signature.
* **dd if=~/wipefs-sdb-0x00000438.bak of=/dev/sdb seek=$((0x00000438)) bs=1 conv=notrunc**  
  Restores an ext2 signature from the backup file  ~/wipefs-sdb-0x00000438.bak.

<a name="author"></a>

# Author

Karel Zak &lt;[kzak@redhat.com](mailto:kzak@redhat.com)&gt;

<a name="environment"></a>

# Environment


* LIBBLKID_DEBUG=all  
  enables libblkid debug output.

<a name="see-also"></a>

# See Also

**blkid**(8),
**findfs**(8)

<a name="availability"></a>

# Availability

The wipefs command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
