# true(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

true
— return true value

<a name="synopsis"></a>

# Synopsis

```


```
    true

<a name="description"></a>

# Description

The
_true_
utility shall return with exit code zero.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

None.

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

Not used.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

Zero.

<a name="consequences-of-errors"></a>

# Consequences of Errors

None.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

This utility is typically used in shell scripts, as shown in the
EXAMPLES section. The special built-in utility
**:**
is sometimes more efficient than
_true_.

<a name="examples"></a>

# Examples

This command is executed forever:

    
    while true
    do
        command
    done


<a name="rationale"></a>

# Rationale

The
_true_
utility has been retained in this volume of POSIX.1-2008, even though the shell special
built-in
**:**
provides similar functionality, because
_true_
is widely used in historical scripts and is less cryptic to novice
script readers.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.9_, _Shell Commands_,
__false_\^_

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
