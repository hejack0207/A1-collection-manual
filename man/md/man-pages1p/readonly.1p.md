# readonly(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

readonly
— set the readonly attribute for variables

<a name="synopsis"></a>

# Synopsis

```


```
    readonly name[=word]...
    
    readonly (mip

<a name="description"></a>

# Description

The variables whose
_name_s
are specified shall be given the
_readonly_
attribute. The values of variables with the
_readonly_
attribute cannot be changed by subsequent assignment, nor can those
variables be unset by the
_unset_
utility. If the name of a variable is followed by =\c
_word_,
then the value of that variable shall be set to
_word_.

The
_readonly_
special built-in shall support the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

When
**\(mip**
is specified,
_readonly_
writes to the standard output the names and values of all read-only
variables, in the following format:

    
    "readonly %s=%sen", <name>, <value>


if
_name_
is set, and

    
    "readonly %sen", <name>


if
_name_
is unset.

The shell shall format the output, including the proper use of quoting,
so that it is suitable for reinput to the shell as commands that
achieve the same value and
_readonly_
attribute-setting results in a shell execution environment in which:

*  1.  
  Variables with values at the time they were output do not have the
  _readonly_
  attribute set.
*  2.  
  Variables that were unset at the time they were output do not have a
  value at the time at which the saved output is reinput to the shell.

When no arguments are given, the results are unspecified.

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


    readonly HOME PWD

<a name="rationale"></a>

# Rationale

Some historical shells preserve the
_readonly_
attribute across separate invocations. This volume of POSIX.1-2008 allows this behavior,
but does not require it.

The
**\(mip**
option allows portable access to the values that can be saved and then
later restored using, for example, a
_dot_
script. Also see the RATIONALE for
__export_\^_
for a description of the no-argument and
**\(mip**
output cases and a related example.

Read-only functions were considered, but they were omitted as not being
historical practice or particularly useful. Furthermore, functions must
not be read-only across invocations to preclude \`\`spoofing''
(spoofing is the term for the practice of creating a program that acts
like a well-known utility with the intent of subverting the real intent
of the user) of administrative or security-relevant (or
security-conscious) shell scripts.

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
