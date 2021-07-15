# systemd\-run\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-run-generator - Generator for invoking commands specified on the kernel command line as system service

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-run-generator
```

<a name="description"></a>

# Description


systemd-run-generator
is a generator that reads the kernel command line and understands three options:

If the
**systemd.run=**
option is specified and followed by a command line, a unit named
kernel-command-line.service
is generated for it and booted into. The service has
_Type=oneshot_
set, and has
_SuccessAction=exit_
and
_FailureAction=exit_
configured by default, thus ensuring that the system is shut down as soon as the command completes. The exit status of the command line is propagated to the invoking container manager, if this applies (which might propagate this further, to the calling shell — e.g.
**systemd-nspawn**(7)
does this). If this option is used multiple times the unit file will contain multiple
_ExecStart=_
lines, to execute all commands in order. The command is started as regular service, i.e. with
_DefaultDependencies=_
on.

Use
**systemd.run\_success\_action=**
and
**systemd.run\_failure\_action=**
to tweak how to react to the process completing. In particular assigning
"none"
will leave the system running after the command completes. For further details on supported arguments, see
**systemd.unit**(5).

systemd-run-generator
implements
**systemd.generator**(7).

<a name="example"></a>

# Example


Use a command like the following to add a user to the user database inside a container run with
**systemd-nspawn**(7):

.if n \{.RS 4
.\}
    # systemd-nspawn -D mycontainer -b systemd.run="adduser test"*(Aq
.if n \{.RE
.\}

(Note the requirement for double quoting in the command line above. The first level of quoting (\*(Aq) is processed and removed by the command shell used to invoke
**systemd-nspawn**. The second level of quoting ("") is propagated to the kernel command line of the container and processed and removed by
**systemd-run-generator**. Both together make sure both words of the specified command line
**adduser test**
end up in the generated unit file together and are neither split apart by the command shell nor by the generator.)

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**kernel-command-line**(7),
**systemd-nspawn**(7),
**systemd.unit**(5),
**systemd.service**(5)
