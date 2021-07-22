# veth(4) - Virtual Ethernet Device

Linux, 2018-02-02


<a name="description"></a>

# Description

The
**veth**
devices are virtual Ethernet devices.
They can act as tunnels between network namespaces to create
a bridge to a physical network device in another namespace,
but can also be used as standalone network devices.

**veth**
devices are always created in interconnected pairs.
A pair can be created using the command:

.in +4n
.EX
# ip link add &lt;p1-name&gt; type veth peer name &lt;p2-name&gt;
.EE
.in

In the above,
_p1-name_
and
_p2-name_
are the names assigned to the two connected end points.

Packets transmitted on one device in the pair are immediately received on
the other device.
When either devices is down the link state of the pair is down.

**veth**
device pairs are useful for combining the network
facilities of the kernel together in interesting ways.
A particularly interesting use case is to place one end of a
**veth**
pair in one network namespace and the other end in another network namespace,
thus allowing communication between network namespaces.
To do this, one first creates the
**veth**
device as above and then moves one side of the pair to the other namespace:

.in +4n
.EX
# ip link set &lt;p2-name&gt; netns &lt;p2-namespace&gt;
.EE
.in

**ethtool**(8)
can be used to find the peer of a
**veth**
network interface, using commands something like:

.in +4n
.EX
# **ip link add ve_A type veth peer name ve\_B**   # Create veth pair
# **ethtool -S ve\_A**         # Discover interface index of peer
NIC statistics:
     peer_ifindex: 16
# **ip link | grep '^16:'**   # Look up interface
16: ve_B@ve_A: &lt;BROADCAST,MULTICAST,M-DOWN&gt; mtu 1500 qdisc ...
.EE
.in


<a name="see-also"></a>

# See Also

**clone**(2),
**network_namespaces**(7),
**ip**(8),
**ip-link**(8),
**ip-netns**(8)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
