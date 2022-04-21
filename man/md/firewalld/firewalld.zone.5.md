# firewalld\&.zone(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.zone - firewalld zone configuration files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    /etc/firewalld/zones/zone.xml
    /usr/lib/firewalld/zones/zone.xml
          
<synopsis>


```

<a name="description"></a>

# Description


A firewalld zone configuration file contains the information for a zone. These are the zone description, services, ports, protocols, icmp-blocks, masquerade, forward-ports and rich language rules in an XML file format. The file name has to be
_zone\_name_.xml where length of
_zone\_name_
is currently limited to 17 chars.

This is the structure of a zone configuration file:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <zone [version="versionstring"] [target="ACCEPT|%%REJECT%%|DROP"]>
      [ <short>short description</short> ]
      [ <description>description</description> ]
      [ <interface name="string"/> ]
      [ <source address="address[/mask]"|mac="MAC"|ipset="ipset"/> ]
      [ <service name="string"/> ]
      [ <port port="portid[-portid]" protocol="tcp|udp|sctp|dccp"/> ]
      [ <protocol value="protocol"/> ]
      [ <icmp-block name="string"/> ]
      [ <icmp-block-inversion/> ]
      [ <masquerade/> ]
      [ <forward-port port="portid[-portid]" protocol="tcp|udp|sctp|dccp" [to-port="portid[-portid]"] [to-addr="IP address"]/> ]
      [ <source-port port="portid[-portid]" protocol="tcp|udp|sctp|dccp"/> ]
      [
        <rule [family="ipv4|ipv6"]>
        [ <source address="address[/mask]"|mac="MAC"|ipset="ipset" [invert="True"]/> ]
        [ <destination address="address[/mask]" [invert="True"]/> ]
        [
          <service name="string"/> |
          <port port="portid[-portid]" protocol="tcp|udp|sctp|dccp"/> |
          <protocol value="protocol"/> |
          <icmp-block name="icmptype"/> |
          <icmp-type name="icmptype"/> |
          <masquerade/> |
          <forward-port port="portid[-portid]" protocol="tcp|udp|sctp|dccp" [to-port="portid[-portid]"] [to-addr="address"]/>
        ]
        [ <log [prefix="prefixtext"] [level="emerg|alert|crit|err|warn|notice|info|debug"]> [<limit value="rate/duration"/>] </log> ]
        [ <audit> [<limit value="rate/duration"/>] </audit> ]
        [
          <accept> [<limit value="rate/duration"/>] </accept> |
          <reject [type="rejecttype"]> [<limit value="rate/duration"/>] </reject> |
          <drop> [<limit value="rate/duration"/>] </drop> |
          <mark set="mark[/mask]"> [<limit value="rate/duration"/>] </mark>
        ]
        </rule>
      ]
    </zone>
          
.if n \{.RE
.\}

The config can contain these tags and attributes. Some of them are mandatory, others optional.

<a name="zone"></a>

### zone


The mandatory zone start and end tag defines the zone. This tag can only be used once in a zone configuration file. There are optional attributes for zones:

version="_string_"
To give the zone a version.

target="_ACCEPT_|_%%REJECT%%_|_DROP_"
Can be used to accept, reject or drop every packet that doesnt match any rule (port, service, etc.). The
_ACCEPT_
target is used in
_trusted_
zone to accept every packet not matching any rule. The
_%%REJECT%%_
target is used in
_block_
zone to reject (with default firewalld reject type) every packet not matching any rule. The
_DROP_
target is used in
_drop_
zone to drop every packet not matching any rule. If the target is not specified, every packet not matching any rule will be rejected.

<a name="short"></a>

### short


Is an optional start and end tag and is used to give a zone a more readable name.

<a name="description"></a>

### description


Is an optional start and end tag to have a description for a zone.

<a name="interface"></a>

### interface


Is an optional empty-element tag and can be used several times. It can be used to bind an interface to a zone. You dont need this for NetworkManager-managed interfaces, because NetworkManager binds interfaces to zones automatically. See also \*(AqHow to set or change a zone for a connection?\*(Aq in
**firewalld.zones**(5). You can use it as a fallback mechanism for interfaces that cant be managed via NetworkManager. An interface entry has exactly one attribute:

name="_string_"
The name of the interface to be bound to the zone.

<a name="source"></a>

### source


Is an optional empty-element tag and can be used several times. It can be used to bind a source address, address range, a MAC address or an ipset to a zone. A source entry has exactly one of these attributes:

address="_address_[/_mask_]"
The source is either an IP address or a network IP address with a mask for IPv4 or IPv6. The network family (IPv4/IPv6) will be automatically discovered. For IPv4, the mask can be a network mask or a plain number. For IPv6 the mask is a plain number. The use of host names is not supported.

mac="_MAC_"
The source is a MAC address. It must be of the form XX:XX:XX:XX:XX:XX.

ipset="_ipset_"
The source is an ipset.

<a name="service"></a>

### service


Is an optional empty-element tag and can be used several times to have more than one service entry enabled. A service entry has exactly one attribute:

name="_string_"
The name of the service to be enabled. To get a list of valid service names
**firewall-cmd --list=services**
can be used.

<a name="port"></a>

### port


Is an optional empty-element tag and can be used several times to have more than one port entry. All attributes of a port entry are mandatory:

port="_portid_[-_portid_]"
The port can either be a single port number
_portid_
or a port range
_portid_-_portid_.

protocol="_tcp_|_udp_|_sctp_|_dccp_"
The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

<a name="protocol"></a>

### protocol


Is an optional empty-element tag and can be used several times to have more than one protocol entry. All protocol has exactly one attribute:

value="_string_"
The protocol can be any protocol supported by the system. Please have a look at
_/etc/protocols_
for supported protocols.

<a name="icmp-block"></a>

### icmp\-block


Is an optional empty-element tag and can be used several times to have more than one icmp-block entry. Each icmp-block tag has exactly one mandatory attribute:

name="_string_"
The name of the Internet Control Message Protocol (ICMP) type to be blocked. To get a list of valid ICMP types
**firewall-cmd --list=icmptypes**
can be used.

<a name="icmp-block-inversion"></a>

### icmp\-block\-inversion


Is an optional empty-element tag and can be used only once in a zone configuration. This flag inverts the icmp block handling. Only enabled ICMP types are accepted and all others are rejected in the zone.

<a name="masquerade"></a>

### masquerade


Is an optional empty-element tag. It can be used only once in a zone configuration. If its present masquerading is enabled for the zone. If you want to enable masquerading, you should enable it in the zone bound to the external interface.

<a name="forward-port"></a>

### forward\-port


Is an optional empty-element tag and can be used several times to have more than one port or packet forward entry. There are mandatory and also optional attributes for forward ports:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Mandatory attributes:**

The local port and protocol to be forwarded.

port="_portid_[-_portid_]"
The port can either be a single port number
_portid_
or a port range
_portid_-_portid_.

protocol="_tcp_|_udp_|_sctp_|_dccp_"
The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Optional attributes:**

The destination of the forward. For local forwarding add
**to-port**
only. For remote forwarding add
**to-addr**
and use
**to-port**
optionally if the destination port on the destination machine should be different.

to-port="_portid_[-_portid_]"
The destination port or port range to forward to. If omitted, the value of the port= attribute will be used altogether with the to-addr attribute.

to-addr="_address_"
The destination IP address either for IPv4 or IPv6.

<a name="source-port"></a>

### source\-port


Is an optional empty-element tag and can be used several times to have more than one source port entry. All attributes of a source port entry are mandatory:

port="_portid_[-_portid_]"
The port can either be a single port number
_portid_
or a port range
_portid_-_portid_.

protocol="_tcp_|_udp_|_sctp_|_dccp_"
The protocol can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

<a name="rule"></a>

### rule


Is an optional element tag and can be used several times to have more than one rich language rule entry.

The general rule structure:

.if n \{.RS 4
.\}
    <rule [family="ipv4|ipv6"]>
      [ <source address="address[/mask]" [invert="True"]/> ]
      [ <destination address="address[/mask]" [invert="True"]/> ]
      [
        <service name="string"/> |
        <port port="portid[-portid]" protocol="tcp|udp|sctp|dccp"/> |
        <protocol value="protocol"/> |
        <icmp-block name="icmptype"/> |
        <icmp-type name="icmptype"/> |
        <masquerade/> |
        <forward-port port="portid[-portid]" protocol="tcp|udp|sctp|dccp" [to-port="portid[-portid]"] [to-addr="address"]/> |
        <source-port port="portid[-portid]" protocol="tcp|udp|sctp|dccp"/> |
      ]
      [ <log [prefix="prefixtext"] [level="emerg|alert|crit|err|warn|notice|info|debug"]/> [<limit value="rate/duration"/>] </log> ]
      [ <audit> [<limit value="rate/duration"/>] </audit> ]
      [
        <accept> [<limit value="rate/duration"/>] </accept> |
        <reject [type="rejecttype"]> [<limit value="rate/duration"/>] </reject> |
        <drop> [<limit value="rate/duration"/>] </drop> |
        <mark set="mark[/mask]"> [<limit value="rate/duration"/>] </mark>
      ]
    
    </rule>
    	
.if n \{.RE
.\}

Rule structure for source black or white listing:

.if n \{.RS 4
.\}
    <rule [family="ipv4|ipv6"]>
      <source address="address[/mask]" [invert="True"]/>
      [ <log [prefix="prefixtext"] [level="emerg|alert|crit|err|warn|notice|info|debug"]/> [<limit value="rate/duration"/>] </log> ]
      [ <audit> [<limit value="rate/duration"/>] </audit> ]
      <accept> [<limit value="rate/duration"/>] </accept> |
      <reject [type="rejecttype"]> [<limit value="rate/duration"/>] </reject> |
      <drop> [<limit value="rate/duration"/>] </drop>
    </rule>
    	
.if n \{.RE
.\}

For a full description on rich language rules, please have a look at
**firewalld.richlanguage**(5).

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
