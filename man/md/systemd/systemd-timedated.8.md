# systemd\-timedated\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-timedated.service, systemd-timedated - Time and date bus mechanism

<a name="synopsis"></a>

# Synopsis

```

 systemd-timedated.service 
 /usr/lib/systemd/systemd-timedated
```

<a name="description"></a>

# Description


systemd-timedated
is a system service that may be used as a mechanism to change the system clock and timezone, as well as to enable/disable NTP time synchronization.
systemd-timedated
is automatically activated on request and terminates itself when it is unused.

The tool
**timedatectl**(1)
is a command line client to this service.

See the
\m[blue]**developer documentation**\m[]\s-2\u[1]\d\s+2
for information about the APIs
systemd-timedated
provides.

<a name="environment"></a>

# Environment


_$SYSTEMD\_TIMEDATED\_NTP\_SERVICES_
Colon-separated list of unit names of NTP client services. If not set, then
**systemd-timesyncd.service**(8)
is used. See the entries of NTP related commands of
**timedatectl**(1)
for details about this.

Example:

.if n \{.RS 4
.\}
    SYSTEMD_TIMEDATED_NTP_SERVICES=ntpd.service:chronyd.service:systemd-timesyncd.service
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**systemd**(1),
**timedatectl**(1),
**localtime**(5),
**hwclock**(8),
**systemd-timesyncd**(8)

<a name="notes"></a>

# Notes


*  1.  
  developer documentation
      https://www.freedesktop.org/wiki/Software/systemd/timedated
