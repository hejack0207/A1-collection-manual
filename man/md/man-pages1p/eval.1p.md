# eval(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

eval
— construct command by concatenating arguments

<a name="synopsis"></a>

# Synopsis

```


```
    eval [argument...]

<a name="description"></a>

# Description

The
_eval_
utility shall construct a command by concatenating
_argument_s
together, separating each with a
&lt;space&gt;
character.
The constructed command shall be read and executed by the shell.

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

If there are no
_argument_s,
or only null
_argument_s,
_eval_
shall return a zero exit status; otherwise, it shall return the exit
status of the command defined by the string of concatenated
_argument_s
separated by
&lt;space&gt;
characters, or a non-zero exit status if the concatenation could not
be parsed as a command and the shell is interactive (and therefore did
not abort).

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Since
_eval_
is not required to recognize the
**"--"**
end of options delimiter, in cases where the argument(s) to
_eval_
might begin with
**'-'**
it is recommended that the first argument is prefixed by a string that
will not alter the commands to be executed, such as a
&lt;space&gt;
character:

    
    eval " $commands"


or:

    
    eval " $(some_command)"


<a name="examples"></a>

# Examples


    foo=10 x=foo
    y='$'$x
    echo $y
    $foo
    eval y='$'$x
    echo $y
    10

<a name="rationale"></a>

# Rationale

This standard allows, but does not require,
_eval_
to recognize
**"--"**.
Although this means applications cannot use
**"--"**
to protect against options supported as an extension (or errors reported
for unsupported options), the nature of the
_eval_
utility is such that other means can be used to provide this protection
(see APPLICATION USAGE above).

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
