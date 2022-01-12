# shift(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

shift
— shift positional parameters

<a name="synopsis"></a>

# Synopsis

```


```
    shift [n]

<a name="description"></a>

# Description

The positional parameters shall be shifted. Positional parameter 1
shall be assigned the value of parameter (1+_n_), parameter 2 shall
be assigned the value of parameter (2+_n_), and so on. The
parameters represented by the numbers
**"$#"**
down to
**"$#\(min+1"**
shall be unset, and the parameter
**'#'**
is updated to reflect the new number of positional parameters.

The value
_n_
shall be an unsigned decimal integer less than or equal to the value of
the special parameter
**'#'**.
If
_n_
is not given, it shall be assumed to be 1. If
_n_
is 0, the positional and special parameters are not changed.

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

If the
_n_
operand is invalid or is greater than
**"$#"**,
this may be considered a syntax error and a non-interactive shell may
exit; if the shell does not exit in this case, a non-zero exit status
shall be returned. Otherwise, zero shall be returned.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples


    $ set a b c d e
    $ shift 2
    $ echo $*
    c d e

<a name="rationale"></a>

# Rationale

None.

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
