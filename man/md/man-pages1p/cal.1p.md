# cal(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

cal
— print a calendar

<a name="synopsis"></a>

# Synopsis

```


```
    cal [[month] year]

<a name="description"></a>

# Description

The
_cal_
utility shall write a calendar to standard output using the Julian
calendar for dates from January 1, 1 through September 2, 1752 and the
Gregorian calendar for dates from September 14, 1752 through December
31, 9999 as though the Gregorian calendar had been adopted on September
14, 1752.

If no operands are given,
_cal_
shall produce a one-month calendar for the current month in the
current year. If only the
_year_
operand is given,
_cal_
shall produce a calendar for all twelve months in the given calendar
year. If both
_month_
and
_year_
operands are given,
_cal_
shall produce a one-month calendar for the given month in the given year.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _month_  
  Specify the month to be displayed, represented as a decimal integer
  from 1 (January) to 12 (December).
* _year_  
  Specify the year for which the calendar is displayed, represented as a
  decimal integer from 1 to 9999.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_cal_:

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
* _LC\_TIME_  
  Determine the format and contents of the calendar.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TZ_  
  Determine the timezone used to calculate the value of the current
  month.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The standard output shall be used to display the calendar, in an
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

Note that:

    
    cal 83


refers to A.D. 83, not 1983.

<a name="examples"></a>

# Examples

None.

<a name="rationale"></a>

# Rationale

Earlier versions of this standard incorrectly required that the command:

    
    cal 2000


write a one-month calendar for the current calendar month (no matter what
the current year is) in the year 2000 to standard output. This did not
match historic practice in any known version of the
_cal_
utility. The description has been updated to match historic practice.
When only the
_year_
operand is given,
_cal_
writes a twelve-month calendar for the specified year.

<a name="future-directions"></a>

# Future Directions

A future version of this standard may support locale-specific
recognition of the date of adoption of the Gregorian calendar.

<a name="see-also"></a>

# See Also

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_

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
