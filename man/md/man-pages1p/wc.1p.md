# wc(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

wc
— word, line, and byte or character count

<a name="synopsis"></a>

# Synopsis

```


```
    wc [(mic|(mim] [(milw] [file...]

<a name="description"></a>

# Description

The
_wc_
utility shall read one or more input files and, by default, write the
number of
&lt;newline&gt;
characters, words, and bytes contained in each input file to the standard
output.

The utility also shall write a total count for all named files, if more
than one input file is specified.

The
_wc_
utility shall consider a
_word_
to be a non-zero-length string of characters delimited by white space.

<a name="options"></a>

# Options

The
_wc_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mic**  
  Write to the standard output the number of bytes in each input file.
* **\(mil**  
  Write to the standard output the number of
  &lt;newline&gt;
  characters in each input file.
* **\(mim**  
  Write to the standard output the number of characters in each input
  file.
* **\(miw**  
  Write to the standard output the number of words in each input file.

When any option is specified,
_wc_
shall report only the information requested by the specified options.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of an input file. If no
  _file_
  operands are specified, the standard input shall be used.

<a name="stdin"></a>

# Stdin

The standard input shall be used if no
_file_
operands are specified, and shall be used if a
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

The input files may be of any type.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_wc_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files) and which
  characters are defined as white-space characters.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

By default, the standard output shall contain an entry for each input
file of the form:

    
    "%d %d %d %sen", <newlines>, <words>, <bytes>, <file>


If the
**\(mim**
option is specified, the number of characters shall replace the
&lt;_bytes_&gt; field in this format.

If any options are specified and the
**\(mil**
option is not specified, the number of
&lt;newline&gt;
characters shall not be written.

If any options are specified and the
**\(miw**
option is not specified, the number of words shall not be written.

If any options are specified and neither
**\(mic**
nor
**\(mim**
is specified, the number of bytes or characters shall not be written.

If no input
_file_
operands are specified, no name shall be written and no
&lt;blank&gt;
characters preceding the pathname shall be written.

If more than one input
_file_
operand is specified, an additional line shall be written, of the same
format as the other lines, except that the word
**total**
(in the POSIX locale) shall be written instead of a pathname and the
total of each column shall be written as appropriate. Such an
additional line, if any, is written at the end of the output.

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

The
**\(mim**
option is not a switch, but an option at the same level as
**\(mic**.
Thus, to produce the full default output with character counts instead
of bytes, the command required is:

    
    wc (mimlw


<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The output file format pseudo-\c
_printf_()
string differs from the System V version of
_wc_:

    
    "%7d%7d%7d %sen"


which produces possibly ambiguous and unparsable results for very large
files, as it assumes no number shall exceed six digits.

Some historical implementations use only
&lt;space&gt;,
&lt;tab&gt;,
and
&lt;newline&gt;
as word separators. The equivalent of the ISO&nbsp;C standard
_isspace_()
function is more appropriate.

The
**\(mic**
option stands for \`\`character'' count, even though it counts bytes.
This stems from the sometimes erroneous historical view that bytes and
characters are the same size. Due to international requirements, the
**\(mim**
option (reminiscent of \`\`multi-byte'') was added to obtain actual
character counts.

Early proposals only specified the results when input files were text
files. The current specification more closely matches historical
practice. (Bytes, words, and
&lt;newline&gt;
characters are counted separately and the results are written when an
end-of-file is detected.)

Historical implementations of the
_wc_
utility only accepted one argument to specify the options
**\(mic**,
**\(mil**,
and
**\(miw**.
Some of them also had multiple occurrences of an option cause the
corresponding count to be written multiple times and had the order of
specification of the options affect the order of the fields on output,
but did not document either of these. Because common usage either
specifies no options or only one option, and because none of this was
documented, the changes required by this volume of POSIX.1-2008 should not break many
historical applications (and do not break any historical conforming
applications).

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__cksum_\^_

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
