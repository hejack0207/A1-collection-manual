# zdump(8) - timezone dumper

"", 2017-05-03

```
zdump [--version] [--help] [-v] [-c [loyear,]hiyear] [zonename...]
```

<a name="description"></a>

# Description

The
**zdump**
program prints the current time in each
_zonename_
named on the command line.


<a name="options"></a>

# Options


* **--version**  
  Output version information and exit.
* **--help**  
  Output short usage message and exit.
* **-v**  
  For each
  _zonename_
  on the command line,
  print the time at the lowest possible time value,
  the time one day after the lowest possible time value,
  the times both one second before and exactly at
  each detected time discontinuity,
  the time at one day less than the highest possible time value,
  and the time at the highest possible time value.
  Each line ends with
  **isdst=1**
  if the given time is Daylight Saving Time or
  **isdst=0**
  otherwise.
* **-c **_[_loyear_**,**__]hiyear_  
  Cut off the verbose output near the start of the given year(s).
  The output still includes the lowest possible time value
  and one day after it, and the highest possible time value
  preceded by the time value one day before it.

<a name="see-also"></a>

# See Also

**tzfile**(5),
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
