# qsig(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qsig
— signal batch jobs

<a name="synopsis"></a>

# Synopsis

```


```
    qsig [(mis signal] job_identifier...

<a name="description"></a>

# Description

To signal a batch job is to send a signal to the session leader of the
batch job. A batch job is signaled by sending a request to the batch
server that manages the batch job. The
_qsig_
utility is a user-accessible batch client that requests the signaling
of a batch job.

The
_qsig_
utility shall signal those batch jobs for which a batch
_job_identifier_
is presented to the utility. The
_qsig_
utility shall not signal any batch jobs whose batch
_job_identifier_s
are not presented to the utility.

The
_qsig_
utility shall signal batch jobs in the order in which the corresponding
batch
_job_identifier_s
are presented to the utility. If the
_qsig_
utility fails to process a batch
_job_identifier_
successfully, the utility shall proceed to process the remaining batch
_job_identifier_s,
if any.

The
_qsig_
utility shall signal batch jobs by sending a
_Signal Job Request_
to the batch server that manages the batch job.

For each successfully processed batch
_job_identifier_,
the
_qsig_
utility shall have received a completion reply to each
_Signal Job Request_
sent to a batch server at the time the utility exits.

<a name="options"></a>

# Options

The
_qsig_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported by the implementation:

* **\(mis&nbsp;signal**  
  Define the signal to be sent to the batch job.

The
_qsig_
utility shall accept a
_signal_
option-argument that is either a symbolic signal name or an unsigned
integer signal number (see the POSIX.1-1990 standard, Section 3.3.1.1). The
_qsig_
utility shall accept signal names for which the SIG prefix has been
omitted.

If the
_signal_
option-argument is a signal name, the
_qsig_
utility shall send that name.

If the
_signal_
option-argument is a number, the
_qsig_
utility shall send the signal value represented by the number.

If the
**\(mis**
option is not presented to the
_qsig_
utility, the utility shall send the signal SIGTERM to each signaled
batch job.

<a name="operands"></a>

# Operands

The
_qsig_
utility shall accept one or more operands that conform to the syntax
for a batch
_job_identifier_
(see
_Section 3.3.1_, _Batch Job Identifier_).

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_qsig_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  the precedence of internationalization variables used to determine the
  values of locale categories.)
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
* _LOGNAME_  
  Determine the login name of the user.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

An implementation of the
_qsig_
utility may write informative messages to standard output.

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

In addition to the default behavior, the
_qsig_
utility shall not be required to write a diagnostic message to standard
error when the error reply received from a batch server indicates that
the batch
_job_identifier_
does not exist on the server. Whether or not the
_qsig_
utility waits to output the diagnostic message while attempting to
locate the batch job on other servers is implementation-defined.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

The
_qsig_
utility allows users to signal batch jobs.

A user may be unable to signal a batch job with the
_kill_
utility of the operating system for a number of reasons. First, the
process ID of the batch job may be unknown to the user. Second, the
processes of the batch job may be on a remote node. However, by virtue
of communication between batch nodes, the
_qsig_
utility can arrange for the signaling of a process.

Because a batch job that is not running cannot be signaled, and because
the signal may not terminate the batch job, the
_qsig_
utility is not a substitute for the
_qdel_
utility.

The options of the
_qsig_
utility allow the user to specify the signal that is to be sent to the
batch job.

The
**\(mis**
option allows users to specify a signal by name or by number, and thus
override the default signal. The POSIX.1-1990 standard defines signals by both name and
number.

The
_qsig_
utility is a new utility, _vis-a-vis_ existing practice; it has
been defined in this volume of POSIX.1-2008 in response to user-perceived shortcomings in
existing practice.

<a name="future-directions"></a>

# Future Directions

The
_qsig_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__kill_\^_,
__qdel_\^_

The Base Definitions volume of POSIX.1-2008,
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
