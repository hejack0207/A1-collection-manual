# tzfile(5) - timezone information

"", 2017-08-04


<a name="description"></a>

# Description

.ie '“'' .ds lq "
.el .ds lq “
.ie '”'' .ds rq "
.el .ds rq ”
The timezone information files used by
**tzset**(3)
are typically found under a directory with a name like
_/usr/share/zoneinfo_.
These files begin with a 44-byte header containing the following fields:

* *  
  The magic four-byte ASCII sequence
  .q "TZif"
  identifies the file as a timezone information file.
* *  
  A byte identifying the version of the file's format
  (as of 2017, either an ASCII NUL, or
  .q "2",
  or
  .q "3" ).
* *  
  Fifteen bytes containing zeros reserved for future use.
* *  
  Six four-byte integer values
  written in a standard byte order
  (the high-order byte of the value is written first).
  These values are,
  in order:
    * _tzh_ttisgmtcnt_  
      The number of UT/local indicators stored in the file.
    * _tzh_ttisstdcnt_  
      The number of standard/wall indicators stored in the file.
    * _tzh_leapcnt_  
      The number of leap seconds for which data entries are stored in the file.
    * _tzh_timecnt_  
      The number of transition times for which data entries are stored
      in the file.
    * _tzh_typecnt_  
      The number of local time types for which data entries are stored
      in the file (must not be zero).
    * _tzh_charcnt_  
      The number of bytes of timezone abbreviation strings
      stored in the file.

The above header is followed by the following fields, whose lengths
vary depend on the contents of the header:

* *  
  _tzh_timecnt_
  four-byte signed integer values sorted in ascending order.
  These values are written in standard byte order.
  Each is used as a transition time (as returned by
  **time**(2))
  at which the rules for computing local time change.
* *  
  _tzh_timecnt_
  one-byte unsigned integer values;
  each one tells which of the different types of local time types
  described in the file is associated with the time period
  starting with the same-indexed transition time.
  These values serve as indices into the next field.
* *  
  _tzh_typecnt_
  _ttinfo_
  entries, each defined as follows:

.in +4n
.EX
struct ttinfo {
    int32_t       tt_gmtoff;
    unsigned char tt_isdst;
    unsigned char tt_abbrind;
};
.EE
.in

Each structure is written as a four-byte signed integer value for
_tt_gmtoff_,
in a standard byte order, followed by a one-byte value for
_tt_isdst_
and a one-byte value for
_tt_abbrind_.
In each structure,
_tt_gmtoff_
gives the number of seconds to be added to UT,
_tt_isdst_
tells whether
_tm_isdst_
should be set by
**localtime**(3)
and
_tt_abbrind_
serves as an index into the array of timezone abbreviation bytes
that follow the
_ttinfo_
structure(s) in the file.

* *  
  _tzh_leapcnt_
  pairs of four-byte values, written in standard byte order;
  the first value of each pair gives the nonnegative time
  (as returned by
  **time**(2))
  at which a leap second occurs;
  the second gives the
  _total_
  number of leap seconds to be applied during the time period
  starting at the given time.
  The pairs of values are sorted in ascending order by time.
  Each transition is for one leap second, either positive or negative;
  transitions always separated by at least 28 days minus 1 second.
* *  
  _tzh_ttisstdcnt_
  standard/wall indicators, each stored as a one-byte value;
  they tell whether the transition times associated with local time types
  were specified as standard time or wall clock time,
  and are used when a timezone file is used in handling POSIX-style
  timezone environment variables.
* *  
  _tzh_ttisgmtcnt_
  UT/local indicators, each stored as a one-byte value;
  they tell whether the transition times associated with local time types
  were specified as UT or local time,
  and are used when a timezone file is used in handling POSIX-style
  timezone environment variables.

The
**localtime**(3)
function
uses the first standard-time
_ttinfo_
structure in the file
(or simply the first
_ttinfo_
structure in the absence of a standard-time structure)
if either
_tzh_timecnt_
is zero or the time argument is less than the first transition time recorded
in the file.

<a name="version-2-format"></a>

### Version 2 format

For version-2-format timezone files,
the above header and data are followed by a second header and data,
identical in format except that
eight bytes are used for each transition time or leap second time.
(Leap second counts remain four bytes.)
After the second header and data comes a newline-enclosed,
POSIX-TZ-environment-variable-style string for use in handling instants
after the last transition time stored in the file
(with nothing between the newlines if there is no POSIX representation for
such instants).
The POSIX-style string must agree with the local time type after
both data's last transition times; for example, given the string
.q "WET0WEST,M3.5.0,M10.5.0/3"
then if a last transition time is in July, the transition's local time
type must specify a daylight-saving time abbreviated
.q "WEST"
that is one hour east of UT.

<a name="version-3-format"></a>

### Version 3 format

For version-3-format timezone files, the POSIX-TZ-style string may
use two minor extensions to the POSIX TZ format, as described in
**newtzset**(3).
First, the hours part of its transition times may be signed and range from
-167 through 167 instead of the POSIX-required unsigned values
from 0 through 24.
Second, DST is in effect all year if it starts
January 1 at 00:00 and ends December 31 at 24:00 plus the difference
between daylight saving and standard time.

Future changes to the format may append more data.

<a name="see-also"></a>

# See Also

**time**(2),
**localtime**(3),
**tzset**(3),
**tzselect**(8),
**zdump**(8),
**zic**(8)



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
