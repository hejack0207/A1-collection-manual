# renice(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

renice
— set nice values of running processes

<a name="synopsis"></a>

# Synopsis

```


```
    renice [(mig|(mip|(miu] (min increment ID...

<a name="description"></a>

# Description

The
_renice_
utility shall request that the nice values (see the Base Definitions volume of POSIX.1-2008,
_Section 3.240_, _Nice Value_)
of one or more running processes be changed. By default, the applicable
processes are specified by their process IDs. When a process group is
specified (see
**\(mig**),
the request shall apply to all processes in the process group.

The nice value shall be bounded in an implementation-defined manner.
If the requested
_increment_
would raise or lower the nice value of the executed utility beyond
implementation-defined limits, then the limit whose value was
exceeded shall be used.

When a user is
_renice_d,
the request applies to all processes whose saved set-user-ID matches
the user ID corresponding to the user.

Regardless of which options are supplied or any other factor,
_renice_
shall not alter the nice values of any process unless the user
requesting such a change has appropriate privileges to do so for the
specified process. If the user lacks appropriate privileges to perform
the requested action, the utility shall return an error status.

The saved set-user-ID of the user's process shall be checked instead of
its effective user ID when
_renice_
attempts to determine the user ID of the process in order to determine
whether the user has appropriate privileges.

<a name="options"></a>

# Options

The
_renice_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for Guideline 9.

The following options shall be supported:

* **\(mig**  
  Interpret the following operands as unsigned decimal integer process
  group IDs.
* **\(min&nbsp;increment**  
  Specify how the nice value of the specified process or processes is to
  be adjusted. The
  _increment_
  option-argument is a positive or negative decimal integer that shall be
  used to modify the nice value of the specified process or processes.

Positive
_increment_
values shall cause a lower nice value. Negative
_increment_
values may require appropriate privileges and shall cause a higher
nice value.

* **\(mip**  
  Interpret the following operands as unsigned decimal integer process
  IDs. The
  **\(mip**
  option is the default if no options are specified.
* **\(miu**  
  Interpret the following operands as users. If a user exists with a user
  name equal to the operand, then the user ID of that user is used in
  further processing. Otherwise, if the operand represents an unsigned
  decimal integer, it shall be used as the numeric user ID of the user.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _ID_  
  A process ID, process group ID, or user name/user ID, depending on the
  option selected.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_renice_:

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

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

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


*  1.  
  Adjust the nice value so that process IDs 987 and 32 would have a lower
  nice value:

    
    renice (min 5 (mip 987 32


*  2.  
  Adjust the nice value so that group IDs 324 and 76 would have a higher
  nice value, if the user has appropriate privileges to do so:

    
    renice (min (mi4 (mig 324 76


*  3.  
  Adjust the nice value so that numeric user ID 8 and user
  **sas**
  would have a lower nice value:

    
    renice (min 4 (miu 8 sas


Useful nice value increments on historical systems include 19 or 20
(the affected processes run only when nothing else in the system
attempts to run) and any negative number (to make processes run
faster).

<a name="rationale"></a>

# Rationale

The
_gid_,
_pid_,
and
_user_
specifications do not fit either the definition of operand or
option-argument. However, for clarity, they have been included in the
OPTIONS section, rather than the OPERANDS section.

The definition of nice value is not intended to suggest that all
processes in a system have priorities that are comparable. Scheduling
policy extensions such as the realtime priorities in the System Interfaces volume of POSIX.1-2008 make the
notion of a single underlying priority for all scheduling policies
problematic. Some implementations may implement the
_nice_-related
features to affect all processes on the system, others to affect just
the general time-sharing activities implied by this volume of POSIX.1-2008, and others may
have no effect at all. Because of the use of
\`\`implementation-defined'' in
_nice_
and
_renice_,
a wide range of implementation strategies are possible.

Originally, this utility was written in the historical manner, using
the term \`\`nice value''. This was always a point of concern with users
because it was never intuitively obvious what this meant. With a newer
version of
_renice_,
which used the term \`\`system scheduling priority'', it was hoped that
novice users could better understand what this utility was meant to
do. Also, it would be easier to document what the utility was meant to
do. Unfortunately, the addition of the POSIX realtime scheduling
capabilities introduced the concepts of process and thread scheduling
priorities that were totally unaffected by the
_nice_/\c
_renice_
utilities or the
_nice_()/\c
_setpriority_()
functions. Continuing to use the term \`\`system scheduling priority''
would have incorrectly suggested that these utilities and functions
were indeed affecting these realtime priorities. It was decided to
revert to the historical term \`\`nice value'' to reference this
unrelated process attribute.

Although this utility has use by system administrators (and in fact
appears in the system administration portion of the BSD documentation),
the standard developers considered that it was very useful for
individual end users to control their own processes.

Earlier versions of this standard allowed the following forms in the
SYNOPSIS:

    
    renice nice_value[(mip] pid...[(mig gid...][(mip pid...][(miu user...]
    renice nice_value (mig gid...[(mig gid...](mip pid...][(miu user...]
    renice nice_value (miu user...[(mig gid...](mip pid...][(miu user...]


These forms are no longer specified by POSIX.1-2008 but may be
present in some implementations.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__nice_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 3.240_, _Nice Value_,
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
