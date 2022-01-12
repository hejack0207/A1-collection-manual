# qhold(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qhold
— hold batch jobs

<a name="synopsis"></a>

# Synopsis

```


```
    qhold [(mih hold_list] job_identifier...

<a name="description"></a>

# Description

A hold is placed on a batch job by a request to the batch server that
manages the batch job. A batch job that has one or more holds is not
eligible for execution. The
_qhold_
utility is a user-accessible client of batch services that requests one
or more types of hold to be placed on one or more batch jobs.

The
_qhold_
utility shall place holds on those batch jobs for which a batch
_job_identifier_
is presented to the utility.

The
_qhold_
utility shall place holds on batch jobs in the order in which their
batch
_job_identifier_s
are presented to the utility. If the
_qhold_
utility fails to process any batch
_job_identifier_
successfully, the utility shall proceed to process the remaining batch
_job_identifier_s,
if any.

The
_qhold_
utility shall place holds on each batch job by sending a
_Hold Job Request_
to the batch server that manages the batch job.

The
_qhold_
utility shall not exit until holds have been placed on the batch job
corresponding to each successfully processed batch
_job_identifier_.

<a name="options"></a>

# Options

The
_qhold_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported by the implementation:

* **\(mih&nbsp;hold\_list**  
  Define the types of holds to be placed on the batch job.

The
_qhold_
**\(mih**
option shall accept a value for the
_hold_list_
option-argument that is a string of alphanumeric characters in the
portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_).

The
_qhold_
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
_qhold_
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
_qhold_
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
_qhold_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters.

An implementation may define other hold types. The conformance document
for an implementation shall describe any additional hold types, how
they are specified, their internal behavior, and how they affect the
behavior of the utility.

If the
**\(mih**
option is not presented to the
_qhold_
utility, the implementation shall set the
_Hold_Types_
attribute to USER.

<a name="operands"></a>

# Operands

The
_qhold_
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
_qhold_:

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
_qhold_
utility shall not be required to write a diagnostic message to standard
error when the error reply received from a batch server indicates that
the batch
_job_identifier_
does not exist on the server. Whether or not the
_qhold_
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
_qhold_
utility allows users to place a hold on one or more jobs. A hold makes
a batch job ineligible for execution.

The
_qhold_
utility has options that allow the user to specify the type of hold.
Should the user wish to place a hold on a set of jobs that meet a
selection criteria, such a list of jobs can be acquired using the
_qselect_
utility.

The
**\(mih**
option allows the user to specify the type of hold that is to be placed
on the job. This option allows for USER, SYSTEM, OPERATOR, and
implementation-defined hold types. The USER and OPERATOR holds are
distinct. The batch server that manages the batch job will verify that
the user is authorized to set the specified hold for the batch job.

Mail is not required on hold because the administrator has the tools
and libraries to build this option if he or she wishes.

Historically, the
_qhold_
utility has been a part of some existing batch systems, although it has
not traditionally been a part of the NQS.

<a name="future-directions"></a>

# Future Directions

The
_qhold_
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
