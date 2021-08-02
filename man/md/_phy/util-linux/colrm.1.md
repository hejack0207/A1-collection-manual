# colrm(1) - remove columns from a file

util-linux, September 2011

```
colrm [first&nbsp;[last]]
```

<a name="description"></a>

# Description

**colrm**
removes selected columns from a file.  Input is taken from standard input.
Output is sent to standard output.

If called with one parameter the columns of each line will be removed
starting with the specified
_first_
column.  If called with two parameters the columns from the
_first_
column to the
_last_
column will be removed.

Column numbering starts with column 1.

<a name="options"></a>

# Options


* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="see-also"></a>

# See Also

**awk**(1),
**column**(1),
**expand**(1),
**paste**(1)

<a name="history"></a>

# History

The
**colrm**
command appeared in 3.0BSD.

<a name="availability"></a>

# Availability

The colrm command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
