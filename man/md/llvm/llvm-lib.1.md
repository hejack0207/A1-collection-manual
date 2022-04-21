# llvm-lib(1) - LLVM lib.exe compatible library tool

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

 llvm-lib [/libpath:<path>] [/out:<output>] [/llvmlibthin] [/ignore] [/machine] [/nologo] [files...]
```

<a name="description"></a>

# Description


The **llvm-lib** command is intended to be a **lib.exe** compatible
tool. See _https://msdn.microsoft.com/en-us/library/7ykb2k5f_ for the
general description.

**llvm-lib** has the following extensions:
.INDENT 0.0

* ·  
  Bitcode files in symbol tables.
  **llvm-lib** includes symbols from both bitcode files and regular
  object files in the symbol table.
* ·  
  Creating thin archives.
  The /llvmlibthin option causes **llvm-lib** to create thin archive
  that contain only the symbol table and the header for the various
  members. These files are much smaller, but are not compatible with
  link.exe (lld can handle them).
  .UNINDENT

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

