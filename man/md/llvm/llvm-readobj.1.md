# llvm-readobj(1) - LLVM Object Reader

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

 llvm-readobj [options] [input...]
```

<a name="description"></a>

# Description


The **llvm-readobj** tool displays low-level format-specific information
about one or more object files.

If **input** is "**-**" or omitted, **llvm-readobj** reads from standard
input. Otherwise, it will read from the specified **filenames**.

<a name="differences-to-llvm-readelf"></a>

# Differences to Llvm-Readelf


**llvm-readelf** is an alias for the **llvm-readobj** tool with a
slightly different command-line interface and output that is GNU compatible.
Following is a list of differences between **llvm-readelf** and
**llvm-readobj**:
.INDENT 0.0

* ·  
  **llvm-readelf** uses _GNU_ for the _--elf-output-style_ option
  by default. **llvm-readobj** uses _LLVM_.
* ·  
  **llvm-readelf** allows single-letter grouped flags (e.g.
  **llvm-readelf -SW** is the same as  **llvm-readelf -S -W**).
  **llvm-readobj** does not allow grouping.
* ·  
  **llvm-readelf** provides _-s_ as an alias for
  _--symbols_, for GNU **readelf** compatibility, whereas it is
  an alias for _--section-headers_ in **llvm-readobj**.
* ·  
  **llvm-readobj** provides **-t** as an alias for _--symbols_.
  **llvm-readelf** does not.
* ·  
  **llvm-readobj** provides **--sr**, **--sd**, **--st** and **--dt** as
  aliases for _--section-relocations_, _--section-data_,
  _--section-symbols_ and _--dyn-symbols_ respectively.
  **llvm-readelf** does not provide these aliases, to avoid conflicting
  with grouped flags.
  .UNINDENT

<a name="general-and-multi-format-options"></a>

# General and Multi-Format Options


These options are applicable to more than one file format, or are unrelated to
file formats.
.INDENT 0.0

* **--all**  
  Equivalent to specifying all the main display options relevant to the file
  format.
  .UNINDENT
  .INDENT 0.0
* **--addrsig**  
  Display the address-significance table.
  .UNINDENT
  .INDENT 0.0
* **--color**  
  Use colors in the output for warnings and errors.
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
* **--relocations, --relocs, -r**  
  Display the relocation entries in the file.
  .UNINDENT
  .INDENT 0.0
* **--sections, --section-headers, -s, -S**  
  Display all sections.
  .UNINDENT
  .INDENT 0.0
* **--section-data, --sd**  
  When used with _--sections_, display section data for each section
  shown. This option has no effect for GNU style output.
  .UNINDENT
  .INDENT 0.0
* **--section-relocations, --sr**  
  When used with _--sections_, display relocations for each section
  shown. This option has no effect for GNU style output.
  .UNINDENT
  .INDENT 0.0
* **--section-symbols, --st**  
  When used with _--sections_, display symbols for each section shown.
  This option has no effect for GNU style output.
  .UNINDENT
  .INDENT 0.0
* **--stackmap**  
  Display contents of the stackmap section.
  .UNINDENT
  .INDENT 0.0
* **--string-dump=&lt;section[,section,...]&gt;, -p**  
  Display the specified section(s) as a list of strings. **section** may be a
  section index or section name.
  .UNINDENT
  .INDENT 0.0
* **--symbols, --syms, -t**  
  Display the symbol table.
  .UNINDENT
  .INDENT 0.0
* **--unwind, -u**  
  Display unwind information.
  .UNINDENT
  .INDENT 0.0
* **--version**  
  Display the version of the **llvm-readobj** executable.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options from response file _&lt;FILE&gt;_.
  .UNINDENT

<a name="elf-specific-options"></a>

# Elf Specific Options


The following options are implemented only for the ELF file format.
.INDENT 0.0

* **--arch-specific, -A**  
  Display architecture-specific information, e.g. the ARM attributes section on ARM.
  .UNINDENT
  .INDENT 0.0
* **--demangle, -C**  
  Display demangled symbol names in the output.
  .UNINDENT
  .INDENT 0.0
* **--dependent-libraries**  
  Display the dependent libraries section.
  .UNINDENT
  .INDENT 0.0
* **--dyn-relocations**  
  Display the dynamic relocation entries.
  .UNINDENT
  .INDENT 0.0
* **--dyn-symbols, --dyn-syms, --dt**  
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
  **GNU**. **LLVM** output (the default) is an expanded and structured format,
  whilst **GNU** output mimics the equivalent GNU **readelf** output.
  .UNINDENT
  .INDENT 0.0
* **--elf-section-groups, --section-groups, -g**  
  Display section groups.
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
* **--section-mapping**  
  Display the section to segment mapping.
  .UNINDENT
  .INDENT 0.0
* **--stack-sizes**  
  Display the contents of the stack sizes section(s), i.e. pairs of function
  names and the size of their stack frames. Currently only implemented for GNU
  style output.
  .UNINDENT
  .INDENT 0.0
* **--version-info, -V**  
  Display version sections.
  .UNINDENT

<a name="mach-o-specific-options"></a>

# Mach-O Specific Options


The following options are implemented only for the Mach-O file format.
.INDENT 0.0

* **--macho-data-in-code**  
  Display the Data in Code command.
  .UNINDENT
  .INDENT 0.0
* **--macho-dsymtab**  
  Display the Dsymtab command.
  .UNINDENT
  .INDENT 0.0
* **--macho-indirect-symbols**  
  Display indirect symbols.
  .UNINDENT
  .INDENT 0.0
* **--macho-linker-options**  
  Display the Mach-O-specific linker options.
  .UNINDENT
  .INDENT 0.0
* **--macho-segment**  
  Display the Segment command.
  .UNINDENT
  .INDENT 0.0
* **--macho-version-min**  
  Display the version min command.
  .UNINDENT

<a name="pecoff-specific-options"></a>

# Pe/Coff Specific Options


The following options are implemented only for the PE/COFF file format.
.INDENT 0.0

* **--codeview**  
  Display CodeView debug information.
  .UNINDENT
  .INDENT 0.0
* **--codeview-ghash**  
  Enable global hashing for CodeView type stream de-duplication.
  .UNINDENT
  .INDENT 0.0
* **--codeview-merged-types**  
  Display the merged CodeView type stream.
  .UNINDENT
  .INDENT 0.0
* **--codeview-subsection-bytes**  
  Dump raw contents of CodeView debug sections and records.
  .UNINDENT
  .INDENT 0.0
* **--coff-basereloc**  
  Display the .reloc section.
  .UNINDENT
  .INDENT 0.0
* **--coff-debug-directory**  
  Display the debug directory.
  .UNINDENT
  .INDENT 0.0
* **--coff-directives**  
  Display the .drectve section.
  .UNINDENT
  .INDENT 0.0
* **--coff-exports**  
  Display the export table.
  .UNINDENT
  .INDENT 0.0
* **--coff-imports**  
  Display the import table.
  .UNINDENT
  .INDENT 0.0
* **--coff-load-config**  
  Display the load config.
  .UNINDENT
  .INDENT 0.0
* **--coff-resources**  
  Display the .rsrc section.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-readobj** returns 0 under normal operation. It returns a non-zero
exit code if there were any errors.

<a name="see-also"></a>

# See Also


**llvm-nm(1)**, **llvm-objdump(1)**, **llvm-readelf(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

