# llvm-objdump(1) - LLVM's object file dumper

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

 llvm-objdump [commands] [options] [filenames...]
```

<a name="description"></a>

# Description


The **llvm-objdump** utility prints the contents of object files and
final linked images named on the command line. If no file name is specified,
**llvm-objdump** will attempt to read from _a.out_. If _-_ is used as a
file name, **llvm-objdump** will process a file on its standard input
stream.

<a name="commands"></a>

# Commands


At least one of the following commands are required, and some commands can be
combined with other commands:
.INDENT 0.0

* **-a, --archive-headers**  
  Display the information contained within an archive's headers.
  .UNINDENT
  .INDENT 0.0
* **-d, --disassemble**  
  Disassemble all text sections found in the input files.
  .UNINDENT
  .INDENT 0.0
* **-D, --disassemble-all**  
  Disassemble all sections found in the input files.
  .UNINDENT
  .INDENT 0.0
* **--disassemble-symbols=&lt;symbol1[,symbol2,...]&gt;**  
  Disassemble only the specified symbols. Takes demangled symbol names when
  _--demangle_ is specified, otherwise takes mangled symbol names.
  Implies _--disassemble_.
  .UNINDENT
  .INDENT 0.0
* **--dwarf=&lt;value&gt;**  
  Dump the specified DWARF debug sections. The supported values are:

_frames_ - .debug_frame
.UNINDENT
.INDENT 0.0

* **-f, --file-headers**  
  Display the contents of the overall file header.
  .UNINDENT
  .INDENT 0.0
* **--fault-map-section**  
  Display the content of the fault map section.
  .UNINDENT
  .INDENT 0.0
* **-h, --headers, --section-headers**  
  Display summaries of the headers for each section.
  .UNINDENT
  .INDENT 0.0
* **--help**  
  Display usage information and exit. Does not stack with other commands.
  .UNINDENT
  .INDENT 0.0
* **-p, --private-headers**  
  Display format-specific file headers.
  .UNINDENT
  .INDENT 0.0
* **-r, --reloc**  
  Display the relocation entries in the file.
  .UNINDENT
  .INDENT 0.0
* **-R, --dynamic-reloc**  
  Display the dynamic relocation entries in the file.
  .UNINDENT
  .INDENT 0.0
* **--raw-clang-ast**  
  Dump the raw binary contents of the clang AST section.
  .UNINDENT
  .INDENT 0.0
* **-s, --full-contents**  
  Display the contents of each section.
  .UNINDENT
  .INDENT 0.0
* **-t, --syms**  
  Display the symbol table.
  .UNINDENT
  .INDENT 0.0
* **-T, --dynamic-syms**  
  Display the contents of the dynamic symbol table.
  .UNINDENT
  .INDENT 0.0
* **-u, --unwind-info**  
  Display the unwind info of the input(s).
  .UNINDENT
  .INDENT 0.0
* **--version**  
  Display the version of the **llvm-objdump** executable. Does not stack
  with other commands.
  .UNINDENT
  .INDENT 0.0
* **-x, --all-headers**  
  Display all available header information. Equivalent to specifying
  _--archive-headers_, _--file-headers_,
  _--private-headers_, _--reloc_, _--section-headers_,
  and _--syms_.
  .UNINDENT

<a name="options"></a>

# Options


**llvm-objdump** supports the following options:
.INDENT 0.0

* **--adjust-vma=&lt;offset&gt;**  
  Increase the displayed address in disassembly or section header printing by
  the specified offset.
  .UNINDENT
  .INDENT 0.0
* **--arch-name=&lt;string&gt;**  
  Specify the target architecture when disassembling. Use _--version_
  for a list of available targets.
  .UNINDENT
  .INDENT 0.0
* **-C, --demangle**  
  Demangle symbol names in the output.
  .UNINDENT
  .INDENT 0.0
* **--debug-vars=&lt;format&gt;**  
  Print the locations (in registers or memory) of source-level variables
  alongside disassembly. **format** may be **unicode** or **ascii**, defaulting
  to **unicode** if omitted.
  .UNINDENT
  .INDENT 0.0
* **--debug-vars-indent=&lt;width&gt;**  
  Distance to indent the source-level variable display, relative to the start
  of the disassembly. Defaults to 40 characters.
  .UNINDENT
  .INDENT 0.0
* **-j, --section=&lt;section1[,section2,...]&gt;**  
  Perform commands on the specified sections only. For Mach-O use
  _segment,section_ to specify the section name.
  .UNINDENT
  .INDENT 0.0
* **-l, --line-numbers**  
  When disassembling, display source line numbers. Implies
  _--disassemble_.
  .UNINDENT
  .INDENT 0.0
* **-M, --disassembler-options=&lt;opt1[,opt2,...]&gt;**  
  Pass target-specific disassembler options. Currently supported for ARM targets
  only. Available options are **reg-names-std** and **reg-names-raw**.
  .UNINDENT
  .INDENT 0.0
* **--mcpu=&lt;cpu-name&gt;**  
  Target a specific CPU type for disassembly. Specify **--mcpu=help** to display
  available CPUs.
  .UNINDENT
  .INDENT 0.0
* **--mattr=&lt;a1,+a2,-a3,...&gt;**  
  Enable/disable target-specific attributes. Specify **--mcpu=help** to display
  the available attributes.
  .UNINDENT
  .INDENT 0.0
* **--no-leading-addr**  
  When disassembling, do not print leading addresses.
  .UNINDENT
  .INDENT 0.0
* **--no-show-raw-insn**  
  When disassembling, do not print the raw bytes of each instruction.
  .UNINDENT
  .INDENT 0.0
* **--print-imm-hex**  
  Use hex format when printing immediate values in disassembly output.
  .UNINDENT
  .INDENT 0.0
* **-S, --source**  
  When disassembling, display source interleaved with the disassembly. Implies
  _--disassemble_.
  .UNINDENT
  .INDENT 0.0
* **--show-lma**  
  Display the LMA column when dumping ELF section headers. Defaults to off
  unless any section has different VMA and LMAs.
  .UNINDENT
  .INDENT 0.0
* **--start-address=&lt;address&gt;**  
  When disassembling, only disassemble from the specified address.

When printing relocations, only print the relocations patching offsets from at least **address**.

When printing symbols, only print symbols with a value of at least **address**.
.UNINDENT
.INDENT 0.0

* **--stop-address=&lt;address&gt;**  
  When disassembling, only disassemble up to, but not including the specified address.

When printing relocations, only print the relocations patching offsets up to **address**.

When printing symbols, only print symbols with a value up to **address**.
.UNINDENT
.INDENT 0.0

* **--triple=&lt;string&gt;**  
  Target triple to disassemble for, see **--version** for available targets.
  .UNINDENT
  .INDENT 0.0
* **-w, --wide**  
  Ignored for compatibility with GNU objdump.
  .UNINDENT
  .INDENT 0.0
* **--x86-asm-syntax=&lt;style&gt;**  
  When used with _--disassemble_, choose style of code to emit from
  X86 backend. Supported values are:
  .INDENT 7.0
  .INDENT 3.5
  .INDENT 0.0
* **att**  
  AT&T-style assembly
  .UNINDENT
  .INDENT 0.0
* **intel**  
  Intel-style assembly
  .UNINDENT
  .UNINDENT
  .UNINDENT

The default disassembly style is **att**.
.UNINDENT
.INDENT 0.0

* **-z, --disassemble-zeroes**  
  Do not skip blocks of zeroes when disassembling.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options and commands from response file _&lt;FILE&gt;_.
  .UNINDENT

<a name="mach-o-only-options-and-commands"></a>

# Mach-O Only Options and Commands

.INDENT 0.0

* **--arch=&lt;architecture&gt;**  
  Specify the architecture to disassemble. see **--version** for available
  architectures.
  .UNINDENT
  .INDENT 0.0
* **--archive-member-offsets**  
  Print the offset to each archive member for Mach-O archives (requires
  _--archive-headers_).
  .UNINDENT
  .INDENT 0.0
* **--bind**  
  Display binding info
  .UNINDENT
  .INDENT 0.0
* **--cfg**  
  Create a CFG for every symbol in the object file and write it to a graphviz
  file.
  .UNINDENT
  .INDENT 0.0
* **--data-in-code**  
  Display the data in code table.
  .UNINDENT
  .INDENT 0.0
* **--dis-symname=&lt;name&gt;**  
  Disassemble just the specified symbol's instructions.
  .UNINDENT
  .INDENT 0.0
* **--dylibs-used**  
  Display the shared libraries used for linked files.
  .UNINDENT
  .INDENT 0.0
* **--dsym=&lt;string&gt;**  
  Use .dSYM file for debug info.
  .UNINDENT
  .INDENT 0.0
* **--dylib-id**  
  Display the shared library's ID for dylib files.
  .UNINDENT
  .INDENT 0.0
* **--exports-trie**  
  Display exported symbols.
  .UNINDENT
  .INDENT 0.0
* **-g**  
  Print line information from debug info if available.
  .UNINDENT
  .INDENT 0.0
* **--full-leading-addr**  
  Print the full leading address when disassembling.
  .UNINDENT
  .INDENT 0.0
* **--indirect-symbols**  
  Display the indirect symbol table.
  .UNINDENT
  .INDENT 0.0
* **--info-plist**  
  Display the info plist section as strings.
  .UNINDENT
  .INDENT 0.0
* **--lazy-bind**  
  Display lazy binding info.
  .UNINDENT
  .INDENT 0.0
* **--link-opt-hints**  
  Display the linker optimization hints.
  .UNINDENT
  .INDENT 0.0
* **-m, --macho**  
  Use Mach-O specific object file parser. Commands and other options may behave
  differently when used with **--macho**.
  .UNINDENT
  .INDENT 0.0
* **--no-leading-headers**  
  Do not print any leading headers.
  .UNINDENT
  .INDENT 0.0
* **--no-symbolic-operands**  
  Do not print symbolic operands when disassembling.
  .UNINDENT
  .INDENT 0.0
* **--non-verbose**  
  Display the information for Mach-O objects in non-verbose or numeric form.
  .UNINDENT
  .INDENT 0.0
* **--objc-meta-data**  
  Display the Objective-C runtime meta data.
  .UNINDENT
  .INDENT 0.0
* **--private-header**  
  Display only the first format specific file header.
  .UNINDENT
  .INDENT 0.0
* **--rebase**  
  Display rebasing information.
  .UNINDENT
  .INDENT 0.0
* **--universal-headers**  
  Display universal headers.
  .UNINDENT
  .INDENT 0.0
* **--weak-bind**  
  Display weak binding information.
  .UNINDENT

<a name="xcoff-only-options-and-commands"></a>

# Xcoff Only Options and Commands

.INDENT 0.0

* **--symbol-description**  
  Add symbol description to disassembly output.
  .UNINDENT

<a name="bugs"></a>

# Bugs


To report bugs, please visit &lt;_https://bugs.llvm.org/_&gt;.

<a name="see-also"></a>

# See Also


**llvm-nm(1)**, **llvm-readelf(1)**, **llvm-readobj(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

