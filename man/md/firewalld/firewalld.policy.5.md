# firewalld\&.policy(5)

firewalld 0.9.1, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.policy - firewalld policy configuration files

<a name="synopsis"></a>

# Synopsis

```

 /usr/etc/firewalld/policies/policy.xml 
 /usr/lib/firewalld/policies/policy.xml
```

<a name="description"></a>

# Description


A firewalld policy configuration file contains the information for a policy. These are the policy descriptions, services, ports, protocols, icmp-blocks, masquerade, forward-ports and rich language rules in an XML file format. The file name has to be
_policy\_name_.xml where length of
_policy\_name_
is currently limited to 17 chars.

This is the structure of a policy configuration file:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <policy [version="versionstring"] [target="CONTINUE|ACCEPT|REJECT|DROP"] [priority="priority"]>
        [ <ingress-zone name="zone"/> ]
        [ <egress-zone name="zone"/> ]
    
        
    
    
    
        [ <short>short description</short> ]
        [ <description>description</description> ]
        [ <service name="string"/> ]
        [ <port port="portid[-portid]" protocol="tcp|udp|sctp|dccp"/> ]
        [ <protocol value="protocol"/> ]
        [ <icmp-block name="string"/> ]
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
    
    
    </policy>
                
.if n \{.RE
.\}

The config can contain these tags and attributes. Some of them are mandatory, others optional.

<a name="policy"></a>

### policy


The mandatory policy start and end tag defines the policy. This tag can only be used once in a policy configuration file. There are optional attributes for policy:

version="_string_"
To give the policy a version.

target="_CONTINUE__ACCEPT_|_REJECT_|_DROP_"
Can be used to accept, reject or drop every packet that doesnt match any rule (port, service, etc.). The
_CONTINUE_
is the default and used for policies that an non-terminal.

<a name="ingress-zone"></a>

### ingress\-zone


An optional element that can be used several times. It can be the name of a firewalld zone or one of the symbolic zones: HOST, ANY. See
**firewalld.policies**(5)
for information about symbolic zones.

<a name="egress-zone"></a>

### egress\-zone


An optional element that can be used several times. It can be the name of a firewalld zone or one of the symbolic zones: HOST, ANY. See
**firewalld.policies**(5)
for information about symbolic zones.

<a name="short"></a>

### short


Is an optional start and end tag and is used to give a more readable name.

<a name="description"></a>

### description


Is an optional start and end tag to have a description.

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

<a name="masquerade"></a>

### masquerade


Is an optional empty-element tag. It can be used only once. If its present masquerading is enabled.

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

**firewall-applet**(1), **firewalld**(1), **firewall-cmd**(1), **firewall-config**(1), **firewalld.conf**(5), **firewalld.direct**(5), **firewalld.dbus**(5), **firewalld.icmptype**(5), **firewalld.lockdown-whitelist**(5), **firewall-offline-cmd**(1), **firewalld.richlanguage**(5), **firewalld.service**(5), **firewalld.zone**(5), **firewalld.zones**(5), **firewalld.policy**(5), **firewalld.policies**(5), **firewalld.ipset**(5), **firewalld.helper**(5)

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
