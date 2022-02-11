# pkcheck(1)

polkit, May 2009

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pkcheck - Check whether a process is authorized

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pkcheck&nbsp;'u pkcheck [--version] [--help] .HP \w'pkcheck&nbsp;'u pkcheck [--list-temp] .HP \w'pkcheck&nbsp;'u pkcheck [--revoke-temp] .HP \w'pkcheck&nbsp;'u pkcheck --action-id&nbsp;action {--process&nbsp;{&nbsp;pid&nbsp;|&nbsp;pid,pid-start-time&nbsp;|&nbsp;pid,pid-start-time,uid&nbsp;} | --system-bus-name&nbsp;busname} [--allow-user-interaction] [--enable-internal-agent] [--detail&nbsp;key&nbsp;value...]
```

<a name="description"></a>

# Description


**pkcheck**
is used to check whether a process, specified by either
**--process**
(see below) or
**--system-bus-name**, is authorized for
_action_. The
**--detail**
option can be used zero or more times to pass details about
_action_. If
**--allow-user-interaction**
is passed,
**pkcheck**
blocks while waiting for authentication.

The invocation
**pkcheck --list-temp**
will list all temporary authorizations for the current session and
**pkcheck --revoke-temp**
will revoke all temporary authorizations for the current session.

This command is a simple wrapper around the polkit D-Bus interface; see the D-Bus interface documentation for details.

<a name="return-value"></a>

# Return Value


If the specified process is authorized,
**pkcheck**
exits with a return value of 0. If the authorization result contains any details, these are printed on standard output as key/value pairs using environment style reporting, e.g. first the key followed by a an equal sign, then the value followed by a newline.

.if n \{.RS 4
.\}
    KEY1=VALUE1
    KEY2=VALUE2
    KEY3=VALUE3
    ...
.if n \{.RE
.\}

Octets that are not in [a-zA-Z0-9_] are escaped using octal codes prefixed with
_\e_. For example, the UTF-8 string
_føl,你好_
will be printed as
_f\e303\e270l\e54\e344\e275\e240\e345\e245\e275_.

If the specified process is not authorized,
**pkcheck**
exits with a return value of 1 and a diagnostic message is printed on standard error. Details are printed on standard output.

If the specified process is not authorized because no suitable authentication agent is available or if the
**--allow-user-interaction**
wasnt passed,
**pkcheck**
exits with a return value of 2 and a diagnostic message is printed on standard error. Details are printed on standard output.

If the specified process is not authorized because the authentication dialog / request was dismissed by the user,
**pkcheck**
exits with a return value of 3 and a diagnostic message is printed on standard error. Details are printed on standard output.

If an error occurred while checking for authorization,
**pkcheck**
exits with a return value of 127 with a diagnostic message printed on standard error.

If one or more of the options passed are malformed,
**pkcheck**
exits with a return value of 126. If stdin is a tty, then this manual page is also shown.

<a name="notes"></a>

# Notes


Do not use either the bare
_pid_
or
_pid,start-time_
syntax forms for
**--process**. There are race conditions in both. New code should always use
_pid,pid-start-time,uid_. The value of
_start-time_
can be determined by consulting e.g. the
**proc**(5)
file system depending on the operating system. If fewer than 3 arguments are passed,
**pkcheck**
will attempt to look up them up internally, but note that this may be racy.

If your program is a daemon with e.g. a custom Unix domain socket, you should determine the
_uid_
parameter via operating system mechanisms such as
PEERCRED.

<a name="authentication-agent"></a>

# Authentication Agent


**pkcheck**, like any other polkit application, will use the authentication agent registered for the process in question. However, if no authentication agent is available, then
**pkcheck**
can register its own textual authentication agent if the option
**--enable-internal-agent**
is passed.

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
**pkexec**(1),
**pkttyagent**(1)
