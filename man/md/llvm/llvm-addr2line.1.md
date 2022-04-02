# llvm-addr2line(1) - a drop-in replacement for addr2line

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

 llvm-addr2line [options]
```

<a name="description"></a>

# Description


**llvm-addr2line** is an alias for the **llvm-symbolizer(1)**
tool with different defaults. The goal is to make it a drop-in replacement for
GNU's **addr2line**.

Here are some of those differences:
.INDENT 0.0

* ·  
  **llvm-addr2line** interprets all addresses as hexadecimal and ignores an
  optional **0x** prefix, whereas **llvm-symbolizer** attempts to determine
  the base from the literal's prefix and defaults to decimal if there is no
  prefix.
* ·  
  **llvm-addr2line** defaults not to print function names. Use _-f_ to enable
  that.
* ·  
  **llvm-addr2line** defaults not to demangle function names. Use _-C_ to
  switch the demangling on.
* ·  
  **llvm-addr2line** defaults not to print inlined frames. Use _-i_ to show
  inlined frames for a source code location in an inlined function.
* ·  
  **llvm-addr2line** uses _--output-style=GNU_ by default.
* ·  
  **llvm-addr2line** parses options from the environment variable
  **LLVM\_ADDR2LINE\_OPTS** instead of from **LLVM\_SYMBOLIZER\_OPTS**.
  .UNINDENT

<a name="see-also"></a>

# See Also


**llvm-symbolizer(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

