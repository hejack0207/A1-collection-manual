# exit(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

exit
— cause the shell to exit

<a name="synopsis"></a>

# Synopsis

```


```
    exit [n]

<a name="description"></a>

# Description

The
_exit_
utility shall cause the shell to exit with the exit status specified
by the unsigned decimal integer
_n_.
If
_n_
is specified, but its value is not between 0 and 255 inclusively, the
exit status is undefined.

A
_trap_
on
**EXIT**
shall be executed before the shell terminates, except when the
_exit_
utility is invoked in that
_trap_
itself, in which case the shell shall exit immediately.

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

The exit status shall be
_n_,
if specified. Otherwise, the value shall be the exit value of the last
command executed, or zero if no command was executed. When
_exit_
is executed in a
_trap_
action, the last command is considered to be the command that executed
immediately preceding the
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

Exit with a
_true_
value:

    
    exit 0


Exit with a
_false_
value:

    
    exit 1


<a name="rationale"></a>

# Rationale

As explained in other sections, certain exit status values have been
reserved for special uses and should be used by applications only for
those purposes:

* \0126  
  A file to be executed was found, but it was not an executable utility.
* \0127  
  A utility to be executed was not found.
* &gt;128  
  A command was interrupted by a signal.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.14_, _Special Built-In Utilities_

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
