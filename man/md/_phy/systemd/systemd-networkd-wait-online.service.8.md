# systemd\-networkd\-wait\-online\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-networkd-wait-online.service, systemd-networkd-wait-online - Wait for network to come online

<a name="synopsis"></a>

# Synopsis

```

 systemd-networkd-wait-online.service 
 /usr/lib/systemd/systemd-networkd-wait-online
```

<a name="description"></a>

# Description


**systemd-networkd-wait-online**
is a oneshot system service (see
**systemd.service**(5)), that waits for the network to be configured. By default, it will wait for all links it is aware of and which are managed by
**systemd-networkd.service**(8)
to be fully configured or failed, and for at least one link to gain a carrier.

<a name="options"></a>

# Options


The following options are understood:

**-i**, **--interface=**
Network interface to wait for before deciding if the system is online. This is useful when a system has several interfaces which will be configured, but a particular one is necessary to access some network resources. This option may be used more than once to wait for multiple network interfaces. When used, all other interfaces are ignored.

**--ignore=**
Network interfaces to be ignored when deciding if the system is online. By default, only the loopback interface is ignored. This option may be used more than once to ignore multiple network interfaces.

**--timeout=**
Fail the service if the network is not online by the time the timeout elapses. A timeout of 0 disables the timeout. Defaults to 120 seconds.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.service**(5),
**systemd-networkd.service**(8)
