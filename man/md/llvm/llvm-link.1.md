# llvm-link(1) - LLVM bitcode linker

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

 llvm-link [options] filename ...
```

<a name="description"></a>

# Description


**llvm-link** takes several LLVM bitcode files and links them together
into a single LLVM bitcode file.  It writes the output file to standard output,
unless the _-o_ option is used to specify a filename.

<a name="options"></a>

# Options

.INDENT 0.0

* **-f**  
  Enable binary output on terminals.  Normally, **llvm-link** will refuse
  to write raw bitcode output if the output stream is a terminal. With this
  option, **llvm-link** will write raw bitcode regardless of the output
  device.
  .UNINDENT
  .INDENT 0.0
* **-o filename**  
  Specify the output file name.  If **filename** is "**-**", then
  **llvm-link** will write its output to standard output.
  .UNINDENT
  .INDENT 0.0
* **-S**  
  Write output in LLVM intermediate language (instead of bitcode).
  .UNINDENT
  .INDENT 0.0
* **-d**  
  If specified, **llvm-link** prints a human-readable version of the
  output bitcode file to standard error.
  .UNINDENT
  .INDENT 0.0
* **-help**  
  Print a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **-v**  
  Verbose mode.  Print information about what **llvm-link** is doing.
  This typically includes a message for each bitcode file linked in and for each
  library found.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


If **llvm-link** succeeds, it will exit with 0.  Otherwise, if an error
occurs, it will exit with a non-zero value.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

