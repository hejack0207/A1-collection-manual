# FormatTime

Transforms a [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) timestamp into the specified date/time format.

```
<span class="func">FormatTime</span>, OutputVar <span class="optional">, <a href="FileSetTime.htm#YYYYMMDD" data-index="2">YYYYMMDDHH24MISS</a>, Format</span>
```

## Parameters

OutputVar

The name of the variable in which to store the result.

YYYYMMDD...

Leave this parameter blank to use the current local date and time. Otherwise, specify all or the leading part of a timestamp in the [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format. If the date and/or time portion of the timestamp is invalid -- such as February 29th of a non-leap year -- the date and/or time will be omitted from _OutputVar_. Although only years between 1601 and 9999 are supported, a formatted time can still be produced for earlier years as long as the time portion is valid.

Format

If omitted, it defaults to the time followed by the long date, both of which will be formatted according to the current user's locale. For example: 4:55 PM Saturday, November 27, 2004

Otherwise, specify one or more of the date-time formats below, along with any literal spaces and punctuation in between (commas do not need to be escaped; they can be used normally). In the following example, note that M must be capitalized: M/d/yyyy h:mm tt

## Date Formats (case sensitive)

FormatDescriptiondDay of the month without leading zero (1 – 31)ddDay of the month with leading zero (01 – 31)dddAbbreviated name for the day of the week (e.g. Mon) in the current user's languageddddFull name for the day of the week (e.g. Monday) in the current user's languageMMonth without leading zero (1 – 12)MMMonth with leading zero (01 – 12)MMMAbbreviated month name (e.g. Jan) in the current user's languageMMMMFull month name (e.g. January) in the current user's languageyYear without century, without leading zero (0 – 99)yyYear without century, with leading zero (00 – 99)yyyyYear with century. For example: 2005ggPeriod/era string for the current user's locale (blank if none)

## Time Formats (case sensitive)

FormatDescriptionhHours without leading zero; 12-hour format (1 – 12)hhHours with leading zero; 12-hour format (01 – 12)HHours without leading zero; 24-hour format (0 – 23)HHHours with leading zero; 24-hour format (00 – 23)mMinutes without leading zero (0 – 59)mmMinutes with leading zero (00 – 59)sSeconds without leading zero (0 – 59)ssSeconds with leading zero (00 – 59)tSingle character time marker, such as A or P (depends on locale)ttMulti-character time marker, such as AM or PM (depends on locale)

## Standalone Formats

The following formats must be used **alone**; that is, with no other formats or text present in the _Format_ parameter. These formats are not case sensitive.

FormatDescription(Blank)Leave _Format_ blank to produce the time followed by the long date. For example, in some locales it might appear as 4:55 PM Saturday, November 27, 2004TimeTime representation for the current user's locale, such as 5:26 PMShortDateShort date representation for the current user's locale, such as 02/29/04LongDateLong date representation for the current user's locale, such as Friday, April 23, 2004YearMonthYear and month format for the current user's locale, such as February, 2004YDayDay of the year without leading zeros (1 – 366)YDay0Day of the year with leading zeros (001 – 366)WDayDay of the week (1 – 7). Sunday is 1.YWeekThe ISO 8601 full year and week number. For example: 200453. If the week containing January 1st has four or more days in the new year, it is considered week 1. Otherwise, it is the last week of the previous year, and the next week is week 1. Consequently, both January 4th and the first Thursday of January are always in week 1.

## Additional Options

The following options can appear inside the _YYYYMMDDHH24MISS_ parameter immediately after the timestamp (if there is no timestamp, they may be used alone). In the following example, note the lack of commas between the last four items:

```
FormatTime, OutputVar, 20040228 LSys D1 D4
```

**R**: Reverse. Have the date come before the time (meaningful only when _Format_ is blank).

**Ln**: If this option is _not_ present, the current user's locale is used to format the string. To use the system's locale instead, specify LSys. To use a specific locale, specify the letter L followed by a hexadecimal or decimal locale identifier (LCID). For information on how to construct an LCID, search [www.microsoft.com](https://www.microsoft.com) for the following phrase: Locale Identifiers

**Dn**: Date options. Specify for **n** one of the following numbers:

- 0 = Force the default options to be used. This also causes the short date to be in effect.
- 1 = Use short date (meaningful only when_Format_ is blank; not compatible with 2 and 8).
- 2 = Use long date (meaningful only when_Format_ is blank; not compatible with 1 and 8).
- 4 = Use alternate calendar (if any).
- 8 = Use Year-Month format (meaningful only when_Format_ is blank; not compatible with 1 and 2).
- 0x10 = Add marks for left-to-right reading order layout.
- 0x20 = Add marks for right-to-left reading order layout.
- 0x80000000 = Do not obey any overrides the user may have in effect for the system's default date format.
- 0x40000000 = Use the system ANSI code page for string translation instead of the locale's code page.

**Tn**: Time options. Specify for **n** one of the following numbers:

- 0 = Force the default options to be used. This also causes minutes and seconds to be shown.
- 1 = Omit minutes and seconds.
- 2 = Omit seconds.
- 4 = Omit time marker (e.g. AM/PM).
- 8 = Always use 24-hour time rather than 12-hour time.
- 12 = Combination of the above two.
- 0x80000000 = Do not obey any overrides the user may have in effect for the system's default time format.
- 0x40000000 = Use the system ANSI code page for string translation instead of the locale's code page.

**Note**: Dn and Tn may be repeated to put more than one option into effect, such as this example: `FormatTime, OutputVar, 20040228 D2 D4 T1 T8`

## Remarks

Letters and numbers that you want to be transcribed literally from _Format_ into _OutputVar_ should be enclosed in single quotes as in this example: `'Date:' MM/dd/yy 'Time:' hh:mm:ss tt`.

By contrast, non-alphanumeric characters such as spaces, tabs, linefeeds (\`n), slashes, colons, commas, and other punctuation do not need to be enclosed in single quotes. The exception to this is the single quote character itself: to produce it literally, use four consecutive single quotes (''''), or just two if the quote is already inside an outer pair of quotes.

If _Format_ contains date and time elements together, they must not be intermixed. In other words, the string should be dividable into two halves: a time half and a date half. For example, a format string consisting of "hh yyyy mm" would not produce the expected result because it has a date element in between two time elements.

When _Format_ contains a numeric day of the month (either d or dd) followed by the full month name (MMMM), the genitive form of the month name is used (if the language has a genitive form).

If _Format_ contains more than 2000 characters, _OutputVar_ will be made blank.

On a related note, addition and subtraction of dates and times can be performed with [EnvAdd](EnvAdd.htm) and [EnvSub](EnvSub.htm).

## Related

To convert in the reverse direction -- that is, _from_ a formatted date/time _to_ [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format -- see [www.autohotkey.com/forum/topic20405.html](https://www.autohotkey.com/forum/topic20405.html)

See also: [Gui DateTime control](GuiControls.htm#DateTime), [Format()](Format.htm), [SetFormat](SetFormat.htm), [Transform](Transform.htm), [built-in date and time variables](../Variables.htm#date), [FileGetTime](FileGetTime.htm)

## Examples

Demonstrates different usages.

```
FormatTime, TimeString
MsgBox The current time and date (time first) is %TimeString%.

FormatTime, TimeString, R
MsgBox The current time and date (date first) is %TimeString%.

FormatTime, TimeString,, Time
MsgBox The current time is %TimeString%.

FormatTime, TimeString, T12, Time
MsgBox The current 24-hour time is %TimeString%.

FormatTime, TimeString,, LongDate
MsgBox The current date (long format) is %TimeString%.

FormatTime, TimeString, 20050423220133, dddd MMMM d, yyyy hh:mm:ss tt
MsgBox The specified date and time, when formatted, is %TimeString%.

FormatTime, TimeString, 200504, 'Month Name': MMMM`n'Day Name': dddd
MsgBox %TimeString%

FormatTime, YearWeek, 20050101, YWeek
MsgBox January 1st of 2005 is in the following ISO year and week number: %YearWeek%
```

Changes the date-time stamp of a file.

```
FileSelectFile, FileName, 3,, Pick a file
if (FileName = "")  <em>; The user didn't pick a file.</em>
    return
FileGetTime, FileTime, %FileName%
FormatTime, FileTime, %FileTime%   <em>; Since the last parameter is omitted, the long date and time are retrieved.</em>
MsgBox The selected file was last modified at %FileTime%.
```

Converts the specified number of seconds into the corresponding number of hours, minutes, and seconds (hh:mm:ss format).

```
MsgBox % FormatSeconds(7384)  <em>; 7384 = 2 hours + 3 minutes + 4 seconds. It yields: 2:03:04</em>

FormatSeconds(NumberOfSeconds)  <em>; Convert the specified number of seconds to hh:mm:ss format.</em>
{
    time := 19990101  <em>; *Midnight* of an arbitrary date.</em>
    time += NumberOfSeconds, seconds
    FormatTime, mmss, %time%, mm:ss
    return NumberOfSeconds//3600 ":" mmss
    <em>/*
    ; Unlike the method used above, this would not support more than 24 hours worth of seconds:
    FormatTime, hmmss, %time%, h:mm:ss
    return hmmss
    */</em>
}
```

