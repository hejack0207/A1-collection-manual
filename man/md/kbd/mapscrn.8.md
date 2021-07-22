# mapscrn(8) - load screen output mapping table

Local, 20 March 1993

```
mapscrn [-V] [-v] [-o map.orig] mapfile
```

<a name="description"></a>

# Description

The
**mapscrn**
command is obsolete - its function is now built-in into setfont.
However, for backwards compatibility it is still available
as a separate command.

The
_mapscrn_
command loads a user defined output character mapping table into the
console driver. The console driver may be later put into
**use user-defined mapping table**
mode by outputting a special escape sequence to the console device.
This sequence is
_&lt;esc&gt;(K_
for the
**G0**
character set and
_&lt;esc&gt;)K_
for the
**G1**
character set.
When the
_-o_
option is given, the old map is saved in
_map.orig._

<a name="use"></a>

# Use

There are two kinds of mapping tables: direct-to-font tables,
that give a font position for each user byte value, and user-to-unicode
tables that give a unicode value for each user byte. The corresponding
glyph is now found using the unicode index of the font.
The command
mapscrn trivial
sets up a one-to-one direct-to-font table where user bytes
directly address the font. This is useful for fonts that are
in the same order as the character set one uses.
A command like
mapscrn 8859-2
sets up a user-to-unicode table that assumes that the user
uses ISO 8859-2.

<a name="input-format"></a>

# Input Format

The
_mapscrn_
command can read the map in either of two formats:  
1. 256 or 512 bytes binary data  
2. two-column text file  
Format (1) is a direct image of the translation 
_table. The 256-bytes tables are direct-to-font,_
the 512-bytes tables are user-to-unicode tables.
Format (2) is used to fill the 
_table_
as follows: cell with offset mentioned in the first column is filled
with the value mentioned in the second column.
When values larger than 255 occur, or values are written using
the U+xxxx notation, the table is assumed to be a user-to-unicode
table, otherwise it is a direct-to-font table.

Values in the file may be specified in one of several
**formats:**  
**1. Decimal:**
String of decimal digits not starting with '0'  
**2. Octal:**
String of octal digits beginning with '0'.  
**3. Hexadecimal:**
String of hexadecimal digits preceded by "0x".  
**4. Unicode:**
String of four hexadecimal digits preceded by "U+".  
**5. Character:**
Single character enclosed in single quotes. (And the binary value is used.)
Note that blank, comma, tab character and '#' cannot be specified
with this format.  
**6. UTF-8 Character:**
Single (possibly multi-byte) UTF-8 character, enclosed in single quotes.

Note that control characters (with codes &lt; 32) cannot be re-mapped with
_mapscrn_
because they have special meaning for the driver.

<a name="other-options"></a>

# Other Options


* **-V**  
  Prints version number and exits.
* **-v**  
  Be verbose.

<a name="files"></a>

# Files

_/lib/kbd/consoletrans_
is the default directory for screen mappings.

<a name="see-also"></a>

# See Also

_setfont_(8)

<a name="author"></a>

# Author

Copyright (C) 1993 Eugene G. Crosser  
&lt;[crosser@pccross.msk](mailto:crosser@pccross.msk).su&gt;  
This software and documentation may be distributed freely.
