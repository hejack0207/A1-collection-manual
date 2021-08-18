# sleep(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

sleep
— suspend execution for an interval

<a name="synopsis"></a>

# Synopsis

```


```
    sleep time

<a name="description"></a>

# Description

The
_sleep_
utility shall suspend execution for at least the integral number of
seconds specified by the
_time_
operand.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _time_  
  A non-negative decimal integer specifying the number of seconds for
  which to suspend execution.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_sleep_:

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

If the
_sleep_
utility receives a SIGALRM signal, one of the following actions shall
be taken:

*  1.  
  Terminate normally with a zero exit status.
*  2.  
  Effectively ignore the signal.
*  3.  
  Provide the default behavior for signals described in the ASYNCHRONOUS
  EVENTS section of
  _Section 1.4_, _Utility Description Defaults_.
  This could include terminating with a non-zero exit status.

The
_sleep_
utility shall take the standard action for all other signals.

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
  The execution was successfully suspended for at least
  _time_
  seconds, or a SIGALRM signal was received. See the ASYNCHRONOUS EVENTS
  section.
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

The
_sleep_
utility can be used to execute a command after a certain amount of
time, as in:

    
    (sleep 105; command) &


or to execute a command every so often, as in:

    
    while true
    do
        command
        sleep 37
    done


<a name="rationale"></a>

# Rationale

The exit status is allowed to be zero when
_sleep_
is interrupted by the SIGALRM signal because most implementations of
this utility rely on the arrival of that signal to notify them that the
requested finishing time has been successfully attained. Such
implementations thus do not distinguish this situation from the
successful completion case. Other implementations are allowed to catch
the signal and go back to sleep until the requested time expires or to
provide the normal signal termination procedures.

As with all other utilities that take integral operands and do not
specify subranges of allowed values,
_sleep_
is required by this volume of POSIX.1-2008 to deal with
_time_
requests of up to 2\|147\|483\|647 seconds. This may mean that some
implementations have to make multiple calls to the delay mechanism of
the underlying operating system if its argument range is less than
this.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__wait_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_

The System Interfaces volume of POSIX.1-2008,
__alarm_\^(\|)_,
__sleep_\^(\|)_

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
