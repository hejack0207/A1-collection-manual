# firewalld\&.ipset(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.ipset - firewalld ipset configuration files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    /etc/firewalld/ipsets/ipset.xml
    /usr/lib/firewalld/ipsets/ipset.xml
          
<synopsis>


```

<a name="description"></a>

# Description


A firewalld ipset configuration file provides the information of an ip set for firewalld. The most important configuration options are type, option and entry.

This example configuration file shows the structure of an ipset configuration file:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <ipset type="hash:ip">
      <short>My Ipset</short>
      <description>description</description>
      <entry>1.2.3.4</entry>
      <entry>1.2.3.5</entry>
      <entry>1.2.3.6</entry>
    </ipset>
          
.if n \{.RE
.\}


<a name="options"></a>

# Options


The config can contain these tags and attributes. Some of them are mandatory, others optional.

<a name="ipset"></a>

### ipset


The mandatory ipset start and end tag defines the ipset. This tag can only be used once in a ipset configuration file. There is one mandatory and also optional attributes for ipsets:

type="_string_"
The mandatory type of the ipset. To get the list of supported types, use
**firewall-cmd --get-ipset-types**.

version="_string_"
To give the ipset a version.

<a name="short"></a>

### short


Is an optional start and end tag and is used to give an ipset a more readable name.

<a name="description"></a>

### description


Is an optional start and end tag to have a description for a ipset.

<a name="option"></a>

### option


Is an optional empty-element tag and can be used several times to have more than one option. Mostly all attributes of an option entry are mandatory:

name="_string_"
The mandatory option name
_string_.

value="_string_"
The optional value of the option.

The supported options are: family:
_"inet"_|_"inet6"_, timeout:
_integer_, hashsize:
_integer_, maxelem:
_integer_. For more information on these options, please have a look at the ipset documentation.

<a name="entry"></a>

### entry


Is an optional start and end tag and can be used several times to have more than one entry entry. An entry entry does not have attributes.

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
