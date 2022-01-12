# exec(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

exec
— execute commands and open, close, or copy file descriptors

<a name="synopsis"></a>

# Synopsis

```


```
    exec [command [argument...]]

<a name="description"></a>

# Description

The
_exec_
utility shall open, close, and/or copy file descriptors as specified by
any redirections as part of the command.

If
_exec_
is specified without
_command_
or
_argument_s,
and any file descriptors with numbers greater than 2 are opened with
associated redirection statements, it is unspecified whether those file
descriptors remain open when the shell invokes another utility.
Scripts concerned that child shells could misuse open file descriptors
can always close them explicitly, as shown in one of the following
examples.

If
_exec_
is specified with
_command_,
it shall replace the shell with
_command_
without creating a new process. If
_argument_s
are specified, they shall be arguments to
_command_.
Redirection affects the current shell execution environment.

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

If
_command_
is specified,
_exec_
shall not return to the shell; rather, the exit status of the process
shall be the exit status of the program implementing
_command_,
which overlaid the shell. If
_command_
is not found, the exit status shall be 127. If
_command_
is found, but it is not an executable utility, the exit status shall be
126. If a redirection error occurs (see
_Section 2.8.1_, _Consequences of Shell Errors_),
the shell shall exit with a value in the range 1\(mi125. Otherwise,
_exec_
shall return a zero exit status.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

Open
_readfile_
as file descriptor 3 for reading:

    
    exec 3< readfile


Open
_writefile_
as file descriptor 4 for writing:

    
    exec 4> writefile


Make file descriptor 5 a copy of file descriptor 0:

    
    exec 5<&0


Close file descriptor 3:

    
    exec 3<&(mi


Cat the file
**maggie**
by replacing the current shell with the
_cat_
utility:

    
    exec cat maggie


<a name="rationale"></a>

# Rationale

Most historical implementations were not conformant in that:

    
    foo=bar exec cmd


did not pass
**foo**
to
**cmd**.

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
