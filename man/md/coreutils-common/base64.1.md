# base64(1) - base64 encode/decode data and print to standard output

GNU coreutils 8.31, March 2019

```
base64 [OPTION]... [FILE]
```

<a name="description"></a>

# Description



Base64 encode or decode FILE, or standard input, to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-d**, **--decode**  
  decode data
* **-i**, **--ignore-garbage**  
  when decoding, ignore non-alphabet characters
* **-w**, **--wrap**=_COLS_  
  wrap encoded lines after COLS character (default 76).
  Use 0 to disable line wrapping
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

The data are encoded as described for the base64 alphabet in RFC 4648.
When decoding, the input may contain newlines in addition to the bytes of
the formal base64 alphabet.  Use **--ignore-garbage** to attempt to recover
from any other non-alphabet bytes in the encoded stream.

<a name="author"></a>

# Author

Written by Simon Josefsson.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/base64&gt;  
or available locally via: info '(coreutils) base64 invocation'
