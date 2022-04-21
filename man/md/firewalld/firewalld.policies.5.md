# firewalld\&.policies(5)

firewalld 0.9.1, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

firewalld.policies - firewalld policies

<a name="description"></a>

# Description


<a name="what-is-a-policy"></a>

### What is a policy?


A policy applies a set of rules to traffic flowing between between zones (see zones (see
**firewalld.zones**(5)). The policy affects traffic in a stateful unidirectional manner, e.g. zoneA to zoneB. This allows asynchronous filtering policies.

A policys relationship to zones is defined by assigning assigning a set set of ingress zones and a set of egress zones. For example, if the set of ingress zones "public" and the set of egress zones contains "internal" then the policy will affect all traffic flowing from the "public" zone to the "internal" zone. However, since policies are unidirectional it will not apply to traffic flowing from "internal" to "public". Note that the ingress set and egress set can contain multiple zones.

<a name="active-policies"></a>

### Active Policies


Policies only become active if all of the following are true.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The ingress zones list contain at least one regular zone or a single symbolic zone.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The egress zones list contain at least one regular zone or a single symbolic zone.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  For non symbolic zones, the zone must be active. That is, it must have interfaces or sources assigned to it.

If the policy is not active then the policy has no effect.

<a name="symbolic-zones"></a>

### Symbolic Zones


Regular zones are not enough to express every form of packet filtering. For example there is no zone to represent traffic flowing to or from the host running firewalld. As such, there are some symbolic zones to fill these gaps. However, symbolic zones are unique in that theyre the only zone allowed in the ingress or egress zone sets. For example, you cannot use "public" and "HOST" in the ingress zones.

Symbolic zones:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  HOST

This symbolic zone is for traffic flowing to or from the host running firewalld. This corresponds to netfilter (iptables/nftables) chains INPUT and OUTPUT.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If used in the egress zones list it will apply to traffic on the INPUT chain.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If used in the ingress zones list it will apply to traffic on the OUTPUT chain.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  ANY

This symbolic zone behaves like a wildcard for the ingress and egress zones. With the exception that it does not include "HOST". Its useful if you want a policy to apply to every zone.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If used in the ingress zones list it will apply for traffic originating from any zone.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If used in the egress zones list it will apply for traffic destined to any zone.

<a name="predefined-policies"></a>

### Predefined Policies


firewalld ships with some predefined policies. These may or may not be active by default. For details see the description of each policy.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  allow-host-ipv6

<a name="similarity-to-zones"></a>

### Similarity to Zones


Policies are similar to zones in that they are an attachment point for firewallds primitives: services, ports, forward ports, etc. This is not a coincidence. Policies are a generalization of how zones have traditionally achieved filtering. In fact, in modern firewalld zones are internally implemented as a set of policies.

The main difference between policies and zones is that policies allow filtering in all directions: input, output, and forwarding. With a couple of exceptions zones only allow input filtering which is sufficient for an end station firewalling. However, for network level filtering or filtering on behalf of virtual machines and containers something more flexible, i.e. policies, are needed.

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
