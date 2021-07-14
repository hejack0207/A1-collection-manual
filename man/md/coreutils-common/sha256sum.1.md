# sha256sum(1) - compute and check SHA256 message digest

GNU coreutils 8.31, March 2019

```
sha256sum [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Print or check SHA256 (256-bit) checksums.

With no FILE, or when FILE is -, read standard input.

* **-b**, **--binary**  
  read in binary mode
* **-c**, **--check**  
  read SHA256 sums from the FILEs and check them
* **--tag**  
  create a BSD-style checksum
* **-t**, **--text**  
  read in text mode (default)
* Note: There is no difference between binary and text mode option on GNU system.
  **-z**, **--zero**           end each output line with NUL, not newline,
* and disable file name escaping

<a name="the-following-five-options-are-useful-only-when-verifying-checksums"></a>

### The following five options are useful only when verifying checksums:


* **--ignore-missing**  
  don't fail or report status for missing files
* **--quiet**  
  don't print OK for each successfully verified file
* **--status**  
  don't output anything, status code shows success
* **--strict**  
  exit non-zero for improperly formatted checksum lines
* **-w**, **--warn**  
  warn about improperly formatted checksum lines
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

The sums are computed as described in FIPS-180-2.  When checking, the input
should be a former output of this program.  The default mode is to print a
line with checksum, a space, a character indicating input mode ('*' for binary,
' ' for text or where binary is insignificant), and name for each FILE.

<a name="author"></a>

# Author

Written by Ulrich Drepper, Scott Miller, and David Madore.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/sha256sum&gt;  
or available locally via: info '(coreutils) sha2 utilities'
