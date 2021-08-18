# break(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

break
— exit from for, while, or until loop

<a name="synopsis"></a>

# Synopsis

```


```
    break [n]

<a name="description"></a>

# Description

The
_break_
utility shall exit from the smallest enclosing
**for**,
**while**,
or
**until**
loop, if any; or from the
_n_th
enclosing loop if
_n_
is specified. The value of
_n_
is an unsigned decimal integer greater than or equal to 1. The default
shall be equivalent to
_n_=1.
If
_n_
is greater than the number of enclosing loops, the outermost enclosing
loop shall be exited. Execution shall continue with the command
immediately following the loop.

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


* \00  
  Successful completion.
* &gt;0  
  The
  _n_
  value was not an unsigned decimal integer greater than or equal to 1.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples


    for i in *
    do
        if test (mid "$i"
        then break
        fi
    done

<a name="rationale"></a>

# Rationale

In early proposals, consideration was given to expanding the syntax of
_break_
and
_continue_
to refer to a label associated with the appropriate loop as a
preferable alternative to the
_n_
method. However, this volume of POSIX.1-2008 does reserve the name space of command names
ending with a
&lt;colon&gt;.
It is anticipated that a future implementation could take advantage of
this and provide something like:

    
    outofloop: for i in a b c d e
    do
        for j in 0 1 2 3 4 5 6 7 8 9
        do
            if test (mir "${i}${j}"
            then break outofloop
            fi
        done
    done


and that this might be standardized after implementation experience is
achieved.

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
