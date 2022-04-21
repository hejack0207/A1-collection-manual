# llvm-as(1) - LLVM assembler

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

 llvm-as [options] [filename]
```

<a name="description"></a>

# Description


**llvm-as** is the LLVM assembler.  It reads a file containing human-readable
LLVM assembly language, translates it to LLVM bitcode, and writes the result
into a file or to standard output.

If _filename_ is omitted or is **-**, then **llvm-as** reads its input from
standard input.

If an output file is not specified with the **-o** option, then
**llvm-as** sends its output to a file or standard output by following
these rules:
.INDENT 0.0

* ·  
  If the input is standard input, then the output is standard output.
* ·  
  If the input is a file that ends with **.ll**, then the output file is of the
  same name, except that the suffix is changed to **.bc**.
* ·  
  If the input is a file that does not end with the **.ll** suffix, then the
  output file has the same name as the input file, except that the **.bc**
  suffix is appended.
  .UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **-f**  
  Enable binary output on terminals.  Normally, **llvm-as** will refuse to
  write raw bitcode output if the output stream is a terminal. With this option,
  **llvm-as** will write raw bitcode regardless of the output device.
* **-help**  
  Print a summary of command line options.
* **-o** _filename_  
  Specify the output file name.  If _filename_ is **-**, then **llvm-as**
  sends its output to standard output.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


If **llvm-as** succeeds, it will exit with 0.  Otherwise, if an error occurs, it
will exit with a non-zero value.

<a name="see-also"></a>

# See Also


**llvm-dis(1)**, as(1)

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

