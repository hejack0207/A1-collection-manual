# cal(1) - display a calendar

util-linux, January 2018

```
cal [options] [[[day] month] year]
cal [options] [timestamp|monthname]
```

<a name="description"></a>

# Description

**cal**
displays a simple calendar.  If no arguments are specified, the current
month is displayed.

The _month_ may be specified as a number (1-12), as a month name or as an
abbreviated month name according to the current locales.

Two different calendar systems are used, Gregorian and Julian.  These are
nearly identical systems with Gregorian making a small adjustment to the
frequency of leap years; this facilitates improved synchronization with solar
events like the equinoxes.  The Gregorian calendar reform was introduced in
1582, but its adoption continued up to 1923.  By default
**cal**
uses the adoption date of 3 Sept 1752.  From that date forward the Gregorian
calendar is displayed; previous dates use the Julian calendar system.  11 days
were removed at the time of adoption to bring the calendar in sync with solar
events.  So Sept 1752 has a mix of Julian and Gregorian dates by which the 2nd
is followed by the 14th (the 3rd through the 13th are absent).

Optionally, either the proleptic Gregorian calendar or the Julian calendar may
be used exclusively.
See&nbsp;**--reform&nbsp;**below.

<a name="options"></a>

# Options


* **-1**, **--one**  
  Display single month output.
  (This is the default.)
* **-3**, **--three**  
  Display three months spanning the date.
* **-n , --months** _number_  
  Display _number_ of months, starting from the month containing the date.
* **-S, --span**  
  Display months spanning the date.
* **-s**, **--sunday**  
  Display Sunday as the first day of the week.
* **-m**, **--monday**  
  Display Monday as the first day of the week.
* **--iso**  
  Display the proleptic Gregorian calendar exclusively.
  See&nbsp;**--reform&nbsp;**below.
* **-j**, **--julian**  
  Use day-of-year numbering for all calendars.  These are also called ordinal
  days.  Ordinal days range from 1 to 366.  This option does not switch from the
  Gregorian to the Julian calendar system, that is controlled by the
  **--reform&nbsp;**option.

Sometimes Gregorian calendars using ordinal dates are referred to as Julian
calendars.  This can be confusing due to the many date related conventions that
use Julian in their name: (ordinal) julian date, julian (calendar) date,
(astronomical) julian date, (modified) julian date, and more.  This option is
named julian, because ordinal days are identified as julian by the POSIX
standard.  However, be aware that
**cal**
also uses the Julian calendar system.
See&nbsp;**DESCRIPTION&nbsp;**above.

* **--reform&nbsp;**_val_  
  This option sets the adoption date of the Gregorian calendar reform.  Calendar
  dates previous to reform use the Julian calendar system.  Calendar dates
  after reform use the Gregorian calendar system.  The argument
  _val_
  can be:
    * ·  
      _1752_
      - sets 3 September 1752 as the reform date (default).
      This is when the Gregorian calendar reform was adopted by the British Empire.
    * ·  
      _gregorian_
      - display Gregorian calendars exclusively.  This special placeholder sets the
      reform date below the smallest year that
      **cal**
      can use; meaning all calendar output uses the Gregorian calendar system.  This
      is called the proleptic Gregorian calendar, because dates prior to the calendar
      system's creation use extrapolated values.
    * ·  
      _iso_
      - alias of
      _gregorian_.
      The ISO 8601 standard for the representation of dates and times in information
      interchange requires using the proleptic Gregorian calendar.
    * ·  
      _julian_
      - display Julian calendars exclusively.  This special placeholder sets the reform date above the largest year that
      **cal**
      can use; meaning all
      calendar output uses the Julian calendar system.

See&nbsp;**DESCRIPTION&nbsp;**above.

* **-y**, **--year**  
  Display a calendar for the whole year.
* **-Y, --twelve**  
  Display a calendar for the next twelve months.
* **-w**, **--week**[=_number_]  
  Display week numbers in the calendar (US or ISO-8601).
* **--color**[=_when_]  
  Colorize the output.  The optional argument _when_
  can be **auto**, **never** or **always**.  If the _when_ argument is omitted,
  it defaults to **auto**.  The colors can be disabled; for the current built-in default
  see the **--help** output.  See also the **COLORS** section.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="parameters"></a>

# Parameters


* **Single digits-only parameter (e.g. 'cal 2020')**  
  Specifies the _year_ to be displayed; note the year must be fully specified:
  **cal 89**
  will not display a calendar for 1989.
* **Single string parameter (e.g. 'cal tomorrow' or 'cal August')**  
  Specifies _timestamp_ or a _month name_ (or abbreviated name) according to the current
  locales.

The special placeholders are accepted when parsing timestamp, "now" may be used
to refer to the current time, "today", "yesterday", "tomorrow" refer to of the
current day, the day before or the next day, respectively.

The relative date specifications are also accepted, in this case "+" is
evaluated to the current time plus the specified time span. Correspondingly, a
time span that is prefixed with "-" is evaluated to the current time minus the
specified time span, for example '+2days'. Instead of prefixing the time span
with "+" or "-", it may also be suffixed with a space and the word "left" or
"ago" (for example '1 week ago').

* **Two parameters (e.g. 'cal 11 2020')**  
  Denote the _month_ (1 - 12) and _year_.
* **Three parameters (e.g. 'cal 25 11 2020')**  
  Denote the _day_ (1-31), _month and year_, and the day will be
  highlighted if the calendar is displayed on a terminal.  If no parameters are
  specified, the current month's calendar is displayed.

<a name="notes"></a>

# Notes

A year starts on January 1.  The first day of the week is determined by the
locale or the
**--sunday**&nbsp;and**&nbsp;--monday**&nbsp;options.

The week numbering depends on the choice of the first day of the week.  If it
is Sunday then the customary North American numbering is used, where 1 January
is in week number 1.  If it is Monday then the ISO 8601 standard week numbering
is used, where the first Thursday is in week number 1.

<a name="colors"></a>

# Colors

Implicit coloring can be disabled as follows:
  
**touch /etc/terminal-colors.d/cal.disable**  

See
**terminal-colors.d**(5)
for more details about colorization configuration.

<a name="bugs"></a>

# Bugs


The default
**cal**
output uses 3 September 1752 as the Gregorian calendar reform date.  The
historical reform  dates for the other locales, including its introduction in
October 1582, are not implemented.

Alternative calendars, such as the Umm al-Qura, the Solar Hijri, the Ge'ez,
or the lunisolar Hindu, are not supported.

<a name="history"></a>

# History

A cal command appeared in Version 6 AT&T UNIX.

<a name="availability"></a>

# Availability

The cal command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
