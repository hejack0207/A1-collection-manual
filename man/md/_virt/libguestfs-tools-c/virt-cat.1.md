# virt-cat(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-cat - Display files in a virtual machine

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-cat [--options] -d domname file [file ...]   virt-cat [--options] -a disk.img [-a disk.img ...] file [file ...] .Ve 
 Old-style: 
 .Vb 1  virt-cat domname file   virt-cat disk.img file .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\f(CW`virt-cat\*(C' is a command line tool to display the contents of \f(CW\*(C\`file\*(C'
where \f(CW`file\*(C' exists in the named virtual machine (or disk image).

Multiple filenames can be given, in which case they are concatenated
together.  Each filename must be a full path, starting at the root
directory (starting with '/').

\f(CW`virt-cat\*(C' can be used to quickly view a file.  To edit a file, use
\f(CW`virt-edit\*(C'.  For more complex cases you should look at the
**guestfish**\|(1) tool (see \s-1USING GUESTFISH\*(R"\s0 below).

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Display _/etc/fstab_ file from inside the libvirt \s-1VM\s0 called
\f(CW`mydomain\*(C':

.Vb 1
 virt-cat -d mydomain /etc/fstab
.Ve

Find out what packages were recently installed:

.Vb 1
 virt-cat -d mydomain /var/log/yum.log | tail
.Ve

Find out who is logged on inside a virtual machine:

.Vb 2
 virt-cat -d mydomain /var/run/utmp &gt; /tmp/utmp
 who /tmp/utmp
.Ve

or who was logged on:

.Vb 2
 virt-cat -d mydomain /var/log/wtmp &gt; /tmp/wtmp
 last -f /tmp/wtmp
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
* **--echo-keys**  
  .IX Item "--echo-keys"
  When prompting for keys and passphrases, virt-cat normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room you
  can specify this flag to see what you are typing.
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
   virt-cat --format=raw -a disk.img file
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-cat --format=raw -a disk.img --format -a another.img file
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_ and reverts to
  auto-detection for _another.img_.
  .Sp
  If you have untrusted raw-format guest disk images, you should use
  this option to specify the disk format.  This avoids a possible
  security problem with malicious guests (\s-1CVE-2010-3851\s0).
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
Previous versions of virt-cat allowed you to write either:

.Vb 1
 virt-cat disk.img [disk.img ...] file
.Ve

or

.Vb 1
 virt-cat guestname file
.Ve

whereas in this version you should use _-a_ or _-d_ respectively
to avoid the confusing case where a disk image might have the same
name as a guest.

For compatibility the old style is still supported.

<a name="log-files"></a>

# Log Files

.IX Header "LOG FILES"
To list out the log files from guests, see the related tool
**virt-log**\|(1).  It understands binary log formats such as the systemd
journal.

To follow (tail) text log files, use **virt-tail**\|(1).

<a name="windows-paths"></a>

# Windows Paths

.IX Header "WINDOWS PATHS"
\f(CW`virt-cat\*(C' has a limited ability to understand Windows drive letters
and paths (eg. _E:\efoo\ebar.txt_).

If and only if the guest is running Windows then:

* ·  
  Drive letter prefixes like \f(CW`C:\*(C' are resolved against the
  Windows Registry to the correct filesystem.
* ·  
  Any backslash (\f(CW`\e\*(C') characters in the path are replaced
  with forward slashes so that libguestfs can process it.
* ·  
  The path is resolved case insensitively to locate the file
  that should be displayed.

There are some known shortcomings:

* ·  
  Some \s-1NTFS\s0 symbolic links may not be followed correctly.
* ·  
  \s-1NTFS\s0 junction points that cross filesystems are not followed.

<a name="using-guestfish"></a>

# Using Guestfish

.IX Header "USING GUESTFISH"
**guestfish**\|(1) is a more powerful, lower level tool which you can use
when \f(CW`virt-cat\*(C' doesn't work.

Using \f(CW`virt-cat\*(C' is approximately equivalent to doing:

.Vb 1
 guestfish --ro -i -d domname download file -
.Ve

where \f(CW`domname\*(C' is the name of the libvirt guest, and \f(CW\*(C\`file\*(C' is the
full path to the file.  Note the final \f(CW`-\*(C' (meaning \*(L"output to
stdout).

The command above uses libguestfs’s guest inspection feature and so
does not work on guests that libguestfs cannot inspect, or on things
like arbitrary disk images that don't contain guests.  To display a
file from a disk image directly, use:

.Vb 1
 guestfish --ro -a disk.img -m /dev/sda1 download file -
.Ve

where _disk.img_ is the disk image, _/dev/sda1_ is the filesystem
within the disk image, and \f(CW`file\*(C' is the full path to the file.

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
**virt-copy-out**\|(1),
**virt-edit**\|(1),
**virt-log**\|(1),
**virt-tail**\|(1),
**virt-tar-out**\|(1),
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
