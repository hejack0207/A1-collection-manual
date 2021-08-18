# qmsg(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qmsg
— send message to batch jobs

<a name="synopsis"></a>

# Synopsis

```


```
    qmsg [(miEO] message_string job_identifier...

<a name="description"></a>

# Description

To send a message to a batch job is to request that a server write a
message string into one or more output files of the batch job. A
message is sent to a batch job by a request to the batch server that
manages the batch job. The
_qmsg_
utility is a user-accessible batch client that requests the sending of
messages to one or more batch jobs.

The
_qmsg_
utility shall write messages into the files of batch jobs by sending a
_Job Message Request_
to the batch server that manages the batch job. The
_qmsg_
utility shall not directly write the message into the files of the
batch job.

The
_qmsg_
utility shall send a
_Job Message Request_
for those batch jobs, and only those batch jobs, for which a batch
_job_identifier_
is presented to the utility.

The
_qmsg_
utility shall send
_Job Message Request_s
for batch jobs in the order in which their batch
_job_identifier_s
are presented to the utility.

If the
_qmsg_
utility fails to process any batch
_job_identifier_
successfully, the utility shall proceed to process the remaining batch
_job_identifier_s,
if any.

The
_qmsg_
utility shall not exit before a
_Job Message Request_
has been sent to the server that manages the batch job that corresponds
to each successfully processed batch
_job_identifier_.

<a name="options"></a>

# Options

The
_qmsg_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(miE**  
  Specify that the message is written to the standard error of each batch
  job.

The
_qmsg_
utility shall write the message into the standard error of the batch
job.

* **\(miO**  
  Specify that the message is written to the standard output of each
  batch job.

The
_qmsg_
utility shall write the message into the standard output of the batch
job.

If neither the
**\(miO**
nor the
**\(miE**
option is presented to the
_qmsg_
utility, the utility shall write the message into an
implementation-defined file. The conformance document for the
implementation shall describe the name and location of the
implementation-defined file. If both the
**\(miO**
and the
**\(miE**
options are presented to the
_qmsg_
utility, then the utility shall write the messages to both standard
output and standard error.

<a name="operands"></a>

# Operands

The
_qmsg_
utility shall accept a minimum of two operands,
_message_string_
and one or more batch
_job_identifier_s.

The
_message_string_
operand shall be the string to be written to one or more output files
of the batch job followed by a
&lt;newline&gt;.
If the string contains
&lt;blank&gt;
characters, then the application shall ensure that the string is
quoted. The
_message_string_
shall be encoded in the portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_).

All remaining operands are batch
_job_identifier_s
that conform to the syntax for a batch
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
_qmsg_:

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

None.

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
_qmsg_
utility shall not be required to write a diagnostic message to standard
error when the error reply received from a batch server indicates that
the batch
_job_identifier_
does not exist on the server. Whether or not the
_qmsg_
utility waits to output the diagnostic message while attempting to
locate the job on other servers is implementation-defined.

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
_qmsg_
utility allows users to write messages into the output files of running
jobs. Users, including operators and administrators, have a number of
occasions when they want to place messages in the output files of a
batch job. For example, if a disk that is being used by a batch job is
showing errors, the operator might note this in the standard error
stream of the batch job.

The options of the
_qmsg_
utility provide users with the means of placing the message in the
output stream of their choice. The default output stream for the
message—if the user does not designate an output stream—is
implementation-defined, since many implementations will provide, as
an extension to this volume of POSIX.1-2008, a log file that shows the history of utility
execution.

If users wish to send a message to a set of jobs that meet a selection
criteria, the
_qselect_
utility can be used to acquire the appropriate list of job
identifiers.

The
**\(miE**
option allows users to place the message in the standard error stream
of the batch job.

The
**\(miO**
option allows users to place the message in the standard output stream
of the batch job.

Historically, the
_qmsg_
utility is an existing practice in the offerings of one or more
implementors of an NQS-derived batch system. The utility has been found
to be useful enough that it deserves to be included in this volume of POSIX.1-2008.

<a name="future-directions"></a>

# Future Directions

The
_qmsg_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__qselect_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_,
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
