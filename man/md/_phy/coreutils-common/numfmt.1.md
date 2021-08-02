# numfmt(1) - Convert numbers from/to human-readable strings

GNU coreutils 8.31, March 2019

```
numfmt [OPTION]... [NUMBER]...
```

<a name="description"></a>

# Description



Reformat NUMBER(s), or the numbers from standard input if none are specified.

Mandatory arguments to long options are mandatory for short options too.

* **--debug**  
  print warnings about invalid input
* **-d**, **--delimiter**=_X_  
  use X instead of whitespace for field delimiter
* **--field**=_FIELDS_  
  replace the numbers in these input fields (default=1)
  see FIELDS below
* **--format**=_FORMAT_  
  use printf style floating-point FORMAT;
  see FORMAT below for details
* **--from**=_UNIT_  
  auto-scale input numbers to UNITs; default is 'none';
  see UNIT below
* **--from-unit**=_N_  
  specify the input unit size (instead of the default 1)
* **--grouping**  
  use locale-defined grouping of digits, e.g. 1,000,000
  (which means it has no effect in the C/POSIX locale)
* **--header**[=_N_]  
  print (without converting) the first N header lines;
  N defaults to 1 if not specified
* **--invalid**=_MODE_  
  failure mode for invalid numbers: MODE can be:
  abort (default), fail, warn, ignore
* **--padding**=_N_  
  pad the output to N characters; positive N will
  right-align; negative N will left-align;
  padding is ignored if the output is wider than N;
  the default is to automatically pad if a whitespace
  is found
* **--round**=_METHOD_  
  use METHOD for rounding when scaling; METHOD can be:
  up, down, from-zero (default), towards-zero, nearest
* **--suffix**=_SUFFIX_  
  add SUFFIX to output numbers, and accept optional
  SUFFIX in input numbers
* **--to**=_UNIT_  
  auto-scale output numbers to UNITs; see UNIT below
* **--to-unit**=_N_  
  the output unit size (instead of the default 1)
* **-z**, **--zero-terminated**  
  line delimiter is NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="unit-options"></a>

### UNIT options:


* none  
  no auto-scaling is done; suffixes will trigger an error
* auto  
  accept optional single/two letter suffix:
* 1K = 1000,
  1Ki = 1024,
  1M = 1000000,
  1Mi = 1048576,
* si  
  accept optional single letter suffix:
* 1K = 1000,
  1M = 1000000,
  ...
* iec  
  accept optional single letter suffix:
* 1K = 1024,
  1M = 1048576,
  ...
* iec-i  
  accept optional two-letter suffix:
* 1Ki = 1024,
  1Mi = 1048576,
  ...

<a name="fields-supports-cut1-style-field-ranges"></a>

### FIELDS supports cut(1) style field ranges:


* N  
  N'th field, counted from 1
* N-  
  from N'th field, to end of line
* N-M  
  from N'th to M'th field (inclusive)
* **-M**  
  from first to M'th field (inclusive)
* -  
  all fields

Multiple fields/ranges can be separated with commas

FORMAT must be suitable for printing one floating-point argument '%f'.
Optional quote (%'f) will enable **--grouping** (if supported by current locale).
Optional width value (%10f) will pad output. Optional zero (%010f) width
will zero pad the number. Optional negative values (%-10f) will left align.
Optional precision (%.1f) will override the input determined precision.

Exit status is 0 if all input numbers were successfully converted.
By default, numfmt will stop at the first conversion error with exit status 2.
With **--invalid=**'fail' a warning is printed for each conversion error
and the exit status is 2.  With **--invalid=**'warn' each conversion error is
diagnosed, but the exit status is 0.  With **--invalid=**'ignore' conversion
errors are not diagnosed and the exit status is 0.

<a name="examples"></a>

# Examples


* \f(CW$ numfmt --to=si 1000
* -&gt; "1.0K"
* \f(CW$ numfmt --to=iec 2048
* -&gt; "2.0K"
* \f(CW$ numfmt --to=iec-i 4096
* -&gt; "4.0Ki"
* \f(CW$ echo 1K | numfmt --from=si
* -&gt; "1000"
* \f(CW$ echo 1K | numfmt --from=iec
* -&gt; "1024"
* \f(CW$ df -B1 | numfmt --header --field 2-4 --to=si  
  \f(CW$ ls -l  | numfmt --header --field 5 --to=iec  
  \f(CW$ ls -lh | numfmt --header --field 5 --from=iec --padding=10  
  \f(CW$ ls -lh | numfmt --header --field 5 --from=iec --format %10f

<a name="author"></a>

# Author

Written by Assaf Gordon.

<a name="reporting-bugs"></a>

# Reporting Bugs

GNU coreutils online help: &lt;https://www.gnu.org/software/coreutils/&gt;  
Report any translation bugs to &lt;https://translationproject.org/team/&gt;

<a name="copyright"></a>

# Copyright

Copyright © 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later &lt;https://gnu.org/licenses/gpl.html&gt;.  
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

<a name="see-also"></a>

# See Also

Full documentation &lt;https://www.gnu.org/software/coreutils/numfmt&gt;  
or available locally via: info '(coreutils) numfmt invocation'
