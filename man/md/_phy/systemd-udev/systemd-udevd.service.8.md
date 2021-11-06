# systemd\-udevd\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-udevd.service, systemd-udevd-control.socket, systemd-udevd-kernel.socket, systemd-udevd - Device event managing daemon

<a name="synopsis"></a>

# Synopsis

```

 systemd-udevd.service 
 systemd-udevd-control.socket 
 systemd-udevd-kernel.socket .HP \w'/usr/lib/systemd/systemd-udevd&nbsp;'u /usr/lib/systemd/systemd-udevd [--daemon] [--debug] [--children-max=] [--exec-delay=] [--event-timeout=] [--resolve-names=early|late|never] [--version] [--help]
```

<a name="description"></a>

# Description


**systemd-udevd**
listens to kernel uevents. For every event, systemd-udevd executes matching instructions specified in udev rules. See
**udev**(7).

The behavior of the daemon can be configured using
**udev.conf**(5), its command line options, environment variables, and on the kernel command line, or changed dynamically with
**udevadm control**.

<a name="options"></a>

# Options


**-d**, **--daemon**
Detach and run in the background.

**-D**, **--debug**
Print debug messages to standard error.

**-c=**, **--children-max=**
Limit the number of events executed in parallel.

**-e=**, **--exec-delay=**
Delay the execution of
_RUN_
instructions by the given number of seconds. This option might be useful when debugging system crashes during coldplug caused by loading non-working kernel modules.

**-t=**, **--event-timeout=**
Set the number of seconds to wait for events to finish. After this time, the event will be terminated. The default is 180 seconds.

**-N=**, **--resolve-names=**
Specify when systemd-udevd should resolve names of users and groups. When set to
**early**
(the default), names will be resolved when the rules are parsed. When set to
**late**, names will be resolved for every event. When set to
**never**, names will never be resolved and all devices will be owned by root.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="kernel-command-line"></a>

# Kernel Command Line


Parameters starting with "rd." will be read when
**systemd-udevd**
is used in an initrd.

_udev.log\_priority=_, _rd.udev.log\_priority=_
Set the log level.

_udev.children\_max=_, _rd.udev.children\_max=_
Limit the number of events executed in parallel.

_udev.exec\_delay=_, _rd.udev.exec\_delay=_
Delay the execution of
_RUN_
instructions by the given number of seconds. This option might be useful when debugging system crashes during coldplug caused by loading non-working kernel modules.

_udev.event\_timeout=_, _rd.udev.event\_timeout=_
Wait for events to finish up to the given number of seconds. This option might be useful if events are terminated due to kernel drivers taking too long to initialize.

_net.ifnames=_
Network interfaces are renamed to give them predictable names when possible. It is enabled by default; specifying 0 disables it.

_net.naming-scheme=_
Network interfaces are renamed to give them predictable names when possible (unless
_net.ifnames=0_
is specified, see above). The names are derived from various device metadata fields. Newer versions of
systemd-udevd.service
take more of these fields into account, improving (and thus possibly changing) the names used for the same devices. With this kernel command line option it is possible to pick a specific version of this algorithm. It expects a naming scheme identifier as argument. Currently the following identifiers are known:
"v238",
"v239",
"v240"
which each implement the naming scheme that was the default in the indicated systemd version. In addition,
"latest"
may be used to designate the latest scheme known (to this particular version of
systemd-udevd.service).

Note that selecting a specific scheme is not sufficient to fully stabilize interface naming: the naming is generally derived from driver attributes exposed by the kernel. As the kernel is updated, previously missing attributes
systemd-udevd.service
is checking might appear, which affects older name derivation algorithms, too.

<a name="see-also"></a>

# See Also


**udev.conf**(5),
**udev**(7),
**udevadm**(8)
