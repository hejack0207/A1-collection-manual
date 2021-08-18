# qalter(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qalter
— alter batch job

<a name="synopsis"></a>

# Synopsis

```


```
    qalter [(mia date_time] [(miA account_string] [(mic interval] [(mie path_name]
        [(mih hold_list] [(mij join_list] [(mik keep_list] [(mil resource_list]
        [(mim mail_options] [(miM mail_list] [(miN name] [(mio path_name]
        [(mip priority] [(mir y|n] [(miS path_name_list] [(miu user_list]
        job_identifier...

<a name="description"></a>

# Description

The attributes of a batch job are altered by a request to the batch
server that manages the batch job. The
_qalter_
utility is a user-accessible batch client that requests the alteration
of the attributes of one or more batch jobs.

The
_qalter_
utility shall alter the attributes of those batch jobs, and only those
batch jobs, for which a batch
_job_identifier_
is presented to the utility.

The
_qalter_
utility shall alter the attributes of batch jobs in the order in which
the batch
_job_identifier_s
are presented to the utility.

If the
_qalter_
utility fails to process a batch
_job_identifier_
successfully, the utility shall proceed to process the remaining batch
_job_identifier_s,
if any.

For each batch
_job_identifier_
for which the
_qalter_
utility succeeds, each attribute of the identified batch job shall be
altered as indicated by all the options presented to the utility.

For each identified batch job for which the
_qalter_
utility fails, the utility shall not alter any attribute of the batch
job.

For each batch job that the
_qalter_
utility processes, the utility shall not modify any attribute other
than those required by the options and option-arguments presented to
the utility.

The
_qalter_
utility shall alter batch jobs by sending a
_Modify Job Request_
to the batch server that manages each batch job. At the time the
_qalter_
utility exits, it shall have modified the batch job corresponding to
each successfully processed batch
_job_identifier_.
An attempt to alter the attributes of a batch job in the RUNNING state
is implementation-defined.

<a name="options"></a>

# Options

The
_qalter_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(mia&nbsp;date\_time**  
  Redefine the time at which the batch job becomes eligible for
  execution.

The
_date_time_
argument shall be in the same form and represent the same time as for
the
_touch_
utility. The time so represented shall be set into the
_Execution_Time_
attribute of the batch job. If the time specified is earlier than the
current time, the
**\(mia**
option shall have no effect.

* **\(miA&nbsp;account\_string**    
  Redefine the account to which the resource consumption of the batch job
  should be charged.

The syntax of the
_account_string_
option-argument is unspecified.

The
_qalter_
utility shall set the
_Account_Name_
attribute of the batch job to the value of the
_account_string_
option-argument.

* **\(mic&nbsp;interval**  
  Redefine whether the batch job should be checkpointed, and if so, how
  often.

The
_qalter_
utility shall accept a value for the interval option-argument that is
one of the following:

* n  
  No checkpointing is to be performed on the batch job
  (NO_CHECKPOINT).
* s  
  Checkpointing is to be performed only when the batch server is shut
  down (CHECKPOINT_AT_SHUTDOWN).
* c  
  Automatic periodic checkpointing is to be performed at the
  _Minimum_Cpu_Interval_
  attribute of the batch queue, in units of CPU minutes
  (CHECKPOINT_AT_MIN_CPU_INTERVAL).
* c=_minutes_  
  Automatic periodic checkpointing is to be performed every
  _minutes_
  of CPU time, or every
  _Minimum_Cpu_Interval_
  minutes, whichever is greater. The
  _minutes_
  argument shall conform to the syntax for unsigned integers and shall be
  greater than zero.

An implementation may define other checkpoint intervals. The
conformance document for an implementation shall describe any
alternative checkpoint intervals, how they are specified, their
internal behavior, and how they affect the behavior of the utility.

The
_qalter_
utility shall set the
_Checkpoint_
attribute of the batch job to the value of the
_interval_
option-argument.

* **\(mie&nbsp;path\_name**    
  Redefine the path to be used for the standard error stream of the batch
  job.

The
_qalter_
utility shall accept a
_path_name_
option-argument that conforms to the syntax of the
_path_name_
element defined in the System Interfaces volume of POSIX.1-2008, which can be preceded by a host name
element of the form
_hostname_:.

If the
_path_name_
option-argument constitutes an absolute pathname, the
_qalter_
utility shall set the
_Error_Path_
attribute of the batch job to the value of the
_path_name_
option-argument, including the host name element, if present.

If the
_path_name_
option-argument constitutes a relative pathname and no host name
element is specified, the
_qalter_
utility shall set the
_Error_Path_
attribute of the batch job to the value of the absolute pathname
derived by expanding the
_path_name_
option-argument relative to the current directory of the process that
executes the
_qalter_
utility.

If the
_path_name_
option-argument constitutes a relative pathname and a host name
element is specified, the
_qalter_
utility shall set the
_Error_Path_
attribute of the batch job to the value of the option-argument without
expansion.

If the
_path_name_
option-argument does not include a host name element, the
_qalter_
utility shall prefix the pathname in the
_Error_Path_
attribute with
_hostname_:,
where
_hostname_
is the name of the host upon which the
_qalter_
utility is being executed.

* **\(mih&nbsp;hold\_list**  
  Redefine the types of holds, if any, on the batch job. The
  _qalter_
  **\(mih**
  option shall accept a value for the
  _hold_list_
  option-argument that is a string of alphanumeric characters in the
  portable character set.

The
_qalter_
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
_qalter_
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
option-argument, the duplicates shall be ignored. An existing
_Hold_Types_
attribute can be cleared by the hold type:

* n  
  NO_HOLD

The
_qalter_
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
_qalter_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters. An implementation may
define other hold types. The conformance document for an implementation
shall describe any additional hold types, how they are specified, their
internal behavior, and how they affect the behavior of the utility.

* **\(mij&nbsp;join\_list**  
  Redefine which streams of the batch job are to be merged. The
  _qalter_
  **\(mij**
  option shall accept a value for the
  _join_list_
  option-argument that is a string of alphanumeric characters in the
  portable character set.

The
_qalter_
utility shall accept a
_join_list_
option-argument that consists of one or more of the characters
**'e'**
and
**'o'**,
or the single character
**'n'**.

All of the other batch job output streams specified shall be merged
into the output stream represented by the character listed first in the
_join_list_
option-argument.

For each unique character in the
_join_list_
option-argument, the
_qalter_
utility shall add a value to the
_Join_Path_
attribute of the batch job as follows, each representing a different
batch job stream to join:

* e  
  The standard error of the batch job (JOIN_STD_ERROR).
* The standard output of the batch job (JOIN_STD_OUTPUT).

An existing
_Join_Path_
attribute can be cleared by the join type:

* n  
  NO_JOIN

If
**'n'**
is specified, then no files are joined. The
_qalter_
utility shall consider it an error if any join type other than
**'n'**
is combined with join type
**'n'**.

Strictly conforming applications shall not repeat any of the characters
**'e'**,
**'o'**,
or
**'n'**
within the
_join_list_
option-argument. The
_qalter_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters.

An implementation may define other join types. The conformance document
for an implementation shall describe any additional batch job streams,
how they are specified, their internal behavior, and how they affect
the behavior of the utility.

* **\(mik&nbsp;keep\_list**  
  Redefine which output of the batch job to retain on the execution host.

The
_qalter_
**\(mik**
option shall accept a value for the
_keep_list_
option-argument that is a string of alphanumeric characters in the
portable character set.

The
_qalter_
utility shall accept a
_keep_list_
option-argument that consists of one or more of the characters
**'e'**
and
**'o'**,
or the single character
**'n'**.

For each unique character in the
_keep_list_
option-argument, the
_qalter_
utility shall add a value to the
_Keep_Files_
attribute of the batch job as follows, each representing a different
batch job stream to keep:

* e  
  The standard error of the batch job (KEEP_STD_ERROR).
* The standard output of the batch job (KEEP_STD_OUTPUT).

If both
**'e'**
and
**'o'**
are specified, then both files are retained. An existing
_Keep_Files_
attribute can be cleared by the keep type:

* n  
  NO_KEEP

If
**'n'**
is specified, then no files are retained. The
_qalter_
utility shall consider it an error if any keep type other than
**'n'**
is combined with keep type
**'n'**.

Strictly conforming applications shall not repeat any of the characters
**'e'**,
**'o'**,
or
**'n'**
within the
_keep_list_
option-argument. The
_qalter_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters. An implementation may
define other keep types. The conformance document for an implementation
shall describe any additional keep types, how they are specified, their
internal behavior, and how they affect the behavior of the utility.

* **\(mil&nbsp;resource\_list**    
  Redefine the resources that are allowed or required by the batch job.

The
_qalter_
utility shall accept a
_resource_list_
option-argument that conforms to the following syntax:

    
    resource=value[,,resource=value,,...]


The
_qalter_
utility shall set one entry in the value of the
_Resource_List_
attribute of the batch job for each resource listed in the
_resource_list_
option-argument.

Because the list of supported resource names might vary by batch
server, the
_qalter_
utility shall rely on the batch server to validate the resource names
and associated values. See
_Section 3.3.3_, _Multiple Keyword-Value Pairs_
for a means of removing
_keyword_=\c
_value_
(and
_value_@\c
_keyword_)
pairs and other general rules for list-oriented batch job attributes.

* **\(mim&nbsp;mail\_options**    
  Redefine the points in the execution of the batch job at which the
  batch server is to send mail about a change in the state of the batch
  job.

The
_qalter_
**\(mim**
option shall accept a value for the
_mail_options_
option-argument that is a string of alphanumeric characters in the
portable character set.

The
_qalter_
utility shall accept a value for the
_mail_options_
option-argument that is a string of one or more of the characters
**'e'**,
**'b'**,
and
**'a'**,
or the single character
**'n'**.
For each unique character in the
_mail_options_
option-argument, the
_qalter_
utility shall add a value to the
_Mail_Users_
attribute of the batch job as follows, each representing a different
time during the life of a batch job at which to send mail:

* e  
  MAIL_AT_EXIT
* b  
  MAIL_AT_BEGINNING
* a  
  MAIL_AT_ABORT

If any of these characters are duplicated in the
_mail_options_
option-argument, the duplicates shall be ignored.

An existing
_Mail_Points_
attribute can be cleared by the mail type:

* n  
  NO_MAIL

If
**'n'**
is specified, then mail is not sent. The
_qalter_
utility shall consider it an error if any mail type other than
**'n'**
is combined with mail type
**'n'**.
Strictly conforming applications shall not repeat any of the characters
**'e'**,
**'b'**,
**'a'**,
or
**'n'**
within the
_mail_options_
option-argument. The
_qalter_
utility shall permit the repetition of characters but shall not assign
additional meaning to the repeated characters.

An implementation may define other mail types. The conformance document
for an implementation shall describe any additional mail types, how
they are specified, their internal behavior, and how they affect the
behavior of the utility.

* **\(miM&nbsp;mail\_list**  
  Redefine the list of users to which the batch server that executes the
  batch job is to send mail, if the batch server sends mail about the
  batch job.

The syntax of the
_mail_list_
option-argument is unspecified. If the implementation of the
_qalter_
utility uses a name service to locate users, the utility shall accept
the syntax used by the name service.

If the implementation of the
_qalter_
utility does not use a name service to locate users, the implementation
shall accept the following syntax for user names:

    
    mail_address[,,mail_address,,...]


The interpretation of
_mail_address_
is implementation-defined.

The
_qalter_
utility shall set the
_Mail_Users_
attribute of the batch job to the value of the
_mail_list_
option-argument.

* **\(miN&nbsp;name**  
  Redefine the name of the batch job.

The
_qalter_
**\(miN**
option shall accept a value for the
_name_
option-argument that is a string of up to 15 alphanumeric characters in
the portable character set where the first character is alphabetic.

The syntax of the
_name_
option-argument is unspecified.

The
_qalter_
utility shall set the
_Job_Name_
attribute of the batch job to the value of the
_name_
option-argument.

* **\(mio&nbsp;path\_name**    
  Redefine the path for the standard output of the batch job.

The
_qalter_
utility shall accept a
_path_name_
option-argument that conforms to the syntax of the
_path_name_
element defined in the System Interfaces volume of POSIX.1-2008, which can be preceded by a host name
element of the form
_hostname_:.

If the
_path_name_
option-argument constitutes an absolute pathname, the
_qalter_
utility shall set the
_Output_Path_
attribute of the batch job to the value of the
_path_name_
option-argument.

If the
_path_name_
option-argument constitutes a relative pathname and no host name
element is specified, the
_qalter_
utility shall set the
_Output_Path_
attribute of the batch job to the absolute pathname derived by
expanding the
_path_name_
option-argument relative to the current directory of the process that
executes the
_qalter_
utility.

If the
_path_name_
option-argument constitutes a relative pathname and a host name
element is specified, the
_qalter_
utility shall set the
_Output_Path_
attribute of the batch job to the value of the
_path_name_
option-argument without any expansion of the pathname.

If the
_path_name_
option-argument does not include a host name element, the
_qalter_
utility shall prefix the pathname in the
_Output_Path_
attribute with
_hostname_:,
where
_hostname_
is the name of the host upon which the
_qalter_
utility is being executed.

* **\(mip&nbsp;priority**  
  Redefine the priority of the batch job.

The
_qalter_
utility shall accept a value for the priority option-argument that
conforms to the syntax for signed decimal integers, and which is not
less than \(mi1\|024 and not greater than 1\|023.

The
_qalter_
utility shall set the
_Priority_
attribute of the batch job to the value of the
_priority_
option-argument.

* **\(mir&nbsp;**y|n  
  Redefine whether the batch job is rerunnable.

If the value of the option-argument is
**'y'**,
the
_qalter_
utility shall set the
_Rerunable_
attribute of the batch job to TRUE.

If the value of the option-argument is
**'n'**,
the
_qalter_
utility shall set the
_Rerunable_
attribute of the batch job to FALSE.

The
_qalter_
utility shall consider it an error if any character other than
**'y'**
or
**'n'**
is specified in the option-argument.

* **\(miS&nbsp;path\_name\_list**    
  Redefine the shell that interprets the script at the destination
  system.

The
_qalter_
utility shall accept a
_path_name_list_
option-argument that conforms to the following syntax:

    
    pathname[@host][,pathname[@host],...]


The
_qalter_
utility shall accept only one pathname that is missing a corresponding
host name. The
_qalter_
utility shall allow only one pathname per named host.

The
_qalter_
utility shall add a value to the
_Shell_Path_List_
attribute of the batch job for each entry in the
_path_name_list_
option-argument. See
_Section 3.3.3_, _Multiple Keyword-Value Pairs_
for a means of removing
_keyword_=\c
_value_
(and
_value_@\c
_keyword_)
pairs and other general rules for list-oriented batch job attributes.

* **\(miu&nbsp;user\_list**  
  Redefine the user name under which the batch job is to run at the
  destination system.

The
_qalter_
utility shall accept a
_user_list_
option-argument that conforms to the following syntax:

    
    username[@host][,,username[@host],,...]


The
_qalter_
utility shall accept only one user name that is missing a corresponding
host name. The
_qalter_
utility shall accept only one user name per named host.

The
_qalter_
utility shall add a value to the
_User_List_
attribute of the batch job for each entry in the
_user_list_
option-argument. See
_Section 3.3.3_, _Multiple Keyword-Value Pairs_
for a means of removing
_keyword_=\c
_value_
(and
_value_@\c
_keyword_)
pairs and other general rules for list-oriented batch job attributes.

<a name="operands"></a>

# Operands

The
_qalter_
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
_qalter_:

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
* _TZ_  
  Determine the timezone used to interpret the
  _date-time_
  option-argument. If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

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
_qalter_
utility shall not be required to write a diagnostic message to standard
error when the error reply received from a batch server indicates that
the batch
_job_identifier_
does not exist on the server. Whether or not the
_qalter_
utility attempts to locate the batch job on other batch servers is
implementation-defined.

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
_qalter_
utility allows users to change the attributes of a batch job.

As a means of altering a queued job, the
_qalter_
utility is superior to deleting and requeuing the batch job insofar as
an altered job retains its place in the queue with some traditional
selection algorithms. In addition, the
_qalter_
utility is both shorter and simpler than a sequence of
_qdel_
and
_qsub_
utilities.

The result of an attempt on the part of a user to alter a batch job in
a RUNNING state is implementation-defined because a batch job in the
RUNNING state will already have opened its output files and otherwise
performed any actions indicated by the options in effect at the time
the batch job began execution.

The options processed by the
_qalter_
utility are identical to those of the
_qsub_
utility, with a few exceptions:
**\(miV**,
**\(miv**,
and
**\(miq**.
The
**\(miV**
and
**\(miv**
are inappropriate for the
_qalter_
utility, since they capture potentially transient environment
information from the submitting process. The
**\(miq**
option would specify a new queue, which would largely negate the
previously stated advantage of using
_qalter_;
furthermore, the
_qmove_
utility provides a superior means of moving jobs.

Each of the following paragraphs provides the rationale for a
_qalter_
option.

Additional rationale concerning these options can be found in the
rationale for the
_qsub_
utility.

The
**\(mia**
option allows users to alter the date and time at which a batch job
becomes eligible to run.

The
**\(miA**
option allows users to change the account that will be charged for the
resources consumed by the batch job. Support for the
**\(miA**
option is mandatory for conforming implementations of
_qalter_,
even though support of accounting is optional for servers. Whether or
not to support accounting is left to the implementor of the server, but
mandatory support of the
**\(miA**
option assures users of a consistent interface and allows them to
control accounting on servers that support accounting.

The
**\(mic**
option allows users to alter the checkpointing interval of a batch
job. A checkpointing system, which is not defined by POSIX.1-2008, allows
recovery of a batch job at the most recent checkpoint in the event of a
crash. Checkpointing is typically used for jobs that consume expensive
computing time or must meet a critical schedule. Users should be
allowed to make the tradeoff between the overhead of checkpointing and
the risk to the timely completion of the batch job; therefore, this volume of POSIX.1-2008
provides the checkpointing interval option. Support for checkpointing
is optional for servers.

The
**\(mie**
option allows users to alter the name and location of the standard
error stream written by a batch job. However, the path of the standard
error stream is meaningless if the value of the
_Join_Path_
attribute of the batch job is TRUE.

The
**\(mih**
option allows users to set the hold type in the
_Hold_Types_
attribute of a batch job. The
_qhold_
and
_qrls_
utilities add or remove hold types to the
_Hold_Types_
attribute, respectively. The
**\(mih**
option has been modified to allow for implementation-defined hold
types.

The
**\(mij**
option allows users to alter the decision to join (merge) the standard
error stream of the batch job with the standard output stream of the
batch job.

The
**\(mil**
option allows users to change the resource limits imposed on a batch
job.

The
**\(mim**
option allows users to modify the list of points in the life of a batch
job at which the designated users will receive mail notification.

The
**\(miM**
option allows users to alter the list of users who will receive
notification about events in the life of a batch job.

The
**\(miN**
option allows users to change the name of a batch job.

The
**\(mio**
option allows users to alter the name and path to which the standard
output stream of the batch job will be written.

The
**\(miP**
option allows users to modify the priority of a batch job. Support for
priority is optional for batch servers.

The
**\(mir**
option allows users to alter the rerunability status of a batch job.

The
**\(miS**
option allows users to change the name and location of the shell image
that will be invoked to interpret the script of the batch job. This
option has been modified to allow a list of shell name and locations
associated with different hosts.

The
**\(miu**
option allows users to change the user identifier under which the batch
job will execute.

The
_job_identifier_
operand syntax is provided so that the user can differentiate between
the originating and destination (or executing) batch server. These may
or may not be the same. The .\c
_server_name_
portion identifies the originating batch server, while the @\c
_server_
portion identifies the destination batch server.

Historically, the
_qalter_
utility has been a component of the Network Queuing System (NQS), the
existing practice from which this utility has been derived.

<a name="future-directions"></a>

# Future Directions

The
_qalter_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__qdel_\^_,
__qhold_\^_,
__qmove_\^_,
__qrls_\^_,
__qsub_\^_,
__touch_\^_

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
