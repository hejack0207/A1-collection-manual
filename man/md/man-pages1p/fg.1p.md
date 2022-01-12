# fg(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

fg
— run jobs in the foreground

<a name="synopsis"></a>

# Synopsis

```


```
    fg [job_id]

<a name="description"></a>

# Description

If job control is enabled (see the description of
_set_
**\(mim**),
the
_fg_
utility shall move a background job from the current environment (see
_Section 2.12_, _Shell Execution Environment_)
into the foreground.

Using
_fg_
to place a job into the foreground shall remove its process ID from the
list of those \`\`known in the current shell execution environment''; see
_Section 2.9.3.1_, _Examples_.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _job\_id_  
  Specify the job to be run as a foreground job. If no
  _job_id_
  operand is given, the
  _job_id_
  for the job that was most recently suspended, placed in the background,
  or run as a background job shall be used. The format of
  _job_id_
  is described in the Base Definitions volume of POSIX.1-2008,
  _Section 3.204_, _Job Control Job ID_.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_fg_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The
_fg_
utility shall write the command line of the job to standard output
in the following format:

    
    "%sen", <command>


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

If job control is disabled, the
_fg_
utility shall exit with an error and no job shall be placed in the
foreground.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
_fg_
utility does not work as expected when it is operating in its own
utility execution environment because that environment has no
applicable jobs to manipulate. See the APPLICATION USAGE section for
__bg_\^_.
For this reason,
_fg_
is generally implemented as a shell regular built-in.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The extensions to the shell specified in this volume of POSIX.1-2008 have mostly been based
on features provided by the KornShell. The job control features
provided by
_bg_,
_fg_,
and
_jobs_
are also based on the KornShell. The standard developers examined the
characteristics of the C shell versions of these utilities and found
that differences exist. Despite widespread use of the C shell, the
KornShell versions were selected for this volume of POSIX.1-2008 to maintain a degree of
uniformity with the rest of the KornShell features selected (such as
the very popular command line editing features).

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.9.3.1_, _Examples_,
_Section 2.12_, _Shell Execution Environment_,
__bg_\^_,
__kill_\^_,
__jobs_\^_,
__wait_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.204_, _Job Control Job ID_,
_Chapter 8_, _Environment Variables_

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
