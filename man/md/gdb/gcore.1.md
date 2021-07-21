# gcore(1)

gdb-Fedora 8.2.91.20190401-23.fc30, 2019-04-01

.if n .ad l
.nh

<a name="name"></a>

# Name

gcore - Generate a core file of a running program

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" gcore [-a] [-o prefix] pid1 [pid2...pidN]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Generate core dumps of one or more running programs with process IDs
_pid1_, _pid2_, etc.  A core file produced by **gcore**
is equivalent to one produced by the kernel when the process crashes
(and when \f(CW`ulimit -c\*(C' was used to set up an appropriate core dump
limit).  However, unlike after a crash, after **gcore** finishes
its job the program remains running without any change.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-a**  
  .IX Item "-a"
  Dump all memory mappings.  The actual effect of this option depends on
  the Operating System.  On GNU/Linux, it will disable
  \f(CW`use-coredump-filter\*(C' and
  enable \f(CW`dump-excluded-mappings\*(C'.
* **-o** _prefix_  
  .IX Item "-o prefix"
  The optional argument _prefix_ specifies the prefix to be used
  when composing the file names of the core dumps.  The file name is
  composed as _prefix.pid_, where _pid_ is the
  process \s-1ID\s0 of the running program being analyzed by **gcore**.
  If not specified, _prefix_ defaults to _gcore_.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
The full documentation for \s-1GDB\s0 is maintained as a Texinfo manual.
If the \f(CW`info\*(C' and \f(CW\*(C\`gdb\*(C' programs and \s-1GDB\s0's Texinfo
documentation are properly installed at your site, the command

.Vb 1
        info gdb
.Ve

should give you access to the complete manual.

_Using \s-1GDB: A\s0 Guide to the \s-1GNU\s0 Source-Level Debugger_,
Richard M. Stallman and Roland H. Pesch, July 1991.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1988-2019 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation; with the
Invariant Sections being Free Software\*(R" and \*(L"Free Software Needs
Free Documentation, with the Front-Cover Texts being \*(L"A \s-1GNU\s0 Manual,\*(R"
and with the Back-Cover Texts as in (a) below.

(a) The \s-1FSF\s0's Back-Cover Text is: You are free to copy and modify
this \s-1GNU\s0 Manual.  Buying copies from \s-1GNU\s0 Press supports the \s-1FSF\s0 in
developing \s-1GNU\s0 and promoting software freedom.
