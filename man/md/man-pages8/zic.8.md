# zic(8) - timezone compiler

"", 2010-02-25

    zic [-v] [-d directory] [-l localtime] [-p posixrules]
        [-L leapsecondfilename] [-s] [-ycommand][filename...]

<a name="description"></a>

# Description

.if t .ds lq \`\`
.if t .ds rq ''
.if n .ds lq "
.if n .ds rq "
The
**zic**
program reads text from the file(s) named on the command line
and creates the time conversion information files specified in this input.
If a
_filename_
is
**-**,
standard input is read.

These options are available:

* **-d **_directory_  
  Create time conversion information files in the named directory rather than
  in the standard directory named below.
* **-l **_timezone_  
  Use the given timezone as local time.
  **zic**
  will act as if the input contained a link line of the form

.ti +.5i
Link	_timezone_		localtime

* **-p **_timezone_  
  Use the given timezone's rules when handling POSIX-format
  timezone environment variables.
  **zic**
  will act as if the input contained a link line of the form

.ti +.5i
Link	_timezone_		posixrules

* **-L **_leapsecondfilename_  
  Read leap second information from the file with the given name.
  If this option is not used,
  no leap second information appears in output files.
* **-v**  
  Complain if a year that appears in a data file is outside the range
  of years representable by
  **time**(2)
  values.
* **-s**  
  Limit time values stored in output files to values that are the same
  whether they're taken to be signed or unsigned.
  You can use this option to generate SVVS-compatible files.
* **-y **_command_  
  Use the given
  _command_
  rather than
  **yearistype**
  when checking year types (see below).

Input lines are made up of fields.
Fields are separated from one another by any number of white space characters.
Leading and trailing white space on input lines is ignored.
An unquoted sharp character (#) in the input introduces a comment which extends
to the end of the line the sharp character appears on.
White space characters and sharp characters may be enclosed in double quotes
(") if they're to be used as part of a field.
Any line that is blank (after comment stripping) is ignored.
Nonblank lines are expected to be of one of three types:
rule lines, zone lines, and link lines.

A rule line has the form
    .ti +.5i
    .ta w'Rule00'u +w'NAME00'u +w'FROM00'u +w'197300'u +w'TYPE00'u +w'Apr00'u +w'lastSun00'u +w'2:0000'u +w'SAVE00'u
    
    Rule	NAME	FROM	TO	TYPE	IN	ON	AT	SAVE	LETTER/S
    
    For example:
    .ti +.5i
    
    Rule	US	1967	1973	-	Apr	lastSun	2:00	1:00	D
    
The fields that make up a rule line are:

* **NAME**  
  Gives the (arbitrary) name of the set of rules this rule is part of.
* **FROM**  
  Gives the first year in which the rule applies.
  Any integer year can be supplied; the Gregorian calendar is assumed.
  The word
  _minimum_
  (or an abbreviation) means the minimum year representable as an integer.
  The word
  _maximum_
  (or an abbreviation) means the maximum year representable as an integer.
  Rules can describe times that are not representable as time values,
  with the unrepresentable times ignored; this allows rules to be portable
  among hosts with differing time value types.
* **TO**  
  Gives the final year in which the rule applies.
  In addition to
  _minimum_
  and
  _maximum_
  (as above),
  the word
  _only_
  (or an abbreviation)
  may be used to repeat the value of the
  **FROM**
  field.
* **TYPE**  
  Gives the type of year in which the rule applies.
  If
  **TYPE**
  is
  **-**,
  then the rule applies in all years between
  **FROM**
  and
  **TO**
  inclusive.
  If
  **TYPE**
  is something else, then
  _zic_
  executes the command
  .ti +.5i
  **yearistype**
  _year_
  _type_  
  to check the type of a year:
  an exit status of zero is taken to mean that the year is of the given type;
  an exit status of one is taken to mean that the year is not of the given type.
* **IN**  
  Names the month in which the rule takes effect.
  Month names may be abbreviated.
* **ON**  
  Gives the day on which the rule takes effect.
  Recognized forms include:
    .in +.5i
    
    .ta w'Sun<=2500'u
    5	the fifth of the month
    lastSun	the last Sunday in the month
    lastMon	the last Monday in the month
    Sun>=8	first Sunday on or after the eighth
    Sun<=25	last Sunday on or before the 25th
.in -.5i

Names of days of the week may be abbreviated or spelled out in full.
Note that there must be no spaces within the
**ON**
field.

* **AT**  
  Gives the time of day at which the rule takes effect.
  Recognized forms include:
    .in +.5i
    
    .ta w'1:28:1300'u
    2	time in hours
    2:00	time in hours and minutes
    15:00	24-hour format time (for times after noon)
    1:28:14	time in hours, minutes, and seconds
    -	equivalent to 0
.in -.5i

where hour 0 is midnight at the start of the day,
and hour 24 is midnight at the end of the day.
Any of these forms may be followed by the letter
_w_
if the given time is local
.q "wall clock"
time,
_s_
if the given time is local
.q standard
time, or
_u_
(or
_g_
or
_z_)
if the given time is universal time;
in the absence of an indicator,
wall clock time is assumed.

* **SAVE**  
  Gives the amount of time to be added to local standard time when the rule is in
  effect.
  This field has the same format as the
  **AT**
  field
  (although, of course, the
  _w_
  and
  _s_
  suffixes are not used).
* **LETTER/S**  
  Gives the
  .q "variable part"
  (for example, the
  .q S
  or
  .q D
  in
  .q EST
  or
  .q EDT )
  of timezone abbreviations to be used when this rule is in effect.
  If this field is
  **-**,
  the variable part is null.

A zone line has the form

    .ti +.5i
    .ta w'Zone00'u +w'Australia/Adelaide00'u +w'UTCOFF00'u +w'RULES/SAVE00'u +w'FORMAT00'u
    Zone	NAME	UTCOFF	RULES/SAVE	FORMAT	[UNTIL]
    
    For example:
    
    .ti +.5i
    Zone	Australia/Adelaide	9:30	Aus	CST	1971 Oct 31 2:00
    
The fields that make up a zone line are:

* **NAME**  
  The name of the timezone.
  This is the name used in creating the time conversion information file for the
  zone.
* **UTCOFF**  
  The amount of time to add to UTC to get standard time in this zone.
  This field has the same format as the
  **AT**
  and
  **SAVE**
  fields of rule lines;
  begin the field with a minus sign if time must be subtracted from UTC.
* **RULES/SAVE**  
  The name of the rule(s) that apply in the timezone or,
  alternately, an amount of time to add to local standard time.
  If this field is
  **-**,
  then standard time always applies in the timezone.
* **FORMAT**  
  The format for timezone abbreviations in this timezone.
  The pair of characters
  **%s**
  is used to show where the
  .q "variable part"
  of the timezone abbreviation goes.
  Alternately,
  a slash (/)
  separates standard and daylight abbreviations.
* **UNTIL**  
  The time at which the UTC offset or the rule(s) change for a location.
  It is specified as a year, a month, a day, and a time of day.
  If this is specified,
  the timezone information is generated from the given UTC offset
  and rule change until the time specified.
  The month, day, and time of day have the same format as the IN, ON, and AT
  columns of a rule; trailing columns can be omitted, and default to the
  earliest possible value for the missing columns.
* The next line must be a
  .q continuation
  line; this has the same form as a zone line except that the
  string
  .q Zone
  and the name are omitted, as the continuation line will
  place information starting at the time specified as the
  **UNTIL**
  field in the previous line in the file used by the previous line.
  Continuation lines may contain an
  **UNTIL**
  field, just as zone lines do, indicating that the next line is a further
  continuation.

A link line has the form

    .ti +.5i
    .ta w'Link00'u +w'Europe/Istanbul00'u
    Link	LINK-FROM	LINK-TO
    
    For example:
    
    .ti +.5i
    Link	Europe/Istanbul	Asia/Istanbul
    
The
**LINK-FROM**
field should appear as the
**NAME**
field in some zone line;
the
**LINK-TO**
field is used as an alternate name for that zone.

Except for continuation lines,
lines may appear in any order in the input.

Lines in the file that describes leap seconds have the following form:
    .ti +.5i
    .ta w'Leap00'u +w'YEAR00'u +w'MONTH00'u +w'DAY00'u +w'HH:MM:SS00'u +w'CORR00'u
    
    Leap	YEAR	MONTH	DAY	HH:MM:SS	CORR	R/S
    
    For example:
    .ti +.5i
    
    Leap	1974	Dec	31	23:59:60	+	S
    
The
**YEAR**,
**MONTH**,
**DAY**,
and
**HH:MM:SS**
fields tell when the leap second happened.
The
**CORR**
field
should be
.q +
if a second was added
or
.q -
if a second was skipped.











The
**R/S**
field
should be (an abbreviation of)
.q Stationary
if the leap second time given by the other fields should be interpreted as UTC
or
(an abbreviation of)
.q Rolling
if the leap second time given by the other fields should be interpreted as
local wall clock time.

<a name="files"></a>

# Files


* _/usr/local/etc/zoneinfo_  
  Standard directory used for created files.

<a name="notes"></a>

# Notes

For areas with more than two types of local time,
you may need to use local standard time in the
**AT**
field of the earliest transition time's rule to ensure that
the earliest transition time recorded in the compiled file is correct.

<a name="see-also"></a>

# See Also

**tzfile**(5),
**zdump**(8)


<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
