# llvm-ar(1) - LLVM archiver

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

 llvm-ar [-]{dmpqrstx}[abcDilLNoOPsSTuUvV] [relpos] [count] archive [files...]
```

<a name="description"></a>

# Description


The **llvm-ar** command is similar to the common Unix utility,
**ar**. It archives several files, such as objects and LLVM bitcode
files into a single archive library that can be linked into a program. However,
the archive can contain any kind of file. By default, **llvm-ar**
generates a symbol table that makes linking faster because only the symbol
table needs to be consulted, not each individual file member of the archive.

The **llvm-ar** command can be used to _read_ archive files in SVR4,
GNU, BSD and Darwin format, and _write_ in the GNU, BSD, and Darwin style
archive files. If an SVR4 format archive is used with the _r_
(replace), _d_ (delete), _m_ (move) or _q_
(quick update) operations, the archive will be reconstructed in the format
defined by _--format_.

Here's where **llvm-ar** departs from previous **ar**
implementations:

_The following option is not supported_
.INDENT 0.0
.INDENT 3.5
[f] - truncate inserted filenames
.UNINDENT
.UNINDENT

_The following options are ignored for compatibility_
.INDENT 0.0
.INDENT 3.5
--plugin=&lt;string&gt; - load a plugin which adds support for other file formats

[l] - ignored in **ar**
.UNINDENT
.UNINDENT

_Symbol Table_
.INDENT 0.0
.INDENT 3.5
Since **llvm-ar** supports bitcode files, the symbol table it creates
includes both native and bitcode symbols.
.UNINDENT
.UNINDENT

_Deterministic Archives_
.INDENT 0.0
.INDENT 3.5
By default, **llvm-ar** always uses zero for timestamps and UIDs/GIDs
to write archives in a deterministic mode. This is equivalent to the
_D_ modifier being enabled by default. If you wish to maintain
compatibility with other **ar** implementations, you can pass the
_U_ modifier to write actual timestamps and UIDs/GIDs.
.UNINDENT
.UNINDENT

_Windows Paths_
.INDENT 0.0
.INDENT 3.5
When on Windows **llvm-ar** treats the names of archived _files_ in the same
case sensitive manner as the operating system. When on a non-Windows machine
**llvm-ar** does not consider character case.
.UNINDENT
.UNINDENT

<a name="options"></a>

# Options


**llvm-ar** operations are compatible with other **ar**
implementations. However, there are a few modifiers (_L_) that are not
found in other **ar** implementations. The options for
**llvm-ar** specify a single basic Operation to perform on the archive,
a variety of Modifiers for that Operation, the name of the archive file, and an
optional list of file names. If the _files_ option is not specified, it
generally means either "none" or "all" members, depending on the operation. The
Options, Operations and Modifiers are explained in the sections below.

The minimal set of options is at least one operator and the name of the
archive.

<a name="operations"></a>

### Operations

.INDENT 0.0

* **d [NT]**  
  Delete files from the **archive**. The _N_ and _T_ modifiers
  apply to this operation. The _files_ options specify which members should be
  removed from the archive. It is not an error if a specified file does not
  appear in the archive. If no _files_ are specified, the archive is not
  modified.
  .UNINDENT
  .INDENT 0.0
* **m [abi]**  
  Move files from one location in the **archive** to another. The _a_,
  _b_, and _i_ modifiers apply to this operation. The _files_
  will all be moved to the location given by the modifiers. If no modifiers are
  used, the files will be moved to the end of the archive. If no _files_ are
  specified, the archive is not modified.
  .UNINDENT
  .INDENT 0.0
* **p [v]**  
  Print _files_ to the standard output stream. If no _files_ are specified, the
  entire **archive** is printed. With the _v_ modifier,
  **llvm-ar** also prints out the name of the file being output. Printing
  binary files is  ill-advised as they might confuse your terminal settings. The
  _p_ operation never modifies the archive.
  .UNINDENT
  .INDENT 0.0
* **q [LT]**  
  Quickly append files to the end of the **archive** without removing
  duplicates. If no _files_ are specified, the archive is not modified. The
  behavior when appending one archive to another depends upon whether the
  _L_ and _T_ modifiers are used:
  .INDENT 7.0
* ·  
  Appending a regular archive to a regular archive will append the archive
  file. If the _L_ modifier is specified the members will be appended
  instead.
* ·  
  Appending a regular archive to a thin archive requires the _T_
  modifier and will append the archive file. The _L_ modifier is not
  supported.
* ·  
  Appending a thin archive to a regular archive will append the archive file.
  If the _L_ modifier is specified the members will be appended
  instead.
* ·  
  Appending a thin archive to a thin archive will always quick append its
  members.
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **r [abTu]**  
  Replace existing _files_ or insert them at the end of the **archive** if
  they do not exist. The _a_, _b_, _T_ and _u_
  modifiers apply to this operation. If no _files_ are specified, the archive
  is not modified.
  .UNINDENT

t[v]
.. option:: t [vO]
.INDENT 0.0
.INDENT 3.5
Print the table of contents. Without any modifiers, this operation just prints
the names of the members to the standard output stream. With the _v_
modifier, **llvm-ar** also prints out the file type (B=bitcode,
S=symbol table, blank=regular file), the permission mode, the owner and group,
are ignored when extracting _files_ and set to placeholder values when adding
size, and the date. With the _O_ modifier, display member offsets. If
any _files_ are specified, the listing is only for those files. If no _files_
are specified, the table of contents for the whole archive is printed.
.UNINDENT
.UNINDENT
.INDENT 0.0

* **V**  
  A synonym for the _--version_ option.
  .UNINDENT
  .INDENT 0.0
* **x [oP]**  
  Extract **archive** members back to files. The _o_ modifier applies
  to this operation. This operation retrieves the indicated _files_ from the
  archive and writes them back to the operating system's file system. If no
  _files_ are specified, the entire archive is extracted.
  .UNINDENT

<a name="modifiers-operation-specific"></a>

### Modifiers (operation specific)


The modifiers below are specific to certain operations. See the Operations
section to determine which modifiers are applicable to which operations.
.INDENT 0.0

* **a**  
  When inserting or moving member files, this option specifies the destination
  of the new files as being after the _relpos_ member. If _relpos_ is not found,
  the files are placed at the end of the **archive**. _relpos_ cannot be
  consumed without either _a_, _b_ or _i_.
  .UNINDENT
  .INDENT 0.0
* **b**  
  When inserting or moving member files, this option specifies the destination
  of the new files as being before the _relpos_ member. If _relpos_ is not
  found, the files are placed at the end of the **archive**. _relpos_ cannot
  be consumed without either _a_, _b_ or _i_. This
  modifier is identical to the _i_ modifier.
  .UNINDENT
  .INDENT 0.0
* **i**  
  A synonym for the _b_ option.
  .UNINDENT
  .INDENT 0.0
* **L**  
  When quick appending an **archive**, instead quick append its members. This
  is a feature for **llvm-ar** that is not found in gnu-ar.
  .UNINDENT
  .INDENT 0.0
* **N**  
  When extracting or deleting a member that shares its name with another member,
  the _count_ parameter allows you to supply a positive whole number that
  selects the instance of the given name, with "1" indicating the first
  instance. If _N_ is not specified the first member of that name will
  be selected. If _count_ is not supplied, the operation fails.*count* cannot be
  .UNINDENT
  .INDENT 0.0
* **o**  
  When extracting files, use the modification times of any _files_ as they
  appear in the **archive**. By default _files_ extracted from the archive
  use the time of extraction.
  .UNINDENT
  .INDENT 0.0
* **O**  
  Display member offsets inside the archive.
  .UNINDENT
  .INDENT 0.0
* **T**  
  When creating or modifying an archive, this option specifies that the
  **archive** will be thin. By default, archives are not created as thin
  archives and when modifying a thin archive, it will be converted to a regular
  archive.
  .UNINDENT
  .INDENT 0.0
* **v**  
  When printing _files_ or the **archive** table of contents, this modifier
  instructs **llvm-ar** to include additional information in the output.
  .UNINDENT

<a name="modifiers-generic"></a>

### Modifiers (generic)


The modifiers below may be applied to any operation.
.INDENT 0.0

* **c**  
  For the _r_ (replace)and _q_ (quick update) operations,
  **llvm-ar** will always create the archive if it doesn't exist.
  Normally, **llvm-ar** will print a warning message indicating that the
  **archive** is being created. Using this modifier turns off
  that warning.
  .UNINDENT
  .INDENT 0.0
* **D**  
  Use zero for timestamps and UIDs/GIDs. This is set by default.
  .UNINDENT
  .INDENT 0.0
* **P**  
  Use full paths when matching member names rather than just the file name.
  This can be useful when manipulating an **archive** generated by another
  archiver, as some allow paths as member names. This is the default behavior
  for thin archives.
  .UNINDENT
  .INDENT 0.0
* **s**  
  This modifier requests that an archive index (or symbol table) be added to the
  **archive**, as if using ranlib. The symbol table will contain all the
  externally visible functions and global variables defined by all the bitcode
  files in the archive. By default **llvm-ar** generates symbol tables in
  archives. This can also be used as an operation.
  .UNINDENT
  .INDENT 0.0
* **S**  
  This modifier is the opposite of the _s_ modifier. It instructs
  **llvm-ar** to not build the symbol table. If both _s_ and
  _S_ are used, the last modifier to occur in the options will prevail.
  .UNINDENT
  .INDENT 0.0
* **u**  
  Only update **archive** members with _files_ that have more recent
  timestamps.
  .UNINDENT
  .INDENT 0.0
* **U**  
  Use actual timestamps and UIDs/GIDs.
  .UNINDENT

<a name="other"></a>

### Other

.INDENT 0.0

* **--format=&lt;type&gt;**  
  This option allows for default, gnu, darwin or bsd **&lt;type&gt;** to be selected.
  When creating an **archive**, **&lt;type&gt;** will default to that of the host
  machine.
  .UNINDENT
  .INDENT 0.0
* **-h, --help**  
  Print a summary of command-line options and their meanings.
  .UNINDENT
  .INDENT 0.0
* **-M**  
  This option allows for MRI scripts to be read through the standard input
  stream. No other options are compatible with this option.
  .UNINDENT
  .INDENT 0.0
* **--version**  
  Display the version of the **llvm-ar** executable.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options and commands from response file **&lt;FILE&gt;**.
  .UNINDENT

<a name="mri-scripts"></a>

# Mri Scripts


**llvm-ar** understands a subset of the MRI scripting interface commonly
supported by archivers following in the ar tradition. An MRI script contains a
sequence of commands to be executed by the archiver. The _-M_ option
allows for an MRI script to be passed to **llvm-ar** through the
standard input stream.

Note that **llvm-ar** has known limitations regarding the use of MRI
scripts:
.INDENT 0.0

* ·  
  Each script can only create one archive.
* ·  
  Existing archives can not be modified.
  .UNINDENT

<a name="mri-script-commands"></a>

### MRI Script Commands


Each command begins with the command's name and must appear on its own line.
Some commands have arguments, which must be separated from the name by
whitespace. An MRI script should begin with either a _CREATE_ or
_CREATETHIN_ command and will typically end with a _SAVE_
command. Any text after either '*' or ';' is treated as a comment.
.INDENT 0.0

* **CREATE archive**  
  Begin creation of a regular archive with the specified name. Subsequent
  commands act upon this **archive**.
  .UNINDENT
  .INDENT 0.0
* **CREATETHIN archive**  
  Begin creation of a thin archive with the specified name. Subsequent
  commands act upon this **archive**.
  .UNINDENT
  .INDENT 0.0
* **ADDLIB archive**  
  Append the contents of **archive** to the current archive.
  .UNINDENT
  .INDENT 0.0
* **ADDMOD &lt;file&gt;**  
  Append **&lt;file&gt;** to the current archive.
  .UNINDENT
  .INDENT 0.0
* **DELETE &lt;file&gt;**  
  Delete the member of the current archive whose file name, excluding directory
  components, matches **&lt;file&gt;**.
  .UNINDENT
  .INDENT 0.0
* **SAVE**  
  Write the current archive to the path specified in the previous
  _CREATE_/_CREATETHIN_ command.
  .UNINDENT
  .INDENT 0.0
* **END**  
  Ends the MRI script (optional).
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


If **llvm-ar** succeeds, it will exit with 0.  Otherwise, if an error occurs, it
will exit with a non-zero value.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

