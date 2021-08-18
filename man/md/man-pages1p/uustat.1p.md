# uustat(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

uustat
— uucp status enquiry and job control

<a name="synopsis"></a>

# Synopsis

```


```
    uustat [(miq|(mik jobid|(mir jobid]
    
    uustat [(mis system] [(miu user]

<a name="description"></a>

# Description

The
_uustat_
utility shall display the status of, or cancel, previously specified
_uucp_
requests, or provide general status on
_uucp_
connections to other systems.

When no options are given,
_uustat_
shall write to standard output the status of all
_uucp_
requests issued by the current user.

Typical implementations of this utility require a communications line
configured to use the Base Definitions volume of POSIX.1-2008,
_Chapter 11_, _General Terminal Interface_,
but other communications means may be used. On systems where there are
no available communications means (either temporarily or permanently),
this utility shall write an error message describing the problem and
exit with a non-zero exit status.

<a name="options"></a>

# Options

The
_uustat_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(miq**  
  Write the jobs queued for each machine.
* **\(mik&nbsp;jobid**  
  Kill the
  _uucp_
  request whose job identification is
  _jobid_.
  The application shall ensure that the killed
  _uucp_
  request belongs to the person invoking
  _uustat_
  unless that user has appropriate privileges.
* **\(mir&nbsp;jobid**  
  Rejuvenate
  _jobid_.
  The files associated with
  _jobid_
  are touched so that their modification time is set to the current
  time. This prevents the cleanup program from deleting the job until
  the jobs modification time reaches the limit imposed by the program.
* **\(mis&nbsp;system**  
  Write the status of all
  _uucp_
  requests for remote system
  _system_.
* **\(miu&nbsp;user**  
  Write the status of all
  _uucp_
  requests issued by
  _user_.

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
_uustat_:

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
  contents of diagnostic messages written to standard error, and
  informative messages written to standard output.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The standard output shall consist of information about each job
selected, in an unspecified format. The information shall include at
least the job ID, the user ID or name, and the remote system name.

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

This utility is part of the UUCP Utilities option and need not be
supported by all implementations.

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

__uucp_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Chapter 11_, _General Terminal Interface_,
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
