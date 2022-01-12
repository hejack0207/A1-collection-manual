# logger(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

logger
— log messages

<a name="synopsis"></a>

# Synopsis

```


```
    logger string...

<a name="description"></a>

# Description

The
_logger_
utility saves a message, in an unspecified manner and format,
containing the
_string_
operands provided by the user. The messages are expected to be
evaluated later by personnel performing system administration tasks.

It is implementation-defined whether messages written in locales
other than the POSIX locale are effective.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _string_  
  One of the string arguments whose contents are concatenated together,
  in the order specified, separated by single
  &lt;space&gt;
  characters.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_logger_:

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
  contents of diagnostic messages written to standard error. (This means
  diagnostics from
  _logger_
  to the user or application, not diagnostic messages that the user is
  sending to the system administrator.)
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

Unspecified.

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

This utility allows logging of information for later use by a system
administrator or programmer in determining why non-interactive
utilities have failed. The locations of the saved messages, their
format, and retention period are all unspecified. There is no method
for a conforming application to read messages, once written.

<a name="examples"></a>

# Examples

A batch application, running non-interactively, tries to read a
configuration file and fails; it may attempt to notify the system
administrator with:

    
    logger myname: unable to read file foo. [timestamp]


<a name="rationale"></a>

# Rationale

The standard developers believed strongly that some method of alerting
administrators to errors was necessary. The obvious example is a batch
utility, running non-interactively, that is unable to read its
configuration files or that is unable to create or write its results
file. However, the standard developers did not wish to define the
format or delivery mechanisms as they have historically been (and will
probably continue to be) very system-specific, as well as involving
functionality clearly outside the scope of this volume of POSIX.1-2008.

The text with
_LC_MESSAGES_
about diagnostic messages means diagnostics from
_logger_
to the user or application, not diagnostic messages that the user is
sending to the system administrator.

Multiple
_string_
arguments are allowed, similar to
_echo_,
for ease-of-use.

Like the utilities
_mailx_
and
_lp_,
_logger_
is admittedly difficult to test. This was not deemed sufficient
justification to exclude these utilities from this volume of POSIX.1-2008. It is also
arguable that they are, in fact, testable, but that the tests
themselves are not portable.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__lp_\^_,
__mailx_\^_,
__write_\^_

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
