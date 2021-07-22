# psfxtable(1) - handle Unicode character tables for console fonts

9 Dec 1999

```
psfxtable [-i infont] [-o outfont] [-it intable] [-ot outtable] [-nt]
```

<a name="description"></a>

# Description

.IX "psfxtable command" "" "\fLpsfxtable command"  

**psfxtable**
handles the embedded Unicode character table for .psf format
console fonts. It reads a font and possibly a table
and writes a font and/or a table.
**psfaddtable**(1),
**psfgettable**(1)
and
**psfstriptable**(1)
are links to it.

Each of the filenames
_infont_,
_outfont_,
_intable_,
and
_outtable_
may be replaced by a single dash (-), in which case
standard input or standard output is used.
If no -i option is given, the font is read from standard input.
If no -it or -o or -ot option is given,
no input table is read or no output font or output table is written.

By default the output font (if any) will have a Unicode table
when either the input font has one, or an explicit table
(which overrides an input font table) has been provided.
The option -nt causes output of a font without table.
When
_outfont_
is requested it will get a psf1 header when infont has
a psf1 header and
_intable_
does not have sequences and a psf2 header otherwise.

<a name="see-also"></a>

# See Also

**setfont**(8),
**psfaddtable**(1),
**psfgettable**(1),
**psfstriptable**(1)
