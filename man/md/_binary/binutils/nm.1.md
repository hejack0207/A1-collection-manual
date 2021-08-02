# nm(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

nm - list symbols from object files

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" nm [-A|-o|--print-file-name] [-a|--debug-syms]    [-B|--format=bsd] [-C|--demangle[=style]]    [-D|--dynamic] [-fformat|--format=format]    [-g|--extern-only] [-h|--help]    [-l|--line-numbers] [--inlines]    [-n|-v|--numeric-sort]    [-P|--portability] [-p|--no-sort]    [-r|--reverse-sort] [-S|--print-size]    [-s|--print-armap] [-t radix|--radix=radix]    [-u|--undefined-only] [-V|--version]    [-X 32_64] [--defined-only] [--no-demangle]    [--plugin name] [--size-sort] [--special-syms]    [--synthetic] [--with-symbol-versions] [--target=bfdname]    [objfile...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\s-1GNU\s0 **nm** lists the symbols from object files _objfile_....
If no object files are listed as arguments, **nm** assumes the file
_a.out_.

For each symbol, **nm** shows:

* ·  
  The symbol value, in the radix selected by options (see below), or
  hexadecimal by default.
* ·  
  The symbol type.  At least the following types are used; others are, as
  well, depending on the object file format.  If lowercase, the symbol is
  usually local; if uppercase, the symbol is global (external).  There
  are however a few lowercase symbols that are shown for special global
  symbols (\f(CW`u\*(C', \f(CW\*(C\`v\*(C' and \f(CW\*(C\`w\*(C').
      .ie n .IP """A""" 4
      .el .IP "\f(CWA" 4
      .IX Item "A"
      The symbol's value is absolute, and will not be changed by further
      linking.
      .ie n .IP """B""" 4
      .el .IP "\f(CWB" 4
      .IX Item "B"
      .ie n .IP """b""" 4
      .el .IP "\f(CWb" 4
      .IX Item "b"
      The symbol is in the \s-1BSS\s0 data section.  This section typically
      contains zero-initialized or uninitialized data, although the exact
      behavior is system dependent.
      .ie n .IP """C""" 4
      .el .IP "\f(CWC" 4
      .IX Item "C"
      The symbol is common.  Common symbols are uninitialized data.  When
      linking, multiple common symbols may appear with the same name.  If the
      symbol is defined anywhere, the common symbols are treated as undefined
      references.
      .ie n .IP """D""" 4
      .el .IP "\f(CWD" 4
      .IX Item "D"
      .ie n .IP """d""" 4
      .el .IP "\f(CWd" 4
      .IX Item "d"
      The symbol is in the initialized data section.
      .ie n .IP """G""" 4
      .el .IP "\f(CWG" 4
      .IX Item "G"
      .ie n .IP """g""" 4
      .el .IP "\f(CWg" 4
      .IX Item "g"
      The symbol is in an initialized data section for small objects.  Some
      object file formats permit more efficient access to small data objects,
      such as a global int variable as opposed to a large global array.
      .ie n .IP """i""" 4
      .el .IP "\f(CWi" 4
      .IX Item "i"
      For \s-1PE\s0 format files this indicates that the symbol is in a section
      specific to the implementation of DLLs.  For \s-1ELF\s0 format files this
      indicates that the symbol is an indirect function.  This is a \s-1GNU\s0
      extension to the standard set of \s-1ELF\s0 symbol types.  It indicates a
      symbol which if referenced by a relocation does not evaluate to its
      address, but instead must be invoked at runtime.  The runtime
      execution will then return the value to be used in the relocation.
      .ie n .IP """I""" 4
      .el .IP "\f(CWI" 4
      .IX Item "I"
      The symbol is an indirect reference to another symbol.
      .ie n .IP """N""" 4
      .el .IP "\f(CWN" 4
      .IX Item "N"
      The symbol is a debugging symbol.
      .ie n .IP """p""" 4
      .el .IP "\f(CWp" 4
      .IX Item "p"
      The symbols is in a stack unwind section.
      .ie n .IP """R""" 4
      .el .IP "\f(CWR" 4
      .IX Item "R"
      .ie n .IP """r""" 4
      .el .IP "\f(CWr" 4
      .IX Item "r"
      The symbol is in a read only data section.
      .ie n .IP """S""" 4
      .el .IP "\f(CWS" 4
      .IX Item "S"
      .ie n .IP """s""" 4
      .el .IP "\f(CWs" 4
      .IX Item "s"
      The symbol is in an uninitialized or zero-initialized data section
      for small objects.
      .ie n .IP """T""" 4
      .el .IP "\f(CWT" 4
      .IX Item "T"
      .ie n .IP """t""" 4
      .el .IP "\f(CWt" 4
      .IX Item "t"
      The symbol is in the text (code) section.
      .ie n .IP """U""" 4
      .el .IP "\f(CWU" 4
      .IX Item "U"
      The symbol is undefined.
      .ie n .IP """u""" 4
      .el .IP "\f(CWu" 4
      .IX Item "u"
      The symbol is a unique global symbol.  This is a \s-1GNU\s0 extension to the
      standard set of \s-1ELF\s0 symbol bindings.  For such a symbol the dynamic linker
      will make sure that in the entire process there is just one symbol with
      this name and type in use.
      .ie n .IP """V""" 4
      .el .IP "\f(CWV" 4
      .IX Item "V"
      .ie n .IP """v""" 4
      .el .IP "\f(CWv" 4
      .IX Item "v"
      The symbol is a weak object.  When a weak defined symbol is linked with
      a normal defined symbol, the normal defined symbol is used with no error.
      When a weak undefined symbol is linked and the symbol is not defined,
      the value of the weak symbol becomes zero with no error.  On some
      systems, uppercase indicates that a default value has been specified.
      .ie n .IP """W""" 4
      .el .IP "\f(CWW" 4
      .IX Item "W"
      .ie n .IP """w""" 4
      .el .IP "\f(CWw" 4
      .IX Item "w"
      The symbol is a weak symbol that has not been specifically tagged as a
      weak object symbol.  When a weak defined symbol is linked with a normal
      defined symbol, the normal defined symbol is used with no error.
      When a weak undefined symbol is linked and the symbol is not defined,
      the value of the symbol is determined in a system-specific manner without
      error.  On some systems, uppercase indicates that a default value has been
      specified.
      .ie n .IP """-""" 4
      .el .IP "\f(CW-" 4
      .IX Item "-"
      The symbol is a stabs symbol in an a.out object file.  In this case, the
      next values printed are the stabs other field, the stabs desc field, and
      the stab type.  Stabs symbols are used to hold debugging information.
      .ie n .IP """?""" 4
      .el .IP "\f(CW?" 4
      .IX Item "?"
      The symbol type is unknown, or object file format specific.
* ·  
  The symbol name.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The long and short forms of options, shown here as alternatives, are
equivalent.

* **-A**  
  .IX Item "-A"
* **-o**  
  .IX Item "-o"
* **--print-file-name**  
  .IX Item "--print-file-name"
  Precede each symbol by the name of the input file (or archive member)
  in which it was found, rather than identifying the input file once only,
  before all of its symbols.
* **-a**  
  .IX Item "-a"
* **--debug-syms**  
  .IX Item "--debug-syms"
  Display all symbols, even debugger-only symbols; normally these are not
  listed.
* **-B**  
  .IX Item "-B"
  The same as **--format=bsd** (for compatibility with the \s-1MIPS\s0 **nm**).
* **-C**  
  .IX Item "-C"
* **--demangle[=**_style_**]**  
  .IX Item "--demangle[=style]"
  Decode (_demangle_) low-level symbol names into user-level names.
  Besides removing any initial underscore prepended by the system, this
  makes  function names readable. Different compilers have different
  mangling styles. The optional demangling style argument can be used to
  choose an appropriate demangling style for your compiler.
* **--no-demangle**  
  .IX Item "--no-demangle"
  Do not demangle low-level symbol names.  This is the default.
* **-D**  
  .IX Item "-D"
* **--dynamic**  
  .IX Item "--dynamic"
  Display the dynamic symbols rather than the normal symbols.  This is
  only meaningful for dynamic objects, such as certain types of shared
  libraries.
* **-f** _format_  
  .IX Item "-f format"
* **--format=**_format_  
  .IX Item "--format=format"
  Use the output format _format_, which can be \f(CW`bsd\*(C',
  \f(CW`sysv\*(C', or \f(CW\*(C\`posix\*(C'.  The default is \f(CW\*(C\`bsd\*(C'.
  Only the first character of _format_ is significant; it can be
  either upper or lower case.
* **-g**  
  .IX Item "-g"
* **--extern-only**  
  .IX Item "--extern-only"
  Display only external symbols.
* **-h**  
  .IX Item "-h"
* **--help**  
  .IX Item "--help"
  Show a summary of the options to **nm** and exit.
* **-l**  
  .IX Item "-l"
* **--line-numbers**  
  .IX Item "--line-numbers"
  For each symbol, use debugging information to try to find a filename and
  line number.  For a defined symbol, look for the line number of the
  address of the symbol.  For an undefined symbol, look for the line
  number of a relocation entry which refers to the symbol.  If line number
  information can be found, print it after the other symbol information.
* **--inlines**  
  .IX Item "--inlines"
  When option **-l** is active, if the address belongs to a
  function that was inlined, then this option causes the source 
  information for all enclosing scopes back to the first non-inlined
  function to be printed as well.  For example, if \f(CW`main\*(C' inlines
  \f(CW`callee1\*(C' which inlines \f(CW\*(C\`callee2\*(C', and address is from
  \f(CW`callee2\*(C', the source information for \f(CW\*(C\`callee1\*(C' and \f(CW\*(C\`main\*(C'
  will also be printed.
* **-n**  
  .IX Item "-n"
* **-v**  
  .IX Item "-v"
* **--numeric-sort**  
  .IX Item "--numeric-sort"
  Sort symbols numerically by their addresses, rather than alphabetically
  by their names.
* **-p**  
  .IX Item "-p"
* **--no-sort**  
  .IX Item "--no-sort"
  Do not bother to sort the symbols in any order; print them in the order
  encountered.
* **-P**  
  .IX Item "-P"
* **--portability**  
  .IX Item "--portability"
  Use the \s-1POSIX.2\s0 standard output format instead of the default format.
  Equivalent to **-f posix**.
* **-r**  
  .IX Item "-r"
* **--reverse-sort**  
  .IX Item "--reverse-sort"
  Reverse the order of the sort (whether numeric or alphabetic); let the
  last come first.
* **-S**  
  .IX Item "-S"
* **--print-size**  
  .IX Item "--print-size"
  Print both value and size of defined symbols for the \f(CW`bsd\*(C' output style.
  This option has no effect for object formats that do not record symbol
  sizes, unless **--size-sort** is also used in which case a
  calculated size is displayed.
* **-s**  
  .IX Item "-s"
* **--print-armap**  
  .IX Item "--print-armap"
  When listing symbols from archive members, include the index: a mapping
  (stored in the archive by **ar** or **ranlib**) of which modules
  contain definitions for which names.
* **-t** _radix_  
  .IX Item "-t radix"
* **--radix=**_radix_  
  .IX Item "--radix=radix"
  Use _radix_ as the radix for printing the symbol values.  It must be
  **d** for decimal, **o** for octal, or **x** for hexadecimal.
* **-u**  
  .IX Item "-u"
* **--undefined-only**  
  .IX Item "--undefined-only"
  Display only undefined symbols (those external to each object file).
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Show the version number of **nm** and exit.
* **-X**  
  .IX Item "-X"
  This option is ignored for compatibility with the \s-1AIX\s0 version of
  **nm**.  It takes one parameter which must be the string
  **32\_64**.  The default mode of \s-1AIX\s0 **nm** corresponds
  to **-X 32**, which is not supported by \s-1GNU\s0 **nm**.
* **--defined-only**  
  .IX Item "--defined-only"
  Display only defined symbols for each object file.
* **--plugin** _name_  
  .IX Item "--plugin name"
  Load the plugin called _name_ to add support for extra target
  types.  This option is only available if the toolchain has been built
  with plugin support enabled.
  .Sp
  If **--plugin** is not provided, but plugin support has been
  enabled then **nm** iterates over the files in
  _${libdir}/bfd-plugins_ in alphabetic order and the first
  plugin that claims the object in question is used.
  .Sp
  Please note that this plugin search directory is _not_ the one
  used by **ld**'s **-plugin** option.  In order to make
  **nm** use the  linker plugin it must be copied into the
  _${libdir}/bfd-plugins_ directory.  For \s-1GCC\s0 based compilations
  the linker plugin is called _liblto\_plugin.so.0.0.0_.  For Clang
  based compilations it is called _LLVMgold.so_.  The \s-1GCC\s0 plugin
  is always backwards compatible with earlier versions, so it is
  sufficient to just copy the newest one.
* **--size-sort**  
  .IX Item "--size-sort"
  Sort symbols by size.  For \s-1ELF\s0 objects symbol sizes are read from the
  \s-1ELF,\s0 for other object types the symbol sizes are computed as the
  difference between the value of the symbol and the value of the symbol
  with the next higher value.  If the \f(CW`bsd\*(C' output format is used
  the size of the symbol is printed, rather than the value, and
  **-S** must be used in order both size and value to be printed.
* **--special-syms**  
  .IX Item "--special-syms"
  Display symbols which have a target-specific special meaning.  These
  symbols are usually used by the target for some special processing and
  are not normally helpful when included in the normal symbol lists.
  For example for \s-1ARM\s0 targets this option would skip the mapping symbols
  used to mark transitions between \s-1ARM\s0 code, \s-1THUMB\s0 code and data.
* **--synthetic**  
  .IX Item "--synthetic"
  Include synthetic symbols in the output.  These are special symbols
  created by the linker for various purposes.  They are not shown by
  default since they are not part of the binary's original source code.
* **--with-symbol-versions**  
  .IX Item "--with-symbol-versions"
  Enables the display of symbol version information if any exists.  The
  version string is displayed as a suffix to the symbol name, preceeded by
  an @ character.  For example **foo@VER\_1**.  If the version is
  the default version to be used when resolving unversioned references
  to the symbol then it is displayed as a suffix preceeded by two @
  characters.  For example **foo@@VER\_2**.
* **--target=**_bfdname_  
  .IX Item "--target=bfdname"
  Specify an object code format other than your system's default format.
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
_ar_\|(1), _objdump_\|(1), _ranlib_\|(1), and the Info entries for _binutils_.

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
