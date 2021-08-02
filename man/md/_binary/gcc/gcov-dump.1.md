# gcov-dump(1)

gcc-9, 2019-03-12

.if n .ad l
.nh

<a name="name"></a>

# Name

gcov-dump - offline gcda and gcno profile dump tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" gcov-dump [-v|--version]      [-h|--help]      [-l|--long]      [-p|--positions]      gcovfiles
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**gcov-dump** is a tool you can use in conjunction with \s-1GCC\s0 to
dump content of gcda and gcno profile files offline.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-h**  
  .IX Item "-h"
* **--help**  
  .IX Item "--help"
  Display help about using **gcov-dump** (on the standard output), and
  exit without doing any further processing.
* **-l**  
  .IX Item "-l"
* **--long**  
  .IX Item "--long"
  Dump content of records.
* **-p**  
  .IX Item "-p"
* **--positions**  
  .IX Item "--positions"
  Dump positions of records.
* **-v**  
  .IX Item "-v"
* **--version**  
  .IX Item "--version"
  Display the **gcov-dump** version number (on the standard output),
  and exit without doing any further processing.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 2017-2019 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation; with the
Invariant Sections being \s-1GNU\s0 General Public License\*(R" and \*(L"Funding
Free Software, the Front-Cover texts being (a) (see below), and with
the Back-Cover Texts being (b) (see below).  A copy of the license is
included in the **gfdl**\|(7) man page.

(a) The \s-1FSF\s0's Front-Cover Text is:

.Vb 1
     A GNU Manual
.Ve

(b) The \s-1FSF\s0's Back-Cover Text is:

.Vb 3
     You have freedom to copy and modify this GNU Manual, like GNU
     software.  Copies published by the Free Software Foundation raise
     funds for GNU development.
.Ve
