# watch(1) - execute a program periodically, showing output fullscreen

procps-ng, 2018-03-03

```
watch [options] command
```

<a name="description"></a>

# Description

**watch**
runs
_command_
repeatedly, displaying its output and errors (the first screenfull).  This
allows you to watch the program output change over time.  By default,
_command_ is run every 2 seconds and **watch** will run until interrupted.

<a name="options"></a>

# Options


* **-d**, **--differences** [_permanent_]  
  Highlight the differences between successive updates.  Option will read
  optional argument that changes highlight to be permanent, allowing to see what
  has changed at least once since first iteration.
* **-n**, **--interval** _seconds_  
  Specify update interval.  The command will not allow quicker than 0.1 second
  interval, in which the smaller values are converted. Both '.' and ',' work
  for any locales.
* **-p**, **--precise**  
  Make
  **watch**
  attempt to run
  _command_
  every
  _interval_
  seconds. Try it with
  **ntptime**
  and notice how the fractional seconds stays (nearly) the same, as opposed to
  normal mode where they continuously increase.
* **-t**, **--no-title**  
  Turn off the header showing the interval, command, and current time at the
  top of the display, as well as the following blank line.
* **-b**, **--beep**  
  Beep if command has a non-zero exit.
* **-e**, **--errexit**  
  Freeze updates on command error, and exit after a key press.
* **-g**, **--chgexit**  
  Exit when the output of
  _command_
  changes.
* **-c**, **--color**  
  Interpret ANSI color and style sequences.
* **-x**, **--exec**  
  Pass
  _command_
  to
  **exec**(2)
  instead of
  **sh -c**
  which reduces the need to use extra quoting to get the desired effect.
* **-h**, **--help**  
  Display help text and exit.
* **-v**, **--version**  
  Display version information and exit.

<a name="exit-status"></a>

# Exit Status



* **0**
  Success.
* **1**
  Various failures.
* **2**
  Forking the process to watch failed.
* **3**
  Replacing child process stdout with write side pipe failed.
* **4**
  Command execution failed.
* **5**
  Closing child process write pipe failed.
* **7**
  IPC pipe creation failed.
* **8**
  Getting child process return value with
  **waitpid**(2)
  failed, or command exited up on error.
* **other**
  The watch will propagate command exit status as child exit status.

<a name="notes"></a>

# Notes

POSIX option processing is used (i.e., option processing stops at
the first non-option argument).  This means that flags after
_command_
don't get interpreted by
**watch**
itself.

<a name="bugs"></a>

# Bugs

Upon terminal resize, the screen will not be correctly repainted until the
next scheduled update.  All
**--differences**
highlighting is lost on that update as well.

Non-printing characters are stripped from program output.  Use "cat -v" as
part of the command pipeline if you want to see them.

Combining Characters that are supposed to display on the character at the
last column on the screen may display one column early, or they may not
display at all.

Combining Characters never count as different in
_--differences_
mode.  Only the base character counts.

Blank lines directly after a line which ends in the last column do not
display.

_--precise_
mode doesn't yet have advanced temporal distortion technology to compensate
for a
_command_
that takes more than
_interval_
seconds to execute.
**watch**
also can get into a state where it rapid-fires as many executions of
_command_
as it can to catch up from a previous executions running longer than
_interval_
(for example,
**netstat**
taking ages on a DNS lookup).

<a name="examples"></a>

# Examples


To watch for mail, you might do

* watch -n 60 from

To watch the contents of a directory change, you could use

* watch -d ls -l

If you're only interested in files owned by user joe, you might use

* watch -d 'ls -l | fgrep joe'

To see the effects of quoting, try these out

* watch echo $$  
  watch echo '$$'  
  watch echo "'"'$$'"'"

To see the effect of precision time keeping, try adding
_-p_
to

* watch -n 10 sleep 1

You can watch for your administrator to install the latest kernel with

* watch uname -r

(Note that
_-p_
isn't guaranteed to work across reboots, especially in the face of
**ntpdate**
or other bootup time-changing mechanisms)
