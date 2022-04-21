# llvm-lipo(1) - LLVM tool for manipulating universal binaries

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

 llvm-lipo [filenames...] [options]
```

<a name="description"></a>

# Description


**llvm-lipo** can create universal binaries from Mach-O files, extract regular object files from universal binaries, and display architecture information about both universal and regular files.

<a name="commands"></a>

# Commands


**llvm-lipo** supports the following mutually exclusive commands:
.INDENT 0.0

* **-help, -h**  
  Display usage information and exit.
  .UNINDENT
  .INDENT 0.0
* **-version**  
  Display the version of this program.
  .UNINDENT
  .INDENT 0.0
* **-verify_arch &lt;architecture 1&gt; [&lt;architecture 2&gt; ...]**  
  Take a single input file and verify the specified architectures are present in the file.
  If so then exit with a status of 0 else exit with a status of 1.
  .UNINDENT
  .INDENT 0.0
* **-archs**  
  Take a single input file and display the architectures present in the file.
  Each architecture is separated by a single whitespace.
  Unknown architectures are displayed as unknown(CPUtype,CPUsubtype).
  .UNINDENT
  .INDENT 0.0
* **-info**  
  Take at least one input file and display the descriptions of each file.
  The descriptions include the filename and architecture types separated by whitespace.
  Universal binaries are grouped together first, followed by thin files.
  Architectures in the fat file: &lt;filename&gt; are: &lt;architectures&gt;
  Non-fat file: &lt;filename&gt; is architecture: &lt;architecture&gt;
  .UNINDENT
  .INDENT 0.0
* **-thin**  
  Take a single universal binary input file and the thin flag followed by an architecture type.
  Require the output flag to be specified, and output a thin binary of the specified architecture.
  .UNINDENT
  .INDENT 0.0
* **-create**  
  Take at least one input file and require the output flag to be specified.
  Output a universal binary combining the input files.
  .UNINDENT
  .INDENT 0.0
* **-replace**  
  Take a single universal binary input file and require the output flag to be specified.
  The replace flag is followed by an architecture type, and a thin input file.
  Output a universal binary with the specified architecture slice in the
  universal binary input replaced with the contents of the thin input file.
  .UNINDENT
  .INDENT 0.0
* **-segalign**  
  Additional flag that can be specified with create and replace.
  The segalign flag is followed by an architecture type, and an alignment.
  The alignment is a hexadecimal number that is a power of 2.
  Output a file in which the slice with the specified architecture has the specified alignment.
  .UNINDENT

<a name="bugs"></a>

# Bugs


To report bugs, please visit &lt;_https://bugs.llvm.org/_&gt;.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

