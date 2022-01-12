# virt-get-kernel(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-get-kernel - Extract kernel and ramdisk from guests

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-get-kernel [--options] -d domname   virt-get-kernel [--options] -a disk.img .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This option extracts the kernel and initramfs from a guest.

The format of the disk image is automatically detected unless you
specify it by using the _--format_ option.

In the case where the guest contains multiple kernels, the one with
the highest version number is chosen.  To extract arbitrary kernels
from the disk image, see **guestfish**\|(1).  To extract the entire
\f(CW`/boot\*(C' directory of a guest, see **virt-copy-out**\|(1).

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **-a** file  
  .IX Item "-a file"
* **--add** file  
  .IX Item "--add file"
  Add _file_ which should be a disk image from a virtual machine.
  .Sp
  The format of the disk image is auto-detected.  To override this and
  force a particular format use the _--format_ option.
* **-a** \s-1URI\s0  
  .IX Item "-a URI"
* **--add** \s-1URI\s0  
  .IX Item "--add URI"
  Add a remote disk.  The \s-1URI\s0 format is compatible with guestfish.
  See \s-1ADDING REMOTE STORAGE\*(R"\s0 in **guestfish**\|(1).
* **--colors**  
  .IX Item "--colors"
* **--colours**  
  .IX Item "--colours"
  Use \s-1ANSI\s0 colour sequences to colourize messages.  This is the default
  when the output is a tty.  If the output of the program is redirected
  to a file, \s-1ANSI\s0 colour sequences are disabled unless you use this
  option.
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
  When prompting for keys and passphrases, virt-get-kernel normally turns
  echoing off so you cannot see what you are typing.  If you are not
  worried about Tempest attacks and there is no one else in the room
  you can specify this flag to see what you are typing.
* **--format** raw|qcow2|..  
  .IX Item "--format raw|qcow2|.."
* **--format** auto  
  .IX Item "--format auto"
  The default for the _-a_ option is to auto-detect the format of the
  disk image.  Using this forces the disk format for the _-a_ option
  on the command line.
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
* **--machine-readable**  
  .IX Item "--machine-readable"
* **--machine-readable**=format  
  .IX Item "--machine-readable=format"
  This option is used to make the output more machine friendly
  when being parsed by other programs.  See
  \s-1MACHINE READABLE OUTPUT\*(R"\s0 below.
* **-o** directory  
  .IX Item "-o directory"
* **--output** directory  
  .IX Item "--output directory"
  This option specifies the output directory where kernel and initramfs
  from the guest are written.
  .Sp
  If not specified, the default output is the current directory.
* **--prefix** prefix  
  .IX Item "--prefix prefix"
  This option specifies a prefix for the extracted files.
  .Sp
  If a prefix is specified, then there will be a dash (\f(CW`-\*(C') after the
  prefix and before the rest of the file name; for example, a kernel
  in the guest like \f(CW`vmlinuz-3.19.0-20-generic\*(C' is saved as
  \f(CW`mydistro-vmlinuz-3.19.0-20-generic\*(C' when the prefix is \f(CW\*(C\`mydistro\*(C'.
  .Sp
  See also _--unversioned-names_.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  Don’t print ordinary progress messages.
* **--unversioned-names**  
  .IX Item "--unversioned-names"
  This option affects the destination file name of extracted files.
  .Sp
  If enabled, files will be saved locally just with the base name;
  for example, kernel and ramdisk in the guest like
  \f(CW`vmlinuz-3.19.0-20-generic\*(C' and \f(CW\*(C\`initrd.img-3.19.0-20-generic\*(C'
  are saved respectively as \f(CW`vmlinuz\*(C' and \f(CW\*(C\`initrd.img\*(C'.
  .Sp
  See also _--prefix_.
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

<a name="machine-readable-output"></a>

# Machine Readable Output

.IX Header "MACHINE READABLE OUTPUT"
The _--machine-readable_ option can be used to make the output more
machine friendly, which is useful when calling virt-get-kernel from
other programs, GUIs etc.

Use the option on its own to query the capabilities of the
virt-get-kernel binary.  Typical output looks like this:

.Vb 2
 $ virt-get-kernel --machine-readable
 virt-get-kernel
.Ve

A list of features is printed, one per line, and the program exits
with status 0.

It is possible to specify a format string for controlling the output;
see \s-1ADVANCED MACHINE READABLE OUTPUT\*(R"\s0 in **guestfs**\|(3).

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
For other environment variables which affect all libguestfs programs,
see \s-1ENVIRONMENT VARIABLES\*(R"\s0 in **guestfs**\|(3).

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
**guestmount**\|(1),
**virt-copy-out**\|(1),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2013-2019 Red Hat Inc.

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
