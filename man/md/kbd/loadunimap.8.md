# loadunimap(8) - load the kernel unicode-to-font mapping table

2004-01-01

```
loadunimap [ -C console ] [ -o oldmap ] [ map ]
```

<a name="description"></a>

# Description

The
**loadunimap**
command is obsolete - its function is now built-in into setfont.
However, for backwards compatibility it is still available
as a separate command.

The program
**loadunimap**
loads the specified map in the kernel unicode-to-font mapping table.
If no map is given
_def_
is assumed.
The default extension (that can be omitted) is
_.uni_.

If the
**-o**
_oldmap_
option is given, the old map is saved in the file specified.

On Linux 2.6.1 and later one can specify the console device using the
**-C**
option.

Usually one does not call
**loadunimap**
directly - its function is also built into
**setfont**.

<a name="files"></a>

# Files

_/lib/kbd/unimaps_
is the default directory for unicode mappings.

<a name="see-also"></a>

# See Also

**mapscrn**(8),
**setfont**(8)

