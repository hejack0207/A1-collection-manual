# virt-copy-in(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-copy-in - Copy files and directories into a virtual machine disk image.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-copy-in -a disk.img file|dir [file|dir ...] /destination   virt-copy-in -d domain file|dir [file|dir ...] /destination .Ve
```

<a name="warning"></a>

# Warning

.IX Header "WARNING"
Using \f(CW`virt-copy-in\*(C'
on live virtual machines, or concurrently with other
disk editing tools, can be dangerous, potentially causing disk
corruption.  The virtual machine must be shut down before you use this
command, and disk images must not be edited concurrently.

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\f(CW`virt-copy-in\*(C' copies files and directories from the local disk into
a virtual machine disk image or named libvirt domain.

You can give one or more filenames and directories on the command
line.  Directories are copied in recursively.  The final parameter
must be the destination directory in the disk image which must be an
absolute path starting with a _/_ character.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Update _/etc/resolv.conf_ in a guest:

.Vb 1
 virt-copy-in -d MyGuest resolv.conf /etc
.Ve

Upload a home directory to a guest:

.Vb 1
 virt-copy-in -d MyGuest skel /home
.Ve

<a name="just-a-shell-script-wrapper-around-guestfish"></a>

# Just a Shell Script Wrapper Around Guestfish

.IX Header "JUST A SHELL SCRIPT WRAPPER AROUND GUESTFISH"
This command is just a simple shell script wrapper around the
**guestfish**\|(1) \f(CW`copy-in\*(C' command.  For anything more complex than a
trivial copy, you are probably better off using guestfish directly.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
Since the shell script just passes options straight to guestfish, read
**guestfish**\|(1) to see the full list of options.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestfish**\|(1),
**virt-cat**\|(1),
**virt-copy-out**\|(1),
**virt-edit**\|(1),
**virt-tar-in**\|(1),
**virt-tar-out**\|(1),
http://libguestfs.org/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Richard W.M. Jones (\f(CW`rjones at redhat dot com\*(C')

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2011-2012 Red Hat Inc.

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
