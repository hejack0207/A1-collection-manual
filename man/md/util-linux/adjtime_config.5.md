# adjtime_config(5) - information about hardware clock setting and drift factor

util-linux, August 2018

```
/etc/adjtime
```

<a name="description"></a>

# Description

The file
**/etc/adjtime**
contains descriptive information about the hardware mode clock setting and clock drift factor.
The file is read and write by hwclock; and read by programs like rtcwake to get RTC time mode.

The file is usually located in /etc, but tools like
**hwclock**(8)
or
**rtcwake**(8)
allow to use alternative location by command line options if write access to
/etc is unwanted.  The default clock mode is "UTC" if the file is missing.

The Hardware Clock is usually not very accurate.  However, much of its inaccuracy is completely predictable - it gains 
or loses the same amount of time every day.  This is called systematic drift.  The util hwclock keeps the file /etc/adjtime,
that keeps some historical information.
For more details see "**The Adjust Function**" and  "**The Adjtime File**" sections from
**hwckock**(8)
man page.


The format of the adjtime file is, in ASCII.


<a name="first-line"></a>

### First line

Three numbers, separated by blanks:

* **drift factor**  
  the systematic drift rate in seconds per day (floating point decimal)
* **last adjust time**  
  the resulting number of seconds since  1969  UTC  of  most recent adjustment or calibration (decimal integer)
* **adjustment status**  
  zero (for compatibility with clock(8)) as a decimal integer.
  

<a name="second-line"></a>

### Second line


* **last calibration time**  
  The resulting number of seconds since 1969 UTC of most recent calibration.
  Zero if there has been no calibration yet or it is known that any previous
  calibration is moot (for example, because the Hardware Clock has been found,
  since that calibration, not to contain a valid time).  This is a decimal
  integer.
  

<a name="third-line"></a>

### Third line


* **clock mode**  
  Supported values are "UTC" or "LOCAL".  Tells whether the Hardware Clock is set
  to Coordinated Universal Time or local time.  You can always override this
  value with options on the hwclock command line.
  

<a name="files"></a>

# Files

_/etc/adjtime_

<a name="see-also"></a>

# See Also

**hwclock**(8),
**rtcwake**(8)

<a name="availability"></a>

# Availability

This man page is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
