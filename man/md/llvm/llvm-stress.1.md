# llvm-stress(1) - generate random .ll files

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

 llvm-stress [-size=filesize] [-seed=initialseed] [-o=outfile]
```

<a name="description"></a>

# Description


The **llvm-stress** tool is used to generate random **.ll** files that
can be used to test different components of LLVM.

<a name="options"></a>

# Options

.INDENT 0.0

* **-o filename**  
  Specify the output filename.
  .UNINDENT
  .INDENT 0.0
* **-size size**  
  Specify the size of the generated **.ll** file.
  .UNINDENT
  .INDENT 0.0
* **-seed seed**  
  Specify the seed to be used for the randomly generated instructions.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-stress** returns 0.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

