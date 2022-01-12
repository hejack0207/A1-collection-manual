# times(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

times
— write process times

<a name="synopsis"></a>

# Synopsis

```


```
    times

<a name="description"></a>

# Description

The
_times_
utility shall write the accumulated user and system times for the shell
and for all of its child processes, in the following POSIX locale
format:

    
    "%dm%fs %dm%fsen%dm%fs %dm%fsen", <shell user minutes>,
        <shell user seconds>, <shell system minutes>,
        <shell system seconds>, <children user minutes>,
        <children user seconds>, <children system minutes>,
        <children system seconds>


The four pairs of times shall correspond to the members of the
_&lt;sys/times.h&gt;_
**tms**
structure (defined in the Base Definitions volume of POSIX.1-2008,
_Chapter 13_, _Headers_)
as returned by
_times_():
_tms_utime_,
_tms_stime_,
_tms_cutime_,
and
_tms_cstime_,
respectively.

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

See the DESCRIPTION.

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

Zero.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples


    $ times
    0m0.43s 0m1.11s
    8m44.18s 1m43.23s

<a name="rationale"></a>

# Rationale

The
_times_
special built-in from the Single UNIX Specification is now required
for all conforming shells.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.14_, _Special Built-In Utilities_

The Base Definitions volume of POSIX.1-2008,
_**&lt;sys\_times.h&gt;**_

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
