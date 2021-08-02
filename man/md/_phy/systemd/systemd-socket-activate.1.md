# systemd\-socket\-activate(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-socket-activate - Test socket activation of daemons

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-socket-activate&nbsp;'u systemd-socket-activate [OPTIONS...] daemon [OPTIONS...]
```

<a name="description"></a>

# Description


**systemd-socket-activate**
may be used to launch a socket-activated service program from the command line for testing purposes. It may also be used to launch individual instances of the service program per connection.

The daemon to launch and its options should be specified after options intended for
**systemd-socket-activate**.

If the
**--inetd**
option is given, the socket file descriptor will be used as the standard input and output of the launched process. Otherwise, standard input and output will be inherited, and sockets will be passed through file descriptors 3 and higher. Sockets passed through
_$LISTEN\_FDS_
to
**systemd-socket-activate**
will be passed through to the daemon, in the original positions. Other sockets specified with
**--listen=**
will use consecutive descriptors. By default,
**systemd-socket-activate**
listens on a stream socket, use
**--datagram**
and
**--seqpacket**
to listen on datagram or sequential packet sockets instead (see below).

<a name="options"></a>

# Options


**-l ****address**, **--listen=****address**
Listen on this
_address_. Takes a string like
"2000"
or
"127.0.0.1:2001".

**-a**, **--accept**
Launch an instance of the service program for each connection and pass the connection socket.

**-d**, **--datagram**
Listen on a datagram socket (**SOCK\_DGRAM**), instead of a stream socket (**SOCK\_STREAM**). May not be combined with
**--seqpacket**.

**--seqpacket**
Listen on a sequential packet socket (**SOCK\_SEQPACKET**), instead of a stream socket (**SOCK\_STREAM**). May not be combined with
**--datagram**.

**--inetd**
Use the inetd protocol for passing file descriptors, i.e. as standard input and standard output, instead of the new-style protocol for passing file descriptors using
_$LISTEN\_FDS_
(see above).

**-E ****_VAR****[=VALUE**]_, **--setenv=****_VAR****[=VALUE**]_
Add this variable to the environment of the launched process. If
_VAR_
is followed by
"=", assume that it is a variable–value pair. Otherwise, obtain the value from the environment of
**systemd-socket-activate**
itself.

**--fdname=**_NAME_[:_NAME_...]
Specify names for the file descriptors passed. This is equivalent to setting
_FileDescriptorName=_
in socket unit files, and enables use of
**sd\_listen\_fds\_with\_names**(3). Multiple entries may be specifies using separate options or by separating names with colons (":") in one option. In case more names are given than descriptors, superfluous ones will be ignored. In case less names are given than descriptors, the remaining file descriptors will be unnamed.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="environment-variables"></a>

# Environment Variables


_$LISTEN\_FDS_, _$LISTEN\_PID_, _$LISTEN\_FDNAMES_
See
**sd\_listen\_fds**(3).

_$SYSTEMD\_LOG\_TARGET_, _$SYSTEMD\_LOG\_LEVEL_, _$SYSTEMD\_LOG\_COLOR_, _$SYSTEMD\_LOG\_LOCATION_
Same as in
**systemd**(1).

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Run an echo server on port 2000**

.if n \{.RS 4
.\}
    $ systemd-socket-activate -l 2000 --inetd -a cat
.if n \{.RE
.\}

**Example&nbsp;2.&nbsp;Run a socket-activated instance of systemd-journal-gatewayd(8)**

.if n \{.RS 4
.\}
    $ systemd-socket-activate -l 19531 /usr/lib/systemd/systemd-journal-gatewayd
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.socket**(5),
**systemd.service**(5),
**systemd-run**(1),
**sd\_listen\_fds**(3),
**sd\_listen\_fds\_with\_names**(3),
**cat**(1)
