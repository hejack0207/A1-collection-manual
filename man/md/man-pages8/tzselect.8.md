# tzselect(8) - select a timezone

"", 2007-05-18

```
tzselect
```

<a name="description"></a>

# Description

The
**tzselect**
program asks the user for information about the current location,
and outputs the resulting timezone description to standard output.
The output is suitable as a value for the
**TZ**
environment variable.

All interaction with the user is done via standard input and standard error.

<a name="exit-status"></a>

# Exit Status

The exit status is zero if a timezone was successfully obtained
from the user, and is nonzero otherwise.

<a name="environment"></a>

# Environment


* **AWK**  
  Name of a POSIX-compliant
  _awk_
  program (default:
  **awk**).
* **TZDIR**  
  Name of the directory containing timezone data files (default:
  _/usr/share/zoneinfo_).
  

<a name="files"></a>

# Files


* **TZDIR**_/iso3166.tab_  
  Table of ISO 3166 2-letter country codes and country names.
* **TZDIR**_/zone.tab_  
  Table of country codes, latitude and longitude, TZ values, and
  descriptive comments.
* **TZDIR**_/__TZ_  
  Timezone data file for timezone
  _TZ_.

<a name="see-also"></a>

# See Also

**tzfile**(5),
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
