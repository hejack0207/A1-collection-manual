# psfgettable(1) - extract the embedded Unicode character table from a console font

25 Oct 1994

```
psfgettable fontfile [outfile]
```

<a name="description"></a>

# Description

.IX "psfgettable command" "" "\fLpsfgettable command"  

**psfgettable**
extracts the embedded Unicode character table from a .psf format
console font into a human readable ASCII file of the format used by
**psfaddtable**(1).
If the font file name is a single dash (-), the font is read from
standard input.

<a name="see-also"></a>

# See Also

**setfont**(8),
**psfaddtable**(1),
**psfstriptable**(1),
**psfxtable**(1)
