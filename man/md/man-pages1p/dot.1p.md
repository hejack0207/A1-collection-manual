# dot(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

dot
— execute commands in the current environment

<a name="synopsis"></a>

# Synopsis

```


```
    . file

<a name="description"></a>

# Description

The shell shall execute commands from the
_file_
in the current environment.

If
_file_
does not contain a
&lt;slash&gt;,
the shell shall use the search path specified by
_PATH_
to find the directory containing
_file_.
Unlike normal command search, however, the file searched for by the
_dot_
utility need not be executable. If no readable file is found, a
non-interactive shell shall abort; an interactive shell shall write a
diagnostic message to standard error, but this condition shall not be
considered a syntax error.

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

See the DESCRIPTION.

<a name="environment-variables"></a>

# Environment Variables

See the DESCRIPTION.

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

If no readable file was found or if the commands in the file could not
be parsed, and the shell is interactive (and therefore does not abort; see
_Section 2.8.1_, _Consequences of Shell Errors_),
the exit status shall be non-zero. Otherwise, return the value of the
last command executed, or a zero exit status if no command is executed.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples


    cat foobar
    foo=hello bar=world
    . ./foobar
    echo $foo $bar
    hello world

<a name="rationale"></a>

# Rationale

Some older implementations searched the current directory for the
_file_,
even if the value of
_PATH_
disallowed it. This behavior was omitted from this volume of POSIX.1-2008 due to concerns
about introducing the susceptibility to trojan horses that the user
might be trying to avoid by leaving
**dot**
out of
_PATH_.

The KornShell version of
_dot_
takes optional arguments that are set to the positional parameters.
This is a valid extension that allows a
_dot_
script to behave identically to a function.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.14_, _Special Built-In Utilities_,
__return_\^_

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
