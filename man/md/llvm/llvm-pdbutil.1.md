# llvm-pdbutil(1) - PDB File forensics and diagnostics

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
.INDENT 0.0

* ·  
  _Synopsis_
* ·  
  _Description_
* ·  
  _Subcommands_
  .INDENT 2.0
* ·  
  _pretty_
  .INDENT 2.0
* ·  
  _Summary_
* ·  
  _Options_
  .INDENT 2.0
* ·  
  _Filtering and Sorting Options_
* ·  
  _Symbol Type Options_
* ·  
  _Other Options_
  .UNINDENT
  .UNINDENT
* ·  
  _dump_
  .INDENT 2.0
* ·  
  _Summary_
* ·  
  _Options_
  .INDENT 2.0
* ·  
  _MSF Container Options_
* ·  
  _Module & File Options_
* ·  
  _Symbol Options_
* ·  
  _Type Record Options_
* ·  
  _Miscellaneous Options_
  .UNINDENT
  .UNINDENT
* ·  
  _bytes_
  .INDENT 2.0
* ·  
  _Summary_
* ·  
  _Options_
  .INDENT 2.0
* ·  
  _MSF File Options_
* ·  
  _PDB Stream Options_
* ·  
  _DBI Stream Options_
* ·  
  _Module Options_
* ·  
  _Type Record Options_
  .UNINDENT
  .UNINDENT
* ·  
  _pdb2yaml_
  .INDENT 2.0
* ·  
  _Summary_
* ·  
  _Options_
  .UNINDENT
* ·  
  _yaml2pdb_
  .INDENT 2.0
* ·  
  _Summary_
* ·  
  _Options_
  .UNINDENT
* ·  
  _merge_
  .INDENT 2.0
* ·  
  _Summary_
* ·  
  _Options_
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="synopsis"></a>

# Synopsis

```

 llvm-pdbutil [subcommand] [options]
```

<a name="description"></a>

# Description


Display types, symbols, CodeView records, and other information from a
PDB file, as well as manipulate and create PDB files.  **llvm-pdbutil**
is normally used by FileCheck-based tests to test LLVM's PDB reading and
writing functionality, but can also be used for general PDB file investigation
and forensics, or as a replacement for cvdump.

<a name="subcommands"></a>

# Subcommands


**llvm-pdbutil** is separated into several subcommands each tailored to
a different purpose.  A brief summary of each command follows, with more detail
in the sections that follow.
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  _pretty_ - Dump symbol and type information in a format that
  tries to look as much like the original source code as possible.
* ·  
  _dump_ - Dump low level types and structures from the PDB
  file, including CodeView records, hash tables, PDB streams, etc.
* ·  
  _bytes_ - Dump data from the PDB file's streams, records,
  types, symbols, etc as raw bytes.
* ·  
  _yaml2pdb_ - Given a yaml description of a PDB file, produce
  a valid PDB file that matches that description.
* ·  
  _pdb2yaml_ - For a given PDB file, produce a YAML
  description of some or all of the file in a way that the PDB can be
  reconstructed.
* ·  
  _merge_ - Given two PDBs, produce a third PDB that is the
  result of merging the two input PDBs.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="pretty"></a>

### pretty


**IMPORTANT:**
.INDENT 0.0
.INDENT 3.5
The **pretty** subcommand is built on the Windows DIA SDK, and as such is not
supported on non-Windows platforms.
.UNINDENT
.UNINDENT

USAGE: **llvm-pdbutil** pretty [_options_] &lt;input PDB file&gt;

<a name="summary"></a>

### Summary


The _pretty_ subcommand displays a very high level representation of your
program's debug info.  Since it is built on the Windows DIA SDK which is the
standard API that Windows tools and debuggers query debug information, it
presents a more authoritative view of how a debugger is going to interpret your
debug information than a mode which displays low-level CodeView records.

<a name="options"></a>

### Options


<a name="filtering-and-sorting-options"></a>

### Filtering and Sorting Options


**NOTE:**
.INDENT 0.0
.INDENT 3.5
_exclude_ filters take priority over _include_ filters.  So if a filter
matches both an include and an exclude rule, then it is excluded.
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-exclude-compilands=&lt;string&gt;**  
  When dumping compilands, compiland source-file contributions, or per-compiland
  symbols, this option instructs **llvm-pdbutil** to omit any compilands that
  match the specified regular expression.
  .UNINDENT
  .INDENT 0.0
* **-exclude-symbols=&lt;string&gt;**  
  When dumping global, public, or per-compiland symbols, this option instructs
  **llvm-pdbutil** to omit any symbols that match the specified regular
  expression.
  .UNINDENT
  .INDENT 0.0
* **-exclude-types=&lt;string&gt;**  
  When dumping types, this option instructs **llvm-pdbutil** to omit any types
  that match the specified regular expression.
  .UNINDENT
  .INDENT 0.0
* **-include-compilands=&lt;string&gt;**  
  When dumping compilands, compiland source-file contributions, or per-compiland
  symbols, limit the initial search to only those compilands that match the
  specified regular expression.
  .UNINDENT
  .INDENT 0.0
* **-include-symbols=&lt;string&gt;**  
  When dumping global, public, or per-compiland symbols, limit the initial
  search to only those symbols that match the specified regular expression.
  .UNINDENT
  .INDENT 0.0
* **-include-types=&lt;string&gt;**  
  When dumping types, limit the initial search to only those types that match
  the specified regular expression.
  .UNINDENT
  .INDENT 0.0
* **-min-class-padding=&lt;uint&gt;**  
  Only display types that have at least the specified amount of alignment
  padding, accounting for padding in base classes and aggregate field members.
  .UNINDENT
  .INDENT 0.0
* **-min-class-padding-imm=&lt;uint&gt;**  
  Only display types that have at least the specified amount of alignment
  padding, ignoring padding in base classes and aggregate field members.
  .UNINDENT
  .INDENT 0.0
* **-min-type-size=&lt;uint&gt;**  
  Only display types T where sizeof(T) is greater than or equal to the specified
  amount.
  .UNINDENT
  .INDENT 0.0
* **-no-compiler-generated**  
  Don't show compiler generated types and symbols
  .UNINDENT
  .INDENT 0.0
* **-no-enum-definitions**  
  When dumping an enum, don't show the full enum (e.g. the individual enumerator
  values).
  .UNINDENT
  .INDENT 0.0
* **-no-system-libs**  
  Don't show symbols from system libraries
  .UNINDENT

<a name="symbol-type-options"></a>

### Symbol Type Options

.INDENT 0.0

* **-all**  
  Implies all other options in this category.
  .UNINDENT
  .INDENT 0.0
* **-class-definitions=&lt;format&gt;**  
  Displays class definitions in the specified format.
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =all      - Display all class members including data, constants, typedefs, functions, etc (default)
    =layout   - Only display members that contribute to class size.
    =none     - Don't display class definitions (e.g. only display the name and base list)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-class-order**  
  Displays classes in the specified order.
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =none            - Undefined / no particular sort order (default)
    =name            - Sort classes by name
    =size            - Sort classes by size
    =padding         - Sort classes by amount of padding
    =padding-pct     - Sort classes by percentage of space consumed by padding
    =padding-imm     - Sort classes by amount of immediate padding
    =padding-pct-imm - Sort classes by percentage of space consumed by immediate padding
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-class-recurse-depth=&lt;uint&gt;**  
  When dumping class definitions, stop after recursing the specified number of times.  The
  default is 0, which is no limit.
  .UNINDENT
  .INDENT 0.0
* **-classes**  
  Display classes
  .UNINDENT
  .INDENT 0.0
* **-compilands**  
  Display compilands (e.g. object files)
  .UNINDENT
  .INDENT 0.0
* **-enums**  
  Display enums
  .UNINDENT
  .INDENT 0.0
* **-externals**  
  Dump external (e.g. exported) symbols
  .UNINDENT
  .INDENT 0.0
* **-globals**  
  Dump global symbols
  .UNINDENT
  .INDENT 0.0
* **-lines**  
  Dump the mappings between source lines and code addresses.
  .UNINDENT
  .INDENT 0.0
* **-module-syms**  
  Display symbols (variables, functions, etc) for each compiland
  .UNINDENT
  .INDENT 0.0
* **-sym-types=&lt;types&gt;**  
  Type of symbols to dump when -globals, -externals, or -module-syms is
  specified. (default all)
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =thunks - Display thunk symbols
    =data   - Display data symbols
    =funcs  - Display function symbols
    =all    - Display all symbols (default)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-symbol-order=&lt;order&gt;**  
  For symbols dumped via the -module-syms, -globals, or -externals options, sort
  the results in specified order.
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =none - Undefined / no particular sort order
    =name - Sort symbols by name
    =size - Sort symbols by size
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-typedefs**  
  Display typedef types
  .UNINDENT
  .INDENT 0.0
* **-types**  
  Display all types (implies -classes, -enums, -typedefs)
  .UNINDENT

<a name="other-options"></a>

### Other Options

.INDENT 0.0

* **-color-output**  
  Force color output on or off.  By default, color if used if outputting to a
  terminal.
  .UNINDENT
  .INDENT 0.0
* **-load-address=&lt;uint&gt;**  
  When displaying relative virtual addresses, assume the process is loaded at the
  given address and display what would be the absolute address.
  .UNINDENT

<a name="dump"></a>

### dump


USAGE: **llvm-pdbutil** dump [_options_] &lt;input PDB file&gt;

<a name="summary"></a>

### Summary


The **dump** subcommand displays low level information about the structure of a
PDB file.  It is used heavily by LLVM's testing infrastructure, but can also be
used for PDB forensics.  It serves a role similar to that of Microsoft's
_cvdump_ tool.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **dump** subcommand exposes internal details of the file format.  As
such, the reader should be familiar with /PDB/index before using this
command.
.UNINDENT
.UNINDENT

<a name="options"></a>

### Options


<a name="msf-container-options"></a>

### MSF Container Options

.INDENT 0.0

* **-streams**  
  dump a summary of all of the streams in the PDB file.
  .UNINDENT
  .INDENT 0.0
* **-stream-blocks**  
  In conjunction with _-streams_, add information to the output about
  what blocks the specified stream occupies.
  .UNINDENT
  .INDENT 0.0
* **-summary**  
  Dump MSF and PDB header information.
  .UNINDENT

<a name="module-file-options"></a>

### Module & File Options

.INDENT 0.0

* **-modi=&lt;uint&gt;**  
  For all options that dump information from each module/compiland, limit to
  the specified module.
  .UNINDENT
  .INDENT 0.0
* **-files**  
  Dump the source files that contribute to each displayed module.
  .UNINDENT
  .INDENT 0.0
* **-il**  
  Dump inlinee line information (DEBUG_S_INLINEELINES CodeView subsection)
  .UNINDENT
  .INDENT 0.0
* **-l**  
  Dump line information (DEBUG_S_LINES CodeView subsection)
  .UNINDENT
  .INDENT 0.0
* **-modules**  
  Dump compiland information
  .UNINDENT
  .INDENT 0.0
* **-xme**  
  Dump cross module exports (DEBUG_S_CROSSSCOPEEXPORTS CodeView subsection)
  .UNINDENT
  .INDENT 0.0
* **-xmi**  
  Dump cross module imports (DEBUG_S_CROSSSCOPEIMPORTS CodeView subsection)
  .UNINDENT

<a name="symbol-options"></a>

### Symbol Options

.INDENT 0.0

* **-globals**  
  dump global symbol records
  .UNINDENT
  .INDENT 0.0
* **-global-extras**  
  dump additional information about the globals, such as hash buckets and hash
  values.
  .UNINDENT
  .INDENT 0.0
* **-publics**  
  dump public symbol records
  .UNINDENT
  .INDENT 0.0
* **-public-extras**  
  dump additional information about the publics, such as hash buckets and hash
  values.
  .UNINDENT
  .INDENT 0.0
* **-symbols**  
  dump symbols (functions, variables, etc) for each module dumped.
  .UNINDENT
  .INDENT 0.0
* **-sym-data**  
  For each symbol record dumped as a result of the _-symbols_ option,
  display the full bytes of the record in binary as well.
  .UNINDENT

<a name="type-record-options"></a>

### Type Record Options

.INDENT 0.0

* **-types**  
  Dump CodeView type records from TPI stream
  .UNINDENT
  .INDENT 0.0
* **-type-extras**  
  Dump additional information from the TPI stream, such as hashes and the type
  index offsets array.
  .UNINDENT
  .INDENT 0.0
* **-type-data**  
  For each type record dumped, display the full bytes of the record in binary as
  well.
  .UNINDENT
  .INDENT 0.0
* **-type-index=&lt;uint&gt;**  
  Only dump types with the specified type index.
  .UNINDENT
  .INDENT 0.0
* **-ids**  
  Dump CodeView type records from IPI stream.
  .UNINDENT
  .INDENT 0.0
* **-id-extras**  
  Dump additional information from the IPI stream, such as hashes and the type
  index offsets array.
  .UNINDENT
  .INDENT 0.0
* **-id-data**  
  For each ID record dumped, display the full bytes of the record in binary as
  well.
  .UNINDENT
  .INDENT 0.0
* **-id-index=&lt;uint&gt;**  
  only dump ID records with the specified hexadecimal type index.
  .UNINDENT
  .INDENT 0.0
* **-dependents**  
  When used in conjunction with _-type-index_ or _-id-index_,
  dumps the entire dependency graph for the specified index instead of just the
  single record with the specified index.  For example, if type index 0x4000 is
  a function whose return type has index 0x3000, and you specify
  _-dependents=0x4000_, then this would dump both records (as well as any other
  dependents in the tree).
  .UNINDENT

<a name="miscellaneous-options"></a>

### Miscellaneous Options

.INDENT 0.0

* **-all**  
  Implies most other options.
  .UNINDENT
  .INDENT 0.0
* **-section-contribs**  
  Dump section contributions.
  .UNINDENT
  .INDENT 0.0
* **-section-headers**  
  Dump image section headers.
  .UNINDENT
  .INDENT 0.0
* **-section-map**  
  Dump section map.
  .UNINDENT
  .INDENT 0.0
* **-string-table**  
  Dump PDB string table.
  .UNINDENT

<a name="bytes"></a>

### bytes


USAGE: **llvm-pdbutil** bytes [_options_] &lt;input PDB file&gt;

<a name="summary"></a>

### Summary


Like the **dump** subcommand, the **bytes** subcommand displays low level
information about the structure of a PDB file, but it is used for even deeper
forensics.  The **bytes** subcommand finds various structures in a PDB file
based on the command line options specified, and dumps them in hex.  Someone
working on support for emitting PDBs would use this heavily, for example, to
compare one PDB against another PDB to ensure byte-for-byte compatibility.  It
is not enough to simply compare the bytes of an entire file, or an entire stream
because it's perfectly fine for the same structure to exist at different
locations in two different PDBs, and "finding" the structure is half the battle.

<a name="options"></a>

### Options


<a name="msf-file-options"></a>

### MSF File Options

.INDENT 0.0

* **-block-range=&lt;start[-end]&gt;**  
  Dump binary data from specified range of MSF file blocks.
  .UNINDENT
  .INDENT 0.0
* **-byte-range=&lt;start[-end]&gt;**  
  Dump binary data from specified range of bytes in the file.
  .UNINDENT
  .INDENT 0.0
* **-fpm**  
  Dump the MSF free page map.
  .UNINDENT
  .INDENT 0.0
* **-stream-data=&lt;string&gt;**  
  Dump binary data from the specified streams.  Format is SN[:Start][@Size].
  For example, _-stream-data=7:3@12_ dumps 12 bytes from stream 7, starting
  at offset 3 in the stream.
  .UNINDENT

<a name="pdb-stream-options"></a>

### PDB Stream Options

.INDENT 0.0

* **-name-map**  
  Dump bytes of PDB Name Map
  .UNINDENT

<a name="dbi-stream-options"></a>

### DBI Stream Options

.INDENT 0.0

* **-ec**  
  Dump the edit and continue map substream of the DBI stream.
  .UNINDENT
  .INDENT 0.0
* **-files**  
  Dump the file info substream of the DBI stream.
  .UNINDENT
  .INDENT 0.0
* **-modi**  
  Dump the modi substream of the DBI stream.
  .UNINDENT
  .INDENT 0.0
* **-sc**  
  Dump section contributions substream of the DBI stream.
  .UNINDENT
  .INDENT 0.0
* **-sm**  
  Dump the section map from the DBI stream.
  .UNINDENT
  .INDENT 0.0
* **-type-server**  
  Dump the type server map from the DBI stream.
  .UNINDENT

<a name="module-options"></a>

### Module Options

.INDENT 0.0

* **-mod=&lt;uint&gt;**  
  Limit all options in this category to the specified module index.  By default,
  options in this category will dump bytes from all modules.
  .UNINDENT
  .INDENT 0.0
* **-chunks**  
  Dump the bytes of each module's C13 debug subsection.
  .UNINDENT
  .INDENT 0.0
* **-split-chunks**  
  When specified with _-chunks_, split the C13 debug subsection into a
  separate chunk for each subsection type, and dump them separately.
  .UNINDENT
  .INDENT 0.0
* **-syms**  
  Dump the symbol record substream from each module.
  .UNINDENT

<a name="type-record-options"></a>

### Type Record Options

.INDENT 0.0

* **-id=&lt;uint&gt;**  
  Dump the record from the IPI stream with the given type index.
  .UNINDENT
  .INDENT 0.0
* **-type=&lt;uint&gt;**  
  Dump the record from the TPI stream with the given type index.
  .UNINDENT

<a name="pdb2yaml"></a>

### pdb2yaml


USAGE: **llvm-pdbutil** pdb2yaml [_options_] &lt;input PDB file&gt;

<a name="summary"></a>

### Summary


<a name="options"></a>

### Options


<a name="yaml2pdb"></a>

### yaml2pdb


USAGE: **llvm-pdbutil** yaml2pdb [_options_] &lt;input YAML file&gt;

<a name="summary"></a>

### Summary


Generate a PDB file from a YAML description.  The YAML syntax is not described
here.  Instead, use _llvm-pdbutil pdb2yaml_ and
examine the output for an example starting point.

<a name="options"></a>

### Options

.INDENT 0.0

* **-pdb=&lt;file-name&gt;**  
  .UNINDENT

Write the resulting PDB to the specified file.

<a name="merge"></a>

### merge


USAGE: **llvm-pdbutil** merge [_options_] &lt;input PDB file 1&gt; &lt;input PDB file 2&gt;

<a name="summary"></a>

### Summary


Merge two PDB files into a single file.

<a name="options"></a>

### Options

.INDENT 0.0

* **-pdb=&lt;file-name&gt;**  
  .UNINDENT

Write the resulting PDB to the specified file.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

