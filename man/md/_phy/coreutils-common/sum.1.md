# sum(1) - checksum and count the blocks in a file

GNU coreutils 8.31, March 2019

```
sum [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Print checksum and block counts for each FILE.

With no FILE, or when FILE is -, read standard input.

* **-r**  
  use BSD sum algorithm, use 1K blocks
* **-s**, **--sysv**  
  use System V sum algorithm, use 512 bytes blocks
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Kayvan Aghaiepour and David MacKenzie.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/sum&gt;  
or available locally via: info '(coreutils) sum invocation'
