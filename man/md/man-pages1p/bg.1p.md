# bg(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

bg
— run jobs in the background

<a name="synopsis"></a>

# Synopsis

```


```
    bg [job_id...]

<a name="description"></a>

# Description

If job control is enabled (see the description of
_set_
**\(mim**),
the
_bg_
utility shall resume suspended jobs from the current environment (see
_Section 2.12_, _Shell Execution Environment_)
by running them as background jobs. If the job specified by
_job_id_
is already a running background job, the
_bg_
utility shall have no effect and shall exit successfully.

Using
_bg_
to place a job into the background shall cause its process ID to become
\`\`known in the current shell execution environment'', as if it had been
started as an asynchronous list; see
_Section 2.9.3.1_, _Examples_.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _job\_id_  
  Specify the job to be resumed as a background job. If no
  _job_id_
  operand is given, the most recently suspended job shall be used. The
  format of
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
_bg_:

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

The output of
_bg_
shall consist of a line in the format:

    
    "[%d] %sen", <job-number>, <command>


where the fields are as follows:

* &lt;_job-number_&gt;  
  A number that can be used to identify the job to the
  _wait_,
  _fg_,
  and
  _kill_
  utilities. Using these utilities, the job can be identified by
  prefixing the job number with
  **'%'**.
* &lt;_command_&gt;  
  The associated command that was given to the shell.

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
_bg_
utility shall exit with an error and no job shall be placed in the
background.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

A job is generally suspended by typing the SUSP character
(&lt;control&gt;-Z on most systems); see the Base Definitions volume of POSIX.1-2008,
_Chapter 11_, _General Terminal Interface_.
At that point,
_bg_
can put the job into the background. This is most effective when the
job is expecting no terminal input and its output has been redirected
to non-terminal files. A background job can be forced to stop when it
has terminal output by issuing the command:

    
    stty tostop


A background job can be stopped with the command:

    
    kill (mis stop job ID


The
_bg_
utility does not work as expected when it is operating in its own
utility execution environment because that environment has no suspended
jobs. In the following examples:

    
    ... | xargs bg
    (bg)


each
_bg_
operates in a different environment and does not share its parent
shell's understanding of jobs. For this reason,
_bg_
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

The
_bg_
utility is expected to wrap its output if the output exceeds the number
of display columns.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.9.3.1_, _Examples_,
__fg_\^_,
__kill_\^_,
__jobs_\^_,
__wait_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.204_, _Job Control Job ID_,
_Chapter 8_, _Environment Variables_,
_Chapter 11_, _General Terminal Interface_

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
