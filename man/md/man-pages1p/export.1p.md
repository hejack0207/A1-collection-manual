# export(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

export
— set the export attribute for variables

<a name="synopsis"></a>

# Synopsis

```


```
    export name[=word]...
    
    export (mip

<a name="description"></a>

# Description

The shell shall give the
_export_
attribute to the variables corresponding to the specified
_name_s,
which shall cause them to be in the environment of subsequently
executed commands. If the name of a variable is followed by =\c
_word_,
then the value of that variable shall be set to
_word_.

The
_export_
special built-in shall support the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

When
**\(mip**
is specified,
_export_
shall write to the standard output the names and values of all exported
variables, in the following format:

    
    "export %s=%sen", <name>, <value>


if
_name_
is set, and:

    
    "export %sen", <name>


if
_name_
is unset.

The shell shall format the output, including the proper use of quoting,
so that it is suitable for reinput to the shell as commands that
achieve the same exporting results, except:

*  1.  
  Read-only variables with values cannot be reset.
*  2.  
  Variables that were unset at the time they were output need not be
  reset to the unset state if a value is assigned to the variable between
  the time the state was saved and the time at which the saved output is
  reinput to the shell.

When no arguments are given, the results are unspecified. If a variable
assignment precedes the command name of
_export_
but that variable is not also listed as an operand of
_export_,
then that variable shall be set in the current shell execution environment
after the completion of the
_export_
command, but it is unspecified whether that variable is marked for export.

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

See the DESCRIPTION.

<a name="stderr-s"></a>

# Stderr S

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

Export
_PWD_
and
_HOME_
variables:

    
    export PWD HOME


Set and export the
_PATH_
variable:

    
    export PATH=/local/bin:$PATH


Save and restore all exported variables:

    
    export (mip > temp-file
    unset a lot of variables
    ... processing
    . temp-file


<a name="rationale"></a>

# Rationale

Some historical shells use the no-argument case as the functional
equivalent of what is required here with
**\(mip**.
This feature was left unspecified because it is not historical practice
in all shells, and some scripts may rely on the now-unspecified results
on their implementations. Attempts to specify the
**\(mip**
output as the default case were unsuccessful in achieving consensus.
The
**\(mip**
option was added to allow portable access to the values that can be
saved and then later restored using; for example, a
_dot_
script.

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
