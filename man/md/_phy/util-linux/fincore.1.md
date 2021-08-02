# fincore(1) - count pages of file contents in core

util-linux, March 2017

```
fincore [options] file ...
```

<a name="description"></a>

# Description

**fincore**
counts pages of file contents being resident in memory (in core), and reports
the numbers.  If an error occurs during counting, then an error message is
printed to the stderr and
**fincore**
continues processing the rest of files listed in a command line.

The default output is subject to change.  So whenever possible, you should
avoid using default outputs in your scripts.  Always explicitly define expected
columns by using
**--output**
_columns-list_
in environments where a stable output is required.

<a name="options"></a>

# Options


* **-n**,** --noheadings**  
  Do not print a header line in status output.
* **-b**,** --bytes**  
  Print the SIZE column in bytes rather than in a human-readable format.
* **-o**,** --output _list_**  
  Define output columns.  See the **--help** output to get a list of the
  currently supported columns. The default list of columns may be extended if _list_ is
  specified in the format _+list_.
* **-r**,** --raw**  
  Produce output in raw format.  All potentially unsafe characters are hex-escaped
  (\\x&lt;code&gt;).
* **-J**,** --json**  
  Use JSON output format.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="authors"></a>

# Authors

.MT yamato@​redhat.com
Masatake YAMATO
.ME

<a name="see-also"></a>

# See Also

**mincore**(2),
**getpagesize**(2),
**getconf**(1)

<a name="availability"></a>

# Availability

The fincore command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
