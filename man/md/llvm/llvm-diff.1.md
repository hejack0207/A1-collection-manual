# llvm-diff(1) - LLVM structural 'diff'

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

 llvm-diff [options] module 1 module 2 [global name ...]
```

<a name="description"></a>

# Description


**llvm-diff** compares the structure of two LLVM modules, primarily
focusing on differences in function definitions.  Insignificant
differences, such as changes in the ordering of globals or in the
names of local values, are ignored.

An input module will be interpreted as an assembly file if its name
ends in '.ll';  otherwise it will be read in as a bitcode file.

If a list of global names is given, just the values with those names
are compared; otherwise, all global values are compared, and
diagnostics are produced for globals which only appear in one module
or the other.

**llvm-diff** compares two functions by comparing their basic blocks,
beginning with the entry blocks.  If the terminators seem to match,
then the corresponding successors are compared; otherwise they are
ignored.  This algorithm is very sensitive to changes in control flow,
which tend to stop any downstream changes from being detected.

**llvm-diff** is intended as a debugging tool for writers of LLVM
passes and frontends.  It does not have a stable output format.

<a name="exit-status"></a>

# Exit Status


If **llvm-diff** finds no differences between the modules, it will exit
with 0 and produce no output.  Otherwise it will exit with a non-zero
value.

<a name="bugs"></a>

# Bugs


Many important differences, like changes in linkage or function
attributes, are not diagnosed.

Changes in memory behavior (for example, coalescing loads) can cause
massive detected differences in blocks.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

