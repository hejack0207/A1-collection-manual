# llvm-readelf(1) - GNU-style LLVM Object Reader

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

 llvm-readelf [options] [input...]
```

<a name="description"></a>

# Description


The **llvm-readelf** tool displays low-level format-specific information
about one or more object files.

If **input** is "**-**" or omitted, **llvm-readelf** reads from standard
input. Otherwise, it will read from the specified **filenames**.

<a name="options"></a>

# Options

.INDENT 0.0

* **--all**  
  Equivalent to specifying all the main display options.
  .UNINDENT
  .INDENT 0.0
* **--addrsig**  
  Display the address-significance table.
  .UNINDENT
  .INDENT 0.0
* **--arch-specific, -A**  
  Display architecture-specific information, e.g. the ARM attributes section on ARM.
  .UNINDENT
  .INDENT 0.0
* **--color**  
  Use colors in the output for warnings and errors.
  .UNINDENT
  .INDENT 0.0
* **--demangle, -C**  
  Display demangled symbol names in the output.
  .UNINDENT
  .INDENT 0.0
* **--dyn-relocations**  
  Display the dynamic relocation entries.
  .UNINDENT
  .INDENT 0.0
* **--dyn-symbols, --dyn-syms**  
  Display the dynamic symbol table.
  .UNINDENT
  .INDENT 0.0
* **--dynamic-table, --dynamic, -d**  
  Display the dynamic table.
  .UNINDENT
  .INDENT 0.0
* **--cg-profile**  
  Display the callgraph profile section.
  .UNINDENT
  .INDENT 0.0
* **--elf-hash-histogram, --histogram, -I**  
  Display a bucket list histogram for dynamic symbol hash tables.
  .UNINDENT
  .INDENT 0.0
* **--elf-linker-options**  
  Display the linker options section.
  .UNINDENT
  .INDENT 0.0
* **--elf-output-style=&lt;value&gt;**  
  Format ELF information in the specified style. Valid options are **LLVM** and
  **GNU**. **LLVM** output is an expanded and structured format, whilst **GNU**
  (the default) output mimics the equivalent GNU **readelf** output.
  .UNINDENT
  .INDENT 0.0
* **--elf-section-groups, --section-groups, -g**  
  Display section groups.
  .UNINDENT
  .INDENT 0.0
* **--expand-relocs**  
  When used with _--relocations_, display each relocation in an expanded
  multi-line format.
  .UNINDENT
  .INDENT 0.0
* **--file-headers, -h**  
  Display file headers.
  .UNINDENT
  .INDENT 0.0
* **--gnu-hash-table**  
  Display the GNU hash table for dynamic symbols.
  .UNINDENT
  .INDENT 0.0
* **--hash-symbols**  
  Display the expanded hash table with dynamic symbol data.
  .UNINDENT
  .INDENT 0.0
* **--hash-table**  
  Display the hash table for dynamic symbols.
  .UNINDENT
  .INDENT 0.0
* **--headers, -e**  
  Equivalent to setting: _--file-headers_, _--program-headers_,
  and _--sections_.
  .UNINDENT
  .INDENT 0.0
* **--help**  
  Display a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **--help-list**  
  Display an uncategorized summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **--hex-dump=&lt;section[,section,...]&gt;, -x**  
  Display the specified section(s) as hexadecimal bytes. **section** may be a
  section index or section name.
  .UNINDENT
  .INDENT 0.0
* **--needed-libs**  
  Display the needed libraries.
  .UNINDENT
  .INDENT 0.0
* **--notes, -n**  
  Display all notes.
  .UNINDENT
  .INDENT 0.0
* **--program-headers, --segments, -l**  
  Display the program headers.
  .UNINDENT
  .INDENT 0.0
* **--raw-relr**  
  Do not decode relocations in RELR relocation sections when displaying them.
  .UNINDENT
  .INDENT 0.0
* **--relocations, --relocs, -r**  
  Display the relocation entries in the file.
  .UNINDENT
  .INDENT 0.0
* **--sections, --section-headers, -S**  
  Display all sections.
  .UNINDENT
  .INDENT 0.0
* **--section-data**  
  When used with _--sections_, display section data for each section
  shown. This option has no effect for GNU style output.
  .UNINDENT
  .INDENT 0.0
* **--section-mapping**  
  Display the section to segment mapping.
  .UNINDENT
  .INDENT 0.0
* **--section-relocations**  
  When used with _--sections_, display relocations for each section
  shown. This option has no effect for GNU style output.
  .UNINDENT
  .INDENT 0.0
* **--section-symbols**  
  When used with _--sections_, display symbols for each section shown.
  This option has no effect for GNU style output.
  .UNINDENT
  .INDENT 0.0
* **--stackmap**  
  Display contents of the stackmap section.
  .UNINDENT
  .INDENT 0.0
* **--stack-sizes**  
  Display the contents of the stack sizes section(s), i.e. pairs of function
  names and the size of their stack frames. Currently only implemented for GNU
  style output.
  .UNINDENT
  .INDENT 0.0
* **--string-dump=&lt;section[,section,...]&gt;, -p**  
  Display the specified section(s) as a list of strings. **section** may be a
  section index or section name.
  .UNINDENT
  .INDENT 0.0
* **--symbols, --syms, -s**  
  Display the symbol table.
  .UNINDENT
  .INDENT 0.0
* **--unwind, -u**  
  Display unwind information.
  .UNINDENT
  .INDENT 0.0
* **--version**  
  Display the version of the **llvm-readelf** executable.
  .UNINDENT
  .INDENT 0.0
* **--version-info, -V**  
  Display version sections.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options from response file _&lt;FILE&gt;_.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-readelf** returns 0 under normal operation. It returns a non-zero
exit code if there were any errors.

<a name="see-also"></a>

# See Also


**llvm-nm(1)**, **llvm-objdump(1)**, **llvm-readobj(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

