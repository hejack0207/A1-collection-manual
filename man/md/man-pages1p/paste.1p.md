# paste(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

paste
— merge corresponding or subsequent lines of files

<a name="synopsis"></a>

# Synopsis

```


```
    paste [(mis] [(mid list] file...

<a name="description"></a>

# Description

The
_paste_
utility shall concatenate the corresponding lines of the given input
files, and write the resulting lines to standard output.

The default operation of
_paste_
shall concatenate the corresponding lines of the input files. The
&lt;newline&gt;
of every line except the line from the last input file shall be
replaced with a
&lt;tab&gt;.

If an end-of-file condition is detected on one or more input files, but
not all input files,
_paste_
shall behave as though empty lines were read from the files on which
end-of-file was detected, unless the
**\(mis**
option is specified.

<a name="options"></a>

# Options

The
_paste_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mid&nbsp;list**  
  Unless a
  &lt;backslash&gt;
  character appears in
  _list_,
  each character in
  _list_
  is an element specifying a delimiter character. If a
  &lt;backslash&gt;
  character appears in
  _list_,
  the
  &lt;backslash&gt;
  character and one or more characters following it are an element
  specifying a delimiter character as described below. These elements
  specify one or more delimiters to use, instead of the default
  &lt;tab&gt;,
  to replace the
  &lt;newline&gt;
  of the input lines. The elements in
  _list_
  shall be used circularly; that is, when the list is exhausted the first
  element from the list is reused. When the
  **\(mis**
  option is specified:
    *  *  
      The last
      &lt;newline&gt;
      in a file shall not be modified.
    *  *  
      The delimiter shall be reset to the first element of
      _list_
      after each
      _file_
      operand is processed.

When the
**\(mis**
option is not specified:

*  *  
  The
  &lt;newline&gt;
  characters in the file specified by the last
  _file_
  operand shall not be modified.
*  *  
  The delimiter shall be reset to the first element of list each time a
  line is processed from each file.

If a
&lt;backslash&gt;
character appears in
_list_,
it and the character following it shall be used to represent the
following delimiter characters:

* \en  
  &lt;newline&gt;.
* \et  
  &lt;tab&gt;.
* \e\e  
  &lt;backslash&gt;
  character.
* \e0  
  Empty string (not a null character). If
  **'\e0'**
  is immediately followed by the character
  **'x'**,
  the character
  **'X'**,
  or any character defined by the
  _LC_CTYPE_
  **digit**
  keyword (see the Base Definitions volume of POSIX.1-2008,
  _Chapter 7_, _Locale_),
  the results are unspecified.

If any other characters follow the
&lt;backslash&gt;,
the results are unspecified.

* **\(mis**  
  Concatenate all of the lines of each separate input file in command
  line order. The
  &lt;newline&gt;
  of every line except the last line in each input file shall be replaced
  with the
  &lt;tab&gt;,
  unless otherwise specified by the
  **\(mid**
  option.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of an input file. If
  **'\(mi'**
  is specified for one or more of the
  _file_s,
  the standard input shall be used; the standard input shall be read one
  line at a time, circularly, for each instance of
  **'\(mi'**.
  Implementations shall support pasting of at least 12
  _file_
  operands.

<a name="stdin"></a>

# Stdin

The standard input shall be used only if one or more
_file_
operands is
**'\(mi'**.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input files shall be text files, except that line lengths shall be
unlimited.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_paste_:

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
  multi-byte characters in arguments and input files).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Concatenated lines of input files shall be separated by the
&lt;tab&gt;
(or other characters under the control of the
**\(mid**
option) and terminated by a
&lt;newline&gt;.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

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

If one or more input files cannot be opened when the
**\(mis**
option is not specified, a diagnostic message shall be written to
standard error, but no output is written to standard output. If the
**\(mis**
option is specified, the
_paste_
utility shall provide the default behavior described in
_Section 1.4_, _Utility Description Defaults_.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

When the escape sequences of the
_list_
option-argument are used in a shell script, they must be quoted;
otherwise, the shell treats the
&lt;backslash&gt;
as a special character.

Conforming applications should only use the specific
&lt;backslash&gt;-escaped
delimiters presented in this volume of POSIX.1-2008. Historical implementations treat
**'\ex'**,
where
**'x'**
is not in this list, as
**'x'**,
but future implementations are free to expand this list to recognize
other common escapes similar to those accepted by
_printf_
and other standard utilities.

Most of the standard utilities work on text files. The
_cut_
utility can be used to turn files with arbitrary line lengths into a
set of text files containing the same data. The
_paste_
utility can be used to create (or recreate) files with arbitrary line
lengths. For example, if
_file_
contains long lines:

    
    cut (mib 1(mi500 (min file > file1
    cut (mib 501(mi (min file > file2


creates
**file1**
(a text file) with lines no longer than 500 bytes (plus the
&lt;newline&gt;)
and
**file2**
that contains the remainder of the data from
_file_.
Note that
**file2**
is not a text file if there are lines in
_file_
that are longer than 500 +
{LINE_MAX}
bytes. The original file can be recreated from
**file1**
and
**file2**
using the command:

    
    paste (mid "e0" file1 file2 > file


The commands:

    
    paste (mid "e0" ...
    paste (mid "" ...


are not necessarily equivalent; the latter is not specified by this volume of POSIX.1-2008
and may result in an error. The construct
**'\e0'**
is used to mean \`\`no separator'' because historical versions of
_paste_
did not follow the syntax guidelines, and the command:

    
    paste (mid"" ...


could not be handled properly by
_getopt_().

<a name="examples"></a>

# Examples


*  1.  
  Write out a directory in four columns:

    
    ls | paste (mi (mi (mi (mi


*  2.  
  Combine pairs of lines from a file into single lines:

    
    paste (mis (mid "eten" file


<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 1.4_, _Utility Description Defaults_,
__cut_\^_,
__grep_\^_,
__pr_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 7_, _Locale_,
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
