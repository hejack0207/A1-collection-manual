# virt-filesystems(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-filesystems - List filesystems, partitions, block devices, LVM in a virtual machine or disk image

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-filesystems [--options] -d domname   virt-filesystems [--options] -a disk.img [-a disk.img ...] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This tool allows you to discover filesystems, partitions, logical
volumes, and their sizes in a disk image or virtual machine.  It is a
replacement for **virt-list-filesystems**\|(1) and
**virt-list-partitions**\|(1).

One use for this tool is from shell scripts to iterate over all
filesystems from a disk image:

.Vb 3
 for fs in $(virt-filesystems -a disk.img); do
   # ...
 done
.Ve

Another use is to list partitions before using another tool to modify
those partitions (such as **virt-resize**\|(1)).  If you are curious
about what an unknown disk image contains, use this tool along with
**virt-inspector**\|(1).

Various command line options control what this program displays.  You
need to give either _-a_ or _-d_ options to specify the disk image
or libvirt guest respectively.  If you just specify that then the
program shows filesystems found, one per line, like this:

.Vb 3
 $ virt-filesystems -a disk.img
 /dev/sda1
 /dev/vg_guest/lv_root
.Ve

If you add _-l_ or _--long_ then the output includes extra
information:

.Vb 4
 $ virt-filesystems -a disk.img -l
 Name                   Type         VFS   Label  Size
 /dev/sda1              filesystem   ext4  boot   524288000
 /dev/vg_guest/lv_root  filesystem   ext4  root   10212081664
.Ve

If you add _--extra_ then non-mountable (swap, unknown) filesystems
are shown as well:

.Vb 5
 $ virt-filesystems -a disk.img --extra
 /dev/sda1
 /dev/vg_guest/lv_root
 /dev/vg_guest/lv_swap
 /dev/vg_guest/lv_data
.Ve

If you add _--partitions_ then partitions are shown instead of filesystems:

.Vb 3
 $ virt-filesystems -a disk.img --partitions
 /dev/sda1
 /dev/sda2
.Ve

Similarly you can use _--logical-volumes_, _--volume-groups_,
_--physical-volumes_, _--block-devices_ to list those items.

You can use these options in combination as well (if you want a
combination including filesystems, you have to add _--filesystems_).
Notice that some items fall into several categories (eg. _/dev/sda1_
might be both a partition and a filesystem).  These items are listed
several times.  To get a list which includes absolutely everything
that virt-filesystems knows about, use the _--all_ option.

UUIDs (because they are quite long) are not shown by default.  Add the
_--uuid_ option to display device and filesystem UUIDs in the long
output.

_--all --long --uuid_ is a useful combination to display all possible
information about everything.

.Vb 7
 $ virt-filesystems -a win.img --all --long --uuid -h
 Name      Type       VFS  Label           Size Parent   UUID
 /dev/sda1 filesystem ntfs System Reserved 100M -        F81C92571C92112C
 /dev/sda2 filesystem ntfs -               20G  -        F2E8996AE8992E3B
 /dev/sda1 partition  -    -               100M /dev/sda -
 /dev/sda2 partition  -    -               20G  /dev/sda -
 /dev/sda  device     -    -               20G  -        -
.Ve

For machine-readable output, use _--csv_ to get Comma-Separated Values.

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
  Add _file_ which should be a disk image from a virtual machine.  If
  the virtual machine has multiple block devices, you must supply all of
  them with separate _-a_ options.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format=.._ option.
* **-a \s-1URI\s0**  
  .IX Item "-a URI"
* **--add \s-1URI\s0**  
  .IX Item "--add URI"
  Add a remote disk.  See \s-1ADDING REMOTE STORAGE\*(R"\s0 in **guestfish**\|(1).
* **--all**  
  .IX Item "--all"
  Display everything.  This is currently the same as specifying these
  options: _--filesystems_, _--extra_, _--partitions_,
  _--block-devices_, _--logical-volumes_, _--volume-groups_,
  _--physical-volumes_.  (More may be added to this list in future).
  .Sp
  See also _--long_.
* **--blkdevs**  
  .IX Item "--blkdevs"
* **--block-devices**  
  .IX Item "--block-devices"
  Display block devices.
* **-c** \s-1URI\s0  
  .IX Item "-c URI"
* **--connect** \s-1URI\s0  
  .IX Item "--connect URI"
  If using libvirt, connect to the given _\s-1URI\s0_.  If omitted, then we
  connect to the default libvirt hypervisor.
  .Sp
  If you specify guest block devices directly (_-a_), then libvirt is
  not used at all.
* **--csv**  
  .IX Item "--csv"
  Write out the results in \s-1CSV\s0 format (comma-separated values).  This
  format can be imported easily into databases and spreadsheets, but
  read \s-1NOTE ABOUT CSV FORMAT\*(R"\s0 below.
* **-d** guest  
  .IX Item "-d guest"
* **--domain** guest  
  .IX Item "--domain guest"
  Add all the disks from the named libvirt guest.  Domain UUIDs can be
  used instead of names.
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, virt-filesystems normally
  turns echoing off so you cannot see what you are typing.  If you are
  not worried about Tempest attacks and there is no one else in the room
  you can specify this flag to see what you are typing.
* **--extra**  
  .IX Item "--extra"
  This causes filesystems that are not ordinary, mountable filesystems
  to be displayed.  This category includes swapspace, and filesystems
  that are empty or contain unknown data.
  .Sp
  This option implies _--filesystems_.
* **--filesystems**  
  .IX Item "--filesystems"
  Display mountable filesystems.  If no display option was selected then
  this option is implied.
  .Sp
  With _--extra_, non-mountable filesystems are shown too.
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
   virt-filesystems --format=raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-filesystems --format=raw -a disk.img --format -a another.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_ and reverts to
  auto-detection for _another.img_.
  .Sp
  If you have untrusted raw-format guest disk images, you should use
  this option to specify the disk format.  This avoids a possible
  security problem with malicious guests (\s-1CVE-2010-3851\s0).
* **-h**  
  .IX Item "-h"
* **--human-readable**  
  .IX Item "--human-readable"
  In _--long_ mode, display sizes in human-readable format.
* **--keys-from-stdin**  
  .IX Item "--keys-from-stdin"
  Read key or passphrase parameters from stdin.  The default is
  to try to read passphrases from the user by opening _/dev/tty_.
* **-l**  
  .IX Item "-l"
* **--long**  
  .IX Item "--long"
  Display extra columns of data (long format\*(R").
  .Sp
  A title row is added unless you also specify _--no-title_.
  .Sp
  The extra columns displayed depend on what output you select, and the
  ordering of columns may change in future versions.  Use the title row,
  _--csv_ output and/or **csvtool**\|(1) to match columns to data in
  external programs.
  .Sp
  Use _-h_ if you want sizes to be displayed in human-readable format.
  The default is to show raw numbers of _bytes_.
  .Sp
  Use _--uuid_ to display UUIDs too.
* **--lvs**  
  .IX Item "--lvs"
* **--logvols**  
  .IX Item "--logvols"
* **--logical-volumes**  
  .IX Item "--logical-volumes"
  Display \s-1LVM\s0 logical volumes.  In this mode, these are displayed
  irrespective of whether the LVs contain filesystems.
* **--no-title**  
  .IX Item "--no-title"
  In _--long_ mode, don’t add a title row.
  .Sp
  Note that the order of the columns is not fixed, and may change in
  future versions of virt-filesystems, so using this option may give you
  unexpected surprises.
* **--parts**  
  .IX Item "--parts"
* **--partitions**  
  .IX Item "--partitions"
  Display partitions.  In this mode, these are displayed
  irrespective of whether the partitions contain filesystems.
* **--pvs**  
  .IX Item "--pvs"
* **--physvols**  
  .IX Item "--physvols"
* **--physical-volumes**  
  .IX Item "--physical-volumes"
  Display \s-1LVM\s0 physical volumes.
* **--uuid**  
  .IX Item "--uuid"
* **--uuids**  
  .IX Item "--uuids"
  In _--long_ mode, display UUIDs as well.
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
* **--vgs**  
  .IX Item "--vgs"
* **--volgroups**  
  .IX Item "--volgroups"
* **--volume-groups**  
  .IX Item "--volume-groups"
  Display \s-1LVM\s0 volume groups.
* **-x**  
  .IX Item "-x"
  Enable tracing of libguestfs \s-1API\s0 calls.

<a name="columns"></a>

# Columns

.IX Header "COLUMNS"
Note that columns in the output are subject to reordering and change
in future versions of this tool.

* **Name**  
  .IX Item "Name"
  The filesystem, partition, block device or \s-1LVM\s0 name.
  .Sp
  For device and partition names these are displayed as canonical
  libguestfs names, so that for example _/dev/sda2_ is the second
  partition on the first device.
  .Sp
  If the _--long_ option is **not** specified, then only the name column
  is shown in the output.
* **Type**  
  .IX Item "Type"
  The object type, for example \f(CW`filesystem\*(C', \f(CW\*(C\`lv\*(C', \f(CW\*(C\`device\*(C' etc.
* **\s-1VFS\s0**  
  .IX Item "VFS"
  If there is a filesystem, then this column displays the filesystem
  type if one could be detected, eg. \f(CW`ext4\*(C'.
* **Label**  
  .IX Item "Label"
  If the object has a label (used for identifying and mounting
  filesystems) then this column contains the label.
* **\s-1MBR\s0**  
  .IX Item "MBR"
  The partition type byte, displayed as a two digit hexadecimal number.
  A comprehensive list of partition types can be found here:
  http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
  .Sp
  This is only applicable for \s-1DOS\s0 (\s-1MBR\s0) partitions.
* **Size**  
  .IX Item "Size"
  The size of the object in bytes.  If the _--human_ option is used
  then the size is displayed in a human-readable form.
* **Parent**  
  .IX Item "Parent"
  The parent column records the parent relationship between objects.
  .Sp
  For example, if the object is a partition, then this column contains
  the name of the containing device.  If the object is a logical volume,
  then this column is the name of the volume group.
  .Sp
  If there is more than one parent, then this column is (internal to the
  column) a comma-separated list, eg. \f(CW`/dev/sda,/dev/sdb\*(C'.
* **\s-1UUID\s0**  
  .IX Item "UUID"
  If the object has a \s-1UUID\s0 (used for identifying and mounting
  filesystems and block devices) then this column contains the \s-1UUID\s0 as a
  string.
  .Sp
  The \s-1UUID\s0 is only displayed if the _--uuid_ option is given.

<a name="note-about-csv-format"></a>

# Note About Csv Format

.IX Header "NOTE ABOUT CSV FORMAT"
Comma-separated values (\s-1CSV\s0) is a deceptive format.  It _seems_ like
it should be easy to parse, but it is definitely not easy to parse.

Myth: Just split fields at commas.  Reality: This does _not_ work
reliably.  This example has two columns:

.Vb 1
 "foo,bar",baz
.Ve

Myth: Read the file one line at a time.  Reality: This does _not_
work reliably.  This example has one row:

.Vb 2
 "foo
 bar",baz
.Ve

For shell scripts, use \f(CW`csvtool\*(C' (https://github.com/Chris00/ocaml-csv
also packaged in major Linux distributions).

For other languages, use a \s-1CSV\s0 processing library (eg. \f(CW`Text::CSV\*(C'
for Perl or Python’s built-in csv library).

Most spreadsheets and databases can import \s-1CSV\s0 directly.

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 if successful, or non-zero if there was an
error.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfs**\|(3),
**guestfish**\|(1),
**virt-cat**\|(1),
**virt-df**\|(1),
**virt-list-filesystems**\|(1),
**virt-list-partitions**\|(1),
**csvtool**\|(1),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2010-2012 Red Hat Inc.

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
