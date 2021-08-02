# column(1) - columnate lists

util-linux, February 2019

```
column [options] [file...]
```

<a name="description"></a>

# Description

The
**column**
utility formats its input into multiple columns.  The util support three modes:

* **columns are filled before rows**  
  This is the default mode (required by backward compatibility).
* **rows are filled before columns**  
  This mode is enabled by option **-x, --fillrows**
* **table**  
  Determine the number of columns the input contains and create a table.  This
  mode is enabled by option **-t, --table** and columns formatting is
  possible to modify by **--table-*** options.  Use this mode if not sure.

Input is taken from _file_, or otherwise from standard input.  Empty lines
are ignored and all invalid multibyte sequences are encoded by \\x&lt;hex&gt; convention.


<a name="options"></a>

# Options

The argument _columns_ for **--table-*** options is comma separated
list of the column names as defined by **--table-columns** or it's column
number in order as specified by input. It's possible to mix names and numbers.


* **-J, --json**  
  Use JSON output format to print the table, the option
  **--table-columns** is required and the option **--table-name** is recommended.
* **-c, --output-width** _width_  
  Output is formatted to a width specified as number of characters. The original
  name of this option is --columns; this name is deprecated since v2.30. Note that input
  longer than _width_ is not truncated by default.
* **-d, --table-noheadings**  
  Do not print header. This option allows to use logical column names on command line, but keep the header hidden when print the table.
* **-o, --output-separator** _string_  
  Specify the columns delimiter for table output (default is two spaces).
* **-s, --separator** _separators_  
  Specify the possible input item delimiters (default is whitespace).
* **-t, --table**  
  Determine the number of columns the input contains and create a table.
  Columns are delimited with whitespace, by default, or with the characters
  supplied using the **--output-separator** option.
  Table output is useful for pretty-printing.
* **-N, --table-columns** _names_  
  Specify the columns names by comma separated list of names. The names are used
  for the table header or to address column in option arguments.
* **-R, --table-right** _columns_  
  Right align text in the specified columns.
* **-T, --table-truncate** _columns_  
  Specify columns where is allowed to truncate text when necessary, otherwise
  very long table entries may be printed on multiple lines.
* **-E, --table-noextreme** _columns_  
  Specify columns where is possible to ignore unusually long (longer than
  average) cells when calculate column width.  The option has impact to the width
  calculation and table formatting, but the printed text is not affected.
  
  The option is used for the last visible column by default.
  
* **-e, --table-header-repeat**  
  Print header line for each page.
* **-W, --table-wrap** _columns_  
  Specify columns where is possible to use multi-line cell for long text when
  necessary.
* **-H, --table-hide** _columns_  
  Don't print specified columns. The special placeholder '-' maybe be used to
  hide all unnamed columns (see --table-columns).
* **-O, --table-order** _columns_  
  Specify columns order on output.
* **-n, --table-name** _name_  
  Specify the table name used for JSON output. The default is "table".
* **-L, --table-empty-lines**  
  Insert empty line to the table for each empty line on input. The default
  is ignore empty lines at all.
* **-r, --tree** _column_  
  Specify column to use tree-like output. Note that the circular dependencies and
  another anomalies in child and parent relation are silently ignored.
* **-i, --tree-id** _column_  
  Specify column with line ID to create child-parent relation.
* **-p, --tree-parent** _column_  
  Specify column with parent ID to create child-parent relation.


* **-x, --fillrows**  
  Fill rows before filling columns.
* **-V**, **--version**  
  Display version information and exit.
* **-h, --help**  
  Display help text and exit.

<a name="environment"></a>

# Environment

The environment variable **COLUMNS** is used to determine the size of
the screen if no other information is available.

<a name="examples"></a>

# Examples

Print fstab with header line and align number to the right:
.EX
**sed 's/#.*//' /etc/fstab | column --table --table-columns SOURCE,TARGET,TYPE,OPTIONS,PASS,FREQ --table-right PASS,FREQ**
.EE

Print fstab and hide unnamed columns:
.EX
**sed 's/#.*//' /etc/fstab | column --table --table-columns SOURCE,TARGET,TYPE --table-hide -**
.EE



Print a tree:
.EX
**echo -e '1 0 A\\n2 1 AA\\n3 1 AB\\n4 2 AAA\\n5 2 AAB' | column --tree-id 1 --tree-parent 2 --tree 3**
1  0  A
2  1  |-AA
4  2  | |-AAA
5  2  | \`-AAB
3  1  \`-AB
.EE

<a name="bugs"></a>

# Bugs

Version 2.23 changed the
**-s**
option to be non-greedy, for example:

.EX
**printf "a:b:c\\n1::3\\n" | column  -t -s ':'**
.EE

Old output:
.EX
a  b  c
1  3
.EE

New output (since util-linux 2.23):
.EX
a  b  c
1     3
.EE

Historical versions of this tool indicated that "rows are filled before
columns" by default, and that the
**-x**
option reverses this. This wording did not reflect the actual behavior, and it
has since been corrected (see above). Other implementations of
**column**
may continue to use the older documentation, but the behavior should be
identical in any case.

<a name="see-also"></a>

# See Also

**colrm**(1),
**ls**(1),
**paste**(1),
**sort**(1)

<a name="history"></a>

# History

The column command appeared in 4.3BSD-Reno.

<a name="availability"></a>

# Availability

The column command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
