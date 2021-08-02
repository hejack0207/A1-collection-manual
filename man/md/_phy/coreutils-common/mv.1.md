# mv(1) - move (rename) files

GNU coreutils 8.31, March 2019

```
mv [OPTION]... [-T] SOURCE DEST
mv [OPTION]... SOURCE... DIRECTORY
mv [OPTION]... -t DIRECTORY SOURCE...
```

<a name="description"></a>

# Description



Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.

Mandatory arguments to long options are mandatory for short options too.

* **--backup**[=_CONTROL_]  
  make a backup of each existing destination file
* **-b**  
  like **--backup** but does not accept an argument
* **-f**, **--force**  
  do not prompt before overwriting
* **-i**, **--interactive**  
  prompt before overwrite
* **-n**, **--no-clobber**  
  do not overwrite an existing file

If you specify more than one of **-i**, **-f**, **-n**, only the final one takes effect.

* **--strip-trailing-slashes**  
  remove any trailing slashes from each SOURCE
  argument
* **-S**, **--suffix**=_SUFFIX_  
  override the usual backup suffix
* **-t**, **--target-directory**=_DIRECTORY_  
  move all SOURCE arguments into DIRECTORY
* **-T**, **--no-target-directory**  
  treat DEST as a normal file
* **-u**, **--update**  
  move only when the SOURCE file is newer
  than the destination file or when the
  destination file is missing
* **-v**, **--verbose**  
  explain what is being done
* **-Z**, **--context**  
  set SELinux security context of destination
  file to default type
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

The backup suffix is '~', unless set with **--suffix** or SIMPLE_BACKUP_SUFFIX.
The version control method may be selected via the **--backup** option or through
the VERSION_CONTROL environment variable.  Here are the values:

* none, off  
  never make backups (even if **--backup** is given)
* numbered, t  
  make numbered backups
* existing, nil  
  numbered if numbered backups exist, simple otherwise
* simple, never  
  always make simple backups

<a name="author"></a>

# Author

Written by Mike Parker, David MacKenzie, and Jim Meyering.

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

rename(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/mv&gt;  
or available locally via: info '(coreutils) mv invocation'
