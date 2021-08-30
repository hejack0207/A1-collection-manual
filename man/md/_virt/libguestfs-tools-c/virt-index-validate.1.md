# virt-index-validate(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-index-validate - Validate virt-builder index file

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  virt-index-validate index .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**virt-builder**\|(1) uses an index file to store metadata about templates
that it knows how to use.  This index file has a specific format which
virt-index-validate knows how to validate.

Note that virt-index-validate can validate either the signed or
unsigned index file (ie. either _index_ or _index.asc_).  It can
only validate a local file, not a \s-1URL.\s0

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--compat-1.24.0**  
  .IX Item "--compat-1.24.0"
  Check for compatibility with virt-builder 1.24.0.  (Using this option
  implies _--compat-1.24.1_, so you don't need to use both.)
  .Sp
  In particular:
    * ·  
      This version of virt-builder could not handle \f(CW`[...]\*(C'
      (square brackets) in field names (eg. \f(CW`checksum[sha512]=...\*(C').
    * ·  
      It required detached signatures (\f(CW`sig=...\*(C').
* **--compat-1.24.1**  
  .IX Item "--compat-1.24.1"
  Check for compatibility with virt-builder ≥ 1.24.1.
  .Sp
  In particular:
    * ·  
      This version of virt-builder could not handle \f(CW`.\*(C' (period) in field
      names or \f(CW`,\*(C' (comma) in subfield names.
    * ·  
      It could not handle comments appearing in the file.
* **--help**  
  .IX Item "--help"
  Display help.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display version number and exit.

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 if the index file validates, or non-zero if
there was an error.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-builder**\|(1),
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Richard W.M. Jones http://people.redhat.com/~rjones/

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2013 Red Hat Inc.

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
