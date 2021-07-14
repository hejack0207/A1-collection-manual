# zramctl(8) - set up and control zram devices

util-linux, July 2014

```
Get info: 
 .in +5 zramctl [options] 
 .in -5 Reset zram: 
 .in +5 "zramctl -r" zramdev... 
 .in -5 Print name of first unused zram device: 
 .in +5 "zramctl -f" 
 .in -5 Set up a zram device: 
 .in +5 zramctl [-f | zramdev] [-s size] [-t number] [-a algorithm] 
 .in -5
```

<a name="description"></a>

# Description

**zramctl**
is used to quickly set up zram device parameters, to reset zram devices, and to
query the status of used zram devices.

If no option is given, all non-zero size zram devices are shown.

Note that _zramdev_ node specified on command line has to already exist. The command
**zramctl**
creates a new /dev/zram&lt;N&gt; nodes only when **--find** option specified. It's possible
(and common) that after system boot /dev/zram&lt;N&gt; nodes are not created yet.

<a name="options"></a>

# Options


* **-a**,** --algorithm lzo**|**lz4**|**lz4hc**|**deflate**|**842**  
  Set the compression algorithm to be used for compressing data in the zram device.
* **-f**,** --find**  
  Find the first unused zram device.  If a **--size** argument is present, then
  initialize the device.
* **-n**,** --noheadings**  
  Do not print a header line in status output.
* **-o**,** --output **list  
  Define the status output columns to be used.  If no output arrangement is
  specified, then a default set is used.
  Use **--help** to get a list of all supported columns.
* **--output-all**  
  Output all available columns.
* **--raw**  
  Use the raw format for status output.
* **-r**,** --reset**  
  Reset the options of the specified zram device(s).  Zram device settings
  can be changed only after a reset.
* **-s**,** --size **size  
  Create a zram device of the specified _size_.
  Zram devices are aligned to memory pages; when the requested _size_ is
  not a multiple of the page size, it will be rounded up to the next multiple.
  When not otherwise specified, the unit of the _size_ parameter is bytes.
* The _size_ argument may be followed by the multiplicative suffixes KiB (=1024),
  MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB"
  is optional, e.g., "K" has the same meaning as "KiB") or the suffixes
  KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
* **-t**,** --streams **number  
  Set the maximum number of compression streams that can be used for the device.
  The default is one stream.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.
  

<a name="return-value"></a>

# Return Value

**zramctl**
returns 0 on success, nonzero on failure.


<a name="files"></a>

# Files


* _/dev/zram[0..N]_  
  zram block devices
  

<a name="example"></a>

# Example

The following commands set up a zram device with a size of one gigabyte
and use it as swap device.
    .IP
    # zramctl --find --size 1024M
    /dev/zram0
    # mkswap /dev/zram0
    # swapon /dev/zram0
     ...
    # swapoff /dev/zram0
    # zramctl --reset /dev/zram0

<a name="see-also"></a>

# See Also

[Linux kernel documentation](http://git.​kernel.​org​/cgit​/linux​/kernel​/git​/torvalds​/linux.git​/tree​/Documentation​/blockdev​/zram.txt).

<a name="authors"></a>

# Authors

    Timofey Titovets <nefelim4ag@gmail.com>
    Karel Zak <kzak@redhat.com>

<a name="availability"></a>

# Availability

The zramctl command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
