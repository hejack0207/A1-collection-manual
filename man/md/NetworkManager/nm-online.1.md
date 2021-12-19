# nm\-online(1)

NetworkManager 1\&.16\&.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nm-online - ask NetworkManager whether the network is connected

<a name="synopsis"></a>

# Synopsis

```
.HP \w'nm-online&nbsp;'u nm-online [OPTIONS...]
```

<a name="description"></a>

# Description


**nm-online**
is a utility to find out whether we are online. It is done by asking NetworkManager about its status. When run,
**nm-online**
waits until NetworkManager reports an active connection, or specified timeout expires. On exit, the returned status code should be checked (see the return codes below).

By default NetworkManager waits for IPv4 dynamic addressing to complete but does not wait for the
auto
IPv6 dynamic addressing. To wait for IPv6 addressing to complete, either (1) change the network connections IPv6
may-fail
setting to
no, and/or (2) change the IPv6 addressing method to
manual
or
dhcp, to indicate that IPv6 connectivity is expected.

<a name="options"></a>

# Options


**-h** | **--help**
Print help information.

**-q** | **--quiet**
Dont print anything.

**-s** | **--wait-for-startup**
Wait for NetworkManager startup to complete, rather than waiting for network connectivity specifically. Startup is considered complete once NetworkManager has activated (or attempted to activate) every auto-activate connection which is available given the current network state. (This is generally only useful at boot time; after startup has completed,
**nm-online -s**
will just return immediately, regardless of the current network state.)

**-t** | **--timeout** _seconds_
Time to wait for a connection, in seconds. If the option is not provided, the default timeout is 30 seconds.

**-x** | **--exit**
Exit immediately if NetworkManager is not running or connecting.

<a name="exit-status"></a>

# Exit Status


**nm-online**
exits with status 0 if it succeeds, a value greater than 0 is returned if an error occurs.

**0**
Success – already online or connection established within given timeout.

**1**
Offline or not online within given timeout.

**2**
Unknown or unspecified error.

<a name="see-also"></a>

# See Also


**nmcli**(1),
**NetworkManager**(8).
