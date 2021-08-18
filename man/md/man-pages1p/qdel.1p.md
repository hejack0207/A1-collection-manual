# qdel(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qdel
— delete batch jobs

<a name="synopsis"></a>

# Synopsis

```


```
    qdel job_identifier...

<a name="description"></a>

# Description

A batch job is deleted by sending a request to the batch server that
manages the batch job. A batch job that has been deleted is no longer
subject to management by batch services.

The
_qdel_
utility is a user-accessible client of batch services that requests the
deletion of one or more batch jobs.

The
_qdel_
utility shall request a batch server to delete those batch jobs for
which a batch
_job_identifier_
is presented to the utility.

The
_qdel_
utility shall delete batch jobs in the order in which their batch
_job_identifier_s
are presented to the utility.

If the
_qdel_
utility fails to process any batch
_job_identifier_
successfully, the utility shall proceed to process the remaining batch
_job_identifier_s,
if any.

The
_qdel_
utility shall delete each batch job by sending a
_Delete Job Request_
to the batch server that manages the batch job.

The
_qdel_
utility shall not exit until the batch job corresponding to each
successfully processed batch
_job_identifier_
has been deleted.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The
_qdel_
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
_qdel_:

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
_qdel_
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
_qdel_
utility shall not be required to write a diagnostic message to standard
error when the error reply received from a batch server indicates that
the batch
_job_identifier_
does not exist on the server. Whether or not the
_qdel_
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
_qdel_
utility allows users and administrators to delete jobs.

The
_qdel_
utility provides functionality that is not otherwise available. For
example, the
_kill_
utility of the operating system does not suffice. First, to use the
_kill_
utility, the user might have to log in on a remote node, because the
_kill_
utility does not operate across the network. Second, unlike
_qdel_,
_kill_
cannot remove jobs from queues. Lastly, the arguments of the
_qdel_
utility are job identifiers rather than process identifiers, and so
this utility can be passed the output of the
_qselect_
utility, thus providing users with a means of deleting a list of jobs.

Because a set of jobs can be selected using the
_qselect_
utility, the
_qdel_
utility has not been complicated with options that provide for
selection of jobs. Instead, the batch jobs to be deleted are identified
individually by their job identifiers.

Historically, the
_qdel_
utility has been a component of NQS, the existing practice on which it
is based. However, the
_qdel_
utility defined in this volume of POSIX.1-2008 does not provide an option for specifying a
signal number to send to the batch job prior to the killing of the
process; that capability has been subsumed by the
_qsig_
utility.

A discussion was held about the delays of networking and the
possibility that the batch server may never respond, due to a down
router, down batch server, or other network mishap. The DESCRIPTION
records this under the words \`\`fails to process any job identifier''.
In the broad sense, the network problem is also an error, which causes
the failure to process the batch job identifier.

<a name="future-directions"></a>

# Future Directions

The
_qdel_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__kill_\^_,
__qselect_\^_,
__qsig_\^_

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
