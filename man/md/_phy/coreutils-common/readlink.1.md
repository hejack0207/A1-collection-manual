# readlink(1) - print resolved symbolic links or canonical file names

GNU coreutils 8.31, March 2019

```
readlink [OPTION]... FILE...
```

<a name="description"></a>

# Description


Note realpath(1) is the preferred command to use
for canonicalization functionality.

Print value of a symbolic link or canonical file name

* **-f**, **--canonicalize**  
  canonicalize by following every symlink in
  every component of the given name recursively;
  all but the last component must exist
* **-e**, **--canonicalize-existing**  
  canonicalize by following every symlink in
  every component of the given name recursively,
  all components must exist
* **-m**, **--canonicalize-missing**  
  canonicalize by following every symlink in
  every component of the given name recursively,
  without requirements on components existence
* **-n**, **--no-newline**  
  do not output the trailing delimiter
  .HP
  **-q**, **--quiet**
* **-s**, **--silent**  
  suppress most error messages (on by default)
* **-v**, **--verbose**  
  report error messages
* **-z**, **--zero**  
  end each output line with NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Dmitry V. Levin.

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

readlink(2), realpath(1), realpath(3)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/readlink&gt;  
or available locally via: info '(coreutils) readlink invocation'
