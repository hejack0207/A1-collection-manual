# firewalld\&.direct(5)

firewalld 0.8.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.direct - firewalld direct configuration file

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    /etc/firewalld/direct.xml
          
<synopsis>


```

<a name="description"></a>

# Description


Direct configuration gives a more direct access to the firewall. It requires user to know basic ip(6)tables/ebtables concepts, i.e.
_table_
(filter/mangle/nat/...),
_chain_
(INPUT/OUTPUT/FORWARD/...),
_commands_
(-A/-D/-I/...),
_parameters_
(-p/-s/-d/-j/...) and
_targets_
(ACCEPT/DROP/REJECT/...). Direct configuration should be used only as a last resort when its not possible to use
**firewalld.zone**(5). See also
_Direct Options_
in
**firewall-cmd**(1).

A firewalld direct configuration file contains informations about permanent direct chains, rules and passthrough ...

This is the structure of a direct configuration file:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <direct>
      [ <chain ipv="ipv4|ipv6|eb" table="table" chain="chain"/> ]
      [ <rule ipv="ipv4|ipv6|eb" table="table" chain="chain" priority="priority"> args </rule> ]
      [ <passthrough ipv="ipv4|ipv6|eb"> args </passthrough> ]
    </direct>
          
.if n \{.RE
.\}


<a name="direct"></a>

### direct


The mandatory direct start and end tag defines the direct. This tag can only be used once in a direct configuration file. There are no attributes for direct.

<a name="chain"></a>

### chain


Is an optional empty-element tag and can be used several times. It can be used to define names for additional chains. A chain entry has exactly three attributes:

ipv="_ipv4_|_ipv6_|_eb_"
The IP family where the chain will be created. This can be either
_ipv4_,
_ipv6_
or
_eb_.

table="_table_"
The table name where the chain will be created. This can be one of the tables that can be used for iptables, ip6tables or ebtables. For the possible values, see TABLES section in the iptables, ip6tables or ebtables man pages.

chain="_chain_"
The name of the chain, that will be created. Please make sure that there is no other chain with this name already.

Please remember to add a rule or passthrough rule with an
**--jump**
or
**--goto**
option to connect the chain to another one.

<a name="rule"></a>

### rule


Is an optional element tag and can be used several times. It can be used to add rules to a built-in or added chain. A rule entry has exactly four attributes:

ipv="_ipv4_|_ipv6_|_eb_"
The IP family where the rule will be added. This can be either
_ipv4_,
_ipv6_
or
_eb_.

table="_table_"
The table name where the rule will be added. This can be one of the tables that can be used for iptables, ip6tables or ebtables. For the possible values, see TABLES section in the iptables, ip6tables or ebtables man pages.

chain="_chain_"
The name of the chain where the rule will be added. This can be either a built-in chain or a chain that has been created with the chain tag. If the chain name is a built-in chain, then the rule will be added to
_chain__direct, else the supplied chain name is used.
_chain__direct is created internally for all built-in chains to make sure that the added rules do not conflict with the rules created by firewalld.

priority="_priority_"
The priority is used to order rules. Priority 0 means add rule on top of the chain, with a higher priority the rule will be added further down. Rules with the same priority are on the same level and the order of these rules is not fixed and may change. If you want to make sure that a rule will be added after another one, use a low priority for the first and a higher for the following.

The
_args_
can be any arguments of iptables or ip6tables, that do not conflict with the table or chain attributes.

<a name="passthrough"></a>

### passthrough


Is an optional element tag and can be used several times. It can be used to add rules to a built-in or added chain. A rule entry has exactly one attribute:

ipv="_ipv4_|_ipv6_|_eb_"
The IP family where the passthrough rule will be added. This can be either
_ipv4_,
_ipv6_
or
_eb_.

The
_args_
can be any arguments of iptables or ip6tables.

The passthrough rule will be added to the chain directly. There is no mechanism like for the direct
**rule**
above. The user of the passthrough rule has to make sure that there will be no conflict with the rules created by firewalld.

<a name="caveats"></a>

# Caveats


Depending on the value of
_FirewallBackend_
(see
**firewalld.conf**(5)) direct rules behave differently in some scenarios.

<a name="packet-acceptdrop-precedence"></a>

### Packet accept/drop precedence


Due to implementation details of netfilter inside the kernel, if
_FirewallBackend=nftables_
is used direct rules that
_ACCEPT_
packets dont actually cause the packets to be immediately accepted by the system. Those packets are still be subject to firewalld\*(Aqs nftables ruleset. This basically means there are two independent firewalls and packets must be accepted by both (iptables and nftables). As an aside, this scenario also occurs inside of nftables (again due to netfilter) if there are multiple chains attached to the same hook - it\*(Aqs not as simple as iptables vs nftables.

There are a handful of options to workaround the
_ACCEPT_
issue:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Rich Rules

If a rich rule can be used, then they should always be preferred over direct rules. Rich Rules will be converted to the enabled
_FirewallBackend_. See
**firewalld.richlanguage**(5).

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Blanket Accept

Users can add an explicit accept to the nftables ruleset. This can be done by adding the interface or source to the
_trusted_
zone.

This strategy is often employed by things that perform their own filtering such as: libvirt, podman, docker.

**Warning**: This means firewalld will do no filtering on these packets. It must all be done via direct rules or out-of-band iptables rules.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Selective Accept

Alternatively, enable only the relevant service, port, address, or otherwise in the appropriate zone.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  Revert to the iptables backend

A last resort is to revert to the iptables backend by setting
_FirewallBackend=iptables_. Users should be aware that firewalld development focuses on the nftables backend.

For direct rules that
_DROP_
packets the packets are immediately dropped regardless of the value of
_FirewallBackend_. As such, there is no special consideration needed.

Firewalld guarantees the above ACCEPT/DROP behavior by registering nftables hooks with a lower precedence than iptables hooks.

<a name="direct-interface-precedence"></a>

### Direct interface precedence


With
_FirewallBackend=iptables_
firewallds top-level internal rules apply before direct rules are executed. This includes rules to accept existing connections. In the past this has surprised users. As an example, if a user adds a direct rule to drop traffic on destination port 22 existing SSH sessions would continue to function, but new connections would be denied.

With
_FirewallBackend=nftables_
direct rules were deliberately given a higher precedence than all other firewalld rules. This includes rules to accept existing connections.

<a name="example"></a>

# Example


Denylisting of the networks 192.168.1.0/24 and 192.168.5.0/24 with logging and dropping early in the raw table:

.if n \{.RS 4
.\}
    <?xml version="1.0" encoding="utf-8"?>
    <direct>
      <chain ipv="ipv4" table="raw" chain="denylist"/>
      <rule ipv="ipv4" table="raw" chain="PREROUTING" priority="0">-s 192.168.1.0/24 -j denylist</rule>
      <rule ipv="ipv4" table="raw" chain="PREROUTING" priority="1">-s 192.168.5.0/24 -j denylist</rule>
      <rule ipv="ipv4" table="raw" chain="denylist" priority="0">-m limit --limit 1/min -j LOG --log-prefix "denylisted: "</rule>
      <rule ipv="ipv4" table="raw" chain="denylist" priority="1">-j DROP</rule>
    </direct>
          
.if n \{.RE
.\}


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
