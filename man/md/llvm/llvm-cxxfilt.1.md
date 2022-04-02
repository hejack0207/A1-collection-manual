# llvm-cxxfilt(1) - LLVM symbol name demangler

11, 2020-10-15

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

```

 llvm-cxxfilt [options] [mangled names...]
```

<a name="description"></a>

# Description


**llvm-cxxfilt** is a symbol demangler that can be used as a replacement
for the GNU **c++filt** tool. It takes a series of symbol names and
prints their demangled form on the standard output stream. If a name cannot be
demangled, it is simply printed as is.

If no names are specified on the command-line, names are read interactively from
the standard input stream. When reading names from standard input, each input
line is split on characters that are not part of valid Itanium name manglings,
i.e. characters that are not alphanumeric, '.', '$', or '_'. Separators between
names are copied to the output as is.

<a name="example"></a>

# Example

.INDENT 0.0
.INDENT 3.5

    .ft C
    $ llvm-cxxfilt _Z3foov _Z3bari not_mangled
    foo()
    bar(int)
    not_mangled
    $ cat input.txt
    | _Z3foov *** _Z3bari *** not_mangled |
    $ llvm-cxxfilt < input.txt
    | foo() *** bar(int) *** not_mangled |
    .ft P
.UNINDENT
.UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **--format=&lt;value&gt;, -s**  
  Mangling scheme to assume. Valid values are **auto** (default, auto-detect the
  style) and **gnu** (assume GNU/Itanium style).
  .UNINDENT
  .INDENT 0.0
* **--help, -h**  
  Print a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **--help-list**  
  Print an uncategorized summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **--no-strip-underscore, -n**  
  Do not strip a leading underscore. This is the default for all platforms
  except Mach-O based hosts.
  .UNINDENT
  .INDENT 0.0
* **--strip-underscore, -_**  
  Strip a single leading underscore, if present, from each input name before
  demangling. On by default on Mach-O based platforms.
  .UNINDENT
  .INDENT 0.0
* **--types, -t**  
  Attempt to demangle names as type names as well as function names.
  .UNINDENT
  .INDENT 0.0
* **--version**  
  Display the version of the **llvm-cxxfilt** executable.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options from response file _&lt;FILE&gt;_.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-cxxfilt** returns 0 unless it encounters a usage error, in which
case a non-zero exit code is returned.

<a name="see-also"></a>

# See Also


**llvm-nm(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

