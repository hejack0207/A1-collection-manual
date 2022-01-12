# qsub(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

qsub
— submit a script

<a name="synopsis"></a>

# Synopsis

```


```
    qsub [(mia date_time] [(miA account_string] [(mic interval]
        [(miC directive_prefix] [(mie path_name] [(mih] [(mij join_list]
        [(mik keep_list] [(mim mail_options] [(miM mail_list] [(miN name]
        [(mio path_name] [(mip priority] [(miq destination] [(mir y|n]
        [(miS path_name_list] [(miu user_list] [(miv variable_list] [(miV]
        [(miz] [script]

<a name="description"></a>

# Description

To submit a script is to create a batch job that executes the script. A
script is submitted by a request to a batch server. The
_qsub_
utility is a user-accessible batch client that submits a script.

Upon successful completion, the
_qsub_
utility shall have created a batch job that will execute the submitted
script.

The
_qsub_
utility shall submit a script by sending a
_Queue Job Request_
to a batch server.

The
_qsub_
utility shall place the value of the following environment variables in
the
_Variable_List_
attribute of the batch job:
_HOME_,
_LANG_,
_LOGNAME_,
_PATH_,
_MAIL_,
_SHELL_,
and
_TZ_.
The name of the environment variable shall be the current name prefixed
with the string PBS_O_.

* **Note:**  
  If the current value of the
  _HOME_
  variable in the environment space of the
  _qsub_
  utility is
  **/aa/bb/cc**,
  then
  _qsub_
  shall place
  _PBS_O_HOME_=\c
  **/aa/bb/cc**
  in the
  _Variable_List_
  attribute of the batch job.


In addition to the variables described above, the
_qsub_
utility shall add the following variables with the indicated values to
the variable list:

* _PBS\_O\_WORKDIR_  
  The absolute path of the current working directory of the
  _qsub_
  utility process.
* _PBS\_O\_HOST_  
  The name of the host on which the
  _qsub_
  utility is running.

<a name="options"></a>

# Options

The
_qsub_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported by the implementation:

* **\(mia&nbsp;date\_time**  
  Define the time at which a batch job becomes eligible for execution.

The
_qsub_
utility shall accept an option-argument that conforms to the syntax of
the
_time_
operand of the
_touch_
utility.  

.ce 1
**Table 4-19: Environment Variable Values (Utilities)**
.TS
center box tab(!);
cB | cB
lI | lI.
Variable Name!Value at qsub Time
_
PBS_O_HOME!HOME
PBS\_O\_HOST!Client host name
PBS_O_LANG!LANG
PBS_O_LOGNAME!LOGNAME
PBS_O_PATH!PATH
PBS_O_MAIL!MAIL
PBS_O_SHELL!SHELL
PBS_O_TZ!TZ
PBS\_O\_WORKDIR!Current working directory
.TE

* **Note:**  
  The server that initiates execution of the batch job will add other
  variables to the batch job's environment; see
  _Section 3.2.2.1_, _Batch Job Execution_.


The
_qsub_
utility shall set the
_Execution_Time_
attribute of the batch job to the number of seconds since the Epoch
that is equivalent to the local time expressed by the value of the
_date_time_
option-argument. The Epoch is defined in the Base Definitions volume of POSIX.1-2008,
_Section 3.150_, _Epoch_.

If the
**\(mia**
option is not presented to the
_qsub_
utility, the utility shall set the
_Execution_Time_
attribute of the batch job to a time (number of seconds since the
Epoch) that is earlier than the time at which the utility exits.

* **\(miA&nbsp;account\_string**    
  Define the account to which the resource consumption of the batch job
  should be charged.

The syntax of the
_account_string_
option-argument is unspecified.

The
_qsub_
utility shall set the
_Account_Name_
attribute of the batch job to the value of the
_account_string_
option-argument.

If the
**\(miA**
option is not presented to the
_qsub_
utility, the utility shall omit the
_Account_Name_
attribute from the attributes of the batch job.

* **\(mic&nbsp;interval**  
  Define whether the batch job should be checkpointed, and if so, how
  often.

The
_qsub_
utility shall accept a value for the interval option-argument that is
one of the following:

* n  
  No checkpointing shall be performed on the batch job
  (NO_CHECKPOINT).
* s  
  Checkpointing shall be performed only when the batch server is shut
  down (CHECKPOINT_AT_SHUTDOWN).
* c  
  Automatic periodic checkpointing shall be performed at the
  _Minimum_Cpu_Interval_
  attribute of the batch queue, in units of CPU minutes
  (CHECKPOINT_AT_MIN_CPU_INTERVAL).
* c=_minutes_  
  Automatic periodic checkpointing shall be performed every
  _minutes_
  of CPU time, or every
  _Minimum_Cpu_Interval_
  minutes, whichever is greater. The
  _minutes_
  argument shall conform to the syntax for unsigned integers and shall be
  greater than zero.

The
_qsub_
utility shall set the
_Checkpoint_
attribute of the batch job to the value of the
_interval_
option-argument.

If the
**\(mic**
option is not presented to the
_qsub_
utility, the utility shall set the
_Checkpoint_
attribute of the batch job to the single character
**'u'**
(CHECKPOINT_UNSPECIFIED).

* **\(miC&nbsp;directive\_prefix**    
  Define the prefix that declares a directive to the
  _qsub_
  utility within the script.

The
_directive_prefix_
is not a batch job attribute; it affects the behavior of the
_qsub_
utility.

If the
**\(miC**
option is presented to the
_qsub_
utility, and the value of the
_directive_prefix_
option-argument is the null string, the utility shall not scan the
script file for directives. If the
**\(miC**
option is not presented to the
_qsub_
utility, then the value of the
_PBS_DPREFIX_
environment variable is used. If the environment variable is not
defined, then #PBS encoded in the portable character set is the
default.

* **\(mie&nbsp;path\_name**    
  Define the path to be used for the standard error stream of the batch
  job.

The
_qsub_
utility shall accept a
_path_name_
option-argument which can be preceded by a host name element of the
form
_hostname_:.

If the
_path_name_
option-argument constitutes an absolute pathname, the
_qsub_
utility shall set the
_Error_Path_
attribute of the batch job to the value of the
_path_name_
option-argument.

If the
_path_name_
option-argument constitutes a relative pathname and no host name
element is specified, the
_qsub_
utility shall set the
_Error_Path_
attribute of the batch job to the value of the absolute pathname
derived by expanding the
_path_name_
option-argument relative to the current directory of the process
executing
_qsub_.

If the
_path_name_
option-argument constitutes a relative pathname and a host name
element is specified, the
_qsub_
utility shall set the
_Error_Path_
attribute of the batch job to the value of the
_path_name_
option-argument without expansion. The host name element shall be
included.

If the
_path_name_
option-argument does not include a host name element, the
_qsub_
utility shall prefix the pathname with
_hostname_:,
where
_hostname_
is the name of the host upon which the
_qsub_
utility is being executed.

If the
**\(mie**
option is not presented to the
_qsub_
utility, the utility shall set the
_Error_Path_
attribute of the batch job to the host name and path of the current
directory of the submitting process and the default filename.

The default filename for standard error has the following format:

    
    job_name.esequence_number


* **\(mih**  
  Specify that a USER hold is applied to the batch job.

The
_qsub_
utility shall set the value of the
_Hold_Types_
attribute of the batch job to the value USER.

If the
**\(mih**
option is not presented to the
_qsub_
utility, the utility shall set the
_Hold_Types_
attribute of the batch job to the value NO_HOLD.

* **\(mij&nbsp;join\_list**  
  Define which streams of the batch job are to be merged. The
  _qsub_
  **\(mij**
  option shall accept a value for the
  _join_list_
  option-argument that is a string of alphanumeric characters in the
  portable character set (see the Base Definitions volume of POSIX.1-2008,
  _Section 6.1_, _Portable Character Set_).

The
_qsub_
utility shall accept a
_join_list_
option-argument that consists of one or more of the characters
**'e'**
and
**'o'**,
or the single character
**'n'**.

All of the other batch job output streams specified will be merged into
the output stream represented by the character listed first in the
_join_list_
option-argument.

For each unique character in the
_join_list_
option-argument, the
_qsub_
utility shall add a value to the
_Join_Path_
attribute of the batch job as follows, each representing a different
batch job stream to join:

* e  
  The standard error of the batch job (JOIN_STD_ERROR).
* The standard output of the batch job (JOIN_STD_OUTPUT).

An existing
_Join_Path_
attribute can be cleared by the following join type:

* n  
  NO_JOIN

If
**'n'**
is specified, then no files are joined. The
_qsub_
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
_qsub_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters.

An implementation may define other join types. The conformance document
for an implementation shall describe any additional batch job streams,
how they are specified, their internal behavior, and how they affect
the behavior of the utility.

If the
**\(mij**
option is not presented to the
_qsub_
utility, the utility shall set the value of the
_Join_Path_
attribute of the batch job to NO_JOIN.

* **\(mik&nbsp;keep\_list**  
  Define which output of the batch job to retain on the execution host.

The
_qsub_
**\(mik**
option shall accept a value for the
_keep_list_
option-argument that is a string of alphanumeric characters in the
portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_).

The
_qsub_
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
_qsub_
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
attribute can be cleared by the following keep type:

* n  
  NO_KEEP

If
**'n'**
is specified, then no files are retained. The
_qsub_
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
_qsub_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters.

An implementation may define other keep types. The conformance document
for an implementation shall describe any additional keep types, how
they are specified, their internal behavior, and how they affect the
behavior of the utility. If the
**\(mik**
option is not presented to the
_qsub_
utility, the utility shall set the
_Keep_Files_
attribute of the batch job to the value NO_KEEP.

* **\(mim&nbsp;mail\_options**    
  Define the points in the execution of the batch job at which the batch
  server that manages the batch job shall send mail about a change in the
  state of the batch job.

The
_qsub_
**\(mim**
option shall accept a value for the
_mail_options_
option-argument that is a string of alphanumeric characters in the
portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_).

The
_qsub_
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
_qsub_
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
attribute can be cleared by the following mail type:

* n  
  NO_MAIL

If
**'n'**
is specified, then mail is not sent. The
_qsub_
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
option-argument.

The
_qsub_
utility shall permit the repetition of characters, but shall not assign
additional meaning to the repeated characters. An implementation may
define other mail types. The conformance document for an implementation
shall describe any additional mail types, how they are specified, their
internal behavior, and how they affect the behavior of the utility.

If the
**\(mim**
option is not presented to the
_qsub_
utility, the utility shall set the
_Mail_Points_
attribute to the value MAIL_AT_ABORT.

* **\(miM&nbsp;mail\_list**  
  Define the list of users to which a batch server that executes the
  batch job shall send mail, if the server sends mail about the batch
  job.

The syntax of the
_mail_list_
option-argument is unspecified.

If the implementation of the
_qsub_
utility uses a name service to locate users, the utility should accept
the syntax used by the name service.

If the implementation of the
_qsub_
utility does not use a name service to locate users, the implementation
should accept the following syntax for user names:

    
    mail_address[,,mail_address,, ...]


The interpretation of
_mail_address_
is implementation-defined.

The
_qsub_
utility shall set the
_Mail_Users_
attribute of the batch job to the value of the
_mail_list_
option-argument.

If the
**\(miM**
option is not presented to the
_qsub_
utility, the utility shall place only the user name and host name for
the current process in the
_Mail_Users_
attribute of the batch job.

* **\(miN&nbsp;name**  
  Define the name of the batch job.

The
_qsub_
**\(miN**
option shall accept a value for the
_name_
option-argument that is a string of up to 15 alphanumeric characters in
the portable character set (see the Base Definitions volume of POSIX.1-2008,
_Section 6.1_, _Portable Character Set_)
where the first character is alphabetic.

The
_qsub_
utility shall set the value of the
_Job_Name_
attribute of the batch job to the value of the
_name_
option-argument.

If the
**\(miN**
option is not presented to the
_qsub_
utility, the utility shall set the
_Job_Name_
attribute of the batch job to the name of the
_script_
argument from which the directory specification if any, has been
removed.

If the
**\(miN**
option is not presented to the
_qsub_
utility, and the script is read from standard input, the utility shall
set the
_Job_Name_
attribute of the batch job to the value STDIN.

* **\(mio&nbsp;path\_name**    
  Define the path for the standard output of the batch job.

The
_qsub_
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
_qsub_
utility shall set the
_Output_Path_
attribute of the batch job to the value of the
_path_name_
option-argument without expansion.

If the
_path_name_
option-argument constitutes a relative pathname and no host name
element is specified, the
_qsub_
utility shall set the
_Output_Path_
attribute of the batch job to the pathname derived by expanding the
value of the
_path_name_
option-argument relative to the current directory of the process
executing the
_qsub_.

If the
_path_name_
option-argument constitutes a relative pathname and a host name
element is specified, the
_qsub_
utility shall set the
_Output_Path_
attribute of the batch job to the value of the
_path_name_
option-argument without expansion.

If the
_path_name_
option-argument does not specify a host name element, the
_qsub_
utility shall prefix the pathname with
_hostname_:,
where
_hostname_
is the name of the host upon which the
_qsub_
utility is executing.

If the
**\(mio**
option is not presented to the
_qsub_
utility, the utility shall set the
_Output_Path_
attribute of the batch job to the host name and path of the current
directory of the submitting process and the default filename.

The default filename for standard output has the following format:

    
    job_name.osequence_number


* **\(mip&nbsp;priority**  
  Define the priority the batch job should have relative to other batch
  jobs owned by the batch server.

The
_qsub_
utility shall set the
_Priority_
attribute of the batch job to the value of the
_priority_
option-argument.

If the
**\(mip**
option is not presented to the
_qsub_
utility, the value of the
_Priority_
attribute is implementation-defined.

The
_qsub_
utility shall accept a value for the
_priority_
option-argument that conforms to the syntax for signed decimal
integers, and which is not less than \(mi1\|024 and not greater than
1\|023.

* **\(miq&nbsp;destination**    
  Define the destination of the batch job.

The destination is not a batch job attribute; it determines the batch
server, and possibly the batch queue, to which the
_qsub_
utility batch queues the batch job.

The
_qsub_
utility shall submit the script to the batch server named by the
_destination_
option-argument or the server that owns the batch queue named in the
_destination_
option-argument.

The
_qsub_
utility shall accept an option-argument for the
**\(miq**
option that conforms to the syntax for a destination (see
_Section 3.3.2_, _Destination_).

If the
**\(miq**
option is not presented to the
_qsub_
utility, the
_qsub_
utility shall submit the batch job to the default destination. The
mechanism for determining the default destination is
implementation-defined.

* **\(mir&nbsp;_y**|n_  
  Define whether the batch job is rerunnable.

If the value of the option-argument is
_y_,
the
_qsub_
utility shall set the
_Rerunable_
attribute of the batch job to TRUE.

If the value of the option-argument is
_n_,
the
_qsub_
utility shall set the
_Rerunable_
attribute of the batch job to FALSE.

If the
**\(mir**
option is not presented to the
_qsub_
utility, the utility shall set the
_Rerunable_
attribute of the batch job to TRUE.

* **\(miS&nbsp;path\_name\_list**    
  Define the pathname to the shell under which the batch job is to
  execute.

The
_qsub_
utility shall accept a
_path_name_list_
option-argument that conforms to the following syntax:

    
    pathname[@host][,,pathname[@host],, ...]


The
_qsub_
utility shall allow only one pathname for a given host name. The
_qsub_
utility shall allow only one pathname that is missing a corresponding
host name.

The
_qsub_
utility shall add a value to the
_Shell_Path_List_
attribute of the batch job for each entry in the
_path_name_list_
option-argument.

If the
**\(miS**
option is not presented to the
_qsub_
utility, the utility shall set the
_Shell_Path_List_
attribute of the batch job to the null string.

The conformance document for an implementation shall describe the
mechanism used to set the default shell and determine the current value
of the default shell. An implementation shall provide a means for the
installation to set the default shell to the login shell of the user
under which the batch job is to execute. See
_Section 3.3.3_, _Multiple Keyword-Value Pairs_
for a means of removing
_keyword_=\c
_value_
(and
_value_@\c
_keyword_)
pairs and other general rules for list-oriented batch job attributes.

* **\(miu&nbsp;user\_list**  
  Define the user name under which the batch job is to execute.

The
_qsub_
utility shall accept a
_user_list_
option-argument that conforms to the following syntax:

    
    username[@host][,,username[@host],, ...]


The
_qsub_
utility shall accept only one user name that is missing a corresponding
host name. The
_qsub_
utility shall accept only one user name per named host.

The
_qsub_
utility shall add a value to the
_User_List_
attribute of the batch job for each entry in the
_user_list_
option-argument.

If the
**\(miu**
option is not presented to the
_qsub_
utility, the utility shall set the
_User_List_
attribute of the batch job to the user name from which the utility is
executing. See
_Section 3.3.3_, _Multiple Keyword-Value Pairs_
for a means of removing
_keyword_=\c
_value_
(and
_value_@\c
_keyword_)
pairs and other general rules for list-oriented batch job attributes.

* **\(miv&nbsp;variable\_list**    
  Add to the list of variables that are exported to the session leader of
  the batch job.

A
_variable_list_
is a set of strings of either the form &lt;\c
_variable_&gt;
or &lt;\c
_variable_=\c
_value_&gt;,
delimited by
&lt;comma&gt;
characters.

If the
**\(miv**
option is presented to the
_qsub_
utility, the utility shall also add, to the environment
_Variable_List_
attribute of the batch job, every variable named in the environment
_variable_list_
option-argument and, optionally, values of specified variables.

If a value is not provided on the command line, the
_qsub_
utility shall set the value of each variable in the environment
_Variable_List_
attribute of the batch job to the value of the corresponding
environment variable for the process in which the utility is executing;
see
_Table 4-19, Environment Variable Values (Utilities)_.

A conforming application shall not repeat a variable in the environment
_variable_list_
option-argument.

The
_qsub_
utility shall not repeat a variable in the environment
_Variable_List_
attribute of the batch job. See
_Section 3.3.3_, _Multiple Keyword-Value Pairs_
for a means of removing
_keyword_=\c
_value_
(and
_value_@\c
_keyword_)
pairs and other general rules for list-oriented batch job attributes.

* **\(miV**  
  Specify that all of the environment variables of the process are
  exported to the context of the batch job.

The
_qsub_
utility shall place every environment variable in the process in which
the utility is executing in the list and shall set the value of each
variable in the attribute to the value of that variable in the
process.

* **\(miz**  
  Specify that the utility does not write the batch
  _job_identifier_
  of the created batch job to standard output.

If the
**\(miz**
option is presented to the
_qsub_
utility, the utility shall not write the batch
_job_identifier_
of the created batch job to standard output.

If the
**\(miz**
option is not presented to the
_qsub_
utility, the utility shall write the identifier of the created batch
job to standard output.

<a name="operands"></a>

# Operands

The
_qsub_
utility shall accept a
_script_
operand that indicates the path to the script of the batch job.

If the
_script_
operand is not presented to the
_qsub_
utility, or if the operand is the single-character string
**'\(mi'**,
the utility shall read the script from standard input.

If the script represents a partial path, the
_qsub_
utility shall expand the path relative to the current directory of the
process executing the utility.

<a name="stdin"></a>

# Stdin

The
_qsub_
utility reads the script of the batch job from standard input if the
script operand is omitted or is the single character
**'\(mi'**.

<a name="input-files"></a>

# Input Files

In addition to binding the file indicated by the
_script_
operand to the batch job, the
_qsub_
utility reads the script file and acts on directives in the script.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_qsub_:

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
* _PBS\_DPREFIX_    
  Determine the default prefix for directives within the script.
* _SHELL_  
  Determine the pathname of the preferred command language interpreter
  of the user.
* _TZ_  
  Determine the timezone used to interpret the
  _date-time_
  option-argument. If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Once created, a batch job exists until it exits, aborts, or is
deleted.

After a batch job is created by the
_qsub_
utility, batch servers might route, execute, modify, or delete the
batch job.

<a name="stdout"></a>

# Stdout

The
_qsub_
utility writes the batch
_job_identifier_
assigned to the batch job to standard output, unless the
**\(miz**
option is specified.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description


<a name="script-preservation"></a>

### Script Preservation


The
_qsub_
utility shall make the script available to the server executing the
batch job in such a way that the server executes the script as it
exists at the time of submission.

The
_qsub_
utility can send a copy of the script to the server with the
_Queue Job Request_
or store a temporary copy of the script in a location specified to the
server.

<a name="option-specification"></a>

### Option Specification


A script can contain directives to the
_qsub_
utility.

The
_qsub_
utility shall scan the lines of the script for directives, skipping
blank lines, until the first line that begins with a string other than
the directive string; if directives occur on subsequent lines, the
utility shall ignore those directives.

Lines are separated by a
&lt;newline&gt;.
If the first line of the script begins with
**"#!"**
or a
&lt;colon&gt;
(\c
**':'**),
then it is skipped. The
_qsub_
utility shall process a line in the script as a directive if and only
if the string of characters from the first non-white-space character on
the line until the first
&lt;space&gt;
or
&lt;tab&gt;
on the line match the directive prefix. If a line in the script
contains a directive and the final characters of the line are
&lt;backslash&gt;
and
&lt;newline&gt;,
then the next line shall be interpreted as a continuation of that
directive.

The
_qsub_
utility shall process the options and option-arguments contained on the
directive prefix line using the same syntax as if the options were
input on the
_qsub_
utility.

The
_qsub_
utility shall continue to process a directive prefix line until after a
&lt;newline&gt;
is encountered. An implementation may ignore lines which, according to
the syntax of the shell that will interpret the script, are comments.
An implementation shall describe in the conformance document the format
of any shell comments that it will recognize.

If an option is present in both a directive and the arguments to the
_qsub_
utility, the utility shall ignore the option and the corresponding
option-argument, if any, in the directive.

If an option that is present in the directive is not present in the
arguments to the
_qsub_
utility, the utility shall process the option and the option-argument,
if any.

In order of preference, the
_qsub_
utility shall select the directive prefix from one of the following
sources:

*  *  
  If the
  **\(miC**
  option is presented to the utility, the value of the
  _directive_prefix_
  option-argument
*  *  
  If the environment variable
  _PBS_DPREFIX_
  is defined, the value of that variable
*  *  
  The four-character string
  **"#PBS"**
  encoded in the portable character set

If the
**\(miC**
option is present in the script file it shall be ignored.

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

None.

<a name="rationale"></a>

# Rationale

The
_qsub_
utility allows users to create a batch job that will process the script
specified as the operand of the utility.

The options of the
_qsub_
utility allow users to control many aspects of the queuing and
execution of a batch job.

The
**\(mia**
option allows users to designate the time after which the batch job
will become eligible to run. By specifying an execution time, users can
take advantage of resources at off-peak hours, synchronize jobs with
chronologically predictable events, and perhaps take advantage of
off-peak pricing of computing time. For these reasons and others, a
timing option is existing practice on the part of almost every batch
system, including NQS.

The
**\(miA**
option allows users to specify the account that will be charged for the
batch job. Support for account is not mandatory for conforming batch
servers.

The
**\(miC**
option allows users to prescribe the prefix for directives within the
script file. The default prefix
**"#PBS"**
may be inappropriate if the script will be interpreted with an
alternate shell, as specified by the
**\(miS**
option.

The
**\(mic**
option allows users to establish the checkpointing interval for their
jobs. A checkpointing system, which is not defined by this volume of POSIX.1-2008, allows
recovery of a batch job at the most recent checkpoint in the event of a
crash. Checkpointing is typically used for jobs that consume expensive
computing time or must meet a critical schedule. Users should be
allowed to make the tradeoff between the overhead of checkpointing and
the risk to the timely completion of the batch job; therefore, this volume of POSIX.1-2008
provides the checkpointing interval option. Support for checkpointing
is optional for batch servers.

The
**\(mie**
option allows users to redirect the standard error streams of their
jobs to a non-default path. For example, if the submitted script
generally produces a great deal of useless error output, a user might
redirect the standard error output to the null device. Or, if the file
system holding the default location (the home directory of the user)
has too little free space, the user might redirect the standard error
stream to a file in another file system.

The
**\(mih**
option allows users to create a batch job that is held until explicitly
released. The ability to create a held job is useful when some external
event must complete before the batch job can execute. For example, the
user might submit a held job and release it when the system load has
dropped.

The
**\(mij**
option allows users to merge the standard error of a batch job into its
standard output stream, which has the advantage of showing the
sequential relationship between output and error messages.

The
**\(mim**
option allows users to designate those points in the execution of a
batch job at which mail will be sent to the submitting user, or to the
account(s) indicated by the
**\(miM**
option. By requesting mail notification at points of interest in the
life of a job, the submitting user, or other designated users, can
track the progress of a batch job.

The
**\(miN**
option allows users to associate a name with the batch job. The job
name in no way affects the processing of the batch job, but rather
serves as a mnemonic handle for users. For example, the batch job name
can help the user distinguish between multiple jobs listed by the
_qstat_
utility.

The
**\(mio**
option allows users to redirect the standard output stream. A user
might, for example, wish to redirect to the null device the standard
output stream of a job that produces copious yet superfluous output.

The
**\(miP**
option allows users to designate the relative priority of a batch job
for selection from a queue.

The
**\(miq**
option allows users to specify an initial queue for the batch job. If
the user specifies a routing queue, the batch server routes the
batch job to another queue for execution or further routing. If the
user specifies a non-routing queue, the batch server of the queue
eventually executes the batch job.

The
**\(mir**
option allows users to control whether the submitted job will be rerun
if the controlling batch node fails during execution of the batch job.
The
**\(mir**
option likewise allows users to indicate whether or not the batch job
is eligible to be rerun by the
_qrerun_
utility. Some jobs cannot be correctly rerun because of changes they
make in the state of databases or other aspects of their environment.
This volume of POSIX.1-2008 specifies that the default, if the
**\(mir**
option is not presented to the utility, will be that the batch job
cannot be rerun, since the result of rerunning a non-rerunnable job
might be catastrophic.

The
**\(miS**
option allows users to specify the program (usually a shell) that will
be invoked to process the script of the batch job. This option has been
modified to allow a list of shell names and locations associated with
different hosts.

The
**\(miu**
option is useful when the submitting user is authorized to use more
than one account on a given host, in which case the
**\(miu**
option allows the user to select from among those accounts. The
option-argument is a list of user-host pairs, so that the submitting
user can provide different user identifiers for different nodes in the
event the batch job is routed. The
**\(miu**
option provides a lot of flexibility to accommodate sites with complex
account structures. Users that have the same user identifier on all the
hosts they are authorized to use will not need to use the
**\(miu**
option.

The
**\(miV**
option allows users to export all their current environment variables,
as of the time the batch job is submitted, to the context of the
processes of the batch job.

The
**\(miv**
option allows users to export specific environment variables from their
current process to the processes of the batch job.

The
**\(miz**
option allows users to suppress the writing of the batch job identifier
to standard output. The
**\(miz**
option is an existing NQS practice that has been standardized.

Historically, the
_qsub_
utility has served the batch job-submission function in the NQS system,
the existing practice on which it is based. Some changes and additions
have been made to the
_qsub_
utility in this volume of POSIX.1-2008, _vis-a-vis_ NQS, as a result of the growing pool
of experience with distributed batch systems.

The set of features of the
_qsub_
utility as defined in this volume of POSIX.1-2008 appears to incorporate all the common
existing practice on potentially conforming platforms.

<a name="future-directions"></a>

# Future Directions

The
_qsub_
utility may be removed in a future version.

<a name="see-also"></a>

# See Also

_Chapter 3_, _Batch Environment Services_,
__qrerun_\^_,
__qstat_\^_,
__touch_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.150_, _Epoch_,
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
