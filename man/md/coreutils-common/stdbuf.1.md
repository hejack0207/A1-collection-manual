# stdbuf(1)

GNU coreutils 8.31, March 2019

stdbuf -
Run COMMAND, with modified buffering operations for its standard streams.

<a name="synopsis"></a>

# Synopsis

```
stdbuf OPTION... COMMAND
```

<a name="description"></a>

# Description



Run COMMAND, with modified buffering operations for its standard streams.

Mandatory arguments to long options are mandatory for short options too.

* **-i**, **--input**=_MODE_  
  adjust standard input stream buffering
* **-o**, **--output**=_MODE_  
  adjust standard output stream buffering
* **-e**, **--error**=_MODE_  
  adjust standard error stream buffering
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

If MODE is 'L' the corresponding stream will be line buffered.
This option is invalid with standard input.

If MODE is '0' the corresponding stream will be unbuffered.

Otherwise MODE is a number which may be followed by one of the following:
KB 1000, K 1024, MB 1000*1000, M 1024*1024, and so on for G, T, P, E, Z, Y.
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.
In this case the corresponding stream will be fully buffered with the buffer
size set to MODE bytes.

NOTE: If COMMAND adjusts the buffering of its standard streams ('tee' does
for example) then that will override corresponding changes by 'stdbuf'.
Also some filters (like 'dd' and 'cat' etc.) don't use streams for I/O,
and are thus unaffected by 'stdbuf' settings.

<a name="examples"></a>

# Examples

**tail -f access.log | stdbuf -oL cut -d ' ' -f1 | uniq**  
This will immediately display unique entries from access.log

<a name="bugs"></a>

# Bugs

On GLIBC platforms, specifying a buffer size, i.e., using fully buffered mode
will result in undefined operation.

<a name="author"></a>

# Author

Written by Padraig Brady.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/stdbuf&gt;  
or available locally via: info '(coreutils) stdbuf invocation'
