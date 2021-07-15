# systemd\-halt\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-halt.service, systemd-poweroff.service, systemd-reboot.service, systemd-kexec.service, systemd-shutdown - System shutdown logic

<a name="synopsis"></a>

# Synopsis

```

 systemd-halt.service 
 systemd-poweroff.service 
 systemd-reboot.service 
 systemd-kexec.service 
 /usr/lib/systemd/systemd-shutdown 
 /usr/lib/systemd/system-shutdown/
```

<a name="description"></a>

# Description


systemd-halt.service
is a system service that is pulled in by
halt.target
and is responsible for the actual system halt. Similarly,
systemd-poweroff.service
is pulled in by
poweroff.target,
systemd-reboot.service
by
reboot.target
and
systemd-kexec.service
by
kexec.target
to execute the respective actions.

When these services are run, they ensure that PID 1 is replaced by the
/usr/lib/systemd/systemd-shutdown
tool which is then responsible for the actual shutdown. Before shutting down, this binary will try to unmount all remaining file systems, disable all remaining swap devices, detach all remaining storage devices and kill all remaining processes.

It is necessary to have this code in a separate binary because otherwise rebooting after an upgrade might be broken&nbsp;— the running PID 1 could still depend on libraries which are not available any more, thus keeping the file system busy, which then cannot be re-mounted read-only.

Immediately before executing the actual system halt/poweroff/reboot/kexec
systemd-shutdown
will run all executables in
/usr/lib/systemd/system-shutdown/
and pass one arguments to them: either
"halt",
"poweroff",
"reboot"
or
"kexec", depending on the chosen action. All executables in this directory are executed in parallel, and execution of the action is not continued before all executables finished.

Note that
systemd-halt.service
(and the related units) should never be executed directly. Instead, trigger system shutdown with a command such as
"systemctl halt"
or suchlike.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd.special**(7),
**reboot**(2),
**systemd-suspend.service**(8),
**bootup**(7)
