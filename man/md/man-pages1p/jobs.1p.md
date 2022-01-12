# jobs(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

jobs
— display status of jobs in the current session

<a name="synopsis"></a>

# Synopsis

```


```
    jobs [(mil|(mip] [job_id...]

<a name="description"></a>

# Description

The
_jobs_
utility shall display the status of jobs that were started in the
current shell environment; see
_Section 2.12_, _Shell Execution Environment_.

When
_jobs_
reports the termination status of a job, the shell shall remove its
process ID from the list of those \`\`known in the current shell
execution environment''; see
_Section 2.9.3.1_, _Examples_.

<a name="options"></a>

# Options

The
_jobs_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mil**  
  (The letter ell.) Provide more information about each job listed. This
  information shall include the job number, current job, process group
  ID, state, and the command that formed the job.
* **\(mip**  
  Display only the process IDs for the process group leaders of the
  selected jobs.

By default, the
_jobs_
utility shall display the status of all stopped jobs, running
background jobs and all jobs whose status has changed and have not been
reported by the shell.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _job\_id_  
  Specifies the jobs for which the status is to be displayed. If no
  _job_id_
  is given, the status information for all jobs shall be displayed. The
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
_jobs_:

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
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If the
**\(mip**
option is specified, the output shall consist of one line for each
process ID:

    
    "%den", <process ID>


Otherwise, if the
**\(mil**
option is not specified, the output shall be a series of lines of the
form:

    
    "[%d] %c %s %sen", <job-number>, <current>, <state>, <command>


where the fields shall be as follows:

* &lt;_current_&gt;  
  The character
  **'\(pl'**
  identifies the job that would be used as a default for the
  _fg_
  or
  _bg_
  utilities; this job can also be specified using the
  _job_id_
  %+ or
  **"%%"**.
  The character
  **'\(mi'**
  identifies the job that would become the default if the current default
  job were to exit; this job can also be specified using the
  _job_id_
  %\(mi. For other jobs, this field is a
  &lt;space&gt;.
  At most one job can be identified with
  **'\(pl'**
  and at most one job can be identified with
  **'\(mi'**.
  If there is any suspended job, then the current job shall be a
  suspended job. If there are at least two suspended jobs, then the
  previous job also shall be a suspended job.
* &lt;_job-number_&gt;  
  A number that can be used to identify the process group to the
  _wait_,
  _fg_,
  _bg_,
  and
  _kill_
  utilities. Using these utilities, the job can be identified by
  prefixing the job number with
  **'%'**.
* &lt;_state_&gt;  
  One of the following strings (in the POSIX locale):
    * **Running**  
      Indicates that the job has not been suspended by a signal and has not
      exited.
    * **Done**  
      Indicates that the job completed and returned exit status zero.
    * **Done**(_code_)  
      Indicates that the job completed normally and that it exited with the
      specified non-zero exit status,
      _code_,
      expressed as a decimal number.
    * **Stopped**  
      Indicates that the job was suspended by the SIGTSTP signal.
    * **Stopped**&nbsp;(**SIGTSTP**)    
      Indicates that the job was suspended by the SIGTSTP signal.
    * **Stopped**&nbsp;(**SIGSTOP**)    
      Indicates that the job was suspended by the SIGSTOP signal.
    * **Stopped**&nbsp;(**SIGTTIN**)    
      Indicates that the job was suspended by the SIGTTIN signal.
    * **Stopped**&nbsp;(**SIGTTOU**)    
      Indicates that the job was suspended by the SIGTTOU signal.

The implementation may substitute the string
**Suspended**
in place of
**Stopped**.
If the job was terminated by a signal, the format of &lt;_state_&gt; is
unspecified, but it shall be visibly distinct from all of the other
&lt;_state_&gt; formats shown here and shall indicate the name or
description of the signal causing the termination.

* &lt;_command_&gt;  
  The associated command that was given to the shell.

If the
**\(mil**
option is specified, a field containing the process group ID shall be
inserted before the &lt;_state_&gt; field. Also, more processes in a
process group may be output on separate lines, using only the process
ID and &lt;_command_&gt; fields.

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

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The
**\(mip**
option is the only portable way to find out the process group of a job
because different implementations have different strategies for
defining the process group of the job. Usage such as $(\c
_jobs_
**\(mip**)
provides a way of referring to the process group of the job in an
implementation-independent way.

The
_jobs_
utility does not work as expected when it is operating in its own
utility execution environment because that environment has no
applicable jobs to manipulate. See the APPLICATION USAGE section for
__bg_\^_.
For this reason,
_jobs_
is generally implemented as a shell regular built-in.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Both
**"%%"**
and
**"%+"**
are used to refer to the current job. Both forms are of equal
validity—the
**"%%"**
mirroring
**"$$"**
and
**"%+"**
mirroring the output of
_jobs_.
Both forms reflect historical practice of the KornShell and the C shell
with job control.

The job control features provided by
_bg_,
_fg_,
and
_jobs_
are based on the KornShell. The standard developers examined the
characteristics of the C shell versions of these utilities and found
that differences exist. Despite widespread use of the C shell, the
KornShell versions were selected for this volume of POSIX.1-2008 to maintain a degree of
uniformity with the rest of the KornShell features selected (such as
the very popular command line editing features).

The
_jobs_
utility is not dependent on the job control option, as are the
seemingly related
_bg_
and
_fg_
utilities because
_jobs_
is useful for examining background jobs, regardless of the condition of
job control. When the user has invoked a
_set_
**+m**
command and job control has been turned off,
_jobs_
can still be used to examine the background jobs associated with that
current session. Similarly,
_kill_
can then be used to kill background jobs with
_kill_
%&lt;_background job number_&gt;.

The output for terminated jobs is left unspecified to accommodate
various historical systems. The following formats have been witnessed:

*  1.  
  **Killed**(\c
  _signal name_)
*  2.  
  _signal name_
*  3.  
  _signal name_(\c
  **coredump**)
*  4.  
  _signal description_\(mi
  **core dumped**

Most users should be able to understand these formats, although it
means that applications have trouble parsing them.

The calculation of job IDs was not described since this would suggest
an implementation, which may impose unnecessary restrictions.

In an early proposal, a
**\(min**
option was included to \`\`Display the status of jobs that have changed,
exited, or stopped since the last status report''. It was removed
because the shell always writes any changed status of jobs before each
prompt.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.12_, _Shell Execution Environment_,
__bg_\^_,
__fg_\^_,
__kill_\^_,
__wait_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.204_, _Job Control Job ID_,
_Chapter 8_, _Environment Variables_,
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
