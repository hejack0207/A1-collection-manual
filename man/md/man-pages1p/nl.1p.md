# nl(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

nl
— line numbering filter

<a name="synopsis"></a>

# Synopsis

```


```
    nl [(mip] [(mib type] [(mid delim] [(mif type] [(mih type] [(mii incr] [(mil num]
        [(min format] [(mis sep] [(miv startnum] [(miw width] [file]

<a name="description"></a>

# Description

The
_nl_
utility shall read lines from the named
_file_
or the standard input if no
_file_
is named and shall reproduce the lines to standard output. Lines shall
be numbered on the left. Additional functionality may be provided in
accordance with the command options in effect.

The
_nl_
utility views the text it reads in terms of logical pages. Line
numbering shall be reset at the start of each logical page. A logical
page consists of a header, a body, and a footer section. Empty sections
are valid. Different line numbering options are independently available
for header, body, and footer (for example, no numbering of header and
footer lines while numbering blank lines only in the body).

The starts of logical page sections shall be signaled by input lines
containing nothing but the following delimiter characters:
.TS
center box tab(@);
cB | cB
lw(1i)f5 | lw(1i).
Line@Start of
_
\e:\e:\e:@Header
\e:\e:@Body
\e:@Footer
.TE

Unless otherwise specified,
_nl_
shall assume the text being read is in a single logical page body.

<a name="options"></a>

# Options

The
_nl_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.
Only one file can be named.

The following options shall be supported:

* **\(mib&nbsp;type**  
  Specify which logical page body lines shall be numbered. Recognized
  _types_
  and their meaning are:
    * **a**  
      Number all lines.
    * **t**  
      Number only non-empty lines.
    * **n**  
      No line numbering.
    * **pstring**  
      Number only lines that contain the basic regular expression
      specified in
      _string_.

The default
_type_
for logical page body shall be
**t**
(text lines numbered).

* **\(mid&nbsp;delim**  
  Specify the delimiter characters that indicate the start of a logical
  page section. These can be changed from the default characters
  **"\e:"**
  to two user-specified characters. If only one character is entered,
  the second character shall remain the default character
  **':'**.
* **\(mif&nbsp;type**  
  Specify the same as
  **b**
  _type_
  except for footer. The default for logical page footer shall be
  **n**
  (no lines numbered).
* **\(mih&nbsp;type**  
  Specify the same as
  **b**
  _type_
  except for header. The default
  _type_
  for logical page header shall be
  **n**
  (no lines numbered).
* **\(mii&nbsp;incr**  
  Specify the increment value used to number logical page lines. The
  default shall be 1.
* **\(mil&nbsp;num**  
  Specify the number of blank lines to be considered as one. For
  example,
  **\(mil&nbsp;2**
  results in only the second adjacent blank line being numbered (if the
  appropriate
  **\(mih&nbsp;a**,
  **\(mib&nbsp;a**,
  or
  **\(mif&nbsp;a**
  option is set). The default shall be 1.
* **\(min&nbsp;format**  
  Specify the line numbering format. Recognized values are:
  **ln**,
  left justified, leading zeros suppressed;
  **rn**,
  right justified, leading zeros suppressed;
  **rz**,
  right justified, leading zeros kept. The default
  _format_
  shall be
  **rn**
  (right justified).
* **\(mip**  
  Specify that numbering should not be restarted at logical page
  delimiters.
* **\(mis&nbsp;sep**  
  Specify the characters used in separating the line number and the
  corresponding text line. The default
  _sep_
  shall be a
  &lt;tab&gt;.
* **\(miv&nbsp;startnum**  
  Specify the initial value used to number logical page lines. The
  default shall be 1.
* **\(miw&nbsp;width**  
  Specify the number of characters to be used for the line number. The
  default
  _width_
  shall be 6.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a text file to be line-numbered.

<a name="stdin"></a>

# Stdin

The standard input shall be used if no
_file_
operand is specified, and shall be used if the
_file_
operand is
**'\(mi'**
and the implementation treats the
**'\(mi'**
as meaning standard input.
Otherwise, the standard input shall not be used.
See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

The input file shall be a text file.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_nl_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_COLLATE_    
  Determine the locale for the behavior of ranges, equivalence classes,
  and multi-character collating elements within regular expressions.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files), the behavior of
  character classes within regular expressions, and for deciding which
  characters are in character class
  **graph**
  (for the
  **\(mib&nbsp;t**,
  **\(mif&nbsp;t**,
  and
  **\(mih&nbsp;t**
  options).
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

The standard output shall be a text file in the following format:

    
    "%s%s%s", <line number>, <separator>, <input line>


where &lt;_line&nbsp;number_&gt; is one of the following numeric formats:

* %6d  
  When the
  **rn**
  format is used (the default; see
  **\(min**).
* %06d  
  When the
  **rz**
  format is used.
* %\(mi6d  
  When the
  **ln**
  format is used.
* &lt;empty&gt;  
  When line numbers are suppressed for a portion of the page; the
  &lt;_separator_&gt; is also suppressed.

In the preceding list, the number 6 is the default width; the
**\(miw**
option can change this value.

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

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

In using the
**\(mid**
_delim_
option, care should be taken to escape characters that have special
meaning to the command interpreter.

<a name="examples"></a>

# Examples

The command:

    
    nl (miv 10 (mii 10 (mid e!+ file1


numbers
_file1_
starting at line number 10 with an increment of 10. The logical page
delimiter is
**"!+"**.
Note that the
**'!'**
has to be escaped when using
_csh_
as a command interpreter because of its history substitution syntax.
For
_ksh_
and
_sh_
the escape is not necessary, but does not do any harm.

<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__pr_\^_

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
