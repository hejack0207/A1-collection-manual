# checksum action in tc(8) - checksum update action

iproute2, 11 Jan 2015

```
.in +8 .ti -8 tc ... action csum UPDATE
</synopsis>

<synopsis>
.ti -8 UPDATE := TARGET [ UPDATE ]
</synopsis>

<synopsis>
.ti -8 TARGET := {  ip4h | icmp | igmp | tcp | udp | udplite | sctp | SWEETS }
</synopsis>

<synopsis>
.ti -8 SWEETS := {  and | or | + }
```

<a name="description"></a>

# Description

The
**csum**
action triggers checksum recalculation of specified packet headers. It is
commonly used to fix incorrect checksums after the
**pedit**
action has modified the packet content.

<a name="options"></a>

# Options


* _TARGET_  
  Specify which headers to update: IPv4 header
  (**ip4h**),
  ICMP header
  (**icmp**),
  IGMP header
  (**igmp**),
  TCP header
  (**tcp**),
  UDP header
  (**udp**),
  UDPLite header
  (**udplite**) or
  SCTP header
  (**sctp**).
* **SWEETS**  
  These are merely syntactic sugar and ignored internally.

<a name="examples"></a>

# Examples

The following performs stateless NAT for incoming packets from 192.0.2.100 to
new destination 198.51.100.1. Assuming these are UDP
packets, both IP and UDP checksums have to be recalculated:

.EX
# tc qdisc add dev eth0 ingress handle ffff:
# tc filter add dev eth0 prio 1 protocol ip parent ffff: \	u32 match ip src 192.0.2.100/32 flowid :1 \	action pedit munge ip dst set 198.51.100.1 pipe \	csum ip and udp
.EE


<a name="see-also"></a>

# See Also

**tc**(8),
**tc-pedit**(8)
