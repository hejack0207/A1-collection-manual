# llvm-size(1) - print size information

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

 llvm-size [options] [input...]
```

<a name="description"></a>

# Description


**llvm-size** is a tool that prints size information for binary files.
It is intended to be a drop-in replacement for GNU's **size**.

The tool prints size information for each **input** specified. If no input is
specified, the program prints size information for **a.out**. If "**-**" is
specified as an input file, **llvm-size** reads a file from the standard
input stream. If an input is an archive, size information will be displayed for
all its members.

<a name="options"></a>

# Options

.INDENT 0.0

* **-A**  
  Equivalent to _--format_ with a value of **sysv**.
  .UNINDENT
  .INDENT 0.0
* **--arch=&lt;arch&gt;**  
  Architecture(s) from Mach-O universal binaries to display information for.
  .UNINDENT
  .INDENT 0.0
* **-B**  
  Equivalent to _--format_ with a value of **berkeley**.
  .UNINDENT
  .INDENT 0.0
* **--common**  
  Include ELF common symbol sizes in bss size for **berkeley** output format, or
  as a separate section entry for **sysv** output. If not specified, these
  symbols are ignored.
  .UNINDENT
  .INDENT 0.0
* **-d**  
  Equivalent to _--radix_ with a value of **10**.
  .UNINDENT
  .INDENT 0.0
* **-l**  
  Display verbose address and offset information for segments and sections in
  Mach-O files in **darwin** format.
  .UNINDENT
  .INDENT 0.0
* **--format=&lt;format&gt;**  
  Set the output format to the **&lt;format&gt;** specified. Available **&lt;format&gt;**
  options are **berkeley** (the default), **sysv** and **darwin**.

Berkeley output summarises text, data and bss sizes in each file, as shown
below for a typical pair of ELF files:
.INDENT 7.0
.INDENT 3.5

    .ft C
    $ llvm-size --format=berkeley test.o test2.o
       text    data     bss     dec     hex filename
        182      16       5     203      cb test.elf
         82       8       1      91      5b test2.o
    .ft P
.UNINDENT
.UNINDENT

For Mach-O files, the output format is slightly different:
.INDENT 7.0
.INDENT 3.5

    .ft C
    $ llvm-size --format=berkeley macho.obj macho2.obj
    __TEXT  __DATA  __OBJC  others  dec     hex
    4       8       0       0       12      c       macho.obj
    16      32      0       0       48      30      macho2.obj
    .ft P
.UNINDENT
.UNINDENT

Sysv output displays size and address information for most sections, with each
file being listed separately:
.INDENT 7.0
.INDENT 3.5

    .ft C
    $ llvm-size --format=sysv test.elf test2.o
       test.elf  :
       section       size      addr
       .eh_frame       92   2097496
       .text           90   2101248
       .data           16   2105344
       .bss             5   2105360
       .comment       209         0
       Total          412
    
       test2.o  :
       section             size   addr
       .text                 26      0
       .data                  8      0
       .bss                   1      0
       .comment             106      0
       .note.GNU-stack        0      0
       .eh_frame             56      0
       .llvm_addrsig          2      0
       Total                199
    .ft P
.UNINDENT
.UNINDENT

**darwin** format only affects Mach-O input files. If an input of a different
file format is specified, **llvm-size** falls back to **berkeley**
format. When producing **darwin** format, the tool displays information about
segments and sections:
.INDENT 7.0
.INDENT 3.5

    .ft C
    $ llvm-size --format=darwin macho.obj macho2.obj
       macho.obj:
       Segment : 12
               Section (__TEXT, __text): 4
               Section (__DATA, __data): 8
               total 12
       total 12
       macho2.obj:
       Segment : 48
               Section (__TEXT, __text): 16
               Section (__DATA, __data): 32
               total 48
       total 48
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--help, -h**  
  Display a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **--help-list**  
  Display an uncategorized summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **-m**  
  Equivalent to _--format_ with a value of **darwin**.
  .UNINDENT
  .INDENT 0.0
* **-o**  
  Equivalent to _--radix_ with a value of **8**.
  .UNINDENT
  .INDENT 0.0
* **--radix=&lt;value&gt;**  
  Display size information in the specified radix. Permitted values are **8**,
  **10** (the default) and **16** for octal, decimal and hexadecimal output
  respectively.

Example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    $ llvm-size --radix=8 test.o
       text    data     bss     oct     hex filename
       0152      04      04     162      72 test.o
    
    $ llvm-size --radix=10 test.o
       text    data     bss     dec     hex filename
        106       4       4     114      72 test.o
    
    $ llvm-size --radix=16 test.o
       text    data     bss     dec     hex filename
       0x6a     0x4     0x4     114      72 test.o
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--totals, -t**  
  Applies only to **berkeley** output format. Display the totals for all listed
  fields, in addition to the individual file listings.

Example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    $ llvm-size --totals test.elf test2.o
       text    data     bss     dec     hex filename
        182      16       5     203      cb test.elf
         82       8       1      91      5b test2.o
        264      24       6     294     126 (TOTALS)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--version**  
  Display the version of the **llvm-size** executable.
  .UNINDENT
  .INDENT 0.0
* **-x**  
  Equivalent to _--radix_ with a value of **16**.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options from response file **&lt;FILE&gt;**.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-size** exits with a non-zero exit code if there is an error.
Otherwise, it exits with code 0.

<a name="bugs"></a>

# Bugs


To report bugs, please visit &lt;_https://bugs.llvm.org/_&gt;.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

