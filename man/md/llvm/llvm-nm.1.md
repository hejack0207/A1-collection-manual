# llvm-nm(1) - list LLVM bitcode and object file's symbol table

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

 llvm-nm [options] [filenames...]
```

<a name="description"></a>

# Description


The **llvm-nm** utility lists the names of symbols from LLVM bitcode
files, object files, and archives. Each symbol is listed along with some simple
information about its provenance. If no filename is specified, _a.out_ is used
as the input. If _-_ is used as a filename, **llvm-nm** will read a file
from its standard input stream.

**llvm-nm**'s default output format is the traditional BSD **nm**
output format. Each such output record consists of an (optional) 8-digit
hexadecimal address, followed by a type code character, followed by a name, for
each symbol. One record is printed per line; fields are separated by spaces.
When the address is omitted, it is replaced by 8 spaces.

The supported type code characters are as follows. Where both lower and
upper-case characters are listed for the same meaning, a lower-case character
represents a local symbol, whilst an upper-case character represents a global
(external) symbol:

a, A
.INDENT 0.0
.INDENT 3.5
Absolute symbol.
.UNINDENT
.UNINDENT

b, B
.INDENT 0.0
.INDENT 3.5
Uninitialized data (bss) object.
.UNINDENT
.UNINDENT

C
.INDENT 0.0
.INDENT 3.5
Common symbol. Multiple definitions link together into one definition.
.UNINDENT
.UNINDENT

d, D
.INDENT 0.0
.INDENT 3.5
Writable data object.
.UNINDENT
.UNINDENT

i, I
.INDENT 0.0
.INDENT 3.5
COFF: .idata symbol or symbol in a section with IMAGE_SCN_LNK_INFO set.
.UNINDENT
.UNINDENT

n
.INDENT 0.0
.INDENT 3.5
ELF: local symbol from non-alloc section.

COFF: debug symbol.
.UNINDENT
.UNINDENT

N
.INDENT 0.0
.INDENT 3.5
ELF: debug section symbol, or global symbol from non-alloc section.
.UNINDENT
.UNINDENT

s, S
.INDENT 0.0
.INDENT 3.5
COFF: section symbol.

Mach-O: absolute symbol or symbol from a section other than __TEXT_EXEC __text,
__TEXT __text, __DATA __data, or __DATA __bss.
.UNINDENT
.UNINDENT

r, R
.INDENT 0.0
.INDENT 3.5
Read-only data object.
.UNINDENT
.UNINDENT

t, T
.INDENT 0.0
.INDENT 3.5
Code (text) object.
.UNINDENT
.UNINDENT

u
.INDENT 0.0
.INDENT 3.5
ELF: GNU unique symbol.
.UNINDENT
.UNINDENT

U
.INDENT 0.0
.INDENT 3.5
Named object is undefined in this file.
.UNINDENT
.UNINDENT

v
.INDENT 0.0
.INDENT 3.5
ELF: Undefined weak object. It is not a link failure if the object is not
defined.
.UNINDENT
.UNINDENT

V
.INDENT 0.0
.INDENT 3.5
ELF: Defined weak object symbol. This definition will only be used if no
regular definitions exist in a link. If multiple weak definitions and no
regular definitions exist, one of the weak definitions will be used.
.UNINDENT
.UNINDENT

w
.INDENT 0.0
.INDENT 3.5
Undefined weak symbol other than an ELF object symbol. It is not a link failure
if the symbol is not defined.
.UNINDENT
.UNINDENT

W
.INDENT 0.0
.INDENT 3.5
Defined weak symbol other than an ELF object symbol. This definition will only
be used if no regular definitions exist in a link. If multiple weak definitions
and no regular definitions exist, one of the weak definitions will be used.
.UNINDENT
.UNINDENT

-
.INDENT 0.0
.INDENT 3.5
Mach-O: N_STAB symbol.
.UNINDENT
.UNINDENT

?
.INDENT 0.0
.INDENT 3.5
Something unrecognizable.
.UNINDENT
.UNINDENT

Because LLVM bitcode files typically contain objects that are not considered to
have addresses until they are linked into an executable image or dynamically
compiled "just-in-time", **llvm-nm** does not print an address for any
symbol in an LLVM bitcode file, even symbols which are defined in the bitcode
file.

<a name="options"></a>

# Options

.INDENT 0.0

* **-B**  
  Use BSD output format. Alias for **--format=bsd**.
  .UNINDENT
  .INDENT 0.0
* **--debug-syms, -a**  
  Show all symbols, even those usually suppressed.
  .UNINDENT
  .INDENT 0.0
* **--defined-only, -U**  
  Print only symbols defined in this file.
  .UNINDENT
  .INDENT 0.0
* **--demangle, -C**  
  Demangle symbol names.
  .UNINDENT
  .INDENT 0.0
* **--dynamic, -D**  
  Display dynamic symbols instead of normal symbols.
  .UNINDENT
  .INDENT 0.0
* **--extern-only, -g**  
  Print only symbols whose definitions are external; that is, accessible from
  other files.
  .UNINDENT
  .INDENT 0.0
* **--format=&lt;format&gt;, -f**  
  Select an output format; _format_ may be _sysv_, _posix_, _darwin_, or _bsd_.
  The default is _bsd_.
  .UNINDENT
  .INDENT 0.0
* **--help, -h**  
  Print a summary of command-line options and their meanings.
  .UNINDENT
  .INDENT 0.0
* **--help-list**  
  Print an uncategorized summary of command-line options and their meanings.
  .UNINDENT
  .INDENT 0.0
* **--just-symbol-name, -j**  
  Print just the symbol names.
  .UNINDENT
  .INDENT 0.0
* **-m**  
  Use Darwin format. Alias for **--format=darwin**.
  .UNINDENT
  .INDENT 0.0
* **--no-demangle**  
  Don't demangle symbol names. This is the default.
  .UNINDENT
  .INDENT 0.0
* **--no-llvm-bc**  
  Disable the LLVM bitcode reader.
  .UNINDENT
  .INDENT 0.0
* **--no-sort, -p**  
  Show symbols in the order encountered.
  .UNINDENT
  .INDENT 0.0
* **--no-weak, -W**  
  Don't print weak symbols.
  .UNINDENT
  .INDENT 0.0
* **--numeric-sort, -n, -v**  
  Sort symbols by address.
  .UNINDENT
  .INDENT 0.0
* **--portability, -P**  
  Use POSIX.2 output format.  Alias for **--format=posix**.
  .UNINDENT
  .INDENT 0.0
* **--print-armap, -M**  
  Print the archive symbol table, in addition to the symbols.
  .UNINDENT
  .INDENT 0.0
* **--print-file-name, -A, -o**  
  Precede each symbol with the file it came from.
  .UNINDENT
  .INDENT 0.0
* **--print-size, -S**  
  Show symbol size as well as address (not applicable for Mach-O).
  .UNINDENT
  .INDENT 0.0
* **--radix=&lt;RADIX&gt;, -t**  
  Specify the radix of the symbol address(es). Values accepted are _d_ (decimal),
  _x_ (hexadecimal) and _o_ (octal).
  .UNINDENT
  .INDENT 0.0
* **--reverse-sort, -r**  
  Sort symbols in reverse order.
  .UNINDENT
  .INDENT 0.0
* **--size-sort**  
  Sort symbols by size.
  .UNINDENT
  .INDENT 0.0
* **--special-syms**  
  Do not filter special symbols from the output.
  .UNINDENT
  .INDENT 0.0
* **--undefined-only, -u**  
  Print only undefined symbols.
  .UNINDENT
  .INDENT 0.0
* **--version**  
  Display the version of the **llvm-nm** executable. Does not stack with
  other commands.
  .UNINDENT
  .INDENT 0.0
* **--without-aliases**  
  Exclude aliases from the output.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options from response file _&lt;FILE&gt;_.
  .UNINDENT

<a name="mach-o-specific-options"></a>

# Mach-O Specific Options

.INDENT 0.0

* **--add-dyldinfo**  
  Add symbols from the dyldinfo, if they are not already in the symbol table.
  This is the default.
  .UNINDENT
  .INDENT 0.0
* **--add-inlinedinfo**  
  Add symbols from the inlined libraries, TBD file inputs only.
  .UNINDENT
  .INDENT 0.0
* **--arch=&lt;arch1[,arch2,...]&gt;**  
  Dump the symbols from the specified architecture(s).
  .UNINDENT
  .INDENT 0.0
* **--dyldinfo-only**  
  Dump only symbols from the dyldinfo.
  .UNINDENT
  .INDENT 0.0
* **--no-dyldinfo**  
  Do not add any symbols from the dyldinfo.
  .UNINDENT
  .INDENT 0.0
* **-s=&lt;segment section&gt;**  
  Dump only symbols from this segment and section name.
  .UNINDENT
  .INDENT 0.0
* **-x**  
  Print symbol entry in hex.
  .UNINDENT

<a name="bugs"></a>

# Bugs

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  **llvm-nm** does not support the full set of arguments that GNU
  **nm** does.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-nm** exits with an exit code of zero.

<a name="see-also"></a>

# See Also


**llvm-ar(1)**, **llvm-objdump(1)**, **llvm-readelf(1)**,
**llvm-readobj(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

