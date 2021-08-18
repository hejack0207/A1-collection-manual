# head(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

head
— copy the first part of files

<a name="synopsis"></a>

# Synopsis

```


```
    head [(min number] [file...]

<a name="description"></a>

# Description

The
_head_
utility shall copy its input files to the standard output, ending the
output for each file at a designated point.

Copying shall end at the point in each input file indicated by the
**\(min**
_number_
option. The option-argument
_number_
shall be counted in units of lines.

<a name="options"></a>

# Options

The
_head_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(min&nbsp;number**  
  The first
  _number_
  lines of each input file shall be copied to standard output. The
  application shall ensure that the
  _number_
  option-argument is a positive decimal integer.

When a file contains less than
_number_
lines, it shall be copied to standard output in its entirety. This
shall not be an error.

If no options are specified,
_head_
shall act as if
**\(min 10**
had been specified.

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

Input files shall be text files, but the line length is not restricted
to
{LINE_MAX}
bytes.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_head_:

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

The standard output shall contain designated portions of the input
files.

If multiple
_file_
operands are specified,
_head_
shall precede the output for each with the header:

    
    "en==> %s <==en", <pathname>


except that the first header written shall not include the initial
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

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

To write the first ten lines of all files (except those with a leading
period) in the directory:

    
    head (mi|(mi *


<a name="rationale"></a>

# Rationale

Although it is possible to simulate
_head_
with
_sed_
10q for a single file, the standard developers decided that the
popularity of
_head_
on historical BSD systems warranted its inclusion alongside
_tail_.

POSIX.1-2008 version of
_head_
follows the Utility Syntax Guidelines. The
**\(min**
option was added to this new interface so that
_head_
and
_tail_
would be more logically related. Earlier versions of this standard
allowed a
**\(minumber**
option. This form is no longer specified by POSIX.1-2008 but may
be present in some implementations.

There is no
**\(mic**
option (as there is in
_tail_)
because it is not historical practice and because other utilities in
this volume of POSIX.1-2008 provide similar functionality.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__sed_\^_,
__tail_\^_

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
