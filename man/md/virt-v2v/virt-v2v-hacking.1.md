# virt-v2v-hacking(1)

virt-v2v-1.44.0, 2021-04-30

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-v2v-hacking -

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
First a little history.  Virt-v2v has been through at least two
complete rewrites, so this is probably about the third version (but we
don't intend to rewrite it again).  The previous version was written
in Perl and can be found here:
https://git.fedorahosted.org/git/virt-v2v.git

The current version started out as almost a line-for-line rewrite of
the Perl code in OCaml + C, and it still has a fairly similar
structure.  Therefore if there are details of this code that you don't
understand (especially in the details of guest conversion), checking
the Perl code may help.

The files to start with when reading this code are:

* ·  
  _types.mli_
* ·  
  _v2v.ml_

_types.mli_ defines all the structures used and passed around when
communicating between different bits of the program.  _v2v.ml_
controls how the program runs in stages.

After studying those files, you may want to branch out into the input
modules (_input\_*_), the output modules (_output\_*_) or the
conversion modules (_convert\_*_).  The input and output modules
define _-i_ and _-o_ options (see the manual).  The conversion
modules define what guest types we can handle and the detailed steps
involved in converting them.

Every other file in this directory is a support module / library of
some sort.  Some code is written in C, especially where we want to use
an external C library such as libxml2.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-p2v**\|(1),
**virt-v2v**\|(1).

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Richard W.M. Jones

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2009-2020 Red Hat Inc.

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
