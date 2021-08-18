# touch(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

touch
— change file access and modification times

<a name="synopsis"></a>

# Synopsis

```


```
    touch [(miacm] [(mir ref_file|(mit time|(mid date_time] file...

<a name="description"></a>

# Description

The
_touch_
utility shall change the last data modification timestamps, the
last data access timestamps, or both.

The time used can be specified by the
**\(mit**
_time_
option-argument, the corresponding
_time_
fields of the file referenced by the
**\(mir**
_ref_file_
option-argument, or the
**\(mid**
_date_time_
option-argument, as specified in the following sections. If none of
these are specified,
_touch_
shall use the current time.

For each
_file_
operand,
_touch_
shall perform actions equivalent to the following functions defined in
the System Interfaces volume of POSIX.1-2008:

*  1.  
  If
  _file_
  does not exist:
    *  a.  
      The
      _creat_()
      function is called with the following arguments:
        * --  
          The
          _file_
          operand is used as the
          _path_
          argument.
        * --  
          The value of the bitwise-inclusive OR of S_IRUSR, S_IWUSR,
          S_IRGRP, S_IWGRP, S_IROTH, and S_IWOTH is used as the
          _mode_
          argument.
    *  b.  
      The
      _futimens_()
      function is called with the following arguments:
        * --  
          The file descriptor opened in step 1a.
        * --  
          The access time and the modification time, set as described in the
          OPTIONS section, are used as the first and second elements of the
          _times_
          array argument, respectively.
*  2.  
  If
  _file_
  exists, the
  _utimensat_()
  function is called with the following arguments:
    *  a.  
      The AT_FDCWD special value is used as the
      _fd_
      argument.
    *  b.  
      The
      _file_
      operand is used as the
      _path_
      argument.
    *  c.  
      The access time and the modification time, set as described in the
      OPTIONS section, are used as the first and second elements of the
      _times_
      array argument, respectively.
    *  d.  
      The
      _flag_
      argument is set to zero.

<a name="options"></a>

# Options

The
_touch_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following options shall be supported:

* **\(mia**  
  Change the access time of
  _file_.
  Do not change the modification time unless
  **\(mim**
  is also specified.
* **\(mic**  
  Do not create a specified
  _file_
  if it does not exist. Do not write any diagnostic messages concerning
  this condition.
* **\(mid&nbsp;date\_time**  
  Use the specified
  _date_time_
  instead of the current time. The option-argument shall be a string of
  the form:

    
    YYYY(miMM(miDDThh:mm:SS[.frac][tz]


or:

    
    YYYY(miMM(miDDThh:mm:SS[,frac][tz]


where:

*  *  
  _YYYY_
  are at least four decimal digits giving the year.
*  *  
  _MM_,
  _DD_,
  _hh_,
  _mm_,
  and
  _SS_
  are as with
  **\(mit**
  _time_.
*  *  
  T is the time designator, and can be replaced by a single
  &lt;space&gt;.
*  *  
  [._frac_] and [,_frac_] are either empty, or a
  &lt;period&gt;
  (\c
  **'.'**)
  or a
  &lt;comma&gt;
  (\c
  **','**)
  respectively, followed by one or more decimal digits, specifying
  a fractional second.
*  *  
  [_tz_] is either empty, signifying local time, or the letter
  **'Z'**,
  signifying UTC. If [_tz_] is empty, the resulting time shall
  be affected by the value of the
  _TZ_
  environment variable.

If the resulting time precedes the Epoch, the behavior is
implementation-defined. If the time cannot be represented as the file's
timestamp,
_touch_
shall exit immediately with an error status.

* **\(mim**  
  Change the modification time of
  _file_.
  Do not change the access time unless
  **\(mia**
  is also specified.
* **\(mir&nbsp;ref\_file**  
  Use the corresponding time of the file named by the pathname
  _ref_file_
  instead of the current time.
* **\(mit&nbsp;time**  
  Use the specified
  _time_
  instead of the current time. The option-argument shall be a decimal
  number of the form:

    
    [[CC]YY]MMDDhhmm[.SS]


where each two digits represents the following:

* _MM_  
  The month of the year [01,12].
* _DD_  
  The day of the month [01,31].
* _hh_  
  The hour of the day [00,23].
* _mm_  
  The minute of the hour [00,59].
* _CC_  
  The first two digits of the year (the century).
* _YY_  
  The second two digits of the year.
* _SS_  
  The second of the minute [00,60].

Both
_CC_
and
_YY_
shall be optional. If neither is given, the current year shall be
assumed. If
_YY_
is specified, but
_CC_
is not,
_CC_
shall be derived as follows:
.TS
center tab(@) box;
cB | cB
c | n.
If _YY_ is:@_CC_ becomes:
_
[69,99]@19
[00,68]@20
.TE

* **Note:**  
  It is expected that in a future version of this standard the default
  century inferred from a 2-digit year will change. (This would apply
  to all commands accepting a 2-digit year as input.)


The resulting time shall be affected by the value of the
_TZ_
environment variable. If the resulting time value precedes the Epoch,
the behavior is implementation-defined. If the time is out of range for
the file's timestamp,
_touch_
shall exit immediately with an error status. The range of valid times
past the Epoch is implementation-defined, but it shall extend to at
least the time 0 hours, 0 minutes, 0 seconds, January 1, 2038,
Coordinated Universal Time. Some implementations may not be able to
represent dates beyond January 18, 2038, because they use
**signed int**
as a time holder.

The range for
_SS_
is [00,60] rather than [00,59] because of leap seconds. If
_SS_
is 60, and the resulting time, as affected by the
_TZ_
environment variable, does not refer to a leap second, the resulting
time shall be one second after a time where
_SS_
is 59. If
_SS_
is not given a value, it is assumed to be zero.

If neither the
**\(mia**
nor
**\(mim**
options were specified,
_touch_
shall behave as if both the
**\(mia**
and
**\(mim**
options were specified.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _file_  
  A pathname of a file whose times shall be modified.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_touch_:

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
  Determine the timezone to be used for interpreting the
  _time_
  option-argument. If
  _TZ_
  is unset or null, an unspecified default timezone shall be used.

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
  The utility executed successfully and all requested changes were made.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The interpretation of time is taken to be
_seconds since the Epoch_
(see the Base Definitions volume of POSIX.1-2008,
_Section 4.15_, _Seconds Since the Epoch_).
It should be noted that implementations conforming to the System Interfaces volume of POSIX.1-2008 do
not take leap seconds into account when computing seconds since the
Epoch. When
_SS_=60
is used, the resulting time always refers to 1 plus
_seconds since the Epoch_
for a time when
_SS_=59.

Although the
**\(mit**
_time_
option-argument specifies values in 1969, the access time and
modification time fields are defined in terms of seconds since the
Epoch (00:00:00 on 1 January 1970 UTC). Therefore, depending on the
value of
_TZ_
when
_touch_
is run, there is never more than a few valid hours in 1969 and there
need not be any valid times in 1969.

One ambiguous situation occurs if
**\(mit**
_time_
is not specified,
**\(mir**
_ref_file_
is not specified, and the first operand is an eight or ten-digit
decimal number. A portable script can avoid this problem by using:

    
    touch (mi|(mi file


or:

    
    touch ./file


in this case.

If the
_T_
time designator is replaced by a
&lt;space&gt;
for the
**\(mid**
_date_time_
option-argument, the
&lt;space&gt;
must be quoted to prevent the shell from splitting the argument.

<a name="examples"></a>

# Examples

Create or update a file called
**dwc**;
the resulting file has both the last data modification and last data
access timestamps set to November 12, 2007 at 10:15:30 local time:

    
    touch (mid 2007-11-12T10:15:30 dwc


Create or update a file called
**nick**;
the resulting file has both the last data modification and last data
access timestamps set to November 12, 2007 at 10:15:30 UTC:

    
    touch (mid 2007-11-12T10:15:30Z nick


Create or update a file called
**gwc**;
the resulting file has both the last data modification and last data
access timestamps set to November 12, 2007 at 10:15:30 local time with
a fractional second timestamp of .002 seconds:

    
    touch (mid 2007-11-12T10:15:30,002 gwc


Create or update a file called
**ajosey**;
the resulting file has both the last data modification and last data
access timestamps set to November 12, 2007 at 10:15:30 UTC with a
fractional second timestamp of .002 seconds:

    
    touch (mid "2007-11-12 10:15:30.002Z" ajosey


Create or update a file called
**cathy**;
the resulting file has both the last data modification and last data
access timestamps set to November 12, 2007 at 10:15:00 local time:

    
    touch (mit 200711121015 cathy


Create or update a file called
**drepper**;
the resulting file has both the last data modification and last data
access timestamps set to November 12, 2007 at 10:15:30 local time:

    
    touch (mit 200711121015.30 drepper


Create or update a file called
**ebb9**;
the resulting file has both the last data modification and last data
access timestamps set to November 12, 2007 at 10:15:30 local time:

    
    touch (mit 0711121015.30 ebb9


Create or update a file called
**eggert**;
the resulting file has the last data access timestamp set to the
corresponding time of the file named
**mark**
instead of the current time. If the file exists, the last data
modification time is not changed:

    
    touch (mia (mir mark eggert


<a name="rationale"></a>

# Rationale

The functionality of
_touch_
is described almost entirely through references to functions in
the System Interfaces volume of POSIX.1-2008. In this way, there is no duplication of effort required for
describing such side-effects as the relationship of user IDs to the
user database, permissions, and so on.

There are some significant differences between the
_touch_
utility in this volume of POSIX.1-2008 and those in System V and BSD systems. They are
upwards-compatible for historical applications from both
implementations:

*  1.  
  In System V, an ambiguity exists when a pathname that is a decimal
  number leads the operands; it is treated as a time value. In BSD, no
  _time_
  value is allowed; files may only be
  _touch_ed
  to the current time. The
  **\(mit**
  _time_
  construct solves these problems for future conforming applications (note
  that the
  **\(mit**
  option is not historical practice).
*  2.  
  The inclusion of the century digits,
  _CC_,
  is also new. Note that a ten-digit
  _time_
  value is treated as if
  _YY_,
  and not
  _CC_,
  were specified. The caveat about the range of dates following the
  Epoch was included as recognition that some implementations are not
  able to represent dates beyond 18 January 2038 because they use
  **signed int**
  as a time holder.

The
**\(mir**
option was added because several comments requested this capability.
This option was named
**\(mif**
in an early proposal, but was changed because the
**\(mif**
option is used in the BSD version of
_touch_
with a different meaning.

At least one historical implementation of
_touch_
incremented the exit code if
**\(mic**
was specified and the file did not exist. This volume of POSIX.1-2008 requires exit status
zero if no errors occur.

In previous version of the standard, if at least two operands are
specified, and the first operand is an eight or ten-digit decimal
integer, the first operand was assumed to be a
_date_time_
operand. This usage was removed in this version of the standard since
it had been marked obsolescent previously.

The
**\(mid**
_date_time_
format is an ISO&nbsp;8601:\|2004 standard complete representation of date and time extended
format with an optional decimal point or
&lt;comma&gt;
followed by a string of digits following the seconds portion to specify
fractions of a second. It is not necessary to recognize
**"[+/-]hh:mm"**
and
**"[+/-]hh"**
to specify timezones other than local time and UTC. The
_T_
time designator in the ISO&nbsp;8601:\|2004 standard extended format may be replaced by
&lt;space&gt;.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__date_\^_

The Base Definitions volume of POSIX.1-2008,
_Section 4.15_, _Seconds Since the Epoch_,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_,
_**&lt;sys\_stat.h&gt;**_

The System Interfaces volume of POSIX.1-2008,
__creat_\^(\|)_,
__futimens_\^(\|)_,
__time_\^(\|)_,
__utime_\^(\|)_

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
