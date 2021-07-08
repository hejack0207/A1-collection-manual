# ranlib(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

ranlib - generate index to archive.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" ranlib [--plugin name] [-DhHvVt] archive
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**ranlib** generates an index to the contents of an archive and
stores it in the archive.  The index lists each symbol defined by a
member of an archive that is a relocatable object file.

You may use **nm -s** or **nm --print-armap** to list this index.

An archive with such an index speeds up linking to the library and
allows routines in the library to call each other without regard to
their placement in the archive.

The \s-1GNU\s0 **ranlib** program is another form of \s-1GNU\s0 **ar**; running
**ranlib** is completely equivalent to executing **ar -s**.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-h**  
  .IX Item "-h"
* **-H**  
  .IX Item "-H"
* **--help**  
  .IX Item "--help"
  Show usage information for **ranlib**.
* **-v**  
  .IX Item "-v"
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Show the version number of **ranlib**.
* **-D**  
  .IX Item "-D"
  Operate in _deterministic_ mode.  The symbol map archive member's
  header will show zero for the \s-1UID, GID,\s0 and timestamp.  When this
  option is used, multiple runs will produce identical output files.
  .Sp
  If _binutils_ was configured with
  **--enable-deterministic-archives**, then this mode is on by
  default.  It can be disabled with the **-U** option, described
  below.
* **-t**  
  .IX Item "-t"
  Update the timestamp of the symbol map of an archive.
* **-U**  
  .IX Item "-U"
  Do _not_ operate in _deterministic_ mode.  This is the
  inverse of the **-D** option, above: the archive index will get
  actual \s-1UID, GID,\s0 timestamp, and file mode values.
  .Sp
  If _binutils_ was configured _without_
  **--enable-deterministic-archives**, then this mode is on by
  default.
* **@**_file_  
  .IX Item "@file"
  Read command-line options from _file_.  The options read are
  inserted in place of the original @_file_ option.  If _file_
  does not exist, or cannot be read, then the option will be treated
  literally, and not removed.
  .Sp
  Options in _file_ are separated by whitespace.  A whitespace
  character may be included in an option by surrounding the entire
  option in either single or double quotes.  Any character (including a
  backslash) may be included by prefixing the character to be included
  with a backslash.  The _file_ may itself contain additional
  @_file_ options; any such options will be processed recursively.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
_ar_\|(1), _nm_\|(1), and the Info entries for _binutils_.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1991-2018 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, with no Front-Cover Texts, and with no
Back-Cover Texts.  A copy of the license is included in the
section entitled \s-1GNU\s0 Free Documentation License\*(R".
