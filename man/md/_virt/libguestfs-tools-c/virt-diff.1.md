# virt-diff(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-diff - Differences between files in two virtual machines

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-diff [--options] -d domain1 -D domain2   virt-diff [--options] -a disk1.img [-a ...] -A disk2.img [-A ...] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\f(CW`virt-diff\*(C' lists the differences between files in two virtual
machines or disk images.  The usual use case is to show the
changes in a \s-1VM\s0 after it has been running for a while, by taking
a snapshot, running the \s-1VM,\s0 and then using this tool to show
what changed between the new \s-1VM\s0 state and the old snapshot.

This tool will find differences in filenames, file sizes, checksums,
extended attributes, file content and more from a virtual machine or
disk image.  However it **does not** look at the boot loader, unused
space between partitions or within filesystems, hidden\*(R" sectors and
so on.  In other words, it is not a security or forensics tool.

To specify two guests, you have to use the _-a_ or _-d_ option(s)
for the first guest, and the _-A_ or _-D_ option(s) for the second
guest.  The common case is:

.Vb 1
 virt-diff -a old.img -A new.img
.Ve

or using names known to libvirt:

.Vb 1
 virt-diff -d oldguest -D newguest
.Ve

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
  Add _file_ which should be a disk image from the first virtual
  machine.  If the virtual machine has multiple block devices, you must
  supply all of them with separate _-a_ options.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format=.._ option.
* **-a** \s-1URI\s0  
  .IX Item "-a URI"
* **--add** \s-1URI\s0  
  .IX Item "--add URI"
  Add a remote disk.  See \s-1ADDING REMOTE STORAGE\*(R"\s0 in **guestfish**\|(1).
* **--all**  
  .IX Item "--all"
  Same as _--extra-stats_ _--times_ _--uids_ _--xattrs_.
* **--atime**  
  .IX Item "--atime"
  The default is to ignore changes in file access times, since those are
  unlikely to be interesting.  Using this flag shows atime differences
  as well.
* **-A** file  
  .IX Item "-A file"
* **-A** \s-1URI\s0  
  .IX Item "-A URI"
  Add a disk image from the second virtual machine.
* **--checksum**  
  .IX Item "--checksum"
* **--checksum=crc|md5|sha1|sha224|sha256|sha384|sha512**  
  .IX Item "--checksum=crc|md5|sha1|sha224|sha256|sha384|sha512"
  Use a checksum over file contents to detect when regular files have
  changed content.
  .Sp
  With no argument, this defaults to using _md5_.  Using an argument,
  you can select the checksum type to use.  If the flag is omitted then
  file times and size are used to determine if a file has changed.
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
* **--dir-links**  
  .IX Item "--dir-links"
  The default is to ignore changes in the number of links in directory
  entries, since those are unlikely to be interesting.  Using this flag
  shows changes to the nlink field of directories.
* **--dir-times**  
  .IX Item "--dir-times"
  The default is to ignore changed times on directory entries, since
  those are unlikely to be interesting.  Using this flag shows changes
  to the time fields of directories.
* **-d** guest  
  .IX Item "-d guest"
* **--domain** guest  
  .IX Item "--domain guest"
  Add all the disks from the named libvirt guest, as the first guest.
  Domain UUIDs can be used instead of names.
* **-D** guest  
  .IX Item "-D guest"
  Add all the disks from the named libvirt guest, as the second guest.
  Domain UUIDs can be used instead of names.
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, virt-diff normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room you
  can specify this flag to see what you are typing.
* **--extra-stats**  
  .IX Item "--extra-stats"
  Display extra stats.
* **--format=raw|qcow2|..**  
  .IX Item "--format=raw|qcow2|.."
* **--format**  
  .IX Item "--format"
  The default for the _-a_/_-A_ option is to auto-detect the format of
  the disk image.  Using this forces the disk format for _-a_/_-A_
  options which follow on the command line.  Using _--format_ with no
  argument switches back to auto-detection for subsequent _-a_/_-A_
  options.
  .Sp
  For example:
  .Sp
  .Vb 1
   virt-diff --format=raw -a disk.img [...]
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-diff --format=raw -a disk.img --format -a another.img [...]
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
  Display file sizes in human-readable format.
* **--key** \s-1SELECTOR\s0  
  .IX Item "--key SELECTOR"
  Specify a key for \s-1LUKS,\s0 to automatically open a \s-1LUKS\s0 device when using
  the inspection.  \f(CW`SELECTOR\*(C' can be in one of the following formats:
      .ie n .IP "**--key** ""DEVICE"":key:KEY_STRING" 4
      .el .IP "**--key** \f(CWDEVICE:key:KEY_STRING" 4
      .IX Item "--key DEVICE:key:KEY_STRING"
      Use the specified \f(CW`KEY\_STRING\*(C' as passphrase.
      .ie n .IP "**--key** ""DEVICE"":file:FILENAME" 4
      .el .IP "**--key** \f(CWDEVICE:file:FILENAME" 4
      .IX Item "--key DEVICE:file:FILENAME"
      Read the passphrase from _\s-1FILENAME\s0_.
* **--keys-from-stdin**  
  .IX Item "--keys-from-stdin"
  Read key or passphrase parameters from stdin.  The default is
  to try to read passphrases from the user by opening _/dev/tty_.
* **--times**  
  .IX Item "--times"
  Display time fields.
* **--time-days**  
  .IX Item "--time-days"
  Display time fields as days before now (negative if in the future).
  .Sp
  Note that \f(CW0 in output means up to 1 day before now\*(R", or that the
  age of the file is between 0 and 86399 seconds.
* **--time-relative**  
  .IX Item "--time-relative"
  Display time fields as seconds before now (negative if in the future).
* **--time-t**  
  .IX Item "--time-t"
  Display time fields as seconds since the Unix epoch.
* **--uids**  
  .IX Item "--uids"
  Display \s-1UID\s0 and \s-1GID\s0 fields.
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
* **--xattrs**  
  .IX Item "--xattrs"
  Display extended attributes.

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
**virt-copy-out**\|(1),
**virt-ls**\|(1),
**virt-tar-out**\|(1),
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
