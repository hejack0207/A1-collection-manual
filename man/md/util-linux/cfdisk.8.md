# cfdisk(8) - display or manipulate a disk partition table

util-linux, March 2014

```
cfdisk [options] [device]
```

<a name="description"></a>

# Description

**cfdisk**
is a curses-based program for partitioning any block device.
The default device is
_/dev/sda_.

Note that
**cfdisk**
provides basic partitioning functionality with a user-friendly interface.
If you need advanced features, use
**fdisk**(8)
instead.

Since version 2.25
**cfdisk**
supports MBR (DOS), GPT, SUN and SGI disk labels, but no longer provides any
functionality for CHS (Cylinder-Head-Sector) addressing.  CHS has
never been important for Linux, and this addressing concept does not make any
sense for new devices.

Since version 2.25
**cfdisk**
also does not provide a 'print' command any more.
This functionality is provided by the utilities
**partx**(8)
and
**lsblk**(8)
in a very comfortable and rich way.

If you want to remove an old partition table from a device, use
**wipefs**(8).


<a name="options"></a>

# Options


* **-h**,** --help**  
  Display help text and exit.
* **-L**,** --color**[**=**_when_]  
  Colorize the output.  The optional argument _when_
  can be **auto**, **never** or **always**.  If the _when_ argument is omitted,
  it defaults to **auto**.  The colors can be disabled, for the current built-in default 
  see **--help** output. See also the COLORS section.
* **-V**,** --version**  
  Display version information and exit.
* **-z**,** --zero**  
  Start with an in-memory zeroed partition table.  This option does not zero the
  partition table on the disk; rather, it simply starts the program without
  reading the existing partition table.  This option allows you to create a new
  partition table from scratch or from an sfdisk-compatible script.
  

<a name="commands"></a>

# Commands

The commands for
**cfdisk**
can be entered by pressing the corresponding key (pressing
_Enter_
after the command is not necessary).  Here is a list of the available
commands:

* **b**  
  Toggle the bootable flag of the current partition.  This allows you to
  select which primary partition is bootable on the drive.  This command may not
  be available for all partition label types.
* **d**  
  Delete the current partition.  This will convert the current partition
  into free space and merge it with any free space immediately
  surrounding the current partition.  A partition already marked as free
  space or marked as unusable cannot be deleted.
* **h**  
  Show the help screen.
* **n**  
  Create a new partition from free space.
  **cfdisk**
  then prompts you for the size of the partition you want to create.
  The default size is equal to the entire available free space at the current
  position.
  
  The size may be followed by a multiplicative suffix: KiB (=1024),
  MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
  (the "iB" is optional, e.g. "K" has the same meaning as "KiB").
* **q**  
  Quit the program.  This will exit the program without writing any data to
  the disk.
* **s**  
  Sort the partitions in ascending start-sector order.  When deleting and
  adding partitions, it is likely that the numbering of the partitions will
  no longer match their order on the disk.  This command restores that match.
* **t**  
  Change the partition type.  By default, new partitions are created as
  _Linux_
  partitions.
* **u**  
  Dump the current in-memory partition table to an sfdisk-compatible script file.

The script files are compatible between **cfdisk**, **fdisk**, **sfdisk**
and other libfdisk applications.  For more details see
**sfdisk**(8).

It is also possible to load an sfdisk-script into **cfdisk** if there is
no partition table on the device or when you start **cfdisk** with the
**--zero** command-line option.

* **W**  
  Write the partition table to disk (you must enter an uppercase W).  Since
  this might destroy data on the disk, you must either confirm or deny
  the write by entering \`yes' or \`no'.  If you enter \`yes',
  **cfdisk**
  will write the partition table to disk and then tell the kernel to re-read the
  partition table from the disk.
  
  The re-reading of the partition table does not always work.  In such a
  case you need to inform the kernel about any new partitions by using
  **partprobe**(8)
  or
  **partx**(8),
  or by rebooting the system.
* **x**  
  Toggle extra information about a partition.
* _Up Arrow_,_ Down Arrow_  
  Move the cursor to the previous or next partition.  If there are more
  partitions than can be displayed on a screen, you can display the next
  (previous) set of partitions by moving down (up) at the last (first)
  partition displayed on the screen.
* _Left Arrow_,_ Right Arrow_  
  Select the preceding or the next menu item.  Hitting _Enter_ will
  execute the currently selected item.
  

All commands can be entered with either uppercase or lowercase
letters (except for
**W**rite).
When in a submenu or at a prompt, you can hit the
_Esc_
key to return to the main menu.


<a name="colors"></a>

# Colors

Implicit coloring can be disabled by creating the empty file
_/etc/terminal-colors.d/cfdisk.disable_.

See
**terminal-colors.d**(5)
for more details about colorization configuration.

**cfdisk**
does not support color customization with a color-scheme file.


<a name="environment"></a>

# Environment


* CFDISK_DEBUG=all  
  enables cfdisk debug output.
* LIBFDISK_DEBUG=all  
  enables libfdisk debug output.
* LIBBLKID_DEBUG=all  
  enables libblkid debug output.
* LIBSMARTCOLS_DEBUG=all  
  enables libsmartcols debug output.
* LIBSMARTCOLS_DEBUG_PADDING=on  
  use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
  

<a name="see-also"></a>

# See Also

**fdisk**(8),
**parted**(8),
**partprobe**(8),
**partx**(8),
**sfdisk**(8)

<a name="author"></a>

# Author

Karel Zak &lt;[kzak@redhat.com](mailto:kzak@redhat.com)&gt;

The current cfdisk implementation is based on the original cfdisk
from Kevin E. Martin ([martin@cs.unc](mailto:martin@cs.unc).edu).


<a name="availability"></a>

# Availability

The cfdisk command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
