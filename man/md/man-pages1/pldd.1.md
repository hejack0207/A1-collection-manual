# pldd(1) - display dynamic shared objects linked into a process

GNU, 2017-09-15

    pldd pid
    pldd option

<a name="description"></a>

# Description

The
**pldd**
command displays a list of the dynamic shared objects that are
linked into the process with the specified process ID.
The list includes the libraries that have been dynamically loaded using
**dlopen**(3).

<a name="options"></a>

# Options


* **-?**, **--help**  
  Display program help message.
* **--usage**  
  Display a short usage message.
* **-V**, **--version**  
  Display the program version.

<a name="exit-status"></a>

# Exit Status

On success,
**pldd**
exits with the status 0.
If the specified process does not exist,
the user does not have permission to access
its dynamic shared object list,
or no command-line arguments are supplied,
**pldd**
exists with a status of 1.
If given an invalid option, it exits with the status 64.

<a name="versions"></a>

# Versions

**pldd**
is available since glibc 2.15.

<a name="conforming-to"></a>

# Conforming to

The
**pldd**
command is not specified by POSIX.1.
Some other systems

have a similar command.

<a name="notes"></a>

# Notes

The command

.in +4n
.EX
lsof -p PID
.EE
.in

also shows output that includes the dynamic shared objects
that are linked into a process.

The
**gdb**(1)
_info shared_
command also shows the shared libraries being used by a process,
so that one can obtain similar output to
**pldd**
using a command such as the following
(to monitor the process with the specified
_pid_):

.in +4n
.EX
$ **gdb -ex "set confirm off" -ex "set height 0" -ex "info shared" \\**
        **-ex "quit" -p $pid | grep '^0x.*0x'**
.EE
.in

<a name="bugs"></a>

# Bugs

Since glibc 2.19,
**pldd**
is broken: it just hangs when executed.

It is unclear if it will ever be fixed.

<a name="example"></a>

# Example

.EX
$ **echo $$**               # Display PID of shell
1143
$ **pldd $$**               # Display DSOs linked into the shell
1143:	/usr/bin/bash
linux-vdso.so.1
/lib64/libtinfo.so.5
/lib64/libdl.so.2
/lib64/libc.so.6
/lib64/ld-linux-x86-64.so.2
/lib64/libnss_files.so.2
.EE

<a name="see-also"></a>

# See Also

**ldd**(1),
**lsof**(1),
**dlopen**(3),
**ld.so**(8)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
