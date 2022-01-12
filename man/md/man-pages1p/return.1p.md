# return(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

return
— return from a function or dot script

<a name="synopsis"></a>

# Synopsis

```


```
    return [n]

<a name="description"></a>

# Description

The
_return_
utility shall cause the shell to stop executing the current function or
_dot_
script. If the shell is not currently executing a function or
_dot_
script, the results are unspecified.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

See the DESCRIPTION.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

None.

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

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The value of the special parameter
**'?'**
shall be set to
_n_,
an unsigned decimal integer, or to the exit status of the last command
executed if
_n_
is not specified. If the value of
_n_
is greater than 255, the results are undefined. When
_return_
is executed in a
_trap_
action, the last command is considered to be the command that
executed immediately preceding the
_trap_
action.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The behavior of
_return_
when not in a function or
_dot_
script differs between the System V shell and the KornShell. In the
System V shell this is an error, whereas in the KornShell, the effect
is the same as
_exit_.

The results of returning a number greater than 255 are undefined
because of differing practices in the various historical
implementations. Some shells AND out all but the low-order 8 bits;
others allow larger values, but not of unlimited size.

See the discussion of appropriate exit status values under
__exit_\^_.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.9.5_, _Function Definition Command_,
_Section 2.14_, _Special Built-In Utilities_,
__dot_\^_

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
