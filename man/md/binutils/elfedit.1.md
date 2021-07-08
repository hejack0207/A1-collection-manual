# elfedit(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

elfedit - Update the ELF header of ELF files.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" elfedit [--input-mach=machine]         [--input-type=type]         [--input-osabi=osabi]         --output-mach=machine         --output-type=type         --output-osabi=osabi         [-v|--version]         [-h|--help]         elffile...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**elfedit** updates the \s-1ELF\s0 header of \s-1ELF\s0 files which have
the matching \s-1ELF\s0 machine and file types.  The options control how and
which fields in the \s-1ELF\s0 header should be updated.

_elffile_... are the \s-1ELF\s0 files to be updated.  32-bit and
64-bit \s-1ELF\s0 files are supported, as are archives containing \s-1ELF\s0 files.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The long and short forms of options, shown here as alternatives, are
equivalent. At least one of the **--output-mach**,
**--output-type** and **--output-osabi** options must be given.

* **--input-mach=**_machine_  
  .IX Item "--input-mach=machine"
  Set the matching input \s-1ELF\s0 machine type to _machine_.  If
  **--input-mach** isn't specified, it will match any \s-1ELF\s0
  machine types.
  .Sp
  The supported \s-1ELF\s0 machine types are, _i386_, _\s-1IAMCU\s0_, _L1OM_,
  _K1OM_ and _x86-64_.
* **--output-mach=**_machine_  
  .IX Item "--output-mach=machine"
  Change the \s-1ELF\s0 machine type in the \s-1ELF\s0 header to _machine_.  The
  supported \s-1ELF\s0 machine types are the same as **--input-mach**.
* **--input-type=**_type_  
  .IX Item "--input-type=type"
  Set the matching input \s-1ELF\s0 file type to _type_.  If
  **--input-type** isn't specified, it will match any \s-1ELF\s0 file types.
  .Sp
  The supported \s-1ELF\s0 file types are, _rel_, _exec_ and _dyn_.
* **--output-type=**_type_  
  .IX Item "--output-type=type"
  Change the \s-1ELF\s0 file type in the \s-1ELF\s0 header to _type_.  The
  supported \s-1ELF\s0 types are the same as **--input-type**.
* **--input-osabi=**_osabi_  
  .IX Item "--input-osabi=osabi"
  Set the matching input \s-1ELF\s0 file \s-1OSABI\s0 to _osabi_.  If
  **--input-osabi** isn't specified, it will match any \s-1ELF\s0 OSABIs.
  .Sp
  The supported \s-1ELF\s0 OSABIs are, _none_, _\s-1HPUX\s0_, _NetBSD_,
  _\s-1GNU\s0_, _Linux_ (alias for _\s-1GNU\s0_),
  _Solaris_, _\s-1AIX\s0_, _Irix_,
  _FreeBSD_, _\s-1TRU64\s0_, _Modesto_, _OpenBSD_, _OpenVMS_,
  _\s-1NSK\s0_, _\s-1AROS\s0_ and _FenixOS_.
* **--output-osabi=**_osabi_  
  .IX Item "--output-osabi=osabi"
  Change the \s-1ELF OSABI\s0 in the \s-1ELF\s0 header to _osabi_.  The
  supported \s-1ELF OSABI\s0 are the same as **--input-osabi**.
* **-v**  
  .IX Item "-v"
* **--version**  
  .IX Item "--version"
  Display the version number of **elfedit**.
* **-h**  
  .IX Item "-h"
* **--help**  
  .IX Item "--help"
  Display the command line options understood by **elfedit**.
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
_readelf_\|(1), and the Info entries for _binutils_.

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
