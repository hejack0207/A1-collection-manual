# qselect(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qselect
— select batch jobs

<a name="synopsis"></a>

# Synopsis

```


```
    qselect [(mia [op]date_time] [(miA account_string] [(mic [op]interval]
        [(mih hold_list] [(mil resource_list] [(miN name] [(mip [op]priority]
        [(miq destination] [(mir y|n] [(mis states] [(miu user_list]

<a name="description"></a>

# Description

To select a set of batch jobs is to return the batch
_job_identifier_s
for each batch job that meets a list of selection criteria. A set of
batch jobs is selected by a request to a batch server. The
_qselect_
utility is a user-accessible batch client that requests the selection
of batch jobs.

Upon successful completion, the
_qselect_
utility shall have returned a list of zero or more batch
_job_identifier_s
that meet the criteria specified by the options and option-arguments
presented to the utility.

The
_qselect_
utility shall select batch jobs by sending a
_Select Jobs Request_
to a batch server. The
_qselect_
utility shall not exit until the server replies to each request
generated.

For each option presented to the
_qselect_
utility, the utility shall restrict the set of selected batch jobs as
described in the OPTIONS section.

The
_qselect_
utility shall not restrict selection of batch jobs except by
authorization and as required by the options presented to the utility.

When an option is specified with a mandatory or optional
_op_
component to the option-argument, then
_op_
shall specify a relation between the value of a certain batch job
attribute and the
_value_
component of the option-argument. If an
_op_
is allowable on an option, then the description of the option letter
indicates the
_op_
as either mandatory or optional. Acceptable strings for the
_op_
component, and the relation the string indicates, are shown in the
following list:

* .eq.  
  The value represented by the attribute of the batch job is equal to the
  value represented by the option-argument.
* .ge.  
  The value represented by the attribute of the batch job is greater than
  or equal to the value represented by the option-argument.
* .gt.  
  The value represented by the attribute of the batch job is greater than
  the value represented by the option-argument.
* .lt.  
  The value represented by the attribute of the batch job is less than
  the value represented by the option-argument.
* .le.  
  The value represented by the attribute of the batch job is less than or
  equal to the value represented by the option-argument.
* .ne.  
  The value represented by the attribute of the batch job is not equal to
  the value represented by the option-argument.

<a name="options"></a>

# Options

The
_qselect_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(mia&nbsp;[op]date\_time**    
  Restrict selection to a specific time, or a range of times.

The
_qselect_
utility shall select only batch jobs for which the value of the
_Execution_Time_
attribute is related to the Epoch equivalent of the local time
expressed by the value of the
_date_time_
component of the option-argument in the manner indicated by the value
of the
_op_
component of the option-argument.

The
_qselect_
utility shall accept a
_date_time_
component of the option-argument that conforms to the syntax of the
_time_
operand of the
_touch_
utility.

If the
_op_
component of the option-argument is not presented to the
_qselect_
utility, the utility shall select batch jobs for which the
_Execution_Time_
attribute is equal to the
_date_time_
component of the option-argument.

When comparing times, the
_qselect_
utility shall use the following definitions for the
_op_
component of the option-argument:

* .eq.  
  The time represented by value of the
  _Execution_Time_
  attribute of the batch job is equal to the time represented by the
  _date_time_
  component of the option-argument.
* .ge.  
  The time represented by value of the
  _Execution_Time_
  attribute of the batch job is after or equal to the time represented by
  the
  _date_time_
  component of the option-argument.
* .gt.  
  The time represented by value of the
  _Execution_Time_
  attribute of the batch job is after the time represented by the
  _date_time_
  component of the option-argument.
* .lt.  
  The time represented by value of the
  _Execution_Time_
  attribute of the batch job is before the time represented by the
  _date_time_
  component of the option-argument.
* .le.  
  The time represented by value of the
  _Execution_Time_
  attribute of the batch job is before or equal to the time represented
  by the
  _date_time_
  component of the option-argument.
* .ne.  
  The time represented by value of the
  _Execution_Time_
  attribute of the batch job is not equal to the time represented by the
  _date_time_
  component of the option-argument.

The
_qselect_
utility shall accept the defined character strings for the
_op_
component of the option-argument.

* **\(miA&nbsp;account\_string**    
  Restrict selection to the batch jobs charging a specified account.

The
_qselect_
utility shall select only batch jobs for which the value of the
_Account_Name_
attribute of the batch job matches the value of the
_account_string_
option-argument.

The syntax of the
_account_string_
option-argument is unspecified.

* **\(mic&nbsp;[op]interval**    
  Restrict selection to batch jobs within a range of checkpoint
  intervals.

The
_qselect_
utility shall select only batch jobs for which the value of the
_Checkpoint_
attribute relates to the value of the
_interval_
component of the option-argument in the manner indicated by the value
of the
_op_
component of the option-argument.

If the
_op_
component of the option-argument is omitted, the
_qselect_
utility shall select batch jobs for which the value of the
_Checkpoint_
attribute is equal to the value of the
_interval_
component of the option-argument.

When comparing checkpoint intervals, the
_qselect_
utility shall use the following definitions for the
_op_
component of the option-argument:

* .eq.  
  The value of the
  _Checkpoint_
  attribute of the batch job equals the value of the
  _interval_
  component of the option-argument.
* .ge.  
  The value of the
  _Checkpoint_
  attribute of the batch job is greater than or equal to the value of the
  _interval_
  component option-argument.
* .gt.  
  The value of the
  _Checkpoint_
  attribute of the batch job is greater than the value of the
  _interval_
  component option-argument.
* .lt.  
  The value of the
  _Checkpoint_
  attribute of the batch job is less than the value of the
  _interval_
  component option-argument.
* .le.  
  The value of the
  _Checkpoint_
  attribute of the batch job is less than or equal to the value of the
  _interval_
  component option-argument.
* .ne.  
  The value of the
  _Checkpoint_
  attribute of the batch job does not equal the value of the
  _interval_
  component option-argument.

The
_qselect_
utility shall accept the defined character strings for the
_op_
component of the option-argument.

The ordering relationship for the values of the interval
option-argument is defined to be:

    
    `n' .gt. `s' .gt. `c=minutes' .ge. `c'

When comparing
_Checkpoint_
attributes with an interval having the value of the single character
**'u'**,
only equality or inequality are valid comparisons.

* **\(mih&nbsp;hold\_list**  
  Restrict selection to batch jobs that have a specific type of hold.

The
_qselect_
utility shall select only batch jobs for which the value of the
_Hold_Types_
attribute matches the value of the
_hold_list_
option-argument.

The
_qselect_
**\(mih**
option shall accept a value for the
_hold_list_
option-argument that is a string of alphanumeric characters in the
portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_).

The
_qselect_
utility shall accept a value for the
_hold_list_
option-argument that is a string of one or more of the characters
**'u'**,
**'s'**,
or
**'o'**,
or the single character
**'n'**.

Each unique character in the
_hold_list_
option-argument of the
_qselect_
utility is defined as follows, each representing a different hold type:

* u  
  USER
* s  
  SYSTEM
* OPERATOR

If any of these characters are duplicated in the
_hold_list_
option-argument, the duplicates shall be ignored.

The
_qselect_
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
_qselect_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters.

An implementation may define other hold types. The conformance document
for an implementation shall describe any additional hold types, how
they are specified, their internal behavior, and how they affect the
behavior of the utility.

* **\(mil&nbsp;resource\_list**    
  Restrict selection to batch jobs with specified resource limits and
  attributes.

The
_qselect_
utility shall accept a
_resource_list_
option-argument with the following syntax:

    
    resource_name op value [,,resource_name op value,, ...]


When comparing resource values, the
_qselect_
utility shall use the following definitions for the
_op_
component of the option-argument:

* .eq.  
  The value of the resource of the same name in the
  _Resource_List_
  attribute of the batch job equals the value of the value component of
  the option-argument.
* .ge.  
  The value of the resource of the same name in the
  _Resource_List_
  attribute of the batch job is greater than or equal to the value of the
  _value_
  component of the option-argument.
* .gt.  
  The value of the resource of the same name in the
  _Resource_List_
  attribute of the batch job is greater than the value of the value
  component of the option-argument.
* .lt.  
  The value of the resource of the same name in the
  _Resource_List_
  attribute of the batch job is less than the value of the value
  component of the option-argument.
* .ne.  
  The value of the resource of the same name in the
  _Resource_List_
  attribute of the batch job does not equal the value of the value
  component of the option-argument.
* .le.  
  The value of the resource of the same name in the
  _Resource_List_
  attribute of the batch job is less than or equal to the value of the
  _value_
  component of the option-argument.

When comparing the limit of a
_Resource_List_
attribute with the
_value_
component of the option-argument, if the limit, the value, or both are
non-numeric, only equality or inequality are valid comparisons.

The
_qselect_
utility shall select only batch jobs for which the values of the
_resource_name_s
listed in the
_resource_list_
option-argument match the corresponding limits of the
_Resource_List_
attribute of the batch job.

Limits of
_resource_name_s
present in the
_Resource_List_
attribute of the batch job that have no corresponding values in the
_resource_list_
option-argument shall not be considered when selecting batch jobs.

* **\(miN&nbsp;name**  
  Restrict selection to batch jobs with a specified name.

The
_qselect_
utility shall select only batch jobs for which the value of the
_Job_Name_
attribute matches the value of the
_name_
option-argument. The string specified in the
_name_
option-argument shall be passed, uninterpreted, to the server. This
allows an implementation to match \`\`wildcard'' patterns against batch
job names.

An implementation shall describe in the conformance document the format
it supports for matching against the
_Job_Name_
attribute.

* **\(mip&nbsp;[op]priority**    
  Restrict selection to batch jobs of the specified priority or range of
  priorities.

The
_qselect_
utility shall select only batch jobs for which the value of the
_Priority_
attribute of the batch job relates to the value of the
_priority_
component of the option-argument in the manner indicated by the value
of the
_op_
component of the option-argument.

If the
_op_
component of the option-argument is omitted, the
_qselect_
utility shall select batch jobs for which the value of the
_Priority_
attribute of the batch job is equal to the value of the
_priority_
component of the option-argument.

When comparing priority values, the
_qselect_
utility shall use the following definitions for the
_op_
component of the option-argument:

* .eq.  
  The value of the
  _Priority_
  attribute of the batch job equals the value of the
  _priority_
  component of the option-argument.
* .ge.  
  The value of the
  _Priority_
  attribute of the batch job is greater than or equal to the value of the
  _priority_
  component option-argument.
* .gt.  
  The value of the
  _Priority_
  attribute of the batch job is greater than the value of the
  _priority_
  component option-argument.
* .lt.  
  The value of the
  _Priority_
  attribute of the batch job is less than the value of the
  _priority_
  component option-argument.
* .lt.  
  The value of the
  _Priority_
  attribute of the batch job is less than or equal to the value of the
  _priority_
  component option-argument.
* .ne.  
  The value of the
  _Priority_
  attribute of the batch job does not equal the value of the
  _priority_
  component option-argument.

* **\(miq&nbsp;destination**    
  Restrict selection to the specified batch queue or server, or both.

The
_qselect_
utility shall select only batch jobs that are located at the
destination indicated by the value of the
_destination_
option-argument.

The destination defines a batch queue, a server, or a batch queue at a
server.

The
_qselect_
utility shall accept an option-argument for the
**\(miq**
option that conforms to the syntax for a destination. If the
**\(miq**
option is not presented to the
_qselect_
utility, the utility shall select batch jobs from all batch queues at
the default batch server.

If the option-argument describes only a batch queue, the
_qselect_
utility shall select only batch jobs from the batch queue of the
specified name at the default batch server. The means by which
_qselect_
determines the default server is implementation-defined.

If the option-argument describes only a batch server, the
_qselect_
utility shall select batch jobs from all the batch queues at that batch
server.

If the option-argument describes both a batch queue and a batch server,
the
_qselect_
utility shall select only batch jobs from the specified batch queue at
the specified server.

* **\(mir&nbsp;**y|n  
  Restrict selection to batch jobs with the specified rerunability
  status.

The
_qselect_
utility shall select only batch jobs for which the value of the
_Rerunable_
attribute of the batch job matches the value of the option-argument.

The
_qselect_
utility shall accept a value for the option-argument that consists of
either the single character
**'y'**
or the single character
**'n'**.
The character
**'y'**
represents the value TRUE, and the character
**'n'**
represents the value FALSE.

* **\(mis&nbsp;states**  
  Restrict selection to batch jobs in the specified states.

The
_qselect_
utility shall accept an option-argument that consists of any
combination of the characters
**'e'**,
**'q'**,
**'r'**,
**'w'**,
**'h'**,
and
**'t'**.

Conforming applications shall not repeat any character in the
option-argument. The
_qselect_
utility shall permit the repetition of characters in the
option-argument, but shall not assign additional meaning to repeated
characters.

The
_qselect_
utility shall interpret the characters in the
_states_
option-argument as follows:

* e  
  Represents the EXITING state.
* q  
  Represents the QUEUED state.
* r  
  Represents the RUNNING state.
* t  
  Represents the TRANSITING state.
* h  
  Represents the HELD state.
* w  
  Represents the WAITING state.

For each character in the
_states_
option-argument, the
_qselect_
utility shall select batch jobs in the corresponding state.

* **\(miu&nbsp;user\_list**  
  Restrict selection to batch jobs owned by the specified user names.

The
_qselect_
utility shall select only the batch jobs of those users specified in
the
_user_list_
option-argument.

The
_qselect_
utility shall accept a
_user_list_
option-argument that conforms to the following syntax:

    
    username[@host][,,username[@host],, ...]


The
_qselect_
utility shall accept only one user name that is missing a corresponding
host name. The
_qselect_
utility shall accept only one user name per named host.

<a name="operands"></a>

# Operands

None.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_qselect_:

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

The
_qselect_
utility shall write zero or more batch
_job_identifier_s
to standard output.

The
_qselect_
utility shall separate the batch
_job_identifier_s
written to standard output by white space.

The
_qselect_
utility shall write batch
_job_identifier_s
in the following format:

    
    sequence_number.server_name@server


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

None.

<a name="examples"></a>

# Examples

The following example shows how a user might use the
_qselect_
utility in conjunction with the
_qdel_
utility to delete all of his or her jobs in the queued state without
affecting any jobs that are already running:

    
    qdel $(qselect (mis q)


or:

    
    qselect (mis q || xargs qdel


<a name="rationale"></a>

# Rationale

The
_qselect_
utility allows users to acquire a list of job identifiers that match
user-specified selection criteria. The list of identifiers returned by
the
_qselect_
utility conforms to the syntax of the batch job identifier list
processed by a utility such as
_qmove_,
_qdel_,
and
_qrls_.
The
_qselect_
utility is thus a powerful tool for causing another batch system
utility to act upon a set of jobs that match a list of selection
criteria.

The options of the
_qselect_
utility let the user apply a number of useful filters for selecting
jobs. Each option further restricts the selection of jobs. Many of the
selection options allow the specification of a relational operator. The
FORTRAN-like syntax of the operator—that is,
**".lt."**—\c
was chosen rather than the C-like
**"&lt;="**
meta-characters.

The
**\(mia**
option allows users to restrict the selected jobs to those that have
been submitted (or altered) to wait until a particular time. The time
period is determined by the argument of this option, which includes
both a time and an operator—it is thus possible to select jobs
waiting until a specific time, jobs waiting until after a certain time,
or those waiting for a time before the specified time.

The
**\(miA**
option allows users to restrict the selected jobs to those that have
been submitted (or altered) to charge a particular account.

The
**\(mic**
option allows users to restrict the selected jobs to those whose
checkpointing interval falls within the specified range.

The
**\(mil**
option allows users to select those jobs whose resource limits fall
within the range indicated by the value of the option. For example, a
user could select those jobs for which the CPU time limit is greater
than two hours.

The
**\(miN**
option allows users to select jobs by job name. For instance, all the
parts of a task that have been divided in parallel jobs might be given
the same name, and thus manipulated as a group by means of this
option.

The
**\(miq**
option allows users to select jobs in a specified queue.

The
**\(mir**
option allows users to select only those jobs with a specified rerun
criteria. For instance, a user might select only those jobs that can be
rerun for use with the
_qrerun_
utility.

The
**\(mis**
option allows users to select only those jobs that are in a certain
state.

The
**\(miu**
option allows users to select jobs that have been submitted to execute
under a particular account.

The selection criteria provided by the options of the
_qselect_
utility allow users to select jobs based on all the appropriate
attributes that can be assigned to jobs by the
_qsub_
utility.

Historically, the
_qselect_
utility has not been a part of existing practice; it is an improvement
that has been introduced in this volume of POSIX.1-2008.

<a name="future-directions"></a>

# Future Directions

The
_qselect_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__qdel_\^_,
__qrerun_\^_,
__qrls_\^_,
__qselect_\^_,
__qsub_\^_,
__touch_\^_

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
