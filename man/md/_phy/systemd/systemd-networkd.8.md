# systemd\-networkd\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-networkd.service, systemd-networkd - Network manager

<a name="synopsis"></a>

# Synopsis

```

 systemd-networkd.service 
 /usr/lib/systemd/systemd-networkd
```

<a name="description"></a>

# Description


**systemd-networkd**
is a system service that manages networks. It detects and configures network devices as they appear, as well as creating virtual network devices.

To configure low-level link settings independently of networks, see
**systemd.link**(5).

**systemd-networkd**
will create network devices based on the configuration in
**systemd.netdev**(5)
files, respecting the [Match] sections in those files.

**systemd-networkd**
will manage network addresses and routes for any link for which it finds a
.network
file with an appropriate [Match] section, see
**systemd.network**(5). For those links, it will flush existing network addresses and routes when bringing up the device. Any links not matched by one of the
.network
files will be ignored. It is also possible to explicitly tell
systemd-networkd
to ignore a link by using
_Unmanaged=yes_
option, see
**systemd.network**(5).

When
systemd-networkd
exits, it generally leaves existing network devices and configuration intact. This makes it possible to transition from the initramfs and to restart the service without breaking connectivity. This also means that when configuration is updated and
systemd-networkd
is restarted, netdev interfaces for which configuration was removed will not be dropped, and may need to be cleaned up manually.

<a name="configuration-files"></a>

# Configuration Files


The configuration files are read from the files located in the system network directory
/usr/lib/systemd/network, the volatile runtime network directory
/run/systemd/network
and the local administration network directory
/etc/systemd/network.

Networks are configured in
.network
files, see
**systemd.network**(5), and virtual network devices are configured in
.netdev
files, see
**systemd.netdev**(5).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.link**(5),
**systemd.network**(5),
**systemd.netdev**(5),
**systemd-networkd-wait-online.service**(8)
