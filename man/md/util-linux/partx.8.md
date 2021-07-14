# partx(8) - tell the kernel about the presence and numbering of on-disk partitions

util-linux, December 2014

```
partx [-a|-d|-P|-r|-s|-u] [-t type] [-n M:N] [-] disk
partx [-a|-d|-P|-r|-s|-u] [-t type] partition [disk]
```

<a name="description"></a>

# Description

Given a device or disk-image,
**partx**
tries to parse the partition table and list its contents.  It
can also tell the kernel to add or remove partitions from its
bookkeeping.

The
_disk_
argument is optional when a
_partition_
argument is provided.  To force scanning a partition as if it were a whole disk
(for example to list nested subpartitions), use the argument "-" (hyphen-minus).
For example:


* partx --show - /dev/sda3  

This will see sda3 as a whole-disk rather than as a partition.

**partx is not an fdisk program**
– adding and removing partitions does not change the disk, it just
tells the kernel about the presence and numbering of on-disk
partitions.

<a name="options"></a>

# Options


* **-a**,** --add**  
  Add the specified partitions, or read the disk and add all partitions.
* **-b**,** --bytes**  
  Print the SIZE column in bytes rather than in human-readable format.
* **-d**,** --delete**  
  Delete the specified partitions or all partitions.
* **-g**,** --noheadings**  
  Do not print a header line with **--show** or **--raw**.
* **-l**,** --list**  
  List the partitions.  Note that all numbers are in 512-byte sectors.
  This output format is DEPRECATED in favour of
  **--show**.
  Do not use it in newly written scripts.
* **-n**,** --nr **M**:**N  
  Specify the range of partitions.  For backward compatibility also the
  format M**-N** is supported.
  The range may contain negative numbers, for example
  **--nr -1:-1**
  means the last partition, and
  **--nr -2:-1**
  means the last two partitions.  Supported range specifications are:
    * _M_  
      Specifies just one partition (e.g. **--nr 3**).
    * _M_**:**  
      Specifies the lower limit only (e.g. **--nr 2:**).
    * **:**_N_  
      Specifies the upper limit only (e.g. **--nr :4**).
    * _M_**:**_N_  
      Specifies the lower and upper limits (e.g. **--nr 2:4**).
* **-o**,** --output **list  
  Define the output columns to use for
  **--show**,
  **--pairs**
  and
  **--raw**
  output.  If no output arrangement is specified, then a default set is
  used.  Use
  **--help**
  to get
  _list_
  of all supported columns.  This option cannot be combined with the
  **--add**,
  **--delete**,
  **--update**
  or
  **--list**
  options.
* **--output-all**  
  Output all available columns.
* **-P**,** --pairs**  
  List the partitions using the KEY="value" format.
* **-r**,** --raw**  
  List the partitions using the raw output format.
* **-s**,** --show**  
  List the partitions.
  The output columns can be selected and rearranged with the
  **--output** option.
  All numbers (except SIZE) are in 512-byte sectors.
* **-t**,** --type **type  
  Specify the partition table type.
* **--list-types**  
  List supported partition types and exit.
* **-u**,** --update**  
  Update the specified partitions.
* **-S**,** --sector-size **size  
  Overwrite default sector size.
* **-v**,** --verbose**  
  Verbose mode.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="examples"></a>

# Examples


* partx --show /dev/sdb3  
  .TQ
  partx --show --nr 3 /dev/sdb
  .TQ
  partx --show /dev/sdb3 /dev/sdb
  All three commands list partition 3 of /dev/sdb.
* partx --show - /dev/sdb3  
  Lists all subpartitions on /dev/sdb3 (the device is used as
  whole-disk).
* partx -o START -g --nr 5 /dev/sdb  
  Prints the start sector of partition 5 on /dev/sdb without header.
* partx -o SECTORS,SIZE /dev/sda5 /dev/sda  
  Lists the length in sectors and human-readable size of partition 5 on
  /dev/sda.
* partx --add --nr 3:5 /dev/sdd  
  Adds all available partitions from 3 to 5 (inclusive) on /dev/sdd.
* partx -d --nr :-1 /dev/sdd  
  Removes the last partition on /dev/sdd.

<a name="see-also"></a>

# See Also

**addpart**(8),
**delpart**(8),
**fdisk**(8),
**parted**(8),
**partprobe**(8)

<a name="authors"></a>

# Authors

.MT [dave@gnu.org](mailto:dave@gnu.org)
Davidlohr Bueso
.ME  
.MT [kzak@redhat.com](mailto:kzak@redhat.com)
Karel Zak
.ME

The original version was written by
.MT [aeb@cwi.nl](mailto:aeb@cwi.nl)
Andries E. Brouwer
.ME .

<a name="environment"></a>

# Environment


* LIBBLKID_DEBUG=all  
  enables libblkid debug output.

<a name="availability"></a>

# Availability

The partx command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
