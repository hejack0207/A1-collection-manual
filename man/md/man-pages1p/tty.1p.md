# tty(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

tty
— return user's terminal name

<a name="synopsis"></a>

# Synopsis

```


```
    tty

<a name="description"></a>

# Description

The
_tty_
utility shall write to the standard output the name of the terminal
that is open as standard input. The name that is used shall be
equivalent to the string that would be returned by the
_ttyname_()
function defined in the System Interfaces volume of POSIX.1-2008.

<a name="options"></a>

# Options

The
_tty_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

<a name="operands"></a>

# Operands

None.

<a name="stdin"></a>

# Stdin

While no input is read from standard input, standard input shall be
examined to determine whether or not it is a terminal, and, if so, to
determine the name of the terminal.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_tty_:

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

If standard input is a terminal device, a pathname of the terminal as
specified by the
_ttyname_()
function defined in the System Interfaces volume of POSIX.1-2008 shall be written in the following
format:

    
    "%sen", <terminal name>


Otherwise, a message shall be written indicating that standard input is
not connected to a terminal. In the POSIX locale, the
_tty_
utility shall use the format:

    
    "not a ttyen"


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
  Standard input is a terminal.
* \01  
  Standard input is not a terminal.
* &gt;1  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

This utility checks the status of the file open as standard input
against that of an implementation-defined set of files. It is possible
that no match can be found, or that the match found need not be the
same file as that which was opened for standard input (although they
are the same device).

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__isatty_\^(\|)_,
__ttyname_\^(\|)_

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
