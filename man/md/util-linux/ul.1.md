# ul(1) - do underlining

util-linux, September 2011

```
ul [options] [file...]
```

<a name="description"></a>

# Description

**ul**
reads the named files (or standard input if none are given) and translates
occurrences of underscores to the sequence which indicates underlining for
the terminal in use, as specified by the environment variable
**TERM**.
The
_terminfo_
database is read to determine the appropriate sequences for underlining.  If
the terminal is incapable of underlining but is capable of a standout mode,
then that is used instead.  If the terminal can overstrike, or handles
underlining automatically,
**ul**
degenerates to
**cat**(1).
If the terminal cannot underline, underlining is ignored.

<a name="options"></a>

# Options


* **-i**, **--indicated**  
  Underlining is indicated by a separate line containing appropriate dashes
  \`-'; this is useful when you want to look at the underlining which is
  present in an
  **nroff**
  output stream on a crt-terminal.
* **-t**, **-T**, **--terminal** _terminal_  
  Override the environment variable
  **TERM**
  with the specified
  _terminal_
  type.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="environment"></a>

# Environment

The following environment variable is used:

* **TERM**  
  The
  **TERM**
  variable is used to relate a tty device with its device capability
  description (see
  **terminfo**(5)).
  **TERM**
  is set at login time, either by the default terminal type specified in
  _/etc/ttys_
  or as set during the login process by the user in their
  **login**
  file (see
  **setenv**(1)).

<a name="see-also"></a>

# See Also

**colcrt**(1),
**login**(1),
**man**(1),
**nroff**(1),
**setenv**(1),
**terminfo**(5)

<a name="bugs"></a>

# Bugs

**nroff**
usually outputs a series of backspaces and underlines intermixed with the
text to indicate underlining.  No attempt is made to optimize the backward
motion.

<a name="history"></a>

# History

The
**ul**
command appeared in 3.0BSD.

<a name="availability"></a>

# Availability

The ul command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
