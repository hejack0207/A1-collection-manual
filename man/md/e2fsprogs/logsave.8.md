# logsave(8) - save the output of a command in a logfile

E2fsprogs version 1.45.6, March 2020

```
logsave [ -asv ] logfile cmd_prog [ ... ]
```

<a name="description"></a>

# Description

The
**logsave**
program will execute
_cmd_prog_
with the specified argument(s), and save a copy of its output to
_logfile_.
If the containing directory for
_logfile_
does not exist,
**logsave**
will accumulate the output in memory until it can be written out.
A copy of the output will also be written to standard output.

If
_cmd_prog_
is a single hyphen ('-'), then instead of executing a program,
**logsave**
will take its input from standard input and save it in
_logfile_

**logsave**
is useful for saving the output of initial boot scripts
until the /var partition is mounted, so the output can be written to
/var/log.

<a name="options"></a>

# Options


* **-a**  
  This option will cause the output to be appended to
  _logfile_,
  instead of replacing its current contents.
* **-s**  
  This option will cause
  **logsave**
  to skip writing to the log file text which is bracketed with a control-A
  (ASCII 001 or Start of Header) and control-B (ASCII 002 or Start of
  Text).  This allows progress bar information to be visible to the user
  on the console, while not being written to the log file.
* **-v**  
  This option will make
  **logsave**
  to be more verbose in its output to the user.

<a name="author"></a>

# Author

Theodore Ts'o ([tytso@mit.edu](mailto:tytso@mit.edu))

<a name="see-also"></a>

# See Also

**fsck**(8)
