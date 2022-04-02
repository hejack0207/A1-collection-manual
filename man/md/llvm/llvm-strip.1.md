# llvm-strip(1) - object stripping tool

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

 llvm-strip [options] inputs...
```

<a name="description"></a>

# Description


**llvm-strip** is a tool to strip sections and symbols from object files.
If no other stripping or remove options are specified, _--strip-all_
will be enabled.

By default, the input files are modified in-place. If "-" is specified for the
input file, the input is read from the program's standard input stream.

If the input is an archive, any requested operations will be applied to each
archive member individually.

The tool is still in active development, but in most scenarios it works as a
drop-in replacement for GNU's **strip**.

<a name="generic-and-cross-platform-options"></a>

# Generic and Cross-Platform Options


The following options are either agnostic of the file format, or apply to
multiple file formats.
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
* **--enable-deterministic-archives, -D**  
  Enable deterministic mode when stripping archives, i.e. use 0 for archive member
  header UIDs, GIDs and timestamp fields. On by default.
  .UNINDENT
  .INDENT 0.0
* **--help, -h**  
  Print a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **--no-strip-all**  
  Disable _--strip-all_.
  .UNINDENT
  .INDENT 0.0
* **-o &lt;file&gt;**  
  Write output to &lt;file&gt;. Multiple input files cannot be used in combination
  with -o.
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
  .UNINDENT
  .INDENT 0.0
* **--strip-all-gnu**  
  Remove all symbols, debug sections and relocations from the output. This option
  is equivalent to GNU **strip**'s **--strip-all** switch.
  .UNINDENT
  .INDENT 0.0
* **--strip-all, -S**  
  For ELF objects, remove from the output all symbols and non-alloc sections not
  within segments, except for .gnu.warning, .ARM.attribute sections and the
  section name table.

For COFF objects, remove all symbols, debug sections, and relocations from the
output.
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
* **--strip-unneeded**  
  Remove from the output all local or undefined symbols that are not required by
  relocations. Also remove all debug sections.
  .UNINDENT
  .INDENT 0.0
* **--version, -V**  
  Display the version of the **llvm-strip** executable.
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

<a name="coff-specific-options"></a>

# Coff-Specific Options


The following options are implemented only for COFF objects. If used with other
objects, **llvm-strip** will either emit an error or silently ignore
them.
.INDENT 0.0

* **--only-keep-debug**  
  Remove the contents of non-debug sections from the output, but keep the section
  headers.
  .UNINDENT

<a name="elf-specific-options"></a>

# Elf-Specific Options


The following options are implemented only for ELF objects. If used with other
objects, **llvm-strip** will either emit an error or silently ignore
them.
.INDENT 0.0

* **--allow-broken-links**  
  Allow **llvm-strip** to remove sections even if it would leave invalid
  section references. Any invalid sh_link fields will be set to zero.
  .UNINDENT
  .INDENT 0.0
* **--discard-locals, -X**  
  Remove local symbols starting with ".L" from the output.
  .UNINDENT
  .INDENT 0.0
* **--keep-file-symbols**  
  Keep symbols of type _STT\_FILE_, even if they would otherwise be stripped.
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
* **--preserve-dates, -p**  
  Preserve access and modification timestamps in the output.
  .UNINDENT
  .INDENT 0.0
* **--strip-sections**  
  Remove from the output all section headers and all section data not within
  segments. Note that many tools will not be able to use an object without
  section headers.
  .UNINDENT
  .INDENT 0.0
* **-T**  
  Remove Swift symbols.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-strip** exits with a non-zero exit code if there is an error.
Otherwise, it exits with code 0.

<a name="bugs"></a>

# Bugs


To report bugs, please visit &lt;_https://bugs.llvm.org/_&gt;.

<a name="see-also"></a>

# See Also


**llvm-objcopy(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

