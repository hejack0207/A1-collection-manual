# llvm-dis(1) - LLVM disassembler

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

 llvm-dis [options] [filename]
```

<a name="description"></a>

# Description


The **llvm-dis** command is the LLVM disassembler.  It takes an LLVM
bitcode file and converts it into human-readable LLVM assembly language.

If filename is omitted or specified as **-**, **llvm-dis** reads its
input from standard input.

If the input is being read from standard input, then **llvm-dis**
will send its output to standard output by default.  Otherwise, the
output will be written to a file named after the input file, with
a **.ll** suffix added (any existing **.bc** suffix will first be
removed).  You can override the choice of output file using the
**-o** option.

<a name="options"></a>

# Options


**-f**
.INDENT 0.0
.INDENT 3.5
Enable binary output on terminals.  Normally, **llvm-dis** will refuse to
write raw bitcode output if the output stream is a terminal. With this option,
**llvm-dis** will write raw bitcode regardless of the output device.
.UNINDENT
.UNINDENT

**-help**
.INDENT 0.0
.INDENT 3.5
Print a summary of command line options.
.UNINDENT
.UNINDENT

**-o** _filename_
.INDENT 0.0
.INDENT 3.5
Specify the output file name.  If _filename_ is -, then the output is sent
to standard output.
.UNINDENT
.UNINDENT

<a name="exit-status"></a>

# Exit Status


If **llvm-dis** succeeds, it will exit with 0.  Otherwise, if an error
occurs, it will exit with a non-zero value.

<a name="see-also"></a>

# See Also


**llvm-as(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

