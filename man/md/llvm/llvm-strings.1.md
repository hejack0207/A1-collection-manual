# llvm-strings(1) - print strings

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

 llvm-strings [options] [input...]
```

<a name="description"></a>

# Description


**llvm-strings** is a tool intended as a drop-in replacement for GNU's
**strings**, which looks for printable strings in files and writes them
to the standard output stream. A printable string is any sequence of four (by
default) or more printable ASCII characters. The end of the file, or any other
byte, terminates the current sequence.

**llvm-strings** looks for strings in each **input** file specified.
Unlike GNU **strings** it looks in the entire input file, regardless of
file format, rather than restricting the search to certain sections of object
files. If "**-**" is specified as an **input**, or no **input** is specified,
the program reads from the standard input stream.

<a name="example"></a>

# Example

.INDENT 0.0
.INDENT 3.5

    .ft C
    $ cat input.txt
    bars
    foo
    wibble blob
    $ llvm-strings input.txt
    bars
    wibble blob
    .ft P
.UNINDENT
.UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **--all, -a**  
  Silently ignored. Present for GNU **strings** compatibility.
  .UNINDENT
  .INDENT 0.0
* **--bytes=&lt;length&gt;, -n**  
  Set the minimum number of printable ASCII characters required for a sequence of
  bytes to be considered a string. The default value is 4.
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
* **--print-file-name, -f**  
  Display the name of the containing file before each string.

Example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    $ llvm-strings --print-file-name test.o test.elf
    test.o: _Z5hellov
    test.o: some_bss
    test.o: test.cpp
    test.o: main
    test.elf: test.cpp
    test.elf: test2.cpp
    test.elf: _Z5hellov
    test.elf: main
    test.elf: some_bss
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--radix=&lt;radix&gt;, -t**  
  Display the offset within the file of each string, before the string and using
  the specified radix. Valid **&lt;radix&gt;** values are **o**, **d** and **x** for
  octal, decimal and hexadecimal respectively.

Example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    $ llvm-strings --radix=o test.o
        1054 _Z5hellov
        1066 .rela.text
        1101 .comment
        1112 some_bss
        1123 .bss
        1130 test.cpp
        1141 main
    $ llvm-strings --radix=d test.o
        556 _Z5hellov
        566 .rela.text
        577 .comment
        586 some_bss
        595 .bss
        600 test.cpp
        609 main
    $ llvm-strings -t x test.o
        22c _Z5hellov
        236 .rela.text
        241 .comment
        24a some_bss
        253 .bss
        258 test.cpp
        261 main
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--version**  
  Display the version of the **llvm-strings** executable.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options from response file **&lt;FILE&gt;**.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-strings** exits with a non-zero exit code if there is an error.
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

