# rm(1) - remove files or directories

GNU coreutils 8.31, March 2019

```
rm [OPTION]... [FILE]...
```

<a name="description"></a>

# Description

This manual page
documents the GNU version of
**rm**.
**rm**
removes each specified file.  By default, it does not remove
directories.

If the _-I_ or _--interactive=once_ option is given,
and there are more than three files or the _-r_, _-R_,
or _--recursive_ are given, then
**rm**
prompts the user for whether to proceed with the entire operation.  If
the response is not affirmative, the entire command is aborted.

Otherwise, if a file is unwritable, standard input is a terminal, and
the _-f_ or _--force_ option is not given, or the
_-i_ or _--interactive=always_ option is given,
**rm**
prompts the user for whether to remove the file.  If the response is
not affirmative, the file is skipped.

<a name="options"></a>

# Options


Remove (unlink) the FILE(s).

* **-f**, **--force**  
  ignore nonexistent files and arguments, never prompt
* **-i**  
  prompt before every removal
* **-I**  
  prompt once before removing more than three files, or
  when removing recursively; less intrusive than **-i**,
  while still giving protection against most mistakes
* **--interactive**[=_WHEN_]  
  prompt according to WHEN: never, once (**-I**), or
  always (**-i**); without WHEN, prompt always
* **--one-file-system**  
  when removing a hierarchy recursively, skip any
  directory that is on a file system different from
  that of the corresponding command line argument
* **--no-preserve-root**  
  do not treat '/' specially
* **--preserve-root**[=_all_]  
  do not remove '/' (default);
  with 'all', reject any command line argument
  on a separate device from its parent
* **-r**, **-R**, **--recursive**  
  remove directories and their contents recursively
* **-d**, **--dir**  
  remove empty directories
* **-v**, **--verbose**  
  explain what is being done
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

By default, rm does not remove directories.  Use the **--recursive** (**-r** or **-R**)
option to remove each listed directory, too, along with all of its contents.

To remove a file whose name starts with a '-', for example '-foo',
use one of these commands:

* rm **--** **-foo**
* rm ./-foo

Note that if you use rm to remove a file, it might be possible to recover
some of its contents, given sufficient expertise and/or time.  For greater
assurance that the contents are truly unrecoverable, consider using shred.

<a name="author"></a>

# Author

Written by Paul Rubin, David MacKenzie, Richard M. Stallman,
and Jim Meyering.

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

unlink(1), unlink(2), chattr(1), shred(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/rm&gt;  
or available locally via: info '(coreutils) rm invocation'
