# virt-df(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-df - Display free space on virtual filesystems

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" All guests: 
 .Vb 1  virt-df [--options] .Ve 
 Single guest: 
 .Vb 1  virt-df [--options] -d domname   virt-df [--options] -a disk.img [-a disk.img ...] .Ve 
 Old style: 
 .Vb 1  virt-df [--options] domname   virt-df [--options] disk.img [disk.img ...] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\f(CW`virt-df\*(C' is a command line tool to display free space on virtual
machine filesystems.  Unlike other tools, it doesn't just display the
size of disk allocated to a virtual machine, but can look inside disk
images to see how much space is really being used.

If used without any _-a_ or _-d_ arguments, \f(CW`virt-df\*(C' checks with
libvirt to get a list of all active and inactive guests, and performs
a \f(CW`df\*(C'-type operation on each one in turn, printing out the results.

If any _-a_ or _-d_ arguments are specified, \f(CW`virt-df\*(C' performs a
\f(CW`df\*(C'-type operation on either the single named libvirt domain, or on
the disk image(s) listed on the command line (which must all belong to
a single \s-1VM\s0).  In this mode (with arguments), \f(CB`virt-df\*(C' will only
work for a single guest.  If you want to run on multiple guests, then
you have to invoke \f(CW`virt-df\*(C' multiple times.

Use the _--csv_ option to get a format which can be easily parsed by
other programs.  Other options are similar to the standard **df**\|(1)
command.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Show disk usage for a single libvirt guest called \f(CW`F14x64\*(C'.  Make the
output human-readable:

.Vb 4
 # virt-df -d F14x64 -h
 Filesystem                       Size     Used  Available  Use%
 F14x64:/dev/sda1                 484M      66M       393M   14%
 F14x64:/dev/vg_f13x64/lv_root    7.4G     3.4G       4.0G   46%
.Ve

Show disk usage for a disk image file called _test.img_:

.Vb 3
 $ virt-df -a test1.img
 Filesystem                  1K-blocks     Used  Available  Use%
 test1.img:/dev/sda1             99099     1551      92432    2%
.Ve

If a single guest has multiple disks, use the _-a_ option repeatedly.
A plus sign (\f(CW`+\*(C') is displayed for each additional disk.  Note: Do
not do this with unrelated guest disks.

.Vb 5
 $ virt-df -a Win7x32TwoDisks-a -a Win7x32TwoDisks-b 
 Filesystem                   1K-blocks    Used  Available  Use%
 Win7x32TwoDisks-a+:/dev/sda1    102396   24712      77684   25%
 Win7x32TwoDisks-a+:/dev/sda2  12478460 7403416    5075044   60%
 Win7x32TwoDisks-a+:/dev/sdb1    521212   55728     465484   11%
.Ve

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display brief help.
* **-a** \s-1FILE\s0  
  .IX Item "-a FILE"
* **--add** \s-1FILE\s0  
  .IX Item "--add FILE"
  Add \f(CW`FILE\*(C' which should be a disk image from a virtual machine.  If
  the virtual machine has multiple block devices, you must supply all of
  them with separate _-a_ options.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format=.._ option.
* **-a** \s-1URI\s0  
  .IX Item "-a URI"
* **--add** \s-1URI\s0  
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
   virt-df --format=raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-df --format=raw -a disk.img --format -a another.img
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
  Print sizes in human-readable format.
  .Sp
  You are not allowed to use _-h_ and _--csv_ at the same time.
* **-i**  
  .IX Item "-i"
* **--inodes**  
  .IX Item "--inodes"
  Print inodes instead of blocks.
* **--one-per-guest**  
  .IX Item "--one-per-guest"
  Since libguestfs 1.22, this is the default.  This option does nothing
  and is left here for backwards compatibility with older scripts.
* **-P** nr_threads  
  .IX Item "-P nr_threads"
  Since libguestfs 1.22, virt-df is multithreaded and examines guests in
  parallel.  By default the number of threads to use is chosen based on
  the amount of free memory available at the time that virt-df is
  started.  You can force virt-df to use at most \f(CW`nr\_threads\*(C' by using
  the _-P_ option.
  .Sp
  Note that _-P 0_ means to autodetect, and _-P 1_ means to use a
  single thread.
* **--uuid**  
  .IX Item "--uuid"
  Print UUIDs instead of names.  This is useful for following
  a guest even when the guest is migrated or renamed, or when
  two guests happen to have the same name.
  .Sp
  Note that only domains that we fetch from libvirt come with UUIDs.
  For disk images, we still print the disk image name even when
  this option is specified.
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

<a name="statvfs-numbers"></a>

# Statvfs Numbers

.IX Header "STATVFS NUMBERS"
\f(CW`virt-df\*(C' (and **df**\|(1)) get information by issuing a **statvfs**\|(3)
system call.  You can get the same information directly, either from
the host (using libguestfs) or inside the guest:

* From the host  
  .IX Item "From the host"
  Run this command:
  .Sp
  .Vb 1
   guestfish --ro -d GuestName -i statvfs /
  .Ve
  .Sp
  (change _/_ to see stats for other filesystems).
* From inside the guest  
  .IX Item "From inside the guest"
  Run this command:
  .Sp
  .Vb 1
   python -c import os; s = os.statvfs ("/"); print s\*(Aq
  .Ve
  .Sp
  (change _/_ to see stats for other filesystems).

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
**df**\|(1),
**guestfs**\|(3),
**guestfish**\|(1),
**virt-filesystems**\|(1),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2009-2019 Red Hat Inc.

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
