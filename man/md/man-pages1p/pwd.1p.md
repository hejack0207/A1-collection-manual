# pwd(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

pwd
— return working directory name

<a name="synopsis"></a>

# Synopsis

```


```
    pwd [(miL|(miP]

<a name="description"></a>

# Description

The
_pwd_
utility shall write to standard output an absolute pathname of the
current working directory, which does not contain the filenames dot or
dot-dot.

<a name="options"></a>

# Options

The
_pwd_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(miL**  
  If the
  _PWD_
  environment variable contains an absolute pathname of the current
  directory that does not contain the filenames dot or dot-dot,
  _pwd_
  shall write this pathname to standard output. Otherwise, if the
  _PWD_
  environment variable contains a pathname of the current directory
  that is longer than
  {PATH_MAX}
  bytes including the terminating null, and the pathname does not contain
  any components that are dot or dot-dot, it is unspecified whether
  _pwd_
  writes this pathname to standard output or behaves as if the
  **\(miP**
  option had been specified. Otherwise, the
  **\(miL**
  option shall behave as the
  **\(miP**
  option.
* **\(miP**  
  The pathname written to standard output shall not contain any components
  that refer to files of type symbolic link. If there are multiple pathnames
  that the
  _pwd_
  utility could write to standard output, one beginning with a single
  &lt;slash&gt;
  character and one or more beginning with two
  &lt;slash&gt;
  characters, then it shall write the pathname beginning with a single
  &lt;slash&gt;
  character. The pathname shall not contain any unnecessary
  &lt;slash&gt;
  characters after the leading one or two
  &lt;slash&gt;
  characters.

If both
**\(miL**
and
**\(miP**
are specified, the last one shall apply. If neither
**\(miL**
nor
**\(miP**
is specified, the
_pwd_
utility shall behave as if
**\(miL**
had been specified.

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

The following environment variables shall affect the execution of
_pwd_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  the precedence of internationalization variables used to determine the
  values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _PWD_  
  An absolute pathname of the current working directory. If an
  application sets or unsets the value of
  _PWD_,
  the behavior of
  _pwd_
  is unspecified.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The
_pwd_
utility output is an absolute pathname of the current working
directory:

    
    "%sen", <directory pathname>


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

The following exit values shall be returned:

* \00  
  Successful completion.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If an error is detected, output shall not be written to standard
output, a diagnostic message shall be written to standard error, and
the exit status is not zero.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

If the pathname obtained from
_pwd_
is longer than
{PATH_MAX}
bytes, it could produce an error if passed to
_cd_.
Therefore, in order to return to that directory it may be necessary to
break the pathname into sections shorter than
{PATH_MAX}
and call
_cd_
on each section in turn (the first section being an absolute pathname
and subsequent sections being relative pathnames).

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Some implementations have historically provided
_pwd_
as a shell special built-in command.

In most utilities, if an error occurs, partial output may be written to
standard output. This does not happen in historical implementations of
_pwd_.
Because
_pwd_
is frequently used in historical shell scripts without checking the
exit status, it is important that the historical behavior is required
here; therefore, the CONSEQUENCES OF ERRORS section specifically
disallows any partial output being written to standard output.

An earlier version of this standard stated that the
_PWD_
environment variable was affected when the
**\(miP**
option was in effect. This was incorrect; conforming implementations
do not do this.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__cd_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__getcwd_\^(\|)_

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
