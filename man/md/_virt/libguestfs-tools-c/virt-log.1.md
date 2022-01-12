# virt-log(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-log - Display log files from a virtual machine

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-log [--options] -d domname   virt-log [--options] -a disk.img [-a disk.img ...] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\f(CW`virt-log\*(C' is a command line tool to display the log files from the
named virtual machine (or disk image).

This tool understands and displays both plain text log files
(eg. _/var/log/messages_) and binary formats such as the systemd
journal.

To display other types of files, use **virt-cat**\|(1).  To follow (tail)
text log files, use **virt-tail**\|(1).  To copy files out of a virtual
machine, use **virt-copy-out**\|(1).  To display the contents of the
Windows Registry, use **virt-win-reg**\|(1).

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Display the complete logs from a guest:

.Vb 1
 virt-log -d mydomain | less
.Ve

Find out what \s-1DHCP IP\s0 address a \s-1VM\s0 acquired:

.Vb 1
 virt-log -d mydomain | grep dhclient.*bound to\*(Aq
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
  When prompting for keys and passphrases, virt-log normally turns
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
   virt-log --format=raw -a disk.img
  .Ve
  .Sp
  forces raw format (no auto-detection) for _disk.img_.
  .Sp
  .Vb 1
   virt-log --format=raw -a disk.img --format -a another.img
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
**virt-tail**\|(1),
**virt-tar-out**\|(1),
**virt-win-reg**\|(1),
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
