# sync(1) - Synchronize cached writes to persistent storage

GNU coreutils 8.31, March 2019

```
sync [OPTION] [FILE]...
```

<a name="description"></a>

# Description



Synchronize cached writes to persistent storage

If one or more files are specified, sync only them,
or their containing file systems.

* **-d**, **--data**  
  sync only file data, no unneeded metadata
* **-f**, **--file-system**  
  sync the file systems that contain the files
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="bugs"></a>

# Bugs

Persistence guarantees vary per system.
See the system calls below for more details.

<a name="author"></a>

# Author

Written by Jim Meyering and Giuseppe Scrivano.

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

fdatasync(2), fsync(2), sync(2), syncfs(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/sync&gt;  
or available locally via: info '(coreutils) sync invocation'
