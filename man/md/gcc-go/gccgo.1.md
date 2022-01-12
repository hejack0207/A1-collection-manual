# gccgo(1)

gcc-10, 2021-04-22

.if n .ad l
.nh

<a name="name"></a>

# Name

gccgo - A GCC-based compiler for the Go language

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" gccgo [-c|-S]       [-g] [-pg] [-Olevel]       [-Idir...] [-Ldir...]       [-o outfile] infile... 
 Only the most useful options are listed here; see below for the remainder.
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **gccgo** command is a frontend to **gcc** and
supports many of the same options.    This manual
only documents the options specific to **gccgo**.

The **gccgo** command may be used to compile Go source code into
an object file, link a collection of object files together, or do both
in sequence.

Go source code is compiled as packages.  A package consists of one or
more Go source files.  All the files in a single package must be
compiled together, by passing all the files as arguments to
**gccgo**.  A single invocation of **gccgo** may only
compile a single package.

One Go package may \f(CW`import\*(C' a different Go package.  The imported
package must have already been compiled; **gccgo** will read
the import data directly from the compiled package.  When this package
is later linked, the compiled form of the package must be included in
the link command.

Go programs must generally be compiled with debugging information, and
**-g1** is the default as described below.  Stripping a Go
program will generally cause it to misbehave or fail.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-I**_dir_  
  .IX Item "-Idir"
  Specify a directory to use when searching for an import package at
  compile time.
* **-L**_dir_  
  .IX Item "-Ldir"
  When linking, specify a library search directory, as with
  **gcc**.
* **-fgo-pkgpath=**_string_  
  .IX Item "-fgo-pkgpath=string"
  Set the package path to use.  This sets the value returned by the
  PkgPath method of reflect.Type objects.  It is also used for the names
  of globally visible symbols.  The argument to this option should
  normally be the string that will be used to import this package after
  it has been installed; in other words, a pathname within the
  directories specified by the **-I** option.
* **-fgo-prefix=**_string_  
  .IX Item "-fgo-prefix=string"
  An alternative to **-fgo-pkgpath**.  The argument will be
  combined with the package name from the source file to produce the
  package path.  If **-fgo-pkgpath** is used, **-fgo-prefix**
  will be ignored.
  .Sp
  Go permits a single program to include more than one package with the
  same name in the \f(CW`package\*(C' clause in the source file, though
  obviously the two packages must be imported using different pathnames.
  In order for this to work with **gccgo**, either
  **-fgo-pkgpath** or **-fgo-prefix** must be specified when
  compiling a package.
  .Sp
  Using either **-fgo-pkgpath** or **-fgo-prefix** disables
  the special treatment of the \f(CW`main\*(C' package and permits that
  package to be imported like any other.
* **-fgo-relative-import-path=**_dir_  
  .IX Item "-fgo-relative-import-path=dir"
  A relative import is an import that starts with _./_ or
  _../_.  If this option is used, **gccgo** will use
  _dir_ as a prefix for the relative import when searching for it.
* **-frequire-return-statement**  
  .IX Item "-frequire-return-statement"
* **-fno-require-return-statement**  
  .IX Item "-fno-require-return-statement"
  By default **gccgo** will warn about functions which have one or
  more return parameters but lack an explicit \f(CW`return\*(C' statement.
  This warning may be disabled using
  **-fno-require-return-statement**.
* **-fgo-check-divide-zero**  
  .IX Item "-fgo-check-divide-zero"
  Add explicit checks for division by zero.  In Go a division (or
  modulos) by zero causes a panic.  On Unix systems this is detected in
  the runtime by catching the \f(CW`SIGFPE\*(C' signal.  Some processors,
  such as PowerPC, do not generate a \s-1SIGFPE\s0 on division by zero.  Some
  runtimes do not generate a signal that can be caught.  On those
  systems, this option may be used.  Or the checks may be removed via
  **-fno-go-check-divide-zero**.  This option is currently on by
  default, but in the future may be off by default on systems that do
  not require it.
* **-fgo-check-divide-overflow**  
  .IX Item "-fgo-check-divide-overflow"
  Add explicit checks for division overflow.  For example, division
  overflow occurs when computing \f(CW`INT_MIN / -1\*(C'.  In Go this should
  be wrapped, to produce \f(CW`INT\_MIN\*(C'.  Some processors, such as x86,
  generate a trap on division overflow.  On those systems, this option
  may be used.  Or the checks may be removed via
  **-fno-go-check-divide-overflow**.  This option is currently on
  by default, but in the future may be off by default on systems that do
  not require it.
* **-fno-go-optimize-allocs**  
  .IX Item "-fno-go-optimize-allocs"
  Disable escape analysis, which tries to allocate objects on the stack
  rather than the heap.
* **-fgo-debug-escape**_n_  
  .IX Item "-fgo-debug-escapen"
  Output escape analysis debugging information.  Larger values of
  _n_ generate more information.
* **-fgo-debug-escape-hash=**_n_  
  .IX Item "-fgo-debug-escape-hash=n"
  A hash value to debug escape analysis.  _n_ is a binary string.
  This runs escape analysis only on functions whose names hash to values
  that match the given suffix _n_.  This can be used to binary
  search across functions to uncover escape analysis bugs.
* **-fgo-debug-optimization**  
  .IX Item "-fgo-debug-optimization"
  Output optimization diagnostics.
* **-fgo-c-header=**_file_  
  .IX Item "-fgo-c-header=file"
  Write top-level named Go struct definitions to _file_ as C code.
  This is used when compiling the runtime package.
* **-fgo-compiling-runtime**  
  .IX Item "-fgo-compiling-runtime"
  Apply special rules for compiling the runtime package.  Implicit
  memory allocation is forbidden.  Some additional compiler directives
  are supported.
* **-g**  
  .IX Item "-g"
  This is the standard **gcc** option.  It
  is mentioned here because by default **gccgo** turns on
  debugging information generation with the equivalent of the standard
  option **-g1**.  This is because Go programs require debugging
  information to be available in order to get backtrace information.  An
  explicit **-g0** may be used to disable the generation of
  debugging information, in which case certain standard library
  functions, such as \f(CW`runtime.Callers\*(C', will not operate correctly.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**gpl**\|(7), **gfdl**\|(7), **fsf-funding**\|(7), **gcc**\|(1)
and the Info entries for _gccgo_ and _gcc_.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 2010-2020 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation; with no
Invariant Sections, the Front-Cover Texts being (a) (see below), and
with the Back-Cover Texts being (b) (see below).
A copy of the license is included in the
man page **gfdl**\|(7).

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
