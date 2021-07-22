# setfont(8) - load EGA/VGA console screen font

"", 11 Feb 2001

```
setfont [-O font+umap.orig] [-o font.orig] [-om cmap.orig] [-ou umap.orig] [-N] [font.new ...] [-m cmap] [-u umap] [-C console] [-hH] [-v] [-V] .IX "setfont command" "" "\fLsetfont command"
```

<a name="description"></a>

# Description

The
**setfont**
command reads a font from the file
_font.new_
and loads it into the EGA/VGA character generator,
and optionally outputs the previous font.
It can also load various mapping tables
and output the previous versions.

If no args are given (or only the option
-_N_
for some number
_N_),
then a default
(8x_N_)
font is loaded (see below).
One may give several small fonts, all containing
a Unicode table, and
**setfont**
will combine them and load the union.
Typical use:

* **setfont**  
  Load a default font.
* **setfont drdos8x16**  
  Load a given font (here the 448-glyph drdos font).
* **setfont cybercafe -u cybercafe**  
  Load a given font that does not have a Unicode map
  and provide one explicitly.
* **setfont LatArCyrHeb-19 -m 8859-2**  
  Load a given font (here a 512-glyph font combining several
  character sets) and indicate that one's local character set
  is ISO 8859-2.

Note: if a font has more than 256 glyphs, only 8 out of 16 colors
can be used simultaneously. It can make console perception worse
(loss of intensity and even some colors).


<a name="font-formats"></a>

# Font Formats

The standard Linux font format is the PSF font.
It has a header describing font properties like character size,
followed by the glyph bitmaps, optionally followed by a Unicode mapping
table giving the Unicode value for each glyph.
Several other (obsolete) font formats are recognized.
If the input file has code page format (probably with suffix .cp),
containing three fonts with sizes e.g. 8x8, 8x14 and 8x16, then one of
the options -8 or -14 or -16 must be used to select one.
Raw font files are binary files of size
256*_N_
bytes, containing bit images for each of 256 characters,
one byte per scan line, and
_N_
bytes per character (0 &lt; 
_N_
&lt;= 32).
Most fonts have a width of 8 bits, but with the framebuffer device (fb)
other widths can be used.


<a name="font-height"></a>

# Font Height

The program
**setfont**
has no built-in knowledge of VGA video modes, but just asks
the kernel to load the character ROM of the video card with
certain bitmaps. However, since Linux 1.3.1 the kernel knows
enough about EGA/VGA video modes to select a different line
distance. The default character height will be the number
_N_
inferred from the font or specified by option. However, the
user can specify a different character height
_H_
using the
_-h_
option.


<a name="console-maps"></a>

# Console Maps

Several mappings are involved in the path from user program
output to console display. If the console is in utf8 mode (see
**unicode_start**(1))
then the kernel expects that user program output is coded as UTF-8 (see
**utf-8**(7)),
and converts that to Unicode (ucs2).
Otherwise, a translation table is used from the 8-bit program output
to 16-bit Unicode values. Such a translation table is called a
_Unicode console map_.
There are four of them: three built into the kernel, the fourth
settable using the
_-m_
option of
**setfont**.
An escape sequence chooses between these four tables; after loading a
_cmap_,
**setfont**
will output the escape sequence Esc ( K that makes it the active translation.

Suitable arguments for the
_-m_
option are for example
_8859-1_,
_8859-2_, ...,
_8859-15_,
_cp437_, ...,
_cp1250_.

Given the Unicode value of the symbol to be displayed, the kernel
finds the right glyph in the font using the Unicode mapping info
of the font and displays it.

Old fonts do not have Unicode mapping info, and in order to handle
them there are direct-to-font maps (also loaded using
_-m_)
that give a correspondence between user bytes and font positions.
The most common correspondence is the one given in the file
_trivial_
(where user byte values are used directly as font positions).
Other correspondences are sometimes preferable since the
PC video hardware expects line drawing characters in certain
font positions.

Giving a
_-m none_
argument inhibits the loading and activation of a mapping table.
The previous console map can be saved to a file using the
_-om file_
option.
These options of setfont render
**mapscrn**(8)
obsolete. (However, it may be useful to read that man page.)


<a name="unicode-font-maps"></a>

# Unicode Font Maps

The correspondence between the glyphs in the font and
Unicode values is described by a Unicode mapping table.
Many fonts have a Unicode mapping table included in
the font file, and an explicit table can be indicated using
the
_-u_
option. The program
**setfont**
will load such a Unicode mapping table, unless a
_-u none_
argument is given. The previous Unicode mapping table
will be saved as part of the saved font file when the -O
option is used. It can be saved to a separate file using the
_-ou file_
option.
These options of setfont render
**loadunimap**(8)
obsolete.

The Unicode mapping table should assign some glyph to
the \`missing character' value U+fffd, otherwise missing
characters are not translated, giving a usually very confusing
result.

Usually no mapping table is needed, and a Unicode mapping table
is already contained in the font (sometimes this is indicated
by the .psfu extension), so that most users need not worry
about the precise meaning and functioning of these mapping tables.

One may add a Unicode mapping table to a psf font using
**psfaddtable**(1).


<a name="options"></a>

# Options


* **-h **_H_  
  Override font height.
* **-m **_file_  
  Load console map or Unicode console map from
  _file_.
* **-o **_file_  
  Save previous font in
  _file_.
* **-O **_file_  
  Save previous font and Unicode map in
  _file_.
* **-om **_file_  
  Store console map in
  _file_.
* **-ou **_file_  
  Save previous Unicode map in
  _file_.
* **-u **_file_  
  Load Unicode table describing the font from
  _file_.
* **-C **_console_  
  Set the font for the indicated console. (May require root permissions.)
* **-v**  
  Be verbose.
* **-V**  
  Print version and exit.
  

<a name="note"></a>

# Note

PC video hardware allows one to use the "intensity" bit
either to indicate brightness, or to address 512 (instead of 256)
glyphs in the font. So, if the font has more than 256 glyphs,
the console will be reduced to 8 (instead of 16) colors.


<a name="files"></a>

# Files

_/lib/kbd/consolefonts_
is the default font directory.
_/lib/kbd/unimaps_
is the default directory for Unicode maps.
_/lib/kbd/consoletrans_
is the default directory for screen mappings.
The default font is a file
_default_
(or
_default8x_N
if the -N option was given for some number N)
perhaps with suitable extension (like .psf).

<a name="see-also"></a>

# See Also

**psfaddtable**(1),
**unicode_start**(1),
**loadunimap**(8),
**utf-8**(7),
**mapscrn**(8)




