# virt-alignment-scan(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-alignment-scan - Check alignment of virtual machine partitions

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-alignment-scan [--options] -d domname   virt-alignment-scan [--options] -a disk.img [-a disk.img ...]   virt-alignment-scan [--options] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
When older operating systems install themselves, the partitioning
tools place partitions at a sector misaligned with the underlying
storage (commonly the first partition starts on sector \f(CW63).
Misaligned partitions can result in an operating system issuing more
I/O than should be necessary.

The virt-alignment-scan tool checks the alignment of partitions in
virtual machines and disk images and warns you if there are alignment
problems.

Currently there is no virt tool for fixing alignment problems.  You
can only reinstall the guest operating system.  The following NetApp
document summarises the problem and possible solutions:
http://media.netapp.com/documents/tr-3747.pdf

<a name="output"></a>

# Output

.IX Header "OUTPUT"
To run this tool on a disk image directly, use the _-a_ option:

.Vb 2
 $ virt-alignment-scan -a winxp.img
 /dev/sda1        32256          512    bad (alignment &lt; 4K)

 $ virt-alignment-scan -a fedora16.img
 /dev/sda1      1048576         1024K   ok
 /dev/sda2      2097152         2048K   ok
 /dev/sda3    526385152         2048K   ok
.Ve

To run the tool on a guest known to libvirt, use the _-d_ option and
possibly the _-c_ option:

.Vb 3
 # virt-alignment-scan -d RHEL5
 /dev/sda1        32256          512    bad (alignment &lt; 4K)
 /dev/sda2    106928640          512    bad (alignment &lt; 4K)

 $ virt-alignment-scan -c qemu:///system -d Win7TwoDisks
 /dev/sda1      1048576         1024K   ok
 /dev/sda2    105906176         1024K   ok
 /dev/sdb1        65536           64K   ok
.Ve

Run virt-alignment-scan without any _-a_ or _-d_ options to scan all
libvirt domains.

.Vb 4
 # virt-alignment-scan
 F16x64:/dev/sda1      1048576         1024K   ok
 F16x64:/dev/sda2      2097152         2048K   ok
 F16x64:/dev/sda3    526385152         2048K   ok
.Ve

The output consists of 4 or more whitespace-separated columns.  Only
the first 4 columns are significant if you want to parse this from a
program.  The columns are:

* col 1  
  .IX Item "col 1"
  The device and partition name (eg. _/dev/sda1_ meaning the
  first partition on the first block device).
  .Sp
  When listing all libvirt domains (no _-a_ or _-d_ option given) this
  column is prefixed by the libvirt name or \s-1UUID\s0 (if _--uuid_ is
  given).  eg: \f(CW`WinXP:/dev/sda1\*(C'
* col 2  
  .IX Item "col 2"
  the start of the partition in bytes
* col 3  
  .IX Item "col 3"
  the alignment in bytes or Kbytes (eg. \f(CW512 or \f(CW`4K\*(C')
* col 4  
  .IX Item "col 4"
  \f(CW`ok\*(C' if the alignment is best for performance, or \f(CW\*(C\`bad\*(C' if the
  alignment can cause performance problems
* cols 5+  
  .IX Item "cols 5+"
  optional free-text explanation.

The exit code from the program changes depending on whether poorly
aligned partitions were found.  See \s-1EXIT STATUS\*(R"\s0 below.

If you just want the exit code with no output, use the _-q_ option.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display brief help.
* **-a** file  
  .IX Item "-a file"
* **--add** file  
  .IX Item "--add file"
  Add _file_ which should be a disk image from a virtual machine.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format=.._ option.
* **-a \s-1URI\s0**  
  .IX Item "-a URI"
* **--add \s-1URI\s0**  
  .IX Item "--add URI"
  Add a remote disk.  See \s-1ADDING REMOTE STORAGE\*(R"\s0 in **guestfish**\|(1).
* **-c** \s-1URI\s0  
  .IX Item "-c URI"
* **--connect** \s-1URI\s0  
  .IX Item "--connect URI"
  If using libvirt, connect to the given _\s-1URI\s0_.  If omitted, then we
  connect to the default libvirt hypervisor.
  .Sp
  If you specify guest block devices directly (_-a_), then libvirt is
  not used at all.
* **-d** guest  
  .IX Item "-d guest"
* **--domain** guest  
  .IX Item "--domain guest"
  Add all the disks from the named libvirt guest.  Domain UUIDs can be
  used instead of names.
* **--format=raw|qcow2|..**  
  .IX Item "--format=raw|qcow2|.."
* **--format**  
  .IX Item "--format"
  The default for the _-a_ option is to auto-detect the format of the
  disk image.  Using this forces the disk format for _-a_ options which
  follow on the command line.  Using _--format_ with no argument
  switches back to auto-detection for subsequent _-a_ options.
  .Sp
  For example:
  .Sp
  .Vb 1
   virt-alignment-scan --format=raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-alignment-scan --format=raw -a disk.img --format -a another.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_ and reverts to
  auto-detection for _another.img_.
  .Sp
  If you have untrusted raw-format guest disk images, you should use
  this option to specify the disk format.  This avoids a possible
  security problem with malicious guests (\s-1CVE-2010-3851\s0).
* **-P** nr_threads  
  .IX Item "-P nr_threads"
  Since libguestfs 1.22, virt-alignment-scan is multithreaded and
  examines guests in parallel.  By default the number of threads to use
  is chosen based on the amount of free memory available at the time
  that virt-alignment-scan is started.  You can force
  virt-alignment-scan to use at most \f(CW`nr\_threads\*(C' by using the _-P_
  option.
  .Sp
  Note that _-P 0_ means to autodetect, and _-P 1_ means to use a
  single thread.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  Don’t produce any output.  Just set the exit code
  (see \s-1EXIT STATUS\*(R"\s0 below).
* **--uuid**  
  .IX Item "--uuid"
  Print UUIDs instead of names.  This is useful for following a guest
  even when the guest is migrated or renamed, or when two guests happen
  to have the same name.
  .Sp
  This option only applies when listing all libvirt domains (when no
  _-a_ or _-d_ options are specified).
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable verbose messages for debugging.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display version number and exit.
* **-x**  
  .IX Item "-x"
  Enable tracing of libguestfs \s-1API\s0 calls.

<a name="recommended-alignment"></a>

# Recommended Alignment

.IX Header "RECOMMENDED ALIGNMENT"
Operating systems older than Windows 2008 and Linux before ca.2010
place the first sector of the first partition at sector 63, with a 512
byte sector size.  This happens because of a historical accident.
Drives have to report a cylinder / head / sector (\s-1CHS\s0) geometry to the
\s-1BIOS.\s0  The geometry is completely meaningless on modern drives, but it
happens that the geometry reported always has 63 sectors per track.
The operating system therefore places the first partition at the start
of the second track\*(R", at sector 63.

When the guest \s-1OS\s0 is virtualized, the host operating system and
hypervisor may prefer accesses aligned to one of:

* ·  
  512 bytes
  .Sp
  if the host \s-1OS\s0 uses local storage directly on hard drive partitions,
  and the hard drive has 512 byte physical sectors.
* ·  
  4 Kbytes
  .Sp
  for local storage on new hard drives with 4Kbyte physical sectors; for
  file-backed storage on filesystems with 4Kbyte block size; or for some
  types of network-attached storage.
* ·  
  64 Kbytes
  .Sp
  for high-end network-attached storage.  This is the optimal block size
  for some NetApp hardware.
* ·  
  1 Mbyte
  .Sp
  see 1 \s-1MB PARTITION ALIGNMENT\*(R"\s0 below.

Partitions which are not aligned correctly to the underlying
storage cause extra I/O.  For example:

.Vb 8
                       sect#63
                       ┌──────────────────────────┬ ─ ─ ─ ─
                       │         guest            │
                       │    filesystem block      │
  ─ ┬──────────────────┴──────┬───────────────────┴─────┬ ─ ─
    │  host block             │  host block             │
    │                         │                         │
  ─ ┴─────────────────────────┴─────────────────────────┴ ─ ─
.Ve

In this example, each time a 4K guest block is read, two blocks on the
host must be accessed (so twice as much I/O is done).  When a 4K guest
block is written, two host blocks must first be read, the old and new
data combined, and the two blocks written back (4x I/O).

<a name="s-1linux-host-block-and-io-sizes0"></a>

### \s-1LINUX HOST BLOCK AND I/O SIZE\s0

.IX Subsection "LINUX HOST BLOCK AND I/O SIZE"
New versions of the Linux kernel expose the physical and logical block
size, and minimum and recommended I/O size.

For a typical consumer hard drive with 512 byte sectors:

.Vb 10
 $ cat /sys/block/sda/queue/hw_sector_size
 512
 $ cat /sys/block/sda/queue/physical_block_size
 512
 $ cat /sys/block/sda/queue/logical_block_size
 512
 $ cat /sys/block/sda/queue/minimum_io_size
 512
 $ cat /sys/block/sda/queue/optimal_io_size
 0
.Ve

For a new consumer hard drive with 4Kbyte sectors:

.Vb 10
 $ cat /sys/block/sda/queue/hw_sector_size
 4096
 $ cat /sys/block/sda/queue/physical_block_size
 4096
 $ cat /sys/block/sda/queue/logical_block_size
 4096
 $ cat /sys/block/sda/queue/minimum_io_size
 4096
 $ cat /sys/block/sda/queue/optimal_io_size
 0
.Ve

For a NetApp \s-1LUN:\s0

.Vb 8
 $ cat /sys/block/sdc/queue/logical_block_size
 512
 $ cat /sys/block/sdc/queue/physical_block_size
 512
 $ cat /sys/block/sdc/queue/minimum_io_size
 4096
 $ cat /sys/block/sdc/queue/optimal_io_size
 65536
.Ve

The NetApp allows 512 byte accesses (but they will be very
inefficient), prefers a minimum 4K I/O size, but the optimal I/O size
is 64K.

For detailed information about what these numbers mean, see
http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/newstorage-iolimits.html

[Thanks to Matt Booth for providing 4K drive data.  Thanks to Mike
Snitzer for providing NetApp data and additional information.]

<a name="1-s-1mb-partition-alignments0"></a>

### 1 \s-1MB PARTITION ALIGNMENT\s0

.IX Subsection "1 MB PARTITION ALIGNMENT"
Microsoft picked 1 \s-1MB\s0 as the default alignment for all partitions
starting with Windows 2008 Server, and Linux has followed this.

Assuming 512 byte sectors in the guest, you will now see the first
partition starting at sector 2048, and subsequent partitions (if any)
will start at a multiple of 2048 sectors.

1 \s-1MB\s0 alignment is compatible with all current alignment requirements
(4K, 64K) and provides room for future growth in physical block sizes.

<a name="s-1setting-alignments0"></a>

### \s-1SETTING ALIGNMENT\s0

.IX Subsection "SETTING ALIGNMENT"
**virt-resize**\|(1) can change the alignment of the partitions of some
guests.  Currently it can fully align all the partitions of all
Windows guests, and it will fix the bootloader where necessary.  For
Linux guests, it can align the second and subsequent partitions, so
the majority of \s-1OS\s0 accesses except at boot will be aligned.

Another way to correct partition alignment problems is to reinstall
your guest operating systems.  If you install operating systems from
templates, ensure these have correct partition alignment too.

For older versions of Windows, the following NetApp document contains
useful information: http://media.netapp.com/documents/tr-3747.pdf

For Red Hat Enterprise Linux ≤ 5, use a Kickstart script that
contains an explicit \f(CW%pre section that creates aligned partitions
using **parted**\|(8).  Do not use the Kickstart \f(CW`part\*(C' command.  The
NetApp document above contains an example.

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns:

* ·  
  0
  .Sp
  successful exit, all partitions are aligned ≥ 64K for best performance
* ·  
  1
  .Sp
  an error scanning the disk image or guest
* ·  
  2
  .Sp
  successful exit, some partitions have alignment &lt; 64K which can result
  in poor performance on high end network storage
* ·  
  3
  .Sp
  successful exit, some partitions have alignment &lt; 4K which can result
  in poor performance on most hypervisors

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfs**\|(3),
**guestfish**\|(1),
**virt-filesystems**\|(1),
**virt-rescue**\|(1),
**virt-resize**\|(1),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2011 Red Hat Inc.

<a name="license"></a>

# License

.IX Header "LICENSE"
This program is free software; you can redistribute it and/or modify it
under the terms of the \s-1GNU\s0 General Public License as published by the
Free Software Foundation; either version 2 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
\s-1WITHOUT ANY WARRANTY\s0; without even the implied warranty of
\s-1MERCHANTABILITY\s0 or \s-1FITNESS FOR A PARTICULAR PURPOSE.\s0  See the \s-1GNU\s0
General Public License for more details.

You should have received a copy of the \s-1GNU\s0 General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, \s-1MA 02110-1301 USA.\s0

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
To get a list of bugs against libguestfs, use this link:
https://bugzilla.redhat.com/buglist.cgi?component=libguestfs&product=Virtualization+Tools

To report a new bug against libguestfs, use this link:
https://bugzilla.redhat.com/enter_bug.cgi?component=libguestfs&product=Virtualization+Tools

When reporting a bug, please supply:

* ·  
  The version of libguestfs.
* ·  
  Where you got libguestfs (eg. which Linux distro, compiled from source, etc)
* ·  
  Describe the bug accurately and give a way to reproduce it.
* ·  
  Run **libguestfs-test-tool**\|(1) and paste the **complete, unedited**
  output into the bug report.
