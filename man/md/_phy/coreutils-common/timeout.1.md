# timeout(1) - run a command with a time limit

GNU coreutils 8.31, March 2019

```
timeout [OPTION] DURATION COMMAND [ARG]...
timeout [OPTION]
```

<a name="description"></a>

# Description



Start COMMAND, and kill it if still running after DURATION.

Mandatory arguments to long options are mandatory for short options too.
.HP
**--preserve-status**

* exit with the same status as COMMAND, even when the
* command times out
  .HP
  **--foreground**
* when not running timeout directly from a shell prompt,
* allow COMMAND to read from the TTY and get TTY signals;
  in this mode, children of COMMAND will not be timed out
  .HP
  **-k**, **--kill-after**=_DURATION_
* also send a KILL signal if COMMAND is still running
* this long after the initial signal was sent
  .HP
  **-s**, **--signal**=_SIGNAL_
* specify the signal to be sent on timeout;
* SIGNAL may be a name like 'HUP' or a number;
  see 'kill **-l**' for a list of signals
* **-v**, **--verbose**  
  diagnose to stderr any signal sent upon timeout
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

DURATION is a floating point number with an optional suffix:
's' for seconds (the default), 'm' for minutes, 'h' for hours or 'd' for days.
A duration of 0 disables the associated timeout.

If the command times out, and **--preserve-status** is not set, then exit with
status 124.  Otherwise, exit with the status of COMMAND.  If no signal
is specified, send the TERM signal upon timeout.  The TERM signal kills
any process that does not block or catch that signal.  It may be necessary
to use the KILL (9) signal, since this signal cannot be caught, in which
case the exit status is 128+9 rather than 124.

<a name="bugs"></a>

# Bugs

Some platforms don't currently support timeouts beyond the year 2038.

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

kill(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/timeout&gt;  
or available locally via: info '(coreutils) timeout invocation'
