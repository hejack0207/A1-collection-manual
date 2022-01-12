# qmove(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qmove
— move batch jobs

<a name="synopsis"></a>

# Synopsis

```


```
    qmove destination job_identifier...

<a name="description"></a>

# Description

To move a batch job is to remove the batch job from the batch queue in
which it resides and instantiate the batch job in another batch queue.
A batch job is moved by a request to the batch server that manages the
batch job. The
_qmove_
utility is a user-accessible batch client that requests the movement of
one or more batch jobs.

The
_qmove_
utility shall move those batch jobs, and only those batch jobs, for
which a batch
_job_identifier_
is presented to the utility.

The
_qmove_
utility shall move batch jobs in the order in which the corresponding
batch
_job_identifier_s
are presented to the utility.

If the
_qmove_
utility fails to process a batch
_job_identifier_
successfully, the utility shall proceed to process the remaining batch
_job_identifier_s,
if any.

The
_qmove_
utility shall move batch jobs by sending a
_Move Job Request_
to the batch server that manages each batch job. The
_qmove_
utility shall not exit before the batch jobs corresponding to all
successfully processed batch
_job_identifier_s
have been moved.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The
_qmove_
utility shall accept one operand that conforms to the syntax for a
destination (see
_Section 3.3.2_, _Destination_).

The
_qmove_
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
_qmove_:

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
_qmove_
utility shall not be required to write a diagnostic message to standard
error when the error reply received from a batch server indicates that
the batch
_job_identifier_
does not exist on the server. Whether or not the
_qmove_
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
_qmove_
utility allows users to move jobs between queues.

The alternative to using the
_qmove_
utility—deleting the batch job and requeuing it—entails
considerably more typing.

Since the means of selecting jobs based on attributes has been
encapsulated in the
_qselect_
utility, the only option of the
_qmove_
utility concerns authorization. The
**\(miu**
option provides the user with the convenience of changing the user
identifier under which the batch job will execute. Minimalism and
consistency have taken precedence over convenience; the
**\(miu**
option has been deleted because the equivalent capability exists with
the
**\(miu**
option of the
_qalter_
utility.

<a name="future-directions"></a>

# Future Directions

The
_qmove_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__qalter_\^_,
__qselect_\^_

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
