# firewalld\&.helper(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.helper - firewalld helper configuration files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    /etc/firewalld/helpers/helper.xml
    /usr/lib/firewalld/helpers/helper.xml
          
<synopsis>


```

<a name="description"></a>

# Description


A firewalld helper configuration file provides the information of a helper entry for firewalld. The most important configuration options are ports, family and module.

This example configuration file shows the structure of a helper configuration file:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <helper module="nf_conntrack_module" [family="ipv4|ipv6"]>
      <short>short</short>
      <description>description</description>
      <port portid[-portid]" protocol="tcp|udp|sctp|dccp"/>
    </helper>
          
.if n \{.RE
.\}


<a name="options"></a>

# Options


The config can contain these tags and attributes. Some of them are mandatory, others optional.

<a name="helper"></a>

### helper


The mandatory helper start and end tag defines the helper. This tag can only be used once in a helper configuration file. There is one mandatory and also optional attributes for helper:

module="_string_"
The mandatory module of the helper. This is one of the netfilter conntrack helper modules. The name starts with
_nf\_conntrack\__.

family="_ipv4_|_ipv6_"
The optional family of the helper. This can be one of these ipv types:
_ipv4_
or
_ipv6_. If the family is not specified, then the helper is usable for
_IPv4_
and
_IPv6_.

version="_string_"
To give the helper a version.

<a name="short"></a>

### short


Is an optional start and end tag and is used to give a helper a more readable name.

<a name="description"></a>

### description


Is an optional start and end tag to have a description for a helper.

<a name="port"></a>

### port


Is an mandatory empty-element tag and can be used several times to have more than one port entry. All attributes of a port entry are mandatory:

port="_string_"
The port
_string_
can be a single port number or a port range
_portid_-_portid_
or also empty to match a protocol only.

protocol="_string_"
The protocol value can either be
**tcp**,
**udp**,
**sctp**
or
**dccp**.

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
