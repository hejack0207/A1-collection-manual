# systemd\-update\-utmp\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-update-utmp.service, systemd-update-utmp-runlevel.service, systemd-update-utmp - Write audit and utmp updates at bootup, runlevel changes and shutdown

<a name="synopsis"></a>

# Synopsis

```

 systemd-update-utmp.service 
 systemd-update-utmp-runlevel.service 
 /usr/lib/systemd/systemd-update-utmp
```

<a name="description"></a>

# Description


systemd-update-utmp-runlevel.service
is a service that writes SysV runlevel changes to utmp and wtmp, as well as the audit logs, as they occur.
systemd-update-utmp.service
does the same for system reboots and shutdown requests.

<a name="see-also"></a>

# See Also


**systemd**(1),
**utmp**(5),
**auditd**(8)
