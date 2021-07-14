# mesg(1) - display (or do not display) messages from other users

util-linux, July 2014

```
mesg [option] [n|y]
```

<a name="description"></a>

# Description

The
**mesg**
utility is invoked by a user to control write access others have to the
terminal device associated with standard error output.  If write access
is allowed, then programs such as
**talk**(1)
and
**write**(1)
may display messages on the terminal.

Traditionally, write access is allowed by default.  However, as users
become more conscious of various security risks, there is a trend to remove
write access by default, at least for the primary login shell.  To make
sure your ttys are set the way you want them to be set,
**mesg**
should be executed in your login scripts.

The
**mesg**
utility silently exits with error status 2 if the current standard error output does
not refer to the terminal.  In this case execute
**mesg**
is pointless.  The command line option **--verbose** forces
mesg to print a warning in this situation.  This behaviour has been introduced
in version 2.33.

<a name="arguments"></a>

# Arguments


* **n**  
  Disallow messages.
* **y**  
  Allow messages to be displayed.

If no arguments are given,
**mesg**
shows the current message status on standard error output.

<a name="options"></a>

# Options


* **-v**,** --verbose**  
  Explain what is being done.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="exit-status"></a>

# Exit Status

The
**mesg**
utility exits with one of the following values:

* **&nbsp;0**
  Messages are allowed.
* **&nbsp;1**
  Messages are not allowed.
* **&gt;1**
  An error has occurred.

<a name="files"></a>

# Files

_/dev/[pt]ty[pq]?_

<a name="see-also"></a>

# See Also

**login**(1),
**talk**(1),
**write**(1),
**wall**(1),
**xterm**(1)

<a name="history"></a>

# History

A
**mesg**
command appeared in Version 6 AT&T UNIX.


<a name="availability"></a>

# Availability

The mesg command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
