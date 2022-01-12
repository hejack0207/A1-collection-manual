# virt-ls(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-ls - List files in a virtual machine

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-ls [--options] -d domname directory [directory ...]   virt-ls [--options] -a disk.img [-a disk.img ...] directory [directory ...] .Ve 
 Old style: 
 .Vb 1  virt-ls [--options] domname directory   virt-ls [--options] disk.img [disk.img ...] directory .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\f(CW`virt-ls\*(C' lists filenames, file sizes, checksums, extended attributes
and more from a virtual machine or disk image.

Multiple directory names can be given, in which case the output from
each is concatenated.

To list directories from a libvirt guest use the _-d_ option to
specify the name of the guest.  For a disk image, use the _-a_
option.

\f(CW`virt-ls\*(C' can do many simple file listings.  For more complicated
cases you may need to use **guestfish**\|(1), or write a program directly
to the **guestfs**\|(3) \s-1API.\s0

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Get a list of all files and directories in a virtual machine:

.Vb 1
 virt-ls -R -d guest /
.Ve

List all setuid or setgid programs in a Linux virtual machine:

.Vb 1
 virt-ls -lR -d guest / | grep ^- [42]\*(Aq
.Ve

List all public-writable directories in a Linux virtual machine:

.Vb 1
 virt-ls -lR -d guest / | grep ^d ...7\*(Aq
.Ve

List all Unix domain sockets in a Linux virtual machine:

.Vb 1
 virt-ls -lR -d guest / | grep ^s\*(Aq
.Ve

List all regular files with filenames ending in ‘.png’:

.Vb 1
 virt-ls -lR -d guest / | grep -i ^-.*\e.png$\*(Aq
.Ve

To display files larger than 10MB in home directories:

.Vb 1
 virt-ls -lR -d guest /home | awk $3 &gt; 10*1024*1024\*(Aq
.Ve

Find everything modified in the last 7 days:

.Vb 1
 virt-ls -lR -d guest --time-days / | awk $6 &lt;= 7\*(Aq
.Ve

Find regular files modified in the last 24 hours:

.Vb 1
 virt-ls -lR -d guest --time-days / | grep ^-\*(Aq | awk \*(Aq$6 &lt; 1\*(Aq
.Ve

<a name="s-1differences-in-snapshots-and-backing-filess0"></a>

### \s-1DIFFERENCES IN SNAPSHOTS AND BACKING FILES\s0

.IX Subsection "DIFFERENCES IN SNAPSHOTS AND BACKING FILES"
Although it is possible to use virt-ls to look for differences, since
libguestfs ≥ 1.26 a new tool is available called **virt-diff**\|(1).

<a name="output-modes"></a>

# Output Modes

.IX Header "OUTPUT MODES"
\f(CW`virt-ls\*(C' has four output modes, controlled by different
combinations of the _-l_ and _-R_ options.

<a name="s-1simple-listings0"></a>

### \s-1SIMPLE LISTING\s0

.IX Subsection "SIMPLE LISTING"
A simple listing is like the ordinary **ls**\|(1) command:

.Vb 4
 $ virt-ls -d guest /
 bin
 boot
 [etc.]
.Ve

<a name="s-1long-listings0"></a>

### \s-1LONG LISTING\s0

.IX Subsection "LONG LISTING"
With the _-l_ (_--long_) option, the output is like the \f(CW`ls -l\*(C'
command (more specifically, like the \f(CW`guestfs\_ll\*(C' function).

.Vb 5
 $ virt-ls -l -d guest /
 total 204
 dr-xr-xr-x.   2 root root   4096 2009-08-25 19:06 bin
 dr-xr-xr-x.   5 root root   3072 2009-08-25 19:06 boot
 [etc.]
.Ve

Note that while this is useful for displaying a directory, do not try
parsing this output in another program.  Use \s-1RECURSIVE LONG LISTING\*(R"\s0
instead.

<a name="s-1recursive-listings0"></a>

### \s-1RECURSIVE LISTING\s0

.IX Subsection "RECURSIVE LISTING"
With the _-R_ (_--recursive_) option, \f(CW`virt-ls\*(C' lists the names of
files and directories recursively:

.Vb 4
 $ virt-ls -R -d guest /tmp
 foo
 foo/bar
 [etc.]
.Ve

To generate this output, \f(CW`virt-ls\*(C' runs the \f(CW\*(C\`guestfs\_find0\*(C' function
and converts \f(CW`\e0\*(C' characters to \f(CW\*(C\`\en\*(C'.

<a name="s-1recursive-long-listings0"></a>

### \s-1RECURSIVE LONG LISTING\s0

.IX Subsection "RECURSIVE LONG LISTING"
Using _-lR_ options together changes the output to display
directories recursively, with file stats, and optionally other
features such as checksums and extended attributes.

Most of the interesting features of \f(CW`virt-ls\*(C' are only available when
using _-lR_ mode.

The fields are normally space-separated.  Filenames are **not** quoted,
so you cannot use the output in another program (because filenames can
contain spaces and other unsafe characters).  If the guest was
untrusted and someone knew you were using \f(CW`virt-ls\*(C' to analyze the
guest, they could play tricks on you by creating filenames with
embedded newline characters.  To **safely** parse the output in another
program, use the _--csv_ (Comma-Separated Values) option.

Note that this output format is completely unrelated to the \f(CW`ls -lR\*(C'
command.

.Vb 8
 $ virt-ls -lR -d guest /bin
 d 0555       4096 /bin
 - 0755        123 /bin/alsaunmute
 - 0755      28328 /bin/arch
 l 0777          4 /bin/awk -&gt; gawk
 - 0755      27216 /bin/basename
 - 0755     943360 /bin/bash
 [etc.]
.Ve

These basic fields are always shown:

* type  
  .IX Item "type"
  The file type, one of:
  \f(CW`-\*(C' (regular file),
  \f(CW`d\*(C' (directory),
  \f(CW`c\*(C' (character device),
  \f(CW`b\*(C' (block device),
  \f(CW`p\*(C' (named pipe),
  \f(CW`l\*(C' (symbolic link),
  \f(CW`s\*(C' (socket) or
  \f(CW`u\*(C' (unknown).
* permissions  
  .IX Item "permissions"
  The Unix permissions, displayed as a 4 digit octal number.
* size  
  .IX Item "size"
  The size of the file.  This is shown in bytes unless _-h_ or
  _--human-readable_ option is given, in which case this is shown as a
  human-readable number.
* path  
  .IX Item "path"
  The full path of the file or directory.
* link  
  .IX Item "link"
  For symbolic links only, the link target.

In _-lR_ mode, additional command line options enable the display of
more fields.

With the _--uids_ flag, these additional fields are displayed before
the path:

* uid  
  .IX Item "uid"
* gid  
  .IX Item "gid"
  The \s-1UID\s0 and \s-1GID\s0 of the owner of the file (displayed numerically).
  Note these only make sense in the context of a Unix-like guest.

With the _--times_ flag, these additional fields are displayed:

* atime  
  .IX Item "atime"
  The time of last access.
* mtime  
  .IX Item "mtime"
  The time of last modification.
* ctime  
  .IX Item "ctime"
  The time of last status change.

The time fields are displayed as string dates and times, unless one of
the _--time-t_, _--time-relative_ or _--time-days_ flags is given.

With the _--extra-stats_ flag, these additional fields are displayed:

* device  
  .IX Item "device"
  The device containing the file (displayed as major:minor).
  This may not match devices as known to the guest.
* inode  
  .IX Item "inode"
  The inode number.
* nlink  
  .IX Item "nlink"
  The number of hard links.
* rdev  
  .IX Item "rdev"
  For block and char special files, the device
  (displayed as major:minor).
* blocks  
  .IX Item "blocks"
  The number of 512 byte blocks allocated to the file.

With the _--checksum_ flag, the checksum of the file contents is
shown (only for regular files).  Computing file checksums can take a
considerable amount of time.

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
* **--checksum**  
  .IX Item "--checksum"
* **--checksum=crc|md5|sha1|sha224|sha256|sha384|sha512**  
  .IX Item "--checksum=crc|md5|sha1|sha224|sha256|sha384|sha512"
  Display checksum over file contents for regular files.  With no
  argument, this defaults to using _md5_.  Using an argument, you can
  select the checksum type to use.
  .Sp
  This option only has effect in _-lR_ output mode.  See
  \s-1RECURSIVE LONG LISTING\*(R"\s0 above.
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
  When prompting for keys and passphrases, virt-ls normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room you
  can specify this flag to see what you are typing.
* **--extra-stats**  
  .IX Item "--extra-stats"
  Display extra stats.
  .Sp
  This option only has effect in _-lR_ output mode.  See
  \s-1RECURSIVE LONG LISTING\*(R"\s0 above.
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
   virt-ls --format=raw -a disk.img /dir
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-ls --format=raw -a disk.img --format -a another.img /dir
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
  .Sp
  This option only has effect in _-lR_ output mode.  See
  \s-1RECURSIVE LONG LISTING\*(R"\s0 above.
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
* **-m** dev[:mountpoint[:options[:fstype]]]  
  .IX Item "-m dev[:mountpoint[:options[:fstype]]]"
* **--mount** dev[:mountpoint[:options[:fstype]]]  
  .IX Item "--mount dev[:mountpoint[:options[:fstype]]]"
  Mount the named partition or logical volume on the given mountpoint.
  .Sp
  If the mountpoint is omitted, it defaults to _/_.
  .Sp
  Specifying any mountpoint disables the inspection of the guest and
  the mount of its root and all of its mountpoints, so make sure
  to mount all the mountpoints needed to work with the filenames
  given as arguments.
  .Sp
  If you don’t know what filesystems a disk image contains, you can
  either run guestfish without this option, then list the partitions,
  filesystems and LVs available (see list-partitions\*(R",
  list-filesystems\*(R" and \*(L"lvs\*(R" commands), or you can use the
  **virt-filesystems**\|(1) program.
  .Sp
  The third (and rarely used) part of the mount parameter is the list of
  mount options used to mount the underlying filesystem.  If this is not
  given, then the mount options are either the empty string or \f(CW`ro\*(C'
  (the latter if the _--ro_ flag is used).  By specifying the mount
  options, you override this default choice.  Probably the only time you
  would use this is to enable ACLs and/or extended attributes if the
  filesystem can support them:
  .Sp
  .Vb 1
   -m /dev/sda1:/:acl,user_xattr
  .Ve
  .Sp
  Using this flag is equivalent to using the \f(CW`mount-options\*(C' command.
  .Sp
  The fourth part of the parameter is the filesystem driver to use, such
  as \f(CW`ext3\*(C' or \f(CW\*(C\`ntfs\*(C'. This is rarely needed, but can be useful if
  multiple drivers are valid for a filesystem (eg: \f(CW`ext2\*(C' and \f(CW\*(C\`ext3\*(C'),
  or if libguestfs misidentifies a filesystem.
* **-l**  
  .IX Item "-l"
* **--long**  
  .IX Item "--long"
* **-R**  
  .IX Item "-R"
* **--recursive**  
  .IX Item "--recursive"
  Select the mode.  With neither of these options, \f(CW`virt-ls\*(C' produces a
  simple, flat list of the files in the named directory.  See
  \s-1SIMPLE LISTING\*(R"\s0.
  .Sp
  \f(CW`virt-ls -l\*(C' produces a \*(L"long listing\*(R", which shows more detail.  See
  \s-1LONG LISTING\*(R"\s0.
  .Sp
  \f(CW`virt-ls -R\*(C' produces a recursive list of files starting at the named
  directory.  See \s-1RECURSIVE LISTING\*(R"\s0.
  .Sp
  \f(CW`virt-ls -lR\*(C' produces a recursive long listing which can be more
  easily parsed.  See \s-1RECURSIVE LONG LISTING\*(R"\s0.
* **--times**  
  .IX Item "--times"
  Display time fields.
  .Sp
  This option only has effect in _-lR_ output mode.  See
  \s-1RECURSIVE LONG LISTING\*(R"\s0 above.
* **--time-days**  
  .IX Item "--time-days"
  Display time fields as days before now (negative if in the future).
  .Sp
  Note that \f(CW0 in output means up to 1 day before now\*(R", or that the
  age of the file is between 0 and 86399 seconds.
  .Sp
  This option only has effect in _-lR_ output mode.  See
  \s-1RECURSIVE LONG LISTING\*(R"\s0 above.
* **--time-relative**  
  .IX Item "--time-relative"
  Display time fields as seconds before now (negative if in the future).
  .Sp
  This option only has effect in _-lR_ output mode.  See
  \s-1RECURSIVE LONG LISTING\*(R"\s0 above.
* **--time-t**  
  .IX Item "--time-t"
  Display time fields as seconds since the Unix epoch.
  .Sp
  This option only has effect in _-lR_ output mode.  See
  \s-1RECURSIVE LONG LISTING\*(R"\s0 above.
* **--uids**  
  .IX Item "--uids"
  Display \s-1UID\s0 and \s-1GID\s0 fields.
  .Sp
  This option only has effect in _-lR_ output mode.  See
  \s-1RECURSIVE LONG LISTING\*(R"\s0 above.
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

<a name="old-style-command-line-arguments"></a>

# Old-Style Command Line Arguments

.IX Header "OLD-STYLE COMMAND LINE ARGUMENTS"
Previous versions of virt-ls allowed you to write either:

.Vb 1
 virt-ls disk.img [disk.img ...] /dir
.Ve

or

.Vb 1
 virt-ls guestname /dir
.Ve

whereas in this version you should use _-a_ or _-d_ respectively
to avoid the confusing case where a disk image might have the same
name as a guest.

For compatibility the old style is still supported.

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
**virt-diff**\|(1),
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
