# git\-column(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-column - Display data in columns

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git column [--command=<name>] [--[raw-]mode=<mode>] [--width=<width>]
                 [--indent=<string>] [--nl=<string>] [--padding=<n>]
<synopsis>


```

<a name="description"></a>

# Description


This command formats the lines of its standard input into a table with multiple columns. Each input line occupies one cell of the table. It is used internally by other git commands to format output into columns.

<a name="options"></a>

# Options


--command=&lt;name&gt;
Look up layout mode using configuration variable column.&lt;name&gt; and column.ui.

--mode=&lt;mode&gt;
Specify layout mode. See configuration variable column.ui for option syntax in
**git-config**(1).

--raw-mode=&lt;n&gt;
Same as --mode but take mode encoded as a number. This is mainly used by other commands that have already parsed layout mode.

--width=&lt;width&gt;
Specify the terminal width. By default
_git column_
will detect the terminal width, or fall back to 80 if it is unable to do so.

--indent=&lt;string&gt;
String to be printed at the beginning of each line.

--nl=&lt;N&gt;
String to be printed at the end of each line, including newline character.

--padding=&lt;N&gt;
The number of spaces between columns. One space by default.

<a name="examples"></a>

# Examples


Format data by columns:

.if n \{.RS 4
.\}
    $ seq 1 24 | git column --mode=column --padding=5
    1      4      7      10     13     16     19     22
    2      5      8      11     14     17     20     23
    3      6      9      12     15     18     21     24
.if n \{.RE
.\}


Format data by rows:

.if n \{.RS 4
.\}
    $ seq 1 21 | git column --mode=row --padding=5
    1      2      3      4      5      6      7
    8      9      10     11     12     13     14
    15     16     17     18     19     20     21
.if n \{.RE
.\}


List some tags in a table with unequal column widths:

.if n \{.RS 4
.\}
    $ git tag --list 'v2.4.*' --column=row,dense
    v2.4.0  v2.4.0-rc0  v2.4.0-rc1  v2.4.0-rc2  v2.4.0-rc3
    v2.4.1  v2.4.10     v2.4.11     v2.4.12     v2.4.2
    v2.4.3  v2.4.4      v2.4.5      v2.4.6      v2.4.7
    v2.4.8  v2.4.9
.if n \{.RE
.\}


<a name="git"></a>

# Git


Part of the **git**(1) suite
