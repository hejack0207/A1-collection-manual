# llvm-build(1) - LLVM Project Build Utility

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

 llvm-build [options]
```

<a name="description"></a>

# Description


**llvm-build** is a tool for working with LLVM projects that use the LLVMBuild
system for describing their components.

At heart, **llvm-build** is responsible for loading, verifying, and manipulating
the project's component data. The tool is primarily designed for use in
implementing build systems and tools which need access to the project structure
information.

<a name="options"></a>

# Options


**-h**, **--help**
.INDENT 0.0
.INDENT 3.5
Print the builtin program help.
.UNINDENT
.UNINDENT

**--source-root**=_PATH_
.INDENT 0.0
.INDENT 3.5
If given, load the project at the given source root path. If this option is not
given, the location of the project sources will be inferred from the location of
the **llvm-build** script itself.
.UNINDENT
.UNINDENT

**--print-tree**
.INDENT 0.0
.INDENT 3.5
Print the component tree for the project.
.UNINDENT
.UNINDENT

**--write-library-table**
.INDENT 0.0
.INDENT 3.5
Write out the C++ fragment which defines the components, library names, and
required libraries. This C++ fragment is built into llvm-config|llvm-config
in order to provide clients with the list of required libraries for arbitrary
component combinations.
.UNINDENT
.UNINDENT

**--write-llvmbuild**
.INDENT 0.0
.INDENT 3.5
Write out new _LLVMBuild.txt_ files based on the loaded components. This is
useful for auto-upgrading the schema of the files. **llvm-build** will try to a
limited extent to preserve the comments which were written in the original
source file, although at this time it only preserves block comments that precede
the section names in the _LLVMBuild_ files.
.UNINDENT
.UNINDENT

**--write-cmake-fragment**
.INDENT 0.0
.INDENT 3.5
Write out the LLVMBuild in the form of a CMake fragment, so it can easily be
consumed by the CMake based build system. The exact contents and format of this
file are closely tied to how LLVMBuild is integrated with CMake, see LLVM's
top-level CMakeLists.txt.
.UNINDENT
.UNINDENT

**--write-make-fragment**
.INDENT 0.0
.INDENT 3.5
Write out the LLVMBuild in the form of a Makefile fragment, so it can easily be
consumed by a Make based build system. The exact contents and format of this
file are closely tied to how LLVMBuild is integrated with the Makefiles, see
LLVM's Makefile.rules.
.UNINDENT
.UNINDENT

**--llvmbuild-source-root**=_PATH_
.INDENT 0.0
.INDENT 3.5
If given, expect the _LLVMBuild_ files for the project to be rooted at the
given path, instead of inside the source tree itself. This option is primarily
designed for use in conjunction with **--write-llvmbuild** to test changes to
_LLVMBuild_ schema.
.UNINDENT
.UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-build** exits with 0 if operation was successful. Otherwise, it will exist
with a non-zero value.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

