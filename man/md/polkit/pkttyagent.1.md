# pkttyagent(1)

polkit, May 2009

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pkttyagent - Textual authentication helper

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pkttyagent&nbsp;'u pkttyagent [--version] [--help] .HP \w'pkttyagent&nbsp;'u pkttyagent [--process&nbsp;{&nbsp;pid&nbsp;|&nbsp;pid,pid-start-time&nbsp;} | --system-bus-name&nbsp;busname] [--notify-fd&nbsp;fd] [--fallback]
```

<a name="description"></a>

# Description


**pkttyagent**
is used to start a textual authentication agent for the subject specified by either
**--process**
or
**--system-bus-name**. If neither of these options are given, the parent process is used.

To get notified when the authentication agent has been registered either listen to the
Changed
D-Bus signal or use
**--notify-fd**
to pass the number of a file descriptor that has been passed to the program. This file descriptor will then be closed when the authentication agent has been successfully registered.

If
**--fallback**
is used, the textual authentication agent will not replace an existing authentication agent.

<a name="return-value"></a>

# Return Value


If the authentication agent could not be registered,
**pkttyagent**
exits with an exit code of 127. Diagnostic messages are printed on standard error.

If one or more of the options passed are malformed,
**pkttyagent**
exits with an exit code of 126. If stdin is a tty, then this manual page is also shown.

If the authentication agent was successfully registered,
**pkttyagent**
will keep running, interacting with the user as needed. When its services are no longer needed, the process can be killed.

<a name="notes"></a>

# Notes


Since process identifiers can be recycled, the caller should always use
_pid,pid-start-time_
when using the
**--process**
option. The value of
_pid-start-time_
can be determined by consulting e.g. the
**proc**(5)
file system depending on the operating system. If only
_pid_
is passed to the
**--process**
option, then
**pkttyagent**
will look up the start time itself but note that this may be racy.

<a name="author"></a>

# Author


Written by David Zeuthen
&lt;[davidz@redhat.com](mailto:davidz@redhat.com)&gt;
with a lot of help from many others.

<a name="bugs"></a>

# Bugs


Please send bug reports to either the distribution or the polkit-devel mailing list, see the link
\m[blue]**http://lists.freedesktop.org/mailman/listinfo/polkit-devel**\m[]
on how to subscribe.

<a name="see-also"></a>

# See Also


**polkit**(8),
**polkitd**(8),
**pkaction**(1),
**pkcheck**(1),
**pkexec**(1)
