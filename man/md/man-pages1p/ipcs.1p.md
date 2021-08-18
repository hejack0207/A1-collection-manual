# ipcs(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ipcs
— report XSI interprocess communication facilities status

<a name="synopsis"></a>

# Synopsis

```


```
    ipcs [(miqms] [(mia|(mibcopt]

<a name="description"></a>

# Description

The
_ipcs_
utility shall write information about active interprocess communication
facilities.

Without options, information shall be written in short format for
message queues, shared memory segments, and semaphore sets that are
currently active in the system. Otherwise, the information that is
displayed is controlled by the options specified.

<a name="options"></a>

# Options

The
_ipcs_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The
_ipcs_
utility accepts the following options:

* **\(miq**  
  Write information about active message queues.
* **\(mim**  
  Write information about active shared memory segments.
* **\(mis**  
  Write information about active semaphore sets.

If
**\(miq**,
**\(mim**,
or
**\(mis**
are specified, only information about those facilities shall be
written. If none of these three are specified, information about all
three shall be written subject to the following options:

* **\(mia**  
  Use all print options. (This is a shorthand notation for
  **\(mib**,
  **\(mic**,
  **\(mio**,
  **\(mip**,
  and
  **\(mit**.)
* **\(mib**  
  Write information on maximum allowable size. (Maximum number of bytes
  in messages on queue for message queues, size of segments for shared
  memory, and number of semaphores in each set for semaphores.)
* **\(mic**  
  Write creator's user name and group name; see below.
* **\(mio**  
  Write information on outstanding usage. (Number of messages on queue
  and total number of bytes in messages on queue for message queues, and
  number of processes attached to shared memory segments.)
* **\(mip**  
  Write process number information. (Process ID of the last process to
  send a message and process ID of the last process to receive a message
  on message queues, process ID of the creating process, and process ID
  of the last process to attach or detach on shared memory segments.)
* **\(mit**  
  Write time information. (Time of the last control operation that
  changed the access permissions for all facilities, time of the last
  _msgsnd_()
  and
  _msgrcv_()
  operations on message queues, time of the last
  _shmat_()
  and
  _shmdt_()
  operations on shared memory, and time of the last
  _semop_()
  operation on semaphores.)

<a name="operands"></a>

# Operands

None.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files


*  *  
  The group database
*  *  
  The user database

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_ipcs_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
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
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TZ_  
  Determine the timezone for the date and time strings written by
  _ipcs_.
  If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

An introductory line shall be written with the format:

    
    "IPC status from %s as of %sen", <source>, <date>


where &lt;_source_&gt; indicates the source used to gather the statistics
and &lt;_date_&gt; is the information that would be produced by the
_date_
command when invoked in the POSIX locale.

The
_ipcs_
utility then shall create up to three reports depending upon the
**\(miq**,
**\(mim**,
and
**\(mis**
options. The first report shall indicate the status of message queues,
the second report shall indicate the status of shared memory segments,
and the third report shall indicate the status of semaphore sets.

If the corresponding facility is not installed or has not been used
since the last reboot, then the report shall be written out in the
format:

    
    "%s facility not in system.en", <facility>


where &lt;_facility_&gt; is
_Message Queue_,
_Shared Memory_,
or
_Semaphore_,
as appropriate. If the facility has been installed and has been used
since the last reboot, column headings separated by one or more
&lt;space&gt;
characters and followed by a
&lt;newline&gt;
shall be written as indicated below followed by the facility name
written out using the format:

    
    "%s:en", <facility>


where &lt;_facility_&gt; is
_Message Queues_,
_Shared Memory_,
or
_Semaphores_,
as appropriate. On the second and third reports the column headings
need not be written if the last column headings written already provide
column headings for all information in that report.

The column headings provided in the first column below and the meaning
of the information in those columns shall be given in order below; the
letters in parentheses indicate the options that shall cause the
corresponding column to appear; \`\`all'' means that the column shall
always appear. Each column is separated by one or more
&lt;space&gt;
characters. Note that these options only determine what information is
provided for each report; they do not determine which reports are written.

* T (all)  
  Type of facility:
    * q  
      Message queue.
    * m  
      Shared memory segment.
    * s  
      Semaphore.

This field is a single character written using the format
**%c**.

* ID (all)  
  The identifier for the facility entry. This field shall be written
  using the format
  **%d**.
* KEY (all)  
  The key used as an argument to
  _msgget_(),
  _semget_(),
  or
  _shmget_()
  to create the facility entry.
    * **Note:**  
      The key of a shared memory segment is changed to IPC_PRIVATE when the
      segment has been removed until all processes attached to the segment
      detach it.

This field shall be written using the format 0x%x.

* MODE (all)  
  The facility access modes and flags. The mode shall consist of 11
  characters that are interpreted as follows.

The first character shall be:

* S  
  If a process is waiting on a
  _msgsnd_()
  operation.
* \(mi  
  If the above is not true.

The second character shall be:

* R  
  If a process is waiting on a
  _msgrcv_()
  operation.
* C&nbsp;or&nbsp;\(mi  
  If the associated shared memory segment is to be cleared when the first
  attach operation is executed.
* \(mi  
  If none of the above is true.

The next nine characters shall be interpreted as three sets of three
bits each. The first set refers to the owner's permissions; the next
to permissions of others in the usergroup of the facility entry; and
the last to all others. Within each set, the first character indicates
permission to read, the second character indicates permission to write
or alter the facility entry, and the last character is a minus-sign (\c
**'\(mi'**).

The permissions shall be indicated as follows:

* _r_  
  If read permission is granted.
* _w_  
  If write permission is granted.
* _a_  
  If alter permission is granted.
* \(mi  
  If the indicated permission is not granted.

The first character following the permissions specifies if there is an
alternate or additional access control method associated with the
facility. If there is no alternate or additional access control method
associated with the facility, a single
&lt;space&gt;
shall be written; otherwise, another printable character is
written.

* OWNER (all)  
  The user name of the owner of the facility entry. If the user name of
  the owner is found in the user database, at least the first eight
  column positions of the name shall be written using the format
  **%s**.
  Otherwise, the user ID of the owner shall be written using the format
  **%d**.
* GROUP (all)  
  The group name of the owner of the facility entry. If the group name
  of the owner is found in the group database, at least the first eight
  column positions of the name shall be written using the format
  **%s**.
  Otherwise, the group ID of the owner shall be written using the format
  **%d**.

The following nine columns shall be only written out for message
queues:

* CREATOR (**a**,**c**)  
  The user name of the creator of the facility entry. If the user name
  of the creator is found in the user database, at least the first eight
  column positions of the name shall be written using the format
  **%s**.
  Otherwise, the user ID of the creator shall be written using the format
  **%d**.
* CGROUP (**a**,**c**)  
  The group name of the creator of the facility entry. If the group name
  of the creator is found in the group database, at least the first eight
  column positions of the name shall be written using the format
  **%s**.
  Otherwise, the group ID of the creator shall be written using the format
  **%d**.
* CBYTES (**a**,**o**)  
  The number of bytes in messages currently outstanding on the associated
  message queue. This field shall be written using the format
  **%d**.
* QNUM (**a**,**o**)  
  The number of messages currently outstanding on the associated message
  queue. This field shall be written using the format
  **%d**.
* QBYTES (**a**,**b**)  
  The maximum number of bytes allowed in messages outstanding on the
  associated message queue. This field shall be written using the format
  **%d**.
* LSPID (**a**,**p**)  
  The process ID of the last process to send a message to the associated
  queue. This field shall be written using the format:

    
    "%d", <pid>


where &lt;_pid_&gt; is 0 if no message has been sent to the corresponding
message queue; otherwise, &lt;_pid_&gt; shall be the process ID of the
last process to send a message to the queue.

* LRPID (**a**,**p**)  
  The process ID of the last process to receive a message from the
  associated queue. This field shall be written using the format:

    
    "%d", <pid>


where &lt;_pid_&gt; is 0 if no message has been received from the
corresponding message queue; otherwise, &lt;_pid_&gt; shall be the
process ID of the last process to receive a message from the queue.

* STIME (**a**,**t**)  
  The time the last message was sent to the associated queue.
  If a message has been sent to the corresponding message queue,
  the hour, minute, and second of the last time a message
  was sent to the queue shall be written using the format
  **%d**:\c
  **%2.2d**:\c
  **%2.2d**.
  Otherwise, the format
  **"&nbsp;no-entry"**
  shall be written.
* RTIME (**a**,**t**)  
  The time the last message was received from the associated queue.
  If a message has been received from the corresponding message queue,
  the hour, minute, and second of the last time a message was received
  from the queue shall be written using the format
  **%d**:\c
  **%2.2d**:\c
  **%2.2d**.
  Otherwise, the format
  **"&nbsp;no-entry"**
  shall be written.

The following eight columns shall be only written out for shared memory
segments.

* CREATOR (**a**,**c**)  
  The user of the creator of the facility entry. If the user name of the
  creator is found in the user database, at least the first eight column
  positions of the name shall be written using the format
  **%s**.
  Otherwise, the user ID of the creator shall be written using the format
  **%d**.
* CGROUP (**a**,**c**)  
  The group name of the creator of the facility entry. If the group name
  of the creator is found in the group database, at least the first eight
  column positions of the name shall be written using the format
  **%s**.
  Otherwise, the group ID of the creator shall be written using the format
  **%d**.
* NATTCH (**a**,**o**)  
  The number of processes attached to the associated shared memory
  segment. This field shall be written using the format
  **%d**.
* SEGSZ (**a**,**b**)  
  The size of the associated shared memory segment. This field shall be
  written using the format
  **%d**.
* CPID (**a**,**p**)  
  The process ID of the creator of the shared memory entry. This field
  shall be written using the format
  **%d**.
* LPID (**a**,**p**)  
  The process ID of the last process to attach or detach the shared
  memory segment. This field shall be written using the format:

    
    "%d", <pid>


where &lt;_pid_&gt; is 0 if no process has attached the corresponding
shared memory segment; otherwise, &lt;_pid_&gt; shall be the process ID
of the last process to attach or detach the segment.

* ATIME (**a**,**t**)  
  The time the last attach on the associated shared memory segment was
  completed. If the corresponding shared memory segment has ever been
  attached, the hour, minute, and second of the last time the segment was
  attached shall be written using the format
  **%d**:\c
  **%2.2d**:\c
  **%2.2d**.
  Otherwise, the format
  **"&nbsp;no-entry"**
  shall be written.
* DTIME (**a**,**t**)  
  The time the last detach on the associated shared memory segment was
  completed. If the corresponding shared memory segment has ever been
  detached, the hour, minute, and second of the last time the segment was
  detached shall be written using the format
  **%d**:\c
  **%2.2d**:\c
  **%2.2d**.
  Otherwise, the format
  **"&nbsp;no-entry"**
  shall be written.

The following four columns shall be only written out for semaphore
sets:

* CREATOR (**a**,**c**)  
  The user of the creator of the facility entry. If the user name of the
  creator is found in the user database, at least the first eight column
  positions of the name shall be written using the format
  **%s**.
  Otherwise, the user ID of the creator shall be written using the format
  **%d**.
* CGROUP     (**a**,**c**)  
  The group name of the creator of the facility entry. If the group name
  of the creator is found in the group database, at least the first eight
  column positions of the name shall be written using the format
  **%s**.
  Otherwise, the group ID of the creator shall be written using the
  format
  **%d**.
* NSEMS (**a**,**b**)  
  The number of semaphores in the set associated with the semaphore
  entry. This field shall be written using the format
  **%d**.
* OTIME (**a**,**t**)  
  The time the last semaphore operation on the set associated with the
  semaphore entry was completed. If a semaphore operation has ever been
  performed on the corresponding semaphore set, the hour, minute, and
  second of the last semaphore operation on the semaphore set shall be
  written using the format
  **%d**:\c
  **%2.2d**:\c
  **%2.2d**.
  Otherwise, the format
  **"&nbsp;no-entry"**
  shall be written.

The following column shall be written for all three reports when it is
requested:

* CTIME (**a**,**t**)  
  The time the associated entry was created or changed. The hour,
  minute, and second of the time when the associated entry was created
  shall be written using the format
  **%d**:\c
  **%2.2d**:\c
  **%2.2d**.

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

Things can change while
_ipcs_
is running; the information it gives is guaranteed to be accurate
only when it was retrieved.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__ipcrm_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__msgrcv_\^(\|)_,
__msgsnd_\^(\|)_,
__semget_\^(\|)_,
__semop_\^(\|)_,
__shmat_\^(\|)_,
__shmdt_\^(\|)_,
__shmget_\^(\|)_

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
