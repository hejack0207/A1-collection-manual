# systemd\-time\-wait\-sync\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-time-wait-sync.service, systemd-time-wait-sync - Wait Until Kernel Time Synchronized

<a name="synopsis"></a>

# Synopsis

```

 systemd-time-wait-sync.service 
 /usr/lib/systemd/systemd-time-wait-sync
```

<a name="description"></a>

# Description


systemd-time-wait-sync
is a system service that delays the start of units that depend on
time-sync.target
until the system time has been synchronized with an accurate time source by
systemd-timesyncd.service.

systemd-timesyncd.service
notifies on successful synchronization.
systemd-time-wait-sync
also tries to detect when the kernel marks the time as synchronized, but this detection is not reliable and is intended only as a fallback for other services that can be used to synchronize time (e.g., ntpd, chronyd).

<a name="files"></a>

# Files


/run/systemd/timesync/synchronized
The presence of this file indicates to this service that the system clock has been synchronized.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.special**(7),
**systemd-timesyncd.service**(8),
