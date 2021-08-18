# date(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

date
— write the date and time

<a name="synopsis"></a>

# Synopsis

```


```
    date [(miu] [+format]
    
    date [(miu] mmddhhmm[[cc]yy]

<a name="description"></a>

# Description

The
_date_
utility shall write the date and time to standard output
or attempt to set the system date and time.
By default, the current date and time shall be written. If an operand
beginning with
**'\(pl'**
is specified, the output format of
_date_
shall be controlled by the conversion specifications and other text
in the operand.

<a name="options"></a>

# Options

The
_date_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(miu**  
  Perform operations as if the
  _TZ_
  environment variable was set to the string
  **"UTC0"**,
  or its equivalent historical value of
  **"GMT0"**.
  Otherwise,
  _date_
  shall use the timezone indicated by the
  _TZ_
  environment variable or the system default if that variable is
  unset or null.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* +_format_  
  When the format is specified, each conversion specifier shall be
  replaced in the standard output by its corresponding value. All other
  characters shall be copied to the output without change. The output
  shall always be terminated with a
  &lt;newline&gt;.

<a name="conversion-specifications"></a>

### Conversion Specifications


* %a  
  Locale's abbreviated weekday name.
* %A  
  Locale's full weekday name.
* %b  
  Locale's abbreviated month name.
* %B  
  Locale's full month name.
* %c  
  Locale's appropriate date and time representation.
* %C  
  Century (a year divided by 100 and truncated to an integer) as a
  decimal number [00,99].
* %d  
  Day of the month as a decimal number [01,31].
* %D  
  Date in the format _mm_/_dd_/_yy_.
* %e  
  Day of the month as a decimal number [1,31] in a two-digit field
  with leading
  &lt;space&gt;
  character fill.
* %h  
  A synonym for
  **%b**.
* %H  
  Hour (24-hour clock) as a decimal number [00,23].
* %I  
  Hour (12-hour clock) as a decimal number [01,12].
* %j  
  Day of the year as a decimal number [001,366].
* %m  
  Month as a decimal number [01,12].
* %M  
  Minute as a decimal number [00,59].
* %n  
  A
  &lt;newline&gt;.
* %p  
  Locale's equivalent of either AM or PM.
* %r  
  12-hour clock time [01,12] using the AM/PM notation; in the POSIX
  locale, this shall be equivalent to
  **%I**:\c
  **%M**:\c
  **%S**
  **%p**.
* %S  
  Seconds as a decimal number [00,60].
* %t  
  A
  &lt;tab&gt;.
* %T  
  24-hour clock time [00,23] in the format _HH_:_MM_:_SS_.
* %u  
  Weekday as a decimal number [1,7] (1=Monday).
* %U  
  Week of the year (Sunday as the first day of the week) as a decimal
  number [00,53]. All days in a new year preceding the first Sunday
  shall be considered to be in week 0.
* %V  
  Week of the year (Monday as the first day of the week) as a decimal
  number [01,53]. If the week containing January 1 has four or more
  days in the new year, then it shall be considered week 1; otherwise, it
  shall be the last week of the previous year, and the next week shall be
  week 1.
* %w  
  Weekday as a decimal number [0,6] (0=Sunday).
* %W  
  Week of the year (Monday as the first day of the week) as a decimal
  number [00,53]. All days in a new year preceding the first Monday
  shall be considered to be in week 0.
* %x  
  Locale's appropriate date representation.
* %X  
  Locale's appropriate time representation.
* %y  
  Year within century [00,99].
* %Y  
  Year with century as a decimal number.
* %Z  
  Timezone name, or no characters if no timezone is determinable.
* %%  
  A
  &lt;percent-sign&gt;
  character.

See the Base Definitions volume of POSIX.1-2008,
_Section 7.3.5_, _LC_TIME_
for the conversion specifier values in the POSIX locale.

<a name="modified-conversion-specifications"></a>

### Modified Conversion Specifications


Some conversion specifiers can be modified by the
**E**
and
**O**
modifier characters to indicate a different format or specification as
specified in the
_LC_TIME_
locale description (see the Base Definitions volume of POSIX.1-2008,
_Section 7.3.5_, _LC_TIME_).
If the corresponding keyword (see
**era**,
**era_year**,
**era_d_fmt**,
and
**alt_digits**
in the Base Definitions volume of POSIX.1-2008,
_Section 7.3.5_, _LC_TIME_)
is not specified or not supported for the current locale,
the unmodified conversion specifier value shall be used.

* %Ec  
  Locale's alternative appropriate date and time representation.
* %EC  
  The name of the base year (period) in the locale's alternative
  representation.
* %Ex  
  Locale's alternative date representation.
* %EX  
  Locale's alternative time representation.
* %Ey  
  Offset from
  **%EC**
  (year only) in the locale's alternative representation.
* %EY  
  Full alternative year representation.
* %Od  
  Day of month using the locale's alternative numeric symbols.
* %Oe  
  Day of month using the locale's alternative numeric symbols.
* %OH  
  Hour (24-hour clock) using the locale's alternative numeric symbols.
* %OI  
  Hour (12-hour clock) using the locale's alternative numeric symbols.
* %Om  
  Month using the locale's alternative numeric symbols.
* %OM  
  Minutes using the locale's alternative numeric symbols.
* %OS  
  Seconds using the locale's alternative numeric symbols.
* %Ou  
  Weekday as a number in the locale's alternative representation (Monday
  = 1).
* %OU  
  Week number of the year (Sunday as the first day of the week) using the
  locale's alternative numeric symbols.
* %OV  
  Week number of the year (Monday as the first day of the week, rules
  corresponding to
  **%V**),
  using the locale's alternative numeric symbols.
* %Ow  
  Weekday as a number in the locale's alternative representation (Sunday
  = 0).
* %OW  
  Week number of the year (Monday as the first day of the week) using the
  locale's alternative numeric symbols.
* %Oy  
  Year (offset from
  **%C**)
  in alternative representation.

* mmddhhmm**[[cc]yy]**    
  Attempt to set the system date and time from the value given in the
  operand. This is only possible if the user has appropriate privileges
  and the system permits the setting of the system date and time. The
  first
  _mm_
  is the month (number);
  _dd_
  is the day (number);
  _hh_
  is the hour (number, 24-hour system); the second
  _mm_
  is the minute (number);
  _cc_
  is the century and is the first two digits of the year (this is
  optional);
  _yy_
  is the last two digits of the year and is optional. If century is not
  specified, then values in the range [69,99] shall refer to years
  1969 to 1999 inclusive, and values in the range [00,68] shall refer
  to years 2000 to 2068 inclusive. The current year is the default if
  _yy_
  is omitted.
    * **Note:**  
      It is expected that in a future version of this standard the default
      century inferred from a 2-digit year will change. (This would apply
      to all commands accepting a 2-digit year as input.)


<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_date_:

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
  Determine the format and contents of date and time strings written by
  _date_.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TZ_  
  Determine the timezone in which the time and date are written, unless
  the
  **\(miu**
  option is specified. If the
  _TZ_
  variable is unset or null and
  **\(miu**
  is not specified, an unspecified system default timezone is used.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

When no formatting operand is specified, the output in the POSIX locale
shall be equivalent to specifying:

    
    date "+%a %b %e %H:%M:%S %Z %Y"


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
  The date was written successfully.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Conversion specifiers are of unspecified format when not in the POSIX
locale. Some of them can contain
&lt;newline&gt;
characters in some locales, so it may be difficult to use the format
shown in standard output for parsing the output of
_date_
in those locales.

The range of values for
**%S**
extends from 0 to 60 seconds to accommodate the occasional leap second.

Although certain of the conversion specifiers in the POSIX locale (such
as the name of the month) are shown with initial capital letters, this
need not be the case in other locales. Programs using these fields may
need to adjust the capitalization if the output is going to be used at
the beginning of a sentence.

The date string formatting capabilities are intended for use in
Gregorian-style calendars, possibly with a different starting year (or
years). The
**%x**
and
**%c**
conversion specifications, however, are intended for local
representation; these may be based on a different, non-Gregorian
calendar.

The
**%C**
conversion specification was introduced to allow a fallback for the
**%EC**
(alternative year format base year); it can be viewed as the base of
the current subdivision in the Gregorian calendar. The century number
is calculated as the year divided by 100 and truncated to an integer;
it should not be confused with the use of ordinal numbers for centuries
(for example, \`\`twenty-first century''.) Both the
**%Ey**
and
**%y**
can then be viewed as the offset from
**%EC**
and
**%C**,
respectively.

The
**E**
and
**O**
modifiers modify the traditional conversion specifiers, so that they
can always be used, even if the implementation (or the current locale)
does not support the modifier.

The
**E**
modifier supports alternative date formats, such as the Japanese
Emperor's Era, as long as these are based on the Gregorian calendar
system. Extending the
**E**
modifiers to other date elements may provide an implementation-defined
extension capable of supporting other calendar systems, especially in
combination with the
**O**
modifier.

The
**O**
modifier supports time and date formats using the locale's alternative
numerical symbols, such as Kanji or Hindi digits or ordinal number
representation.

Non-European locales, whether they use Latin digits in computational
items or not, often have local forms of the digits for use in date
formats. This is not totally unknown even in Europe; a variant of dates
uses Roman numerals for the months: the third day of September 1991
would be written as 3.IX.1991. In Japan, Kanji digits are regularly
used for dates; in Arabic-speaking countries, Hindi digits are used.
The
**%d**,
**%e**,
**%H**,
**%I**,
**%m**,
**%S**,
**%U**,
**%w**,
**%W**,
and
**%y**
conversion specifications always return the date and time field in
Latin digits (that is, 0 to 9). The
**%O**
modifier was introduced to support the use for display purposes of
non-Latin digits. In the
_LC_TIME_
category in
_localedef_,
the optional
**alt_digits**
keyword is intended for this purpose. As an example, assume the
following (partial)
_localedef_
source:

    
    alt_digits  "";"I";"II";"III";"IV";"V";"VI";"VII";"VIII" e
                "IX";"X";"XI";"XII"
    d_fmt       "%e.%Om.%Y"


With the above date, the command:

    
    date "+%x"


would yield 3.IX.1991. With the same
**d_fmt**,
but without the
**alt_digits**,
the command would yield 3.9.1991.

<a name="examples"></a>

# Examples


*  1.  
  The following are input/output examples of
  _date_
  used at arbitrary times in the POSIX locale:

    
    $ date
    Tue Jun 26 09:58:10 PDT 1990
    
    $ date "+DATE: %m/%d/%y%nTIME: %H:%M:%S"
    DATE: 11/02/91
    TIME: 13:36:16
    
    $ date "+TIME: %r"
    TIME: 01:36:32 PM


*  2.  
  Examples for Denmark, where the default date and time format is
  **%a**
  **%d**
  **%b**
  **%Y**
  **%T**
  **%Z**:

    
    $ LANG=da_DK.iso_8859(mi1 date
    ons 02 okt 1991 15:03:32 CET
    
    $ LANG=da_DK.iso_8859(mi1 e
        date "+DATO: %A den %e. %B %Y%nKLOKKEN: %H:%M:%S"
    DATO: onsdag den 2. oktober 1991
    KLOKKEN: 15:03:56


*  3.  
  Examples for Germany, where the default date and time format is
  **%a**
  **%d**.\c
  **%h**.\c
  **%Y**,
  **%T**
  **%Z**:

    
    $ LANG=De_DE.88591 date
    Mi 02.Okt.1991, 15:01:21 MEZ
    
    $ LANG=De_DE.88591 date "+DATUM: %A, %d. %B %Y%nZEIT: %H:%M:%S"
    DATUM: Mittwoch, 02. Oktober 1991
    ZEIT: 15:02:02


*  4.  
  Examples for France, where the default date and time format is
  **%a**
  **%d**
  **%h**
  **%Y**
  **%Z**
  **%T**:

    
    $ LANG=Fr_FR.88591 date
    Mer 02 oct 1991 MET 15:03:32
    
    $ LANG=Fr_FR.88591 date "+JOUR: %A %d %B %Y%nHEURE: %H:%M:%S"
    JOUR: Mercredi 02 octobre 1991
    HEURE: 15:03:56


<a name="rationale"></a>

# Rationale

Some of the new options for formatting are from the ISO&nbsp;C standard. The
**\(miu**
option was introduced to allow portable access to Coordinated Universal
Time (UTC).
The string
**"GMT0"**
is allowed as an equivalent
_TZ_
value to be compatible with all of the systems using the BSD
implementation, where this option originated.

The
**%e**
format conversion specification (adopted from System V) was added
because the ISO&nbsp;C standard conversion specifications did not provide any way to
produce the historical default
_date_
output during the first nine days of any month.

There are two varieties of day and week numbering supported (in
addition to any others created with the locale-dependent
**%E**
and
**%O**
modifier characters):

*  *  
  The historical variety in which Sunday is the first day of the week and
  the weekdays preceding the first Sunday of the year are considered week
  0. These are represented by
  **%w**
  and
  **%U**.
  A variant of this is
  **%W**,
  using Monday as the first day of the week, but still referring to week
  0. This view of the calendar was retained because so many historical
  applications depend on it and the ISO&nbsp;C standard
  _strftime_()
  function, on which many
  _date_
  implementations are based, was defined in this way.
*  *  
  The international standard, based on the ISO&nbsp;8601:\|2004 standard where Monday is the
  first weekday and the algorithm for the first week number is more
  complex: If the week (Monday to Sunday) containing January 1 has four
  or more days in the new year, then it is week 1; otherwise, it is week
  53 of the previous year, and the next week is week 1. These are
  represented by the new conversion specifications
  **%u**
  and
  **%V**,
  added as a result of international comments.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

The Base Definitions volume of POSIX.1-2008,
_Section 7.3.5_, _LC_TIME_,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__fprintf_\^(\|)_,
__strftime_\^(\|)_

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
