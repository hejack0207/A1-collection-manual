# swapon(8) - enable/disable devices and files for paging and swapping

util-linux, October 2014

```
swapon [options] [specialfile...]
swapoff [-va] [specialfile...]
```

<a name="description"></a>

# Description

**swapon**
is used to specify devices on which paging and swapping are to take place.

The device or file used is given by the
_specialfile_
parameter.  It may be of the form
**-L**_ label_
or
**-U**_ uuid_
to indicate a device by label or uuid.

Calls to
**swapon**
normally occur in the system boot scripts making all swap devices available, so
that the paging and swapping activity is interleaved across several devices and
files.

**swapoff**
disables swapping on the specified devices and files.
When the
**-a**
flag is given, swapping is disabled on all known swap devices and files
(as found in
_/proc/swaps_
or
_/etc/fstab_).


<a name="options"></a>

# Options


* **-a**,** --all**  
  All devices marked as \`\`swap'' in
  _/etc/fstab_
  are made available, except for those with the \`\`noauto'' option.
  Devices that are already being used as swap are silently skipped.
* **-d**,** --discard**[**=_policy_]**  
  Enable swap discards, if the swap backing device supports the discard or
  trim operation.  This may improve performance on some Solid State Devices,
  but often it does not.  The option allows one to select between two
  available swap discard policies:
  **--discard=once**
  to perform a single-time discard operation for the whole swap area at swapon;
  or
  **--discard=pages**
  to asynchronously discard freed swap pages before they are available for reuse.
  If no policy is selected, the default behavior is to enable both discard types.
  The
  _/etc/fstab_
  mount options
  **discard**,
  **discard=once**,
  or
  **discard=pages**
  may also be used to enable discard flags.
* **-e**,** --ifexists**  
  Silently skip devices that do not exist.
  The
  _/etc/fstab_
  mount option
  **nofail**
  may also be used to skip non-existing device.
  
* **-f**,** --fixpgsz**  
  Reinitialize (exec mkswap) the swap space if its page size does not
  match that of the current running kernel.
  **mkswap**(2)
  initializes the whole device and does not check for bad blocks.
* **-h**,** --help**  
  Display help text and exit.
* **-L**_ label_  
  Use the partition that has the specified
  _label_.
  (For this, access to
  _/proc/partitions_
  is needed.)
* **-o**,** --options **_opts_  
  Specify swap options by an fstab-compatible comma-separated string.
  For example:

**swapon -o pri=1,discard=pages,nofail /dev/sda2**

The _opts_ string is evaluated last and overrides all other
command line options.

* **-p**,** --priority **_priority_  
  Specify the priority of the swap device.
  _priority_
  is a value between -1 and 32767.  Higher numbers indicate
  higher priority.  See
  **swapon**(2)
  for a full description of swap priorities.  Add
  **pri=**_value_
  to the option field of
  _/etc/fstab_
  for use with
  **swapon -a**.
  When no priority is defined, it defaults to -1.
* **-s**,** --summary**  
  Display swap usage summary by device.  Equivalent to "cat /proc/swaps".
  This output format is DEPRECATED in favour
  of **--show** that provides better control on output data.
* **--show**[**=_column_**...]  
  Display a definable table of swap areas.  See the
  **--help**
  output for a list of available columns.
* **--output-all**  
  Output all available columns.
* **--noheadings**  
  Do not print headings when displaying
  **--show**
  output.
* **--raw**  
  Display
  **--show**
  output without aligning table columns.
* **--bytes**  
  Display swap size in bytes in
  **--show**
  output instead of in user-friendly units.
* **-U**_ uuid_  
  Use the partition that has the specified
  _uuid_.
* **-v**,** --verbose**  
  Be verbose.
* **-V**,** --version**  
  Display version information and exit.

<a name="notes"></a>

# Notes

You should not use **swapon** on a file with holes.
This can be seen in the system log as

**swapon: swapfile has holes.**

The swap file implementation in the kernel expects to be able to write to the
file directly, without the assistance of the filesystem.  This is a problem on
preallocated files (e.g.
**fallocate**(1))
on filesystems like **XFS** or **ext4**, and on copy-on-write
filesystems like **btrfs**.

It is recommended to use
**dd**(1)
and
_/dev/zero_
to avoid holes on XFS and ext4.

**swapon**
may not work correctly when using a swap file with some versions of
**btrfs**.  This is due to btrfs being a copy-on-write filesystem: the
file location may not be static and corruption can result.  Btrfs actively
disallows the use of swap files on its filesystems by refusing to map the file.

One possible workaround is to map the swap
file to a loopback device.  This will allow the filesystem to determine the
mapping properly but may come with a performance impact.

Swap over **NFS** may not work.

**swapon**
automatically detects and rewrites a swap space signature with old software
suspend data (e.g. S1SUSPEND, S2SUSPEND, ...). The problem is that if we don't
do it, then we get data corruption the next time an attempt at unsuspending is
made.


<a name="environment"></a>

# Environment


* LIBMOUNT_DEBUG=all  
  enables libmount debug output.
* LIBBLKID_DEBUG=all  
  enables libblkid debug output.
  

<a name="see-also"></a>

# See Also

**swapoff**(2),
**swapon**(2),
**fstab**(5),
**init**(8),
**mkswap**(8),
**mount**(8),
**rc**(8)

<a name="files"></a>

# Files
  
_/dev/sd??_
standard paging devices  
_/etc/fstab_
ascii filesystem description table

<a name="history"></a>

# History

The
**swapon**
command appeared in 4.0BSD.

<a name="availability"></a>

# Availability

The swapon command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
