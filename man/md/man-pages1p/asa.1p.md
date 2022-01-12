# asa(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

asa
— interpret carriage-control characters

<a name="synopsis"></a>

# Synopsis

```


```
    asa [file...]

<a name="description"></a>

# Description

The
_asa_
utility shall write its input files to standard output, mapping
carriage-control characters from the text files to line-printer control
sequences in an implementation-defined manner.

The first character of every line shall be removed from the input, and
the following actions are performed.

If the character removed is:

* &lt;space&gt;  
  The rest of the line is output without change.
* 0  
  A
  &lt;newline&gt;
  is output, then the rest of the input line.
* 1  
  One or more implementation-defined characters that causes an advance
  to the next page shall be output, followed by the rest of the input
  line.
* +  
  The
  &lt;newline&gt;
  of the previous line shall be replaced with one or more
  implementation-defined characters that causes printing to return to
  column position 1, followed by the rest of the input line. If the
  **'\(pl'**
  is the first character in the input, it shall be equivalent to
  &lt;space&gt;.

The action of the
_asa_
utility is unspecified upon encountering any character other than those
listed above as the first character in a line.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands


* _file_  
  A pathname of a text file used for input. If no
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

The input files shall be text files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_asa_:

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

The standard output shall be the text from the input file modified as
described in the DESCRIPTION section.

<a name="stderr"></a>

# Stderr

None.

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
  All input files were output successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples


*  1.  
  The following command:

    
    asa file


permits the viewing of
_file_
(created by a program using FORTRAN-style carriage-control characters)
on a terminal.

*  2.  
  The following command:

    
    a.out | asa | lp


formats the FORTRAN output of
**a.out**
and directs it to the printer.

<a name="rationale"></a>

# Rationale

The
_asa_
utility is needed to map \`\`standard'' FORTRAN 77 output into a form
acceptable to contemporary printers. Usually,
_asa_
is used to pipe data to the
_lp_
utility; see
_lp_.

This utility is generally used only by FORTRAN programs. The
standard developers decided to retain
_asa_
to avoid breaking the historical large base of FORTRAN applications
that put carriage-control characters in their output files. There is no
requirement that a system have a FORTRAN compiler in order to run
applications that need
_asa_.

Historical implementations have used an ASCII
&lt;form-feed&gt;
in response to a 1 and an ASCII
&lt;carriage-return&gt;
in response to a
**'\(pl'**.
It is suggested that implementations treat characters other than 0, 1,
and
**'\(pl'**
as
&lt;space&gt;
in the absence of any compelling reason to do otherwise. However, the
action is listed here as \`\`unspecified'', permitting an implementation
to provide extensions to access fast multiple-line slewing and channel
seeking in a non-portable manner.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__fort77_\^_,
__lp_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_

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
