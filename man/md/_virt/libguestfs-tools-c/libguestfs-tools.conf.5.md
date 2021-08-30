# libguestfs-tools.conf(5)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

libguestfs-tools.conf - configuration file for guestfish, guestmount, virt-rescue

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  /etc/libguestfs-tools.conf   $XDG_CONFIG_DIRS/libguestfs/libguestfs-tools.conf   $HOME/.libguestfs-tools.rc   $XDG_CONFIG_HOME/libguestfs/libguestfs-tools.conf .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
_libguestfs-tools.conf_ (or _\f(CI$HOME/.libguestfs-tools.rc_) changes the
defaults for the following programs only:

* ·  
  **guestfish**\|(1)
* ·  
  **guestmount**\|(1)
* ·  
  **virt-rescue**\|(1)

There is currently only one setting which is controlled by this
file.  Adding (or uncommenting):

.Vb 1
 read_only = true;
.Ve

changes these programs so they act as if the _--ro_ flag was given on
the command line.  You can use this to make the programs safe against
accidental modification of a live guest (users would have to
explicitly add the _--rw_ flag to modify guests).  This is not the
default because it is not backwards compatible.
See also \s-1OPENING DISKS FOR READ AND WRITE\*(R"\s0 in **guestfish**\|(1).

Note that **the semicolon is required**.

This file is parsed by the libconfig library.  For more information
about the format, see:
http://www.hyperrealm.com/libconfig/libconfig_manual.html

<a name="file-location"></a>

# File Location

.IX Header "FILE LOCATION"
The order of the configuration files being read is, by importance:

* ·  
  \f(CW$XDG\_CONFIG\_HOME/libguestfs/libguestfs-tools.conf (\f(CW$XDG\_CONFIG\_HOME is
  _\f(CI$HOME/.config_ if not set).
* ·  
  \f(CW$HOME/.libguestfs-tools.rc
* ·  
  \f(CW$XDG\_CONFIG\_DIRS/libguestfs/libguestfs-tools.conf (where \f(CW$XDG\_CONFIG\_DIRS
  means any of the directories in that environment variable, or just _/etc/xdg_
  if not set)
* ·  
  /etc/libguestfs-tools.conf

This means local users can override the system configuration by copying
the configuration file (or creating it anew) into
_\f(CI$XDG\_CONFIG\_HOME/libguestfs/libguestfs-tools.conf_.

_/etc/libguestfs-tools.conf_ and _\f(CI$HOME/.libguestfs-tools.rc_ are the old
non-XDG paths which are read for compatibility.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
\s-1OPENING DISKS FOR READ AND WRITE\*(R"\s0 in **guestfish**\|(1),
**guestmount**\|(1),
**virt-rescue**\|(1),
http://libguestfs.org/,
http://standards.freedesktop.org/basedir-spec/latest/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Richard W.M. Jones (\f(CW`rjones at redhat dot com\*(C')

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2011-2019 Red Hat Inc.

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
