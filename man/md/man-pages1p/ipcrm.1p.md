# ipcrm(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

ipcrm
— remove an XSI message queue, semaphore set, or shared memory
segment identifier

<a name="synopsis"></a>

# Synopsis

```


```
    ipcrm [(miq msgid|(miQ msgkey|(mis semid|(miS semkey|(mim shmid|(miM shmkey]...

<a name="description"></a>

# Description

The
_ipcrm_
utility shall remove zero or more message queues, semaphore sets, or
shared memory segments. The interprocess communication facilities to be
removed are specified by the options.

Only a user with appropriate privileges shall be allowed to remove an
interprocess communication facility that was not created by or owned by
the user invoking
_ipcrm_.

<a name="options"></a>

# Options

The
_ipcrm_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(miq&nbsp;msgid**  
  Remove the message queue identifier
  _msgid_
  from the system and destroy the message queue and data structure
  associated with it.
* **\(mim&nbsp;shmid**  
  Remove the shared memory identifier
  _shmid_
  from the system. The shared memory segment and data structure
  associated with it shall be destroyed after the last detach.
* **\(mis&nbsp;semid**  
  Remove the semaphore identifier
  _semid_
  from the system and destroy the set of semaphores and data structure
  associated with it.
* **\(miQ&nbsp;msgkey**  
  Remove the message queue identifier, created with key
  _msgkey_,
  from the system and destroy the message queue and data structure
  associated with it.
* **\(miM&nbsp;shmkey**  
  Remove the shared memory identifier, created with key
  _shmkey_,
  from the system. The shared memory segment and data structure
  associated with it shall be destroyed after the last detach.
* **\(miS&nbsp;semkey**  
  Remove the semaphore identifier, created with key
  _semkey_,
  from the system and destroy the set of semaphores and data structure
  associated with it.

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
_ipcrm_:

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

None.

<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__ipcs_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__msgctl_\^(\|)_,
__semctl_\^(\|)_,
__shmctl_\^(\|)_

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
