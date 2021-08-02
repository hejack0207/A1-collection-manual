# ar(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

ar - create, modify, and extract from archives

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" ar [-X32_64] [-]p[mod] [--plugin name] [--target bfdname] [relpos] [count] archive [member...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The \s-1GNU\s0 **ar** program creates, modifies, and extracts from
archives.  An _archive_ is a single file holding a collection of
other files in a structure that makes it possible to retrieve
the original individual files (called _members_ of the archive).

The original files' contents, mode (permissions), timestamp, owner, and
group are preserved in the archive, and can be restored on
extraction.

\s-1GNU\s0 **ar** can maintain archives whose members have names of any
length; however, depending on how **ar** is configured on your
system, a limit on member-name length may be imposed for compatibility
with archive formats maintained with other tools.  If it exists, the
limit is often 15 characters (typical of formats related to a.out) or 16
characters (typical of formats related to coff).

**ar** is considered a binary utility because archives of this sort
are most often used as _libraries_ holding commonly needed
subroutines.

**ar** creates an index to the symbols defined in relocatable
object modules in the archive when you specify the modifier **s**.
Once created, this index is updated in the archive whenever **ar**
makes a change to its contents (save for the **q** update operation).
An archive with such an index speeds up linking to the library, and
allows routines in the library to call each other without regard to
their placement in the archive.

You may use **nm -s** or **nm --print-armap** to list this index
table.  If an archive lacks the table, another form of **ar** called
**ranlib** can be used to add just the table.

\s-1GNU\s0 **ar** can optionally create a _thin_ archive,
which contains a symbol index and references to the original copies
of the member files of the archive.  This is useful for building
libraries for use within a local build tree, where the relocatable
objects are expected to remain available, and copying the contents of
each object would only waste time and space.

An archive can either be _thin_ or it can be normal.  It cannot
be both at the same time.  Once an archive is created its format
cannot be changed without first deleting it and then creating a new
archive in its place.

Thin archives are also _flattened_, so that adding one thin
archive to another thin archive does not nest it, as would happen with
a normal archive.  Instead the elements of the first archive are added
individually to the second archive.

The paths to the elements of the archive are stored relative to the
archive itself.

\s-1GNU\s0 **ar** is designed to be compatible with two different
facilities.  You can control its activity using command-line options,
like the different varieties of **ar** on Unix systems; or, if you
specify the single command-line option **-M**, you can control it
with a script supplied via standard input, like the \s-1MRI\s0 librarian\*(R"
program.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
\s-1GNU\s0 **ar** allows you to mix the operation code _p_ and modifier
flags _mod_ in any order, within the first command-line argument.

If you wish, you may begin the first command-line argument with a
dash.

The _p_ keyletter specifies what operation to execute; it may be
any of the following, but you must specify only one of them:

* **d**  
  .IX Item "d"
  _Delete_ modules from the archive.  Specify the names of modules to
  be deleted as _member_...; the archive is untouched if you
  specify no files to delete.
  .Sp
  If you specify the **v** modifier, **ar** lists each module
  as it is deleted.
* **m**  
  .IX Item "m"
  Use this operation to _move_ members in an archive.
  .Sp
  The ordering of members in an archive can make a difference in how
  programs are linked using the library, if a symbol is defined in more
  than one member.
  .Sp
  If no modifiers are used with \f(CW`m\*(C', any members you name in the
  _member_ arguments are moved to the _end_ of the archive;
  you can use the **a**, **b**, or **i** modifiers to move them to a
  specified place instead.
* **p**  
  .IX Item "p"
  _Print_ the specified members of the archive, to the standard
  output file.  If the **v** modifier is specified, show the member
  name before copying its contents to standard output.
  .Sp
  If you specify no _member_ arguments, all the files in the archive are
  printed.
* **q**  
  .IX Item "q"
  _Quick append_; Historically, add the files _member_... to the end of
  _archive_, without checking for replacement.
  .Sp
  The modifiers **a**, **b**, and **i** do _not_ affect this
  operation; new members are always placed at the end of the archive.
  .Sp
  The modifier **v** makes **ar** list each file as it is appended.
  .Sp
  Since the point of this operation is speed, implementations of
  **ar** have the option of not updating the archive's symbol
  table if one exists.  Too many different systems however assume that
  symbol tables are always up-to-date, so \s-1GNU\s0 **ar** will
  rebuild the table even with a quick append.
  .Sp
  Note - \s-1GNU\s0 **ar** treats the command **qs** as a
  synonym for **r** - replacing already existing files in the
  archive and appending new ones at the end.
* **r**  
  .IX Item "r"
  Insert the files _member_... into _archive_ (with
  _replacement_). This operation differs from **q** in that any
  previously existing members are deleted if their names match those being
  added.
  .Sp
  If one of the files named in _member_... does not exist, **ar**
  displays an error message, and leaves undisturbed any existing members
  of the archive matching that name.
  .Sp
  By default, new members are added at the end of the file; but you may
  use one of the modifiers **a**, **b**, or **i** to request
  placement relative to some existing member.
  .Sp
  The modifier **v** used with this operation elicits a line of
  output for each file inserted, along with one of the letters **a** or
  **r** to indicate whether the file was appended (no old member
  deleted) or replaced.
* **s**  
  .IX Item "s"
  Add an index to the archive, or update it if it already exists.  Note
  this command is an exception to the rule that there can only be one
  command letter, as it is possible to use it as either a command or a
  modifier.  In either case it does the same thing.
* **t**  
  .IX Item "t"
  Display a _table_ listing the contents of _archive_, or those
  of the files listed in _member_... that are present in the
  archive.  Normally only the member name is shown, but if the modifier
  **O** is specified, then the corresponding offset of the member is also
  displayed.  Finally, in order to see the modes (permissions), timestamp,
  owner, group, and size the **v** modifier should be included.
  .Sp
  If you do not specify a _member_, all files in the archive
  are listed.
  .Sp
  If there is more than one file with the same name (say, **fie**) in
  an archive (say **b.a**), **ar t b.a fie** lists only the
  first instance; to see them all, you must ask for a complete
  listing---in our example, **ar t b.a**.
* **x**  
  .IX Item "x"
  _Extract_ members (named _member_) from the archive.  You can
  use the **v** modifier with this operation, to request that
  **ar** list each name as it extracts it.
  .Sp
  If you do not specify a _member_, all files in the archive
  are extracted.
  .Sp
  Files cannot be extracted from a thin archive.

A number of modifiers (_mod_) may immediately follow the _p_
keyletter, to specify variations on an operation's behavior:

* **a**  
  .IX Item "a"
  Add new files _after_ an existing member of the
  archive.  If you use the modifier **a**, the name of an existing archive
  member must be present as the _relpos_ argument, before the
  _archive_ specification.
* **b**  
  .IX Item "b"
  Add new files _before_ an existing member of the
  archive.  If you use the modifier **b**, the name of an existing archive
  member must be present as the _relpos_ argument, before the
  _archive_ specification.  (same as **i**).
* **c**  
  .IX Item "c"
  _Create_ the archive.  The specified _archive_ is always
  created if it did not exist, when you request an update.  But a warning is
  issued unless you specify in advance that you expect to create it, by
  using this modifier.
* **D**  
  .IX Item "D"
  Operate in _deterministic_ mode.  When adding files and the archive
  index use zero for UIDs, GIDs, timestamps, and use consistent file modes
  for all files.  When this option is used, if **ar** is used with
  identical options and identical input files, multiple runs will create
  identical output files regardless of the input files' owners, groups,
  file modes, or modification times.
  .Sp
  If _binutils_ was configured with
  **--enable-deterministic-archives**, then this mode is on by default.
  It can be disabled with the **U** modifier, below.
* **f**  
  .IX Item "f"
  Truncate names in the archive.  \s-1GNU\s0 **ar** will normally permit file
  names of any length.  This will cause it to create archives which are
  not compatible with the native **ar** program on some systems.  If
  this is a concern, the **f** modifier may be used to truncate file
  names when putting them in the archive.
* **i**  
  .IX Item "i"
  Insert new files _before_ an existing member of the
  archive.  If you use the modifier **i**, the name of an existing archive
  member must be present as the _relpos_ argument, before the
  _archive_ specification.  (same as **b**).
* **l**  
  .IX Item "l"
  This modifier is accepted but not used.
* **N**  
  .IX Item "N"
  Uses the _count_ parameter.  This is used if there are multiple
  entries in the archive with the same name.  Extract or delete instance
  _count_ of the given name from the archive.
* **o**  
  .IX Item "o"
  Preserve the _original_ dates of members when extracting them.  If
  you do not specify this modifier, files extracted from the archive
  are stamped with the time of extraction.
* **O**  
  .IX Item "O"
  Display member offsets inside the archive. Use together with the **t**
  option.
* **P**  
  .IX Item "P"
  Use the full path name when matching names in the archive.  \s-1GNU\s0
  **ar** can not create an archive with a full path name (such archives
  are not \s-1POSIX\s0 complaint), but other archive creators can.  This option
  will cause \s-1GNU\s0 **ar** to match file names using a complete path
  name, which can be convenient when extracting a single file from an
  archive created by another tool.
* **s**  
  .IX Item "s"
  Write an object-file index into the archive, or update an existing one,
  even if no other change is made to the archive.  You may use this modifier
  flag either with any operation, or alone.  Running **ar s** on an
  archive is equivalent to running **ranlib** on it.
* **S**  
  .IX Item "S"
  Do not generate an archive symbol table.  This can speed up building a
  large library in several steps.  The resulting archive can not be used
  with the linker.  In order to build a symbol table, you must omit the
  **S** modifier on the last execution of **ar**, or you must run
  **ranlib** on the archive.
* **T**  
  .IX Item "T"
  Make the specified _archive_ a _thin_ archive.  If it already
  exists and is a regular archive, the existing members must be present
  in the same directory as _archive_.
* **u**  
  .IX Item "u"
  Normally, **ar r**... inserts all files
  listed into the archive.  If you would like to insert _only_ those
  of the files you list that are newer than existing members of the same
  names, use this modifier.  The **u** modifier is allowed only for the
  operation **r** (replace).  In particular, the combination **qu** is
  not allowed, since checking the timestamps would lose any speed
  advantage from the operation **q**.
* **U**  
  .IX Item "U"
  Do _not_ operate in _deterministic_ mode.  This is the inverse
  of the **D** modifier, above: added files and the archive index will
  get their actual \s-1UID, GID,\s0 timestamp, and file mode values.
  .Sp
  This is the default unless _binutils_ was configured with
  **--enable-deterministic-archives**.
* **v**  
  .IX Item "v"
  This modifier requests the _verbose_ version of an operation.  Many
  operations display additional information, such as filenames processed,
  when the modifier **v** is appended.
* **V**  
  .IX Item "V"
  This modifier shows the version number of **ar**.

The **ar** program also supports some command line options which
are neither modifiers nor actions, but which do change its behaviour
in specific ways:

* **--help**  
  .IX Item "--help"
  Displays the list of command line options supported by **ar**
  and then exits.
* **--version**  
  .IX Item "--version"
  Displays the version information of **ar** and then exits.
* **-X32\_64**  
  .IX Item "-X32_64"
  **ar** ignores an initial option spelt **-X32\_64**, for
  compatibility with \s-1AIX.\s0  The behaviour produced by this option is the
  default for \s-1GNU\s0 **ar**.  **ar** does not support any
  of the other **-X** options; in particular, it does not support
  **-X32** which is the default for \s-1AIX\s0 **ar**.
* **--plugin** _name_  
  .IX Item "--plugin name"
  The optional command line switch **--plugin** _name_ causes 
  **ar** to load the plugin called _name_ which adds support
  for more file formats, including object files with link-time
  optimization information.
  .Sp
  This option is only available if the toolchain has been built with
  plugin support enabled.
  .Sp
  If **--plugin** is not provided, but plugin support has been
  enabled then **ar** iterates over the files in
  _${libdir}/bfd-plugins_ in alphabetic order and the first
  plugin that claims the object in question is used.
  .Sp
  Please note that this plugin search directory is _not_ the one
  used by **ld**'s **-plugin** option.  In order to make
  **ar** use the  linker plugin it must be copied into the
  _${libdir}/bfd-plugins_ directory.  For \s-1GCC\s0 based compilations
  the linker plugin is called _liblto\_plugin.so.0.0.0_.  For Clang
  based compilations it is called _LLVMgold.so_.  The \s-1GCC\s0 plugin
  is always backwards compatible with earlier versions, so it is
  sufficient to just copy the newest one.
* **--target** _target_  
  .IX Item "--target target"
  The optional command line switch **--target** _bfdname_
  specifies that the archive members are in an object code format
  different from your system's default format.  See
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

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
_nm_\|(1), _ranlib_\|(1), and the Info entries for _binutils_.

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
