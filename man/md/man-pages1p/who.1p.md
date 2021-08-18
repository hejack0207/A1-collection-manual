# who(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

who
— display who is on the system

<a name="synopsis"></a>

# Synopsis

```


```
    who [(mimTu] [(miabdHlprt] [file]
    
    who [(mimu] (mis [(mibHlprt] [file]
    
    who (miq [file]
    
    who am i
    
    who am I

<a name="description"></a>

# Description

The
_who_
utility shall list various pieces of information about accessible
users. The domain of accessibility is implementation-defined.

Based on the options given,
_who_
can also list the user's name, terminal line, login time, elapsed time
since activity occurred on the line, and the process ID of the command
interpreter for each current system user.

<a name="options"></a>

# Options

The
_who_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported. The metavariables, such as
&lt;_line_&gt;, refer to fields described in the STDOUT section.

* **\(mia**  
  Process the implementation-defined database or named file with the
  **\(mib**,
  **\(mid**,
  **\(mil**,
  **\(mip**,
  **\(mir**,
  **\(mit**,
  **\(miT**
  and
  **\(miu**
  options turned on.
* **\(mib**  
  Write the time and date of the last system reboot. The system reboot
  time is the time at which the implementation is able to commence
  running processes.
* **\(mid**  
  Write a list of all processes that have expired and not been respawned
  by the
  _init_
  system process. The &lt;_exit_&gt; field shall appear for dead processes
  and contain the termination and exit values of the dead process. This
  can be useful in determining why a process terminated.
* **\(miH**  
  Write column headings above the regular output.
* **\(mil**  
  (The letter ell.) List only those lines on which the system is waiting
  for someone to login. The &lt;_name_&gt; field shall be
  **LOGIN**
  in such cases. Other fields shall be the same as for user entries
  except that the &lt;_state_&gt; field does not exist.
* **\(mim**  
  Output only information about the current terminal.
* **\(mip**  
  List any other process that is currently active and has been previously
  spawned by
  _init_.
* **\(miq**  
  (Quick.) List only the names and the number of users currently logged
  on. When this option is used, all other options shall be ignored.
* **\(mir**  
  Write the current
  _run-level_
  of the
  _init_
  process.
* **\(mis**  
  List only the &lt;_name_&gt;, &lt;_line_&gt;, and &lt;_time_&gt; fields.
  This is the default case.
* **\(mit**  
  Indicate the last change to the system clock.
* **\(miT**  
  Show the state of each terminal, as described in the STDOUT section.
* **\(miu**  
  Write \`\`idle time'' for each displayed user in addition to any other
  information. The idle time is the time since any activity occurred on
  the user's terminal. The method of determining this is unspecified.
  This option shall list only those users who are currently logged in.
  The &lt;_name_&gt; is the user's login name. The &lt;_line_&gt; is the name
  of the line as found in the directory
  **/dev**.
  The &lt;_time_&gt; is the time that the user logged in. The
  &lt;_activity_&gt; is the number of hours and minutes since activity last
  occurred on that particular line. A dot indicates that the terminal has
  seen activity in the last minute and is therefore \`\`current''. If more
  than twenty-four hours have elapsed or the line has not been used since
  boot time, the entry shall be marked &lt;_old_&gt;. This field is useful
  when trying to determine whether a person is working at the terminal or
  not. The &lt;_pid_&gt; is the process ID of the user's login process.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* **am&nbsp;i**,&nbsp;**am&nbsp;I**  
  In the POSIX locale, limit the output to describing the invoking user,
  equivalent to the
  **\(mim**
  option. The
  **am**
  and
  **i**
  or
  **I**
  must be separate arguments.
* _file_  
  Specify a pathname of a file to substitute for the
  implementation-defined database of logged-on users that
  _who_
  uses by default.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_who_:

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
* _LC\_TIME_  
  Determine the locale used for the format and contents of the date and
  time strings.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TZ_  
  Determine the timezone used when writing date and time information. If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The
_who_
utility shall write its default format to the standard output in an
implementation-defined format, subject only to the requirement of
containing the information described above.

XSI-conformant systems shall write the default information to the
standard output in the following general format:

    
    <name>[<state>]<line><time>[<activity>][<pid>][<comment>][<exit>]


For the
**\(mib**
option, &lt;_line_&gt; shall be
**"system**boot"**.**
The &lt;_name_&gt; is unspecified.

The following format shall be used for the
**\(miT**
option:

    
    "%s %c %s %sen" <name>, <terminal state>, <terminal name>,
        <time of login>


where &lt;_terminal&nbsp;state_&gt; is one of the following characters:

* +  
  The terminal allows write access to other users.
* \(mi  
  The terminal denies write access to other users.
* ?  
  The terminal write-access state cannot be determined.
* &lt;space&gt;  
  This entry is not associated with a terminal.

In the POSIX locale, the &lt;_time&nbsp;of&nbsp;login_&gt; shall be equivalent in
format to the output of:

    
    date +"%b %e %H:%M"


If the
**\(miu**
option is used with
**\(miT**,
the idle time shall be added to the end of the previous format in an
unspecified format.

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

The name
_init_
used for the system process is the most commonly used on historical
systems, but it may vary.

The \`\`domain of accessibility'' referred to is a broad concept that
permits interpretation either on a very secure basis or even to allow a
network-wide implementation like the historical
_rwho_.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Due to differences between historical implementations, the base options
provided were a compromise to allow users to work with those
functions. The standard developers also considered removing all the
options, but felt that these options offered users valuable
functionality. Additional options to match historical systems are
available on XSI-conformant systems.

It is recognized that the
_who_
command may be of limited usefulness, especially in a multi-level
secure environment. The standard developers considered, however, that
having some standard method of determining the \`\`accessibility'' of
other users would aid user portability.

No format was specified for the default
_who_
output for systems not supporting the XSI option. In such a
user-oriented command, designed only for human use, this was not
considered to be a deficiency.

The format of the terminal name is unspecified, but the descriptions of
_ps_,
_talk_,
and
_write_
require that they use the same format.

It is acceptable for an implementation to produce no output for
an invocation of
_who_
**mil**.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__mesg_\^_

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
