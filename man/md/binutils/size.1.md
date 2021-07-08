# size(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

size - list section sizes and total size.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" size [-A|-B|--format=compatibility]      [--help]      [-d|-o|-x|--radix=number]      [--common]      [-t|--totals]      [--target=bfdname] [-V|--version]      [objfile...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The \s-1GNU\s0 **size** utility lists the section sizes---and the total
size---for each of the object or archive files _objfile_ in its
argument list.  By default, one line of output is generated for each
object file or each module in an archive.

_objfile_... are the object files to be examined.
If none are specified, the file \f(CW`a.out\*(C' will be used.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The command line options have the following meanings:

* **-A**  
  .IX Item "-A"
* **-B**  
  .IX Item "-B"
* **--format=**_compatibility_  
  .IX Item "--format=compatibility"
  Using one of these options, you can choose whether the output from \s-1GNU\s0
  **size** resembles output from System V **size** (using **-A**,
  or **--format=sysv**), or Berkeley **size** (using **-B**, or
  **--format=berkeley**).  The default is the one-line format similar to
  Berkeley's.
  .Sp
  Here is an example of the Berkeley (default) format of output from
  **size**:
  .Sp
  .Vb 4
          $ size --format=Berkeley ranlib size
          text    data    bss     dec     hex     filename
          294880  81920   11592   388392  5ed28   ranlib
          294880  81920   11888   388688  5ee50   size
  .Ve
  .Sp
  This is the same data, but displayed closer to System V conventions:
  .Sp
  .Vb 7
          $ size --format=SysV ranlib size
          ranlib  :
          section         size         addr
          .text         294880         8192
          .data          81920       303104
          .bss           11592       385024
          Total         388392
          
          
          size  :
          section         size         addr
          .text         294880         8192
          .data          81920       303104
          .bss           11888       385024
          Total         388688
  .Ve
* **--help**  
  .IX Item "--help"
  Show a summary of acceptable arguments and options.
* **-d**  
  .IX Item "-d"
* **-o**  
  .IX Item "-o"
* **-x**  
  .IX Item "-x"
* **--radix=**_number_  
  .IX Item "--radix=number"
  Using one of these options, you can control whether the size of each
  section is given in decimal (**-d**, or **--radix=10**); octal
  (**-o**, or **--radix=8**); or hexadecimal (**-x**, or
  **--radix=16**).  In **--radix=**_number_, only the three
  values (8, 10, 16) are supported.  The total size is always given in two
  radices; decimal and hexadecimal for **-d** or **-x** output, or
  octal and hexadecimal if you're using **-o**.
* **--common**  
  .IX Item "--common"
  Print total size of common symbols in each file.  When using Berkeley
  format these are included in the bss size.
* **-t**  
  .IX Item "-t"
* **--totals**  
  .IX Item "--totals"
  Show totals of all objects listed (Berkeley format listing mode only).
* **--target=**_bfdname_  
  .IX Item "--target=bfdname"
  Specify that the object-code format for _objfile_ is
  _bfdname_.  This option may not be necessary; **size** can
  automatically recognize many formats.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display the version number of **size**.
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
_ar_\|(1), _objdump_\|(1), _readelf_\|(1), and the Info entries for _binutils_.

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
