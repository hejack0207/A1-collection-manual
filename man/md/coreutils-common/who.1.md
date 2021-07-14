# who(1) - show who is logged on

GNU coreutils 8.31, March 2019

```
who [OPTION]... [ FILE | ARG1 ARG2 ]
```

<a name="description"></a>

# Description



Print information about users who are currently logged in.

* **-a**, **--all**  
  same as **-b** **-d** **--login** **-p** **-r** **-t** **-T** **-u**
* **-b**, **--boot**  
  time of last system boot
* **-d**, **--dead**  
  print dead processes
* **-H**, **--heading**  
  print line of column headings
* **-l**, **--login**  
  print system login processes
* **--lookup**  
  attempt to canonicalize hostnames via DNS
* **-m**  
  only hostname and user associated with stdin
* **-p**, **--process**  
  print active processes spawned by init
* **-q**, **--count**  
  all login names and number of users logged on
* **-r**, **--runlevel**  
  print current runlevel
* **-s**, **--short**  
  print only name, line, and time (default)
* **-t**, **--time**  
  print last system clock change
* **-T**, **-w**, **--mesg**  
  add user's message status as +, - or ?
* **-u**, **--users**  
  list users logged in
* **--message**  
  same as **-T**
* **--writable**  
  same as **-T**
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

If FILE is not specified, use _/var/run/utmp_.  _/var/log/wtmp_ as FILE is common.
If ARG1 ARG2 given, **-m** presumed: 'am i' or 'mom likes' are usual.

<a name="author"></a>

# Author

Written by Joseph Arceneaux, David MacKenzie, and Michael Stone.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/who&gt;  
or available locally via: info '(coreutils) who invocation'
