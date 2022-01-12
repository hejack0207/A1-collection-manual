# unset(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

unset
— unset values and attributes of variables and functions

<a name="synopsis"></a>

# Synopsis

```


```
    unset [(mifv] name...

<a name="description"></a>

# Description

Each variable or function specified by
_name_
shall be unset.

If
**\(miv**
is specified,
_name_
refers to a variable name and the shell shall unset it and remove it
from the environment. Read-only variables cannot be unset.

If
**\(mif**
is specified,
_name_
refers to a function and the shell shall unset the function definition.

If neither
**\(mif**
nor
**\(miv**
is specified,
_name_
refers to a variable; if a variable by that name does not exist, it is
unspecified whether a function by that name, if any, shall be unset.

Unsetting a variable or function that was not previously set shall not
be considered an error and does not cause the shell to abort.

The
_unset_
special built-in shall support the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

Note that:

    
    VARIABLE=


is not equivalent to an
_unset_
of
**VARIABLE**;
in the example,
**VARIABLE**
is set to
**"\^"**.
Also, the variables that can be
_unset_
should not be misinterpreted to include the special parameters (see
_Section 2.5.2_, _Special Parameters_).

<a name="options"></a>

# Options

See the DESCRIPTION.

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
  All
  _name_
  operands were successfully unset.
* &gt;0  
  At least one
  _name_
  could not be unset.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

Unset
_VISUAL_
variable:

    
    unset (miv VISUAL


Unset the functions
**foo**
and
**bar**:

    
    unset (mif foo bar


<a name="rationale"></a>

# Rationale

Consideration was given to omitting the
**\(mif**
option in favor of an
_unfunction_
utility, but the standard developers decided to retain historical
practice.

The
**\(miv**
option was introduced because System V historically used one name space
for both variables and functions. When
_unset_
is used without options, System V historically unset either a function
or a variable, and there was no confusion about which one was intended.
A portable POSIX application can use
_unset_
without an option to unset a variable, but not a function; the
**\(mif**
option must be used.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.14_, _Special Built-In Utilities_

The Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_

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
