# ip\-link(8) - network device configuration

iproute2, 13 Dec 2012

```

 .in +8 .ti -8 ip link  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 ip link add [ link DEVICE ] [ name ] NAME
[ txqueuelen PACKETS ]
[ address LLADDR ] [ broadcast LLADDR ]
[ mtu MTU ] [ index IDX ]
[ numtxqueues QUEUE_COUNT ] [ numrxqueues QUEUE_COUNT ]
[ gso_max_size BYTES ] [ gso_max_segs SEGMENTS ]
type TYPE [ ARGS ]
</synopsis>

<synopsis>
.ti -8 ip link delete { DEVICE |  group GROUP } type TYPE [ ARGS ]
</synopsis>

<synopsis>
.ti -8 ip link set { DEVICE |  group GROUP }
[ { up | down } ]
[ type ETYPE TYPE_ARGS ]
[ arp { on | off } ]
[ dynamic { on | off } ]
[ multicast { on | off } ]
[ allmulticast { on | off } ]
[ promisc { on | off } ]
[ protodown { on | off } ]
[ trailers { on | off } ]
[ txqueuelen PACKETS ]
[ name NEWNAME ]
[ address LLADDR ]
[ broadcast LLADDR ]
[ mtu MTU ]
[ netns { PID | NETNSNAME } ]
[ link-netnsid ID ]
[ alias NAME ]
[ vf NUM [  mac LLADDR ]
.in +9 [ VFVLAN-LIST ]
[ rate TXRATE ]
[ max_tx_rate TXRATE ]
[ min_tx_rate TXRATE ]
[ spoofchk { on | off } ]
[ query_rss { on | off } ]
[ state { auto | enable | disable } ]
[ trust { on | off } ]
[ node_guid eui64 ]
[ port_guid eui64 ] ]
.in -9 [ { xdp | xdpgeneric | xdpdrv | xdpoffload } { off |
.in +8 object FILE [ section NAME ] [ verbose ] |
pinned FILE } ]
.in -8 [ master DEVICE ]
[ nomaster ]
[ vrf NAME ]
[ addrgenmode { eui64 | none | stable_secret | random } ]
[ macaddr { flush | { add | del }  MACADDR | set [  MACADDR [  MACADDR [ ... ] ] ] } ]

</synopsis>

<synopsis>
.ti -8 ip link show [ DEVICE |  group GROUP ] [ up ] [ master DEVICE ] [ type ETYPE ] [ vrf NAME ]
</synopsis>

<synopsis>
.ti -8 ip link xstats type TYPE [ ARGS ]
</synopsis>

<synopsis>
.ti -8 ip link afstats [ dev DEVICE ]
</synopsis>

<synopsis>
.ti -8 ip link help [ TYPE ]
</synopsis>

<synopsis>
.ti -8 TYPE := [  bridge |  bond |  can |  dummy |  hsr |  ifb |  ipoib | macvlan |  macvtap |  vcan |  vxcan |  veth |  vlan |  vxlan | ip6tnl | ipip | sit | gre | gretap | erspan | ip6gre | ip6gretap | ip6erspan | vti | nlmon | ipvlan | ipvtap | lowpan | geneve | vrf | macsec | netdevsim | rmnet ]
</synopsis>

<synopsis>
.ti -8 ETYPE := [ TYPE | bridge_slave | bond_slave ]
</synopsis>

<synopsis>
.ti -8 VFVLAN-LIST := [ VFVLAN-LIST ] VFVLAN
</synopsis>

<synopsis>
.ti -8 VFVLAN :=  [ vlan VLANID [  qos VLAN-QOS ] [ proto VLAN-PROTO ] ]
```


<a name="description"></a>

# Description


<a name="ip-link-add-add-virtual-link"></a>

### ip link add - add virtual link



* **link**_ DEVICE _  
  specifies the physical device to act operate on.
  
  _NAME_
  specifies the name of the new virtual device.
  
  _TYPE_
  specifies the type of the new device.

Link types:

.in +8
**bridge**
- Ethernet Bridge device

**bond**
- Bonding device

**dummy**
- Dummy network interface

**hsr**
- High-availability Seamless Redundancy device

**ifb**
- Intermediate Functional Block device

**ipoib**
- IP over Infiniband device

**macvlan**
- Virtual interface base on link layer address (MAC)

**macvtap**
- Virtual interface based on link layer address (MAC) and TAP.

**vcan**
- Virtual Controller Area Network interface

**vxcan**
- Virtual Controller Area Network tunnel interface

**veth**
- Virtual ethernet interface

**vlan**
- 802.1q tagged virtual LAN interface

**vxlan**
- Virtual eXtended LAN

**ip6tnl**
- Virtual tunnel interface IPv4|IPv6 over IPv6

**ipip**
- Virtual tunnel interface IPv4 over IPv4

**sit**
- Virtual tunnel interface IPv6 over IPv4

**gre**
- Virtual tunnel interface GRE over IPv4

**gretap**
- Virtual L2 tunnel interface GRE over IPv4

**erspan**
- Encapsulated Remote SPAN over GRE and IPv4

**ip6gre**
- Virtual tunnel interface GRE over IPv6

**ip6gretap**
- Virtual L2 tunnel interface GRE over IPv6

**ip6erspan**
- Encapsulated Remote SPAN over GRE and IPv6

**vti**
- Virtual tunnel interface

**nlmon**
- Netlink monitoring device

**ipvlan**
- Interface for L3 (IPv6/IPv4) based VLANs

**ipvtap**
- Interface for L3 (IPv6/IPv4) based VLANs and TAP

**lowpan**
- Interface for 6LoWPAN (IPv6) over IEEE 802.15.4 / Bluetooth

**geneve**
- GEneric NEtwork Virtualization Encapsulation

**macsec**
- Interface for IEEE 802.1AE MAC Security (MACsec)

**vrf**
- Interface for L3 VRF domains

**netdevsim**
- Interface for netdev API tests

**rmnet**
- Qualcomm rmnet device
.in -8


* **numtxqueues**_ QUEUE_COUNT _  
  specifies the number of transmit queues for new device.
  
* **numrxqueues**_ QUEUE_COUNT _  
  specifies the number of receive queues for new device.
  
* **gso_max_size**_ BYTES _  
  specifies the recommended maximum size of a Generic Segment Offload packet the new device should accept.
  
* **gso_max_segs**_ SEGMENTS _  
  specifies the recommended maximum number of a Generic Segment Offload segments the new device should accept.
  
* **index**_ IDX _  
  specifies the desired index of the new virtual device. The link creation fails, if the index is busy.
  
* VLAN Type Support  
  For a link of type
  _VLAN_
  the following additional arguments are supported:
  
  **ip**_link_**add**
  **link**_ DEVICE _
  **name**_ NAME _
  **type vlan**
  [
  **protocol**_ VLAN_PROTO _
  ]
  **id**_ VLANID _
  [
  **reorder_hdr** { **on** | **off** } 
  ]
  [
  **gvrp** { **on** | **off** } 
  ]
  [
  **mvrp** { **on** | **off** } 
  ]
  [
  **loose_binding** { **on** | **off** } 
  ]
  [
  **ingress-qos-map**_ QOS-MAP _
  ]
  [
  **egress-qos-map**_ QOS-MAP _
  ]
  
  .in +8

**protocol**_ VLAN_PROTO _
- either 802.1Q or 802.1ad.

**id**_ VLANID _
- specifies the VLAN Identifer to use. Note that numbers with a leading " 0 " or " 0x " are interpreted as octal or hexadeimal, respectively.

**reorder_hdr** { **on** | **off** } 
- specifies whether ethernet headers are reordered or not (default is
**on**).

.in +4
If
**reorder_hdr** is **on**
then VLAN header will be not inserted immediately but only before passing to the
physical device (if this device does not support VLAN offloading), the similar
on the RX direction - by default the packet will be untagged before being
received by VLAN device. Reordering allows to accelerate tagging on egress and
to hide VLAN header on ingress so the packet looks like regular Ethernet packet,
at the same time it might be confusing for packet capture as the VLAN header
does not exist within the packet.

VLAN offloading can be checked by
**ethtool**(8):
.in +4

**ethtool -k**
&lt;phy_dev&gt; |
grep** tx-vlan-offload**

.in -4
where &lt;phy_dev&gt; is the physical device to which VLAN device is bound.
.in -4

**gvrp** { **on** | **off** } 
- specifies whether this VLAN should be registered using GARP VLAN Registration Protocol.

**mvrp** { **on** | **off** } 
- specifies whether this VLAN should be registered using Multiple VLAN Registration Protocol.

**loose_binding** { **on** | **off** } 
- specifies whether the VLAN device state is bound to the physical device state.

**ingress-qos-map**_ QOS-MAP _
- defines a mapping of VLAN header prio field to the Linux internal packet
priority on incoming frames. The format is FROM:TO with multiple mappings
separated by spaces.

**egress-qos-map**_ QOS-MAP _
- defines a mapping of Linux internal packet priority to VLAN header prio field
but for outgoing frames. The format is the same as for ingress-qos-map.
.in +4

Linux packet priority can be set by
**iptables**(8)**:**
.in +4

**iptables**
-t mangle -A POSTROUTING [...] -j CLASSIFY --set-class 0:4

.in -4
and this "4" priority can be used in the egress qos mapping to set VLAN prio "5":

.in +4
**ip**
link set veth0.10 type vlan egress 4:5
.in -4
.in -4
.in -8


* VXLAN Type Support  
  For a link of type
  _VXLAN_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_
  **type**_ vxlan _**id**_ VNI_
  [
  **dev**_ PHYS_DEV _
   ] [ { **group** | **remote** } 
  _IPADDR_
  ] [
  **local**
  { _IPADDR_ | _any_ } 
  ] [
  **ttl**_ TTL _
  ] [
  **tos**_ TOS _
  ] [
  **df**_ DF _
  ] [
  **flowlabel**_ FLOWLABEL _
  ] [
  **dstport**_ PORT _
  ] [
  **srcport**_ MIN MAX _
  ] [
  [**no**]**learning**
  ] [
  [**no**]**proxy**
  ] [
  [**no**]**rsc**
  ] [
  [**no**]**l2miss**
  ] [
  [**no**]**l3miss**
  ] [
  [**no**]**udpcsum**
  ] [
  [**no**]**udp6zerocsumtx**
  ] [
  [**no**]**udp6zerocsumrx**
  ] [
  **ageing**_ SECONDS _
  ] [
  **maxaddress**_ NUMBER _
  ] [
  [**no**]**external**
  ] [
  **gbp**
  ] [
  **gpe**
  ]
  
  .in +8

**id**_ VNI _
- specifies the VXLAN Network Identifer (or VXLAN Segment
Identifier) to use.

**dev**_ PHYS_DEV_
- specifies the physical device to use for tunnel endpoint communication.


**group**_ IPADDR_
- specifies the multicast IP address to join.
This parameter cannot be specified with the
**remote**
parameter.


**remote**_ IPADDR_
- specifies the unicast destination IP address to use in outgoing packets
when the destination link layer address is not known in the VXLAN device
forwarding database. This parameter cannot be specified with the
**group**
parameter.


**local**_ IPADDR_
- specifies the source IP address to use in outgoing packets.


**ttl**_ TTL_
- specifies the TTL value to use in outgoing packets.


**tos**_ TOS_
- specifies the TOS value to use in outgoing packets.


**df**_ DF_
- specifies the usage of the Don't Fragment flag (DF) bit in outgoing packets
with IPv4 headers. The value
**inherit**
causes the bit to be copied from the original IP header. The values
**unset**
and
**set**
cause the bit to be always unset or always set, respectively. By default, the
bit is not set.


**flowlabel**_ FLOWLABEL_
- specifies the flow label to use in outgoing packets.


**dstport**_ PORT_
- specifies the UDP destination port to communicate to the remote VXLAN tunnel endpoint.


**srcport**_ MIN MAX_
- specifies the range of port numbers to use as UDP
source ports to communicate to the remote VXLAN tunnel endpoint.


[**no**]**learning**
- specifies if unknown source link layer addresses and IP addresses
are entered into the VXLAN device forwarding database.


[**no**]**rsc**
- specifies if route short circuit is turned on.


[**no**]**proxy**
- specifies ARP proxy is turned on.


[**no**]**l2miss**
- specifies if netlink LLADDR miss notifications are generated.


[**no**]**l3miss**
- specifies if netlink IP ADDR miss notifications are generated.


[**no**]**udpcsum**
- specifies if UDP checksum is calculated for transmitted packets over IPv4.


[**no**]**udp6zerocsumtx**
- skip UDP checksum calculation for transmitted packets over IPv6.


[**no**]**udp6zerocsumrx**
- allow incoming UDP packets over IPv6 with zero checksum field.


**ageing**_ SECONDS_
- specifies the lifetime in seconds of FDB entries learnt by the kernel.


**maxaddress**_ NUMBER_
- specifies the maximum number of FDB entries.


[**no**]**external**
- specifies whether an external control plane
(e.g. **ip route encap**)
or the internal FDB should be used.


**gbp**
- enables the Group Policy extension (VXLAN-GBP).

.in +4
Allows to transport group policy context across VXLAN network peers.
If enabled, includes the mark of a packet in the VXLAN header for outgoing
packets and fills the packet mark based on the information found in the
VXLAN header for incoming packets.

Format of upper 16 bits of packet mark (flags);

.in +2
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+  
|-|-|-|-|-|-|-|-|-|D|-|-|A|-|-|-|  
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

**D :=**
Don't Learn bit. When set, this bit indicates that the egress
VTEP MUST NOT learn the source address of the encapsulated frame.

**A :=**
Indicates that the group policy has already been applied to
this packet. Policies MUST NOT be applied by devices when the A bit is set.
.in -2

Format of lower 16 bits of packet mark (policy ID):

.in +2
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+  
|        Group Policy ID        |  
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
.in -2

Example:
  iptables -A OUTPUT [...] -j MARK --set-mark 0x800FF

.in -4


**gpe**
- enables the Generic Protocol extension (VXLAN-GPE). Currently, this is
only supported together with the
**external**
keyword.

.in -8


* VETH, VXCAN Type Support  
  For a link of types
  _VETH/VXCAN_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_
  **type** { **veth** | **vxcan** }
  [
  **peer**
  **name **_NAME_
  ]
  
  .in +8

**peer**
**name **_NAME_
- specifies the virtual pair device name of the
_VETH/VXCAN_
tunnel.

.in -8


* IPIP, SIT Type Support  
  For a link of type
  _IPIP_or_SIT_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_
  **type** { **ipip** | **sit** }
  ** remote **_ADDR_** local **_ADDR_
  [
  **encap** { **fou** | **gue** | **none** }
  ] [
  **encap-sport** { **PORT** | **auto** }
  ] [
  **encap-dport **_PORT_
  ] [
  [**no**]**encap-csum**
  ] [
  _ [no]encap-remcsum _
  ] [
  _ mode  { ip6ip | ipip | mplsip | any }_
  ] [
  **external**
  ]
  
  .in +8

**remote**_ ADDR _
- specifies the remote address of the tunnel.


**local**_ ADDR _
- specifies the fixed local address for tunneled packets.
It must be an address on another interface on this host.


**encap** { **fou** | **gue** | **none** }
- specifies type of secondary UDP encapsulation. "fou" indicates
Foo-Over-UDP, "gue" indicates Generic UDP Encapsulation.


**encap-sport** { **PORT** | **auto** }
- specifies the source port in UDP encapsulation.
_PORT_
indicates the port by number, "auto"
indicates that the port number should be chosen automatically
(the kernel picks a flow based on the flow hash of the
encapsulated packet).


[**no**]**encap-csum**
- specifies if UDP checksums are enabled in the secondary
encapsulation.


[**no**]**encap-remcsum**
- specifies if Remote Checksum Offload is enabled. This is only
applicable for Generic UDP Encapsulation.


**mode**_ { ip6ip | ipip | mplsip | any } _
- specifies mode in which device should run. "ip6ip" indicates
IPv6-Over-IPv4, "ipip" indicates "IPv4-Over-IPv4", "mplsip" indicates
MPLS-Over-IPv4, "any" indicates IPv6, IPv4 or MPLS Over IPv4. Supported for
SIT where the default is "ip6ip" and IPIP where the default is "ipip".
IPv6-Over-IPv4 is not supported for IPIP.


**external**
- make this tunnel externally controlled
(e.g. **ip route encap**).

.in -8

* GRE Type Support  
  For a link of type
  _GRE_ or _GRETAP_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_
  **type** { **gre** | **gretap** }
  ** remote **_ADDR_** local **_ADDR_
  [
  [**no**]**""**[**i**|**o**]**seq**
  ] [
  [**i**|**o**]**key**
  _KEY_
  |
  **no**[**i**|**o**]**key**
  ] [
  [**no**]**""**[**i**|**o**]**csum**
  ] [
  **ttl**_ TTL _
  ] [
  **tos**_ TOS _
  ] [
  [**no**]**pmtudisc**
  ] [
  [**no**]**ignore-df**
  ] [
  **dev**_ PHYS_DEV _
  ] [
  **encap** { **fou** | **gue** | **none** }
  ] [
  **encap-sport** { **PORT** | **auto** }
  ] [
  **encap-dport **_PORT_
  ] [
  [**no**]**encap-csum**
  ] [
  [**no**]**encap-remcsum**
  ] [
  **external**
  ]
  
  .in +8

**remote**_ ADDR _
- specifies the remote address of the tunnel.


**local**_ ADDR _
- specifies the fixed local address for tunneled packets.
It must be an address on another interface on this host.


[**no**]**""**[**i**|**o**]**seq**
- serialize packets.
The
**oseq**
flag enables sequencing of outgoing packets.
The
**iseq**
flag requires that all input packets are serialized.


[**i**|**o**]**key**
_KEY_
|
**no**[**i**|**o**]**key**
- use keyed GRE with key
_KEY_. _KEY_
is either a number or an IPv4 address-like dotted quad.
The
**key**
parameter specifies the same key to use in both directions.
The
**ikey** and **okey**
parameters specify different keys for input and output.


[**no**]**""**[**i**|**o**]**csum**
- generate/require checksums for tunneled packets.
The
**ocsum**
flag calculates checksums for outgoing packets.
The
**icsum**
flag requires that all input packets have the correct
checksum. The
**csum**
flag is equivalent to the combination
**icsum ocsum .**


**ttl**_ TTL_
- specifies the TTL value to use in outgoing packets.


**tos**_ TOS_
- specifies the TOS value to use in outgoing packets.


[**no**]**pmtudisc**
- enables/disables Path MTU Discovery on this tunnel.
It is enabled by default. Note that a fixed ttl is incompatible
with this option: tunneling with a fixed ttl always makes pmtu
discovery.


[**no**]**ignore-df**
- enables/disables IPv4 DF suppression on this tunnel.
Normally datagrams that exceed the MTU will be fragmented; the presence
of the DF flag inhibits this, resulting instead in an ICMP Unreachable
(Fragmentation Required) message.  Enabling this attribute causes the
DF flag to be ignored.


**dev**_ PHYS_DEV_
- specifies the physical device to use for tunnel endpoint communication.


**encap** { **fou** | **gue** | **none** }
- specifies type of secondary UDP encapsulation. "fou" indicates
Foo-Over-UDP, "gue" indicates Generic UDP Encapsulation.


**encap-sport** { **PORT** | **auto** }
- specifies the source port in UDP encapsulation.
_PORT_
indicates the port by number, "auto"
indicates that the port number should be chosen automatically
(the kernel picks a flow based on the flow hash of the
encapsulated packet).


[**no**]**encap-csum**
- specifies if UDP checksums are enabled in the secondary
encapsulation.


[**no**]**encap-remcsum**
- specifies if Remote Checksum Offload is enabled. This is only
applicable for Generic UDP Encapsulation.


**external**
- make this tunnel externally controlled
(e.g. **ip route encap**).

.in -8


* IP6GRE/IP6GRETAP Type Support  
  For a link of type
  _IP6GRE/IP6GRETAP_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_
  **type** { **ip6gre** | **ip6gretap** }
  **remote**_ ADDR _**local**_ ADDR_
  [
  [**no**]**""**[**i**|**o**]**seq**
  ] [
  [**i**|**o**]**key**
  _KEY_
  |
  **no**[**i**|**o**]**key**
  ] [
  [**no**]**""**[**i**|**o**]**csum**
  ] [
  **hoplimit**_ TTL _
  ] [
  **encaplimit**_ ELIM _
  ] [
  **tclass**_ TCLASS _
  ] [
  **flowlabel**_ FLOWLABEL _
  ] [
  **dscp inherit**
  ] [
  **[no]allow-localremote**
  ] [
  **dev**_ PHYS_DEV _
  ] [
  external
  ]
  
  .in +8

**remote**_ ADDR _
- specifies the remote IPv6 address of the tunnel.


**local**_ ADDR _
- specifies the fixed local IPv6 address for tunneled packets.
It must be an address on another interface on this host.


[**no**]**""**[**i**|**o**]**seq**
- serialize packets.
The
**oseq**
flag enables sequencing of outgoing packets.
The
**iseq**
flag requires that all input packets are serialized.


[**i**|**o**]**key**
_KEY_
|
**no**[**i**|**o**]**key**
- use keyed GRE with key
_KEY_. _KEY_
is either a number or an IPv4 address-like dotted quad.
The
**key**
parameter specifies the same key to use in both directions.
The
**ikey** and **okey**
parameters specify different keys for input and output.


[**no**]**""**[**i**|**o**]**csum**
- generate/require checksums for tunneled packets.
The
**ocsum**
flag calculates checksums for outgoing packets.
The
**icsum**
flag requires that all input packets have the correct
checksum. The
**csum**
flag is equivalent to the combination
**icsum ocsum**.


**hoplimit**_ TTL_
- specifies Hop Limit value to use in outgoing packets.


**encaplimit**_ ELIM_
- specifies a fixed encapsulation limit. Default is 4.


**flowlabel**_ FLOWLABEL_
- specifies a fixed flowlabel.


**[no]allow-localremote**
- specifies whether to allow remote endpoint to have an address configured on
local host.


**tclass**_ TCLASS_
- specifies the traffic class field on
tunneled packets, which can be specified as either a two-digit
hex value (e.g. c0) or a predefined string (e.g. internet).
The value
**inherit**
causes the field to be copied from the original IP header. The
values
**inherit/**_STRING_
or
**inherit/**_00_**..**_ff_
will set the field to
_STRING_
or
_00_.._ff_
when tunneling non-IP packets. The default value is 00.


external
- make this tunnel externally controlled (or not, which is the default).
In the kernel, this is referred to as collect metadata mode.  This flag is
mutually exclusive with the
**remote**,
**local**,
**seq**,
**key,**
**csum,**
**hoplimit,**
**encaplimit,**
**flowlabel** and **tclass**
options.

.in -8


* IPoIB Type Support  
  For a link of type
  _IPoIB_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_** name **_NAME_
  **type ipoib **[** pkey _PKEY** ] [ **mode** MODE _]
  
  .in +8

**pkey**_ PKEY _
- specifies the IB P-Key to use.

**mode**_ MODE _
- specifies the mode (datagram or connected) to use.


* ERSPAN Type Support  
  For a link of type
  _ERSPAN/IP6ERSPAN_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_
  **type** { **erspan** | **ip6erspan** }
  **remote**_ ADDR _**local**_ ADDR _**seq**
  key
  _KEY_
  **erspan_ver** version 
  [
  **erspan** IDX 
  ] [
  **erspan_dir** { **ingress** | **egress** }
  ] [
  **erspan_hwid** hwid 
  ] [
  **[no]allow-localremote**
  ] [
  external
  ]
  
  .in +8

**remote**_ ADDR _
- specifies the remote address of the tunnel.


**local**_ ADDR _
- specifies the fixed local address for tunneled packets.
It must be an address on another interface on this host.


**erspan_ver** version 
- specifies the ERSPAN version number.
_version_
indicates the ERSPAN version to be created: 1 for version 1 (type II)
or 2 for version 2 (type III).


**erspan** IDX 
- specifies the ERSPAN v1 index field.
_IDX_
indicates a 20 bit index/port number associated with the ERSPAN
traffic's source port and direction.


**erspan_dir** { **ingress** | **egress** }
- specifies the ERSPAN v2 mirrored traffic's direction.


**erspan_hwid** hwid 
- an unique identifier of an ERSPAN v2 engine within a system.
_hwid_
is a 6-bit value for users to configure.


**[no]allow-localremote**
- specifies whether to allow remote endpoint to have an address configured on
local host.


**external**
- make this tunnel externally controlled (or not, which is the default).
In the kernel, this is referred to as collect metadata mode.  This flag is
mutually exclusive with the
**remote**,
**local**,
**erspan_ver**,
**erspan**,
**erspan_dir** and **erspan_hwid**
options.

.in -8


* GENEVE Type Support  
  For a link of type
  _GENEVE_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_
  **type**_ geneve _**id**_ VNI _**remote**_ IPADDR_
  [
  **ttl**_ TTL _
  ] [
  **tos**_ TOS _
  ] [
  **df**_ DF _
  ] [
  **flowlabel**_ FLOWLABEL _
  ] [
  **dstport**_ PORT_
  ] [
  [**no**]**external**
  ] [
  [**no**]**udpcsum**
  ] [
  [**no**]**udp6zerocsumtx**
  ] [
  [**no**]**udp6zerocsumrx**
  ]
  
  .in +8

**id**_ VNI _
- specifies the Virtual Network Identifer to use.


**remote**_ IPADDR_
- specifies the unicast destination IP address to use in outgoing packets.


**ttl**_ TTL_
- specifies the TTL value to use in outgoing packets. "0" or "auto" means
use whatever default value, "inherit" means inherit the inner protocol's
ttl. Default option is "0".


**tos**_ TOS_
- specifies the TOS value to use in outgoing packets.


**df**_ DF_
- specifies the usage of the Don't Fragment flag (DF) bit in outgoing packets
with IPv4 headers. The value
**inherit**
causes the bit to be copied from the original IP header. The values
**unset**
and
**set**
cause the bit to be always unset or always set, respectively. By default, the
bit is not set.


**flowlabel**_ FLOWLABEL_
- specifies the flow label to use in outgoing packets.


**dstport**_ PORT_
- select a destination port other than the default of 6081.


[**no**]**external**
- make this tunnel externally controlled (or not, which is the default). This
flag is mutually exclusive with the
**id**,
**remote**,
**ttl**,
**tos** and **flowlabel**
options.


[**no**]**udpcsum**
- specifies if UDP checksum is calculated for transmitted packets over IPv4.


[**no**]**udp6zerocsumtx**
- skip UDP checksum calculation for transmitted packets over IPv6.


[**no**]**udp6zerocsumrx**
- allow incoming UDP packets over IPv6 with zero checksum field.

.in -8


* MACVLAN and MACVTAP Type Support  
  For a link of type
  _MACVLAN_
  or
  _MACVTAP_
  the following additional arguments are supported:
  
  **ip link add link **_DEVICE_** name **_NAME_
  **type** { **macvlan** | **macvtap** } 
  **mode** { **private** | **vepa** | **bridge** | **passthru**
   [ **nopromisc** ] | **source** } 
  
  .in +8

**type** { **macvlan** | **macvtap** } 
- specifies the link type to use.
**macvlan** creates just a virtual interface, while 
**macvtap** in addition creates a character device 
**/dev/tapX** to be used just like a **tuntap** device.

**mode private**
- Do not allow communication between
**macvlan**
instances on the same physical interface, even if the external switch supports
hairpin mode.

**mode vepa**
- Virtual Ethernet Port Aggregator mode. Data from one
**macvlan**
instance to the other on the same physical interface is transmitted over the
physical interface. Either the attached switch needs to support hairpin mode,
or there must be a TCP/IP router forwarding the packets in order to allow
communication. This is the default mode.

**mode bridge**
- In bridge mode, all endpoints are directly connected to each other,
communication is not redirected through the physical interface's peer.

**mode** **passthru** [ **nopromisc** ] 
- This mode gives more power to a single endpoint, usually in
**macvtap** mode. It is not allowed for more than one endpoint on the same 
physical interface. All traffic will be forwarded to this endpoint, allowing
virtio guests to change MAC address or set promiscuous mode in order to bridge
the interface or create vlan interfaces on top of it. By default, this mode
forces the underlying interface into promiscuous mode. Passing the
**nopromisc** flag prevents this, so the promisc flag may be controlled 
using standard tools.

**mode source**
- allows one to set a list of allowed mac address, which is used to match
against source mac address from received frames on underlying interface. This
allows creating mac based VLAN associations, instead of standard port or tag
based. The feature is useful to deploy 802.1x mac based behavior,
where drivers of underlying interfaces doesn't allows that.
.in -8


* High-availability Seamless Redundancy (HSR) Support  
  For a link of type
  _HSR_
  the following additional arguments are supported:
  
  **ip link add link **_DEVICE_** name **_NAME_** type hsr**
  **slave1**_ SLAVE1-IF _**slave2**_ SLAVE2-IF _
  [** supervision**
  _ADDR-BYTE_ ] [
  **version** { **0** | **1** } ]
  
  .in +8

**type** hsr 
- specifies the link type to use, here HSR.

**slave1**_ SLAVE1-IF _
- Specifies the physical device used for the first of the two ring ports.

**slave2**_ SLAVE2-IF _
- Specifies the physical device used for the second of the two ring ports.

**supervision**_ ADDR-BYTE_
- The last byte of the multicast address used for HSR supervision frames.
Default option is "0", possible values 0-255.

**version** { **0** | **1** }
- Selects the protocol version of the interface. Default option is "0", which
corresponds to the 2010 version of the HSR standard. Option "1" activates the
2012 version.
.in -8


* BRIDGE Type Support  
  For a link of type
  _BRIDGE_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_** type bridge **
  [
  **ageing_time**_ AGEING_TIME _
  ] [
  **group_fwd_mask**_ MASK _
  ] [
  **group_address**_ ADDRESS _
  ] [
  **forward_delay**_ FORWARD_DELAY _
  ] [
  **hello_time**_ HELLO_TIME _
  ] [
  **max_age**_ MAX_AGE _
  ] [
  **stp_state**_ STP_STATE _
  ] [
  **priority**_ PRIORITY _
  ] [
  **vlan_filtering**_ VLAN_FILTERING _
  ] [
  **vlan_protocol**_ VLAN_PROTOCOL _
  ] [
  **vlan_default_pvid**_ VLAN_DEFAULT_PVID _
  ] [
  **vlan_stats_enabled**_ VLAN_STATS_ENABLED _
  ] [
  **mcast_snooping**_ MULTICAST_SNOOPING _
  ] [
  **mcast_router**_ MULTICAST_ROUTER _
  ] [
  **mcast_query_use_ifaddr**_ MCAST_QUERY_USE_IFADDR _
  ] [
  **mcast_querier**_ MULTICAST_QUERIER _
  ] [
  **mcast_hash_elasticity**_ HASH_ELASTICITY _
  ] [
  **mcast_hash_max**_ HASH_MAX _
  ] [
  **mcast_last_member_count**_ LAST_MEMBER_COUNT _
  ] [
  **mcast_startup_query_count**_ STARTUP_QUERY_COUNT _
  ] [
  **mcast_last_member_interval**_ LAST_MEMBER_INTERVAL _
  ] [
  **mcast_membership_interval**_ MEMBERSHIP_INTERVAL _
  ] [
  **mcast_querier_interval**_ QUERIER_INTERVAL _
  ] [
  **mcast_query_interval**_ QUERY_INTERVAL _
  ] [
  **mcast_query_response_interval**_ QUERY_RESPONSE_INTERVAL _
  ] [
  **mcast_startup_query_interval**_ STARTUP_QUERY_INTERVAL _
  ] [
  **mcast_stats_enabled**_ MCAST_STATS_ENABLED _
  ] [
  **mcast_igmp_version**_ IGMP_VERSION _
  ] [
  **mcast_mld_version**_ MLD_VERSION _
  ] [
  **nf_call_iptables**_ NF_CALL_IPTABLES _
  ] [
  **nf_call_ip6tables**_ NF_CALL_IP6TABLES _
  ] [
  **nf_call_arptables**_ NF_CALL_ARPTABLES _
  ]
  
  .in +8

**ageing_time**_ AGEING_TIME _
- configure the bridge's FDB entries ageing time, ie the number of seconds a MAC address will be kept in the FDB after a packet has been received from that address. after this time has passed, entries are cleaned up.

**group_fwd_mask**_ MASK _
- set the group forward mask. This is the bitmask that is applied to decide whether to forward incoming frames destined to link-local addresses, ie addresses of the form 01:80:C2:00:00:0X (defaults to 0, ie the bridge does not forward any link-local frames).

**group_address**_ ADDRESS _
- set the MAC address of the multicast group this bridge uses for STP.  The address must be a link-local address in standard Ethernet MAC address format, ie an address of the form 01:80:C2:00:00:0X, with X in [0, 4..f].

**forward_delay**_ FORWARD_DELAY _
- set the forwarding delay in seconds, ie the time spent in LISTENING state (before moving to LEARNING) and in LEARNING state (before moving to FORWARDING). Only relevant if STP is enabled. Valid values are between 2 and 30.

**hello_time**_ HELLO_TIME _
- set the time in seconds between hello packets sent by the bridge, when it is a root bridge or a designated bridges. Only relevant if STP is enabled. Valid values are between 1 and 10.

**max_age**_ MAX_AGE _
- set the hello packet timeout, ie the time in seconds until another bridge in the spanning tree is assumed to be dead, after reception of its last hello message. Only relevant if STP is enabled. Valid values are between 6 and 40.

**stp_state**_ STP_STATE _
- turn spanning tree protocol on
(_STP_STATE_ &gt; 0) 
or off
(_STP_STATE_ == 0). 
for this bridge.

**priority**_ PRIORITY _
- set this bridge's spanning tree priority, used during STP root bridge election.
_PRIORITY_
is a 16bit unsigned integer.

**vlan_filtering**_ VLAN_FILTERING _
- turn VLAN filtering on
(_VLAN_FILTERING_ &gt; 0) 
or off
(_VLAN_FILTERING_ == 0). 
When disabled, the bridge will not consider the VLAN tag when handling packets.

**vlan_protocol** { **802.1Q** | **802.1ad** } 
- set the protocol used for VLAN filtering.

**vlan_default_pvid**_ VLAN_DEFAULT_PVID _
- set the default PVID (native/untagged VLAN ID) for this bridge.

**vlan_stats_enabled**_ VLAN_STATS_ENABLED _
- enable
(_VLAN_STATS_ENABLED_ == 1) 
or disable
(_VLAN_STATS_ENABLED_ == 0) 
per-VLAN stats accounting.

**mcast_snooping**_ MULTICAST_SNOOPING _
- turn multicast snooping on
(_MULTICAST_SNOOPING_ &gt; 0) 
or off
(_MULTICAST_SNOOPING_ == 0). 

**mcast_router**_ MULTICAST_ROUTER _
- set bridge's multicast router if IGMP snooping is enabled.
_MULTICAST_ROUTER_
is an integer value having the following meaning:
.in +8

**0**
- disabled.

**1**
- automatic (queried).

**2**
- permanently enabled.
.in -8

**mcast_query_use_ifaddr**_ MCAST_QUERY_USE_IFADDR _
- whether to use the bridge's own IP address as source address for IGMP queries
(_MCAST_QUERY_USE_IFADDR_ &gt; 0) 
or the default of 0.0.0.0
(_MCAST_QUERY_USE_IFADDR_ == 0). 

**mcast_querier**_ MULTICAST_QUERIER _
- enable
(_MULTICAST_QUERIER_ &gt; 0) 
or disable
(_MULTICAST_QUERIER_ == 0) 
IGMP querier, ie sending of multicast queries by the bridge (default: disabled).

**mcast_querier_interval**_ QUERIER_INTERVAL _
- interval between queries sent by other routers. if no queries are seen after this delay has passed, the bridge will start to send its own queries (as if
**mcast_querier**
was enabled).

**mcast_hash_elasticity**_ HASH_ELASTICITY _
- set multicast database hash elasticity, ie the maximum chain length in the multicast hash table (defaults to 4).

**mcast_hash_max**_ HASH_MAX _
- set maximum size of multicast hash table (defaults to 512, value must be a power of 2).

**mcast_last_member_count**_ LAST_MEMBER_COUNT _
- set multicast last member count, ie the number of queries the bridge will send before stopping forwarding a multicast group after a "leave" message has been received (defaults to 2).

**mcast_last_member_interval**_ LAST_MEMBER_INTERVAL _
- interval between queries to find remaining members of a group, after a "leave" message is received.

**mcast_startup_query_count**_ STARTUP_QUERY_COUNT _
- set the number of IGMP queries to send during startup phase (defaults to 2).

**mcast_startup_query_interval**_ STARTUP_QUERY_INTERVAL _
- interval between queries in the startup phase.

**mcast_query_interval**_ QUERY_INTERVAL _
- interval between queries sent by the bridge after the end of the startup phase.

**mcast_query_response_interval**_ QUERY_RESPONSE_INTERVAL _
- set the Max Response Time/Maximum Response Delay for IGMP/MLD queries sent by the bridge.

**mcast_membership_interval**_ MEMBERSHIP_INTERVAL _
- delay after which the bridge will leave a group, if no membership reports for this group are received.

**mcast_stats_enabled**_ MCAST_STATS_ENABLED _
- enable
(_MCAST_STATS_ENABLED_ &gt; 0) 
or disable
(_MCAST_STATS_ENABLED_ == 0) 
multicast (IGMP/MLD) stats accounting.

**mcast_igmp_version**_ IGMP_VERSION _
- set the IGMP version.

**mcast_mld_version**_ MLD_VERSION _
- set the MLD version.

**nf_call_iptables**_ NF_CALL_IPTABLES _
- enable
(_NF_CALL_IPTABLES_ &gt; 0) 
or disable
(_NF_CALL_IPTABLES_ == 0) 
iptables hooks on the bridge.

**nf_call_ip6tables**_ NF_CALL_IP6TABLES _
- enable
(_NF_CALL_IP6TABLES_ &gt; 0) 
or disable
(_NF_CALL_IP6TABLES_ == 0) 
ip6tables hooks on the bridge.

**nf_call_arptables**_ NF_CALL_ARPTABLES _
- enable
(_NF_CALL_ARPTABLES_ &gt; 0) 
or disable
(_NF_CALL_ARPTABLES_ == 0) 
arptables hooks on the bridge.


.in -8


* MACsec Type Support  
  For a link of type
  _MACsec_
  the following additional arguments are supported:
  
  **ip link add link **_DEVICE_** name **_NAME_** type macsec**
  [ [
  **address**_ &lt;lladdr&gt;_
  ]
  **port**_ PORT_
  |
  **sci**_ SCI_
  ] [
  **cipher**_ CIPHER_SUITE_
  ] [
  **icvlen** { 
  _8..16_ } ] [
  **encrypt** {
  **on** | **off** } ] [ 
  **send_sci** { **on** | **off** } ] [
  **end_station** { **on** | **off** } ] [
  **scb** { **on** | **off** } ] [
  **protect** { **on** | **off** } ] [
  **replay** { **on** | **off** }
  **window** { 
  _0..2^32-1_ } ] [
  **validate** { **strict** | **check** | **disabled** } ] [
  **encodingsa** { 
  _0..3_ } ]
  
  .in +8

**address**_ &lt;lladdr&gt; _
- sets the system identifier component of secure channel for this MACsec device.


**port**_ PORT _
- sets the port number component of secure channel for this MACsec device, in a
range from 1 to 65535 inclusive. Numbers with a leading " 0 " or " 0x " are
interpreted as octal and hexadecimal, respectively.


**sci**_ SCI _
- sets the secure channel identifier for this MACsec device.
_SCI_
is a 64bit wide number in hexadecimal format.


**cipher**_ CIPHER_SUITE _
- defines the cipher suite to use.


**icvlen**_ LENGTH _
- sets the length of the Integrity Check Value (ICV).


**encrypt on **or** encrypt off**
- switches between authenticated encryption, or authenticity mode only.


**send_sci on **or** send_sci off**
- specifies whether the SCI is included in every packet, or only when it is necessary.


**end_station on **or** end_station off**
- sets the End Station bit.


**scb on **or** scb off**
- sets the Single Copy Broadcast bit.


**protect on **or** protect off**
- enables MACsec protection on the device.


**replay on **or** replay off**
- enables replay protection on the device.

.in +8


**window**_ SIZE _
- sets the size of the replay window.

.in -8


**validate strict **or** validate check **or** validate disabled**
- sets the validation mode on the device.


**encodingsa**_ AN _
- sets the active secure association for transmission.

.in -8


* VRF Type Support  
  For a link of type
  _VRF_
  the following additional arguments are supported:
  
  **ip link add **_DEVICE_** type vrf table **_TABLE_
  
  .in +8

**table** table id associated with VRF device

.in -8


* RMNET Type Support  
  For a link of type
  _RMNET_
  the following additional arguments are supported:
  
  **ip link add link **_DEVICE_** name **_NAME_** type rmnet mux_id **_MUXID_
  
  .in +8

**mux_id**_ MUXID _
- specifies the mux identifier for the rmnet device, possible values 1-254.

.in -8


<a name="ip-link-delete-delete-virtual-link"></a>

### ip link delete - delete virtual link



* **dev**_ DEVICE _  
  specifies the virtual device to act operate on.
  
* **group**_ GROUP _  
  specifies the group of virtual links to delete. Group 0 is not allowed to be
  deleted since it is the default group.
  
* **type**_ TYPE _  
  specifies the type of the device.
  

<a name="ip-link-set-change-device-attributes"></a>

### ip link set - change device attributes



**Warning:**
If multiple parameter changes are requested,
**ip**
aborts immediately after any of the changes have failed.
This is the only case when
**ip**
can move the system to an unpredictable state. The solution
is to avoid changing several parameters with one
**ip link set**
call.


* **dev**_ DEVICE _  
  _DEVICE_
  specifies network device to operate on. When configuring SR-IOV Virtual Function
  (VF) devices, this keyword should specify the associated Physical Function (PF)
  device.
  
* **group**_ GROUP _  
  _GROUP_
  has a dual role: If both group and dev are present, then move the device to the
  specified group. If only a group is specified, then the command operates on
  all devices in that group.
  
* **up** and **down**  
  change the state of the device to
  **UP**
  or
  **DOWN**.
  
* **arp on **or** arp off**  
  change the
  **NOARP**
  flag on the device.
  
* **multicast on **or** multicast off**  
  change the
  **MULTICAST**
  flag on the device.
  
* **protodown on **or** protodown off**  
  change the
  **PROTODOWN**
  state on the device. Indicates that a protocol error has been detected on the port. Switch drivers can react to this error by doing a phys down on the switch port.
  
* **dynamic on **or** dynamic off**  
  change the
  **DYNAMIC**
  flag on the device. Indicates that address can change when interface goes down (currently
  **NOT**
  used by the Linux).
  
* **name**_ NAME_  
  change the name of the device. This operation is not
  recommended if the device is running or has some addresses
  already configured.
  
* **txqueuelen**_ NUMBER_  
* **txqlen**_ NUMBER_  
  change the transmit queue length of the device.
  
* **mtu**_ NUMBER_  
  change the
  _MTU_
  of the device.
  
* **address**_ LLADDRESS_  
  change the station address of the interface.
  
* **broadcast**_ LLADDRESS_  
* **brd**_ LLADDRESS_  
* **peer**_ LLADDRESS_  
  change the link layer broadcast address or the peer address when
  the interface is
  _POINTOPOINT_.
  
* **netns**_ NETNSNAME _**|**_ PID_  
  move the device to the network namespace associated with name
  _NETNSNAME _or
  process_ PID_.
  
  Some devices are not allowed to change network namespace: loopback, bridge,
  ppp, wireless. These are network namespace local devices. In such case
  **ip**
  tool will return "Invalid argument" error. It is possible to find out if device is local
  to a single network namespace by checking
  **netns-local**
  flag in the output of the
  **ethtool**:
  
  .in +8
  **ethtool -k**
  _DEVICE_
  .in -8
  
  To change network namespace for wireless devices the
  **iw**
  tool can be used. But it allows to change network namespace only for physical devices and by process
  _PID_.
  
* **alias**_ NAME_  
  give the device a symbolic name for easy reference.
  
* **group**_ GROUP_  
  specify the group the device belongs to.
  The available groups are listed in file
  **/etc/iproute2/group**.
  
* **vf**_ NUM_  
  specify a Virtual Function device to be configured. The associated PF device
  must be specified using the
  **dev**
  parameter.
  
  .in +8
  **mac**_ LLADDRESS_
  - change the station address for the specified VF. The
  **vf**
  parameter must be specified.
  

**vlan**_ VLANID_
- change the assigned VLAN for the specified VF. When specified, all traffic
sent from the VF will be tagged with the specified VLAN ID. Incoming traffic
will be filtered for the specified VLAN ID, and will have all VLAN tags
stripped before being passed to the VF. Setting this parameter to 0 disables
VLAN tagging and filtering. The
**vf**
parameter must be specified.


**qos**_ VLAN-QOS_
- assign VLAN QOS (priority) bits for the VLAN tag. When specified, all VLAN
tags transmitted by the VF will include the specified priority bits in the
VLAN tag. If not specified, the value is assumed to be 0. Both the
**vf**
and
**vlan**
parameters must be specified. Setting both
**vlan**
and
**qos**
as 0 disables VLAN tagging and filtering for the VF.


**proto**_ VLAN-PROTO_
- assign VLAN PROTOCOL for the VLAN tag, either 802.1Q or 802.1ad.
Setting to 802.1ad, all traffic sent from the VF will be tagged with VLAN S-Tag.
Incoming traffic will have VLAN S-Tags stripped before being passed to the VF.
Setting to 802.1ad also enables an option to concatenate another VLAN tag, so both
S-TAG and C-TAG will be inserted/stripped for outgoing/incoming traffic, respectively.
If not specified, the value is assumed to be 802.1Q. Both the
**vf**
and
**vlan**
parameters must be specified.


**rate**_ TXRATE_
-- change the allowed transmit bandwidth, in Mbps, for the specified VF.
Setting this parameter to 0 disables rate limiting.
**vf**
parameter must be specified.
Please use new API
**max_tx_rate**
option instead.


**max_tx_rate**_ TXRATE_
- change the allowed maximum transmit bandwidth, in Mbps, for the specified VF.
Setting this parameter to 0 disables rate limiting.
**vf**
parameter must be specified.


**min_tx_rate**_ TXRATE_
- change the allowed minimum transmit bandwidth, in Mbps, for the specified VF.
Minimum TXRATE should be always &lt;= Maximum TXRATE.
Setting this parameter to 0 disables rate limiting.
**vf**
parameter must be specified.


**spoofchk**_ on|off_
- turn packet spoof checking on or off for the specified VF.

**query_rss**_ on|off_
- toggle the ability of querying the RSS configuration of a specific VF. VF RSS information like RSS hash key may be considered sensitive on some devices where this information is shared between VF and PF and thus its querying may be prohibited by default.

**state**_ auto|enable|disable_
- set the virtual link state as seen by the specified VF. Setting to auto means a
reflection of the PF link state, enable lets the VF to communicate with other VFs on
this host even if the PF link state is down, disable causes the HW to drop any packets
sent by the VF.

**trust**_ on|off_
- trust the specified VF user. This enables that VF user can set a specific feature
which may impact security and/or performance. (e.g. VF multicast promiscuous mode)

**node_guid**_ eui64_
- configure node GUID for Infiniband VFs.

**port_guid**_ eui64_
- configure port GUID for Infiniband VFs.
.in -8


* **xdp object | pinned | off**  
  set (or unset) a XDP ("eXpress Data Path") BPF program to run on every
  packet at driver level.
  **ip link**
  output will indicate a
  **xdp**
  flag for the networking device. If the driver does not have native XDP
  support, the kernel will fall back to a slower, driver-independent "generic"
  XDP variant. The
  **ip link**
  output will in that case indicate
  **xdpgeneric**
  instead of
  **xdp**
  only. If the driver does have native XDP support, but the program is
  loaded under
  **xdpgeneric object | pinned**
  then the kernel will use the generic XDP variant instead of the native one.
  **xdpdrv**
  has the opposite effect of requestsing that the automatic fallback to the
  generic XDP variant be disabled and in case driver is not XDP-capable error
  should be returned.
  **xdpdrv**
  also disables hardware offloads.
  **xdpoffload**
  in ip link output indicates that the program has been offloaded to hardware
  and can also be used to request the "offload" mode, much like
  **xdpgeneric**
  it forces program to be installed specifically in HW/FW of the apater.
  
  **off**
  (or
  **none**
  )
  - Detaches any currently attached XDP/BPF program from the given device.
  
  **object**_ FILE _
  - Attaches a XDP/BPF program to the given device. The
  _FILE_
  points to a BPF ELF file (f.e. generated by LLVM) that contains the BPF
  program code, map specifications, etc. If a XDP/BPF program is already
  attached to the given device, an error will be thrown. If no XDP/BPF
  program is currently attached, the device supports XDP and the program
  from the BPF ELF file passes the kernel verifier, then it will be attached
  to the device. If the option
  _-force_
  is passed to
  **ip**
  then any prior attached XDP/BPF program will be atomically overridden and
  no error will be thrown in this case. If no
  **section**
  option is passed, then the default section name ("prog") will be assumed,
  otherwise the provided section name will be used. If no
  **verbose**
  option is passed, then a verifier log will only be dumped on load error.
  See also
  **EXAMPLES**
  section for usage examples.
  
  **section**_ NAME _
  - Specifies a section name that contains the BPF program code. If no section
  name is specified, the default one ("prog") will be used. This option is
  to be passed with the
  **object**
  option.
  
  **verbose**
  - Act in verbose mode. For example, even in case of success, this will
  print the verifier log in case a program was loaded from a BPF ELF file.
  
  **pinned**_ FILE _
  - Attaches a XDP/BPF program to the given device. The
  _FILE_
  points to an already pinned BPF program in the BPF file system. The option
  **section**
  doesn't apply here, but otherwise semantics are the same as with the option
  **object**
  described already.
  
* **master**_ DEVICE_  
  set master device of the device (enslave device).
  
* **nomaster**  
  unset master device of the device (release device).
  
* **addrgenmode**_ eui64|none|stable_secret|random_  
  set the IPv6 address generation mode
  
  _eui64_
  - use a Modified EUI-64 format interface identifier
  
  _none_
  - disable automatic address generation
  
  _stable_secret_
  - generate the interface identifier based on a preset /proc/sys/net/ipv6/conf/{default,DEVICE}/stable_secret
  
  _random_
  - like stable_secret, but auto-generate a new random secret if none is set
  
* **link-netnsid **  
  set peer netnsid for a cross-netns interface
  
* **type**_ ETYPE TYPE_ARGS_  
  Change type-specific settings. For a list of supported types and arguments refer
  to the description of
  **ip link add**
  above. In addition to that, it is possible to manipulate settings to slave
  devices:
  
* Bridge Slave Support  
  For a link with master
  **bridge**
  the following additional arguments are supported:
  
  **ip link set type bridge_slave**
  [
  **fdb_flush**
  ] [
  **state**_ STATE_
  ] [
  **priority**_ PRIO_
  ] [
  **cost**_ COST_
  ] [
  **guard** { **on** | **off** }
  ] [
  **hairpin** { **on** | **off** }
  ] [
  **fastleave** { **on** | **off** }
  ] [
  **root_block** { **on** | **off** }
  ] [
  **learning** { **on** | **off** }
  ] [
  **flood** { **on** | **off** }
  ] [
  **proxy_arp** { **on** | **off** }
  ] [
  **proxy_arp_wifi** { **on** | **off** }
  ] [
  **mcast_router**_ MULTICAST_ROUTER_
  ] [
  **mcast_fast_leave** { **on** | **off**}
  ] [
  **mcast_flood** { **on** | **off** }
  ] [
  **group_fwd_mask** MASK
  ] [
  **neigh_suppress** { **on** | **off** }
  ] [
  **vlan_tunnel** { **on** | **off** }
  ] [
  **isolated** { **on** | **off** }
  ] [
  **backup_port** DEVICE
  ] [
  **nobackup_port** ]
  
  .in +8

**fdb_flush**
- flush bridge slave's fdb dynamic entries.

**state**_ STATE_
- Set port state.
_STATE_
is a number representing the following states:
**0** (disabled),
**1** (listening),
**2** (learning),
**3** (forwarding),
**4** (blocking).

**priority**_ PRIO_
- set port priority (allowed values are between 0 and 63, inclusively).

**cost**_ COST_
- set port cost (allowed values are between 1 and 65535, inclusively).

**guard** { **on** | **off** }
- block incoming BPDU packets on this port.

**hairpin** { **on** | **off** }
- enable hairpin mode on this port. This will allow incoming packets on this
port to be reflected back.

**fastleave** { **on** | **off** }
- enable multicast fast leave on this port.

**root_block** { **on** | **off** }
- block this port from becoming the bridge's root port.

**learning** { **on** | **off** }
- allow MAC address learning on this port.

**flood** { **on** | **off** }
- open the flood gates on this port, i.e. forward all unicast frames to this
port also. Requires
**proxy_arp** and **proxy_arp_wifi**
to be turned off.

**proxy_arp** { **on** | **off** }
- enable proxy ARP on this port.

**proxy_arp_wifi** { **on** | **off** }
- enable proxy ARP on this port which meets extended requirements by IEEE
802.11 and Hotspot 2.0 specifications.

**mcast_router**_ MULTICAST_ROUTER_
- configure this port for having multicast routers attached. A port with a
multicast router will receive all multicast traffic.
_MULTICAST_ROUTER_
may be either
**0**
to disable multicast routers on this port,
**1**
to let the system detect the presence of of routers (this is the default),
**2**
to permanently enable multicast traffic forwarding on this port or
**3**
to enable multicast routers temporarily on this port, not depending on incoming
queries.

**mcast_fast_leave** { **on** | **off** }
- this is a synonym to the
**fastleave**
option above.

**mcast_flood** { **on** | **off** }
- controls whether a given port will flood multicast traffic for which there is no MDB entry.

**group_fwd_mask**_ MASK _
- set the group forward mask. This is the bitmask that is applied to decide whether to forward incoming frames destined to link-local addresses, ie addresses of the form 01:80:C2:00:00:0X (defaults to 0, ie the bridge does not forward any link-local frames coming on this port).

**neigh_suppress** { **on** | **off** }
- controls whether neigh discovery (arp and nd) proxy and suppression is enabled on the port. By default this flag is off.

**vlan_tunnel** { **on** | **off** }
- controls whether vlan to tunnel mapping is enabled on the port. By default this flag is off.

**backup_port**_ DEVICE_
- if the port loses carrier all traffic will be redirected to the configured backup port

**nobackup_port**
- removes the currently configured backup port

.in -8


* Bonding Slave Support  
  For a link with master
  **bond**
  the following additional arguments are supported:
  
  **ip link set type bond_slave**
  [
  **queue_id**_ ID_
  ]
  
  .in +8

**queue_id**_ ID_
- set the slave's queue ID (a 16bit unsigned value).

.in -8


* MACVLAN and MACVTAP Support  
  Modify list of allowed macaddr for link in source mode.
  
  **ip link set type { macvlan | macvap } **
  [
  **macaddr**_ _**""**_COMMAND_** **_MACADDR_** ...**
  ]
  
  Commands:
  .in +8
  **add**
  - add MACADDR to allowed list

**set**
- replace allowed list

**del**
- remove MACADDR from allowed list

**flush**
- flush whole allowed list

.in -8



<a name="ip-link-show-display-device-attributes"></a>

### ip link show - display device attributes



* **dev**_ NAME _**(default)**  
  _NAME_
  specifies the network device to show.
  If this argument is omitted all devices in the default group are listed.
  
* **group**_ GROUP _  
  _GROUP_
  specifies what group of devices to show.
  
* **up**  
  only display running interfaces.
  
* **master**_ DEVICE _  
  _DEVICE_
  specifies the master device which enslaves devices to show.
  
* **vrf**_ NAME _  
  _NAME_
  speficies the VRF which enslaves devices to show.
  
* **type**_ TYPE _  
  _TYPE_
  specifies the type of devices to show.
  
  Note that the type name is not checked against the list of supported types -
  instead it is sent as-is to the kernel. Later it is used to filter the returned
  interface list by comparing it with the relevant attribute in case the kernel
  didn't filter already. Therefore any string is accepted, but may lead to empty
  output.
  

<a name="ip-link-xstats-display-extended-statistics"></a>

### ip link xstats - display extended statistics



* **type**_ TYPE _  
  _TYPE_
  specifies the type of devices to display extended statistics for.
  

<a name="ip-link-afstats-display-address-family-specific-statistics"></a>

### ip link afstats - display address-family specific statistics



* **dev**_ DEVICE _  
  _DEVICE_
  specifies the device to display address-family statistics for.
  

<a name="ip-link-help-display-help"></a>

### ip link help - display help



_TYPE_
specifies which help of link type to dislpay.

.SS
_GROUP_
may be a number or a string from the file
**/etc/iproute2/group**
which can be manually filled.


<a name="examples"></a>

# Examples


ip link show
Shows the state of all network interfaces on the system.

ip link show type bridge
Shows the bridge devices.

ip link show type vlan
Shows the vlan devices.

ip link show master br0
Shows devices enslaved by br0

ip link set dev ppp0 mtu 1400
Change the MTU the ppp0 device.

ip link add link eth0 name eth0.10 type vlan id 10
Creates a new vlan device eth0.10 on device eth0.

ip link delete dev eth0.10
Removes vlan device.

ip link help gre
Display help for the gre link type.

ip link add name tun1 type ipip remote 192.168.1.1
local 192.168.1.2 ttl 225 encap gue encap-sport auto
encap-dport 5555 encap-csum encap-remcsum
Creates an IPIP that is encapsulated with Generic UDP Encapsulation,
and the outer UDP checksum and remote checksum offload are enabled.

ip link set dev eth0 xdp obj prog.o
Attaches a XDP/BPF program to device eth0, where the program is
located in prog.o, section "prog" (default section). In case a
XDP/BPF program is already attached, throw an error.

ip -force link set dev eth0 xdp obj prog.o sec foo
Attaches a XDP/BPF program to device eth0, where the program is
located in prog.o, section "foo". In case a XDP/BPF program is
already attached, it will be overridden by the new one.

ip -force link set dev eth0 xdp pinned /sys/fs/bpf/foo
Attaches a XDP/BPF program to device eth0, where the program was
previously pinned as an object node into BPF file system under
name foo.

ip link set dev eth0 xdp off
If a XDP/BPF program is attached on device eth0, detach it and
effectively turn off XDP for device eth0.

ip link add link wpan0 lowpan0 type lowpan
Creates a 6LoWPAN interface named lowpan0 on the underlying
IEEE 802.15.4 device wpan0.

ip link add dev ip6erspan11 type ip6erspan seq key 102
local fc00:100::2 remote fc00:100::1
erspan_ver 2 erspan_dir ingress erspan_hwid 17
Creates a IP6ERSPAN version 2 interface named ip6erspan00.


<a name="see-also"></a>

# See Also
  
**ip**(8),
**ip-netns**(8),
**ethtool**(8),
**iptables**(8)


<a name="author"></a>

# Author

Original Manpage by Michail Litvak &lt;[mci@owl.openwall](mailto:mci@owl.openwall).com&gt;
