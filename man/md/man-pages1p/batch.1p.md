# batch(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

batch
— schedule commands to be executed in a batch queue

<a name="synopsis"></a>

# Synopsis

```


```
    batch

<a name="description"></a>

# Description

The
_batch_
utility shall read commands from standard input and schedule them
for execution in a batch queue. It shall be the equivalent of
the command:

    
    at (miq b (mim now


where queue
_b_
is a special
_at_
queue, specifically for batch jobs. Batch jobs shall be submitted to the
batch queue with no time constraints and shall be run by the system using
algorithms, based on unspecified factors, that may vary with each
invocation of
_batch_.

Users shall be permitted to use
_batch_
if their name appears in the file
**at.allow**
which is located in an implementation-defined directory.
If that file does not exist, the file
**at.deny**,
which is located in an implementation-defined directory,
shall be checked to determine whether the user shall be denied access to
_batch_.
If neither file exists, only a process with appropriate privileges
shall be allowed to submit a job. If only
**at.deny**
exists and is empty, global usage shall be permitted. The
**at.allow**
and
**at.deny**
files shall consist of one user name per line.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

None.

<a name="stdin"></a>

# Stdin

The standard input shall be a text file consisting of commands
acceptable to the shell command language described in
_Chapter 2_, _Shell Command Language_.

<a name="input-files"></a>

# Input Files

The text files
**at.allow**
and
**at.deny**,
which are located in an implementation-defined directory,
shall contain zero or more user names, one per line, of users who are,
respectively, authorized or denied access to the
_at_
and
_batch_
utilities.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_batch_:

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
  multi-byte characters in arguments and input files).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error and
  informative messages written to standard output.
* _LC\_TIME_  
  Determine the format and contents for date and time strings written by
  _batch_.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _SHELL_  
  Determine the name of a command interpreter to be used to invoke the
  at-job. If the variable is unset or null,
  _sh_
  shall be used. If it is set to a value other than a name for
  _sh_,
  the implementation shall do one of the following: use that shell; use
  _sh_;
  use the login shell from the user database; any of the preceding
  accompanied by a warning diagnostic about which was chosen.
* _TZ_  
  Determine the timezone. The job shall be submitted for execution at the
  time specified by
  _timespec_
  or
  **\(mit**
  _time_
  relative to the timezone specified by the
  _TZ_
  variable. If
  _timespec_
  specifies a timezone, it overrides
  _TZ_.
  If
  _timespec_
  does not specify a timezone and
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

When standard input is a terminal, prompts of unspecified format for
each line of the user input described in the STDIN section may be
written to standard output.

<a name="stderr"></a>

# Stderr

The following shall be written to standard error when a job has been
successfully submitted:

    
    "job %s at %sen", at_job_id, <date>


where
_date_
shall be equivalent in format to the output of:

    
    date +"%a %b %e %T %Y"


The date and time written shall be adjusted so that they appear in the
timezone of the user (as determined by the
_TZ_
variable).

Neither this, nor warning messages concerning the selection of the
command interpreter, are considered a diagnostic that changes the exit
status.

Diagnostic messages, if any, shall be written to standard error.

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

The job shall not be scheduled.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

It may be useful to redirect standard output within the specified
commands.

<a name="examples"></a>

# Examples


*  1.  
  This sequence can be used at a terminal:

    
    batch
    sort < file >outfile
    EOT


*  2.  
  This sequence, which demonstrates redirecting standard error to a pipe,
  is useful in a command procedure (the sequence of output redirection
  specifications is significant):

    
    batch <<!
    diff file1 file2 2>&1 >outfile | mailx mygroup
    !


<a name="rationale"></a>

# Rationale

Early proposals described
_batch_
in a manner totally separated from
_at_,
even though the historical model treated it almost as a synonym for
_at_
**\(miqb**.
A number of features were added to list and control batch work
separately from those in
_at_.
Upon further reflection, it was decided that the benefit of this did
not merit the change to the historical interface.

The
**\(mim**
option was included on the equivalent
_at_
command because it is historical practice to mail results to the
submitter, even if all job-produced output is redirected. As explained
in the RATIONALE for
_at_,
the
**now**
keyword submits the job for immediate execution (after scheduling
delays), despite some historical systems where
_at_
**now**
would have been considered an error.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__at_\^_

The Base Definitions volume of POSIX.1-2008,
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
