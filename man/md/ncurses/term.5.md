# term(5)

.ie \n(.g .ds \`\` “
.el       .ds \`\` \`\`
.ie \n(.g .ds '' ”
.el       .ds '' ''

<a name="name"></a>

# Name

term - format of compiled term file.

<a name="synopsis"></a>

# Synopsis

```
term
```

<a name="description"></a>

# Description


<a name="storage-location"></a>

### STORAGE LOCATION

Compiled terminfo descriptions are placed under the directory **/usr/share/terminfo**.
Two configurations are supported (when building the **ncurses** libraries):

* **directory tree**  
  A two-level scheme is used to avoid a linear search
  of a huge \s-1UNIX\s+1 system directory: **/usr/share/terminfo/c/name** where
  _name_
  is the name of the terminal, and
  _c_
  is the first character of
  _name_.
  Thus,
  _act4_
  can be found in the file **/usr/share/terminfo/a/act4**.
  Synonyms for the same terminal are implemented by multiple
  links to the same compiled file.
* **hashed database**  
  Using Berkeley database, two types of records are stored:
  the terminfo data in the same format as stored in a directory tree with
  the terminfo's primary name as a key,
  and records containing only aliases pointing to the primary name.
* If built to write hashed databases,
  **ncurses** can still read terminfo databases organized as a directory tree,
  but cannot write entries into the directory tree.
  It can write (or rewrite) entries in the hashed database.
* **ncurses** distinguishes the two cases in the TERMINFO and TERMINFO_DIRS
  environment variable by assuming a directory tree for entries that
  correspond to an existing directory,
  and hashed database otherwise.

<a name="legacy-storage-format"></a>

### LEGACY STORAGE FORMAT

The format has been chosen so that it will be the same on all hardware.
An 8 or more bit byte is assumed, but no assumptions about byte ordering
or sign extension are made.

The compiled file is created with the **tic** program,
and read by the routine **setupterm**(3X).
The file is divided into six parts:
the header,
terminal names,
boolean flags,
numbers,
strings,
and
string table.

The header section begins the file.
This section contains six short integers in the format
described below.
These integers are

* (1) the magic number (octal 0432);  
* (2) the size, in bytes, of the names section;  
* (3) the number of bytes in the boolean section;  
* (4) the number of short integers in the numbers section;  
* (5) the number of offsets (short integers) in the strings section;  
* (6) the size, in bytes, of the string table.  

Short integers are stored in two 8-bit bytes.
The first byte contains the least significant 8 bits of the value,
and the second byte contains the most significant 8 bits.
(Thus, the value represented is 256*second+first.)
The value -1 is represented by the two bytes 0377, 0377; other negative
values are illegal.
This value generally
means that the corresponding capability is missing from this terminal.
Note that this format corresponds to the hardware of the \s-1VAX\s+1
and \s-1PDP\s+1-11 (that is, little-endian machines).
Machines where this does not correspond to the hardware must read the
integers as two bytes and compute the little-endian value.

The terminal names section comes next.
It contains the first line of the terminfo description,
listing the various names for the terminal,
separated by the \`|\*('' character.
The section is terminated with an \s-1ASCII NUL\s+1 character.

The boolean flags have one byte for each flag.
This byte is either 0 or 1 as the flag is present or absent.
The capabilities are in the same order as the file &lt;term.h&gt;.

Between the boolean section and the number section,
a null byte will be inserted, if necessary,
to ensure that the number section begins on an even byte (this is a
relic of the PDP-11's word-addressed architecture, originally
designed in to avoid IOT traps induced by addressing a word on an
odd byte boundary).
All short integers are aligned on a short word boundary.

The numbers section is similar to the flags section.
Each capability takes up two bytes,
and is stored as a little-endian short integer.
If the value represented is -1, the capability is taken to be missing.

The strings section is also similar.
Each capability is stored as a short integer, in the format above.
A value of -1 means the capability is missing.
Otherwise, the value is taken as an offset from the beginning
of the string table.
Special characters in ^X or \ec notation are stored in their
interpreted form, not the printing representation.
Padding information $&lt;nn&gt; and parameter information %x are
stored intact in uninterpreted form.

The final section is the string table.
It contains all the values of string capabilities referenced in
the string section.
Each string is null terminated.

<a name="extended-storage-format"></a>

### EXTENDED STORAGE FORMAT

The previous section describes the conventional terminfo binary format.
With some minor variations of the offsets (see PORTABILITY),
the same binary format is used in all modern UNIX systems.
Each system uses a predefined set of boolean, number or string capabilities.

The **ncurses** libraries and applications support
extended terminfo binary format,
allowing users to define capabilities which are loaded at runtime.
This
extension is made possible by using the fact that the other implementations
stop reading the terminfo data when they have reached the end of the size given
in the header.
**ncurses** checks the size,
and if it exceeds that due to the predefined data,
continues to parse according to its own scheme.

First, it reads the extended header (5 short integers):

* (1)  
  count of extended boolean capabilities
* (2)  
  count of extended numeric capabilities
* (3)  
  count of extended string capabilities
* (4)  
  count of the items in extended string table
* (5)  
  size of the extended string table in bytes

The count- and size-values for the extended string table
include the extended capability _names_ as well as
extended capability _values_.

Using the counts and sizes, **ncurses** allocates arrays and reads data
for the extended capabilities in the same order as the header information.

The extended string table contains values for string capabilities.
After the end of these values, it contains the names for each of
the extended capabilities in order, e.g., booleans, then numbers and
finally strings.

Applications which manipulate terminal data can use the definitions
described in **term\_variables**(3X) which associate the long capability
names with members of a **TERMTYPE** structure.

<a name="extended-number-format"></a>

### EXTENDED NUMBER FORMAT


On occasion, 16-bit signed integers are not large enough.
With **ncurses** 6.1, a new format was introduced by making a few changes
to the legacy format:
.bP
a different magic number (0542)
.bP
changing the type for the _number_ array from signed 16-bit integers
to signed 32-bit integers.

To maintain compatibility, the library presents the same data structures
to direct users of the **TERMTYPE** structure as in previous formats.
However, that cannot provide callers with the extended numbers.
The library uses a similar but hidden data structure **TERMTYPE2**
to provide data for the terminfo functions.

<a name="portability"></a>

# Portability

Note that it is possible for
**setupterm**
to expect a different set of capabilities
than are actually present in the file.
Either the database may have been updated since
**setupterm**
has been recompiled
(resulting in extra unrecognized entries in the file)
or the program may have been recompiled more recently
than the database was updated
(resulting in missing entries).
The routine
**setupterm**
must be prepared for both possibilities -
this is why the numbers and sizes are included.
Also, new capabilities must always be added at the end of the lists
of boolean, number, and string capabilities.

Despite the consistent use of little-endian for numbers and the otherwise
self-describing format, it is not wise to count on portability of binary
terminfo entries between commercial UNIX versions.
The problem is that there
are at least three versions of terminfo (under HP-UX, AIX, and OSF/1) which
diverged from System V terminfo after SVr1, and have added extension
capabilities to the string table that (in the binary format) collide with
System V and XSI Curses extensions.
See **terminfo**(5) for detailed
discussion of terminfo source compatibility issues.

Direct access to the **TERMTYPE** structure is provided for legacy
applications.
Portable applications should use the **tigetflag** and related functions
described in **curs\_terminfo**(3X) for reading terminal capabilities.

A small number of terminal descriptions use uppercase characters in
their names.
If the underlying filesystem ignores the difference between
uppercase and lowercase,
**ncurses** represents the \`first character\*(''
of the terminal name used as
the intermediate level of a directory tree in (two-character) hexadecimal form.

<a name="example"></a>

# Example

As an example, here is a description for the Lear-Siegler
ADM-3, a popular though rather stupid early terminal:
.NS
adm3a|lsi adm3a,
        am,
        cols#80, lines#24,
        bel=^G, clear=\032$&lt;1&gt;, cr=^M, cub1=^H, cud1=^J,
        cuf1=^L, cup=\\E=%p1%{32}%+%c%p2%{32}%+%c, cuu1=^K,
        home=^^, ind=^J,
.NS

and a hexadecimal dump of the compiled terminal description:
.NS
\s-20000  1a 01 10 00 02 00 03 00  82 00 31 00 61 64 6d 33  ........ ..1.adm3
0010  61 7c 6c 73 69 20 61 64  6d 33 61 00 00 01 50 00  a|lsi ad m3a...P.
0020  ff ff 18 00 ff ff 00 00  02 00 ff ff ff ff 04 00  ........ ........
0030  ff ff ff ff ff ff ff ff  0a 00 25 00 27 00 ff ff  ........ ..%.'...
0040  29 00 ff ff ff ff 2b 00  ff ff 2d 00 ff ff ff ff  ).....+. ..-.....
0050  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
0060  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
0070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
0080  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
0090  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
00a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
00b0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
00c0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
00d0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
00e0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
00f0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
0100  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
0110  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ........ ........
0120  ff ff ff ff ff ff 2f 00  07 00 0d 00 1a 24 3c 31  ....../. .....$&lt;1
0130  3e 00 1b 3d 25 70 31 25  7b 33 32 7d 25 2b 25 63  &gt;..=%p1% {32}%+%c
0140  25 70 32 25 7b 33 32 7d  25 2b 25 63 00 0a 00 1e  %p2%{32} %+%c....
0150  00 08 00 0c 00 0b 00 0a  00                       ........ .\s+2
.NE


<a name="limits"></a>

# Limits

Some limitations:
.bP
total compiled entries cannot exceed 4096 bytes in the legacy format.
.bP
total compiled entries cannot exceed 32768 bytes in the extended format.
.bP
the name field cannot exceed 128 bytes.

<a name="files"></a>

# Files

/usr/share/terminfo/*/*	compiled terminal capability data base

<a name="see-also"></a>

# See Also

**curses**(3X), **terminfo**(5).

<a name="authors"></a>

# Authors

Thomas E. Dickey  
extended terminfo format for ncurses 5.0  
hashed database support for ncurses 5.6  
extended number support for ncurses 6.1

Eric S. Raymond  
documented legacy terminfo format, e.g., from pcurses.
