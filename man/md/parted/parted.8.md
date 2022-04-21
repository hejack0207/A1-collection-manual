# parted(8) - a partition manipulation program

parted, 2007 March 29

```
parted [options] [device [command [options...]...]]
```

<a name="description"></a>

# Description

**parted**
is a program to manipulate disk partitions.  It supports multiple partition
table formats, including MS-DOS and GPT.  It is useful for creating space for
new operating systems, reorganising disk usage, and copying data to new hard
disks.

This manual page documents **parted** briefly.  Complete documentation is
distributed with the package in GNU Info format.

<a name="options"></a>

# Options


* **-h, --help**  
  displays a help message
* **-l, --list**  
  lists partition layout on all block devices
* **-m, --machine**  
  displays machine parseable output
* **-s, --script**  
  never prompts for user intervention
* **-v, --version**  
  displays the version
* **-a _alignment-type_, --align _alignment-type_**  
  Set alignment for newly created partitions, valid alignment types are:
    * none  
      Use the minimum alignment allowed by the disk type.
    * cylinder  
      Align partitions to cylinders.
    * minimal  
      Use minimum alignment as given by the disk topology information. This and
      the opt value will use layout information provided by the disk to align the
      logical partition table addresses to actual physical blocks on the disks.
      The min value is the minimum alignment needed to align the partition properly to
      physical blocks, which avoids performance degradation.
    * optimal  
      Use optimum alignment as given by the disk topology information. This
      aligns to a multiple of the physical block size in a way that guarantees
      optimal performance.
  

<a name="commands"></a>

# Commands


* **[device]**  
  The block device to be used.  When none is given, **parted** will use the
  first block device it finds.
* **[command [options]]**  
  Specifies the command to be executed.  If no command is given,
  **parted**
  will present a command prompt.  Possible commands are:
    * **help _[command]_**  
      Print general help, or help on _command_ if specified.
    * **align-check _type_ _partition_**  
      Check if _partition_ satisfies the alignment constraint of _type_.
      _type_ must be "minimal" or "optimal".
    * **mklabel _label-type_**  
      Create a new disklabel (partition table) of _label-type_.  _label-type_
      should be one of "aix", "amiga", "bsd", "dvh", "gpt", "loop", "mac", "msdos",
      "pc98", or "sun".
    * **mkpart [_part-type_ _name_ _fs-type_] _start_ _end_**  
      Create a new partition. _part-type_ may be specified only with msdos and
      dvh partition tables, it should be one of "primary", "logical", or "extended".
      _name_ is required for GPT partition tables and _fs-type_ is optional.
      _fs-type_ can be one of "btrfs", "ext2", "ext3", "ext4", "fat16", "fat32",
      "hfs", "hfs+", "linux-swap", "ntfs", "reiserfs", "udf", or "xfs".
    * **name _partition_ _name_**  
      Set the name of _partition_ to _name_. This option works only on Mac,
      PC98, and GPT disklabels. The name can be placed in double quotes, if necessary.
      And depending on the shell may need to also be wrapped in single quotes so that
      the shell doesn't strip off the double quotes.
    * **print**  
      Display the partition table.
    * **quit**  
      Exit from **parted**.
    * **rescue _start_ _end_**  
      Rescue a lost partition that was located somewhere between _start_ and
      _end_.  If a partition is found, **parted** will ask if you want to
      create an entry for it in the partition table.
    * **resizepart _partition_ _end_**  
      Change the _end_ position of _partition_.  Note that this does not
      modify any filesystem present in the partition.
    * **rm _partition_**  
      Delete _partition_.
    * **select _device_**  
      Choose _device_ as the current device to edit. _device_ should usually
      be a Linux hard disk device, but it can be a partition, software raid device,
      or an LVM logical volume if necessary.
    * **set _partition_ _flag_ _state_**  
      Change the state of the _flag_ on _partition_ to _state_.
      Supported flags are: "boot", "root", "swap", "hidden", "raid", "lvm", "lba",
      "legacy_boot", "irst", "msftres", "esp", "chromeos_kernel", "bls_boot" and "palo".
      _state_ should be either "on" or "off".
    * **unit _unit_**  
      Set _unit_ as the unit to use when displaying locations and sizes, and for
      interpreting those given by the user when not suffixed with an explicit unit.
      _unit_ can be one of "s" (sectors), "B" (bytes), "kB", "MB", "MiB", "GB",
      "GiB", "TB", "TiB", "%" (percentage of device size), "cyl" (cylinders), "chs"
      (cylinders, heads, sectors), or "compact" (megabytes for input, and a
      human-friendly form for output).
    * **toggle _partition_ _flag_**  
      Toggle the state of _flag_ on _partition_.
    * **version**  
      Display version information and a copyright message.

<a name="reporting-bugs"></a>

# Reporting Bugs

Report bugs to &lt;bug-parted@gnu.org&gt;

<a name="see-also"></a>

# See Also

**fdisk**(8),
**mkfs**(8),
The _parted_ program is fully documented in the
**info(1)**
format
_GNU partitioning software_
manual.

<a name="author"></a>

# Author

This manual page was written by Timshel Knoll &lt;[timshel@debian.org](mailto:timshel@debian.org)&gt;,
for the Debian GNU/Linux system (but may be used by others).
