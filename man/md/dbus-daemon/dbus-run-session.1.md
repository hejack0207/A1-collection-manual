# dbus\-run\-session(1)

D\-Bus 1\&.12\&.20, 07/27/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dbus-run-session - start a process as a new D-Bus session

<a name="synopsis"></a>

# Synopsis

```
.HP \w'dbus-run-session&nbsp;'u dbus-run-session [--config-file&nbsp;FILENAME] [--dbus-daemon&nbsp;BINARY] [--] PROGRAM [ARGUMENTS...] .HP \w'dbus-run-session&nbsp;'u dbus-run-session --help .HP \w'dbus-run-session&nbsp;'u dbus-run-session --version
```

<a name="description"></a>

# Description


**dbus-run-session**
is used to start a session bus instance of
**dbus-daemon**
from a shell script, and start a specified program in that session. The
**dbus-daemon**
will run for as long as the program does, after which it will terminate.

One use is to run a shell with its own
**dbus-daemon**
in a text-mode or SSH session, and have the
**dbus-daemon**
terminate automatically on leaving the sub-shell, like this:

dbus-run-session -- bash

or to replace the login shell altogether, by combining
**dbus-run-session**
with the
**exec**
builtin:

exec dbus-run-session -- bash

Another use is to run regression tests and similar things in an isolated D-Bus session, to avoid either interfering with the "real" D-Bus session or relying on there already being a D-Bus session active, for instance:

dbus-run-session -- make check

or (in
**automake**(1)):

.if n \{.RS 4
.\}
      AM_TESTS_ENVIRONMENT = export MY_DEBUG=all;
      LOG_COMPILER = dbus-run-session
      AM_LOG_FLAGS = --
.if n \{.RE
.\}

<a name="options"></a>

# Options


**--config-file=**_FILENAME_, **--config-file** _FILENAME_
Pass
**--config-file=**_FILENAME_
to the bus daemon, instead of passing it the
**--session**
argument. See
**dbus-daemon**(1).

**--dbus-daemon=**_BINARY_, **--dbus-daemon** _BINARY_
Run
_BINARY_
as
**dbus-daemon**(1), instead of searching the
**PATH**
in the usual way for an executable called
**dbus-daemon**.

**--help**
Print usage information and exit.

**--version**
Print the version of dbus-run-session and exit.

<a name="exit-status"></a>

# Exit Status


**dbus-run-session**
exits with the exit status of
_PROGRAM_, 0 if the
**--help**
or
**--version**
options were used, 127 on an error within
**dbus-run-session**
itself, or 128+_n_
if the
_PROGRAM_
was killed by signal
_n_.

<a name="environment"></a>

# Environment


**PATH**
is searched to find
_PROGRAM_, and (if the --dbus-daemon option is not used or its argument does not contain a
**/**
character) to find
**dbus-daemon**.

The session bus address is made available to
_PROGRAM_
in the environment variable
**DBUS\_SESSION\_BUS\_ADDRESS**.

The variables
**DBUS\_SESSION\_BUS\_PID**,
**DBUS\_SESSION\_BUS\_WINDOWID**,
**DBUS\_STARTER\_BUS\_TYPE**
and
**DBUS\_STARTER\_ADDRESS**
are removed from the environment, if present.

<a name="bugs"></a>

# Bugs


Please send bug reports to the D-Bus mailing list or bug tracker, see
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[]

<a name="see-also"></a>

# See Also


**dbus-daemon**(1),
**dbus-launch**(1)
