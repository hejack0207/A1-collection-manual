# utmpdump(1) - dump UTMP and WTMP files in raw format

util-linux, July 2014

```
utmpdump [options] [filename]
```

<a name="description"></a>

# Description

**utmpdump**
is a simple program to dump UTMP and WTMP files in raw format, so they
can be examined.
**utmpdump**
reads from stdin unless a
_filename_
is passed.

<a name="options"></a>

# Options


* **-f**,** --follow**  
  Output appended data as the file grows.
* **-o**,** --output **file  
  Write command output to _file_ instead of standard output.
* **-r**,** --reverse**  
  Undump, write back edited login information into the utmp or wtmp files.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="notes"></a>

# Notes

**utmpdump**
can be useful in cases of corrupted utmp or wtmp entries.  It can dump
out utmp/wtmp to an ASCII file, which can then be edited to remove
bogus entries, and reintegrated using:

**utmpdump -r &lt; ascii_file &gt; wtmp**

But be warned,
**utmpdump**
was written for debugging purposes only.

<a name="file-formats"></a>

### File formats


The only binary version of the
**utmp**(5)
is standardised.  Textual dumps may become incompatible in future.

The version 2.28 was the last one that printed text output using
**ctime**(3)
timestamp format.  Newer dumps use millisecond precision ISO-8601 timestamp
format in UTC-0 timezone.  Conversion from former timestamp format can be
made to binary, although attempt to do so can lead the timestamps to drift
amount of timezone offset.

<a name="bugs"></a>

# Bugs

You may
**not**
use the
**-r**
option, as the format for the utmp/wtmp files strongly depends on the input
format.  This tool was
**not**
written for normal use, but for debugging only.

<a name="author"></a>

# Author

Michael Krapp

<a name="see-also"></a>

# See Also

**last**(1),
**w**(1),
**who**(1),
**utmp**(5)

<a name="availability"></a>

# Availability

The utmpdump command is part of the util-linux package and is available
from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
