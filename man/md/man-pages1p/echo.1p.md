# echo(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

echo
— write arguments to standard output

<a name="synopsis"></a>

# Synopsis

```


```
    echo [string...]

<a name="description"></a>

# Description

The
_echo_
utility writes its arguments to standard output, followed by a
&lt;newline&gt;.
If there are no arguments, only the
&lt;newline&gt;
is written.

<a name="options"></a>

# Options

The
_echo_
utility shall not recognize the
**"\(mi\|\(mi"**
argument in the manner specified by Guideline 10 of the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_;
**"\(mi\|\(mi"**
shall be recognized as a string operand.

Implementations shall not support any options.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _string_  
  A string to be written to standard output. If the first operand is
  **\(min**,
  or if any of the operands contain a
  &lt;backslash&gt;
  character, the results are implementation-defined.

On XSI-conformant systems, if the first operand is
**\(min**,
it shall be treated as a string, not an option. The following character
sequences shall be recognized on XSI-conformant systems within any of
the arguments:

* \ea  
  Write an
  &lt;alert&gt;.
* \eb  
  Write a
  &lt;backspace&gt;.
* \ec  
  Suppress the
  &lt;newline&gt;
  that otherwise follows the final argument in the output. All
  characters following the
  **'\ec'**
  in the arguments shall be ignored.
* \ef  
  Write a
  &lt;form-feed&gt;.
* \en  
  Write a
  &lt;newline&gt;.
* \er  
  Write a
  &lt;carriage-return&gt;.
* \et  
  Write a
  &lt;tab&gt;.
* \ev  
  Write a
  &lt;vertical-tab&gt;.
* \e\e  
  Write a
  &lt;backslash&gt;
  character.
* \e0_num_  
  Write an 8-bit value that is the zero, one, two, or three-digit octal
  number
  _num_.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_echo_:

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
  multi-byte characters in arguments).
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

The
_echo_
utility arguments shall be separated by single
&lt;space&gt;
characters and a
&lt;newline&gt;
character shall follow the last argument.
Output transformations shall occur based on the escape sequences in
the input. See the OPERANDS section.

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

It is not possible to use
_echo_
portably across all POSIX systems unless both
**\(min**
(as the first argument) and escape sequences are omitted.

The
_printf_
utility can be used portably to emulate any of the traditional
behaviors of the
_echo_
utility as follows (assuming that
_IFS_
has its standard value or is unset):

*  *  
  The historic System V
  _echo_
  and the requirements on XSI implementations in this volume of POSIX.1-2008 are equivalent to:

    
    printf "%ben$*"


*  *  
  The BSD
  _echo_
  is equivalent to:

    
    if [ "X$1" = "X(min" ]
    then
        shift
        printf "%s$*"
    else
        printf "%sen$*"
    fi


New applications are encouraged to use
_printf_
instead of
_echo_.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The
_echo_
utility has not been made obsolescent because of its extremely
widespread use in historical applications. Conforming applications that
wish to do prompting without
&lt;newline&gt;
characters or that could possibly be expecting to echo a
**\(min**,
should use the
_printf_
utility derived from the Ninth Edition system.

As specified,
_echo_
writes its arguments in the simplest of ways. The two different
historical versions of
_echo_
vary in fatally incompatible ways.

The BSD
_echo_
checks the first argument for the string
**\(min**
which causes it to suppress the
&lt;newline&gt;
that would otherwise follow the final argument in the output.

The System V
_echo_
does not support any options, but allows escape sequences within its
operands, as described for XSI implementations in the OPERANDS section.

The
_echo_
utility does not support Utility Syntax Guideline 10 because historical
applications depend on
_echo_
to echo
_all_
of its arguments, except for the
**\(min**
option in the BSD version.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__printf_\^_

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
