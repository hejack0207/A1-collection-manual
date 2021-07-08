# ld(1)

binutils-2.31.1, 2020-01-02

.if n .ad l
.nh

<a name="name"></a>

# Name

ld - The GNU linker

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" ld [options] objfile ...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**ld** combines a number of object and archive files, relocates
their data and ties up symbol references. Usually the last step in
compiling a program is to run **ld**.

**ld** accepts Linker Command Language files written in
a superset of \s-1AT&T\s0's Link Editor Command Language syntax,
to provide explicit and total control over the linking process.

This man page does not describe the command language; see the
**ld** entry in \f(CW`info\*(C' for full details on the command
language and on other aspects of the \s-1GNU\s0 linker.

This version of **ld** uses the general purpose \s-1BFD\s0 libraries
to operate on object files. This allows **ld** to read, combine, and
write object files in many different formats---for example, \s-1COFF\s0 or
\f(CW`a.out\*(C'.  Different formats may be linked together to produce any
available kind of object file.

Aside from its flexibility, the \s-1GNU\s0 linker is more helpful than other
linkers in providing diagnostic information.  Many linkers abandon
execution immediately upon encountering an error; whenever possible,
**ld** continues executing, allowing you to identify other errors
(or, in some cases, to get an output file in spite of the error).

The \s-1GNU\s0 linker **ld** is meant to cover a broad range of situations,
and to be as compatible as possible with other linkers.  As a result,
you have many choices to control its behavior.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The linker supports a plethora of command-line options, but in actual
practice few of them are used in any particular context.
For instance, a frequent use of **ld** is to link standard Unix
object files on a standard, supported Unix system.  On such a system, to
link a file \f(CW`hello.o\*(C':

.Vb 1
        ld -o &lt;output&gt; /lib/crt0.o hello.o -lc
.Ve

This tells **ld** to produce a file called _output_ as the
result of linking the file \f(CW`/lib/crt0.o\*(C' with \f(CW\*(C\`hello.o\*(C' and
the library \f(CW`libc.a\*(C', which will come from the standard search
directories.  (See the discussion of the **-l** option below.)

Some of the command-line options to **ld** may be specified at any
point in the command line.  However, options which refer to files, such
as **-l** or **-T**, cause the file to be read at the point at
which the option appears in the command line, relative to the object
files and other file options.  Repeating non-file options with a
different argument will either have no further effect, or override prior
occurrences (those further to the left on the command line) of that
option.  Options which may be meaningfully specified more than once are
noted in the descriptions below.

Non-option arguments are object files or archives which are to be linked
together.  They may follow, precede, or be mixed in with command-line
options, except that an object file argument may not be placed between
an option and its argument.

Usually the linker is invoked with at least one object file, but you can
specify other forms of binary input files using **-l**, **-R**,
and the script command language.  If _no_ binary input files at all
are specified, the linker does not produce any output, and issues the
message **No input files**.

If the linker cannot recognize the format of an object file, it will
assume that it is a linker script.  A script specified in this way
augments the main linker script used for the link (either the default
linker script or the one specified by using **-T**).  This feature
permits the linker to link against a file which appears to be an object
or an archive, but actually merely defines some symbol values, or uses
\f(CW`INPUT\*(C' or \f(CW\*(C\`GROUP\*(C' to load other objects.  Specifying a
script in this way merely augments the main linker script, with the
extra commands placed after the main script; use the **-T** option
to replace the default linker script entirely, but note the effect of
the \f(CW`INSERT\*(C' command.

For options whose names are a single letter,
option arguments must either follow the option letter without intervening
whitespace, or be given as separate arguments immediately following the
option that requires them.

For options whose names are multiple letters, either one dash or two can
precede the option name; for example, **-trace-symbol** and
**--trace-symbol** are equivalent.  Note---there is one exception to
this rule.  Multiple letter options that start with a lower case 'o' can
only be preceded by two dashes.  This is to reduce confusion with the
**-o** option.  So for example **-omagic** sets the output file
name to **magic** whereas **--omagic** sets the \s-1NMAGIC\s0 flag on the
output.

Arguments to multiple-letter options must either be separated from the
option name by an equals sign, or be given as separate arguments
immediately following the option that requires them.  For example,
**--trace-symbol foo** and **--trace-symbol=foo** are equivalent.
Unique abbreviations of the names of multiple-letter options are
accepted.

Note---if the linker is being invoked indirectly, via a compiler driver
(e.g. **gcc**) then all the linker command line options should be
prefixed by **-Wl,** (or whatever is appropriate for the particular
compiler driver) like this:

.Vb 1
          gcc -Wl,--start-group foo.o bar.o -Wl,--end-group
.Ve

This is important, because otherwise the compiler driver program may
silently drop the linker options, resulting in a bad link.  Confusion
may also arise when passing options that require values through a
driver, as the use of a space between option and argument acts as
a separator, and causes the driver to pass only the option to the linker
and the argument to the compiler.  In this case, it is simplest to use
the joined forms of both single- and multiple-letter options, such as:

.Vb 1
          gcc foo.o bar.o -Wl,-eENTRY -Wl,-Map=a.map
.Ve

Here is a table of the generic command line switches accepted by the \s-1GNU\s0
linker:

* **@**_file_  
  .IX Item "@file"
  Read command-line options from _file_.  The options read are
  inserted in place of the original @_file_ option.  If _file_
  does not exist, or cannot be read, then the option will be treated
  literally, and not removed.
  .Sp
  Options in _file_ are separated by whitespace.  A whitespace
  character may be included in an option by surrounding the entire
  option in either single or double quotes.  Any character (including a
  backslash) may be included by prefixing the character to be included
  with a backslash.  The _file_ may itself contain additional
  @_file_ options; any such options will be processed recursively.
* **-a** _keyword_  
  .IX Item "-a keyword"
  This option is supported for \s-1HP/UX\s0 compatibility.  The _keyword_
  argument must be one of the strings **archive**, **shared**, or
  **default**.  **-aarchive** is functionally equivalent to
  **-Bstatic**, and the other two keywords are functionally equivalent
  to **-Bdynamic**.  This option may be used any number of times.
* **--audit** _\s-1AUDITLIB\s0_  
  .IX Item "--audit AUDITLIB"
  Adds _\s-1AUDITLIB\s0_ to the \f(CW`DT\_AUDIT\*(C' entry of the dynamic section.
  _\s-1AUDITLIB\s0_ is not checked for existence, nor will it use the \s-1DT_SONAME\s0
  specified in the library.  If specified multiple times \f(CW`DT\_AUDIT\*(C'
  will contain a colon separated list of audit interfaces to use. If the linker
  finds an object with an audit entry while searching for shared libraries,
  it will add a corresponding \f(CW`DT\_DEPAUDIT\*(C' entry in the output file.
  This option is only meaningful on \s-1ELF\s0 platforms supporting the rtld-audit
  interface.
* **-b** _input-format_  
  .IX Item "-b input-format"
* **--format=**_input-format_  
  .IX Item "--format=input-format"
  **ld** may be configured to support more than one kind of object
  file.  If your **ld** is configured this way, you can use the
  **-b** option to specify the binary format for input object files
  that follow this option on the command line.  Even when **ld** is
  configured to support alternative object formats, you don't usually need
  to specify this, as **ld** should be configured to expect as a
  default input format the most usual format on each machine.
  _input-format_ is a text string, the name of a particular format
  supported by the \s-1BFD\s0 libraries.  (You can list the available binary
  formats with **objdump -i**.)
  .Sp
  You may want to use this option if you are linking files with an unusual
  binary format.  You can also use **-b** to switch formats explicitly (when
  linking object files of different formats), by including
  **-b** _input-format_ before each group of object files in a
  particular format.
  .Sp
  The default format is taken from the environment variable
  \f(CW`GNUTARGET\*(C'.
  .Sp
  You can also define the input format from a script, using the command
  \f(CW`TARGET\*(C';
* **-c** _MRI-commandfile_  
  .IX Item "-c MRI-commandfile"
* **--mri-script=**_MRI-commandfile_  
  .IX Item "--mri-script=MRI-commandfile"
  For compatibility with linkers produced by \s-1MRI,\s0 **ld** accepts script
  files written in an alternate, restricted command language, described in
  the \s-1MRI\s0 Compatible Script Files section of \s-1GNU\s0 ld documentation.
  Introduce \s-1MRI\s0 script files with
  the option **-c**; use the **-T** option to run linker
  scripts written in the general-purpose **ld** scripting language.
  If _MRI-cmdfile_ does not exist, **ld** looks for it in the directories
  specified by any **-L** options.
* **-d**  
  .IX Item "-d"
* **-dc**  
  .IX Item "-dc"
* **-dp**  
  .IX Item "-dp"
  These three options are equivalent; multiple forms are supported for
  compatibility with other linkers.  They assign space to common symbols
  even if a relocatable output file is specified (with **-r**).  The
  script command \f(CW`FORCE\_COMMON\_ALLOCATION\*(C' has the same effect.
* **--depaudit** _\s-1AUDITLIB\s0_  
  .IX Item "--depaudit AUDITLIB"
* **-P** _\s-1AUDITLIB\s0_  
  .IX Item "-P AUDITLIB"
  Adds _\s-1AUDITLIB\s0_ to the \f(CW`DT\_DEPAUDIT\*(C' entry of the dynamic section.
  _\s-1AUDITLIB\s0_ is not checked for existence, nor will it use the \s-1DT_SONAME\s0
  specified in the library.  If specified multiple times \f(CW`DT\_DEPAUDIT\*(C'
  will contain a colon separated list of audit interfaces to use.  This
  option is only meaningful on \s-1ELF\s0 platforms supporting the rtld-audit interface.
  The -P option is provided for Solaris compatibility.
* **-e** _entry_  
  .IX Item "-e entry"
* **--entry=**_entry_  
  .IX Item "--entry=entry"
  Use _entry_ as the explicit symbol for beginning execution of your
  program, rather than the default entry point.  If there is no symbol
  named _entry_, the linker will try to parse _entry_ as a number,
  and use that as the entry address (the number will be interpreted in
  base 10; you may use a leading **0x** for base 16, or a leading
  **0** for base 8).
* **--exclude-libs** _lib_**,**_lib_**,...**  
  .IX Item "--exclude-libs lib,lib,..."
  Specifies a list of archive libraries from which symbols should not be automatically
  exported.  The library names may be delimited by commas or colons.  Specifying
  \f(CW`--exclude-libs ALL\*(C' excludes symbols in all archive libraries from
  automatic export.  This option is available only for the i386 \s-1PE\s0 targeted
  port of the linker and for \s-1ELF\s0 targeted ports.  For i386 \s-1PE,\s0 symbols
  explicitly listed in a .def file are still exported, regardless of this
  option.  For \s-1ELF\s0 targeted ports, symbols affected by this option will
  be treated as hidden.
* **--exclude-modules-for-implib** _module_**,**_module_**,...**  
  .IX Item "--exclude-modules-for-implib module,module,..."
  Specifies a list of object files or archive members, from which symbols
  should not be automatically exported, but which should be copied wholesale
  into the import library being generated during the link.  The module names
  may be delimited by commas or colons, and must match exactly the filenames
  used by **ld** to open the files; for archive members, this is simply
  the member name, but for object files the name listed must include and
  match precisely any path used to specify the input file on the linker's
  command-line.  This option is available only for the i386 \s-1PE\s0 targeted port
  of the linker.  Symbols explicitly listed in a .def file are still exported,
  regardless of this option.
* **-E**  
  .IX Item "-E"
* **--export-dynamic**  
  .IX Item "--export-dynamic"
* **--no-export-dynamic**  
  .IX Item "--no-export-dynamic"
  When creating a dynamically linked executable, using the **-E**
  option or the **--export-dynamic** option causes the linker to add
  all symbols to the dynamic symbol table.  The dynamic symbol table is the
  set of symbols which are visible from dynamic objects at run time.
  .Sp
  If you do not use either of these options (or use the
  **--no-export-dynamic** option to restore the default behavior), the
  dynamic symbol table will normally contain only those symbols which are
  referenced by some dynamic object mentioned in the link.
  .Sp
  If you use \f(CW`dlopen\*(C' to load a dynamic object which needs to refer
  back to the symbols defined by the program, rather than some other
  dynamic object, then you will probably need to use this option when
  linking the program itself.
  .Sp
  You can also use the dynamic list to control what symbols should
  be added to the dynamic symbol table if the output format supports it.
  See the description of **--dynamic-list**.
  .Sp
  Note that this option is specific to \s-1ELF\s0 targeted ports.  \s-1PE\s0 targets
  support a similar function to export all symbols from a \s-1DLL\s0 or \s-1EXE\s0; see
  the description of **--export-all-symbols** below.
* **-EB**  
  .IX Item "-EB"
  Link big-endian objects.  This affects the default output format.
* **-EL**  
  .IX Item "-EL"
  Link little-endian objects.  This affects the default output format.
* **-f** _name_  
  .IX Item "-f name"
* **--auxiliary=**_name_  
  .IX Item "--auxiliary=name"
  When creating an \s-1ELF\s0 shared object, set the internal \s-1DT_AUXILIARY\s0 field
  to the specified name.  This tells the dynamic linker that the symbol
  table of the shared object should be used as an auxiliary filter on the
  symbol table of the shared object _name_.
  .Sp
  If you later link a program against this filter object, then, when you
  run the program, the dynamic linker will see the \s-1DT_AUXILIARY\s0 field.  If
  the dynamic linker resolves any symbols from the filter object, it will
  first check whether there is a definition in the shared object
  _name_.  If there is one, it will be used instead of the definition
  in the filter object.  The shared object _name_ need not exist.
  Thus the shared object _name_ may be used to provide an alternative
  implementation of certain functions, perhaps for debugging or for
  machine specific performance.
  .Sp
  This option may be specified more than once.  The \s-1DT_AUXILIARY\s0 entries
  will be created in the order in which they appear on the command line.
* **-F** _name_  
  .IX Item "-F name"
* **--filter=**_name_  
  .IX Item "--filter=name"
  When creating an \s-1ELF\s0 shared object, set the internal \s-1DT_FILTER\s0 field to
  the specified name.  This tells the dynamic linker that the symbol table
  of the shared object which is being created should be used as a filter
  on the symbol table of the shared object _name_.
  .Sp
  If you later link a program against this filter object, then, when you
  run the program, the dynamic linker will see the \s-1DT_FILTER\s0 field.  The
  dynamic linker will resolve symbols according to the symbol table of the
  filter object as usual, but it will actually link to the definitions
  found in the shared object _name_.  Thus the filter object can be
  used to select a subset of the symbols provided by the object
  _name_.
  .Sp
  Some older linkers used the **-F** option throughout a compilation
  toolchain for specifying object-file format for both input and output
  object files.
  The \s-1GNU\s0 linker uses other mechanisms for this purpose: the
  **-b**, **--format**, **--oformat** options, the
  \f(CW`TARGET\*(C' command in linker scripts, and the \f(CW\*(C\`GNUTARGET\*(C'
  environment variable.
  The \s-1GNU\s0 linker will ignore the **-F** option when not
  creating an \s-1ELF\s0 shared object.
* **-fini=**_name_  
  .IX Item "-fini=name"
  When creating an \s-1ELF\s0 executable or shared object, call \s-1NAME\s0 when the
  executable or shared object is unloaded, by setting \s-1DT_FINI\s0 to the
  address of the function.  By default, the linker uses \f(CW`\_fini\*(C' as
  the function to call.
* **-g**  
  .IX Item "-g"
  Ignored.  Provided for compatibility with other tools.
* **-G** _value_  
  .IX Item "-G value"
* **--gpsize=**_value_  
  .IX Item "--gpsize=value"
  Set the maximum size of objects to be optimized using the \s-1GP\s0 register to
  _size_.  This is only meaningful for object file formats such as
  \s-1MIPS ELF\s0 that support putting large and small objects into different
  sections.  This is ignored for other object file formats.
* **-h** _name_  
  .IX Item "-h name"
* **-soname=**_name_  
  .IX Item "-soname=name"
  When creating an \s-1ELF\s0 shared object, set the internal \s-1DT_SONAME\s0 field to
  the specified name.  When an executable is linked with a shared object
  which has a \s-1DT_SONAME\s0 field, then when the executable is run the dynamic
  linker will attempt to load the shared object specified by the \s-1DT_SONAME\s0
  field rather than the using the file name given to the linker.
* **-i**  
  .IX Item "-i"
  Perform an incremental link (same as option **-r**).
* **-init=**_name_  
  .IX Item "-init=name"
  When creating an \s-1ELF\s0 executable or shared object, call \s-1NAME\s0 when the
  executable or shared object is loaded, by setting \s-1DT_INIT\s0 to the address
  of the function.  By default, the linker uses \f(CW`\_init\*(C' as the
  function to call.
* **-l** _namespec_  
  .IX Item "-l namespec"
* **--library=**_namespec_  
  .IX Item "--library=namespec"
  Add the archive or object file specified by _namespec_ to the
  list of files to link.  This option may be used any number of times.
  If _namespec_ is of the form _:filename_, **ld**
  will search the library path for a file called _filename_, otherwise it
  will search the library path for a file called _libnamespec.a_.
  .Sp
  On systems which support shared libraries, **ld** may also search for
  files other than _libnamespec.a_.  Specifically, on \s-1ELF\s0
  and SunOS systems, **ld** will search a directory for a library
  called _libnamespec.so_ before searching for one called
  _libnamespec.a_.  (By convention, a \f(CW`.so\*(C' extension
  indicates a shared library.)  Note that this behavior does not apply
  to _:filename_, which always specifies a file called
  _filename_.
  .Sp
  The linker will search an archive only once, at the location where it is
  specified on the command line.  If the archive defines a symbol which
  was undefined in some object which appeared before the archive on the
  command line, the linker will include the appropriate file(s) from the
  archive.  However, an undefined symbol in an object appearing later on
  the command line will not cause the linker to search the archive again.
  .Sp
  See the **-(** option for a way to force the linker to search
  archives multiple times.
  .Sp
  You may list the same archive multiple times on the command line.
  .Sp
  This type of archive searching is standard for Unix linkers.  However,
  if you are using **ld** on \s-1AIX,\s0 note that it is different from the
  behaviour of the \s-1AIX\s0 linker.
* **-L** _searchdir_  
  .IX Item "-L searchdir"
* **--library-path=**_searchdir_  
  .IX Item "--library-path=searchdir"
  Add path _searchdir_ to the list of paths that **ld** will search
  for archive libraries and **ld** control scripts.  You may use this
  option any number of times.  The directories are searched in the order
  in which they are specified on the command line.  Directories specified
  on the command line are searched before the default directories.  All
  **-L** options apply to all **-l** options, regardless of the
  order in which the options appear.  **-L** options do not affect
  how **ld** searches for a linker script unless **-T**
  option is specified.
  .Sp
  If _searchdir_ begins with \f(CW`=\*(C' or \f(CW$SYSROOT, then this
  prefix will be replaced by the _sysroot prefix_, controlled by the
  **--sysroot** option, or specified when the linker is configured.
  .Sp
  The default set of paths searched (without being specified with
  **-L**) depends on which emulation mode **ld** is using, and in
  some cases also on how it was configured.
  .Sp
  The paths can also be specified in a link script with the
  \f(CW`SEARCH\_DIR\*(C' command.  Directories specified this way are searched
  at the point in which the linker script appears in the command line.
* **-m** _emulation_  
  .IX Item "-m emulation"
  Emulate the _emulation_ linker.  You can list the available
  emulations with the **--verbose** or **-V** options.
  .Sp
  If the **-m** option is not used, the emulation is taken from the
  \f(CW`LDEMULATION\*(C' environment variable, if that is defined.
  .Sp
  Otherwise, the default emulation depends upon how the linker was
  configured.
* **-M**  
  .IX Item "-M"
* **--print-map**  
  .IX Item "--print-map"
  Print a link map to the standard output.  A link map provides
  information about the link, including the following:
    * ·  
      Where object files are mapped into memory.
    * ·  
      How common symbols are allocated.
    * ·  
      All archive members included in the link, with a mention of the symbol
      which caused the archive member to be brought in.
    * ·  
      The values assigned to symbols.
      .Sp
      Note - symbols whose values are computed by an expression which
      involves a reference to a previous value of the same symbol may not
      have correct result displayed in the link map.  This is because the
      linker discards intermediate results and only retains the final value
      of an expression.  Under such circumstances the linker will display
      the final value enclosed by square brackets.  Thus for example a
      linker script containing:
      .Sp
      .Vb 3
                 foo = 1
                 foo = foo * 4
                 foo = foo + 8
      .Ve
      .Sp
      will produce the following output in the link map if the **-M**
      option is used:
      .Sp
      .Vb 3
                 0x00000001                foo = 0x1
                 [0x0000000c]                foo = (foo * 0x4)
                 [0x0000000c]                foo = (foo + 0x8)
      .Ve
      .Sp
      See **Expressions** for more information about expressions in linker
      scripts.
* **-n**  
  .IX Item "-n"
* **--nmagic**  
  .IX Item "--nmagic"
  Turn off page alignment of sections, and disable linking against shared
  libraries.  If the output format supports Unix style magic numbers,
  mark the output as \f(CW`NMAGIC\*(C'.
* **-N**  
  .IX Item "-N"
* **--omagic**  
  .IX Item "--omagic"
  Set the text and data sections to be readable and writable.  Also, do
  not page-align the data segment, and disable linking against shared
  libraries.  If the output format supports Unix style magic numbers,
  mark the output as \f(CW`OMAGIC\*(C'. Note: Although a writable text section
  is allowed for PE-COFF targets, it does not conform to the format
  specification published by Microsoft.
* **--no-omagic**  
  .IX Item "--no-omagic"
  This option negates most of the effects of the **-N** option.  It
  sets the text section to be read-only, and forces the data segment to
  be page-aligned.  Note - this option does not enable linking against
  shared libraries.  Use **-Bdynamic** for this.
* **-o** _output_  
  .IX Item "-o output"
* **--output=**_output_  
  .IX Item "--output=output"
  Use _output_ as the name for the program produced by **ld**; if this
  option is not specified, the name _a.out_ is used by default.  The
  script command \f(CW`OUTPUT\*(C' can also specify the output file name.
* **-O** _level_  
  .IX Item "-O level"
  If _level_ is a numeric values greater than zero **ld** optimizes
  the output.  This might take significantly longer and therefore probably
  should only be enabled for the final binary.  At the moment this
  option only affects \s-1ELF\s0 shared library generation.  Future releases of
  the linker may make more use of this option.  Also currently there is
  no difference in the linker's behaviour for different non-zero values
  of this option.  Again this may change with future releases.
* **-plugin** _name_  
  .IX Item "-plugin name"
  Involve a plugin in the linking process.  The _name_ parameter is
  the absolute filename of the plugin.  Usually this parameter is
  automatically added by the complier, when using link time
  optimization, but users can also add their own plugins if they so
  wish.
  .Sp
  Note that the location of the compiler originated plugins is different
  from the place where the **ar**, **nm** and
  **ranlib** programs search for their plugins.  In order for
  those commands to make use of a compiler based plugin it must first be
  copied into the _${libdir}/bfd-plugins_ directory.  All gcc
  based linker plugins are backward compatible, so it is sufficient to
  just copy in the newest one.
* **--push-state**  
  .IX Item "--push-state"
  The **--push-state** allows to preserve the current state of the
  flags which govern the input file handling so that they can all be
  restored with one corresponding **--pop-state** option.
  .Sp
  The option which are covered are: **-Bdynamic**, **-Bstatic**,
  **-dn**, **-dy**, **-call\_shared**, **-non\_shared**,
  **-static**, **-N**, **-n**, **--whole-archive**,
  **--no-whole-archive**, **-r**, **-Ur**,
  **--copy-dt-needed-entries**, **--no-copy-dt-needed-entries**,
  **--as-needed**, **--no-as-needed**, and **-a**.
  .Sp
  One target for this option are specifications for _pkg-config_.  When
  used with the **--libs** option all possibly needed libraries are
  listed and then possibly linked with all the time.  It is better to return
  something as follows:
  .Sp
  .Vb 1
          -Wl,--push-state,--as-needed -libone -libtwo -Wl,--pop-state
  .Ve
* **--pop-state**  
  .IX Item "--pop-state"
  Undoes the effect of --push-state, restores the previous values of the
  flags governing input file handling.
* **-q**  
  .IX Item "-q"
* **--emit-relocs**  
  .IX Item "--emit-relocs"
  Leave relocation sections and contents in fully linked executables.
  Post link analysis and optimization tools may need this information in
  order to perform correct modifications of executables.  This results
  in larger executables.
  .Sp
  This option is currently only supported on \s-1ELF\s0 platforms.
* **--force-dynamic**  
  .IX Item "--force-dynamic"
  Force the output file to have dynamic sections.  This option is specific
  to VxWorks targets.
* **-r**  
  .IX Item "-r"
* **--relocatable**  
  .IX Item "--relocatable"
  Generate relocatable output---i.e., generate an output file that can in
  turn serve as input to **ld**.  This is often called partial
  linking.  As a side effect, in environments that support standard Unix
  magic numbers, this option also sets the output file's magic number to
  \f(CW`OMAGIC\*(C'.
  If this option is not specified, an absolute file is produced.  When
  linking  programs, this option _will not_ resolve references to
  constructors; to do that, use **-Ur**.
  .Sp
  When an input file does not have the same format as the output file,
  partial linking is only supported if that input file does not contain any
  relocations.  Different output formats can have further restrictions; for
  example some \f(CW`a.out\*(C'-based formats do not support partial linking
  with input files in other formats at all.
  .Sp
  This option does the same thing as **-i**.
* **-R** _filename_  
  .IX Item "-R filename"
* **--just-symbols=**_filename_  
  .IX Item "--just-symbols=filename"
  Read symbol names and their addresses from _filename_, but do not
  relocate it or include it in the output.  This allows your output file
  to refer symbolically to absolute locations of memory defined in other
  programs.  You may use this option more than once.
  .Sp
  For compatibility with other \s-1ELF\s0 linkers, if the **-R** option is
  followed by a directory name, rather than a file name, it is treated as
  the **-rpath** option.
* **-s**  
  .IX Item "-s"
* **--strip-all**  
  .IX Item "--strip-all"
  Omit all symbol information from the output file.
* **-S**  
  .IX Item "-S"
* **--strip-debug**  
  .IX Item "--strip-debug"
  Omit debugger symbol information (but not all symbols) from the output file.
* **--strip-discarded**  
  .IX Item "--strip-discarded"
* **--no-strip-discarded**  
  .IX Item "--no-strip-discarded"
  Omit (or do not omit) global symbols defined in discarded sections.
  Enabled by default.
* **-t**  
  .IX Item "-t"
* **--trace**  
  .IX Item "--trace"
  Print the names of the input files as **ld** processes them.
* **-T** _scriptfile_  
  .IX Item "-T scriptfile"
* **--script=**_scriptfile_  
  .IX Item "--script=scriptfile"
  Use _scriptfile_ as the linker script.  This script replaces
  **ld**'s default linker script (rather than adding to it), so
  _commandfile_ must specify everything necessary to describe the
  output file.    If _scriptfile_ does not exist in
  the current directory, \f(CW`ld\*(C' looks for it in the directories
  specified by any preceding **-L** options.  Multiple **-T**
  options accumulate.
* **-dT** _scriptfile_  
  .IX Item "-dT scriptfile"
* **--default-script=**_scriptfile_  
  .IX Item "--default-script=scriptfile"
  Use _scriptfile_ as the default linker script.
  .Sp
  This option is similar to the **--script** option except that
  processing of the script is delayed until after the rest of the
  command line has been processed.  This allows options placed after the
  **--default-script** option on the command line to affect the
  behaviour of the linker script, which can be important when the linker
  command line cannot be directly controlled by the user.  (eg because
  the command line is being constructed by another tool, such as
  **gcc**).
* **-u** _symbol_  
  .IX Item "-u symbol"
* **--undefined=**_symbol_  
  .IX Item "--undefined=symbol"
  Force _symbol_ to be entered in the output file as an undefined
  symbol.  Doing this may, for example, trigger linking of additional
  modules from standard libraries.  **-u** may be repeated with
  different option arguments to enter additional undefined symbols.  This
  option is equivalent to the \f(CW`EXTERN\*(C' linker script command.
  .Sp
  If this option is being used to force additional modules to be pulled
  into the link, and if it is an error for the symbol to remain
  undefined, then the option **--require-defined** should be used
  instead.
* **--require-defined=**_symbol_  
  .IX Item "--require-defined=symbol"
  Require that _symbol_ is defined in the output file.  This option
  is the same as option **--undefined** except that if _symbol_
  is not defined in the output file then the linker will issue an error
  and exit.  The same effect can be achieved in a linker script by using
  \f(CW`EXTERN\*(C', \f(CW\*(C\`ASSERT\*(C' and \f(CW\*(C\`DEFINED\*(C' together.  This option
  can be used multiple times to require additional symbols.
* **-Ur**  
  .IX Item "-Ur"
  For anything other than  programs, this option is equivalent to
  **-r**: it generates relocatable output---i.e., an output file that can in
  turn serve as input to **ld**.  When linking  programs, **-Ur**
  _does_ resolve references to constructors, unlike **-r**.
  It does not work to use **-Ur** on files that were themselves linked
  with **-Ur**; once the constructor table has been built, it cannot
  be added to.  Use **-Ur** only for the last partial link, and
  **-r** for the others.
* **--orphan-handling=**_\s-1MODE\s0_  
  .IX Item "--orphan-handling=MODE"
  Control how orphan sections are handled.  An orphan section is one not
  specifically mentioned in a linker script.
  .Sp
  _\s-1MODE\s0_ can have any of the following values:
      .ie n .IP """place""" 4
      .el .IP "\f(CWplace" 4
      .IX Item "place"
      Orphan sections are placed into a suitable output section following
      the strategy described in **Orphan Sections**.  The option
      **--unique** also affects how sections are placed.
      .ie n .IP """discard""" 4
      .el .IP "\f(CWdiscard" 4
      .IX Item "discard"
      All orphan sections are discarded, by placing them in the
      **/DISCARD/** section.
      .ie n .IP """warn""" 4
      .el .IP "\f(CWwarn" 4
      .IX Item "warn"
      The linker will place the orphan section as for \f(CW`place\*(C' and also
      issue a warning.
      .ie n .IP """error""" 4
      .el .IP "\f(CWerror" 4
      .IX Item "error"
      The linker will exit with an error if any orphan section is found.
      .Sp
      The default if **--orphan-handling** is not given is \f(CW`place\*(C'.
* **--unique[=**_\s-1SECTION\s0_**]**  
  .IX Item "--unique[=SECTION]"
  Creates a separate output section for every input section matching
  _\s-1SECTION\s0_, or if the optional wildcard _\s-1SECTION\s0_ argument is
  missing, for every orphan input section.  An orphan section is one not
  specifically mentioned in a linker script.  You may use this option
  multiple times on the command line;  It prevents the normal merging of
  input sections with the same name, overriding output section assignments
  in a linker script.
* **-v**  
  .IX Item "-v"
* **--version**  
  .IX Item "--version"
* **-V**  
  .IX Item "-V"
  Display the version number for **ld**.  The **-V** option also
  lists the supported emulations.
* **-x**  
  .IX Item "-x"
* **--discard-all**  
  .IX Item "--discard-all"
  Delete all local symbols.
* **-X**  
  .IX Item "-X"
* **--discard-locals**  
  .IX Item "--discard-locals"
  Delete all temporary local symbols.  (These symbols start with
  system-specific local label prefixes, typically **.L** for \s-1ELF\s0 systems
  or **L** for traditional a.out systems.)
* **-y** _symbol_  
  .IX Item "-y symbol"
* **--trace-symbol=**_symbol_  
  .IX Item "--trace-symbol=symbol"
  Print the name of each linked file in which _symbol_ appears.  This
  option may be given any number of times.  On many systems it is necessary
  to prepend an underscore.
  .Sp
  This option is useful when you have an undefined symbol in your link but
  don't know where the reference is coming from.
* **-Y** _path_  
  .IX Item "-Y path"
  Add _path_ to the default library search path.  This option exists
  for Solaris compatibility.
* **-z** _keyword_  
  .IX Item "-z keyword"
  The recognized keywords are:
    * **bndplt**  
      .IX Item "bndplt"
      Always generate \s-1BND\s0 prefix in \s-1PLT\s0 entries. Supported for Linux/x86_64.
    * **call-nop=prefix-addr**  
      .IX Item "call-nop=prefix-addr"
    * **call-nop=suffix-nop**  
      .IX Item "call-nop=suffix-nop"
    * **call-nop=prefix-**_byte_  
      .IX Item "call-nop=prefix-byte"
    * **call-nop=suffix-**_byte_  
      .IX Item "call-nop=suffix-byte"
      Specify the 1-byte \f(CW`NOP\*(C' padding when transforming indirect call
      to a locally defined function, foo, via its \s-1GOT\s0 slot.
      **call-nop=prefix-addr** generates \f(CW`0x67 call foo\*(C'.
      **call-nop=suffix-nop** generates \f(CW`call foo 0x90\*(C'.
      **call-nop=prefix-**_byte_ generates \f(CW`\f(CIbyte\f(CW call foo\*(C'.
      **call-nop=suffix-**_byte_ generates \f(CW`call foo \f(CIbyte\f(CW\*(C'.
      Supported for i386 and x86_64.
    * **combreloc**  
      .IX Item "combreloc"
    * **nocombreloc**  
      .IX Item "nocombreloc"
      Combine multiple dynamic relocation sections and sort to improve
      dynamic symbol lookup caching.  Do not do this if **nocombreloc**.
    * **common**  
      .IX Item "common"
    * **nocommon**  
      .IX Item "nocommon"
      Generate common symbols with \s-1STT_COMMON\s0 type during a relocatable
      link.  Use \s-1STT_OBJECT\s0 type if **nocommon**.
    * **common-page-size=**_value_  
      .IX Item "common-page-size=value"
      Set the page size most commonly used to _value_.  Memory image
      layout will be optimized to minimize memory pages if the system is
      using pages of this size.
    * **defs**  
      .IX Item "defs"
      Report unresolved symbol references from regular object files.  This
      is done even if the linker is creating a non-symbolic shared library.
      This option is the inverse of **-z undefs**.
    * **dynamic-undefined-weak**  
      .IX Item "dynamic-undefined-weak"
    * **nodynamic-undefined-weak**  
      .IX Item "nodynamic-undefined-weak"
      Make undefined weak symbols dynamic when building a dynamic object,
      if they are referenced from a regular object file and not forced local
      by symbol visibility or versioning.  Do not make them dynamic if
      **nodynamic-undefined-weak**.  If neither option is given, a target
      may default to either option being in force, or make some other
      selection of undefined weak symbols dynamic.  Not all targets support
      these options.
    * **execstack**  
      .IX Item "execstack"
      Marks the object as requiring executable stack.
    * **global**  
      .IX Item "global"
      This option is only meaningful when building a shared object.  It makes
      the symbols defined by this shared object available for symbol resolution
      of subsequently loaded libraries.
    * **globalaudit**  
      .IX Item "globalaudit"
      This option is only meaningful when building a dynamic executable.
      This option marks the executable as requiring global auditing by
      setting the \f(CW`DF\_1\_GLOBAUDIT\*(C' bit in the \f(CW\*(C\`DT\_FLAGS\_1\*(C' dynamic
      tag.  Global auditing requires that any auditing library defined via
      the **--depaudit** or **-P** command line options be run for
      all dynamic objects loaded by the application.
    * **ibtplt**  
      .IX Item "ibtplt"
      Generate Intel Indirect Branch Tracking (\s-1IBT\s0) enabled \s-1PLT\s0 entries.
      Supported for Linux/i386 and Linux/x86_64.
    * **ibt**  
      .IX Item "ibt"
      Generate \s-1GNU_PROPERTY_X86_FEATURE_1_IBT\s0 in .note.gnu.property section
      to indicate compatibility with \s-1IBT.\s0  This also implies **ibtplt**.
      Supported for Linux/i386 and Linux/x86_64.
    * **initfirst**  
      .IX Item "initfirst"
      This option is only meaningful when building a shared object.
      It marks the object so that its runtime initialization will occur
      before the runtime initialization of any other objects brought into
      the process at the same time.  Similarly the runtime finalization of
      the object will occur after the runtime finalization of any other
      objects.
    * **interpose**  
      .IX Item "interpose"
      Specify that the dynamic loader should modify its symbol search order
      so that symbols in this shared library interpose all other shared
      libraries not so marked.
    * **lazy**  
      .IX Item "lazy"
      When generating an executable or shared library, mark it to tell the
      dynamic linker to defer function call resolution to the point when
      the function is called (lazy binding), rather than at load time.
      Lazy binding is the default.
    * **loadfltr**  
      .IX Item "loadfltr"
      Specify that the object's filters be processed immediately at runtime.
    * **max-page-size=**_value_  
      .IX Item "max-page-size=value"
      Set the maximum memory page size supported to _value_.
    * **muldefs**  
      .IX Item "muldefs"
      Allow multiple definitions.
    * **nocopyreloc**  
      .IX Item "nocopyreloc"
      Disable linker generated .dynbss variables used in place of variables
      defined in shared libraries.  May result in dynamic text relocations.
    * **nodefaultlib**  
      .IX Item "nodefaultlib"
      Specify that the dynamic loader search for dependencies of this object
      should ignore any default library search paths.
    * **nodelete**  
      .IX Item "nodelete"
      Specify that the object shouldn't be unloaded at runtime.
    * **nodlopen**  
      .IX Item "nodlopen"
      Specify that the object is not available to \f(CW`dlopen\*(C'.
    * **nodump**  
      .IX Item "nodump"
      Specify that the object can not be dumped by \f(CW`dldump\*(C'.
    * **noexecstack**  
      .IX Item "noexecstack"
      Marks the object as not requiring executable stack.
    * **noextern-protected-data**  
      .IX Item "noextern-protected-data"
      Don't treat protected data symbols as external when building a shared
      library.  This option overrides the linker backend default.  It can be
      used to work around incorrect relocations against protected data symbols
      generated by compiler.  Updates on protected data symbols by another
      module aren't visible to the resulting shared library.  Supported for
      i386 and x86-64.
    * **noreloc-overflow**  
      .IX Item "noreloc-overflow"
      Disable relocation overflow check.  This can be used to disable
      relocation overflow check if there will be no dynamic relocation
      overflow at run-time.  Supported for x86_64.
    * **now**  
      .IX Item "now"
      When generating an executable or shared library, mark it to tell the
      dynamic linker to resolve all symbols when the program is started, or
      when the shared library is loaded by dlopen, instead of deferring
      function call resolution to the point when the function is first
      called.
    * **origin**  
      .IX Item "origin"
      Specify that the object requires **\f(CB$ORIGIN** handling in paths.
    * **relro**  
      .IX Item "relro"
    * **norelro**  
      .IX Item "norelro"
      Create an \s-1ELF\s0 \f(CW`PT\_GNU\_RELRO\*(C' segment header in the object.  This
      specifies a memory segment that should be made read-only after
      relocation, if supported.  Specifying **common-page-size** smaller
      than the system page size will render this protection ineffective.
      Don't create an \s-1ELF\s0 \f(CW`PT\_GNU\_RELRO\*(C' segment if **norelro**.
    * **separate-code**  
      .IX Item "separate-code"
    * **noseparate-code**  
      .IX Item "noseparate-code"
      Create separate code \f(CW`PT\_LOAD\*(C' segment header in the object.  This
      specifies a memory segment that should contain only instructions and must
      be in wholly disjoint pages from any other data.  Don't create separate
      code \f(CW`PT\_LOAD\*(C' segment if **noseparate-code** is used.
    * **shstk**  
      .IX Item "shstk"
      Generate \s-1GNU_PROPERTY_X86_FEATURE_1_SHSTK\s0 in .note.gnu.property section
      to indicate compatibility with Intel Shadow Stack.  Supported for
      Linux/i386 and Linux/x86_64.
    * **stack-size=**_value_  
      .IX Item "stack-size=value"
      Specify a stack size for an \s-1ELF\s0 \f(CW`PT\_GNU\_STACK\*(C' segment.
      Specifying zero will override any default non-zero sized
      \f(CW`PT\_GNU\_STACK\*(C' segment creation.
    * **text**  
      .IX Item "text"
    * **notext**  
      .IX Item "notext"
    * **textoff**  
      .IX Item "textoff"
      Report an error if \s-1DT_TEXTREL\s0 is set, i.e., if the binary has dynamic
      relocations in read-only sections.  Don't report an error if
      **notext** or **textoff**.
    * **undefs**  
      .IX Item "undefs"
      Do not report unresolved symbol references from regular object files,
      either when creating an executable, or when creating a shared library.
      This option is the inverse of **-z defs**.
      .Sp
      Other keywords are ignored for Solaris compatibility.
* **-(** _archives_ **-)**  
  .IX Item "-( archives -)"
* **--start-group** _archives_ **--end-group**  
  .IX Item "--start-group archives --end-group"
  The _archives_ should be a list of archive files.  They may be
  either explicit file names, or **-l** options.
  .Sp
  The specified archives are searched repeatedly until no new undefined
  references are created.  Normally, an archive is searched only once in
  the order that it is specified on the command line.  If a symbol in that
  archive is needed to resolve an undefined symbol referred to by an
  object in an archive that appears later on the command line, the linker
  would not be able to resolve that reference.  By grouping the archives,
  they all be searched repeatedly until all possible references are
  resolved.
  .Sp
  Using this option has a significant performance cost.  It is best to use
  it only when there are unavoidable circular references between two or
  more archives.
* **--accept-unknown-input-arch**  
  .IX Item "--accept-unknown-input-arch"
* **--no-accept-unknown-input-arch**  
  .IX Item "--no-accept-unknown-input-arch"
  Tells the linker to accept input files whose architecture cannot be
  recognised.  The assumption is that the user knows what they are doing
  and deliberately wants to link in these unknown input files.  This was
  the default behaviour of the linker, before release 2.14.  The default
  behaviour from release 2.14 onwards is to reject such input files, and
  so the **--accept-unknown-input-arch** option has been added to
  restore the old behaviour.
* **--as-needed**  
  .IX Item "--as-needed"
* **--no-as-needed**  
  .IX Item "--no-as-needed"
  This option affects \s-1ELF DT_NEEDED\s0 tags for dynamic libraries mentioned
  on the command line after the **--as-needed** option.  Normally
  the linker will add a \s-1DT_NEEDED\s0 tag for each dynamic library mentioned
  on the command line, regardless of whether the library is actually
  needed or not.  **--as-needed** causes a \s-1DT_NEEDED\s0 tag to only be
  emitted for a library that _at that point in the link_ satisfies a
  non-weak undefined symbol reference from a regular object file or, if
  the library is not found in the \s-1DT_NEEDED\s0 lists of other needed libraries, a
  non-weak undefined symbol reference from another needed dynamic library.
  Object files or libraries appearing on the command line _after_
  the library in question do not affect whether the library is seen as
  needed.  This is similar to the rules for extraction of object files
  from archives.  **--no-as-needed** restores the default behaviour.
* **--add-needed**  
  .IX Item "--add-needed"
* **--no-add-needed**  
  .IX Item "--no-add-needed"
  These two options have been deprecated because of the similarity of
  their names to the **--as-needed** and **--no-as-needed**
  options.  They have been replaced by **--copy-dt-needed-entries**
  and **--no-copy-dt-needed-entries**.
* **-assert** _keyword_  
  .IX Item "-assert keyword"
  This option is ignored for SunOS compatibility.
* **-Bdynamic**  
  .IX Item "-Bdynamic"
* **-dy**  
  .IX Item "-dy"
* **-call\_shared**  
  .IX Item "-call_shared"
  Link against dynamic libraries.  This is only meaningful on platforms
  for which shared libraries are supported.  This option is normally the
  default on such platforms.  The different variants of this option are
  for compatibility with various systems.  You may use this option
  multiple times on the command line: it affects library searching for
  **-l** options which follow it.
* **-Bgroup**  
  .IX Item "-Bgroup"
  Set the \f(CW`DF\_1\_GROUP\*(C' flag in the \f(CW\*(C\`DT\_FLAGS\_1\*(C' entry in the dynamic
  section.  This causes the runtime linker to handle lookups in this
  object and its dependencies to be performed only inside the group.
  **--unresolved-symbols=report-all** is implied.  This option is
  only meaningful on \s-1ELF\s0 platforms which support shared libraries.
* **-Bstatic**  
  .IX Item "-Bstatic"
* **-dn**  
  .IX Item "-dn"
* **-non\_shared**  
  .IX Item "-non_shared"
* **-static**  
  .IX Item "-static"
  Do not link against shared libraries.  This is only meaningful on
  platforms for which shared libraries are supported.  The different
  variants of this option are for compatibility with various systems.  You
  may use this option multiple times on the command line: it affects
  library searching for **-l** options which follow it.  This
  option also implies **--unresolved-symbols=report-all**.  This
  option can be used with **-shared**.  Doing so means that a
  shared library is being created but that all of the library's external
  references must be resolved by pulling in entries from static
  libraries.
* **-Bsymbolic**  
  .IX Item "-Bsymbolic"
  When creating a shared library, bind references to global symbols to the
  definition within the shared library, if any.  Normally, it is possible
  for a program linked against a shared library to override the definition
  within the shared library.  This option can also be used with the
  **--export-dynamic** option, when creating a position independent
  executable, to bind references to global symbols to the definition within
  the executable.  This option is only meaningful on \s-1ELF\s0 platforms which
  support shared libraries and position independent executables.
* **-Bsymbolic-functions**  
  .IX Item "-Bsymbolic-functions"
  When creating a shared library, bind references to global function
  symbols to the definition within the shared library, if any.
  This option can also be used with the **--export-dynamic** option,
  when creating a position independent executable, to bind references
  to global function symbols to the definition within the executable.
  This option is only meaningful on \s-1ELF\s0 platforms which support shared
  libraries and position independent executables.
* **--dynamic-list=**_dynamic-list-file_  
  .IX Item "--dynamic-list=dynamic-list-file"
  Specify the name of a dynamic list file to the linker.  This is
  typically used when creating shared libraries to specify a list of
  global symbols whose references shouldn't be bound to the definition
  within the shared library, or creating dynamically linked executables
  to specify a list of symbols which should be added to the symbol table
  in the executable.  This option is only meaningful on \s-1ELF\s0 platforms
  which support shared libraries.
  .Sp
  The format of the dynamic list is the same as the version node without
  scope and node name.  See **\s-1VERSION\s0** for more information.
* **--dynamic-list-data**  
  .IX Item "--dynamic-list-data"
  Include all global data symbols to the dynamic list.
* **--dynamic-list-cpp-new**  
  .IX Item "--dynamic-list-cpp-new"
  Provide the builtin dynamic list for  operator new and delete.  It
  is mainly useful for building shared libstdc++.
* **--dynamic-list-cpp-typeinfo**  
  .IX Item "--dynamic-list-cpp-typeinfo"
  Provide the builtin dynamic list for  runtime type identification.
* **--check-sections**  
  .IX Item "--check-sections"
* **--no-check-sections**  
  .IX Item "--no-check-sections"
  Asks the linker _not_ to check section addresses after they have
  been assigned to see if there are any overlaps.  Normally the linker will
  perform this check, and if it finds any overlaps it will produce
  suitable error messages.  The linker does know about, and does make
  allowances for sections in overlays.  The default behaviour can be
  restored by using the command line switch **--check-sections**.
  Section overlap is not usually checked for relocatable links.  You can
  force checking in that case by using the **--check-sections**
  option.
* **--copy-dt-needed-entries**  
  .IX Item "--copy-dt-needed-entries"
* **--no-copy-dt-needed-entries**  
  .IX Item "--no-copy-dt-needed-entries"
  This option affects the treatment of dynamic libraries referred to
  by \s-1DT_NEEDED\s0 tags _inside_ \s-1ELF\s0 dynamic libraries mentioned on the
  command line.  Normally the linker won't add a \s-1DT_NEEDED\s0 tag to the
  output binary for each library mentioned in a \s-1DT_NEEDED\s0 tag in an
  input dynamic library.  With **--copy-dt-needed-entries**
  specified on the command line however any dynamic libraries that
  follow it will have their \s-1DT_NEEDED\s0 entries added.  The default
  behaviour can be restored with **--no-copy-dt-needed-entries**.
  .Sp
  This option also has an effect on the resolution of symbols in dynamic
  libraries.  With **--copy-dt-needed-entries** dynamic libraries
  mentioned on the command line will be recursively searched, following
  their \s-1DT_NEEDED\s0 tags to other libraries, in order to resolve symbols
  required by the output binary.  With the default setting however
  the searching of dynamic libraries that follow it will stop with the
  dynamic library itself.  No \s-1DT_NEEDED\s0 links will be traversed to resolve
  symbols.
* **--cref**  
  .IX Item "--cref"
  Output a cross reference table.  If a linker map file is being
  generated, the cross reference table is printed to the map file.
  Otherwise, it is printed on the standard output.
  .Sp
  The format of the table is intentionally simple, so that it may be
  easily processed by a script if necessary.  The symbols are printed out,
  sorted by name.  For each symbol, a list of file names is given.  If the
  symbol is defined, the first file listed is the location of the
  definition.  If the symbol is defined as a common value then any files
  where this happens appear next.  Finally any files that reference the
  symbol are listed.
* **--no-define-common**  
  .IX Item "--no-define-common"
  This option inhibits the assignment of addresses to common symbols.
  The script command \f(CW`INHIBIT\_COMMON\_ALLOCATION\*(C' has the same effect.
  .Sp
  The **--no-define-common** option allows decoupling
  the decision to assign addresses to Common symbols from the choice
  of the output file type; otherwise a non-Relocatable output type
  forces assigning addresses to Common symbols.
  Using **--no-define-common** allows Common symbols that are referenced
  from a shared library to be assigned addresses only in the main program.
  This eliminates the unused duplicate space in the shared library,
  and also prevents any possible confusion over resolving to the wrong
  duplicate when there are many dynamic modules with specialized search
  paths for runtime symbol resolution.
* **--force-group-allocation**  
  .IX Item "--force-group-allocation"
  This option causes the linker to place section group members like
  normal input sections, and to delete the section groups.  This is the
  default behaviour for a final link but this option can be used to
  change the behaviour of a relocatable link (**-r**).  The script
  command \f(CW`FORCE\_GROUP\_ALLOCATION\*(C' has the same
  effect.
* **--defsym=**_symbol_**=**_expression_  
  .IX Item "--defsym=symbol=expression"
  Create a global symbol in the output file, containing the absolute
  address given by _expression_.  You may use this option as many
  times as necessary to define multiple symbols in the command line.  A
  limited form of arithmetic is supported for the _expression_ in this
  context: you may give a hexadecimal constant or the name of an existing
  symbol, or use \f(CW`+\*(C' and \f(CW\*(C\`-\*(C' to add or subtract hexadecimal
  constants or symbols.  If you need more elaborate expressions, consider
  using the linker command language from a script.
  _Note:_ there should be no white space between _symbol_, the
  equals sign ("**=**"), and _expression_.
* **--demangle[=**_style_**]**  
  .IX Item "--demangle[=style]"
* **--no-demangle**  
  .IX Item "--no-demangle"
  These options control whether to demangle symbol names in error messages
  and other output.  When the linker is told to demangle, it tries to
  present symbol names in a readable fashion: it strips leading
  underscores if they are used by the object file format, and converts 
  mangled symbol names into user readable names.  Different compilers have
  different mangling styles.  The optional demangling style argument can be used
  to choose an appropriate demangling style for your compiler.  The linker will
  demangle by default unless the environment variable **\s-1COLLECT\_NO\_DEMANGLE\s0**
  is set.  These options may be used to override the default.
* **-I**_file_  
  .IX Item "-Ifile"
* **--dynamic-linker=**_file_  
  .IX Item "--dynamic-linker=file"
  Set the name of the dynamic linker.  This is only meaningful when
  generating dynamically linked \s-1ELF\s0 executables.  The default dynamic
  linker is normally correct; don't use this unless you know what you are
  doing.
* **--no-dynamic-linker**  
  .IX Item "--no-dynamic-linker"
  When producing an executable file, omit the request for a dynamic
  linker to be used at load-time.  This is only meaningful for \s-1ELF\s0
  executables that contain dynamic relocations, and usually requires
  entry point code that is capable of processing these relocations.
* **--embedded-relocs**  
  .IX Item "--embedded-relocs"
  This option is similar to the **--emit-relocs** option except
  that the relocs are stored in a target specific section.  This option
  is only supported by the **\s-1BFIN\s0**, **\s-1CR16\s0** and _M68K_
  targets.
* **--disable-multiple-abs-defs**  
  .IX Item "--disable-multiple-abs-defs"
  Do not allow multiple definitions with symbols included
  in filename invoked by -R or --just-symbols
* **--fatal-warnings**  
  .IX Item "--fatal-warnings"
* **--no-fatal-warnings**  
  .IX Item "--no-fatal-warnings"
  Treat all warnings as errors.  The default behaviour can be restored
  with the option **--no-fatal-warnings**.
* **--force-exe-suffix**  
  .IX Item "--force-exe-suffix"
  Make sure that an output file has a .exe suffix.
  .Sp
  If a successfully built fully linked output file does not have a
  \f(CW`.exe\*(C' or \f(CW\*(C\`.dll\*(C' suffix, this option forces the linker to copy
  the output file to one of the same name with a \f(CW`.exe\*(C' suffix. This
  option is useful when using unmodified Unix makefiles on a Microsoft
  Windows host, since some versions of Windows won't run an image unless
  it ends in a \f(CW`.exe\*(C' suffix.
* **--gc-sections**  
  .IX Item "--gc-sections"
* **--no-gc-sections**  
  .IX Item "--no-gc-sections"
  Enable garbage collection of unused input sections.  It is ignored on
  targets that do not support this option.  The default behaviour (of not
  performing this garbage collection) can be restored by specifying
  **--no-gc-sections** on the command line.  Note that garbage
  collection for \s-1COFF\s0 and \s-1PE\s0 format targets is supported, but the
  implementation is currently considered to be experimental.
  .Sp
  **--gc-sections** decides which input sections are used by
  examining symbols and relocations.  The section containing the entry
  symbol and all sections containing symbols undefined on the
  command-line will be kept, as will sections containing symbols
  referenced by dynamic objects.  Note that when building shared
  libraries, the linker must assume that any visible symbol is
  referenced.  Once this initial set of sections has been determined,
  the linker recursively marks as used any section referenced by their
  relocations.  See **--entry** and **--undefined**.
  .Sp
  This option can be set when doing a partial link (enabled with option
  **-r**).  In this case the root of symbols kept must be explicitly
  specified either by an **--entry** or **--undefined** option or by
  a \f(CW`ENTRY\*(C' command in the linker script.
* **--print-gc-sections**  
  .IX Item "--print-gc-sections"
* **--no-print-gc-sections**  
  .IX Item "--no-print-gc-sections"
  List all sections removed by garbage collection.  The listing is
  printed on stderr.  This option is only effective if garbage
  collection has been enabled via the **--gc-sections**) option.  The
  default behaviour (of not listing the sections that are removed) can
  be restored by specifying **--no-print-gc-sections** on the command
  line.
* **--gc-keep-exported**  
  .IX Item "--gc-keep-exported"
  When **--gc-sections** is enabled, this option prevents garbage
  collection of unused input sections that contain global symbols having
  default or protected visibility.  This option is intended to be used for
  executables where unreferenced sections would otherwise be garbage
  collected regardless of the external visibility of contained symbols.
  Note that this option has no effect when linking shared objects since
  it is already the default behaviour.  This option is only supported for
  \s-1ELF\s0 format targets.
* **--print-output-format**  
  .IX Item "--print-output-format"
  Print the name of the default output format (perhaps influenced by
  other command-line options).  This is the string that would appear
  in an \f(CW`OUTPUT\_FORMAT\*(C' linker script command.
* **--print-memory-usage**  
  .IX Item "--print-memory-usage"
  Print used size, total size and used size of memory regions created with
  the **\s-1MEMORY\s0** command.  This is useful on embedded targets to have a
  quick view of amount of free memory.  The format of the output has one
  headline and one line per region.  It is both human readable and easily
  parsable by tools.  Here is an example of an output:
  .Sp
  .Vb 3
          Memory region         Used Size  Region Size  %age Used
                       ROM:        256 KB         1 MB     25.00%
                       RAM:          32 B         2 GB      0.00%
  .Ve
* **--help**  
  .IX Item "--help"
  Print a summary of the command-line options on the standard output and exit.
* **--target-help**  
  .IX Item "--target-help"
  Print a summary of all target specific options on the standard output and exit.
* **-Map=**_mapfile_  
  .IX Item "-Map=mapfile"
  Print a link map to the file _mapfile_.  See the description of the
  **-M** option, above.
* **--no-keep-memory**  
  .IX Item "--no-keep-memory"
  **ld** normally optimizes for speed over memory usage by caching the
  symbol tables of input files in memory.  This option tells **ld** to
  instead optimize for memory usage, by rereading the symbol tables as
  necessary.  This may be required if **ld** runs out of memory space
  while linking a large executable.
* **--no-undefined**  
  .IX Item "--no-undefined"
* **-z defs**  
  .IX Item "-z defs"
  Report unresolved symbol references from regular object files.  This
  is done even if the linker is creating a non-symbolic shared library.
  The switch **--[no-]allow-shlib-undefined** controls the
  behaviour for reporting unresolved references found in shared
  libraries being linked in.
  .Sp
  The effects of this option can be reverted by using \f(CW`-z undefs\*(C'.
* **--allow-multiple-definition**  
  .IX Item "--allow-multiple-definition"
* **-z muldefs**  
  .IX Item "-z muldefs"
  Normally when a symbol is defined multiple times, the linker will
  report a fatal error. These options allow multiple definitions and the
  first definition will be used.
* **--allow-shlib-undefined**  
  .IX Item "--allow-shlib-undefined"
* **--no-allow-shlib-undefined**  
  .IX Item "--no-allow-shlib-undefined"
  Allows or disallows undefined symbols in shared libraries.
  This switch is similar to **--no-undefined** except that it
  determines the behaviour when the undefined symbols are in a
  shared library rather than a regular object file.  It does not affect
  how undefined symbols in regular object files are handled.
  .Sp
  The default behaviour is to report errors for any undefined symbols
  referenced in shared libraries if the linker is being used to create
  an executable, but to allow them if the linker is being used to create
  a shared library.
  .Sp
  The reasons for allowing undefined symbol references in shared
  libraries specified at link time are that:
    * ·  
      A shared library specified at link time may not be the same as the one
      that is available at load time, so the symbol might actually be
      resolvable at load time.
    * ·  
      There are some operating systems, eg BeOS and \s-1HPPA,\s0 where undefined
      symbols in shared libraries are normal.
      .Sp
      The BeOS kernel for example patches shared libraries at load time to
      select whichever function is most appropriate for the current
      architecture.  This is used, for example, to dynamically select an
      appropriate memset function.
* **--no-undefined-version**  
  .IX Item "--no-undefined-version"
  Normally when a symbol has an undefined version, the linker will ignore
  it. This option disallows symbols with undefined version and a fatal error
  will be issued instead.
* **--default-symver**  
  .IX Item "--default-symver"
  Create and use a default symbol version (the soname) for unversioned
  exported symbols.
* **--default-imported-symver**  
  .IX Item "--default-imported-symver"
  Create and use a default symbol version (the soname) for unversioned
  imported symbols.
* **--no-warn-mismatch**  
  .IX Item "--no-warn-mismatch"
  Normally **ld** will give an error if you try to link together input
  files that are mismatched for some reason, perhaps because they have
  been compiled for different processors or for different endiannesses.
  This option tells **ld** that it should silently permit such possible
  errors.  This option should only be used with care, in cases when you
  have taken some special action that ensures that the linker errors are
  inappropriate.
* **--no-warn-search-mismatch**  
  .IX Item "--no-warn-search-mismatch"
  Normally **ld** will give a warning if it finds an incompatible
  library during a library search.  This option silences the warning.
* **--no-whole-archive**  
  .IX Item "--no-whole-archive"
  Turn off the effect of the **--whole-archive** option for subsequent
  archive files.
* **--noinhibit-exec**  
  .IX Item "--noinhibit-exec"
  Retain the executable output file whenever it is still usable.
  Normally, the linker will not produce an output file if it encounters
  errors during the link process; it exits without writing an output file
  when it issues any error whatsoever.
* **-nostdlib**  
  .IX Item "-nostdlib"
  Only search library directories explicitly specified on the
  command line.  Library directories specified in linker scripts
  (including linker scripts specified on the command line) are ignored.
* **--oformat=**_output-format_  
  .IX Item "--oformat=output-format"
  **ld** may be configured to support more than one kind of object
  file.  If your **ld** is configured this way, you can use the
  **--oformat** option to specify the binary format for the output
  object file.  Even when **ld** is configured to support alternative
  object formats, you don't usually need to specify this, as **ld**
  should be configured to produce as a default output format the most
  usual format on each machine.  _output-format_ is a text string, the
  name of a particular format supported by the \s-1BFD\s0 libraries.  (You can
  list the available binary formats with **objdump -i**.)  The script
  command \f(CW`OUTPUT\_FORMAT\*(C' can also specify the output format, but
  this option overrides it.
* **--out-implib** _file_  
  .IX Item "--out-implib file"
  Create an import library in _file_ corresponding to the executable
  the linker is generating (eg. a \s-1DLL\s0 or \s-1ELF\s0 program).  This import
  library (which should be called \f(CW`*.dll.a\*(C' or \f(CW\*(C\`*.a\*(C' for DLLs)
  may be used to link clients against the generated executable; this
  behaviour makes it possible to skip a separate import library creation
  step (eg. \f(CW`dlltool\*(C' for DLLs).  This option is only available for
  the i386 \s-1PE\s0 and \s-1ELF\s0 targetted ports of the linker.
* **-pie**  
  .IX Item "-pie"
* **--pic-executable**  
  .IX Item "--pic-executable"
  Create a position independent executable.  This is currently only supported on
  \s-1ELF\s0 platforms.  Position independent executables are similar to shared
  libraries in that they are relocated by the dynamic linker to the virtual
  address the \s-1OS\s0 chooses for them (which can vary between invocations).  Like
  normal dynamically linked executables they can be executed and symbols
  defined in the executable cannot be overridden by shared libraries.
* **-qmagic**  
  .IX Item "-qmagic"
  This option is ignored for Linux compatibility.
* **-Qy**  
  .IX Item "-Qy"
  This option is ignored for \s-1SVR4\s0 compatibility.
* **--relax**  
  .IX Item "--relax"
* **--no-relax**  
  .IX Item "--no-relax"
  An option with machine dependent effects.
  This option is only supported on a few targets.
  .Sp
  On some platforms the **--relax** option performs target specific,
  global optimizations that become possible when the linker resolves
  addressing in the program, such as relaxing address modes,
  synthesizing new instructions, selecting shorter version of current
  instructions, and combining constant values.
  .Sp
  On some platforms these link time global optimizations may make symbolic
  debugging of the resulting executable impossible.
  This is known to be the case for the Matsushita \s-1MN10200\s0 and \s-1MN10300\s0
  family of processors.
  .Sp
  On platforms where this is not supported, **--relax** is accepted,
  but ignored.
  .Sp
  On platforms where **--relax** is accepted the option
  **--no-relax** can be used to disable the feature.
* **--retain-symbols-file=**_filename_  
  .IX Item "--retain-symbols-file=filename"
  Retain _only_ the symbols listed in the file _filename_,
  discarding all others.  _filename_ is simply a flat file, with one
  symbol name per line.  This option is especially useful in environments
  (such as VxWorks)
  where a large global symbol table is accumulated gradually, to conserve
  run-time memory.
  .Sp
  **--retain-symbols-file** does _not_ discard undefined symbols,
  or symbols needed for relocations.
  .Sp
  You may only specify **--retain-symbols-file** once in the command
  line.  It overrides **-s** and **-S**.
* **-rpath=**_dir_  
  .IX Item "-rpath=dir"
  Add a directory to the runtime library search path.  This is used when
  linking an \s-1ELF\s0 executable with shared objects.  All **-rpath**
  arguments are concatenated and passed to the runtime linker, which uses
  them to locate shared objects at runtime.  The **-rpath** option is
  also used when locating shared objects which are needed by shared
  objects explicitly included in the link; see the description of the
  **-rpath-link** option.  If **-rpath** is not used when linking an
  \s-1ELF\s0 executable, the contents of the environment variable
  \f(CW`LD\_RUN\_PATH\*(C' will be used if it is defined.
  .Sp
  The **-rpath** option may also be used on SunOS.  By default, on
  SunOS, the linker will form a runtime search path out of all the
  **-L** options it is given.  If a **-rpath** option is used, the
  runtime search path will be formed exclusively using the **-rpath**
  options, ignoring the **-L** options.  This can be useful when using
  gcc, which adds many **-L** options which may be on \s-1NFS\s0 mounted
  file systems.
  .Sp
  For compatibility with other \s-1ELF\s0 linkers, if the **-R** option is
  followed by a directory name, rather than a file name, it is treated as
  the **-rpath** option.
* **-rpath-link=**_dir_  
  .IX Item "-rpath-link=dir"
  When using \s-1ELF\s0 or SunOS, one shared library may require another.  This
  happens when an \f(CW`ld -shared\*(C' link includes a shared library as one
  of the input files.
  .Sp
  When the linker encounters such a dependency when doing a non-shared,
  non-relocatable link, it will automatically try to locate the required
  shared library and include it in the link, if it is not included
  explicitly.  In such a case, the **-rpath-link** option
  specifies the first set of directories to search.  The
  **-rpath-link** option may specify a sequence of directory names
  either by specifying a list of names separated by colons, or by
  appearing multiple times.
  .Sp
  The tokens _\f(CI$ORIGIN_ and _\f(CI$LIB_ can appear in these search
  directories.  They will be replaced by the full path to the directory
  containing the program or shared object in the case of _\f(CI$ORIGIN_
  and either **lib** - for 32-bit binaries - or **lib64** - for
  64-bit binaries - in the case of _\f(CI$LIB_.
  .Sp
  The alternative form of these tokens - _${\s-1ORIGIN\s0}_ and
  _${\s-1LIB\s0}_ can also be used.  The token _\f(CI$PLATFORM_ is not
  supported.
  .Sp
  This option should be used with caution as it overrides the search path
  that may have been hard compiled into a shared library. In such a case it
  is possible to use unintentionally a different search path than the
  runtime linker would do.
  .Sp
  The linker uses the following search paths to locate required shared
  libraries:
    * 1.  
      Any directories specified by **-rpath-link** options.
    * 2.  
      Any directories specified by **-rpath** options.  The difference
      between **-rpath** and **-rpath-link** is that directories
      specified by **-rpath** options are included in the executable and
      used at runtime, whereas the **-rpath-link** option is only effective
      at link time. Searching **-rpath** in this way is only supported
      by native linkers and cross linkers which have been configured with
      the **--with-sysroot** option.
    * 3.  
      On an \s-1ELF\s0 system, for native linkers, if the **-rpath** and
      **-rpath-link** options were not used, search the contents of the
      environment variable \f(CW`LD\_RUN\_PATH\*(C'.
    * 4.  
      On SunOS, if the **-rpath** option was not used, search any
      directories specified using **-L** options.
    * 5.  
      For a native linker, search the contents of the environment
      variable \f(CW`LD\_LIBRARY\_PATH\*(C'.
    * 6.  
      For a native \s-1ELF\s0 linker, the directories in \f(CW`DT\_RUNPATH\*(C' or
      \f(CW`DT\_RPATH\*(C' of a shared library are searched for shared
      libraries needed by it. The \f(CW`DT\_RPATH\*(C' entries are ignored if
      \f(CW`DT\_RUNPATH\*(C' entries exist.
    * 7.  
      The default directories, normally _/lib_ and _/usr/lib_.
    * 8.  
      For a native linker on an \s-1ELF\s0 system, if the file _/etc/ld.so.conf_
      exists, the list of directories found in that file.
      .Sp
      If the required shared library is not found, the linker will issue a
      warning and continue with the link.
* **-shared**  
  .IX Item "-shared"
* **-Bshareable**  
  .IX Item "-Bshareable"
  Create a shared library.  This is currently only supported on \s-1ELF, XCOFF\s0
  and SunOS platforms.  On SunOS, the linker will automatically create a
  shared library if the **-e** option is not used and there are
  undefined symbols in the link.
* **--sort-common**  
  .IX Item "--sort-common"
* **--sort-common=ascending**  
  .IX Item "--sort-common=ascending"
* **--sort-common=descending**  
  .IX Item "--sort-common=descending"
  This option tells **ld** to sort the common symbols by alignment in
  ascending or descending order when it places them in the appropriate output
  sections.  The symbol alignments considered are sixteen-byte or larger,
  eight-byte, four-byte, two-byte, and one-byte. This is to prevent gaps
  between symbols due to alignment constraints.  If no sorting order is
  specified, then descending order is assumed.
* **--sort-section=name**  
  .IX Item "--sort-section=name"
  This option will apply \f(CW`SORT\_BY\_NAME\*(C' to all wildcard section
  patterns in the linker script.
* **--sort-section=alignment**  
  .IX Item "--sort-section=alignment"
  This option will apply \f(CW`SORT\_BY\_ALIGNMENT\*(C' to all wildcard section
  patterns in the linker script.
* **--spare-dynamic-tags=**_count_  
  .IX Item "--spare-dynamic-tags=count"
  This option specifies the number of empty slots to leave in the
  .dynamic section of \s-1ELF\s0 shared objects.  Empty slots may be needed by
  post processing tools, such as the prelinker.  The default is 5.
* **--split-by-file[=**_size_**]**  
  .IX Item "--split-by-file[=size]"
  Similar to **--split-by-reloc** but creates a new output section for
  each input file when _size_ is reached.  _size_ defaults to a
  size of 1 if not given.
* **--split-by-reloc[=**_count_**]**  
  .IX Item "--split-by-reloc[=count]"
  Tries to creates extra sections in the output file so that no single
  output section in the file contains more than _count_ relocations.
  This is useful when generating huge relocatable files for downloading into
  certain real time kernels with the \s-1COFF\s0 object file format; since \s-1COFF\s0
  cannot represent more than 65535 relocations in a single section.  Note
  that this will fail to work with object file formats which do not
  support arbitrary sections.  The linker will not split up individual
  input sections for redistribution, so if a single input section contains
  more than _count_ relocations one output section will contain that
  many relocations.  _count_ defaults to a value of 32768.
* **--stats**  
  .IX Item "--stats"
  Compute and display statistics about the operation of the linker, such
  as execution time and memory usage.
* **--sysroot=**_directory_  
  .IX Item "--sysroot=directory"
  Use _directory_ as the location of the sysroot, overriding the
  configure-time default.  This option is only supported by linkers
  that were configured using **--with-sysroot**.
* **--task-link**  
  .IX Item "--task-link"
  This is used by \s-1COFF/PE\s0 based targets to create a task-linked object
  file where all of the global symbols have been converted to statics.
* **--traditional-format**  
  .IX Item "--traditional-format"
  For some targets, the output of **ld** is different in some ways from
  the output of some existing linker.  This switch requests **ld** to
  use the traditional format instead.
  .Sp
  For example, on SunOS, **ld** combines duplicate entries in the
  symbol string table.  This can reduce the size of an output file with
  full debugging information by over 30 percent.  Unfortunately, the SunOS
  \f(CW`dbx\*(C' program can not read the resulting program (\f(CW\*(C\`gdb\*(C' has no
  trouble).  The **--traditional-format** switch tells **ld** to not
  combine duplicate entries.
* **--section-start=**_sectionname_**=**_org_  
  .IX Item "--section-start=sectionname=org"
  Locate a section in the output file at the absolute
  address given by _org_.  You may use this option as many
  times as necessary to locate multiple sections in the command
  line.
  _org_ must be a single hexadecimal integer;
  for compatibility with other linkers, you may omit the leading
  **0x** usually associated with hexadecimal values.  _Note:_ there
  should be no white space between _sectionname_, the equals
  sign ("**=**"), and _org_.
* **-Tbss=**_org_  
  .IX Item "-Tbss=org"
* **-Tdata=**_org_  
  .IX Item "-Tdata=org"
* **-Ttext=**_org_  
  .IX Item "-Ttext=org"
  Same as **--section-start**, with \f(CW`.bss\*(C', \f(CW\*(C\`.data\*(C' or
  \f(CW`.text\*(C' as the _sectionname_.
* **-Ttext-segment=**_org_  
  .IX Item "-Ttext-segment=org"
  When creating an \s-1ELF\s0 executable, it will set the address of the first
  byte of the text segment.
* **-Trodata-segment=**_org_  
  .IX Item "-Trodata-segment=org"
  When creating an \s-1ELF\s0 executable or shared object for a target where
  the read-only data is in its own segment separate from the executable
  text, it will set the address of the first byte of the read-only data segment.
* **-Tldata-segment=**_org_  
  .IX Item "-Tldata-segment=org"
  When creating an \s-1ELF\s0 executable or shared object for x86-64 medium memory
  model, it will set the address of the first byte of the ldata segment.
* **--unresolved-symbols=**_method_  
  .IX Item "--unresolved-symbols=method"
  Determine how to handle unresolved symbols.  There are four possible
  values for **method**:
    * **ignore-all**  
      .IX Item "ignore-all"
      Do not report any unresolved symbols.
    * **report-all**  
      .IX Item "report-all"
      Report all unresolved symbols.  This is the default.
    * **ignore-in-object-files**  
      .IX Item "ignore-in-object-files"
      Report unresolved symbols that are contained in shared libraries, but
      ignore them if they come from regular object files.
    * **ignore-in-shared-libs**  
      .IX Item "ignore-in-shared-libs"
      Report unresolved symbols that come from regular object files, but
      ignore them if they come from shared libraries.  This can be useful
      when creating a dynamic binary and it is known that all the shared
      libraries that it should be referencing are included on the linker's
      command line.
      .Sp
      The behaviour for shared libraries on their own can also be controlled
      by the **--[no-]allow-shlib-undefined** option.
      .Sp
      Normally the linker will generate an error message for each reported
      unresolved symbol but the option **--warn-unresolved-symbols**
      can change this to a warning.
* **--dll-verbose**  
  .IX Item "--dll-verbose"
* **--verbose[=**_\s-1NUMBER\s0_**]**  
  .IX Item "--verbose[=NUMBER]"
  Display the version number for **ld** and list the linker emulations
  supported.  Display which input files can and cannot be opened.  Display
  the linker script being used by the linker. If the optional _\s-1NUMBER\s0_
  argument &gt; 1, plugin symbol status will also be displayed.
* **--version-script=**_version-scriptfile_  
  .IX Item "--version-script=version-scriptfile"
  Specify the name of a version script to the linker.  This is typically
  used when creating shared libraries to specify additional information
  about the version hierarchy for the library being created.  This option
  is only fully supported on \s-1ELF\s0 platforms which support shared libraries;
  see **\s-1VERSION\s0**.  It is partially supported on \s-1PE\s0 platforms, which can
  use version scripts to filter symbol visibility in auto-export mode: any
  symbols marked **local** in the version script will not be exported.
* **--warn-common**  
  .IX Item "--warn-common"
  Warn when a common symbol is combined with another common symbol or with
  a symbol definition.  Unix linkers allow this somewhat sloppy practice,
  but linkers on some other operating systems do not.  This option allows
  you to find potential problems from combining global symbols.
  Unfortunately, some C libraries use this practice, so you may get some
  warnings about symbols in the libraries as well as in your programs.
  .Sp
  There are three kinds of global symbols, illustrated here by C examples:
    * **int i = 1;**  
      .IX Item "int i = 1;"
      A definition, which goes in the initialized data section of the output
      file.
    * **extern int i;**  
      .IX Item "extern int i;"
      An undefined reference, which does not allocate space.
      There must be either a definition or a common symbol for the
      variable somewhere.
    * **int i;**  
      .IX Item "int i;"
      A common symbol.  If there are only (one or more) common symbols for a
      variable, it goes in the uninitialized data area of the output file.
      The linker merges multiple common symbols for the same variable into a
      single symbol.  If they are of different sizes, it picks the largest
      size.  The linker turns a common symbol into a declaration, if there is
      a definition of the same variable.
      .Sp
      The **--warn-common** option can produce five kinds of warnings.
      Each warning consists of a pair of lines: the first describes the symbol
      just encountered, and the second describes the previous symbol
      encountered with the same name.  One or both of the two symbols will be
      a common symbol.
    * 1.  
      Turning a common symbol into a reference, because there is already a
      definition for the symbol.
      .Sp
      .Vb 3
              &lt;file&gt;(&lt;section&gt;): warning: common of \\`&lt;symbol&gt;
                 overridden by definition
              &lt;file&gt;(&lt;section&gt;): warning: defined here
      .Ve
    * 2.  
      Turning a common symbol into a reference, because a later definition for
      the symbol is encountered.  This is the same as the previous case,
      except that the symbols are encountered in a different order.
      .Sp
      .Vb 3
              &lt;file&gt;(&lt;section&gt;): warning: definition of \\`&lt;symbol&gt;
                 overriding common
              &lt;file&gt;(&lt;section&gt;): warning: common is here
      .Ve
    * 3.  
      Merging a common symbol with a previous same-sized common symbol.
      .Sp
      .Vb 3
              &lt;file&gt;(&lt;section&gt;): warning: multiple common
                 of \\`&lt;symbol&gt;
              &lt;file&gt;(&lt;section&gt;): warning: previous common is here
      .Ve
    * 4.  
      Merging a common symbol with a previous larger common symbol.
      .Sp
      .Vb 3
              &lt;file&gt;(&lt;section&gt;): warning: common of \\`&lt;symbol&gt;
                 overridden by larger common
              &lt;file&gt;(&lt;section&gt;): warning: larger common is here
      .Ve
    * 5.  
      Merging a common symbol with a previous smaller common symbol.  This is
      the same as the previous case, except that the symbols are
      encountered in a different order.
      .Sp
      .Vb 3
              &lt;file&gt;(&lt;section&gt;): warning: common of \\`&lt;symbol&gt;
                 overriding smaller common
              &lt;file&gt;(&lt;section&gt;): warning: smaller common is here
      .Ve
* **--warn-constructors**  
  .IX Item "--warn-constructors"
  Warn if any global constructors are used.  This is only useful for a few
  object file formats.  For formats like \s-1COFF\s0 or \s-1ELF,\s0 the linker can not
  detect the use of global constructors.
* **--warn-multiple-gp**  
  .IX Item "--warn-multiple-gp"
  Warn if multiple global pointer values are required in the output file.
  This is only meaningful for certain processors, such as the Alpha.
  Specifically, some processors put large-valued constants in a special
  section.  A special register (the global pointer) points into the middle
  of this section, so that constants can be loaded efficiently via a
  base-register relative addressing mode.  Since the offset in
  base-register relative mode is fixed and relatively small (e.g., 16
  bits), this limits the maximum size of the constant pool.  Thus, in
  large programs, it is often necessary to use multiple global pointer
  values in order to be able to address all possible constants.  This
  option causes a warning to be issued whenever this case occurs.
* **--warn-once**  
  .IX Item "--warn-once"
  Only warn once for each undefined symbol, rather than once per module
  which refers to it.
* **--warn-section-align**  
  .IX Item "--warn-section-align"
  Warn if the address of an output section is changed because of
  alignment.  Typically, the alignment will be set by an input section.
  The address will only be changed if it not explicitly specified; that
  is, if the \f(CW`SECTIONS\*(C' command does not specify a start address for
  the section.
* **--warn-shared-textrel**  
  .IX Item "--warn-shared-textrel"
  Warn if the linker adds a \s-1DT_TEXTREL\s0 to a shared object.
* **--warn-alternate-em**  
  .IX Item "--warn-alternate-em"
  Warn if an object has alternate \s-1ELF\s0 machine code.
* **--warn-unresolved-symbols**  
  .IX Item "--warn-unresolved-symbols"
  If the linker is going to report an unresolved symbol (see the option
  **--unresolved-symbols**) it will normally generate an error.
  This option makes it generate a warning instead.
* **--error-unresolved-symbols**  
  .IX Item "--error-unresolved-symbols"
  This restores the linker's default behaviour of generating errors when
  it is reporting unresolved symbols.
* **--whole-archive**  
  .IX Item "--whole-archive"
  For each archive mentioned on the command line after the
  **--whole-archive** option, include every object file in the archive
  in the link, rather than searching the archive for the required object
  files.  This is normally used to turn an archive file into a shared
  library, forcing every object to be included in the resulting shared
  library.  This option may be used more than once.
  .Sp
  Two notes when using this option from gcc: First, gcc doesn't know
  about this option, so you have to use **-Wl,-whole-archive**.
  Second, don't forget to use **-Wl,-no-whole-archive** after your
  list of archives, because gcc will add its own list of archives to
  your link and you may not want this flag to affect those as well.
* **--wrap=**_symbol_  
  .IX Item "--wrap=symbol"
  Use a wrapper function for _symbol_.  Any undefined reference to
  _symbol_ will be resolved to \f(CW`\_\|\_wrap\_\f(CIsymbol\f(CW\*(C'.  Any
  undefined reference to \f(CW`\_\|\_real\_\f(CIsymbol\f(CW\*(C' will be resolved to
  _symbol_.
  .Sp
  This can be used to provide a wrapper for a system function.  The
  wrapper function should be called \f(CW`\_\|\_wrap\_\f(CIsymbol\f(CW\*(C'.  If it
  wishes to call the system function, it should call
  \f(CW`\_\|\_real\_\f(CIsymbol\f(CW\*(C'.
  .Sp
  Here is a trivial example:
  .Sp
  .Vb 6
          void *
          _\|_wrap_malloc (size_t c)
          {
            printf ("malloc called with %zu\en", c);
            return _\|_real_malloc (c);
          }
  .Ve
  .Sp
  If you link other code with this file using **--wrap malloc**, then
  all calls to \f(CW`malloc\*(C' will call the function \f(CW\*(C\`\_\|\_wrap\_malloc\*(C'
  instead.  The call to \f(CW`\_\|\_real\_malloc\*(C' in \f(CW\*(C\`\_\|\_wrap\_malloc\*(C' will
  call the real \f(CW`malloc\*(C' function.
  .Sp
  You may wish to provide a \f(CW`\_\|\_real\_malloc\*(C' function as well, so that
  links without the **--wrap** option will succeed.  If you do this,
  you should not put the definition of \f(CW`\_\|\_real\_malloc\*(C' in the same
  file as \f(CW`\_\|\_wrap\_malloc\*(C'; if you do, the assembler may resolve the
  call before the linker has a chance to wrap it to \f(CW`malloc\*(C'.
* **--eh-frame-hdr**  
  .IX Item "--eh-frame-hdr"
* **--no-eh-frame-hdr**  
  .IX Item "--no-eh-frame-hdr"
  Request (**--eh-frame-hdr**) or suppress
  (**--no-eh-frame-hdr**) the creation of \f(CW`.eh\_frame\_hdr\*(C'
  section and \s-1ELF\s0 \f(CW`PT\_GNU\_EH\_FRAME\*(C' segment header.
* **--no-ld-generated-unwind-info**  
  .IX Item "--no-ld-generated-unwind-info"
  Request creation of \f(CW`.eh\_frame\*(C' unwind info for linker
  generated code sections like \s-1PLT.\s0  This option is on by default
  if linker generated unwind info is supported.
* **--enable-new-dtags**  
  .IX Item "--enable-new-dtags"
* **--disable-new-dtags**  
  .IX Item "--disable-new-dtags"
  This linker can create the new dynamic tags in \s-1ELF.\s0 But the older \s-1ELF\s0
  systems may not understand them. If you specify
  **--enable-new-dtags**, the new dynamic tags will be created as needed
  and older dynamic tags will be omitted.
  If you specify **--disable-new-dtags**, no new dynamic tags will be
  created. By default, the new dynamic tags are not created. Note that
  those options are only available for \s-1ELF\s0 systems.
* **--hash-size=**_number_  
  .IX Item "--hash-size=number"
  Set the default size of the linker's hash tables to a prime number
  close to _number_.  Increasing this value can reduce the length of
  time it takes the linker to perform its tasks, at the expense of
  increasing the linker's memory requirements.  Similarly reducing this
  value can reduce the memory requirements at the expense of speed.
* **--hash-style=**_style_  
  .IX Item "--hash-style=style"
  Set the type of linker's hash table(s).  _style_ can be either
  \f(CW`sysv\*(C' for classic \s-1ELF\s0 \f(CW\*(C\`.hash\*(C' section, \f(CW\*(C\`gnu\*(C' for
  new style \s-1GNU\s0 \f(CW`.gnu.hash\*(C' section or \f(CW\*(C\`both\*(C' for both
  the classic \s-1ELF\s0 \f(CW`.hash\*(C' and new style \s-1GNU\s0 \f(CW\*(C\`.gnu.hash\*(C'
  hash tables.  The default is \f(CW`sysv\*(C'.
* **--compress-debug-sections=none**  
  .IX Item "--compress-debug-sections=none"
* **--compress-debug-sections=zlib**  
  .IX Item "--compress-debug-sections=zlib"
* **--compress-debug-sections=zlib-gnu**  
  .IX Item "--compress-debug-sections=zlib-gnu"
* **--compress-debug-sections=zlib-gabi**  
  .IX Item "--compress-debug-sections=zlib-gabi"
  On \s-1ELF\s0 platforms, these options control how \s-1DWARF\s0 debug sections are
  compressed using zlib.
  .Sp
  **--compress-debug-sections=none** doesn't compress \s-1DWARF\s0 debug
  sections.  **--compress-debug-sections=zlib-gnu** compresses
  \s-1DWARF\s0 debug sections and renames them to begin with **.zdebug**
  instead of **.debug**.  **--compress-debug-sections=zlib-gabi**
  also compresses \s-1DWARF\s0 debug sections, but rather than renaming them it
  sets the \s-1SHF_COMPRESSED\s0 flag in the sections' headers.
  .Sp
  The **--compress-debug-sections=zlib** option is an alias for
  **--compress-debug-sections=zlib-gabi**.
  .Sp
  Note that this option overrides any compression in input debug
  sections, so if a binary is linked with **--compress-debug-sections=none**
  for example, then any compressed debug sections in input files will be
  uncompressed before they are copied into the output binary.
  .Sp
  The default compression behaviour varies depending upon the target
  involved and the configure options used to build the toolchain.  The
  default can be determined by examining the output from the linker's
  **--help** option.
* **--reduce-memory-overheads**  
  .IX Item "--reduce-memory-overheads"
  This option reduces memory requirements at ld runtime, at the expense of
  linking speed.  This was introduced to select the old O(n^2) algorithm
  for link map file generation, rather than the new O(n) algorithm which uses
  about 40% more memory for symbol storage.
  .Sp
  Another effect of the switch is to set the default hash table size to
  1021, which again saves memory at the cost of lengthening the linker's
  run time.  This is not done however if the **--hash-size** switch
  has been used.
  .Sp
  The **--reduce-memory-overheads** switch may be also be used to
  enable other tradeoffs in future versions of the linker.
* **--build-id**  
  .IX Item "--build-id"
* **--build-id=**_style_  
  .IX Item "--build-id=style"
  Request the creation of a \f(CW`.note.gnu.build-id\*(C' \s-1ELF\s0 note section
  or a \f(CW`.buildid\*(C' \s-1COFF\s0 section.  The contents of the note are
  unique bits identifying this linked file.  _style_ can be
  \f(CW`uuid\*(C' to use 128 random bits, \f(CW\*(C\`sha1\*(C' to use a 160-bit
  \s-1SHA1\s0 hash on the normative parts of the output contents,
  \f(CW`md5\*(C' to use a 128-bit \s-1MD5\s0 hash on the normative parts of
  the output contents, or \f(CW`0x\f(CIhexstring\f(CW\*(C' to use a chosen bit
  string specified as an even number of hexadecimal digits (\f(CW`-\*(C' and
  \f(CW`:\*(C' characters between digit pairs are ignored).  If _style_
  is omitted, \f(CW`sha1\*(C' is used.
  .Sp
  The \f(CW`md5\*(C' and \f(CW\*(C\`sha1\*(C' styles produces an identifier
  that is always the same in an identical output file, but will be
  unique among all nonidentical output files.  It is not intended
  to be compared as a checksum for the file's contents.  A linked
  file may be changed later by other tools, but the build \s-1ID\s0 bit
  string identifying the original linked file does not change.
  .Sp
  Passing \f(CW`none\*(C' for _style_ disables the setting from any
  \f(CW`--build-id\*(C' options earlier on the command line.

The i386 \s-1PE\s0 linker supports the **-shared** option, which causes
the output to be a dynamically linked library (\s-1DLL\s0) instead of a
normal executable.  You should name the output \f(CW`*.dll\*(C' when you
use this option.  In addition, the linker fully supports the standard
\f(CW`*.def\*(C' files, which may be specified on the linker command line
like an object file (in fact, it should precede archives it exports
symbols from, to ensure that they get linked in, just like a normal
object file).

In addition to the options common to all targets, the i386 \s-1PE\s0 linker
support additional command line options that are specific to the i386
\s-1PE\s0 target.  Options that take values may be separated from their
values by either a space or an equals sign.

* **--add-stdcall-alias**  
  .IX Item "--add-stdcall-alias"
  If given, symbols with a stdcall suffix (@_nn_) will be exported
  as-is and also with the suffix stripped.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--base-file** _file_  
  .IX Item "--base-file file"
  Use _file_ as the name of a file in which to save the base
  addresses of all the relocations needed for generating DLLs with
  _dlltool_.
  [This is an i386 \s-1PE\s0 specific option]
* **--dll**  
  .IX Item "--dll"
  Create a \s-1DLL\s0 instead of a regular executable.  You may also use
  **-shared** or specify a \f(CW`LIBRARY\*(C' in a given \f(CW\*(C\`.def\*(C'
  file.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--enable-long-section-names**  
  .IX Item "--enable-long-section-names"
* **--disable-long-section-names**  
  .IX Item "--disable-long-section-names"
  The \s-1PE\s0 variants of the \s-1COFF\s0 object format add an extension that permits
  the use of section names longer than eight characters, the normal limit
  for \s-1COFF.\s0  By default, these names are only allowed in object files, as
  fully-linked executable images do not carry the \s-1COFF\s0 string table required
  to support the longer names.  As a \s-1GNU\s0 extension, it is possible to
  allow their use in executable images as well, or to (probably pointlessly!)
  disallow it in object files, by using these two options.  Executable images
  generated with these long section names are slightly non-standard, carrying
  as they do a string table, and may generate confusing output when examined
  with non-GNU PE-aware tools, such as file viewers and dumpers.  However,
  \s-1GDB\s0 relies on the use of \s-1PE\s0 long section names to find Dwarf-2 debug
  information sections in an executable image at runtime, and so if neither
  option is specified on the command-line, **ld** will enable long
  section names, overriding the default and technically correct behaviour,
  when it finds the presence of debug information while linking an executable
  image and not stripping symbols.
  [This option is valid for all \s-1PE\s0 targeted ports of the linker]
* **--enable-stdcall-fixup**  
  .IX Item "--enable-stdcall-fixup"
* **--disable-stdcall-fixup**  
  .IX Item "--disable-stdcall-fixup"
  If the link finds a symbol that it cannot resolve, it will attempt to
  do fuzzy linking\*(R" by looking for another defined symbol that differs
  only in the format of the symbol name (cdecl vs stdcall) and will
  resolve that symbol by linking to the match.  For example, the
  undefined symbol \f(CW`\_foo\*(C' might be linked to the function
  \f(CW`\_foo@12\*(C', or the undefined symbol \f(CW\*(C\`\_bar@16\*(C' might be linked
  to the function \f(CW`\_bar\*(C'.  When the linker does this, it prints a
  warning, since it normally should have failed to link, but sometimes
  import libraries generated from third-party dlls may need this feature
  to be usable.  If you specify **--enable-stdcall-fixup**, this
  feature is fully enabled and warnings are not printed.  If you specify
  **--disable-stdcall-fixup**, this feature is disabled and such
  mismatches are considered to be errors.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--leading-underscore**  
  .IX Item "--leading-underscore"
* **--no-leading-underscore**  
  .IX Item "--no-leading-underscore"
  For most targets default symbol-prefix is an underscore and is defined
  in target's description. By this option it is possible to
  disable/enable the default underscore symbol-prefix.
* **--export-all-symbols**  
  .IX Item "--export-all-symbols"
  If given, all global symbols in the objects used to build a \s-1DLL\s0 will
  be exported by the \s-1DLL.\s0  Note that this is the default if there
  otherwise wouldn't be any exported symbols.  When symbols are
  explicitly exported via \s-1DEF\s0 files or implicitly exported via function
  attributes, the default is to not export anything else unless this
  option is given.  Note that the symbols \f(CW`DllMain@12\*(C',
  \f(CW`DllEntryPoint@0\*(C', \f(CW\*(C\`DllMainCRTStartup@12\*(C', and
  \f(CW`impure\_ptr\*(C' will not be automatically
  exported.  Also, symbols imported from other DLLs will not be
  re-exported, nor will symbols specifying the \s-1DLL\s0's internal layout
  such as those beginning with \f(CW`\_head\_\*(C' or ending with
  \f(CW`\_iname\*(C'.  In addition, no symbols from \f(CW\*(C\`libgcc\*(C',
  \f(CW`libstd++\*(C', \f(CW\*(C\`libmingw32\*(C', or \f(CW\*(C\`crtX.o\*(C' will be exported.
  Symbols whose names begin with \f(CW`\_\|\_rtti\_\*(C' or \f(CW\*(C\`\_\|\_builtin\_\*(C' will
  not be exported, to help with  DLLs.  Finally, there is an
  extensive list of cygwin-private symbols that are not exported
  (obviously, this applies on when building DLLs for cygwin targets).
  These cygwin-excludes are: \f(CW`\_cygwin\_dll\_entry@12\*(C',
  \f(CW`\_cygwin\_crt0\_common@8\*(C', \f(CW\*(C\`\_cygwin\_noncygwin\_dll\_entry@12\*(C',
  \f(CW`\_fmode\*(C', \f(CW\*(C\`\_impure\_ptr\*(C', \f(CW\*(C\`cygwin\_attach\_dll\*(C',
  \f(CW`cygwin\_premain0\*(C', \f(CW\*(C\`cygwin\_premain1\*(C', \f(CW\*(C\`cygwin\_premain2\*(C',
  \f(CW`cygwin\_premain3\*(C', and \f(CW\*(C\`environ\*(C'.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--exclude-symbols** _symbol_**,**_symbol_**,...**  
  .IX Item "--exclude-symbols symbol,symbol,..."
  Specifies a list of symbols which should not be automatically
  exported.  The symbol names may be delimited by commas or colons.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--exclude-all-symbols**  
  .IX Item "--exclude-all-symbols"
  Specifies no symbols should be automatically exported.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--file-alignment**  
  .IX Item "--file-alignment"
  Specify the file alignment.  Sections in the file will always begin at
  file offsets which are multiples of this number.  This defaults to
  512.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--heap** _reserve_  
  .IX Item "--heap reserve"
* **--heap** _reserve_**,**_commit_  
  .IX Item "--heap reserve,commit"
  Specify the number of bytes of memory to reserve (and optionally commit)
  to be used as heap for this program.  The default is 1MB reserved, 4K
  committed.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--image-base** _value_  
  .IX Item "--image-base value"
  Use _value_ as the base address of your program or dll.  This is
  the lowest memory location that will be used when your program or dll
  is loaded.  To reduce the need to relocate and improve performance of
  your dlls, each should have a unique base address and not overlap any
  other dlls.  The default is 0x400000 for executables, and 0x10000000
  for dlls.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--kill-at**  
  .IX Item "--kill-at"
  If given, the stdcall suffixes (@_nn_) will be stripped from
  symbols before they are exported.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--large-address-aware**  
  .IX Item "--large-address-aware"
  If given, the appropriate bit in the Characteristics\*(R" field of the \s-1COFF\s0
  header is set to indicate that this executable supports virtual addresses
  greater than 2 gigabytes.  This should be used in conjunction with the /3GB
  or /USERVA=_value_ megabytes switch in the [operating systems]\*(R"
  section of the \s-1BOOT.INI.\s0  Otherwise, this bit has no effect.
  [This option is specific to \s-1PE\s0 targeted ports of the linker]
* **--disable-large-address-aware**  
  .IX Item "--disable-large-address-aware"
  Reverts the effect of a previous **--large-address-aware** option.
  This is useful if **--large-address-aware** is always set by the compiler
  driver (e.g. Cygwin gcc) and the executable does not support virtual
  addresses greater than 2 gigabytes.
  [This option is specific to \s-1PE\s0 targeted ports of the linker]
* **--major-image-version** _value_  
  .IX Item "--major-image-version value"
  Sets the major number of the image version\*(R".  Defaults to 1.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--major-os-version** _value_  
  .IX Item "--major-os-version value"
  Sets the major number of the os version\*(R".  Defaults to 4.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--major-subsystem-version** _value_  
  .IX Item "--major-subsystem-version value"
  Sets the major number of the subsystem version\*(R".  Defaults to 4.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--minor-image-version** _value_  
  .IX Item "--minor-image-version value"
  Sets the minor number of the image version\*(R".  Defaults to 0.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--minor-os-version** _value_  
  .IX Item "--minor-os-version value"
  Sets the minor number of the os version\*(R".  Defaults to 0.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--minor-subsystem-version** _value_  
  .IX Item "--minor-subsystem-version value"
  Sets the minor number of the subsystem version\*(R".  Defaults to 0.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--output-def** _file_  
  .IX Item "--output-def file"
  The linker will create the file _file_ which will contain a \s-1DEF\s0
  file corresponding to the \s-1DLL\s0 the linker is generating.  This \s-1DEF\s0 file
  (which should be called \f(CW`*.def\*(C') may be used to create an import
  library with \f(CW`dlltool\*(C' or may be used as a reference to
  automatically or implicitly exported symbols.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--enable-auto-image-base**  
  .IX Item "--enable-auto-image-base"
* **--enable-auto-image-base=**_value_  
  .IX Item "--enable-auto-image-base=value"
  Automatically choose the image base for DLLs, optionally starting with base
  _value_, unless one is specified using the \f(CW`--image-base\*(C' argument.
  By using a hash generated from the dllname to create unique image bases
  for each \s-1DLL,\s0 in-memory collisions and relocations which can delay program
  execution are avoided.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--disable-auto-image-base**  
  .IX Item "--disable-auto-image-base"
  Do not automatically generate a unique image base.  If there is no
  user-specified image base (\f(CW`--image-base\*(C') then use the platform
  default.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--dll-search-prefix** _string_  
  .IX Item "--dll-search-prefix string"
  When linking dynamically to a dll without an import library,
  search for \f(CW`&lt;string&gt;&lt;basename&gt;.dll\*(C' in preference to
  \f(CW`lib&lt;basename&gt;.dll\*(C'. This behaviour allows easy distinction
  between DLLs built for the various subplatforms\*(R": native, cygwin,
  uwin, pw, etc.  For instance, cygwin DLLs typically use
  \f(CW`--dll-search-prefix=cyg\*(C'.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--enable-auto-import**  
  .IX Item "--enable-auto-import"
  Do sophisticated linking of \f(CW`\_symbol\*(C' to \f(CW\*(C\`\_\|\_imp\_\|\_symbol\*(C' for
  \s-1DATA\s0 imports from DLLs, thus making it possible to bypass the dllimport
  mechanism on the user side and to reference unmangled symbol names.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
  .Sp
  The following remarks pertain to the original implementation of the
  feature and are obsolete nowadays for Cygwin and MinGW targets.
  .Sp
  Note: Use of the 'auto-import' extension will cause the text section
  of the image file to be made writable. This does not conform to the
  PE-COFF format specification published by Microsoft.
  .Sp
  Note - use of the 'auto-import' extension will also cause read only
  data which would normally be placed into the .rdata section to be
  placed into the .data section instead.  This is in order to work
  around a problem with consts that is described here:
  http://www.cygwin.com/ml/cygwin/2004-09/msg01101.html
  .Sp
  Using 'auto-import' generally will 'just work'  but sometimes you may
  see this message:
  .Sp
  "variable '&lt;var&gt;' can't be auto-imported. Please read the
  documentation for ld's \f(CW`--enable-auto-import\*(C' for details."
  .Sp
  This message occurs when some (sub)expression accesses an address
  ultimately given by the sum of two constants (Win32 import tables only
  allow one).  Instances where this may occur include accesses to member
  fields of struct variables imported from a \s-1DLL,\s0 as well as using a
  constant index into an array variable imported from a \s-1DLL.\s0  Any
  multiword variable (arrays, structs, long long, etc) may trigger
  this error condition.  However, regardless of the exact data type
  of the offending exported variable, ld will always detect it, issue
  the warning, and exit.
  .Sp
  There are several ways to address this difficulty, regardless of the
  data type of the exported variable:
  .Sp
  One way is to use --enable-runtime-pseudo-reloc switch. This leaves the task
  of adjusting references in your client code for runtime environment, so
  this method works only when runtime environment supports this feature.
  .Sp
  A second solution is to force one of the 'constants' to be a variable 
  that is, unknown and un-optimizable at compile time.  For arrays,
  there are two possibilities: a) make the indexee (the array's address)
  a variable, or b) make the 'constant' index a variable.  Thus:
  .Sp
  .Vb 3
          extern type extern_array[];
          extern_array[1] --&gt;
             { volatile type *t=extern_array; t[1] }
  .Ve
  .Sp
  or
  .Sp
  .Vb 3
          extern type extern_array[];
          extern_array[1] --&gt;
             { volatile int t=1; extern_array[t] }
  .Ve
  .Sp
  For structs (and most other multiword data types) the only option
  is to make the struct itself (or the long long, or the ...) variable:
  .Sp
  .Vb 3
          extern struct s extern_struct;
          extern_struct.field --&gt;
             { volatile struct s *t=&extern_struct; t-&gt;field }
  .Ve
  .Sp
  or
  .Sp
  .Vb 3
          extern long long extern_ll;
          extern_ll --&gt;
            { volatile long long * local_ll=&extern_ll; *local_ll }
  .Ve
  .Sp
  A third method of dealing with this difficulty is to abandon
  'auto-import' for the offending symbol and mark it with
  \f(CW`\_\|\_declspec(dllimport)\*(C'.  However, in practice that
  requires using compile-time #defines to indicate whether you are
  building a \s-1DLL,\s0 building client code that will link to the \s-1DLL,\s0 or
  merely building/linking to a static library.   In making the choice
  between the various methods of resolving the 'direct address with
  constant offset' problem, you should consider typical real-world usage:
  .Sp
  Original:
  .Sp
  .Vb 7
          --foo.h
          extern int arr[];
          --foo.c
          #include "foo.h"
          void main(int argc, char **argv){
            printf("%d\en",arr[1]);
          }
  .Ve
  .Sp
  Solution 1:
  .Sp
  .Vb 9
          --foo.h
          extern int arr[];
          --foo.c
          #include "foo.h"
          void main(int argc, char **argv){
            /* This workaround is for win32 and cygwin; do not "optimize" */
            volatile int *parr = arr;
            printf("%d\en",parr[1]);
          }
  .Ve
  .Sp
  Solution 2:
  .Sp
  .Vb 10
          --foo.h
          /* Note: auto-export is assumed (no _\|_declspec(dllexport)) */
          #if (defined(_WIN32) || defined(_\|_CYGWIN_\|_)) && \e
            !(defined(FOO_BUILD_DLL) || defined(FOO_STATIC))
          #define FOO_IMPORT _\|_declspec(dllimport)
          #else
          #define FOO_IMPORT
          #endif
          extern FOO_IMPORT int arr[];
          --foo.c
          #include "foo.h"
          void main(int argc, char **argv){
            printf("%d\en",arr[1]);
          }
  .Ve
  .Sp
  A fourth way to avoid this problem is to re-code your
  library to use a functional interface rather than a data interface
  for the offending variables (e.g. **set\_foo()** and **get\_foo()** accessor
  functions).
* **--disable-auto-import**  
  .IX Item "--disable-auto-import"
  Do not attempt to do sophisticated linking of \f(CW`\_symbol\*(C' to
  \f(CW`\_\|\_imp\_\|\_symbol\*(C' for \s-1DATA\s0 imports from DLLs.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--enable-runtime-pseudo-reloc**  
  .IX Item "--enable-runtime-pseudo-reloc"
  If your code contains expressions described in --enable-auto-import section,
  that is, \s-1DATA\s0 imports from \s-1DLL\s0 with non-zero offset, this switch will create
  a vector of 'runtime pseudo relocations' which can be used by runtime
  environment to adjust references to such data in your client code.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--disable-runtime-pseudo-reloc**  
  .IX Item "--disable-runtime-pseudo-reloc"
  Do not create pseudo relocations for non-zero offset \s-1DATA\s0 imports from DLLs.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--enable-extra-pe-debug**  
  .IX Item "--enable-extra-pe-debug"
  Show additional debug info related to auto-import symbol thunking.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--section-alignment**  
  .IX Item "--section-alignment"
  Sets the section alignment.  Sections in memory will always begin at
  addresses which are a multiple of this number.  Defaults to 0x1000.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--stack** _reserve_  
  .IX Item "--stack reserve"
* **--stack** _reserve_**,**_commit_  
  .IX Item "--stack reserve,commit"
  Specify the number of bytes of memory to reserve (and optionally commit)
  to be used as stack for this program.  The default is 2MB reserved, 4K
  committed.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
* **--subsystem** _which_  
  .IX Item "--subsystem which"
* **--subsystem** _which_**:**_major_  
  .IX Item "--subsystem which:major"
* **--subsystem** _which_**:**_major_**.**_minor_  
  .IX Item "--subsystem which:major.minor"
  Specifies the subsystem under which your program will execute.  The
  legal values for _which_ are \f(CW`native\*(C', \f(CW\*(C\`windows\*(C',
  \f(CW`console\*(C', \f(CW\*(C\`posix\*(C', and \f(CW\*(C\`xbox\*(C'.  You may optionally set
  the subsystem version also.  Numeric values are also accepted for
  _which_.
  [This option is specific to the i386 \s-1PE\s0 targeted port of the linker]
  .Sp
  The following options set flags in the \f(CW`DllCharacteristics\*(C' field
  of the \s-1PE\s0 file header:
  [These options are specific to \s-1PE\s0 targeted ports of the linker]
* **--high-entropy-va**  
  .IX Item "--high-entropy-va"
  Image is compatible with 64-bit address space layout randomization
  (\s-1ASLR\s0).
* **--dynamicbase**  
  .IX Item "--dynamicbase"
  The image base address may be relocated using address space layout
  randomization (\s-1ASLR\s0).  This feature was introduced with \s-1MS\s0 Windows
  Vista for i386 \s-1PE\s0 targets.
* **--forceinteg**  
  .IX Item "--forceinteg"
  Code integrity checks are enforced.
* **--nxcompat**  
  .IX Item "--nxcompat"
  The image is compatible with the Data Execution Prevention.
  This feature was introduced with \s-1MS\s0 Windows \s-1XP SP2\s0 for i386 \s-1PE\s0 targets.
* **--no-isolation**  
  .IX Item "--no-isolation"
  Although the image understands isolation, do not isolate the image.
* **--no-seh**  
  .IX Item "--no-seh"
  The image does not use \s-1SEH.\s0 No \s-1SE\s0 handler may be called from
  this image.
* **--no-bind**  
  .IX Item "--no-bind"
  Do not bind this image.
* **--wdmdriver**  
  .IX Item "--wdmdriver"
  The driver uses the \s-1MS\s0 Windows Driver Model.
* **--tsaware**  
  .IX Item "--tsaware"
  The image is Terminal Server aware.
* **--insert-timestamp**  
  .IX Item "--insert-timestamp"
* **--no-insert-timestamp**  
  .IX Item "--no-insert-timestamp"
  Insert a real timestamp into the image.  This is the default behaviour
  as it matches legacy code and it means that the image will work with
  other, proprietary tools.  The problem with this default is that it
  will result in slightly different images being produced each time the
  same sources are linked.  The option **--no-insert-timestamp**
  can be used to insert a zero value for the timestamp, this ensuring
  that binaries produced from identical sources will compare
  identically.

The C6X uClinux target uses a binary format called \s-1DSBT\s0 to support shared
libraries.  Each shared library in the system needs to have a unique index;
all executables use an index of 0.

* **--dsbt-size** _size_  
  .IX Item "--dsbt-size size"
  This option sets the number of entries in the \s-1DSBT\s0 of the current executable
  or shared library to _size_.  The default is to create a table with 64
  entries.
* **--dsbt-index** _index_  
  .IX Item "--dsbt-index index"
  This option sets the \s-1DSBT\s0 index of the current executable or shared library
  to _index_.  The default is 0, which is appropriate for generating
  executables.  If a shared library is generated with a \s-1DSBT\s0 index of 0, the
  \f(CW`R\_C6000\_DSBT\_INDEX\*(C' relocs are copied into the output file.
  .Sp
  The **--no-merge-exidx-entries** switch disables the merging of adjacent
  exidx entries in frame unwind info.

The 68HC11 and 68HC12 linkers support specific options to control the
memory bank switching mapping and trampoline code generation.

* **--no-trampoline**  
  .IX Item "--no-trampoline"
  This option disables the generation of trampoline. By default a trampoline
  is generated for each far function which is called using a \f(CW`jsr\*(C'
  instruction (this happens when a pointer to a far function is taken).
* **--bank-window** _name_  
  .IX Item "--bank-window name"
  This option indicates to the linker the name of the memory region in
  the **\s-1MEMORY\s0** specification that describes the memory bank window.
  The definition of such region is then used by the linker to compute
  paging and addresses within the memory window.

The following options are supported to control handling of \s-1GOT\s0 generation
when linking for 68K targets.

* **--got=**_type_  
  .IX Item "--got=type"
  This option tells the linker which \s-1GOT\s0 generation scheme to use.
  _type_ should be one of **single**, **negative**,
  **multigot** or **target**.  For more information refer to the
  Info entry for _ld_.

The following options are supported to control microMIPS instruction
generation and branch relocation checks for \s-1ISA\s0 mode transitions when
linking for \s-1MIPS\s0 targets.

* **--insn32**  
  .IX Item "--insn32"
* **--no-insn32**  
  .IX Item "--no-insn32"
  These options control the choice of microMIPS instructions used in code
  generated by the linker, such as that in the \s-1PLT\s0 or lazy binding stubs,
  or in relaxation.  If **--insn32** is used, then the linker only uses
  32-bit instruction encodings.  By default or if **--no-insn32** is
  used, all instruction encodings are used, including 16-bit ones where
  possible.
* **--ignore-branch-isa**  
  .IX Item "--ignore-branch-isa"
* **--no-ignore-branch-isa**  
  .IX Item "--no-ignore-branch-isa"
  These options control branch relocation checks for invalid \s-1ISA\s0 mode
  transitions.  If **--ignore-branch-isa** is used, then the linker
  accepts any branch relocations and any \s-1ISA\s0 mode transition required
  is lost in relocation calculation, except for some cases of \f(CW`BAL\*(C'
  instructions which meet relaxation conditions and are converted to
  equivalent \f(CW`JALX\*(C' instructions as the associated relocation is
  calculated.  By default or if **--no-ignore-branch-isa** is used
  a check is made causing the loss of an \s-1ISA\s0 mode transition to produce
  an error.

<a name="environment"></a>

# Environment

.IX Header "ENVIRONMENT"
You can change the behaviour of **ld** with the environment variables
\f(CW`GNUTARGET\*(C',
\f(CW`LDEMULATION\*(C' and \f(CW\*(C\`COLLECT\_NO\_DEMANGLE\*(C'.

\f(CW`GNUTARGET\*(C' determines the input-file object format if you don't
use **-b** (or its synonym **--format**).  Its value should be one
of the \s-1BFD\s0 names for an input format.  If there is no
\f(CW`GNUTARGET\*(C' in the environment, **ld** uses the natural format
of the target. If \f(CW`GNUTARGET\*(C' is set to \f(CW\*(C\`default\*(C' then \s-1BFD\s0
attempts to discover the input format by examining binary input files;
this method often succeeds, but there are potential ambiguities, since
there is no method of ensuring that the magic number used to specify
object-file formats is unique.  However, the configuration procedure for
\s-1BFD\s0 on each system places the conventional format for that system first
in the search-list, so ambiguities are resolved in favor of convention.

\f(CW`LDEMULATION\*(C' determines the default emulation if you don't use the
**-m** option.  The emulation can affect various aspects of linker
behaviour, particularly the default linker script.  You can list the
available emulations with the **--verbose** or **-V** options.  If
the **-m** option is not used, and the \f(CW`LDEMULATION\*(C' environment
variable is not defined, the default emulation depends upon how the
linker was configured.

Normally, the linker will default to demangling symbols.  However, if
\f(CW`COLLECT\_NO\_DEMANGLE\*(C' is set in the environment, then it will
default to not demangling symbols.  This environment variable is used in
a similar fashion by the \f(CW`gcc\*(C' linker wrapper program.  The default
may be overridden by the **--demangle** and **--no-demangle**
options.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ar**\|(1), **nm**\|(1), **objcopy**\|(1), **objdump**\|(1), **readelf**\|(1) and
the Info entries for _binutils_ and
_ld_.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1991-2018 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, with no Front-Cover Texts, and with no
Back-Cover Texts.  A copy of the license is included in the
section entitled \s-1GNU\s0 Free Documentation License\*(R".
