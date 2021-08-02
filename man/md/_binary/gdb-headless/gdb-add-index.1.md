# gdb-add-index(1)

gdb-Fedora 8.2.91.20190401-23.fc30, 2019-04-01

.if n .ad l
.nh

<a name="name"></a>

# Name

gdb-add-index - Add index files to speed up GDB

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" gdb-add-index filename
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
When \s-1GDB\s0 finds a symbol file, it scans the symbols in the
file in order to construct an internal symbol table.  This lets most
\s-1GDB\s0 operations work quicklyat the cost of a delay early on.
For large programs, this delay can be quite lengthy, so \s-1GDB\s0
provides a way to build an index, which speeds up startup.

To determine whether a file contains such an index, use the command
\f(CW`readelf -S filename\*(C': the index is stored in a section named
\f(CW`.gdb\_index\*(C'.  The index file can only be produced on systems
which use \s-1ELF\s0 binaries and \s-1DWARF\s0 debug information (i.e., sections
named \f(CW`.debug\_*\*(C').

**gdb-add-index** uses \s-1GDB\s0 and **objdump** found
in the **\s-1PATH\s0** environment variable.  If you want to use different
versions of these programs, you can specify them through the
**\s-1GDB\s0** and **\s-1OBJDUMP\s0** environment variables.

See more in
the \s-1GDB\s0 manual in node \f(CW`Index Files\*(C'
 shell command \f(CW\*(C\`info -f gdb -n "Index Files"\*(C'.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

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
