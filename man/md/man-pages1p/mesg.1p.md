# mesg(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

mesg
— permit or deny messages

<a name="synopsis"></a>

# Synopsis

```


```
    mesg [y|n]

<a name="description"></a>

# Description

The
_mesg_
utility shall control whether other users are allowed to send messages
via
_write_,
_talk_,
or other utilities to a terminal device. The terminal device affected
shall be determined by searching for the first terminal in the sequence
of devices associated with standard input, standard output, and
standard error, respectively. With no arguments,
_mesg_
shall report the current state without changing it. Processes with
appropriate privileges may be able to send messages to the terminal
independent of the current state.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operands shall be supported in the POSIX locale:

* _y_  
  Grant permission to other users to send messages to the terminal
  device.
* _n_  
  Deny permission to other users to send messages to the terminal
  device.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_mesg_:

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
  contents of diagnostic messages written (by
  _mesg_)
  to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If no operand is specified,
_mesg_
shall display the current terminal state in an unspecified format.

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
  Receiving messages is allowed.
* \01  
  Receiving messages is not allowed.
* &gt;1  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The mechanism by which the message status of the terminal is changed is
unspecified. Therefore, unspecified actions may cause the status of
the terminal to change after
_mesg_
has successfully completed. These actions may include, but are not
limited to: another invocation of the
_mesg_
utility, login procedures; invocation of the
_stty_
utility, invocation of the
_chmod_
utility or
_chmod_()
function, and so on.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The terminal changed by
_mesg_
is that associated with the standard input, output, or error, rather
than the controlling terminal for the session. This is because users
logged in more than once should be able to change any of their login
terminals without having to stop the job running in those sessions.
This is not a security problem involving the terminals of other users
because appropriate privileges would
be required to affect the terminal of another user.

The method of checking each of the first three file descriptors in
sequence until a terminal is found was adopted from System V.

The file
**/dev/tty**
is not specified for the terminal device because it was thought to be
too restrictive. Typical environment changes for the
_n_
operand are that write permissions are removed for
_others_
and
_group_
from the appropriate device. It was decided to leave the actual
description of what is done as unspecified because of potential
differences between implementations.

The format for standard output is unspecified because of differences
between historical implementations. This output is generally not
useful to shell scripts (they can use the exit status), so exact
parsing of the output is unnecessary.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__talk_\^_,
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
