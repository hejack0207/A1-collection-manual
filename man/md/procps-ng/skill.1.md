# skill(1) - send a signal or report process status

procps-ng, October 2011

```
skill [signal] [options] expression
snice [new priority] [options] expression
```

<a name="description"></a>

# Description

These tools are obsolete and unportable.  The command syntax is
poorly defined.  Consider using the killall, pkill, and pgrep
commands instead.

The default signal for skill is TERM.  Use -l or -L to list
available signals.  Particularly useful signals include HUP, INT,
KILL, STOP, CONT, and 0.  Alternate signals may be specified in three
ways: -9 -SIGKILL -KILL.

The default priority for snice is +4.  Priority numbers range from
+20 (slowest) to -20 (fastest).  Negative priority numbers are
restricted to administrative users.

<a name="options"></a>

# Options


* **-f**,**&nbsp;--fast**  
  Fast mode.  This option has not been implemented.
* **-i**,**&nbsp;--interactive**  
  Interactive use.  You will be asked to approve each action.
* **-l**,**&nbsp;--list**  
  List all signal names.
* **-L**,**&nbsp;--table**  
  List all signal names in a nice table.
* **-n**,**&nbsp;--no-action**  
  No action; perform a simulation of events that would occur but do not
  actually change the system.
* **-v**,**&nbsp;--verbose**  
  Verbose; explain what is being done.
* **-w**,**&nbsp;--warnings**  
  Enable warnings.  This option has not been implemented.
* **-h**, **--help**  
  Display help text and exit.
* **-V**, **--version**  
  Display version information.

<a name="process-selection-options"></a>

# Process Selection Options

Selection criteria can be: terminal, user, pid, command.  The options
below may be used to ensure correct interpretation.

* **-t**, **--tty** _tty_  
  The next expression is a terminal (tty or pty).
* **-u**, **--user** _user_  
  The next expression is a username.
* **-p**, **--pid** _pid_  
  The next expression is a process ID number.
* **-c**, **--command** _command_  
  The next expression is a command name.
* **--ns pid**  
  Match the processes that belong to the same namespace as pid.
* **--nslist ns,...**  
  list which namespaces will be considered for the --ns option.
  Available namespaces: ipc, mnt, net, pid, user, uts.

<a name="signals"></a>

# Signals

The behavior of signals is explained in
**signal**(7)
manual page.

<a name="examples"></a>

# Examples


* **snice -c seti -c crack +7**  
  Slow down seti and crack commands.
* **skill -KILL -t /dev/pts/***  
  Kill users on PTY devices.
* **skill -STOP -u viro -u lm -u davem**  
  Stop three users.

<a name="see-also"></a>

# See Also

**kill**(1),
**kill**(2),
**killall**(1),
**nice**(1),
**pkill**(1),
**renice**(1),
**signal**(7)

<a name="standards"></a>

# Standards

No standards apply.

<a name="author"></a>

# Author

.UR [albert@users.sf](mailto:albert@users.sf).net
Albert Cahalan
.UE
wrote skill and snice in 1999 as a replacement for a non-free
version.

<a name="reporting-bugs"></a>

# Reporting Bugs

Please send bug reports to
.UR procps@freelists.org
.UE
