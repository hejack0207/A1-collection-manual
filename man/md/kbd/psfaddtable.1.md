# psfaddtable(1) - add a Unicode character table to a console font

25 Oct 1994

```
psfaddtable fontfile tablefile outfile
```

<a name="description"></a>

# Description

.IX "psfaddtable command" "" "\fLpsfaddtable command"  

**psfaddtable**
takes a console font in .psf format given by
_fontfile_
and merges it with the Unicode character table given by
_tablefile_
to produce a font file with an embedded character table, which is
written to
_outfile_.
An input file name of "-" denotes standard input,
and an output file name of "-" denotes standard output.
If the
_fontfile_
already contains an embedded character table, it is ignored.

<a name="table-file-format"></a>

# Table File Format

Each line in the
_tablefile_
should be either blank, contain a comment (preceded by
_#_),
or contain a sequence of numbers in either decimal (default), octal
(preceded by
_0_),
or hexadecimal (preceded by
_0x_)
format, separated by spaces or tabs.
The first number on each line indicates the glyph slot in the
font that is being referred to, this is between 0 and 0xff for a
256-character font and 0 and 0x1ff for a 512-character font.  Any
subsequent numbers on the same line are Unicodes matched by this
specific glyph slot.  Instead of a single Unicode one may have
a sequence of Unicodes separates by commas, to denote that the
glyph depicts the corresponding composed symbol.
It is permissible to have multiple lines for the same glyph.

<a name="see-also"></a>

# See Also

**setfont**(8),
**psfgettable**(1),
**psfstriptable**(1),
**psfxtable**(1)
