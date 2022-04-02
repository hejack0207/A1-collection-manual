# llvm-locstats(1) - calculate statistics on DWARF debug location

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

 llvm-locstats [options] [filename]
```

<a name="description"></a>

# Description


**llvm-locstats** works like a wrapper around **llvm-dwarfdump**.
It parses **llvm-dwarfdump** statistics regarding debug location by
pretty printing it in a more human readable way.

The line 0% shows the number and the percentage of DIEs with no location
information, but the line 100% shows the information for DIEs where there is
location information in all code section bytes (where the variable or parameter
is in the scope). The line [50%,60%) shows the number and the percentage of DIEs
where the location information is between 50 and 60 percentage of its scope
covered.

<a name="options"></a>

# Options

.INDENT 0.0

* **--only-variables**  
  calculate the location statistics only for local variables
  .UNINDENT
  .INDENT 0.0
* **--only-formal-parameters**  
  calculate the location statistics only for formal parameters
  .UNINDENT
  .INDENT 0.0
* **--ignore-debug-entry-values**  
  ignore the location statistics on locations containing the
  debug entry values DWARF operation
  .UNINDENT
  .INDENT 0.0
* **--draw-plot**  
  make histogram of location buckets generated (requires
  matplotlib)
  .UNINDENT
  .INDENT 0.0
* **--compare**  
  compare the debug location coverage on two files provided, and draw
  a plot showing the difference (requires matplotlib)
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-locstats** returns 0 if the input file were parsed
successfully. Otherwise, it returns 1.

<a name="example-1"></a>

# Example 1


Pretty print the location coverage on the standard output.
.INDENT 0.0
.INDENT 3.5

    .ft C
    llvm-locstats a.out
    
      =================================================
                Debug Location Statistics
      =================================================
            cov%          samples       percentage(~)
      -------------------------------------------------
         0%                    1              16%
         (0%,10%)              0               0%
         [10%,20%)             0               0%
         [20%,30%)             0               0%
         [30%,40%)             0               0%
         [40%,50%)             0               0%
         [50%,60%)             1              16%
         [60%,70%)             0               0%
         [70%,80%)             0               0%
         [80%,90%)             1              16%
         [90%,100%)            0               0%
         100%                  3              50%
      =================================================
      -the number of debug variables processed: 6
      -PC ranges covered: 81%
      -------------------------------------------------
      -total availability: 83%
      =================================================
    .ft P
.UNINDENT
.UNINDENT

<a name="example-2"></a>

# Example 2


Generate a plot as an image file.
.INDENT 0.0
.INDENT 3.5

    .ft C
    llvm-locstats --draw-plot file1.out
    .ft P
.UNINDENT
.UNINDENT
[image]

<a name="example-3"></a>

# Example 3


Generate a plot as an image file showing the difference in the debug location
coverage.
.INDENT 0.0
.INDENT 3.5

    .ft C
    llvm-locstats --compare file1.out file1.withentryvals.out
    .ft P
.UNINDENT
.UNINDENT
[image]

<a name="see-also"></a>

# See Also


**llvm-dwarfdump(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

