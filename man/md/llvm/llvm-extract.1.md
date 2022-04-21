# llvm-extract(1) - extract a function from an LLVM module

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

 llvm-extract [options] --func function-name [filename]
```

<a name="description"></a>

# Description


The **llvm-extract** command takes the name of a function and extracts
it from the specified LLVM bitcode file.  It is primarily used as a debugging
tool to reduce test cases from larger programs that are triggering a bug.

In addition to extracting the bitcode of the specified function,
**llvm-extract** will also remove unreachable global variables,
prototypes, and unused types.

The **llvm-extract** command reads its input from standard input if
filename is omitted or if filename is **-**.  The output is always written to
standard output, unless the **-o** option is specified (see below).

<a name="options"></a>

# Options


**--alias** _alias-name_
.INDENT 0.0
.INDENT 3.5
Extract the alias named _function-name_ from the LLVM bitcode.  May be
specified multiple times to extract multiple alias at once.
.UNINDENT
.UNINDENT

**--ralias** _alias-regular-expr_
.INDENT 0.0
.INDENT 3.5
Extract the alias matching _alias-regular-expr_ from the LLVM bitcode.
All alias matching the regular expression will be extracted.  May be
specified multiple times.
.UNINDENT
.UNINDENT

**--bb** _basic-block-specifier_
.INDENT 0.0
.INDENT 3.5
Extract basic blocks(s) specicified in _basic-block-specifier_. May be
specified multiple times. Each &lt;function:bb[;bb]&gt; specifier pair will create
a function. If multiple basic blocks are specified in one pair, the first
block in the sequence should dominate the rest.
.UNINDENT
.UNINDENT

**--delete**
.INDENT 0.0
.INDENT 3.5
Delete specified Globals from Module.
.UNINDENT
.UNINDENT

**-f**
.INDENT 0.0
.INDENT 3.5
Enable binary output on terminals.  Normally, **llvm-extract** will
refuse to write raw bitcode output if the output stream is a terminal.  With
this option, **llvm-extract** will write raw bitcode regardless of the
output device.
.UNINDENT
.UNINDENT

**--func** _function-name_
.INDENT 0.0
.INDENT 3.5
Extract the function named _function-name_ from the LLVM bitcode.  May be
specified multiple times to extract multiple functions at once.
.UNINDENT
.UNINDENT

**--rfunc** _function-regular-expr_
.INDENT 0.0
.INDENT 3.5
Extract the function(s) matching _function-regular-expr_ from the LLVM bitcode.
All functions matching the regular expression will be extracted.  May be
specified multiple times.
.UNINDENT
.UNINDENT

**--glob** _global-name_
.INDENT 0.0
.INDENT 3.5
Extract the global variable named _global-name_ from the LLVM bitcode.  May be
specified multiple times to extract multiple global variables at once.
.UNINDENT
.UNINDENT

**--rglob** _glob-regular-expr_
.INDENT 0.0
.INDENT 3.5
Extract the global variable(s) matching _global-regular-expr_ from the LLVM
bitcode.  All global variables matching the regular expression will be
extracted.  May be specified multiple times.
.UNINDENT
.UNINDENT

**--keep-const-init**
.INDENT 0.0
.INDENT 3.5
Preserve the values of constant globals.
.UNINDENT
.UNINDENT

**--recursive**
.INDENT 0.0
.INDENT 3.5
Recursively extract all called functions
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
Specify the output filename.  If filename is "-" (the default), then
**llvm-extract** sends its output to standard output.
.UNINDENT
.UNINDENT

**-S**
.INDENT 0.0
.INDENT 3.5
Write output in LLVM intermediate language (instead of bitcode).
.UNINDENT
.UNINDENT

<a name="exit-status"></a>

# Exit Status


If **llvm-extract** succeeds, it will exit with 0.  Otherwise, if an error
occurs, it will exit with a non-zero value.

<a name="see-also"></a>

# See Also


**bugpoint(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

