# llvm-cxxmap(1) - Mangled name remapping tool

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

 llvm-cxxmap [options] symbol-file-1 symbol-file-2
```

<a name="description"></a>

# Description


The **llvm-cxxmap** tool performs fuzzy matching of C++ mangled names,
based on a file describing name components that should be considered equivalent.

The symbol files should contain a list of C++ mangled names (one per line).
Blank lines and lines starting with **#** are ignored. The output is a list
of pairs of equivalent symbols, one per line, of the form
.INDENT 0.0
.INDENT 3.5

    .ft C
    <symbol-1> <symbol-2>
    .ft P
.UNINDENT
.UNINDENT

where **&lt;symbol-1&gt;** is a symbol from _symbol-file-1_ and **&lt;symbol-2&gt;** is
a symbol from _symbol-file-2_. Mappings for which the two symbols are identical
are omitted.

<a name="options"></a>

# Options

.INDENT 0.0

* **-remapping-file=file, -r=file**  
  Specify a file containing a list of equivalence rules that should be used
  to determine whether two symbols are equivalent. Required.
  See _REMAPPING FILE_.
  .UNINDENT
  .INDENT 0.0
* **-output=file, -o=file**  
  Specify a file to write the list of matched names to. If unspecified, the
  list will be written to stdout.
  .UNINDENT
  .INDENT 0.0
* **-Wambiguous**  
  Produce a warning if there are multiple equivalent (but distinct) symbols in
  _symbol-file-2_.
  .UNINDENT
  .INDENT 0.0
* **-Wincomplete**  
  Produce a warning if _symbol-file-1_ contains a symbol for which there is no
  equivalent symbol in _symbol-file-2_.
  .UNINDENT

<a name="remapping-file"></a>

# Remapping File


The remapping file is a text file containing lines of the form
.INDENT 0.0
.INDENT 3.5

    .ft C
    fragmentkind fragment1 fragment2
    .ft P
.UNINDENT
.UNINDENT

where **fragmentkind** is one of **name**, **type**, or **encoding**,
indicating whether the following mangled name fragments are
&lt;_name_&gt;s,
&lt;_type_&gt;s, or
&lt;_encoding_&gt;s,
respectively.
Blank lines and lines starting with **#** are ignored.

Unmangled C names can be expressed as an **encoding** that is a (length-prefixed)
&lt;_source-name_&gt;:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # C function "void foo_bar()" is remapped to C++ function "void foo::bar()".
    encoding 7foo_bar _Z3foo3barv
    .ft P
.UNINDENT
.UNINDENT

For convenience, built-in &lt;substitution&gt;s such as **St** and **Ss**
are accepted as &lt;name&gt;s (even though they technically are not &lt;name&gt;s).

For example, to specify that **absl::string\_view** and **std::string\_view**
should be treated as equivalent, the following remapping file could be used:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # absl::string_view is considered equivalent to std::string_view
    type N4absl11string_viewE St17basic_string_viewIcSt11char_traitsIcEE
    
    # std:: might be std::__1:: in libc++ or std::__cxx11:: in libstdc++
    name St St3__1
    name St St7__cxx11
    .ft P
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Symbol remapping is currently only supported for C++ mangled names
following the Itanium C++ ABI mangling scheme. This covers all C++ targets
supported by Clang other than Windows targets.
.UNINDENT
.UNINDENT

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

