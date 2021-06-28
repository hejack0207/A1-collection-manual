# readelf(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

readelf - Displays information about ELF files.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" readelf [-a|--all]         [-h|--file-header]         [-l|--program-headers|--segments]         [-S|--section-headers|--sections]         [-g|--section-groups]         [-t|--section-details]         [-e|--headers]         [-s|--syms|--symbols]         [--dyn-syms]         [-n|--notes]         [-r|--relocs]         [-u|--unwind]         [-d|--dynamic]         [-V|--version-info]         [-A|--arch-specific]         [-D|--use-dynamic]         [-x <number or name>|--hex-dump=<number or name>]         [-p <number or name>|--string-dump=<number or name>]         [-R <number or name>|--relocated-dump=<number or name>]         [-z|--decompress]         [-c|--archive-index]         [-w[lLiaprmfFsoRtUuTgAckK]|          --debug-dump[=rawline,=decodedline,=info,=abbrev,=pubnames,=aranges,=macro,=frames,=frames-interp,=str,=loc,=Ranges,=pubtypes,=trace_info,=trace_abbrev,=trace_aranges,=gdb_index,=addr,=cu_index,=links,=follow-links]]         [--dwarf-depth=n]         [--dwarf-start=n]         [-I|--histogram]         [-v|--version]         [-W|--wide]         [-H|--help]         elffile...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**readelf** displays information about one or more \s-1ELF\s0 format object
files.  The options control what particular information to display.

_elffile_... are the object files to be examined.  32-bit and
64-bit \s-1ELF\s0 files are supported, as are archives containing \s-1ELF\s0 files.

This program performs a similar function to **objdump** but it
goes into more detail and it exists independently of the \s-1BFD\s0
library, so if there is a bug in \s-1BFD\s0 then readelf will not be
affected.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The long and short forms of options, shown here as alternatives, are
equivalent.  At least one option besides **-v** or **-H** must be
given.

* **-a**  
  .IX Item "-a"
* **--all**  
  .IX Item "--all"
  Equivalent to specifying **--file-header**,
  **--program-headers**, **--sections**, **--symbols**,
  **--relocs**, **--dynamic**, **--notes**,
  **--version-info**, **--arch-specific**, **--unwind**,
  **--section-groups** and **--histogram**.
  .Sp
  Note - this option does not enable **--use-dynamic** itself, so
  if that option is not present on the command line then dynamic symbols
  and dynamic relocs will not be displayed.
* **-h**  
  .IX Item "-h"
* **--file-header**  
  .IX Item "--file-header"
  Displays the information contained in the \s-1ELF\s0 header at the start of the
  file.
* **-l**  
  .IX Item "-l"
* **--program-headers**  
  .IX Item "--program-headers"
* **--segments**  
  .IX Item "--segments"
  Displays the information contained in the file's segment headers, if it
  has any.
* **-S**  
  .IX Item "-S"
* **--sections**  
  .IX Item "--sections"
* **--section-headers**  
  .IX Item "--section-headers"
  Displays the information contained in the file's section headers, if it
  has any.
* **-g**  
  .IX Item "-g"
* **--section-groups**  
  .IX Item "--section-groups"
  Displays the information contained in the file's section groups, if it
  has any.
* **-t**  
  .IX Item "-t"
* **--section-details**  
  .IX Item "--section-details"
  Displays the detailed section information. Implies **-S**.
* **-s**  
  .IX Item "-s"
* **--symbols**  
  .IX Item "--symbols"
* **--syms**  
  .IX Item "--syms"
  Displays the entries in symbol table section of the file, if it has one.
  If a symbol has version information associated with it then this is
  displayed as well.  The version string is displayed as a suffix to the
  symbol name, preceeded by an @ character.  For example
  **foo@VER\_1**.  If the version is the default version to be used
  when resolving unversioned references to the symbol then it is
  displayed as a suffix preceeded by two @ characters.  For example
  **foo@@VER\_2**.
* **--dyn-syms**  
  .IX Item "--dyn-syms"
  Displays the entries in dynamic symbol table section of the file, if it
  has one.  The output format is the same as the format used by the
  **--syms** option.
* **-e**  
  .IX Item "-e"
* **--headers**  
  .IX Item "--headers"
  Display all the headers in the file.  Equivalent to **-h -l -S**.
* **-n**  
  .IX Item "-n"
* **--notes**  
  .IX Item "--notes"
  Displays the contents of the \s-1NOTE\s0 segments and/or sections, if any.
* **-r**  
  .IX Item "-r"
* **--relocs**  
  .IX Item "--relocs"
  Displays the contents of the file's relocation section, if it has one.
* **-u**  
  .IX Item "-u"
* **--unwind**  
  .IX Item "--unwind"
  Displays the contents of the file's unwind section, if it has one.  Only
  the unwind sections for \s-1IA64 ELF\s0 files, as well as \s-1ARM\s0 unwind tables
  (\f(CW`.ARM.exidx\*(C' / \f(CW\*(C\`.ARM.extab\*(C') are currently supported.
* **-d**  
  .IX Item "-d"
* **--dynamic**  
  .IX Item "--dynamic"
  Displays the contents of the file's dynamic section, if it has one.
* **-V**  
  .IX Item "-V"
* **--version-info**  
  .IX Item "--version-info"
  Displays the contents of the version sections in the file, it they
  exist.
* **-A**  
  .IX Item "-A"
* **--arch-specific**  
  .IX Item "--arch-specific"
  Displays architecture-specific information in the file, if there
  is any.
* **-D**  
  .IX Item "-D"
* **--use-dynamic**  
  .IX Item "--use-dynamic"
  When displaying symbols, this option makes **readelf** use the
  symbol hash tables in the file's dynamic section, rather than the
  symbol table sections.
  .Sp
  When displaying relocations, this option makes **readelf**
  display the dynamic relocations rather than the static relocations.
* **-x &lt;number or name&gt;**  
  .IX Item "-x &lt;number or name&gt;"
* **--hex-dump=&lt;number or name&gt;**  
  .IX Item "--hex-dump=&lt;number or name&gt;"
  Displays the contents of the indicated section as a hexadecimal bytes.
  A number identifies a particular section by index in the section table;
  any other string identifies all sections with that name in the object file.
* **-R &lt;number or name&gt;**  
  .IX Item "-R &lt;number or name&gt;"
* **--relocated-dump=&lt;number or name&gt;**  
  .IX Item "--relocated-dump=&lt;number or name&gt;"
  Displays the contents of the indicated section as a hexadecimal
  bytes.  A number identifies a particular section by index in the
  section table; any other string identifies all sections with that name
  in the object file.  The contents of the section will be relocated
  before they are displayed.
* **-p &lt;number or name&gt;**  
  .IX Item "-p &lt;number or name&gt;"
* **--string-dump=&lt;number or name&gt;**  
  .IX Item "--string-dump=&lt;number or name&gt;"
  Displays the contents of the indicated section as printable strings.
  A number identifies a particular section by index in the section table;
  any other string identifies all sections with that name in the object file.
* **-z**  
  .IX Item "-z"
* **--decompress**  
  .IX Item "--decompress"
  Requests that the section(s) being dumped by **x**, **R** or
  **p** options are decompressed before being displayed.  If the
  section(s) are not compressed then they are displayed as is.
* **-c**  
  .IX Item "-c"
* **--archive-index**  
  .IX Item "--archive-index"
  Displays the file symbol index information contained in the header part
  of binary archives.  Performs the same function as the **t**
  command to **ar**, but without using the \s-1BFD\s0 library.
* **-w[lLiaprmfFsoRtUuTgAckK]**  
  .IX Item "-w[lLiaprmfFsoRtUuTgAckK]"
* **--debug-dump[=rawline,=decodedline,=info,=abbrev,=pubnames,=aranges,=macro,=frames,=frames-interp,=str,=loc,=Ranges,=pubtypes,=trace\_info,=trace\_abbrev,=trace\_aranges,=gdb\_index,=addr,=cu\_index,=links,=follow-links]**  
  .IX Item "--debug-dump[=rawline,=decodedline,=info,=abbrev,=pubnames,=aranges,=macro,=frames,=frames-interp,=str,=loc,=Ranges,=pubtypes,=trace_info,=trace_abbrev,=trace_aranges,=gdb_index,=addr,=cu_index,=links,=follow-links]"
  Displays the contents of the \s-1DWARF\s0 debug sections in the file, if any
  are present.  Compressed debug sections are automatically decompressed
  (temporarily) before they are displayed.  If one or more of the
  optional letters or words follows the switch then only those type(s)
  of data will be dumped.  The letters and words refer to the following
  information:
      .ie n .IP """a""" 4
      .el .IP "\f(CWa" 4
      .IX Item "a"
      .ie n .IP """=abbrev""" 4
      .el .IP "\f(CW=abbrev" 4
      .IX Item "=abbrev"
      Displays the contents of the **.debug\_abbrev** section.
      .ie n .IP """A""" 4
      .el .IP "\f(CWA" 4
      .IX Item "A"
      .ie n .IP """=addr""" 4
      .el .IP "\f(CW=addr" 4
      .IX Item "=addr"
      Displays the contents of the **.debug\_addr** section.
      .ie n .IP """c""" 4
      .el .IP "\f(CWc" 4
      .IX Item "c"
      .ie n .IP """=cu_index""" 4
      .el .IP "\f(CW=cu\_index" 4
      .IX Item "=cu_index"
      Displays the contents of the **.debug\_cu\_index** and/or
      **.debug\_tu\_index** sections.
      .ie n .IP """f""" 4
      .el .IP "\f(CWf" 4
      .IX Item "f"
      .ie n .IP """=frames""" 4
      .el .IP "\f(CW=frames" 4
      .IX Item "=frames"
      Display the raw contents of a **.debug\_frame** section.
      .ie n .IP """F""" 4
      .el .IP "\f(CWF" 4
      .IX Item "F"
      .ie n .IP """=frame-interp""" 4
      .el .IP "\f(CW=frame-interp" 4
      .IX Item "=frame-interp"
      Display the interpreted contents of a **.debug\_frame** section.
      .ie n .IP """g""" 4
      .el .IP "\f(CWg" 4
      .IX Item "g"
      .ie n .IP """=gdb_index""" 4
      .el .IP "\f(CW=gdb\_index" 4
      .IX Item "=gdb_index"
      Displays the contents of the **.gdb\_index** and/or
      **.debug\_names** sections.
      .ie n .IP """i""" 4
      .el .IP "\f(CWi" 4
      .IX Item "i"
      .ie n .IP """=info""" 4
      .el .IP "\f(CW=info" 4
      .IX Item "=info"
      Displays the contents of the **.debug\_info** section.  Note: the
      output from this option can also be restricted by the use of the 
      **--dwarf-depth** and **--dwarf-start** options.
      .ie n .IP """k""" 4
      .el .IP "\f(CWk" 4
      .IX Item "k"
      .ie n .IP """=links""" 4
      .el .IP "\f(CW=links" 4
      .IX Item "=links"
      Displays the contents of the **.gnu\_debuglink** and/or
      **.gnu\_debugaltlink** sections.  Also displays the link to a
      separate dwarf object file (dwo), if one is specified by the 
      DW_AT_GNU_dwo_name or DW_AT_dwo_name attributes in the
      **.debug\_info** section.
      .ie n .IP """K""" 4
      .el .IP "\f(CWK" 4
      .IX Item "K"
      .ie n .IP """=follow-links""" 4
      .el .IP "\f(CW=follow-links" 4
      .IX Item "=follow-links"
      Display the contents of any selected debug sections that are found in
      a linked, separate debug info file.  This can result in multiple
      versions of the same debug section being displayed if both the main
      file and the separate debug info file contain sections with the same
      name.
      .Sp
      In addition, when displaying \s-1DWARF\s0 attributes, if a form is found that
      references the separate debug info file, then the referenced contents
      will also be displayed.
      .ie n .IP """l""" 4
      .el .IP "\f(CWl" 4
      .IX Item "l"
      .ie n .IP """=rawline""" 4
      .el .IP "\f(CW=rawline" 4
      .IX Item "=rawline"
      Displays the contents of the **.debug\_line** section in a raw
      format.
      .ie n .IP """L""" 4
      .el .IP "\f(CWL" 4
      .IX Item "L"
      .ie n .IP """=decodedline""" 4
      .el .IP "\f(CW=decodedline" 4
      .IX Item "=decodedline"
      Displays the interpreted contents of the **.debug\_line** section.
      .ie n .IP """m""" 4
      .el .IP "\f(CWm" 4
      .IX Item "m"
      .ie n .IP """=macro""" 4
      .el .IP "\f(CW=macro" 4
      .IX Item "=macro"
      Displays the contents of the **.debug\_macro** and/or
      **.debug\_macinfo** sections.
      .ie n .IP """o""" 4
      .el .IP "\f(CWo" 4
      .IX Item "o"
      .ie n .IP """=loc""" 4
      .el .IP "\f(CW=loc" 4
      .IX Item "=loc"
      Displays the contents of the **.debug\_loc** and/or
      **.debug\_loclists** sections.
      .ie n .IP """p""" 4
      .el .IP "\f(CWp" 4
      .IX Item "p"
      .ie n .IP """=pubnames""" 4
      .el .IP "\f(CW=pubnames" 4
      .IX Item "=pubnames"
      Displays the contents of the **.debug\_pubnames** and/or
      **.debug\_gnu\_pubnames** sections.
      .ie n .IP """r""" 4
      .el .IP "\f(CWr" 4
      .IX Item "r"
      .ie n .IP """=aranges""" 4
      .el .IP "\f(CW=aranges" 4
      .IX Item "=aranges"
      Displays the contents of the **.debug\_aranges** section.
      .ie n .IP """R""" 4
      .el .IP "\f(CWR" 4
      .IX Item "R"
      .ie n .IP """=Ranges""" 4
      .el .IP "\f(CW=Ranges" 4
      .IX Item "=Ranges"
      Displays the contents of the **.debug\_ranges** and/or
      **.debug\_rnglists** sections.
      .ie n .IP """s""" 4
      .el .IP "\f(CWs" 4
      .IX Item "s"
      .ie n .IP """=str""" 4
      .el .IP "\f(CW=str" 4
      .IX Item "=str"
      Displays the contents of the **.debug\_str**, **.debug\_line\_str**
      and/or **.debug\_str\_offsets** sections.
      .ie n .IP """t""" 4
      .el .IP "\f(CWt" 4
      .IX Item "t"
      .ie n .IP """=pubtype""" 4
      .el .IP "\f(CW=pubtype" 4
      .IX Item "=pubtype"
      Displays the contents of the **.debug\_pubtypes** and/or
      **.debug\_gnu\_pubtypes** sections.
      .ie n .IP """T""" 4
      .el .IP "\f(CWT" 4
      .IX Item "T"
      .ie n .IP """=trace_aranges""" 4
      .el .IP "\f(CW=trace\_aranges" 4
      .IX Item "=trace_aranges"
      Displays the contents of the **.trace\_aranges** section.
      .ie n .IP """u""" 4
      .el .IP "\f(CWu" 4
      .IX Item "u"
      .ie n .IP """=trace_abbrev""" 4
      .el .IP "\f(CW=trace\_abbrev" 4
      .IX Item "=trace_abbrev"
      Displays the contents of the **.trace\_abbrev** section.
      .ie n .IP """U""" 4
      .el .IP "\f(CWU" 4
      .IX Item "U"
      .ie n .IP """=trace_info""" 4
      .el .IP "\f(CW=trace\_info" 4
      .IX Item "=trace_info"
      Displays the contents of the **.trace\_info** section.
      .Sp
      Note: displaying the contents of **.debug\_static\_funcs**,
      **.debug\_static\_vars** and **debug\_weaknames** sections is not
      currently supported.
* **--dwarf-depth=**_n_  
  .IX Item "--dwarf-depth=n"
  Limit the dump of the \f(CW`.debug\_info\*(C' section to _n_ children.
  This is only useful with **--debug-dump=info**.  The default is
  to print all DIEs; the special value 0 for _n_ will also have this
  effect.
  .Sp
  With a non-zero value for _n_, DIEs at or deeper than _n_
  levels will not be printed.  The range for _n_ is zero-based.
* **--dwarf-start=**_n_  
  .IX Item "--dwarf-start=n"
  Print only DIEs beginning with the \s-1DIE\s0 numbered _n_.  This is only
  useful with **--debug-dump=info**.
  .Sp
  If specified, this option will suppress printing of any header
  information and all DIEs before the \s-1DIE\s0 numbered _n_.  Only
  siblings and children of the specified \s-1DIE\s0 will be printed.
  .Sp
  This can be used in conjunction with **--dwarf-depth**.
* **-I**  
  .IX Item "-I"
* **--histogram**  
  .IX Item "--histogram"
  Display a histogram of bucket list lengths when displaying the contents
  of the symbol tables.
* **-v**  
  .IX Item "-v"
* **--version**  
  .IX Item "--version"
  Display the version number of readelf.
* **-W**  
  .IX Item "-W"
* **--wide**  
  .IX Item "--wide"
  Don't break output lines to fit into 80 columns. By default
  **readelf** breaks section header and segment listing lines for
  64-bit \s-1ELF\s0 files, so that they fit into 80 columns. This option causes
  **readelf** to print each section header resp. each segment one a
  single line, which is far more readable on terminals wider than 80 columns.
* **-H**  
  .IX Item "-H"
* **--help**  
  .IX Item "--help"
  Display the command line options understood by **readelf**.
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
_objdump_\|(1), and the Info entries for _binutils_.

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
