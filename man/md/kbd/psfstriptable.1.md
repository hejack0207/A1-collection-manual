# psfstriptable(1) - remove the embedded Unicode character table from a console font

25 Oct 1994

```
psfstriptable fontfile outfile
```

<a name="description"></a>

# Description

.IX "psfstriptable command" "" "\fLpsfstriptable command"  

**psfstriptable**
reads a .psf format console font from 
_fontfile_,
removes the embedded Unicode font table if there is one,
and writes the result to
_outfile_.
An input file name of "-" denotes standard input,
and an output file name of "-" denotes standard output.

<a name="see-also"></a>

# See Also

**setfont**(8),
**psfaddtable**(1),
**psfgettable**(1),
**psfxtable**(1)
