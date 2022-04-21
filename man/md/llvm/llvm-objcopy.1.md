# llvm-objcopy(1) - object copying and editing tool

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

 llvm-objcopy [options] input [output]
```

<a name="description"></a>

# Description


**llvm-objcopy** is a tool to copy and manipulate objects. In basic
usage, it makes a semantic copy of the input to the output. If any options are
specified, the output may be modified along the way, e.g. by removing sections.

If no output file is specified, the input file is modified in-place. If "-" is
specified for the input file, the input is read from the program's standard
input stream. If "-" is specified for the output file, the output is written to
the standard output stream of the program.

If the input is an archive, any requested operations will be applied to each
archive member individually.

The tool is still in active development, but in most scenarios it works as a
drop-in replacement for GNU's **objcopy**.

<a name="generic-and-cross-platform-options"></a>

# Generic and Cross-Platform Options


The following options are either agnostic of the file format, or apply to
multiple file formats.
.INDENT 0.0

* **--add-gnu-debuglink &lt;debug-file&gt;**  
  Add a .gnu_debuglink section for **&lt;debug-file&gt;** to the output.
  .UNINDENT
  .INDENT 0.0
* **--add-section &lt;section=file&gt;**  
  Add a section named **&lt;section&gt;** with the contents of **&lt;file&gt;** to the
  output. For ELF objects the section will be of type _SHT\_NOTE_, if the name
  starts with ".note". Otherwise, it will have type _SHT\_PROGBITS_. Can be
  specified multiple times to add multiple sections.

For MachO objects, **&lt;section&gt;** must be formatted as
**&lt;segment name&gt;,&lt;section name&gt;**.
.UNINDENT
.INDENT 0.0

* **--binary-architecture &lt;arch&gt;, -B**  
  Ignored for compatibility.
  .UNINDENT
  .INDENT 0.0
* **--disable-deterministic-archives, -U**  
  Use real values for UIDs, GIDs and timestamps when updating archive member
  headers.
  .UNINDENT
  .INDENT 0.0
* **--discard-all, -x**  
  Remove most local symbols from the output. Different file formats may limit
  this to a subset of the local symbols. For example, file and section symbols in
  ELF objects will not be discarded.
  .UNINDENT
  .INDENT 0.0
* **--dump-section &lt;section&gt;=&lt;file&gt;**  
  Dump the contents of section **&lt;section&gt;** into the file **&lt;file&gt;**. Can be
  specified multiple times to dump multiple sections to different files.
  **&lt;file&gt;** is unrelated to the input and output files provided to
  **llvm-objcopy** and as such the normal copying and editing
  operations will still be performed. No operations are performed on the sections
  prior to dumping them.

For MachO objects, **&lt;section&gt;** must be formatted as
**&lt;segment name&gt;,&lt;section name&gt;**.
.UNINDENT
.INDENT 0.0

* **--enable-deterministic-archives, -D**  
  Enable deterministic mode when copying archives, i.e. use 0 for archive member
  header UIDs, GIDs and timestamp fields. On by default.
  .UNINDENT
  .INDENT 0.0
* **--help, -h**  
  Print a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **--only-keep-debug**  
  Produce a debug file as the output that only preserves contents of sections
  useful for debugging purposes.

For ELF objects, this removes the contents of _SHF\_ALLOC_ sections that are not
_SHT\_NOTE_ by making them _SHT\_NOBITS_ and shrinking the program headers where
possible.
.UNINDENT
.INDENT 0.0

* **--only-section &lt;section&gt;, -j**  
  Remove all sections from the output, except for sections named **&lt;section&gt;**.
  Can be specified multiple times to keep multiple sections.

For MachO objects, **&lt;section&gt;** must be formatted as
**&lt;segment name&gt;,&lt;section name&gt;**.
.UNINDENT
.INDENT 0.0

* **--redefine-sym &lt;old&gt;=&lt;new&gt;**  
  Rename symbols called **&lt;old&gt;** to **&lt;new&gt;** in the output. Can be specified
  multiple times to rename multiple symbols.
  .UNINDENT
  .INDENT 0.0
* **--redefine-syms &lt;filename&gt;**  
  Rename symbols in the output as described in the file **&lt;filename&gt;**. In the
  file, each line represents a single symbol to rename, with the old name and new
  name separated by whitespace. Leading and trailing whitespace is ignored, as is
  anything following a '#'. Can be specified multiple times to read names from
  multiple files.
  .UNINDENT
  .INDENT 0.0
* **--regex**  
  If specified, symbol and section names specified by other switches are treated
  as extended POSIX regular expression patterns.
  .UNINDENT
  .INDENT 0.0
* **--remove-section &lt;section&gt;, -R**  
  Remove the specified section from the output. Can be specified multiple times
  to remove multiple sections simultaneously.

For MachO objects, **&lt;section&gt;** must be formatted as
**&lt;segment name&gt;,&lt;section name&gt;**.
.UNINDENT
.INDENT 0.0

* **--set-section-alignment &lt;section&gt;=&lt;align&gt;**  
  Set the alignment of section **&lt;section&gt;** to _&lt;align&gt;\`_. Can be specified
  multiple times to update multiple sections.
  .UNINDENT
  .INDENT 0.0
* **--set-section-flags &lt;section&gt;=&lt;flag&gt;[,&lt;flag&gt;,...]**  
  Set section properties in the output of section **&lt;section&gt;** based on the
  specified **&lt;flag&gt;** values. Can be specified multiple times to update multiple
  sections.

Supported flag names are _alloc_, _load_, _noload_, _readonly_, _exclude_,
_debug_, _code_, _data_, _rom_, _share_, _contents_, _merge_ and _strings_. Not
all flags are meaningful for all object file formats.

For ELF objects, the flags have the following effects:
.INDENT 7.0

* ·  
  _alloc_ = add the _SHF\_ALLOC_ flag.
* ·  
  _load_ = if the section has _SHT\_NOBITS_ type, mark it as a _SHT\_PROGBITS_
  section.
* ·  
  _readonly_ = if this flag is not specified, add the _SHF\_WRITE_ flag.
* ·  
  _exclude_ = add the _SHF\_EXCLUDE_ flag.
* ·  
  _code_ = add the _SHF\_EXECINSTR_ flag.
* ·  
  _merge_ = add the _SHF\_MERGE_ flag.
* ·  
  _strings_ = add the _SHF\_STRINGS_ flag.
* ·  
  _contents_ = if the section has _SHT\_NOBITS_ type, mark it as a _SHT\_PROGBITS_
  section.
  .UNINDENT

For COFF objects, the flags have the following effects:
.INDENT 7.0

* ·  
  _alloc_ = add the _IMAGE\_SCN\_CNT\_UNINITIALIZED\_DATA_ and _IMAGE\_SCN\_MEM\_READ_
  flags, unless the _load_ flag is specified.
* ·  
  _noload_ = add the _IMAGE\_SCN\_LNK\_REMOVE_ and _IMAGE\_SCN\_MEM\_READ_ flags.
* ·  
  _readonly_ = if this flag is not specified, add the _IMAGE\_SCN\_MEM\_WRITE_
  flag.
* ·  
  _exclude_ = add the _IMAGE\_SCN\_LNK\_REMOVE_ and _IMAGE\_SCN\_MEM\_READ_ flags.
* ·  
  _debug_ = add the _IMAGE\_SCN\_CNT\_INITIALIZED\_DATA_,
  _IMAGE\_SCN\_MEM\_DISCARDABLE_ and  _IMAGE\_SCN\_MEM\_READ_ flags.
* ·  
  _code_ = add the _IMAGE\_SCN\_CNT\_CODE_, _IMAGE\_SCN\_MEM\_EXECUTE_ and
  _IMAGE\_SCN\_MEM\_READ_ flags.
* ·  
  _data_ = add the _IMAGE\_SCN\_CNT\_INITIALIZED\_DATA_ and _IMAGE\_SCN\_MEM\_READ_
  flags.
* ·  
  _share_ = add the _IMAGE\_SCN\_MEM\_SHARED_ and _IMAGE\_SCN\_MEM\_READ_ flags.
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **--strip-all-gnu**  
  Remove all symbols, debug sections and relocations from the output. This option
  is equivalent to GNU **objcopy**'s **--strip-all** switch.
  .UNINDENT
  .INDENT 0.0
* **--strip-all, -S**  
  For ELF objects, remove from the output all symbols and non-alloc sections not
  within segments, except for .gnu.warning, .ARM.attribute sections and the
  section name table.

For COFF and Mach-O objects, remove all symbols, debug sections, and
relocations from the output.
.UNINDENT
.INDENT 0.0

* **--strip-debug, -g**  
  Remove all debug sections from the output.
  .UNINDENT
  .INDENT 0.0
* **--strip-symbol &lt;symbol&gt;, -N**  
  Remove all symbols named **&lt;symbol&gt;** from the output. Can be specified
  multiple times to remove multiple symbols.
  .UNINDENT
  .INDENT 0.0
* **--strip-symbols &lt;filename&gt;**  
  Remove all symbols whose names appear in the file **&lt;filename&gt;**, from the
  output. In the file, each line represents a single symbol name, with leading
  and trailing whitespace ignored, as is anything following a '#'. Can be
  specified multiple times to read names from multiple files.
  .UNINDENT
  .INDENT 0.0
* **--strip-unneeded-symbol &lt;symbol&gt;**  
  Remove from the output all symbols named **&lt;symbol&gt;** that are local or
  undefined and are not required by any relocation.
  .UNINDENT
  .INDENT 0.0
* **--strip-unneeded-symbols &lt;filename&gt;**  
  Remove all symbols whose names appear in the file **&lt;filename&gt;**, from the
  output, if they are local or undefined and are not required by any relocation.
  In the file, each line represents a single symbol name, with leading and
  trailing whitespace ignored, as is anything following a '#'. Can be specified
  multiple times to read names from multiple files.
  .UNINDENT
  .INDENT 0.0
* **--strip-unneeded**  
  Remove from the output all local or undefined symbols that are not required by
  relocations. Also remove all debug sections.
  .UNINDENT
  .INDENT 0.0
* **--version, -V**  
  Display the version of the **llvm-objcopy** executable.
  .UNINDENT
  .INDENT 0.0
* **--wildcard, -w**  
  Allow wildcard syntax for symbol-related flags. On by default for
  section-related flags. Incompatible with --regex.

Wildcard syntax allows the following special symbols:
.TS
center;
|l|l|l|.
_
T{
Character
T}	T{
Meaning
T}	T{
Equivalent
T}
_
T{
<b>\*</b>
T}	T{
Any number of characters
T}	T{
**.***
T}
_
T{
**?**
T}	T{
Any single character
T}	T{
**.**
T}
_
T{
**\e**
T}	T{
Escape the next character
T}	T{
**\e**
T}
_
T{
**[a-z]**
T}	T{
Character class
T}	T{
**[a-z]**
T}
_
T{
**[!a-z]**, **[^a-z]**
T}	T{
Negated character class
T}	T{
**[^a-z]**
T}
_
.TE

Additionally, starting a wildcard with '!' will prevent a match, even if
another flag matches. For example **-w -N '*' -N '!x'** will strip all symbols
except for **x**.

The order of wildcards does not matter. For example, **-w -N '*' -N '!x'** is
the same as **-w -N '!x' -N '*'**.
.UNINDENT
.INDENT 0.0

* **@&lt;FILE&gt;**  
  Read command-line options and commands from response file _&lt;FILE&gt;_.
  .UNINDENT

<a name="elf-specific-options"></a>

# Elf-Specific Options


The following options are implemented only for ELF objects. If used with other
objects, **llvm-objcopy** will either emit an error or silently ignore
them.
.INDENT 0.0

* **--add-symbol &lt;name&gt;=[&lt;section&gt;:]&lt;value&gt;[,&lt;flags&gt;]**  
  Add a new symbol called **&lt;name&gt;** to the output symbol table, in the section
  named **&lt;section&gt;**, with value **&lt;value&gt;**. If **&lt;section&gt;** is not specified,
  the symbol is added as an absolute symbol. The **&lt;flags&gt;** affect the symbol
  properties. Accepted values are:
  .INDENT 7.0
* ·  
  _global_ = the symbol will have global binding.
* ·  
  _local_ = the symbol will have local binding.
* ·  
  _weak_ = the symbol will have weak binding.
* ·  
  _default_ = the symbol will have default visibility.
* ·  
  _hidden_ = the symbol will have hidden visibility.
* ·  
  _protected_ = the symbol will have protected visibility.
* ·  
  _file_ = the symbol will be an _STT\_FILE_ symbol.
* ·  
  _section_ = the symbol will be an _STT\_SECTION_ symbol.
* ·  
  _object_ = the symbol will be an _STT\_OBJECT_ symbol.
* ·  
  _function_ = the symbol will be an _STT\_FUNC_ symbol.
* ·  
  _indirect-function_ = the symbol will be an _STT\_GNU\_IFUNC_ symbol.
  .UNINDENT

Additionally, the following flags are accepted but ignored: _debug_,
_constructor_, _warning_, _indirect_, _synthetic_, _unique-object_, _before_.

Can be specified multiple times to add multiple symbols.
.UNINDENT
.INDENT 0.0

* **--allow-broken-links**  
  Allow **llvm-objcopy** to remove sections even if it would leave invalid
  section references. Any invalid sh_link fields will be set to zero.
  .UNINDENT
  .INDENT 0.0
* **--build-id-link-dir &lt;dir&gt;**  
  Set the directory used by _--build-id-link-input_ and
  _--build-id-link-output_.
  .UNINDENT
  .INDENT 0.0
* **--build-id-link-input &lt;suffix&gt;**  
  Hard-link the input to **&lt;dir&gt;/xx/xxx&lt;suffix&gt;**, where **&lt;dir&gt;** is the directory
  specified by _--build-id-link-dir_. The path used is derived from the
  hex build ID.
  .UNINDENT
  .INDENT 0.0
* **--build-id-link-output &lt;suffix&gt;**  
  Hard-link the output to **&lt;dir&gt;/xx/xxx&lt;suffix&gt;**, where **&lt;dir&gt;** is the directory
  specified by _--build-id-link-dir_. The path used is derived from the
  hex build ID.
  .UNINDENT
  .INDENT 0.0
* **--change-start &lt;incr&gt;, --adjust-start**  
  Add **&lt;incr&gt;** to the program's start address. Can be specified multiple
  times, in which case the values will be applied cumulatively.
  .UNINDENT
  .INDENT 0.0
* **--compress-debug-sections [&lt;style&gt;]**  
  Compress DWARF debug sections in the output, using the specified style.
  Supported styles are _zlib-gnu_ and _zlib_. Defaults to _zlib_ if no style is
  specified.
  .UNINDENT
  .INDENT 0.0
* **--decompress-debug-sections**  
  Decompress any compressed DWARF debug sections in the output.
  .UNINDENT
  .INDENT 0.0
* **--discard-locals, -X**  
  Remove local symbols starting with ".L" from the output.
  .UNINDENT
  .INDENT 0.0
* **--extract-dwo**  
  Remove all sections that are not DWARF .dwo sections from the output.
  .UNINDENT
  .INDENT 0.0
* **--extract-main-partition**  
  Extract the main partition from the output.
  .UNINDENT
  .INDENT 0.0
* **--extract-partition &lt;name&gt;**  
  Extract the named partition from the output.
  .UNINDENT
  .INDENT 0.0
* **--globalize-symbol &lt;symbol&gt;**  
  Mark any defined symbols named **&lt;symbol&gt;** as global symbols in the output.
  Can be specified multiple times to mark multiple symbols.
  .UNINDENT
  .INDENT 0.0
* **--globalize-symbols &lt;filename&gt;**  
  Read a list of names from the file **&lt;filename&gt;** and mark defined symbols with
  those names as global in the output. In the file, each line represents a single
  symbol, with leading and trailing whitespace ignored, as is anything following
  a '#'. Can be specified multiple times to read names from multiple files.
  .UNINDENT
  .INDENT 0.0
* **--input-target &lt;format&gt;, -I**  
  Read the input as the specified format. See _SUPPORTED FORMATS_ for a list of
  valid **&lt;format&gt;** values. If unspecified, **llvm-objcopy** will attempt
  to determine the format automatically.
  .UNINDENT
  .INDENT 0.0
* **--keep-file-symbols**  
  Keep symbols of type _STT\_FILE_, even if they would otherwise be stripped.
  .UNINDENT
  .INDENT 0.0
* **--keep-global-symbol &lt;symbol&gt;**  
  Make all symbols local in the output, except for symbols with the name
  **&lt;symbol&gt;**. Can be specified multiple times to ignore multiple symbols.
  .UNINDENT
  .INDENT 0.0
* **--keep-global-symbols &lt;filename&gt;**  
  Make all symbols local in the output, except for symbols named in the file
  **&lt;filename&gt;**. In the file, each line represents a single symbol, with leading
  and trailing whitespace ignored, as is anything following a '#'. Can be
  specified multiple times to read names from multiple files.
  .UNINDENT
  .INDENT 0.0
* **--keep-section &lt;section&gt;**  
  When removing sections from the output, do not remove sections named
  **&lt;section&gt;**. Can be specified multiple times to keep multiple sections.
  .UNINDENT
  .INDENT 0.0
* **--keep-symbol &lt;symbol&gt;, -K**  
  When removing symbols from the output, do not remove symbols named
  **&lt;symbol&gt;**. Can be specified multiple times to keep multiple symbols.
  .UNINDENT
  .INDENT 0.0
* **--keep-symbols &lt;filename&gt;**  
  When removing symbols from the output do not remove symbols named in the file
  **&lt;filename&gt;**. In the file, each line represents a single symbol, with leading
  and trailing whitespace ignored, as is anything following a '#'. Can be
  specified multiple times to read names from multiple files.
  .UNINDENT
  .INDENT 0.0
* **--localize-hidden**  
  Make all symbols with hidden or internal visibility local in the output.
  .UNINDENT
  .INDENT 0.0
* **--localize-symbol &lt;symbol&gt;, -L**  
  Mark any defined non-common symbol named **&lt;symbol&gt;** as a local symbol in the
  output. Can be specified multiple times to mark multiple symbols as local.
  .UNINDENT
  .INDENT 0.0
* **--localize-symbols &lt;filename&gt;**  
  Read a list of names from the file **&lt;filename&gt;** and mark defined non-common
  symbols with those names as local in the output. In the file, each line
  represents a single symbol, with leading and trailing whitespace ignored, as is
  anything following a '#'. Can be specified multiple times to read names from
  multiple files.
  .UNINDENT
  .INDENT 0.0
* **--new-symbol-visibility &lt;visibility&gt;**  
  Specify the visibility of the symbols automatically created when using binary
  input or _--add-symbol_. Valid options are:
  .INDENT 7.0
* ·  
  _default_
* ·  
  _hidden_
* ·  
  _internal_
* ·  
  _protected_
  .UNINDENT

The default is _default_.
.UNINDENT
.INDENT 0.0

* **--output-target &lt;format&gt;, -O**  
  Write the output as the specified format. See _SUPPORTED FORMATS_ for a list
  of valid **&lt;format&gt;** values. If unspecified, the output format is assumed to
  be the same as the value specified for _--input-target_ or the input
  file's format if that option is also unspecified.
  .UNINDENT
  .INDENT 0.0
* **--prefix-alloc-sections &lt;prefix&gt;**  
  Add **&lt;prefix&gt;** to the front of the names of all allocatable sections in the
  output.
  .UNINDENT
  .INDENT 0.0
* **--prefix-symbols &lt;prefix&gt;**  
  Add **&lt;prefix&gt;** to the front of every symbol name in the output.
  .UNINDENT
  .INDENT 0.0
* **--preserve-dates, -p**  
  Preserve access and modification timestamps in the output.
  .UNINDENT
  .INDENT 0.0
* **--rename-section &lt;old&gt;=&lt;new&gt;[,&lt;flag&gt;,...]**  
  Rename sections called **&lt;old&gt;** to **&lt;new&gt;** in the output, and apply any
  specified **&lt;flag&gt;** values. See _--set-section-flags_ for a list of
  supported flags. Can be specified multiple times to rename multiple sections.
  .UNINDENT
  .INDENT 0.0
* **--set-start-addr &lt;addr&gt;**  
  Set the start address of the output to **&lt;addr&gt;**. Overrides any previously
  specified _--change-start_ or _--adjust-start_ options.
  .UNINDENT
  .INDENT 0.0
* **--split-dwo &lt;dwo-file&gt;**  
  Equivalent to running **llvm-objcopy** with _--extract-dwo_ and
  **&lt;dwo-file&gt;** as the output file and no other options, and then with
  _--strip-dwo_ on the input file.
  .UNINDENT
  .INDENT 0.0
* **--strip-dwo**  
  Remove all DWARF .dwo sections from the output.
  .UNINDENT
  .INDENT 0.0
* **--strip-non-alloc**  
  Remove from the output all non-allocatable sections that are not within
  segments.
  .UNINDENT
  .INDENT 0.0
* **--strip-sections**  
  Remove from the output all section headers and all section data not within
  segments. Note that many tools will not be able to use an object without
  section headers.
  .UNINDENT
  .INDENT 0.0
* **--target &lt;format&gt;, -F**  
  Equivalent to _--input-target_ and _--output-target_ for the
  specified format. See _SUPPORTED FORMATS_ for a list of valid **&lt;format&gt;**
  values.
  .UNINDENT
  .INDENT 0.0
* **--weaken-symbol &lt;symbol&gt;, -W**  
  Mark any global symbol named **&lt;symbol&gt;** as a weak symbol in the output. Can
  be specified multiple times to mark multiple symbols as weak.
  .UNINDENT
  .INDENT 0.0
* **--weaken-symbols &lt;filename&gt;**  
  Read a list of names from the file **&lt;filename&gt;** and mark global symbols with
  those names as weak in the output. In the file, each line represents a single
  symbol, with leading and trailing whitespace ignored, as is anything following
  a '#'. Can be specified multiple times to read names from multiple files.
  .UNINDENT
  .INDENT 0.0
* **--weaken**  
  Mark all defined global symbols as weak in the output.
  .UNINDENT

<a name="supported-formats"></a>

# Supported Formats


The following values are currently supported by **llvm-objcopy** for the
_--input-target_, _--output-target_, and _--target_
options. For GNU **objcopy** compatibility, the values are all bfdnames.
.INDENT 0.0

* ·  
  _binary_
* ·  
  _ihex_
* ·  
  _elf32-i386_
* ·  
  _elf32-x86-64_
* ·  
  _elf64-x86-64_
* ·  
  _elf32-iamcu_
* ·  
  _elf32-littlearm_
* ·  
  _elf64-aarch64_
* ·  
  _elf64-littleaarch64_
* ·  
  _elf32-littleriscv_
* ·  
  _elf64-littleriscv_
* ·  
  _elf32-powerpc_
* ·  
  _elf32-powerpcle_
* ·  
  _elf64-powerpc_
* ·  
  _elf64-powerpcle_
* ·  
  _elf32-bigmips_
* ·  
  _elf32-ntradbigmips_
* ·  
  _elf32-ntradlittlemips_
* ·  
  _elf32-tradbigmips_
* ·  
  _elf32-tradlittlemips_
* ·  
  _elf64-tradbigmips_
* ·  
  _elf64-tradlittlemips_
* ·  
  _elf32-sparc_
* ·  
  _elf32-sparcel_
  .UNINDENT

Additionally, all targets except _binary_ and _ihex_ can have _-freebsd_ as a
suffix.

<a name="binary-input-and-output"></a>

# Binary Input and Output


If _binary_ is used as the value for _--input-target_, the input file
will be embedded as a data section in an ELF relocatable object, with symbols
**\_binary\_&lt;file\_name&gt;\_start**, **\_binary\_&lt;file\_name&gt;\_end**, and
**\_binary\_&lt;file\_name&gt;\_size** representing the start, end and size of the data,
where **&lt;file\_name&gt;** is the path of the input file as specified on the command
line with non-alphanumeric characters converted to **\_**.

If _binary_ is used as the value for _--output-target_, the output file
will be a raw binary file, containing the memory image of the input file.
Symbols and relocation information will be discarded. The image will start at
the address of the first loadable section in the output.

<a name="exit-status"></a>

# Exit Status


**llvm-objcopy** exits with a non-zero exit code if there is an error.
Otherwise, it exits with code 0.

<a name="bugs"></a>

# Bugs


To report bugs, please visit &lt;_https://bugs.llvm.org/_&gt;.

There is a known issue with _--input-target_ and _--target_
causing only **binary** and **ihex** formats to have any effect. Other values
will be ignored and **llvm-objcopy** will attempt to guess the input
format.

<a name="see-also"></a>

# See Also


**llvm-strip(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

