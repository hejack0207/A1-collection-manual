# llvm-ranlib(1) - generates an archive index

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

 llvm-ranlib [options]
```

<a name="description"></a>

# Description


**llvm-ranlib** is an alias for the llvm-ar tool that
generates an index for an archive. It can be used as a replacement for GNU's
**ranlib** tool.

Running **llvm-ranlib** is equivalent to running **llvm-ar s**.

<a name="see-also"></a>

# See Also


**llvm-ar(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

