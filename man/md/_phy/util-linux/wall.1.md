# wall(1) - write a message to all users

util-linux, August 2013

```
wall [-n] [-t timeout] [-g group] [message | file]
```

<a name="description"></a>

# Description

**wall**
displays a
_message_,
or the contents of a
_file_,
or otherwise its standard input, on the terminals of all currently logged
in users.  The command will wrap lines that are longer than 79 characters.
Short lines are whitespace padded to have 79 characters.  The command will
always put a carriage return and new line at the end of each line.

Only the superuser can write on the terminals of users who have chosen to
deny messages or are using a program which automatically denies messages.

Reading from a
_file_
is refused when the invoker is not superuser and the program is
set-user-ID or set-group-ID.

<a name="options"></a>

# Options


* **-n**,** --nobanner**  
  Suppress the banner.
* **-t**,** --timeout **_timeout_  
  Abandon the write attempt to the terminals after _timeout_ seconds.
  This _timeout_ must be a positive integer.  The default value
  is 300 seconds, which is a legacy from the time when people ran terminals over
  modem lines.
* **-g**,** --group **_group_  
  Limit printing message to members of group defined as a
  _group_
  argument.  The argument can be group name or GID.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="notes"></a>

# Notes

Some sessions, such as wdm, that have in the beginning of
**utmp**(5)
ut_type data a ':' character will not get the message from
**wall**.
This is done to avoid write errors.

<a name="see-also"></a>

# See Also

**mesg**(1),
**talk**(1),
**write**(1),
**shutdown**(8)

<a name="history"></a>

# History

A
**wall**
command appeared in Version 7 AT&T UNIX.

<a name="availability"></a>

# Availability

The wall command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
