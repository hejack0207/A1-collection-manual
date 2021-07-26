# gdbinit(5)

gdb-Fedora 8.2.91.20190401-23.fc30, 2019-04-01

.if n .ad l
.nh

<a name="name"></a>

# Name

gdbinit - GDB initialization scripts

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" /etc/gdbinit 
 ~/.gdbinit 
 ./.gdbinit
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
These files contain \s-1GDB\s0 commands to automatically execute during
\s-1GDB\s0 startup.  The lines of contents are canned sequences of commands,
described in
the \s-1GDB\s0 manual in node \f(CW`Sequences\*(C'
 shell command \f(CW\*(C\`info -f gdb -n Sequences\*(C'.

Please read more in
the \s-1GDB\s0 manual in node \f(CW`Startup\*(C'
 shell command \f(CW\*(C\`info -f gdb -n Startup\*(C'.

* **/etc/gdbinit**  
  .IX Item "/etc/gdbinit"
  System-wide initialization file.  It is executed unless user specified
  \s-1GDB\s0 option \f(CW`-nx\*(C' or \f(CW\*(C\`-n\*(C'.
  See more in
  the \s-1GDB\s0 manual in node \f(CW`System-wide configuration\*(C'
   shell command \f(CW\*(C\`info -f gdb -n \*(AqSystem-wide configuration\*(Aq\*(C'.
* **~/.gdbinit**  
  .IX Item "~/.gdbinit"
  User initialization file.  It is executed unless user specified
  \s-1GDB\s0 options \f(CW`-nx\*(C', \f(CW\*(C\`-n\*(C' or \f(CW\*(C\`-nh\*(C'.
* **./.gdbinit**  
  .IX Item "./.gdbinit"
  Initialization file for current directory.  It may need to be enabled with
  \s-1GDB\s0 security command \f(CW`set auto-load local-gdbinit\*(C'.
  See more in
  the \s-1GDB\s0 manual in node \f(CW`Init File in the Current Directory\*(C'
   shell command \f(CW\*(C\`info -f gdb -n \*(AqInit File in the Current Directory\*(Aq\*(C'.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**gdb**\|(1), \f(CW`info -f gdb -n Startup\*(C'

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
