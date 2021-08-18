# qrls(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qrls
— release batch jobs

<a name="synopsis"></a>

# Synopsis

```


```
    qrls [(mih hold_list] job_identifier...

<a name="description"></a>

# Description

A batch job might have one or more holds, which prevent the batch job
from executing. A batch job from which all the holds have been removed
becomes eligible for execution and is said to have been released. A
batch job hold is removed by sending a request to the batch server that
manages the batch job. The
_qrls_
utility is a user-accessible client of batch services that requests
holds be removed from one or more batch jobs.

The
_qrls_
utility shall remove one or more holds from those batch jobs for which
a batch
_job_identifier_
is presented to the utility.

The
_qrls_
utility shall remove holds from batch jobs in the order in which their
batch
_job_identifier_s
are presented to the utility.

If the
_qrls_
utility fails to process a batch
_job_identifier_
successfully, the utility shall proceed to process the remaining batch
_job_identifier_s,
if any.

The
_qrls_
utility shall remove holds on each batch job by sending a
_Release Job Request_
to the batch server that manages the batch job.

The
_qrls_
utility shall not exit until the holds have been removed from the batch
job corresponding to each successfully processed batch
_job_identifier_.

<a name="options"></a>

# Options

The
_qrls_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported by the implementation:

* **\(mih&nbsp;hold\_list**  
  Define the types of holds to be removed from the batch job.

The
_qrls_
**\(mih**
option shall accept a value for the
_hold_list_
option-argument that is a string of alphanumeric characters in the
portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_).

The
_qrls_
utility shall accept a value for the
_hold_list_
option-argument that is a string of one or more of the characters
**'u'**,
**'s'**,
or
**'o'**,
or the single character
**'n'**.

For each unique character in the
_hold_list_
option-argument, the
_qrls_
utility shall add a value to the
_Hold_Types_
attribute of the batch job as follows, each representing a different
hold type:

* u  
  USER
* s  
  SYSTEM
* OPERATOR

If any of these characters are duplicated in the
_hold_list_
option-argument, the duplicates shall be ignored.

An existing
_Hold_Types_
attribute can be cleared by the following hold type:

* n  
  NO_HOLD

The
_qrls_
utility shall consider it an error if any hold type other than
**'n'**
is combined with hold type
**'n'**.

Strictly conforming applications shall not repeat any of the characters
**'u'**,
**'s'**,
**'o'**,
or
**'n'**
within the
_hold_list_
option-argument. The
_qrls_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters.

An implementation may define other hold types. The conformance document
for an implementation shall describe any additional hold types, how
they are specified, their internal behavior, and how they affect the
behavior of the utility.

If the
**\(mih**
option is not presented to the
_qrls_
utility, the implementation shall remove the USER hold in the
_Hold_Types_
attribute.

<a name="operands"></a>

# Operands

The
_qrls_
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
_qrls_:

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
_qrls_
utility shall not be required to write a diagnostic message to standard
error when the error reply received from a batch server indicates that
the batch
_job_identifier_
does not exist on the server. Whether or not the
_qrls_
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
_qrls_
utility allows users, operators, and administrators to remove holds
from jobs.

The
_qrls_
utility does not support any job selection options or wildcard
arguments. Users may acquire a list of jobs selected by attributes
using the
_qselect_
utility. For example, a user could select all of their held jobs.

The
**\(mih**
option allows the user to specify the type of hold that is to be
removed. This option allows for USER, SYSTEM, OPERATOR, and
implementation-defined hold types. The batch server that manages the
batch job will verify whether the user is authorized to remove the
specified hold for the batch job. If more than one type of hold has
been placed on the batch job, a user may wish to remove only some of
them.

Mail is not required on release because the administrator has the tools
and libraries to build this option if required.

The
_qrls_
utility is a new utility _vis-a-vis_ existing practice; it has been
defined in this volume of POSIX.1-2008 as the natural complement to the
_qhold_
utility.

<a name="future-directions"></a>

# Future Directions

The
_qrls_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__qhold_\^_,
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
