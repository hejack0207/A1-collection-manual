# udev\&.conf(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

udev.conf - Configuration for device event managing daemon

<a name="synopsis"></a>

# Synopsis

```

 /etc/udev/udev.conf
```

<a name="description"></a>

# Description


**systemd-udevd**(8)
expects its main configuration file at
/etc/udev/udev.conf. It consists of a set of variables allowing the user to override default udev values. All empty lines or lines beginning with #\*(Aq are ignored. The following variables can be set:

_udev\_log=_
The log level. Valid values are the numerical syslog priorities or their textual representations:
**err**,
**info**
and
**debug**.

_children\_max=_
An integer. The maximum number of events executed in parallel.

This is the same as the
**--children-max=**
option.

_exec\_delay=_
An integer. Delay the execution of
_RUN_
instructions by the given number of seconds. This option might be useful when debugging system crashes during coldplug caused by loading non-working kernel modules.

This is the same as the
**--exec-delay=**
option.

_event\_timeout=_
An integer. The number of seconds to wait for events to finish. After this time, the event will be terminated. The default is 180 seconds.

This is the same as the
**--event-timeout=**
option.

_resolve\_names=_
Specifes when systemd-udevd should resolve names of users and groups. When set to
**early**
(the default), names will be resolved when the rules are parsed. When set to
**late**, names will be resolved for every event. When set to
**never**, names will never be resolved and all devices will be owned by root.

This is the same as the
**--resolve-names=**
option.

In addition,
systemd-udevd
can be configured by command line options and the kernel command line (see
**systemd-udevd**(8)).

<a name="see-also"></a>

# See Also


**systemd-udevd**(8),
**udev**(7),
**udevadm**(8)
