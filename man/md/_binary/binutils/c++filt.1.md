# c++filt(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

c++filt - Demangle C++ and Java symbols.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" c++filt [-_|--strip-underscore]         [-n|--no-strip-underscore]         [-p|--no-params]         [-t|--types]         [-i|--no-verbose]         [-s format|--format=format]         [--help]  [--version]  [symbol...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The  and Java languages provide function overloading, which means
that you can write many functions with the same name, providing that
each function takes parameters of different types.  In order to be
able to distinguish these similarly named functions  and Java
encode them into a low-level assembler name which uniquely identifies
each different version.  This process is known as _mangling_. The
**c++filt**
[1]
program does the inverse mapping: it decodes (_demangles_) low-level
names into user-level names so that they can be read.

Every alphanumeric word (consisting of letters, digits, underscores,
dollars, or periods) seen in the input is a potential mangled name.
If the name decodes into a  name, the \*(C+ name replaces the
low-level name in the output, otherwise the original word is output.
In this way you can pass an entire assembler source file, containing
mangled names, through **c++filt** and see the same source file
containing demangled names.

You can also use **c++filt** to decipher individual symbols by
passing them on the command line:

.Vb 1
        c++filt &lt;symbol&gt;
.Ve

If no _symbol_ arguments are given, **c++filt** reads symbol
names from the standard input instead.  All the results are printed on
the standard output.  The difference between reading names from the
command line versus reading names from the standard input is that
command line arguments are expected to be just mangled names and no
checking is performed to separate them from surrounding text.  Thus
for example:

.Vb 1
        c++filt -n _Z1fv
.Ve

will work and demangle the name to f()\*(R" whereas:

.Vb 1
        c++filt -n _Z1fv,
.Ve

will not work.  (Note the extra comma at the end of the mangled
name which makes it invalid).  This command however will work:

.Vb 1
        echo _Z1fv, | c++filt -n
.Ve

and will display f(),\*(R", i.e., the demangled name followed by a
trailing comma.  This behaviour is because when the names are read
from the standard input it is expected that they might be part of an
assembler source file where there might be extra, extraneous
characters trailing after a mangled name.  For example:

.Vb 1
            .type   _Z1fv, @function
.Ve

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-\_**  
  .IX Item "-_"
* **--strip-underscore**  
  .IX Item "--strip-underscore"
  On some systems, both the C and  compilers put an underscore in front
  of every name.  For example, the C name \f(CW`foo\*(C' gets the low-level
  name \f(CW`\_foo\*(C'.  This option removes the initial underscore.  Whether
  **c++filt** removes the underscore by default is target dependent.
* **-n**  
  .IX Item "-n"
* **--no-strip-underscore**  
  .IX Item "--no-strip-underscore"
  Do not remove the initial underscore.
* **-p**  
  .IX Item "-p"
* **--no-params**  
  .IX Item "--no-params"
  When demangling the name of a function, do not display the types of
  the function's parameters.
* **-t**  
  .IX Item "-t"
* **--types**  
  .IX Item "--types"
  Attempt to demangle types as well as function names.  This is disabled
  by default since mangled types are normally only used internally in
  the compiler, and they can be confused with non-mangled names.  For example,
  a function called a\*(R" treated as a mangled type name would be
  demangled to signed char\*(R".
* **-i**  
  .IX Item "-i"
* **--no-verbose**  
  .IX Item "--no-verbose"
  Do not include implementation details (if any) in the demangled
  output.
* **-s** _format_  
  .IX Item "-s format"
* **--format=**_format_  
  .IX Item "--format=format"
  **c++filt** can decode various methods of mangling, used by
  different compilers.  The argument to this option selects which
  method it uses:
      .ie n .IP """auto""" 4
      .el .IP "\f(CWauto" 4
      .IX Item "auto"
      Automatic selection based on executable (the default method)
      .ie n .IP """gnu""" 4
      .el .IP "\f(CWgnu" 4
      .IX Item "gnu"
      the one used by the \s-1GNU \s0 compiler (g++)
      .ie n .IP """lucid""" 4
      .el .IP "\f(CWlucid" 4
      .IX Item "lucid"
      the one used by the Lucid compiler (lcc)
      .ie n .IP """arm""" 4
      .el .IP "\f(CWarm" 4
      .IX Item "arm"
      the one specified by the  Annotated Reference Manual
      .ie n .IP """hp""" 4
      .el .IP "\f(CWhp" 4
      .IX Item "hp"
      the one used by the \s-1HP\s0 compiler (aCC)
      .ie n .IP """edg""" 4
      .el .IP "\f(CWedg" 4
      .IX Item "edg"
      the one used by the \s-1EDG\s0 compiler
      .ie n .IP """gnu-v3""" 4
      .el .IP "\f(CWgnu-v3" 4
      .IX Item "gnu-v3"
      the one used by the \s-1GNU \s0 compiler (g++) with the V3 \s-1ABI.\s0
      .ie n .IP """java""" 4
      .el .IP "\f(CWjava" 4
      .IX Item "java"
      the one used by the \s-1GNU\s0 Java compiler (gcj)
      .ie n .IP """gnat""" 4
      .el .IP "\f(CWgnat" 4
      .IX Item "gnat"
      the one used by the \s-1GNU\s0 Ada compiler (\s-1GNAT\s0).
* **--help**  
  .IX Item "--help"
  Print a summary of the options to **c++filt** and exit.
* **--version**  
  .IX Item "--version"
  Print the version number of **c++filt** and exit.
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

<a name="footnotes"></a>

# Footnotes

.IX Header "FOOTNOTES"

* 1.  
  MS-DOS does not allow \f(CW`+\*(C' characters in file names, so on
  MS-DOS this program is named **\s-1CXXFILT\s0**.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
the Info entries for _binutils_.

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
