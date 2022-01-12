# qstat(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qstat
— show status of batch jobs

<a name="synopsis"></a>

# Synopsis

```


```
    qstat [(mif] job_identifier...
    
    qstat (miQ [(mif] destination...
    
    qstat (miB [(mif] server_name...

<a name="description"></a>

# Description

The status of a batch job, batch queue, or batch server is obtained by
a request to the server. The
_qstat_
utility is a user-accessible batch client that requests the status of
one or more batch jobs, batch queues, or servers, and writes the status
information to standard output.

For each successfully processed batch
_job_identifier_,
the
_qstat_
utility shall display information about the corresponding batch job.

For each successfully processed destination, the
_qstat_
utility shall display information about the corresponding batch queue.

For each successfully processed server name, the
_qstat_
utility shall display information about the corresponding server.

The
_qstat_
utility shall acquire batch job status information by sending a
_Job Status Request_
to a batch server. The
_qstat_
utility shall acquire batch queue status information by sending a
_Queue Status Request_
to a batch server. The
_qstat_
utility shall acquire server status information by sending a
_Server Status Request_
to a batch server.

<a name="options"></a>

# Options

The
_qstat_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(mif**  
  Specify that a full display is produced.

The minimum contents of a full display are specified in the STDOUT
section.

Additional contents and format of a full display are
implementation-defined.

* **\(miQ**  
  Specify that the operand is a destination.

The
_qstat_
utility shall display information about each batch queue at each
destination identified as an operand.

* **\(miB**  
  Specify that the operand is a server name.

The
_qstat_
utility shall display information about each server identified as an
operand.

<a name="operands"></a>

# Operands

If the
**\(miQ**
option is presented to the
_qstat_
utility, the utility shall accept one or more operands that conform to
the syntax for a destination (see
_Section 3.3.2_, _Destination_).

If the
**\(miB**
option is presented to the
_qstat_
utility, the utility shall accept one or more
_server_name_
operands.

If neither the
**\(miB**
nor the
**\(miQ**
option is presented to the
_qstat_
utility, the utility shall accept one or more operands that conform to
the syntax for a batch
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
_qstat_:

* _HOME_  
  Determine the pathname of the user's home directory.
* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  the precedence of internationalization variables used to determine the
  values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_COLLATE_    
  Determine the locale for the behavior of ranges, equivalence classes,
  and multi-character collating elements within regular expressions.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _LC\_NUMERIC_    
  Determine the locale for selecting the radix character used when
  writing floating-point formatted output.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

If an operand presented to the
_qstat_
utility is a batch
_job_identifier_
and the
**\(mif**
option is not specified, the
_qstat_
utility shall display the following items on a single line, in the
stated order, with white space between each item, for each successfully
processed operand:

*  *  
  The batch
  _job_identifier_
*  *  
  The batch job name
*  *  
  The
  _Job_Owner_
  attribute
*  *  
  The CPU time used by the batch job
*  *  
  The batch job state
*  *  
  The batch job location

If an operand presented to the
_qstat_
utility is a batch
_job_identifier_
and the
**\(mif**
option is specified, the
_qstat_
utility shall display the following items for each success fully
processed operand:

*  *  
  The batch
  _job_identifier_
*  *  
  The batch job name
*  *  
  The
  _Job_Owner_
  attribute
*  *  
  The execution user ID
*  *  
  The CPU time used by the batch job
*  *  
  The batch job state
*  *  
  The batch job location
*  *  
  Additional implementation-defined information, if any, about the
  batch job or batch queue

If an operand presented to the
_qstat_
utility is a destination, the
**\(miQ**
option is specified, and the
**\(mif**
option is not specified, the
_qstat_
utility shall display the following items on a single line, in the
stated order, with white space between each item, for each successfully
processed operand:

*  *  
  The batch queue name
*  *  
  The maximum number of batch jobs that shall be run in the batch
  queue concurrently
*  *  
  The total number of batch jobs in the batch queue
*  *  
  The status of the batch queue
*  *  
  For each state, the number of batch jobs in that state in the batch
  queue and the name of the state
*  *  
  The type of batch queue (execution or routing)

If the operands presented to the
_qstat_
utility are destinations, the
**\(miQ**
option is specified, and the
**\(mif**
option is specified, the
_qstat_
utility shall display the following items for each successfully
processed operand:

*  *  
  The batch queue name
*  *  
  The maximum number of batch jobs that shall be run in the batch
  queue concurrently
*  *  
  The total number of batch jobs in the batch queue
*  *  
  The status of the batch queue
*  *  
  For each state, the number of batch jobs in that state in the batch
  queue and the name of the state
*  *  
  The type of batch queue (execution or routing)
*  *  
  Additional implementation-defined information, if any, about
  the batch queue

If the operands presented to the
_qstat_
utility are batch server names, the
**\(miB**
option is specified, and the
**\(mif**
option is not specified, the
_qstat_
utility shall display the following items on a single line, in the
stated order, with white space between each item, for each successfully
processed operand:

*  *  
  The batch server name
*  *  
  The maximum number of batch jobs that shall be run in the batch
  queue concurrently
*  *  
  The total number of batch jobs managed by the batch server
*  *  
  The status of the batch server
*  *  
  For each state, the number of batch jobs in that state and the name of
  the state

If the operands presented to the
_qstat_
utility are server names, the
**\(miB**
option is specified, and the
**\(mif**
option is specified, the
_qstat_
utility shall display the following items for each successfully
processed operand:

*  *  
  The server name
*  *  
  The maximum number of batch jobs that shall be run in the batch
  queue concurrently
*  *  
  The total number of batch jobs managed by the server
*  *  
  The status of the server
*  *  
  For each state, the number of batch jobs in that state and the name of
  the state
*  *  
  Additional implementation-defined information, if any, about the server

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
_qstat_
utility shall not be required to write a diagnostic message to standard
error when the error reply received from a batch server indicates that
the batch
_job_identifier_
does not exist on the server. Whether or not the
_qstat_
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
_qstat_
utility allows users to display the status of jobs and list the
batch jobs in queues.

The operands of the
_qstat_
utility may be either job identifiers, queues (specified as destination
identifiers), or batch server names. The
**\(miQ**
and
**\(miB**
options, or absence thereof, indicate the nature of the operands.

The other options of the
_qstat_
utility allow the user to control the amount of information displayed
and the format in which it is displayed. Should a user wish to display
the status of a set of jobs that match a selection criteria, the
_qselect_
utility may be used to acquire such a list.

The
**\(mif**
option allows users to request a \`\`full'' display in an
implementation-defined format.

Historically, the
_qstat_
utility has been a part of the NQS and its derivatives, the existing
practice on which it is based.

<a name="future-directions"></a>

# Future Directions

The
_qstat_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__qselect_\^_

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
