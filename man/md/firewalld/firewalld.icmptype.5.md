# firewalld\&.icmptype(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.icmptype - firewalld icmptype configuration files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    /etc/firewalld/icmptypes/icmptype.xml
    /usr/lib/firewalld/icmptypes/icmptype.xml
          
<synopsis>


```

<a name="description"></a>

# Description


A firewalld icmptype configuration file provides the information for an Internet Control Message Protocol (ICMP) type for firewalld.

This example configuration file shows the structure of an icmptype configuration file:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <icmptype>
      <short>My Icmptype</short>
      <description>description</description>
      <destination ipv4="yes" ipv6="yes"/>
    </icmptype>
          
.if n \{.RE
.\}


<a name="options"></a>

# Options


The config can contain these tags and attributes. Some of them are mandatory, others optional.

<a name="icmptype"></a>

### icmptype


The mandatory icmptype start and end tag defines the icmptype. This tag can only be used once in an icmptype configuration file. This tag has optional attributes:

version="_string_"
To give the icmptype a version.

<a name="short"></a>

### short


Is an optional start and end tag and is used to give an icmptype a more readable name.

<a name="description"></a>

### description


Is an optional start and end tag to have a description for a icmptype.

<a name="destination"></a>

### destination


Is an optional empty-element tag and can be used only once. The destination tag specifies if an icmptype entry is available for IPv4 and/or IPv6. The default is IPv4 and IPv6, where this tag can be missing.

ipv4="_bool_"
Describes if the icmptype is available for IPv4.

ipv6="_bool_"
Describes if the icmptype is available for IPv6.

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
