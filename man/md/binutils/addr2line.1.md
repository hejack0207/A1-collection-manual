# addr2line(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

addr2line - convert addresses into file names and line numbers.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" addr2line [-a|--addresses]           [-b bfdname|--target=bfdname]           [-C|--demangle[=style]]           [-e filename|--exe=filename]           [-f|--functions] [-s|--basename]           [-i|--inlines]           [-p|--pretty-print]           [-j|--section=name]           [-H|--help] [-V|--version]           [addr addr ...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**addr2line** translates addresses into file names and line numbers.
Given an address in an executable or an offset in a section of a relocatable
object, it uses the debugging information to figure out which file name and
line number are associated with it.

The executable or relocatable object to use is specified with the **-e**
option.  The default is the file _a.out_.  The section in the relocatable
object to use is specified with the **-j** option.

**addr2line** has two modes of operation.

In the first, hexadecimal addresses are specified on the command line,
and **addr2line** displays the file name and line number for each
address.

In the second, **addr2line** reads hexadecimal addresses from
standard input, and prints the file name and line number for each
address on standard output.  In this mode, **addr2line** may be used
in a pipe to convert dynamically chosen addresses.

The format of the output is **\s-1FILENAME:LINENO\s0**.  By default
each input address generates one line of output.

Two options can generate additional lines before each
**\s-1FILENAME:LINENO\s0** line (in that order).

If the **-a** option is used then a line with the input address
is displayed.

If the **-f** option is used, then a line with the
**\s-1FUNCTIONNAME\s0** is displayed.  This is the name of the function
containing the address.

One option can generate additional lines after the
**\s-1FILENAME:LINENO\s0** line.

If the **-i** option is used and the code at the given address is
present there because of inlining by the compiler then additional
lines are displayed afterwards.  One or two extra lines (if the
**-f** option is used) are displayed for each inlined function.

Alternatively if the **-p** option is used then each input
address generates a single, long, output line containing the address,
the function name, the file name and the line number.  If the
**-i** option has also been used then any inlined functions will
be displayed in the same manner, but on separate lines, and prefixed
by the text **(inlined by)**.

If the file name or function name can not be determined,
**addr2line** will print two question marks in their place.  If the
line number can not be determined, **addr2line** will print 0.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The long and short forms of options, shown here as alternatives, are
equivalent.

* **-a**  
  .IX Item "-a"
* **--addresses**  
  .IX Item "--addresses"
  Display the address before the function name, file and line number
  information.  The address is printed with a **0x** prefix to easily
  identify it.
* **-b** _bfdname_  
  .IX Item "-b bfdname"
* **--target=**_bfdname_  
  .IX Item "--target=bfdname"
  Specify that the object-code format for the object files is
  _bfdname_.
* **-C**  
  .IX Item "-C"
* **--demangle[=**_style_**]**  
  .IX Item "--demangle[=style]"
  Decode (_demangle_) low-level symbol names into user-level names.
  Besides removing any initial underscore prepended by the system, this
  makes  function names readable.  Different compilers have different
  mangling styles. The optional demangling style argument can be used to
  choose an appropriate demangling style for your compiler.
* **-e** _filename_  
  .IX Item "-e filename"
* **--exe=**_filename_  
  .IX Item "--exe=filename"
  Specify the name of the executable for which addresses should be
  translated.  The default file is _a.out_.
* **-f**  
  .IX Item "-f"
* **--functions**  
  .IX Item "--functions"
  Display function names as well as file and line number information.
* **-s**  
  .IX Item "-s"
* **--basenames**  
  .IX Item "--basenames"
  Display only the base of each file name.
* **-i**  
  .IX Item "-i"
* **--inlines**  
  .IX Item "--inlines"
  If the address belongs to a function that was inlined, the source
  information for all enclosing scopes back to the first non-inlined
  function will also be printed.  For example, if \f(CW`main\*(C' inlines
  \f(CW`callee1\*(C' which inlines \f(CW\*(C\`callee2\*(C', and address is from
  \f(CW`callee2\*(C', the source information for \f(CW\*(C\`callee1\*(C' and \f(CW\*(C\`main\*(C'
  will also be printed.
* **-j**  
  .IX Item "-j"
* **--section**  
  .IX Item "--section"
  Read offsets relative to the specified section instead of absolute addresses.
* **-p**  
  .IX Item "-p"
* **--pretty-print**  
  .IX Item "--pretty-print"
  Make the output more human friendly: each location are printed on one line.
  If option **-i** is specified, lines for all enclosing scopes are
  prefixed with **(inlined by)**.
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
Info entries for _binutils_.

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
