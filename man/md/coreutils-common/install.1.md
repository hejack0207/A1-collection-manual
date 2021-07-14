# install(1) - copy files and set attributes

GNU coreutils 8.31, March 2019

```
install [OPTION]... [-T] SOURCE DEST
install [OPTION]... SOURCE... DIRECTORY
install [OPTION]... -t DIRECTORY SOURCE...
install [OPTION]... -d DIRECTORY...
```

<a name="description"></a>

# Description



This install program copies files (often just compiled) into destination
locations you choose.  If you want to download and install a ready-to-use
package on a GNU/Linux system, you should instead be using a package manager
like yum(1) or apt-get(1).

In the first three forms, copy SOURCE to DEST or multiple SOURCE(s) to
the existing DIRECTORY, while setting permission modes and owner/group.
In the 4th form, create all components of the given DIRECTORY(ies).

Mandatory arguments to long options are mandatory for short options too.

* **--backup**[=_CONTROL_]  
  make a backup of each existing destination file
* **-b**  
  like **--backup** but does not accept an argument
* **-c**  
  (ignored)
* **-C**, **--compare**  
  compare each pair of source and destination files, and
  in some cases, do not modify the destination at all
* **-d**, **--directory**  
  treat all arguments as directory names; create all
  components of the specified directories
* **-D**  
  create all leading components of DEST except the last,
  or all components of **--target-directory**,
  then copy SOURCE to DEST
* **-g**, **--group**=_GROUP_  
  set group ownership, instead of process' current group
* **-m**, **--mode**=_MODE_  
  set permission mode (as in chmod), instead of rwxr-xr-x
* **-o**, **--owner**=_OWNER_  
  set ownership (super-user only)
* **-p**, **--preserve-timestamps**  
  apply access/modification times of SOURCE files
  to corresponding destination files
* **-s**, **--strip**  
  strip symbol tables
* **--strip-program**=_PROGRAM_  
  program used to strip binaries
* **-S**, **--suffix**=_SUFFIX_  
  override the usual backup suffix
* **-t**, **--target-directory**=_DIRECTORY_  
  copy all SOURCE arguments into DIRECTORY
* **-T**, **--no-target-directory**  
  treat DEST as a normal file
* **-v**, **--verbose**  
  print the name of each directory as it is created
* **-P**, **--preserve-context**  
  preserve SELinux security context (**-P** deprecated)
* **-Z**  
  set SELinux security context of destination
  file and each created directory to default type
* **--context**[=_CTX_]  
  like **-Z**, or if CTX is specified then set the
  SELinux or SMACK security context to CTX
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

Written by David MacKenzie.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/install&gt;  
or available locally via: info '(coreutils) install invocation'
