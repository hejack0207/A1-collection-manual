# virt-make-fs(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-make-fs - Make a filesystem from a tar archive or files

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-make-fs [--options] input.tar output.img   virt-make-fs [--options] input.tar.gz output.img   virt-make-fs [--options] directory output.img .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-make-fs is a command line tool for creating a filesystem from a
tar archive or some files in a directory.  It is similar to tools like
**mkisofs**\|(1), **genisoimage**\|(1) and **mksquashfs**\|(1).  Unlike those
tools, it can create common filesystem types like ext2/3 or \s-1NTFS,\s0
which can be useful if you want to attach these filesystems to
existing virtual machines (eg. to import large amounts of read-only
data to a \s-1VM\s0).

To create blank disks, use **virt-format**\|(1).  To create complex
layouts, use **guestfish**\|(1).

Basic usage is:

.Vb 1
 virt-make-fs input output.img
.Ve

where \f(CW`input\*(C' is either a directory containing files that you want to
add, or a tar archive (either uncompressed tar or gzip-compressed
tar); and _output.img_ is a disk image.  The input type is detected
automatically.  The output disk image defaults to a raw ext2 sparse
image unless you specify extra flags (see \s-1OPTIONS\*(R"\s0 below).

<a name="s-1filesystem-types0"></a>

### \s-1FILESYSTEM TYPE\s0

.IX Subsection "FILESYSTEM TYPE"
The default filesystem type is \f(CW`ext2\*(C'.  Just about any filesystem
type that libguestfs supports can be used (but _not_ read-only
formats like \s-1ISO9660\s0).  Here are some of the more common choices:

* _ext3_  
  .IX Item "ext3"
  Note that ext3 filesystems contain a journal, typically 1-32 \s-1MB\s0 in size.
  If you are not going to use the filesystem in a way that requires the
  journal, then this is just wasted overhead.
* _ntfs_ or _vfat_  
  .IX Item "ntfs or vfat"
  Useful if exporting data to a Windows guest.
* _minix_  
  .IX Item "minix"
  Lower overhead than \f(CW`ext2\*(C', but certain limitations on filename
  length and total filesystem size.

_\s-1EXAMPLE\s0_
.IX Subsection "EXAMPLE"

.Vb 1
 virt-make-fs --type=minix input minixfs.img
.Ve

<a name="s-1to-partition-or-not-to-partitions0"></a>

### \s-1TO PARTITION OR NOT TO PARTITION\s0

.IX Subsection "TO PARTITION OR NOT TO PARTITION"
Optionally virt-make-fs can add a partition table to the output disk.

Adding a partition can make the disk image more compatible with
certain virtualized operating systems which don't expect to see a
filesystem directly located on a block device (Linux doesn't care and
will happily handle both types).

On the other hand, if you have a partition table then the output image
is no longer a straight filesystem.  For example you cannot run
**fsck**\|(8) directly on a partitioned disk image.  (However libguestfs
tools such as **guestfish**\|(1) and **virt-resize**\|(1) can still be
used).

_\s-1EXAMPLE\s0_
.IX Subsection "EXAMPLE"

Add an \s-1MBR\s0 partition:

.Vb 1
 virt-make-fs --partition -- input disk.img
.Ve

If the output disk image could be terabyte-sized or larger, it's
better to use an EFI/GPT-compatible partition table:

.Vb 1
 virt-make-fs --partition=gpt --size=+4T --format=qcow2 input disk.img
.Ve

<a name="s-1extra-spaces0"></a>

### \s-1EXTRA SPACE\s0

.IX Subsection "EXTRA SPACE"
Unlike formats such as tar and squashfs, a filesystem does not just
fit the files that it contains, but might have extra space.
Depending on how you are going to use the output, you might think this
extra space is wasted and want to minimize it, or you might want to
leave space so that more files can be added later.  Virt-make-fs
defaults to minimizing the extra space, but you can use the _--size_
flag to leave space in the filesystem if you want it.

An alternative way to leave extra space but not make the output image
any bigger is to use an alternative disk image format (instead of the
default raw\*(R" format).  Using _--format=qcow2_ will use the native
qemu/KVM qcow2 image format (check your hypervisor supports this
before using it).  This allows you to choose a large _--size_ but the
extra space won't actually be allocated in the image until you try to
store something in it.

Don’t forget that you can also use local commands including
**resize2fs**\|(8) and **virt-resize**\|(1) to resize existing filesystems,
or rerun virt-make-fs to build another image from scratch.

_\s-1EXAMPLE\s0_
.IX Subsection "EXAMPLE"

.Vb 1
 virt-make-fs --format=qcow2 --size=+200M input output.img
.Ve

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display brief help.
* **--floppy**  
  .IX Item "--floppy"
  Create a virtual floppy disk.
  .Sp
  Currently this preselects the size (1440K), partition type (\s-1MBR\s0) and
  filesystem type (\s-1VFAT\s0).  In future it may also choose the geometry.
* **--size=**N  
  .IX Item "--size=N"
* **--size=+**N  
  .IX Item "--size=+N"
* **-s** N  
  .IX Item "-s N"
* **-s** **+**N  
  .IX Item "-s +N"
  Use the _--size_ (or _-s_) option to choose the size of the output
  image.
  .Sp
  If this option is _not_ given, then the output image will be just
  large enough to contain all the files, with not much wasted space.
  .Sp
  To choose a fixed size output disk, specify an absolute number
  followed by b/K/M/G/T/P/E to mean bytes, Kilobytes, Megabytes,
  Gigabytes, Terabytes, Petabytes or Exabytes.  This must be large
  enough to contain all the input files, else you will get an error.
  .Sp
  To leave extra space, specify \f(CW`+\*(C' (plus sign) and a number followed
  by b/K/M/G/T/P/E to mean bytes, Kilobytes, Megabytes, Gigabytes,
  Terabytes, Petabytes or Exabytes.  For example: _--size=+200M_ means
  enough space for the input files, and (approximately) an extra 200 \s-1MB\s0
  free space.
  .Sp
  Note that virt-make-fs estimates free space, and therefore will not
  produce filesystems containing precisely the free space requested.
  (It is much more expensive and time-consuming to produce a filesystem
  which has precisely the desired free space).
* **--format=**\s-1FMT\s0  
  .IX Item "--format=FMT"
* **-F** \s-1FMT\s0  
  .IX Item "-F FMT"
  Choose the output disk image format.
  .Sp
  The default is \f(CW`raw\*(C' (raw sparse disk image).
* **--type=**\s-1FS\s0  
  .IX Item "--type=FS"
* **-t** \s-1FS\s0  
  .IX Item "-t FS"
  Choose the output filesystem type.
  .Sp
  The default is \f(CW`ext2\*(C'.
  .Sp
  Any filesystem which is supported read-write by libguestfs can be used
  here.
* **--label=**\s-1LABEL\s0  
  .IX Item "--label=LABEL"
  Set the filesystem label.
* **--partition**  
  .IX Item "--partition"
* **--partition=**\s-1PARTTYPE\s0  
  .IX Item "--partition=PARTTYPE"
  If specified, this flag adds an \s-1MBR\s0 partition table to the output disk
  image.
  .Sp
  You can change the partition table type, eg. _--partition=gpt_ for
  large disks.
  .Sp
  For \s-1MBR,\s0 virt-make-fs sets the partition type byte automatically.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable debugging information.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display version number and exit.
* **-x**  
  .IX Item "-x"
  Enable libguestfs trace.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfish**\|(1),
**virt-format**\|(1),
**virt-resize**\|(1),
**virt-tar-in**\|(1),
**mkisofs**\|(1),
**genisoimage**\|(1),
**mksquashfs**\|(1),
**mke2fs**\|(8),
**resize2fs**\|(8),
**guestfs**\|(3),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2010-2019 Red Hat Inc.

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
