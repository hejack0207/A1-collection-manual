# pr(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

pr
— print files

<a name="synopsis"></a>

# Synopsis

```


```
    pr [+page] [(micolumn] [(miadFmrt] [(mie[char][gap]] [(mih header] [(mii[char][gap]]
        [(mil lines] [(min[char][width]] [(mio offset] [(mis[char]] [(miw width] [(mifp]
        [file...]

<a name="description"></a>

# Description

The
_pr_
utility is a printing and pagination filter. If multiple input files
are specified, each shall be read, formatted, and written to standard
output. By default, the input shall be separated into 66-line pages,
each with:

*  *  
  A 5-line header that includes the page number, date, time, and
  the pathname of the file
*  *  
  A 5-line trailer consisting of blank lines

If standard output is associated with a terminal, diagnostic messages
shall be deferred until the
_pr_
utility has completed processing.

When options specifying multi-column output are specified, output text
columns shall be of equal width; input lines that do not fit into a
text column shall be truncated. By default, text columns shall be
separated with at least one
&lt;blank&gt;.

<a name="options"></a>

# Options

The
_pr_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that: the
_page_
option has a
**'\(pl'**
delimiter;
_page_
and
_column_
can be multi-digit numbers; some of the option-arguments are optional;
and some of the option-arguments cannot be specified as separate
arguments from the preceding option letter. In particular, the
**\(mis**
option does not allow the option letter to be separated from its
argument, and the options
**\(mie**,
**\(mii**,
and
**\(min**
require that both arguments, if present, not be separated from the
option letter.

The following options shall be supported. In the following option
descriptions,
_column_,
_lines_,
_offset_,
_page_,
and
_width_
are positive decimal integers;
_gap_
is a non-negative decimal integer.

* **+page**  
  Begin output at page number
  _page_
  of the formatted input.
* **\(micolumn**  
  Produce multi-column output that is arranged in
  _column_
  columns (the default shall be 1) and is written down each column in the
  order in which the text is received from the input file. This option
  should not be used with
  **\(mim**.
  The options
  **\(mie**
  and
  **\(mii**
  shall be assumed for multiple text-column output. Whether or not text
  columns are produced with identical vertical lengths is unspecified,
  but a text column shall never exceed the length of the page (see the
  **\(mil**
  option). When used with
  **\(mit**,
  use the minimum number of lines to write the output.
* **\(mia**  
  Modify the effect of the
  **\(mi**\c
  _column_
  option so that the columns are filled across the page in a round-robin
  order (for example, when
  _column_
  is 2, the first input line heads column 1, the second heads column 2,
  the third is the second line in column 1, and so on).
* **\(mid**  
  Produce output that is double-spaced; append an extra
  &lt;newline&gt;
  following every
  &lt;newline&gt;
  found in the input.
* **\(mie[char][gap]**    
  Expand each input
  &lt;tab&gt;
  to the next greater column position specified by the formula
  _n_*\c
  _gap_+1,
  where
  _n_
  is an integer &gt; 0. If
  _gap_
  is zero or is omitted, it shall default to 8. All
  &lt;tab&gt;
  characters in the input shall be expanded into the appropriate number of
  &lt;space&gt;
  characters. If any non-digit character,
  _char_,
  is specified, it shall be used as the input
  &lt;tab&gt;.
  If the first character of the
  **\(mie**
  option-argument is a digit, the entire option-argument shall be assumed
  to be
  _gap_.
* **\(mif**  
  Use a
  &lt;form-feed&gt;
  for new pages, instead of the default behavior that uses a sequence of
  &lt;newline&gt;
  characters. Pause before beginning the first page if the standard output
  is associated with a terminal.
* **\(miF**  
  Use a
  &lt;form-feed&gt;
  for new pages, instead of the default behavior that uses a sequence of
  &lt;newline&gt;
  characters.
* **\(mih&nbsp;header**  
  Use the string
  _header_
  to replace the contents of the
  _file_
  operand in the page header.
* **\(mii[char][gap]**  
  In output, replace
  &lt;space&gt;
  characters with
  &lt;tab&gt;
  characters wherever one or more adjacent
  &lt;space&gt;
  characters reach column positions
  _gap_+1,
  2*
  _gap_+1,
  3*
  _gap_+1,
  and so on. If
  _gap_
  is zero or is omitted, default tab settings at every eighth column
  position shall be assumed. If any non-digit character,
  _char_,
  is specified, it shall be used as the output
  &lt;tab&gt;.
  If the first character of the
  **\(mii**
  option-argument is a digit, the entire option-argument shall be assumed
  to be
  _gap_.
* **\(mil&nbsp;lines**  
  Override the 66-line default and reset the page length to
  _lines_.
  If
  _lines_
  is not greater than the sum of both the header and trailer depths (in
  lines), the
  _pr_
  utility shall suppress both the header and trailer, as if the
  **\(mit**
  option were in effect.
* **\(mim**  
  Merge files. Standard output shall be formatted so the
  _pr_
  utility writes one line from each file specified by a
  _file_
  operand, side by side into text columns of equal fixed widths, in terms
  of the number of column positions. Implementations shall support
  merging of at least nine
  _file_
  operands.
* **\(min[char][width]**    
  Provide
  _width_-digit
  line numbering (default for
  _width_
  shall be 5). The number shall occupy the first
  _width_
  column positions of each text column of default output or each line of
  **\(mim**
  output. If
  _char_
  (any non-digit character) is given, it shall be appended to the line
  number to separate it from whatever follows (default for
  _char_
  is a
  &lt;tab&gt;).
* **\(mio&nbsp;offset**  
  Each line of output shall be preceded by offset
  &lt;space&gt;
  characters. If the
  **\(mio**
  option is not specified, the default offset shall be zero. The space
  taken is in addition to the output line width (see the
  **\(miw**
  option below).
* **\(mip**  
  Pause before beginning each page if the standard output is directed to
  a terminal (\c
  _pr_
  shall write an
  &lt;alert&gt;
  to standard error and wait for a
  &lt;carriage-return&gt;
  to be read on
  **/dev/tty**).
* **\(mir**  
  Write no diagnostic reports on failure to open files.
* **\(mis[char]**  
  Separate text columns by the single character
  _char_
  instead of by the appropriate number of
  &lt;space&gt;
  characters (default for
  _char_
  shall be
  &lt;tab&gt;).
* **\(mit**  
  Write neither the five-line identifying header nor the five-line
  trailer usually supplied for each page. Quit writing after the last
  line of each file without spacing to the end of the page.
* **\(miw&nbsp;width**  
  Set the width of the line to
  _width_
  column positions for multiple text-column output only. If the
  **\(miw**
  option is not specified and the
  **\(mis**
  option is not specified, the default width shall be 72. If the
  **\(miw**
  option is not specified and the
  **\(mis**
  option is specified, the default width shall be 512.

For single column output, input lines shall not be truncated.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a file to be written. If no
  _file_
  operands are specified, or if a
  _file_
  operand is
  **'\(mi'**,
  the standard input shall be used.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if no
_file_
operands are specified, or if a
_file_
operand is
**'\(mi'**.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files.

The file
**/dev/tty**
shall be used to read responses required by the
**\(mip**
option.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_pr_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  the precedence of internationalization variables used to determine the
  values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and which
  characters are defined as printable (character class
  **print**).
  Non-printable characters are still written to standard output, but are
  not counted for the purpose for column-width and line-length
  calculations.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _LC\_TIME_  
  Determine the format of the date and time for use in writing header
  lines.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TZ_  
  Determine the timezone used to calculate date and time strings written
  in header lines. If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

If
_pr_
receives an interrupt while writing to a terminal, it shall flush all
accumulated error messages to the screen before terminating.

<a name="stdout"></a>

# Stdout

The
_pr_
utility output shall be a paginated version of the original file (or
files). This pagination shall be accomplished using either
&lt;form-feed&gt;
characters or a sequence of
&lt;newline&gt;
characters, as controlled by the
**\(miF**
or
**\(mif**
option. Page headers shall be generated unless the
**\(mit**
option is specified. The page headers shall be of the form:

    
    "enen%s %s Page %denenen", <output of date>, <file>, <page number>


In the POSIX locale, the &lt;_output&nbsp;of&nbsp;date_&gt; field, representing
the date and time of last modification of the input file (or the
current date and time if the input file is standard input), shall be
equivalent to the output of the following command as it would appear if
executed at the given time:

    
    date "+%b %e %H:%M %Y"


without the trailing
&lt;newline&gt;,
if the page being written is from standard input. If the page being
written is not from standard input, in the POSIX locale, the same
format shall be used, but the time used shall be the modification time
of the file corresponding to
_file_
instead of the current time. When the
_LC_TIME_
locale category is not set to the POSIX locale, a different format and
order of presentation of this field may be used.

If the standard input is used instead of a
_file_
operand, the &lt;_file_&gt; field shall be replaced by a null string.

If the
**\(mih**
option is specified, the &lt;_file_&gt; field shall be replaced by the
_header_
argument.

<a name="stderr"></a>

# Stderr

The standard error shall be used for diagnostic messages and
for alerting the terminal when
**\(mip**
is specified.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

A conforming application must protect its first operand, if it starts
with a
&lt;plus-sign&gt;,
by preceding it with the
**"\(mi\|\(mi"**
argument that denotes the end of the options. For example,
_pr_\(pl\c
_x_
could be interpreted as an invalid page number or a
_file_
operand.

<a name="examples"></a>

# Examples


*  1.  
  Print a numbered list of all files in the current directory:

    
    ls (mia | pr (min (mih "Files in $(pwd)."


*  2.  
  Print
  **file1**
  and
  **file2**
  as a double-spaced, three-column listing headed by \`\`file list'':

    
    pr (mi3d (mih "file list" file1 file2


*  3.  
  Write
  **file1**
  on
  **file2**,
  expanding tabs to columns 10, 19, 28, .\|.\|.:

    
    pr (mie9 (mit <file1 >file2


<a name="rationale"></a>

# Rationale

This utility is one of those that does not follow the Utility Syntax
Guidelines because of its historical origins. The standard developers
could have added new options that obeyed the guidelines (and marked the
old options obsolescent) or devised an entirely new utility; there are
examples of both actions in this volume of POSIX.1-2008. Because of its widespread use by
historical applications, the standard developers decided to exempt this
version of
_pr_
from many of the guidelines.

Implementations are required to accept option-arguments to the
**\(mih**,
**\(mil**,
**\(mio**,
and
**\(miw**
options whether presented as part of the same argument or as a separate
argument to
_pr_,
as suggested by the Utility Syntax Guidelines. The
**\(min**
and
**\(mis**
options, however, are specified as in historical practice because they
are frequently specified without their optional arguments. If a
&lt;blank&gt;
were allowed before the option-argument in these cases, a
_file_
operand could mistakenly be interpreted as an option-argument in
historical applications.

The text about the minimum number of lines in multi-column output was
included to ensure that a best effort is made in balancing the length
of the columns. There are known historical implementations in which,
for example, 60-line files are listed by
_pr_
\(mi2 as one column of 56 lines and a second of 4. Although this is not
a problem when a full page with headers and trailers is produced, it
would be relatively useless when used with
**\(mit**.

Historical implementations of the
_pr_
utility have differed in the action taken for the
**\(mif**
option. BSD uses it as described here for the
**\(miF**
option; System V uses it to change trailing
&lt;newline&gt;
characters on each page to a
&lt;form-feed&gt;
and, if standard output is a TTY device, sends an
&lt;alert&gt;
to standard error and reads a line from
**/dev/tty**
before the first page. There were strong arguments from both sides of
this issue concerning historical practice and as a result the
**\(miF**
option was added. XSI-conformant systems support the System V
historical actions for the
**\(mif**
option.

The &lt;_output&nbsp;of&nbsp;date_&gt; field in the
**\(mil**
format is specified only for the POSIX locale. As noted, the format can
be different in other locales. No mechanism for defining this is
present in this volume of POSIX.1-2008, as the appropriate vehicle is a message catalog;
that is, the format should be specified as a \`\`message''.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__expand_\^_,
__lp_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

<a name="copyright"></a>

# Copyright

Portions of this text are reprinted and reproduced in electronic form
from IEEE Std 1003.1, 2013 Edition, Standard for Information Technology
-- Portable Operating System Interface (POSIX), The Open Group Base
Specifications Issue 7, Copyright (C) 2013 by the Institute of
Electrical and Electronics Engineers, Inc and The Open Group.
(This is POSIX.1-2008 with the 2013 Technical Corrigendum 1 applied.) In the
event of any discrepancy between this version and the original IEEE and
The Open Group Standard, the original IEEE and The Open Group Standard
is the referee document. The original Standard can be obtained online at
http://www.unix.org/online.html .

Any typographical or formatting errors that appear
in this page are most likely
to have been introduced during the conversion of the source files to
man page format. To report such errors, see
https://www.kernel.org/doc/man-pages/reporting_bugs.html .
