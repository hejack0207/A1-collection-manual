# firewalld\&.zones(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.zones - firewalld zones

<a name="description"></a>

# Description


<a name="what-is-a-zone"></a>

### What is a zone?


A network zone defines the level of trust for network connections. This is a one to many relation, which means that a connection can only be part of one zone, but a zone can be used for many network connections.

The zone defines the firewall features that are enabled in this zone:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Predefined services**

A service is a combination of port and/or protocol entries. Optionally netfilter helper modules can be added and also a IPv4 and IPv6 destination address.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Ports and protocols**

Definition of
_tcp_
or
_udp_
ports, where ports can be a single port or a port range.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**ICMP blocks**

Blocks selected Internet Control Message Protocol (ICMP) messages. These messages are either information requests or created as a reply to information requests or in error conditions.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Masquerading**

The addresses of a private network are mapped to and hidden behind a public IP address. This is a form of address translation.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Forward ports**

A forward port is either mapped to the same port on another host or to another port on the same host or to another port on another host.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Rich language rules**

The rich language extends the elements (service, port, icmp-block, masquerade, forward-port and source-port) with additional source and destination addresses, logging, actions and limits for logs and actions. It can also be used for host or network white and black listing (for more information, please have a look at
**firewalld.richlanguage**(5)).

For more information on the zone file format, please have a look at
**firewalld.zone**(5).

<a name="which-zones-are-available"></a>

### Which zones are available?


Here are the zones provided by firewalld sorted according to the default trust level of the zones from untrusted to trusted:

drop
Any incoming network packets are dropped, there is no reply. Only outgoing network connections are possible.

block
Any incoming network connections are rejected with an
_icmp-host-prohibited_
message for IPv4 and
_icmp6-adm-prohibited_
for IPv6. Only network connections initiated within this system are possible.

public
For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.

external
For use on external networks with masquerading enabled especially for routers. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.

dmz
For computers in your demilitarized zone that are publicly-accessible with limited access to your internal network. Only selected incoming connections are accepted.

work
For use in work areas. You mostly trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.

home
For use in home areas. You mostly trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.

internal
For use on internal networks. You mostly trust the other computers on the networks to not harm your computer. Only selected incoming connections are accepted.

trusted
All network connections are accepted.

<a name="which-zone-should-be-used"></a>

### Which zone should be used?


A public WIFI network connection for example should be mainly untrusted, a wired home network connection should be fairly trusted. Select the zone that best matches the network you are using.

<a name="how-to-configure-or-add-zones"></a>

### How to configure or add zones?


To configure or add zones you can either use one of the firewalld interfaces to handle and change the configuration: These are the graphical configuration tool firewall-config, the command line tool
**firewall-cmd**
or the D-Bus interface. Or you can create or copy a zone file in one of the configuration directories.
_/usr/lib/firewalld/zones_
is used for default and fallback configurations and
_/etc/firewalld/zones_
is used for user created and customized configuration files.

<a name="how-to-set-or-change-a-zone-for-a-connection"></a>

### How to set or change a zone for a connection?


The zone is stored into the ifcfg of the connection with
**ZONE=**
option. If the option is missing or empty, the default zone set in firewalld is used.

If the connection is controlled by NetworkManager, you can also use
**nm-connection-editor**
to change the zone.

For the addion or change of interfaces that are not under control of NetworkManager: firewalld tries to change the ZONE setting in the ifcfg file, if an ifcfg file exists that is using the interface.

Only for the removal of interfaces that are not under control of NetworkManager: firewalld is not trying to change the ZONE setting in the ifcfg file. This is needed to make sure that an ifdown of the interface will not result in a reset of the zone setting to the default zone. Only the zone binding is then removed in firewalld then.

<a name="see-also"></a>

# See Also

**firewall-applet**(1), **firewalld**(1), **firewall-cmd**(1), **firewall-config**(1), **firewalld.conf**(5), **firewalld.direct**(5), **firewalld.dbus**(5), **firewalld.icmptype**(5), **firewalld.lockdown-whitelist**(5), **firewall-offline-cmd**(1), **firewalld.richlanguage**(5), **firewalld.service**(5), **firewalld.zone**(5), **firewalld.zones**(5), **firewalld.ipset**(5), **firewalld.helper**(5)

<a name="notes"></a>

# Notes


firewalld home page:
\m[blue]**http://firewalld.org**\m[]

More documentation with examples:
\m[blue]**http://fedoraproject.org/wiki/FirewallD**\m[]

<a name="authors"></a>

# Authors


**Thomas Woerner** &lt;[twoerner@redhat.com](mailto:twoerner@redhat.com)&gt;
Developer

**Jiri Popelka** &lt;[jpopelka@redhat.com](mailto:jpopelka@redhat.com)&gt;
Developer

**Eric Garver** &lt;[eric@garver.life](mailto:eric@garver.life)&gt;
Developer
