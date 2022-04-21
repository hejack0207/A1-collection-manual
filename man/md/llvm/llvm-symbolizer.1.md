# llvm-symbolizer(1) - convert addresses into source code locations

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

 llvm-symbolizer [options] [addresses...]
```

<a name="description"></a>

# Description


**llvm-symbolizer** reads object file names and addresses from the
command-line and prints corresponding source code locations to standard output.

If no address is specified on the command-line, it reads the addresses from
standard input. If no object file is specified on the command-line, but
addresses are, or if at any time an input value is not recognized, the input is
simply echoed to the output.

A positional argument or standard input value can be preceded by "DATA" or
"CODE" to indicate that the address should be symbolized as data or executable
code respectively. If neither is specified, "CODE" is assumed. DATA is
symbolized as address and symbol size rather than line number.

Object files can be specified together with the addresses either on standard
input or as positional arguments on the command-line, following any "DATA" or
"CODE" prefix.

**llvm-symbolizer** parses options from the environment variable
**LLVM\_SYMBOLIZER\_OPTS** after parsing options from the command line.
**LLVM\_SYMBOLIZER\_OPTS** is primarily useful for supplementing the command-line
options when **llvm-symbolizer** is invoked by another program or
runtime.

<a name="examples"></a>

# Examples


All of the following examples use the following two source files as input. They
use a mixture of C-style and C++-style linkage to illustrate how these names are
printed differently (see _--demangle_).
.INDENT 0.0
.INDENT 3.5

    .ft C
    // test.h
    extern "C" inline int foz() {
      return 1234;
    }
    .ft P
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    // test.cpp
    #include "test.h"
    int bar=42;
    
    int foo() {
      return bar;
    }
    
    int baz() {
      volatile int k = 42;
      return foz() + k;
    }
    
    int main() {
      return foo() + baz();
    }
    .ft P
.UNINDENT
.UNINDENT

These files are built as follows:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ clang -g test.cpp -o test.elf
    $ clang -g -O2 test.cpp -o inlined.elf
    .ft P
.UNINDENT
.UNINDENT

Example 1 - addresses and object on command-line:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ llvm-symbolizer --obj=test.elf 0x4004d0 0x400490
    foz
    /tmp/test.h:1:0
    
    baz()
    /tmp/test.cpp:11:0
    .ft P
.UNINDENT
.UNINDENT

Example 2 - addresses on standard input:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ cat addr.txt
    0x4004a0
    0x400490
    0x4004d0
    $ llvm-symbolizer --obj=test.elf < addr.txt
    main
    /tmp/test.cpp:15:0
    
    baz()
    /tmp/test.cpp:11:0
    
    foz
    /tmp/./test.h:1:0
    .ft P
.UNINDENT
.UNINDENT

Example 3 - object specified with address:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ llvm-symbolizer "test.elf 0x400490" "inlined.elf 0x400480"
    baz()
    /tmp/test.cpp:11:0
    
    foo()
    /tmp/test.cpp:8:10
    
    $ cat addr2.txt
    test.elf 0x4004a0
    inlined.elf 0x400480
    
    $ llvm-symbolizer < addr2.txt
    main
    /tmp/test.cpp:15:0
    
    foo()
    /tmp/test.cpp:8:10
    .ft P
.UNINDENT
.UNINDENT

Example 4 - CODE and DATA prefixes:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ llvm-symbolizer --obj=test.elf "CODE 0x400490" "DATA 0x601028"
    baz()
    /tmp/test.cpp:11:0
    
    bar
    6295592 4
    
    $ cat addr3.txt
    CODE test.elf 0x4004a0
    DATA inlined.elf 0x601028
    
    $ llvm-symbolizer < addr3.txt
    main
    /tmp/test.cpp:15:0
    
    bar
    6295592 4
    .ft P
.UNINDENT
.UNINDENT

Example 5 - path-style options:

This example uses the same source file as above, but the source file's
full path is /tmp/foo/test.cpp and is compiled as follows. The first case
shows the default absolute path, the second --basenames, and the third
shows --relativenames.
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ pwd
    /tmp
    $ clang -g foo/test.cpp -o test.elf
    $ llvm-symbolizer --obj=test.elf 0x4004a0
    main
    /tmp/foo/test.cpp:15:0
    $ llvm-symbolizer --obj=test.elf 0x4004a0 --basenames
    main
    test.cpp:15:0
    $ llvm-symbolizer --obj=test.elf 0x4004a0 --relativenames
    main
    foo/test.cpp:15:0
    .ft P
.UNINDENT
.UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **--adjust-vma &lt;offset&gt;**  
  Add the specified offset to object file addresses when performing lookups.
  This can be used to perform lookups as if the object were relocated by the
  offset.
  .UNINDENT
  .INDENT 0.0
* **--basenames, -s**  
  Print just the file's name without any directories, instead of the
  absolute path.
  .UNINDENT
  .INDENT 0.0
* **--relativenames**  
  Print the file's path relative to the compilation directory, instead
  of the absolute path. If the command-line to the compiler included
  the full path, this will be the same as the default.
  .UNINDENT
  .INDENT 0.0
* **--demangle, -C**  
  Print demangled function names, if the names are mangled (e.g. the mangled
  name _\_Z3bazv_ becomes _baz()_, whilst the non-mangled name _foz_ is printed
  as is). Defaults to true.
  .UNINDENT
  .INDENT 0.0
* **--dwp &lt;path&gt;**  
  Use the specified DWP file at **&lt;path&gt;** for any CUs that have split DWARF
  debug data.
  .UNINDENT
  .INDENT 0.0
* **--fallback-debug-path &lt;path&gt;**  
  When a separate file contains debug data, and is referenced by a GNU debug
  link section, use the specified path as a basis for locating the debug data if
  it cannot be found relative to the object.
  .UNINDENT
  .INDENT 0.0
* **--functions [=&lt;none|short|linkage&gt;], -f**  
  Specify the way function names are printed (omit function name, print short
  function name, or print full linkage name, respectively). Defaults to
  **linkage**.
  .UNINDENT
  .INDENT 0.0
* **--help, -h**  
  Show help and usage for this command.
  .UNINDENT
  .INDENT 0.0
* **--help-list**  
  Show help and usage for this command without grouping the options into categories.
  .UNINDENT
  .INDENT 0.0
* **--inlining, --inlines, -i**  
  If a source code location is in an inlined function, prints all the inlined
  frames. Defaults to true.
  .UNINDENT
  .INDENT 0.0
* **--no-demangle**  
  Don't print demangled function names.
  .UNINDENT
  .INDENT 0.0
* **--obj &lt;path&gt;, --exe, -e**  
  Path to object file to be symbolized. If **-** is specified, read the object
  directly from the standard input stream.
  .UNINDENT
  .INDENT 0.0
* **--output-style &lt;LLVM|GNU&gt;**  
  Specify the preferred output style. Defaults to **LLVM**. When the output
  style is set to **GNU**, the tool follows the style of GNU's **addr2line**.
  The differences from the **LLVM** style are:
  .INDENT 7.0
* ·  
  Does not print the column of a source code location.
* ·  
  Does not add an empty line after the report for an address.
* ·  
  Does not replace the name of an inlined function with the name of the
  topmost caller when inlined frames are not shown and _--use-symbol-table_
  is on.
* ·  
  Prints an address's debug-data discriminator when it is non-zero. One way to
  produce discriminators is to compile with clang's -fdebug-info-for-profiling.
  .UNINDENT
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ llvm-symbolizer --obj=inlined.elf 0x4004be 0x400486 -p
    baz() at /tmp/test.cpp:11:18
     (inlined by) main at /tmp/test.cpp:15:0
    
    foo() at /tmp/test.cpp:6:3
    
    $ llvm-symbolizer --output-style=LLVM --obj=inlined.elf 0x4004be 0x400486 -p -i=0
    main at /tmp/test.cpp:11:18
    
    foo() at /tmp/test.cpp:6:3
    
    $ llvm-symbolizer --output-style=GNU --obj=inlined.elf 0x4004be 0x400486 -p -i=0
    baz() at /tmp/test.cpp:11
    foo() at /tmp/test.cpp:6
    
    $ clang -g -fdebug-info-for-profiling test.cpp -o profiling.elf
    $ llvm-symbolizer --output-style=GNU --obj=profiling.elf 0x401167 -p -i=0
    main at /tmp/test.cpp:15 (discriminator 2)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--pretty-print, -p**  
  Print human readable output. If _--inlining_ is specified, the
  enclosing scope is prefixed by (inlined by).
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ llvm-symbolizer --obj=inlined.elf 0x4004be --inlining --pretty-print
    baz() at /tmp/test.cpp:11:18
     (inlined by) main at /tmp/test.cpp:15:0
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--print-address, --addresses, -a**  
  Print address before the source code location. Defaults to false.
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ llvm-symbolizer --obj=inlined.elf --print-address 0x4004be
    0x4004be
    baz()
    /tmp/test.cpp:11:18
    main
    /tmp/test.cpp:15:0
    
    $ llvm-symbolizer --obj=inlined.elf 0x4004be --pretty-print --print-address
    0x4004be: baz() at /tmp/test.cpp:11:18
     (inlined by) main at /tmp/test.cpp:15:0
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--print-source-context-lines &lt;N&gt;**  
  Print **N** lines of source context for each symbolized address.
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ llvm-symbolizer --obj=test.elf 0x400490 --print-source-context-lines=2
    baz()
    /tmp/test.cpp:11:0
    10  :   volatile int k = 42;
    11 >:   return foz() + k;
    12  : }
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--use-symbol-table**  
  Prefer function names stored in symbol table to function names in debug info
  sections. Defaults to true.
  .UNINDENT
  .INDENT 0.0
* **--verbose**  
  Print verbose line and column information.
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ llvm-symbolizer --obj=inlined.elf --verbose 0x4004be
    baz()
      Filename: /tmp/test.cpp
    Function start line: 9
      Line: 11
      Column: 18
    main
      Filename: /tmp/test.cpp
    Function start line: 14
      Line: 15
      Column: 0
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--version**  
  Print version information for the tool.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options from response file _&lt;FILE&gt;_.
  .UNINDENT

<a name="mach-o-specific-options"></a>

# Mach-O Specific Options

.INDENT 0.0

* **--default-arch &lt;arch&gt;**  
  If a binary contains object files for multiple architectures (e.g. it is a
  Mach-O universal binary), symbolize the object file for a given architecture.
  You can also specify the architecture by writing **binary\_name:arch\_name** in
  the input (see example below). If the architecture is not specified in either
  way, the address will not be symbolized. Defaults to empty string.
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ cat addr.txt
    /tmp/mach_universal_binary:i386 0x1f84
    /tmp/mach_universal_binary:x86_64 0x100000f24
    
    $ llvm-symbolizer < addr.txt
    _main
    /tmp/source_i386.cc:8
    
    _main
    /tmp/source_x86_64.cc:8
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **--dsym-hint &lt;path/to/file.dSYM&gt;**  
  If the debug info for a binary isn't present in the default location, look for
  the debug info at the .dSYM path provided via this option. This flag can be
  used multiple times.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-symbolizer** returns 0. Other exit codes imply an internal program
error.

<a name="see-also"></a>

# See Also


**llvm-addr2line(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

