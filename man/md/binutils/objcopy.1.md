# objcopy(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

objcopy - copy and translate object files

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" objcopy [-F bfdname|--target=bfdname]         [-I bfdname|--input-target=bfdname]         [-O bfdname|--output-target=bfdname]         [-B bfdarch|--binary-architecture=bfdarch]         [-S|--strip-all]         [-g|--strip-debug]         [--strip-unneeded]         [-K symbolname|--keep-symbol=symbolname]         [-N symbolname|--strip-symbol=symbolname]         [--strip-unneeded-symbol=symbolname]         [-G symbolname|--keep-global-symbol=symbolname]         [--localize-hidden]         [-L symbolname|--localize-symbol=symbolname]         [--globalize-symbol=symbolname]         [-W symbolname|--weaken-symbol=symbolname]         [-w|--wildcard]         [-x|--discard-all]         [-X|--discard-locals]         [-b byte|--byte=byte]         [-i [breadth]|--interleave[=breadth]]         [--interleave-width=width]         [-j sectionpattern|--only-section=sectionpattern]         [-R sectionpattern|--remove-section=sectionpattern]         [--remove-relocations=sectionpattern]         [-p|--preserve-dates]         [-D|--enable-deterministic-archives]         [-U|--disable-deterministic-archives]         [--debugging]         [--gap-fill=val]         [--pad-to=address]         [--set-start=val]         [--adjust-start=incr]         [--change-addresses=incr]         [--change-section-address sectionpattern{=,+,-}val]         [--change-section-lma sectionpattern{=,+,-}val]         [--change-section-vma sectionpattern{=,+,-}val]         [--change-warnings] [--no-change-warnings]         [--set-section-flags sectionpattern=flags]         [--add-section sectionname=filename]         [--dump-section sectionname=filename]         [--update-section sectionname=filename]         [--rename-section oldname=newname[,flags]]         [--long-section-names {enable,disable,keep}]         [--change-leading-char] [--remove-leading-char]         [--reverse-bytes=num]         [--srec-len=ival] [--srec-forceS3]         [--redefine-sym old=new]         [--redefine-syms=filename]         [--weaken]         [--keep-symbols=filename]         [--strip-symbols=filename]         [--strip-unneeded-symbols=filename]         [--keep-global-symbols=filename]         [--localize-symbols=filename]         [--globalize-symbols=filename]         [--weaken-symbols=filename]         [--add-symbol name=[section:]value[,flags]]         [--alt-machine-code=index]         [--prefix-symbols=string]         [--prefix-sections=string]         [--prefix-alloc-sections=string]         [--add-gnu-debuglink=path-to-file]         [--keep-file-symbols]         [--only-keep-debug]         [--strip-dwo]         [--extract-dwo]         [--extract-symbol]         [--writable-text]         [--readonly-text]         [--pure]         [--impure]         [--file-alignment=num]         [--heap=size]         [--image-base=address]         [--section-alignment=num]         [--stack=size]         [--subsystem=which:major.minor]         [--compress-debug-sections]         [--decompress-debug-sections]         [--elf-stt-common=val]         [--merge-notes]         [--no-merge-notes]         [-v|--verbose]         [-V|--version]         [--help] [--info]         infile [outfile]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The \s-1GNU\s0 **objcopy** utility copies the contents of an object
file to another.  **objcopy** uses the \s-1GNU BFD\s0 Library to
read and write the object files.  It can write the destination object
file in a format different from that of the source object file.  The
exact behavior of **objcopy** is controlled by command-line options.
Note that **objcopy** should be able to copy a fully linked file
between any two formats. However, copying a relocatable object file
between any two formats may not work as expected.

**objcopy** creates temporary files to do its translations and
deletes them afterward.  **objcopy** uses \s-1BFD\s0 to do all its
translation work; it has access to all the formats described in \s-1BFD\s0
and thus is able to recognize most formats without being told
explicitly.

**objcopy** can be used to generate S-records by using an output
target of **srec** (e.g., use **-O srec**).

**objcopy** can be used to generate a raw binary file by using an
output target of **binary** (e.g., use **-O binary**).  When
**objcopy** generates a raw binary file, it will essentially produce
a memory dump of the contents of the input object file.  All symbols and
relocation information will be discarded.  The memory dump will start at
the load address of the lowest section copied into the output file.

When generating an S-record or a raw binary file, it may be helpful to
use **-S** to remove sections containing debugging information.  In
some cases **-R** will be useful to remove sections which contain
information that is not needed by the binary file.

Note---**objcopy** is not able to change the endianness of its input
files.  If the input format has an endianness (some formats do not),
**objcopy** can only copy the inputs into file formats that have the
same endianness or which have no endianness (e.g., **srec**).
(However, see the **--reverse-bytes** option.)

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* _infile_  
  .IX Item "infile"
* _outfile_  
  .IX Item "outfile"
  The input and output files, respectively.
  If you do not specify _outfile_, **objcopy** creates a
  temporary file and destructively renames the result with
  the name of _infile_.
* **-I** _bfdname_  
  .IX Item "-I bfdname"
* **--input-target=**_bfdname_  
  .IX Item "--input-target=bfdname"
  Consider the source file's object format to be _bfdname_, rather than
  attempting to deduce it.
* **-O** _bfdname_  
  .IX Item "-O bfdname"
* **--output-target=**_bfdname_  
  .IX Item "--output-target=bfdname"
  Write the output file using the object format _bfdname_.
* **-F** _bfdname_  
  .IX Item "-F bfdname"
* **--target=**_bfdname_  
  .IX Item "--target=bfdname"
  Use _bfdname_ as the object format for both the input and the output
  file; i.e., simply transfer data from source to destination with no
  translation.
* **-B** _bfdarch_  
  .IX Item "-B bfdarch"
* **--binary-architecture=**_bfdarch_  
  .IX Item "--binary-architecture=bfdarch"
  Useful when transforming a architecture-less input file into an object file.
  In this case the output architecture can be set to _bfdarch_.  This
  option will be ignored if the input file has a known _bfdarch_.  You
  can access this binary data inside a program by referencing the special
  symbols that are created by the conversion process.  These symbols are
  called \_binary\__objfile__start, \_binary\__objfile__end and
  \_binary\__objfile__size.  e.g. you can transform a picture file into
  an object file and then access it in your code using these symbols.
* **-j** _sectionpattern_  
  .IX Item "-j sectionpattern"
* **--only-section=**_sectionpattern_  
  .IX Item "--only-section=sectionpattern"
  Copy only the indicated sections from the input file to the output file.
  This option may be given more than once.  Note that using this option
  inappropriately may make the output file unusable.  Wildcard
  characters are accepted in _sectionpattern_.
  .Sp
  If the first character of _sectionpattern_ is the exclamation
  point (!) then matching sections will not be copied, even if earlier
  use of **--only-section** on the same command line would
  otherwise copy it.  For example:
  .Sp
  .Vb 1
            --only-section=.text.* --only-section=!.text.foo
  .Ve
  .Sp
  will copy all sectinos maching '.text.*' but not the section
  '.text.foo'.
* **-R** _sectionpattern_  
  .IX Item "-R sectionpattern"
* **--remove-section=**_sectionpattern_  
  .IX Item "--remove-section=sectionpattern"
  Remove any section matching _sectionpattern_ from the output file.
  This option may be given more than once.  Note that using this option
  inappropriately may make the output file unusable.  Wildcard
  characters are accepted in _sectionpattern_.  Using both the
  **-j** and **-R** options together results in undefined
  behaviour.
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
* **-S**  
  .IX Item "-S"
* **--strip-all**  
  .IX Item "--strip-all"
  Do not copy relocation and symbol information from the source file.
* **-g**  
  .IX Item "-g"
* **--strip-debug**  
  .IX Item "--strip-debug"
  Do not copy debugging symbols or sections from the source file.
* **--strip-unneeded**  
  .IX Item "--strip-unneeded"
  Strip all symbols that are not needed for relocation processing.
* **-K** _symbolname_  
  .IX Item "-K symbolname"
* **--keep-symbol=**_symbolname_  
  .IX Item "--keep-symbol=symbolname"
  When stripping symbols, keep symbol _symbolname_ even if it would
  normally be stripped.  This option may be given more than once.
* **-N** _symbolname_  
  .IX Item "-N symbolname"
* **--strip-symbol=**_symbolname_  
  .IX Item "--strip-symbol=symbolname"
  Do not copy symbol _symbolname_ from the source file.  This option
  may be given more than once.
* **--strip-unneeded-symbol=**_symbolname_  
  .IX Item "--strip-unneeded-symbol=symbolname"
  Do not copy symbol _symbolname_ from the source file unless it is needed
  by a relocation.  This option may be given more than once.
* **-G** _symbolname_  
  .IX Item "-G symbolname"
* **--keep-global-symbol=**_symbolname_  
  .IX Item "--keep-global-symbol=symbolname"
  Keep only symbol _symbolname_ global.  Make all other symbols local
  to the file, so that they are not visible externally.  This option may
  be given more than once.
* **--localize-hidden**  
  .IX Item "--localize-hidden"
  In an \s-1ELF\s0 object, mark all symbols that have hidden or internal visibility
  as local.  This option applies on top of symbol-specific localization options
  such as **-L**.
* **-L** _symbolname_  
  .IX Item "-L symbolname"
* **--localize-symbol=**_symbolname_  
  .IX Item "--localize-symbol=symbolname"
  Convert a global or weak symbol called _symbolname_ into a local
  symbol, so that it is not visible externally.  This option may be
  given more than once.  Note - unique symbols are not converted.
* **-W** _symbolname_  
  .IX Item "-W symbolname"
* **--weaken-symbol=**_symbolname_  
  .IX Item "--weaken-symbol=symbolname"
  Make symbol _symbolname_ weak. This option may be given more than once.
* **--globalize-symbol=**_symbolname_  
  .IX Item "--globalize-symbol=symbolname"
  Give symbol _symbolname_ global scoping so that it is visible
  outside of the file in which it is defined.  This option may be given
  more than once.
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
            -w -W !foo -W fo*
  .Ve
  .Sp
  would cause objcopy to weaken all symbols that start with fo\*(R"
  except for the symbol foo\*(R".
* **-x**  
  .IX Item "-x"
* **--discard-all**  
  .IX Item "--discard-all"
  Do not copy non-global symbols from the source file.
* **-X**  
  .IX Item "-X"
* **--discard-locals**  
  .IX Item "--discard-locals"
  Do not copy compiler-generated local symbols.
  (These usually start with **L** or **.**.)
* **-b** _byte_  
  .IX Item "-b byte"
* **--byte=**_byte_  
  .IX Item "--byte=byte"
  If interleaving has been enabled via the **--interleave** option
  then start the range of bytes to keep at the _byte_th byte.
  _byte_ can be in the range from 0 to _breadth_-1, where
  _breadth_ is the value given by the **--interleave** option.
* **-i [**_breadth_**]**  
  .IX Item "-i [breadth]"
* **--interleave[=**_breadth_**]**  
  .IX Item "--interleave[=breadth]"
  Only copy a range out of every _breadth_ bytes.  (Header data is
  not affected).  Select which byte in the range begins the copy with
  the **--byte** option.  Select the width of the range with the
  **--interleave-width** option.
  .Sp
  This option is useful for creating files to program \s-1ROM.\s0  It is
  typically used with an \f(CW`srec\*(C' output target.  Note that
  **objcopy** will complain if you do not specify the
  **--byte** option as well.
  .Sp
  The default interleave breadth is 4, so with **--byte** set to 0,
  **objcopy** would copy the first byte out of every four bytes
  from the input to the output.
* **--interleave-width=**_width_  
  .IX Item "--interleave-width=width"
  When used with the **--interleave** option, copy _width_
  bytes at a time.  The start of the range of bytes to be copied is set
  by the **--byte** option, and the extent of the range is set with
  the **--interleave** option.
  .Sp
  The default value for this option is 1.  The value of _width_ plus
  the _byte_ value set by the **--byte** option must not exceed
  the interleave breadth set by the **--interleave** option.
  .Sp
  This option can be used to create images for two 16-bit flashes interleaved
  in a 32-bit bus by passing **-b 0 -i 4 --interleave-width=2**
  and **-b 2 -i 4 --interleave-width=2** to two **objcopy**
  commands.  If the input was '12345678' then the outputs would be
  '1256' and '3478' respectively.
* **-p**  
  .IX Item "-p"
* **--preserve-dates**  
  .IX Item "--preserve-dates"
  Set the access and modification dates of the output file to be the same
  as those of the input file.
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
* **--debugging**  
  .IX Item "--debugging"
  Convert debugging information, if possible.  This is not the default
  because only certain debugging formats are supported, and the
  conversion process can be time consuming.
* **--gap-fill** _val_  
  .IX Item "--gap-fill val"
  Fill gaps between sections with _val_.  This operation applies to
  the _load address_ (\s-1LMA\s0) of the sections.  It is done by increasing
  the size of the section with the lower address, and filling in the extra
  space created with _val_.
* **--pad-to** _address_  
  .IX Item "--pad-to address"
  Pad the output file up to the load address _address_.  This is
  done by increasing the size of the last section.  The extra space is
  filled in with the value specified by **--gap-fill** (default zero).
* **--set-start** _val_  
  .IX Item "--set-start val"
  Set the start address of the new file to _val_.  Not all object file
  formats support setting the start address.
* **--change-start** _incr_  
  .IX Item "--change-start incr"
* **--adjust-start** _incr_  
  .IX Item "--adjust-start incr"
  Change the start address by adding _incr_.  Not all object file
  formats support setting the start address.
* **--change-addresses** _incr_  
  .IX Item "--change-addresses incr"
* **--adjust-vma** _incr_  
  .IX Item "--adjust-vma incr"
  Change the \s-1VMA\s0 and \s-1LMA\s0 addresses of all sections, as well as the start
  address, by adding _incr_.  Some object file formats do not permit
  section addresses to be changed arbitrarily.  Note that this does not
  relocate the sections; if the program expects sections to be loaded at a
  certain address, and this option is used to change the sections such
  that they are loaded at a different address, the program may fail.
* **--change-section-address** _sectionpattern_**{=,+,-}**_val_  
  .IX Item "--change-section-address sectionpattern{=,+,-}val"
* **--adjust-section-vma** _sectionpattern_**{=,+,-}**_val_  
  .IX Item "--adjust-section-vma sectionpattern{=,+,-}val"
  Set or change both the \s-1VMA\s0 address and the \s-1LMA\s0 address of any section
  matching _sectionpattern_.  If **=** is used, the section
  address is set to _val_.  Otherwise, _val_ is added to or
  subtracted from the section address.  See the comments under
  **--change-addresses**, above. If _sectionpattern_ does not
  match any sections in the input file, a warning will be issued, unless
  **--no-change-warnings** is used.
* **--change-section-lma** _sectionpattern_**{=,+,-}**_val_  
  .IX Item "--change-section-lma sectionpattern{=,+,-}val"
  Set or change the \s-1LMA\s0 address of any sections matching
  _sectionpattern_.  The \s-1LMA\s0 address is the address where the
  section will be loaded into memory at program load time.  Normally
  this is the same as the \s-1VMA\s0 address, which is the address of the
  section at program run time, but on some systems, especially those
  where a program is held in \s-1ROM,\s0 the two can be different.  If **=**
  is used, the section address is set to _val_.  Otherwise,
  _val_ is added to or subtracted from the section address.  See the
  comments under **--change-addresses**, above.  If
  _sectionpattern_ does not match any sections in the input file, a
  warning will be issued, unless **--no-change-warnings** is used.
* **--change-section-vma** _sectionpattern_**{=,+,-}**_val_  
  .IX Item "--change-section-vma sectionpattern{=,+,-}val"
  Set or change the \s-1VMA\s0 address of any section matching
  _sectionpattern_.  The \s-1VMA\s0 address is the address where the
  section will be located once the program has started executing.
  Normally this is the same as the \s-1LMA\s0 address, which is the address
  where the section will be loaded into memory, but on some systems,
  especially those where a program is held in \s-1ROM,\s0 the two can be
  different.  If **=** is used, the section address is set to
  _val_.  Otherwise, _val_ is added to or subtracted from the
  section address.  See the comments under **--change-addresses**,
  above.  If _sectionpattern_ does not match any sections in the
  input file, a warning will be issued, unless
  **--no-change-warnings** is used.
* **--change-warnings**  
  .IX Item "--change-warnings"
* **--adjust-warnings**  
  .IX Item "--adjust-warnings"
  If **--change-section-address** or **--change-section-lma** or
  **--change-section-vma** is used, and the section pattern does not
  match any sections, issue a warning.  This is the default.
* **--no-change-warnings**  
  .IX Item "--no-change-warnings"
* **--no-adjust-warnings**  
  .IX Item "--no-adjust-warnings"
  Do not issue a warning if **--change-section-address** or
  **--adjust-section-lma** or **--adjust-section-vma** is used, even
  if the section pattern does not match any sections.
* **--set-section-flags** _sectionpattern_**=**_flags_  
  .IX Item "--set-section-flags sectionpattern=flags"
  Set the flags for any sections matching _sectionpattern_.  The
  _flags_ argument is a comma separated string of flag names.  The
  recognized names are **alloc**, **contents**, **load**,
  **noload**, **readonly**, **code**, **data**, **rom**,
  **share**, and **debug**.  You can set the **contents** flag
  for a section which does not have contents, but it is not meaningful
  to clear the **contents** flag of a section which does have
  contentsjust remove the section instead.  Not all flags are
  meaningful for all object file formats.
* **--add-section** _sectionname_**=**_filename_  
  .IX Item "--add-section sectionname=filename"
  Add a new section named _sectionname_ while copying the file.  The
  contents of the new section are taken from the file _filename_.  The
  size of the section will be the size of the file.  This option only
  works on file formats which can support sections with arbitrary names.
  Note - it may be necessary to use the **--set-section-flags**
  option to set the attributes of the newly created section.
* **--dump-section** _sectionname_**=**_filename_  
  .IX Item "--dump-section sectionname=filename"
  Place the contents of section named _sectionname_ into the file
  _filename_, overwriting any contents that may have been there
  previously.  This option is the inverse of **--add-section**.
  This option is similar to the **--only-section** option except
  that it does not create a formatted file, it just dumps the contents
  as raw binary data, without applying any relocations.  The option can
  be specified more than once.
* **--update-section** _sectionname_**=**_filename_  
  .IX Item "--update-section sectionname=filename"
  Replace the existing contents of a section named _sectionname_
  with the contents of file _filename_.  The size of the section
  will be adjusted to the size of the file.  The section flags for
  _sectionname_ will be unchanged.  For \s-1ELF\s0 format files the section
  to segment mapping will also remain unchanged, something which is not
  possible using **--remove-section** followed by
  **--add-section**.  The option can be specified more than once.
  .Sp
  Note - it is possible to use **--rename-section** and
  **--update-section** to both update and rename a section from one
  command line.  In this case, pass the original section name to
  **--update-section**, and the original and new section names to
  **--rename-section**.
* **--add-symbol** _name_**=[**_section_**:]**_value_**[,**_flags_**]**  
  .IX Item "--add-symbol name=[section:]value[,flags]"
  Add a new symbol named _name_ while copying the file.  This option may be
  specified multiple times.  If the _section_ is given, the symbol will be
  associated with and relative to that section, otherwise it will be an \s-1ABS\s0
  symbol.  Specifying an undefined section will result in a fatal error.  There
  is no check for the value, it will be taken as specified.  Symbol flags can
  be specified and not all flags will be meaningful for all object file
  formats.  By default, the symbol will be global.  The special flag
  'before=_othersym_' will insert the new symbol in front of the specified
  _othersym_, otherwise the symbol(s) will be added at the end of the
  symbol table in the order they appear.
* **--rename-section** _oldname_**=**_newname_**[,**_flags_**]**  
  .IX Item "--rename-section oldname=newname[,flags]"
  Rename a section from _oldname_ to _newname_, optionally
  changing the section's flags to _flags_ in the process.  This has
  the advantage over using a linker script to perform the rename in that
  the output stays as an object file and does not become a linked
  executable.
  .Sp
  This option is particularly helpful when the input format is binary,
  since this will always create a section called .data.  If for example,
  you wanted instead to create a section called .rodata containing binary
  data you could use the following command line to achieve it:
  .Sp
  .Vb 3
            objcopy -I binary -O &lt;output_format&gt; -B &lt;architecture&gt; \e
             --rename-section .data=.rodata,alloc,load,readonly,data,contents \e
             &lt;input_binary_file&gt; &lt;output_object_file&gt;
  .Ve
* **--long-section-names {enable,disable,keep}**  
  .IX Item "--long-section-names {enable,disable,keep}"
  Controls the handling of long section names when processing \f(CW`COFF\*(C'
  and \f(CW`PE-COFF\*(C' object formats.  The default behaviour, **keep**,
  is to preserve long section names if any are present in the input file.
  The **enable** and **disable** options forcibly enable or disable
  the use of long section names in the output object; when **disable**
  is in effect, any long section names in the input object will be truncated.
  The **enable** option will only emit long section names if any are
  present in the inputs; this is mostly the same as **keep**, but it
  is left undefined whether the **enable** option might force the
  creation of an empty string table in the output file.
* **--change-leading-char**  
  .IX Item "--change-leading-char"
  Some object file formats use special characters at the start of
  symbols.  The most common such character is underscore, which compilers
  often add before every symbol.  This option tells **objcopy** to
  change the leading character of every symbol when it converts between
  object file formats.  If the object file formats use the same leading
  character, this option has no effect.  Otherwise, it will add a
  character, or remove a character, or change a character, as
  appropriate.
* **--remove-leading-char**  
  .IX Item "--remove-leading-char"
  If the first character of a global symbol is a special symbol leading
  character used by the object file format, remove the character.  The
  most common symbol leading character is underscore.  This option will
  remove a leading underscore from all global symbols.  This can be useful
  if you want to link together objects of different file formats with
  different conventions for symbol names.  This is different from
  **--change-leading-char** because it always changes the symbol name
  when appropriate, regardless of the object file format of the output
  file.
* **--reverse-bytes=**_num_  
  .IX Item "--reverse-bytes=num"
  Reverse the bytes in a section with output contents.  A section length must
  be evenly divisible by the value given in order for the swap to be able to
  take place. Reversing takes place before the interleaving is performed.
  .Sp
  This option is used typically in generating \s-1ROM\s0 images for problematic
  target systems.  For example, on some target boards, the 32-bit words
  fetched from 8-bit ROMs are re-assembled in little-endian byte order
  regardless of the \s-1CPU\s0 byte order.  Depending on the programming model, the
  endianness of the \s-1ROM\s0 may need to be modified.
  .Sp
  Consider a simple file with a section containing the following eight
  bytes:  \f(CW12345678.
  .Sp
  Using **--reverse-bytes=2** for the above example, the bytes in the
  output file would be ordered \f(CW21436587.
  .Sp
  Using **--reverse-bytes=4** for the above example, the bytes in the
  output file would be ordered \f(CW43218765.
  .Sp
  By using **--reverse-bytes=2** for the above example, followed by
  **--reverse-bytes=4** on the output file, the bytes in the second
  output file would be ordered \f(CW34127856.
* **--srec-len=**_ival_  
  .IX Item "--srec-len=ival"
  Meaningful only for srec output.  Set the maximum length of the Srecords
  being produced to _ival_.  This length covers both address, data and
  crc fields.
* **--srec-forceS3**  
  .IX Item "--srec-forceS3"
  Meaningful only for srec output.  Avoid generation of S1/S2 records,
  creating S3-only record format.
* **--redefine-sym** _old_**=**_new_  
  .IX Item "--redefine-sym old=new"
  Change the name of a symbol _old_, to _new_.  This can be useful
  when one is trying link two things together for which you have no
  source, and there are name collisions.
* **--redefine-syms=**_filename_  
  .IX Item "--redefine-syms=filename"
  Apply **--redefine-sym** to each symbol pair "_old_ _new_"
  listed in the file _filename_.  _filename_ is simply a flat file,
  with one symbol pair per line.  Line comments may be introduced by the hash
  character.  This option may be given more than once.
* **--weaken**  
  .IX Item "--weaken"
  Change all global symbols in the file to be weak.  This can be useful
  when building an object which will be linked against other objects using
  the **-R** option to the linker.  This option is only effective when
  using an object file format which supports weak symbols.
* **--keep-symbols=**_filename_  
  .IX Item "--keep-symbols=filename"
  Apply **--keep-symbol** option to each symbol listed in the file
  _filename_.  _filename_ is simply a flat file, with one symbol
  name per line.  Line comments may be introduced by the hash character.
  This option may be given more than once.
* **--strip-symbols=**_filename_  
  .IX Item "--strip-symbols=filename"
  Apply **--strip-symbol** option to each symbol listed in the file
  _filename_.  _filename_ is simply a flat file, with one symbol
  name per line.  Line comments may be introduced by the hash character.
  This option may be given more than once.
* **--strip-unneeded-symbols=**_filename_  
  .IX Item "--strip-unneeded-symbols=filename"
  Apply **--strip-unneeded-symbol** option to each symbol listed in
  the file _filename_.  _filename_ is simply a flat file, with one
  symbol name per line.  Line comments may be introduced by the hash
  character.  This option may be given more than once.
* **--keep-global-symbols=**_filename_  
  .IX Item "--keep-global-symbols=filename"
  Apply **--keep-global-symbol** option to each symbol listed in the
  file _filename_.  _filename_ is simply a flat file, with one
  symbol name per line.  Line comments may be introduced by the hash
  character.  This option may be given more than once.
* **--localize-symbols=**_filename_  
  .IX Item "--localize-symbols=filename"
  Apply **--localize-symbol** option to each symbol listed in the file
  _filename_.  _filename_ is simply a flat file, with one symbol
  name per line.  Line comments may be introduced by the hash character.
  This option may be given more than once.
* **--globalize-symbols=**_filename_  
  .IX Item "--globalize-symbols=filename"
  Apply **--globalize-symbol** option to each symbol listed in the file
  _filename_.  _filename_ is simply a flat file, with one symbol
  name per line.  Line comments may be introduced by the hash character.
  This option may be given more than once.
* **--weaken-symbols=**_filename_  
  .IX Item "--weaken-symbols=filename"
  Apply **--weaken-symbol** option to each symbol listed in the file
  _filename_.  _filename_ is simply a flat file, with one symbol
  name per line.  Line comments may be introduced by the hash character.
  This option may be given more than once.
* **--alt-machine-code=**_index_  
  .IX Item "--alt-machine-code=index"
  If the output architecture has alternate machine codes, use the
  _index_th code instead of the default one.  This is useful in case
  a machine is assigned an official code and the tool-chain adopts the
  new code, but other applications still depend on the original code
  being used.  For \s-1ELF\s0 based architectures if the _index_
  alternative does not exist then the value is treated as an absolute
  number to be stored in the e_machine field of the \s-1ELF\s0 header.
* **--writable-text**  
  .IX Item "--writable-text"
  Mark the output text as writable.  This option isn't meaningful for all
  object file formats.
* **--readonly-text**  
  .IX Item "--readonly-text"
  Make the output text write protected.  This option isn't meaningful for all
  object file formats.
* **--pure**  
  .IX Item "--pure"
  Mark the output file as demand paged.  This option isn't meaningful for all
  object file formats.
* **--impure**  
  .IX Item "--impure"
  Mark the output file as impure.  This option isn't meaningful for all
  object file formats.
* **--prefix-symbols=**_string_  
  .IX Item "--prefix-symbols=string"
  Prefix all symbols in the output file with _string_.
* **--prefix-sections=**_string_  
  .IX Item "--prefix-sections=string"
  Prefix all section names in the output file with _string_.
* **--prefix-alloc-sections=**_string_  
  .IX Item "--prefix-alloc-sections=string"
  Prefix all the names of all allocated sections in the output file with
  _string_.
* **--add-gnu-debuglink=**_path-to-file_  
  .IX Item "--add-gnu-debuglink=path-to-file"
  Creates a .gnu_debuglink section which contains a reference to
  _path-to-file_ and adds it to the output file.  Note: the file at
  _path-to-file_ must exist.  Part of the process of adding the
  .gnu_debuglink section involves embedding a checksum of the contents
  of the debug info file into the section.
  .Sp
  If the debug info file is built in one location but it is going to be
  installed at a later time into a different location then do not use
  the path to the installed location.  The **--add-gnu-debuglink**
  option will fail because the installed file does not exist yet.
  Instead put the debug info file in the current directory and use the
  **--add-gnu-debuglink** option without any directory components,
  like this:
  .Sp
  .Vb 1
           objcopy --add-gnu-debuglink=foo.debug
  .Ve
  .Sp
  At debug time the debugger will attempt to look for the separate debug
  info file in a set of known locations.  The exact set of these
  locations varies depending upon the distribution being used, but it
  typically includes:
      .ie n .IP """* The same directory as the executable.""" 4
      .el .IP "\f(CW* The same directory as the executable." 4
      .IX Item "* The same directory as the executable."
      .ie n .IP """* A sub-directory of the directory containing the executable""" 4
      .el .IP "\f(CW* A sub-directory of the directory containing the executable" 4
      .IX Item "* A sub-directory of the directory containing the executable"
      called .debug
      .ie n .IP """* A global debug directory such as /usr/lib/debug.""" 4
      .el .IP "\f(CW* A global debug directory such as /usr/lib/debug." 4
      .IX Item "* A global debug directory such as /usr/lib/debug."
      .Sp
      As long as the debug info file has been installed into one of these
      locations before the debugger is run everything should work
      correctly.
* **--keep-file-symbols**  
  .IX Item "--keep-file-symbols"
  When stripping a file, perhaps with **--strip-debug** or
  **--strip-unneeded**, retain any symbols specifying source file names,
  which would otherwise get stripped.
* **--only-keep-debug**  
  .IX Item "--only-keep-debug"
  Strip a file, removing contents of any sections that would not be
  stripped by **--strip-debug** and leaving the debugging sections
  intact.  In \s-1ELF\s0 files, this preserves all note sections in the output.
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
      .ie n .IP "1.&lt;Copy ""foo"" to  ""foo.full""&gt;" 4
      .el .IP "1.&lt;Copy \f(CWfoo to  \f(CWfoo.full&gt;" 4
      .IX Item "1.&lt;Copy foo to foo.full&gt;"
      .ie n .IP "1.&lt;Run ""objcopy --strip-debug foo""&gt;" 4
      .el .IP "1.&lt;Run \f(CWobjcopy --strip-debug foo&gt;" 4
      .IX Item "1.&lt;Run objcopy --strip-debug foo&gt;"
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
* **--strip-dwo**  
  .IX Item "--strip-dwo"
  Remove the contents of all \s-1DWARF\s0 .dwo sections, leaving the
  remaining debugging sections and all symbols intact.
  This option is intended for use by the compiler as part of
  the **-gsplit-dwarf** option, which splits debug information
  between the .o file and a separate .dwo file.  The compiler
  generates all debug information in the same file, then uses
  the **--extract-dwo** option to copy the .dwo sections to
  the .dwo file, then the **--strip-dwo** option to remove
  those sections from the original .o file.
* **--extract-dwo**  
  .IX Item "--extract-dwo"
  Extract the contents of all \s-1DWARF\s0 .dwo sections.  See the
  **--strip-dwo** option for more information.
* **--file-alignment** _num_  
  .IX Item "--file-alignment num"
  Specify the file alignment.  Sections in the file will always begin at
  file offsets which are multiples of this number.  This defaults to
  512.
  [This option is specific to \s-1PE\s0 targets.]
* **--heap** _reserve_  
  .IX Item "--heap reserve"
* **--heap** _reserve_**,**_commit_  
  .IX Item "--heap reserve,commit"
  Specify the number of bytes of memory to reserve (and optionally commit)
  to be used as heap for this program.
  [This option is specific to \s-1PE\s0 targets.]
* **--image-base** _value_  
  .IX Item "--image-base value"
  Use _value_ as the base address of your program or dll.  This is
  the lowest memory location that will be used when your program or dll
  is loaded.  To reduce the need to relocate and improve performance of
  your dlls, each should have a unique base address and not overlap any
  other dlls.  The default is 0x400000 for executables, and 0x10000000
  for dlls.
  [This option is specific to \s-1PE\s0 targets.]
* **--section-alignment** _num_  
  .IX Item "--section-alignment num"
  Sets the section alignment.  Sections in memory will always begin at
  addresses which are a multiple of this number.  Defaults to 0x1000.
  [This option is specific to \s-1PE\s0 targets.]
* **--stack** _reserve_  
  .IX Item "--stack reserve"
* **--stack** _reserve_**,**_commit_  
  .IX Item "--stack reserve,commit"
  Specify the number of bytes of memory to reserve (and optionally commit)
  to be used as stack for this program.
  [This option is specific to \s-1PE\s0 targets.]
* **--subsystem** _which_  
  .IX Item "--subsystem which"
* **--subsystem** _which_**:**_major_  
  .IX Item "--subsystem which:major"
* **--subsystem** _which_**:**_major_**.**_minor_  
  .IX Item "--subsystem which:major.minor"
  Specifies the subsystem under which your program will execute.  The
  legal values for _which_ are \f(CW`native\*(C', \f(CW\*(C\`windows\*(C',
  \f(CW`console\*(C', \f(CW\*(C\`posix\*(C', \f(CW\*(C\`efi-app\*(C', \f(CW\*(C\`efi-bsd\*(C',
  \f(CW`efi-rtd\*(C', \f(CW\*(C\`sal-rtd\*(C', and \f(CW\*(C\`xbox\*(C'.  You may optionally set
  the subsystem version also.  Numeric values are also accepted for
  _which_.
  [This option is specific to \s-1PE\s0 targets.]
* **--extract-symbol**  
  .IX Item "--extract-symbol"
  Keep the file's section flags and symbols but remove all section data.
  Specifically, the option:
    * *&lt;removes the contents of all sections;&gt;  
      .IX Item "*&lt;removes the contents of all sections;&gt;"
    * *&lt;sets the size of every section to zero; and&gt;  
      .IX Item "*&lt;sets the size of every section to zero; and&gt;"
    * *&lt;sets the file's start address to zero.&gt;  
      .IX Item "*&lt;sets the file's start address to zero.&gt;"
      .Sp
      This option is used to build a _.sym_ file for a VxWorks kernel.
      It can also be a useful way of reducing the size of a **--just-symbols**
      linker input file.
* **--compress-debug-sections**  
  .IX Item "--compress-debug-sections"
  Compress \s-1DWARF\s0 debug sections using zlib with \s-1SHF_COMPRESSED\s0 from the
  \s-1ELF ABI.\s0  Note - if compression would actually make a section
  _larger_, then it is not compressed.
* **--compress-debug-sections=none**  
  .IX Item "--compress-debug-sections=none"
* **--compress-debug-sections=zlib**  
  .IX Item "--compress-debug-sections=zlib"
* **--compress-debug-sections=zlib-gnu**  
  .IX Item "--compress-debug-sections=zlib-gnu"
* **--compress-debug-sections=zlib-gabi**  
  .IX Item "--compress-debug-sections=zlib-gabi"
  For \s-1ELF\s0 files, these options control how \s-1DWARF\s0 debug sections are
  compressed.  **--compress-debug-sections=none** is equivalent
  to **--decompress-debug-sections**.
  **--compress-debug-sections=zlib** and
  **--compress-debug-sections=zlib-gabi** are equivalent to
  **--compress-debug-sections**.
  **--compress-debug-sections=zlib-gnu** compresses \s-1DWARF\s0 debug
  sections using zlib.  The debug sections are renamed to begin with
  **.zdebug** instead of **.debug**.  Note - if compression would
  actually make a section _larger_, then it is not compressed nor
  renamed.
* **--decompress-debug-sections**  
  .IX Item "--decompress-debug-sections"
  Decompress \s-1DWARF\s0 debug sections using zlib.  The original section
  names of the compressed sections are restored.
* **--elf-stt-common=yes**  
  .IX Item "--elf-stt-common=yes"
* **--elf-stt-common=no**  
  .IX Item "--elf-stt-common=no"
  For \s-1ELF\s0 files, these options control whether common symbols should be
  converted to the \f(CW`STT\_COMMON\*(C' or \f(CW\*(C\`STT\_OBJECT\*(C' type.
  **--elf-stt-common=yes** converts common symbol type to
  \f(CW`STT\_COMMON\*(C'. **--elf-stt-common=no** converts common symbol
  type to \f(CW`STT\_OBJECT\*(C'.
* **--merge-notes**  
  .IX Item "--merge-notes"
* **--no-merge-notes**  
  .IX Item "--no-merge-notes"
  For \s-1ELF\s0 files, attempt (or do not attempt) to reduce the size of any
  \s-1SHT_NOTE\s0 type sections by removing duplicate notes.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Show the version number of **objcopy**.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Verbose output: list all object files modified.  In the case of
  archives, **objcopy -V** lists all members of the archive.
* **--help**  
  .IX Item "--help"
  Show a summary of the options to **objcopy**.
* **--info**  
  .IX Item "--info"
  Display a list showing all architectures and object formats available.
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
_ld_\|(1), _objdump_\|(1), and the Info entries for _binutils_.

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
