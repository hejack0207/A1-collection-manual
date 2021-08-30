# guestunmount(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

guestunmount - Unmount a guestmounted filesystem

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  guestunmount mountpoint   guestunmount --fd=<FD> mountpoint .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
guestunmount is a utility to clean up mounted filesystems
automatically.  **guestmount**\|(1) mounts filesystems using libguestfs.
This program unmounts the filesystem when a program or script has finished
with it.

guestunmount is a wrapper around the \s-1FUSE\s0 **fusermount**\|(1) program,
which must exist on the current \f(CW`PATH\*(C'.

There are two ways to use guestunmount.  When called as:

.Vb 1
 guestunmount mountpoint
.Ve

it unmounts \f(CW`mountpoint\*(C' immediately.

When called as:

.Vb 1
 guestunmount --fd=FD mountpoint
.Ve

it waits until the pipe \f(CW`FD\*(C' is closed.  This can be used to monitor
another process and clean up its mountpoint when that process exits,
as described below.

<a name="s-1from-programss0"></a>

### \s-1FROM PROGRAMS\s0

.IX Subsection "FROM PROGRAMS"
You can just call \f(CW`guestunmount mountpoint\*(C' from the program, but a
more sophisticated way to use guestunmount is to have it monitor your
program so it can clean up the mount point if your program exits
unexpectedly.

In the program, create a pipe (eg. by calling **pipe**\|(2)).  Let \f(CW`FD\*(C'
be the file descriptor number of the read side of the pipe
(ie. \f(CW`pipefd[0]\*(C').

After mounting the filesystem with **guestmount**\|(1) (on
\f(CW`mountpoint\*(C'), fork and run guestunmount like this:

.Vb 1
 guestunmount --fd=FD mountpoint
.Ve

Close the read side of the pipe in the parent process.

Now, when the write side of the pipe (ie. \f(CW`pipefd[1]\*(C') is closed for
any reason, either explicitly or because the parent process
exits, guestunmount notices and unmounts the mountpoint.

If your operating system supports it, you should set the \f(CW`FD\_CLOEXEC\*(C'
flag on the write side of the pipe.  This is so that other child
processes don't inherit the file descriptor and keep it open.

Guestunmount never daemonizes itself.

<a name="s-1from-shell-scriptss0"></a>

### \s-1FROM SHELL SCRIPTS\s0

.IX Subsection "FROM SHELL SCRIPTS"
Since bash doesn't provide a way to create an unnamed pipe, use a trap
to call guestunmount on exit like this:

.Vb 1
 trap "guestunmount mountpoint" EXIT INT QUIT TERM
.Ve

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--fd=FD**  
  .IX Item "--fd=FD"
  Specify the pipe file descriptor to monitor, and delay cleanup until
  that pipe is closed.
* **--help**  
  .IX Item "--help"
  Display brief help and exit.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  Don’t display error messages from fusermount.  The return status is
  still set (see \s-1EXIT STATUS\*(R"\s0 below).
* **--no-retry**  
  .IX Item "--no-retry"
* **--retry=N**  
  .IX Item "--retry=N"
  By default, guestunmount will retry the fusermount operation up to
  5 times (that is, it will run it up to 6 times = 1 try +
  5 retries).
  .Sp
  Use _--no-retry_ to make guestunmount run fusermount only once.
  .Sp
  Use _--retry=N_ to make guestunmount retry \f(CW`N\*(C' times instead of 5.
  .Sp
  guestunmount performs an exponential back-off between retries, waiting
  1 second, 2 seconds, 4 seconds, etc before each retry.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display the program version and exit.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"
.ie n .IP """PATH""" 4
.el .IP "\f(CWPATH" 4
.IX Item "PATH"
The **fusermount**\|(1) program (supplied by \s-1FUSE\s0) must be available on
the current \f(CW`PATH\*(C'.

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 if successful, or one of the following error
codes:
.ie n .IP "1" 4
.el .IP "\f(CW1" 4
.IX Item "1"
Program error, eg. could not allocate memory, could not run fusermount.
See the error message printed for more information.
.ie n .IP "2" 4
.el .IP "\f(CW2" 4
.IX Item "2"
The mount point could not be unmounted even after retrying.  See
the error message printed for the underlying fusermount error.
.ie n .IP "3" 4
.el .IP "\f(CW3" 4
.IX Item "3"
The mount point is not mounted.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**guestmount**\|(1),
**fusermount**\|(1),
**pipe**\|(2),
\s-1MOUNT LOCAL\*(R"\s0 in **guestfs**\|(3),
http://libguestfs.org/,
http://fuse.sf.net/.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
Richard W.M. Jones (\f(CW`rjones at redhat dot com\*(C')

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
