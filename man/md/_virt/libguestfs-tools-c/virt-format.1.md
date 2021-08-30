# virt-format(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-format - Erase and make a blank disk

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-format [--options] -a disk.img [-a disk.img ...] .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
Using \f(CW`virt-format\*(C'
on live virtual machines, or concurrently with other
disk editing tools, can be dangerous, potentially causing disk
corruption.  The virtual machine must be shut down before you use this
command, and disk images must not be edited concurrently.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-format takes an existing disk file (or it can be a host
partition, \s-1LV\s0 etc), **erases all data on it**, and formats it as a
blank disk.  It can optionally create partition tables, empty
filesystems, logical volumes and more.

To create a disk containing data, you may be better to use
**virt-make-fs**\|(1).  If you are creating a blank disk to use in
**guestfish**\|(1), you should instead use the guestfish _-N_ option.

Normal usage would be something like this:

.Vb 1
 virt-format -a disk.qcow
.Ve

or this:

.Vb 1
 virt-format -a /dev/VG/LV
.Ve

_disk.qcow_ or _/dev/VG/LV_ must exist already.  Any data on these
disks will be erased by these commands.  These commands will create a
single empty partition covering the whole disk, with no filesystem
inside it.

Additional parameters can be used to control the creation of
partitions, filesystems, etc.  The most commonly used options are:

* **--filesystem=[ext3|ntfs|vfat|...]**  
  .IX Item "--filesystem=[ext3|ntfs|vfat|...]"
  Create an empty filesystem (\f(CW`ext3\*(C', \f(CW\*(C\`ntfs\*(C' etc) inside the partition.
* **--lvm[=/dev/VG/LV]**  
  .IX Item "--lvm[=/dev/VG/LV]"
  Create a Linux \s-1LVM2\s0 logical volume on the disk.  When used with
  _--filesystem_, the filesystem is created inside the \s-1LV.\s0

For more information about these and other options, see
\s-1OPTIONS\*(R"\s0 below.

The format of the disk is normally auto-detected, but you can also
force it by using the _--format_ option (q.v.).  In situations where
you do not trust the existing content of the disk, then it is
advisable to use this option to avoid possible exploits.

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
  Add _file_, a disk image, host partition, \s-1LV,\s0 external \s-1USB\s0 disk, etc.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format=.._ option.
  .Sp
  **Any existing data on the disk is erased.**
* **-a** \s-1URI\s0  
  .IX Item "-a URI"
* **--add** \s-1URI\s0  
  .IX Item "--add URI"
  Add a remote disk.  See \s-1ADDING REMOTE STORAGE\*(R"\s0 in **guestfish**\|(1).
* **--filesystem=ext3|ntfs|vfat|...**  
  .IX Item "--filesystem=ext3|ntfs|vfat|..."
  Create an empty filesystem of the specified type.  Many filesystem
  types are supported by libguestfs.
* **--filesystem=none**  
  .IX Item "--filesystem=none"
  Create no filesystem.  This is the default.
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
   virt-format --format=raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-format --format=raw -a disk.img --format -a another.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_ and reverts to
  auto-detection for _another.img_.
  .Sp
  If you have untrusted raw-format guest disk images, you should use
  this option to specify the disk format.  This avoids a possible
  security problem with malicious guests (\s-1CVE-2010-3851\s0).
* **--label=**\s-1LABEL\s0  
  .IX Item "--label=LABEL"
  Set the filesystem label.
* **--lvm=/dev/\f(BI\s-1VG\s0/\f(BI\s-1LV\s0**  
  .IX Item "--lvm=/dev/VG/LV"
  Create a Linux \s-1LVM2\s0 logical volume called _/dev/\s-1VG\s0/\s-1LV\s0_.  You
  can change the name of the volume group and logical volume.
* **--lvm**  
  .IX Item "--lvm"
  Create a Linux \s-1LVM2\s0 logical volume with the default name
  (_/dev/VG/LV_).
* **--lvm=none**  
  .IX Item "--lvm=none"
  Create no logical volume.  This is the default.
* **--partition**  
  .IX Item "--partition"
  Create either an \s-1MBR\s0 or \s-1GPT\s0 partition covering the whole disk.  \s-1MBR\s0 is
  chosen if the disk size is &lt; 2 \s-1TB, GPT\s0 if ≥ 2 \s-1TB.\s0
  .Sp
  This is the default.
* **--partition=gpt**  
  .IX Item "--partition=gpt"
  Create a \s-1GPT\s0 partition.
* **--partition=mbr**  
  .IX Item "--partition=mbr"
  Create an \s-1MBR\s0 partition.
* **--partition=none**  
  .IX Item "--partition=none"
  Create no partition table.  Note that Windows may not be able to see
  these disks.
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
* **--wipe**  
  .IX Item "--wipe"
  Normally virt-format does not wipe data from the disk (because that
  takes a long time).  Thus if there is data on the disk, it is only
  hidden and partially overwritten by virt-format, and it might be
  recovered by disk editing tools.
  .Sp
  If you use this option, virt-format writes zeroes over the whole disk
  so that previous data is not recoverable.
* **-x**  
  .IX Item "-x"
  Enable tracing of libguestfs \s-1API\s0 calls.

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns \f(CW0 on success, or \f(CW1 on failure.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfs**\|(3),
**guestfish**\|(1),
**virt-filesystems**\|(1),
**virt-make-fs**\|(1),
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
Copyright (C) 2012 Red Hat Inc.

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
