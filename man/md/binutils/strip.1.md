# strip(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

strip - Discard symbols from object files.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" strip [-F bfdname |--target=bfdname]       [-I bfdname |--input-target=bfdname]       [-O bfdname |--output-target=bfdname]       [-s|--strip-all]       [-S|-g|-d|--strip-debug]       [--strip-dwo]       [-K symbolname|--keep-symbol=symbolname]       [-M|--merge-notes][--no-merge-notes]       [-N symbolname |--strip-symbol=symbolname]       [-w|--wildcard]       [-x|--discard-all] [-X |--discard-locals]       [-R sectionname |--remove-section=sectionname]       [--remove-relocations=sectionpattern]       [-o file] [-p|--preserve-dates]       [-D|--enable-deterministic-archives]       [-U|--disable-deterministic-archives]       [--keep-file-symbols]       [--only-keep-debug]       [-v |--verbose] [-V|--version]       [--help] [--info]       objfile...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\s-1GNU\s0 **strip** discards all symbols from object files
_objfile_.  The list of object files may include archives.
At least one object file must be given.

**strip** modifies the files named in its argument,
rather than writing modified copies under different names.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-F** _bfdname_  
  .IX Item "-F bfdname"
* **--target=**_bfdname_  
  .IX Item "--target=bfdname"
  Treat the original _objfile_ as a file with the object
  code format _bfdname_, and rewrite it in the same format.
* **--help**  
  .IX Item "--help"
  Show a summary of the options to **strip** and exit.
* **--info**  
  .IX Item "--info"
  Display a list showing all architectures and object formats available.
* **-I** _bfdname_  
  .IX Item "-I bfdname"
* **--input-target=**_bfdname_  
  .IX Item "--input-target=bfdname"
  Treat the original _objfile_ as a file with the object
  code format _bfdname_.
* **-O** _bfdname_  
  .IX Item "-O bfdname"
* **--output-target=**_bfdname_  
  .IX Item "--output-target=bfdname"
  Replace _objfile_ with a file in the output format _bfdname_.
* **-R** _sectionname_  
  .IX Item "-R sectionname"
* **--remove-section=**_sectionname_  
  .IX Item "--remove-section=sectionname"
  Remove any section named _sectionname_ from the output file, in
  addition to whatever sections would otherwise be removed.  This
  option may be given more than once.  Note that using this option
  inappropriately may make the output file unusable.  The wildcard
  character *** may be given at the end of sectionname**.  If
  so, then any section starting with _sectionname_ will be removed.
  .Sp
  If the first character of _sectionpattern_ is the exclamation
  point (!) then matching sections will not be removed even if an
  earlier use of **--remove-section** on the same command line
  would otherwise remove it.  For example:
  .Sp
  .Vb 1
            --remove-section=.text.* --remove-section=!.text.foo
  .Ve
  .Sp
  will remove all sections matching the pattern '.text.*', but will not
  remove the section '.text.foo'.
* **--remove-relocations=**_sectionpattern_  
  .IX Item "--remove-relocations=sectionpattern"
  Remove relocations from the output file for any section matching
  _sectionpattern_.  This option may be given more than once.  Note
  that using this option inappropriately may make the output file
  unusable.  Wildcard characters are accepted in _sectionpattern_.
  For example:
  .Sp
  .Vb 1
            --remove-relocations=.text.*
  .Ve
  .Sp
  will remove the relocations for all sections matching the patter
  '.text.*'.
  .Sp
  If the first character of _sectionpattern_ is the exclamation
  point (!) then matching sections will not have their relocation
  removed even if an earlier use of **--remove-relocations** on the
  same command line would otherwise cause the relocations to be removed.
  For example:
  .Sp
  .Vb 1
            --remove-relocations=.text.* --remove-relocations=!.text.foo
  .Ve
  .Sp
  will remove all relocations for sections matching the pattern
  '.text.*', but will not remove relocations for the section
  '.text.foo'.
* **-s**  
  .IX Item "-s"
* **--strip-all**  
  .IX Item "--strip-all"
  Remove all symbols.
* **-g**  
  .IX Item "-g"
* **-S**  
  .IX Item "-S"
* **-d**  
  .IX Item "-d"
* **--strip-debug**  
  .IX Item "--strip-debug"
  Remove debugging symbols only.
* **--strip-dwo**  
  .IX Item "--strip-dwo"
  Remove the contents of all \s-1DWARF\s0 .dwo sections, leaving the
  remaining debugging sections and all symbols intact.
  See the description of this option in the **objcopy** section
  for more information.
* **--strip-unneeded**  
  .IX Item "--strip-unneeded"
  Remove all symbols that are not needed for relocation processing.
* **-K** _symbolname_  
  .IX Item "-K symbolname"
* **--keep-symbol=**_symbolname_  
  .IX Item "--keep-symbol=symbolname"
  When stripping symbols, keep symbol _symbolname_ even if it would
  normally be stripped.  This option may be given more than once.
* **-M**  
  .IX Item "-M"
* **--merge-notes**  
  .IX Item "--merge-notes"
* **--no-merge-notes**  
  .IX Item "--no-merge-notes"
  For \s-1ELF\s0 files, attempt (or do not attempt) to reduce the size of any
  \s-1SHT_NOTE\s0 type sections by removing duplicate notes.  The default is to
  attempt this reduction.
* **-N** _symbolname_  
  .IX Item "-N symbolname"
* **--strip-symbol=**_symbolname_  
  .IX Item "--strip-symbol=symbolname"
  Remove symbol _symbolname_ from the source file. This option may be
  given more than once, and may be combined with strip options other than
  **-K**.
* **-o** _file_  
  .IX Item "-o file"
  Put the stripped output in _file_, rather than replacing the
  existing file.  When this argument is used, only one _objfile_
  argument may be specified.
* **-p**  
  .IX Item "-p"
* **--preserve-dates**  
  .IX Item "--preserve-dates"
  Preserve the access and modification dates of the file.
* **-D**  
  .IX Item "-D"
* **--enable-deterministic-archives**  
  .IX Item "--enable-deterministic-archives"
  Operate in _deterministic_ mode.  When copying archive members
  and writing the archive index, use zero for UIDs, GIDs, timestamps,
  and use consistent file modes for all files.
  .Sp
  If _binutils_ was configured with
  **--enable-deterministic-archives**, then this mode is on by default.
  It can be disabled with the **-U** option, below.
* **-U**  
  .IX Item "-U"
* **--disable-deterministic-archives**  
  .IX Item "--disable-deterministic-archives"
  Do _not_ operate in _deterministic_ mode.  This is the
  inverse of the **-D** option, above: when copying archive members
  and writing the archive index, use their actual \s-1UID, GID,\s0 timestamp,
  and file mode values.
  .Sp
  This is the default unless _binutils_ was configured with
  **--enable-deterministic-archives**.
* **-w**  
  .IX Item "-w"
* **--wildcard**  
  .IX Item "--wildcard"
  Permit regular expressions in _symbolname_s used in other command
  line options.  The question mark (?), asterisk (*), backslash (\e) and
  square brackets ([]) operators can be used anywhere in the symbol
  name.  If the first character of the symbol name is the exclamation
  point (!) then the sense of the switch is reversed for that symbol.
  For example:
  .Sp
  .Vb 1
            -w -K !foo -K fo*
  .Ve
  .Sp
  would cause strip to only keep symbols that start with the letters
  fo\*(R", but to discard the symbol \*(L"foo\*(R".
* **-x**  
  .IX Item "-x"
* **--discard-all**  
  .IX Item "--discard-all"
  Remove non-global symbols.
* **-X**  
  .IX Item "-X"
* **--discard-locals**  
  .IX Item "--discard-locals"
  Remove compiler-generated local symbols.
  (These usually start with **L** or **.**.)
* **--keep-file-symbols**  
  .IX Item "--keep-file-symbols"
  When stripping a file, perhaps with **--strip-debug** or
  **--strip-unneeded**, retain any symbols specifying source file names,
  which would otherwise get stripped.
* **--only-keep-debug**  
  .IX Item "--only-keep-debug"
  Strip a file, emptying the contents of any sections that would not be
  stripped by **--strip-debug** and leaving the debugging sections
  intact.  In \s-1ELF\s0 files, this preserves all the note sections in the
  output as well.
  .Sp
  Note - the section headers of the stripped sections are preserved,
  including their sizes, but the contents of the section are discarded.
  The section headers are preserved so that other tools can match up the
  debuginfo file with the real executable, even if that executable has
  been relocated to a different address space.
  .Sp
  The intention is that this option will be used in conjunction with
  **--add-gnu-debuglink** to create a two part executable.  One a
  stripped binary which will occupy less space in \s-1RAM\s0 and in a
  distribution and the second a debugging information file which is only
  needed if debugging abilities are required.  The suggested procedure
  to create these files is as follows:
    * 1.&lt;Link the executable as normal.  Assuming that it is called&gt;  
      .IX Item "1.&lt;Link the executable as normal. Assuming that it is called&gt;"
      \f(CW`foo\*(C' then...
      .ie n .IP "1.&lt;Run ""objcopy --only-keep-debug foo foo.dbg"" to&gt;" 4
      .el .IP "1.&lt;Run \f(CWobjcopy --only-keep-debug foo foo.dbg to&gt;" 4
      .IX Item "1.&lt;Run objcopy --only-keep-debug foo foo.dbg to&gt;"
      create a file containing the debugging info.
      .ie n .IP "1.&lt;Run ""objcopy --strip-debug foo"" to create a&gt;" 4
      .el .IP "1.&lt;Run \f(CWobjcopy --strip-debug foo to create a&gt;" 4
      .IX Item "1.&lt;Run objcopy --strip-debug foo to create a&gt;"
      stripped executable.
      .ie n .IP "1.&lt;Run ""objcopy --add-gnu-debuglink=foo.dbg foo""&gt;" 4
      .el .IP "1.&lt;Run \f(CWobjcopy --add-gnu-debuglink=foo.dbg foo&gt;" 4
      .IX Item "1.&lt;Run objcopy --add-gnu-debuglink=foo.dbg foo&gt;"
      to add a link to the debugging info into the stripped executable.
      .Sp
      Note---the choice of \f(CW`.dbg\*(C' as an extension for the debug info
      file is arbitrary.  Also the \f(CW`--only-keep-debug\*(C' step is
      optional.  You could instead do this:
    * 1.&lt;Link the executable as normal.&gt;  
      .IX Item "1.&lt;Link the executable as normal.&gt;"
      .ie n .IP "1.&lt;Copy ""foo"" to ""foo.full""&gt;" 4
      .el .IP "1.&lt;Copy \f(CWfoo to \f(CWfoo.full&gt;" 4
      .IX Item "1.&lt;Copy foo to foo.full&gt;"
      .ie n .IP "1.&lt;Run ""strip --strip-debug foo""&gt;" 4
      .el .IP "1.&lt;Run \f(CWstrip --strip-debug foo&gt;" 4
      .IX Item "1.&lt;Run strip --strip-debug foo&gt;"
      .ie n .IP "1.&lt;Run ""objcopy --add-gnu-debuglink=foo.full foo""&gt;" 4
      .el .IP "1.&lt;Run \f(CWobjcopy --add-gnu-debuglink=foo.full foo&gt;" 4
      .IX Item "1.&lt;Run objcopy --add-gnu-debuglink=foo.full foo&gt;"
      .Sp
      i.e., the file pointed to by the **--add-gnu-debuglink** can be the
      full executable.  It does not have to be a file created by the
      **--only-keep-debug** switch.
      .Sp
      Note---this switch is only intended for use on fully linked files.  It
      does not make sense to use it on object files where the debugging
      information may be incomplete.  Besides the gnu_debuglink feature
      currently only supports the presence of one filename containing
      debugging information, not multiple filenames on a one-per-object-file
      basis.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Show the version number for **strip**.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Verbose output: list all object files modified.  In the case of
  archives, **strip -v** lists all members of the archive.
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
the Info entries for _binutils_.

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
