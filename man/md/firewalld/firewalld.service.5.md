# firewalld\&.service(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.service - firewalld service configuration files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    /etc/firewalld/services/service.xml
    /usr/lib/firewalld/services/service.xml
          
<synopsis>


```

<a name="description"></a>

# Description


A firewalld service configuration file provides the information of a service entry for firewalld. The most important configuration options are ports, modules and destination addresses.

This example configuration file shows the structure of a service configuration file:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <service>
      <short>My Service</short>
      <description>description</description>
      <port port="137" protocol="tcp"/>
      <protocol value="igmp"/>
      <module name="nf_conntrack_netbios_ns"/>
      <destination ipv4="224.0.0.251" ipv6="ff02::fb"/>
      <include service="ssdp"/>
      <helper name="ftp"/>
    </service>
          
.if n \{.RE
.\}


<a name="options"></a>

# Options


The config can contain these tags and attributes. Some of them are mandatory, others optional.

<a name="service"></a>

### service


The mandatory service start and end tag defines the service. This tag can only be used once in a service configuration file. There are optional attributes for services:

version="_string_"
To give the service a version.

<a name="short"></a>

### short


Is an optional start and end tag and is used to give an service a more readable name.

<a name="description"></a>

### description


Is an optional start and end tag to have a description for a service.

<a name="port"></a>

### port


Is an optional empty-element tag and can be used several times to have more than one port entry. All attributes of a port entry are mandatory:

port="_string_"
The port
_string_
can be a single port number or a port range
_portid_-_portid_
or also empty to match a protocol only.

protocol="_string_"
The protocol value can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

For compatibility with older firewalld versions, it is possible to add protocols with the port option where the port is empty. With the addition of native protocol support in the service, this it not needed anymore. These entries will automatically be converted to protocols. With the next modification of the service file, the enries will be listed as protocols.

<a name="protocol"></a>

### protocol


Is an optional empty-element tag and can be used several times to have more than one protocol entry. A protocol entry has exactly one attribute:

value="_string_"
The protocol can be any protocol supported by the system. Please have a look at
_/etc/protocols_
for supported protocols.

<a name="source-port"></a>

### source\-port


Is an optional empty-element tag and can be used several times to have more than one source port entry. All attributes of a source port entry are mandatory:

port="_string_"
The port
_string_
can be a single port number or a port range
_portid_-_portid_.

protocol="_string_"
The protocol value can either be
_tcp_,
_udp_,
_sctp_
or
_dccp_.

<a name="module"></a>

### module


This element is deprecated. Please use helper described below in
the section called “helper”.

<a name="destination"></a>

### destination


Is an optional empty-element tag and can be used only once. The destination specifies the destination network as a network IP address (optional with /mask), or a plain IP address. The use of hostnames is not recommended, because these will only be resolved at service activation and transmitted to the kernel. For more information in this element, please have a look at
**--destination**
in
**iptables**(8)
and
**ip6tables**(8).

ipv4="_address_[/_mask_]"
The IPv4 destination address with optional mask.

ipv6="_address_[/_mask_]"
The IPv6 destination address with optional mask.

<a name="include"></a>

### include


Is an optional empty-element tag and can be used several times to have more than one include entry. An include entry has exactly one attribute:

service="_string_"
The include can be any service supported by firewalld.

**Warning:**Firewalld will only check that the included
_service_
is a valid service if its applied to a zone.

<a name="helper"></a>

### helper


Is an optional empty-element tag and can be used several times to have more than one helper entry. An helper entry has exactly one attribute:

name="_string_"
The helper can be any helper supported by firewalld.

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
