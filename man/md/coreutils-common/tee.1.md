# tee(1) - read from standard input and write to standard output and files

GNU coreutils 8.31, March 2019

```
tee [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Copy standard input to each FILE, and also to standard output.

* **-a**, **--append**  
  append to the given FILEs, do not overwrite
* **-i**, **--ignore-interrupts**  
  ignore interrupt signals
* **-p**  
  diagnose errors writing to non pipes
* **--output-error**[=_MODE_]  
  set behavior on write error.  See MODE below
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="mode-determines-behavior-with-write-errors-on-the-outputs"></a>

### MODE determines behavior with write errors on the outputs:


* 'warn'  
  diagnose errors writing to any output
* 'warn-nopipe'  
  diagnose errors writing to any output not a pipe
* 'exit'  
  exit on error writing to any output
* 'exit-nopipe'  
  exit on error writing to any output not a pipe

The default MODE for the **-p** option is 'warn-nopipe'.
The default operation when **--output-error** is not specified, is to
exit immediately on error writing to a pipe, and diagnose errors
writing to non pipe outputs.

<a name="author"></a>

# Author

Written by Mike Parker, Richard M. Stallman, and David MacKenzie.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/tee&gt;  
or available locally via: info '(coreutils) tee invocation'
