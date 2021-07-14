# du(1) - estimate file space usage

GNU coreutils 8.31, March 2019

```
du [OPTION]... [FILE]...
du [OPTION]... --files0-from=F
```

<a name="description"></a>

# Description



Summarize disk usage of the set of FILEs, recursively for directories.

Mandatory arguments to long options are mandatory for short options too.

* **-0**, **--null**  
  end each output line with NUL, not newline
* **-a**, **--all**  
  write counts for all files, not just directories
* **--apparent-size**  
  print apparent sizes, rather than disk usage; although
  the apparent size is usually smaller, it may be
  larger due to holes in ('sparse') files, internal
  fragmentation, indirect blocks, and the like
* **-B**, **--block-size**=_SIZE_  
  scale sizes by SIZE before printing them; e.g.,
  '-BM' prints sizes in units of 1,048,576 bytes;
  see SIZE format below
* **-b**, **--bytes**  
  equivalent to '--apparent-size **--block-size**=_1_'
* **-c**, **--total**  
  produce a grand total
* **-D**, **--dereference-args**  
  dereference only symlinks that are listed on the
  command line
* **-d**, **--max-depth**=_N_  
  print the total for a directory (or file, with **--all**)
  only if it is N or fewer levels below the command
  line argument;  **--max-depth**=_0_ is the same as
  **--summarize**
* **--files0-from**=_F_  
  summarize disk usage of the
  NUL-terminated file names specified in file F;
  if F is -, then read names from standard input
* **-H**  
  equivalent to **--dereference-args** (**-D**)
* **-h**, **--human-readable**  
  print sizes in human readable format (e.g., 1K 234M 2G)
* **--inodes**  
  list inode usage information instead of block usage
* **-k**  
  like **--block-size**=_1K_
* **-L**, **--dereference**  
  dereference all symbolic links
* **-l**, **--count-links**  
  count sizes many times if hard linked
* **-m**  
  like **--block-size**=_1M_
* **-P**, **--no-dereference**  
  don't follow any symbolic links (this is the default)
* **-S**, **--separate-dirs**  
  for directories do not include size of subdirectories
* **--si**  
  like **-h**, but use powers of 1000 not 1024
* **-s**, **--summarize**  
  display only a total for each argument
* **-t**, **--threshold**=_SIZE_  
  exclude entries smaller than SIZE if positive,
  or entries greater than SIZE if negative
* **--time**  
  show time of the last modification of any file in the
  directory, or any of its subdirectories
* **--time**=_WORD_  
  show time as WORD instead of modification time:
  atime, access, use, ctime or status
* **--time-style**=_STYLE_  
  show times using STYLE, which can be:
  full-iso, long-iso, iso, or +FORMAT;
  FORMAT is interpreted like in 'date'
* **-X**, **--exclude-from**=_FILE_  
  exclude files that match any pattern in FILE
* **--exclude**=_PATTERN_  
  exclude files that match PATTERN
* **-x**, **--one-file-system**  
  skip directories on different file systems
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

Display values are in units of the first available SIZE from **--block-size**,
and the DU_BLOCK_SIZE, BLOCK_SIZE and BLOCKSIZE environment variables.
Otherwise, units default to 1024 bytes (or 512 if POSIXLY_CORRECT is set).

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

<a name="patterns"></a>

# Patterns

PATTERN is a shell pattern (not a regular expression).  The pattern
**?**
matches any one character, whereas
<b>*</b>
matches any string (composed of zero, one or multiple characters).  For
example,
<b>*.o</b>
will match any files whose names end in
**.o**.
Therefore, the command

* **du --exclude='*.o'**

will skip all files and subdirectories ending in
**.o**
(including the file
**.o**
itself).

<a name="author"></a>

# Author

Written by Torbjorn Granlund, David MacKenzie, Paul Eggert,
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

Full documentation &lt;https://www.gnu.org/software/coreutils/du&gt;  
or available locally via: info '(coreutils) du invocation'
