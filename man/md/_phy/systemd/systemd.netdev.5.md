# systemd\&.netdev(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.netdev - Virtual Network Device configuration

<a name="synopsis"></a>

# Synopsis

```

 netdev.netdev
```

<a name="description"></a>

# Description


Network setup is performed by
**systemd-networkd**(8).

The main Virtual Network Device file must have the extension
.netdev; other extensions are ignored. Virtual network devices are created as soon as networkd is started. If a netdev with the specified name already exists, networkd will use that as-is rather than create its own. Note that the settings of the pre-existing netdev will not be changed by networkd.

The
.netdev
files are read from the files located in the system network directory
/usr/lib/systemd/network, the volatile runtime network directory
/run/systemd/network
and the local administration network directory
/etc/systemd/network. All configuration files are collectively sorted and processed in lexical order, regardless of the directories in which they live. However, files with identical filenames replace each other. Files in
/etc
have the highest priority, files in
/run
take precedence over files with the same name in
/usr/lib. This can be used to override a system-supplied configuration file with a local file if needed. As a special case, an empty file (file size 0) or symlink with the same name pointing to
/dev/null
disables the configuration file entirely (it is "masked").

Along with the netdev file
foo.netdev, a "drop-in" directory
foo.netdev.d/
may exist. All files with the suffix
".conf"
from this directory will be parsed after the file itself is parsed. This is useful to alter or add configuration settings, without having to modify the main configuration file. Each drop-in file must have appropriate section headers.

In addition to
/etc/systemd/network, drop-in
".d"
directories can be placed in
/usr/lib/systemd/network
or
/run/systemd/network
directories. Drop-in files in
/etc
take precedence over those in
/run
which in turn take precedence over those in
/usr/lib. Drop-in files under any of these directories take precedence over the main netdev file wherever located. (Of course, since
/run
is temporary and
/usr/lib
is for vendors, it is unlikely drop-ins should be used in either of those places.)

<a name="supported-netdev-kinds"></a>

# Supported Netdev Kinds


The following kinds of virtual network devices may be configured in
.netdev
files:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Supported kinds of virtual network devices**
.TS
allbox tab(:);
lB lB.
T{
Kind
T}:T{
Description
T}
.T&
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l.
T{
_bond_
T}:T{
A bond device is an aggregation of all its slave devices. See \m[blue]**Linux Ethernet Bonding Driver HOWTO**\m[]\s-2\u[1]\d\s+2 for details.Local configuration
T}
T{
_bridge_
T}:T{
A bridge device is a software switch, and each of its slave devices and the bridge itself are ports of the switch.
T}
T{
_dummy_
T}:T{
A dummy device drops all packets sent to it.
T}
T{
_gre_
T}:T{
A Level 3 GRE tunnel over IPv4. See \m[blue]**RFC 2784**\m[]\s-2\u[2]\d\s+2 for details.
T}
T{
_gretap_
T}:T{
A Level 2 GRE tunnel over IPv4.
T}
T{
_erspan_
T}:T{
ERSPAN mirrors traffic on one or more source ports and delivers the mirrored traffic to one or more destination ports on another switch. The traffic is encapsulated in generic routing encapsulation (GRE) and is therefore routable across a layer 3 network between the source switch and the destination switch.
T}
T{
_ip6gre_
T}:T{
A Level 3 GRE tunnel over IPv6.
T}
T{
_ip6tnl_
T}:T{
An IPv4 or IPv6 tunnel over IPv6
T}
T{
_ip6gretap_
T}:T{
A Level 2 GRE tunnel over IPv6.
T}
T{
_ipip_
T}:T{
An IPv4 over IPv4 tunnel.
T}
T{
_ipvlan_
T}:T{
An ipvlan device is a stacked device which receives packets from its underlying device based on IP address filtering.
T}
T{
_macvlan_
T}:T{
A macvlan device is a stacked device which receives packets from its underlying device based on MAC address filtering.
T}
T{
_macvtap_
T}:T{
A macvtap device is a stacked device which receives packets from its underlying device based on MAC address filtering.
T}
T{
_sit_
T}:T{
An IPv6 over IPv4 tunnel.
T}
T{
_tap_
T}:T{
A persistent Level 2 tunnel between a network device and a device node.
T}
T{
_tun_
T}:T{
A persistent Level 3 tunnel between a network device and a device node.
T}
T{
_veth_
T}:T{
An Ethernet tunnel between a pair of network devices.
T}
T{
_vlan_
T}:T{
A VLAN is a stacked device which receives packets from its underlying device based on VLAN tagging. See \m[blue]**IEEE 802.1Q**\m[]\s-2\u[3]\d\s+2 for details.
T}
T{
_vti_
T}:T{
An IPv4 over IPSec tunnel.
T}
T{
_vti6_
T}:T{
An IPv6 over IPSec tunnel.
T}
T{
_vxlan_
T}:T{
A virtual extensible LAN (vxlan), for connecting Cloud computing deployments.
T}
T{
_geneve_
T}:T{
A GEneric NEtwork Virtualization Encapsulation (GENEVE) netdev driver.
T}
T{
_vrf_
T}:T{
A Virtual Routing and Forwarding (\m[blue]**VRF**\m[]\s-2\u[4]\d\s+2) interface to create separate routing and forwarding domains.
T}
T{
_vcan_
T}:T{
The virtual CAN driver (vcan). Similar to the network loopback devices, vcan offers a virtual local CAN interface.
T}
T{
_vxcan_
T}:T{
The virtual CAN tunnel driver (vxcan). Similar to the virtual ethernet driver veth, vxcan implements a local CAN traffic tunnel between two virtual CAN network devices. When creating a vxcan, two vxcan devices are created as pair. When one end receives the packet it appears on its pair and vice versa. The vxcan can be used for cross namespace communication.
T}
T{
_wireguard_
T}:T{
WireGuard Secure Network Tunnel.
T}
T{
_netdevsim_
T}:T{
A simulator. This simulated networking device is used for testing various networking APIs and at this time is particularly focused on testing hardware offloading related interfaces.
T}
T{
_fou_
T}:T{
Foo-over-UDP tunneling.
T}
.TE


<a name="match-section-options"></a>

# [Match] Section Options


A virtual network device is only created if the
"[Match]"
section matches the current environment, or if the section is empty. The following keys are accepted:

_Host=_
Matches against the hostname or machine ID of the host. See
"ConditionHost="
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

_Virtualization=_
Checks whether the system is executed in a virtualized environment and optionally test whether it is a specific implementation. See
"ConditionVirtualization="
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

_KernelCommandLine=_
Checks whether a specific kernel command line option is set. See
"ConditionKernelCommandLine="
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

_KernelVersion=_
Checks whether the kernel version (as reported by
**uname -r**) matches a certain expression. See
"ConditionKernelVersion="
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

_Architecture=_
Checks whether the system is running on a specific architecture. See
"ConditionArchitecture="
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

<a name="netdev-section-options"></a>

# [Netdev] Section Options


The
"[NetDev]"
section accepts the following keys:

_Description=_
A free-form description of the netdev.

_Name=_
The interface name used when creating the netdev. This option is compulsory.

_Kind=_
The netdev kind. This option is compulsory. See the
"Supported netdev kinds"
section for the valid keys.

_MTUBytes=_
The maximum transmission unit in bytes to set for the device. The usual suffixes K, M, G, are supported and are understood to the base of 1024. For
"tun"
or
"tap"
devices,
_MTUBytes=_
setting is not currently supported in
"[NetDev]"
section. Please specify it in
"[Link]"
section of corresponding
**systemd.network**(5)
files.

_MACAddress=_
The MAC address to use for the device. For
"tun"
or
"tap"
devices, setting
_MACAddress=_
in the
"[NetDev]"
section is not supported. Please specify it in
"[Link]"
section of the corresponding
**systemd.network**(5)
file. If this option is not set,
"vlan"
devices inherit the MAC address of the physical interface. For other kind of netdevs, if this option is not set, then MAC address is generated based on the interface name and the
**machine-id**(5).

<a name="bridge-section-options"></a>

# [Bridge] Section Options


The
"[Bridge]"
section only applies for netdevs of kind
"bridge", and accepts the following keys:

_HelloTimeSec=_
HelloTimeSec specifies the number of seconds between two hello packets sent out by the root bridge and the designated bridges. Hello packets are used to communicate information about the topology throughout the entire bridged local area network.

_MaxAgeSec=_
MaxAgeSec specifies the number of seconds of maximum message age. If the last seen (received) hello packet is more than this number of seconds old, the bridge in question will start the takeover procedure in attempt to become the Root Bridge itself.

_ForwardDelaySec=_
ForwardDelaySec specifies the number of seconds spent in each of the Listening and Learning states before the Forwarding state is entered.

_AgeingTimeSec=_
This specifies the number of seconds a MAC Address will be kept in the forwarding database after having a packet received from this MAC Address.

_Priority=_
The priority of the bridge. An integer between 0 and 65535. A lower value means higher priority. The bridge having the lowest priority will be elected as root bridge.

_GroupForwardMask=_
A 16-bit bitmask represented as an integer which allows forwarding of link local frames with 802.1D reserved addresses (01:80:C2:00:00:0X). A logical AND is performed between the specified bitmask and the exponentiation of 2^X, the lower nibble of the last octet of the MAC address. For example, a value of 8 would allow forwarding of frames addressed to 01:80:C2:00:00:03 (802.1X PAE).

_DefaultPVID=_
This specifies the default port VLAN ID of a newly attached bridge port. Set this to an integer in the range 1–4094 or
"none"
to disable the PVID.

_MulticastQuerier=_
Takes a boolean. This setting controls the IFLA_BR_MCAST_QUERIER option in the kernel. If enabled, the kernel will send general ICMP queries from a zero source address. This feature should allow faster convergence on startup, but it causes some multicast-aware switches to misbehave and disrupt forwarding of multicast packets. When unset, the kernels default will be used.

_MulticastSnooping=_
Takes a boolean. This setting controls the IFLA_BR_MCAST_SNOOPING option in the kernel. If enabled, IGMP snooping monitors the Internet Group Management Protocol (IGMP) traffic between hosts and multicast routers. When unset, the kernels default will be used.

_VLANFiltering=_
Takes a boolean. This setting controls the IFLA_BR_VLAN_FILTERING option in the kernel. If enabled, the bridge will be started in VLAN-filtering mode. When unset, the kernels default will be used.

_STP=_
Takes a boolean. This enables the bridges Spanning Tree Protocol (STP). When unset, the kernel\*(Aqs default will be used.

<a name="vlan-section-options"></a>

# [Vlan] Section Options


The
"[VLAN]"
section only applies for netdevs of kind
"vlan", and accepts the following key:

_Id=_
The VLAN ID to use. An integer in the range 0–4094. This option is compulsory.

_GVRP=_
Takes a boolean. The Generic VLAN Registration Protocol (GVRP) is a protocol that allows automatic learning of VLANs on a network. When unset, the kernels default will be used.

_MVRP=_
Takes a boolean. Multiple VLAN Registration Protocol (MVRP) formerly known as GARP VLAN Registration Protocol (GVRP) is a standards-based Layer 2 network protocol, for automatic configuration of VLAN information on switches. It was defined in the 802.1ak amendment to 802.1Q-2005. When unset, the kernels default will be used.

_LooseBinding=_
Takes a boolean. The VLAN loose binding mode, in which only the operational state is passed from the parent to the associated VLANs, but the VLAN device state is not changed. When unset, the kernels default will be used.

_ReorderHeader=_
Takes a boolean. The VLAN reorder header is set VLAN interfaces behave like physical interfaces. When unset, the kernels default will be used.

<a name="macvlan-section-options"></a>

# [Macvlan] Section Options


The
"[MACVLAN]"
section only applies for netdevs of kind
"macvlan", and accepts the following key:

_Mode=_
The MACVLAN mode to use. The supported options are
"private",
"vepa",
"bridge", and
"passthru".

<a name="macvtap-section-options"></a>

# [Macvtap] Section Options


The
"[MACVTAP]"
section applies for netdevs of kind
"macvtap"
and accepts the same key as
"[MACVLAN]".

<a name="ipvlan-section-options"></a>

# [Ipvlan] Section Options


The
"[IPVLAN]"
section only applies for netdevs of kind
"ipvlan", and accepts the following key:

_Mode=_
The IPVLAN mode to use. The supported options are
"L2","L3"
and
"L3S".

_Flags=_
The IPVLAN flags to use. The supported options are
"bridge","private"
and
"vepa".

<a name="vxlan-section-options"></a>

# [Vxlan] Section Options


The
"[VXLAN]"
section only applies for netdevs of kind
"vxlan", and accepts the following keys:

_Id=_
The VXLAN ID to use.

_Remote=_
Configures destination IP address.

_Local=_
Configures local IP address.

_TOS=_
The Type Of Service byte value for a vxlan interface.

_TTL=_
A fixed Time To Live N on Virtual eXtensible Local Area Network packets. N is a number in the range 1–255. 0 is a special value meaning that packets inherit the TTL value.

_MacLearning=_
Takes a boolean. When true, enables dynamic MAC learning to discover remote MAC addresses.

_FDBAgeingSec=_
The lifetime of Forwarding Database entry learnt by the kernel, in seconds.

_MaximumFDBEntries=_
Configures maximum number of FDB entries.

_ReduceARPProxy=_
Takes a boolean. When true, bridge-connected VXLAN tunnel endpoint answers ARP requests from the local bridge on behalf of remote Distributed Overlay Virtual Ethernet
\m[blue]**(DVOE)**\m[]\s-2\u[5]\d\s+2
clients. Defaults to false.

_L2MissNotification=_
Takes a boolean. When true, enables netlink LLADDR miss notifications.

_L3MissNotification=_
Takes a boolean. When true, enables netlink IP address miss notifications.

_RouteShortCircuit=_
Takes a boolean. When true, route short circuiting is turned on.

_UDPChecksum=_
Takes a boolean. When true, transmitting UDP checksums when doing VXLAN/IPv4 is turned on.

_UDP6ZeroChecksumTx=_
Takes a boolean. When true, sending zero checksums in VXLAN/IPv6 is turned on.

_UDP6ZeroChecksumRx=_
Takes a boolean. When true, receiving zero checksums in VXLAN/IPv6 is turned on.

_RemoteChecksumTx=_
Takes a boolean. When true, remote transmit checksum offload of VXLAN is turned on.

_RemoteChecksumRx=_
Takes a boolean. When true, remote receive checksum offload in VXLAN is turned on.

_GroupPolicyExtension=_
Takes a boolean. When true, it enables Group Policy VXLAN extension security label mechanism across network peers based on VXLAN. For details about the Group Policy VXLAN, see the
\m[blue]**VXLAN Group Policy**\m[]\s-2\u[6]\d\s+2
document. Defaults to false.

_DestinationPort=_
Configures the default destination UDP port on a per-device basis. If destination port is not specified then Linux kernel default will be used. Set destination port 4789 to get the IANA assigned value. If not set or if the destination port is assigned the empty string the default port of 4789 is used.

_PortRange=_
Configures VXLAN port range. VXLAN bases source UDP port based on flow to help the receiver to be able to load balance based on outer header flow. It restricts the port range to the normal UDP local ports, and allows overriding via configuration.

_FlowLabel=_
Specifies the flow label to use in outgoing packets. The valid range is 0-1048575.

<a name="geneve-section-options"></a>

# [Geneve] Section Options


The
"[GENEVE]"
section only applies for netdevs of kind
"geneve", and accepts the following keys:

_Id=_
Specifies the Virtual Network Identifier (VNI) to use. Ranges [0-16777215].

_Remote=_
Specifies the unicast destination IP address to use in outgoing packets.

_TOS=_
Specifies the TOS value to use in outgoing packets. Ranges [1-255].

_TTL=_
Specifies the TTL value to use in outgoing packets. Ranges [1-255].

_UDPChecksum=_
Takes a boolean. When true, specifies if UDP checksum is calculated for transmitted packets over IPv4.

_UDP6ZeroChecksumTx=_
Takes a boolean. When true, skip UDP checksum calculation for transmitted packets over IPv6.

_UDP6ZeroChecksumRx=_
Takes a boolean. When true, allows incoming UDP packets over IPv6 with zero checksum field.

_DestinationPort=_
Specifies destination port. Defaults to 6081. If not set or assigned the empty string, the default port of 6081 is used.

_FlowLabel=_
Specifies the flow label to use in outgoing packets.

<a name="tunnel-section-options"></a>

# [Tunnel] Section Options


The
"[Tunnel]"
section only applies for netdevs of kind
"ipip",
"sit",
"gre",
"gretap",
"ip6gre",
"ip6gretap",
"vti",
"vti6", and
"ip6tnl"
and accepts the following keys:

_Local=_
A static local address for tunneled packets. It must be an address on another interface of this host, or the special value
"any".

_Remote=_
The remote endpoint of the tunnel. Takes an IP address or the special value
"any".

_TOS=_
The Type Of Service byte value for a tunnel interface. For details about the TOS, see the
\m[blue]**Type of Service in the Internet Protocol Suite**\m[]\s-2\u[7]\d\s+2
document.

_TTL=_
A fixed Time To Live N on tunneled packets. N is a number in the range 1–255. 0 is a special value meaning that packets inherit the TTL value. The default value for IPv4 tunnels is: inherit. The default value for IPv6 tunnels is 64.

_DiscoverPathMTU=_
Takes a boolean. When true, enables Path MTU Discovery on the tunnel.

_IPv6FlowLabel=_
Configures the 20-bit flow label (see
\m[blue]**RFC 6437**\m[]\s-2\u[8]\d\s+2) field in the IPv6 header (see
\m[blue]**RFC 2460**\m[]\s-2\u[9]\d\s+2), which is used by a node to label packets of a flow. It is only used for IPv6 tunnels. A flow label of zero is used to indicate packets that have not been labeled. It can be configured to a value in the range 0–0xFFFFF, or be set to
"inherit", in which case the original flowlabel is used.

_CopyDSCP=_
Takes a boolean. When true, the Differentiated Service Code Point (DSCP) field will be copied to the inner header from outer header during the decapsulation of an IPv6 tunnel packet. DSCP is a field in an IP packet that enables different levels of service to be assigned to network traffic. Defaults to
"no".

_EncapsulationLimit=_
The Tunnel Encapsulation Limit option specifies how many additional levels of encapsulation are permitted to be prepended to the packet. For example, a Tunnel Encapsulation Limit option containing a limit value of zero means that a packet carrying that option may not enter another tunnel before exiting the current tunnel. (see
\m[blue]**RFC 2473**\m[]\s-2\u[10]\d\s+2). The valid range is 0–255 and
"none". Defaults to 4.

_Key=_
The
_Key=_
parameter specifies the same key to use in both directions (_InputKey=_
and
_OutputKey=_). The
_Key=_
is either a number or an IPv4 address-like dotted quad. It is used as mark-configured SAD/SPD entry as part of the lookup key (both in data and control path) in ip xfrm (framework used to implement IPsec protocol). See
\m[blue]**ip-xfrm — transform configuration**\m[]\s-2\u[11]\d\s+2
for details. It is only used for VTI/VTI6 tunnels.

_InputKey=_
The
_InputKey=_
parameter specifies the key to use for input. The format is same as
_Key=_. It is only used for VTI/VTI6 tunnels.

_OutputKey=_
The
_OutputKey=_
parameter specifies the key to use for output. The format is same as
_Key=_. It is only used for VTI/VTI6 tunnels.

_Mode=_
An
"ip6tnl"
tunnel can be in one of three modes
"ip6ip6"
for IPv6 over IPv6,
"ipip6"
for IPv4 over IPv6 or
"any"
for either.

_Independent=_
Takes a boolean. When true tunnel does not require .network file. Created as "tunnel@NONE". Defaults to
"false".

_AllowLocalRemote=_
Takes a boolean. When true allows tunnel traffic on
_ip6tnl_
devices where the remote endpoint is a local host address. When unset, the kernels default will be used.

_FooOverUDP=_
Takes a boolean. Specifies whether
_FooOverUDP=_
tunnel is to be configured. Defaults to false. For more detail information see
\m[blue]**Foo over UDP**\m[]\s-2\u[12]\d\s+2

_FOUDestinationPort=_
This setting specifies the UDP destination port for encapsulation. This field is mandatory and is not set by default.

_FOUSourcePort=_
This setting specifies the UDP source port for encapsulation. Defaults to
**0**
— that is, the source port for packets is left to the network stack to decide.

_Encapsulation=_
Accepts the same key as
"[FooOverUDP]"

_IPv6RapidDeploymentPrefix=_
Reconfigure the tunnel for
\m[blue]**IPv6 Rapid Deployment**\m[]\s-2\u[13]\d\s+2, also known as 6rd. The value is an ISP-specific IPv6 prefix with a non-zero length. Only applicable to SIT tunnels.

_ISATAP=_
Takes a boolean. If set, configures the tunnel as Intra-Site Automatic Tunnel Addressing Protocol (ISATAP) tunnel. Only applicable to SIT tunnels. When unset, the kernels default will be used.

_SerializeTunneledPackets=_
Takes a boolean. If set to yes, then packets are serialized. Only applies for ERSPAN tunnel. When unset, the kernels default will be used.

_ERSPANIndex=_
Specifies the ERSPAN index field for the interface, an integer in the range 1-1048575 associated with the ERSPAN traffics source port and direction. This field is mandatory.

<a name="foooverudp-section-options"></a>

# [Foooverudp] Section Options


The
"[FooOverUDP]"
section only applies for netdevs of kind
"fou"
and accepts the following keys:

_Protocol=_
The
_Protocol=_
specifies the protocol number of the packets arriving at the UDP port. This field is mandatory and is not set by default. Valid range is 1-255.

_Encapsulation=_
Specifies the encapsulation mechanism used to store networking packets of various protocols inside the UDP packets. Supports the following values:
"FooOverUDP"
provides the simplest no frills model of UDP encapsulation, it simply encapsulates packets directly in the UDP payload.
"GenericUDPEncapsulation"
is a generic and extensible encapsulation, it allows encapsulation of packets for any IP protocol and optional data as part of the encapsulation. For more detailed information see
\m[blue]**Generic UDP Encapsulation**\m[]\s-2\u[14]\d\s+2. Defaults to
"FooOverUDP".

_Port=_
Specifies the port number, where the IP encapsulation packets will arrive. Please take note that the packets will arrive with the encapsulation will be removed. Then they will be manually fed back into the network stack, and sent ahead for delivery to the real destination. This option is mandatory.

<a name="peer-section-options"></a>

# [Peer] Section Options


The
"[Peer]"
section only applies for netdevs of kind
"veth"
and accepts the following keys:

_Name=_
The interface name used when creating the netdev. This option is compulsory.

_MACAddress=_
The peer MACAddress, if not set, it is generated in the same way as the MAC address of the main interface.

<a name="vxcan-section-options"></a>

# [Vxcan] Section Options


The
"[VXCAN]"
section only applies for netdevs of kind
"vxcan"
and accepts the following key:

_Peer=_
The peer interface name used when creating the netdev. This option is compulsory.

<a name="tun-section-options"></a>

# [Tun] Section Options


The
"[Tun]"
section only applies for netdevs of kind
"tun", and accepts the following keys:

_OneQueue=_
Takes a boolean. Configures whether all packets are queued at the device (enabled), or a fixed number of packets are queued at the device and the rest at the
"qdisc". Defaults to
"no".

_MultiQueue=_
Takes a boolean. Configures whether to use multiple file descriptors (queues) to parallelize packets sending and receiving. Defaults to
"no".

_PacketInfo=_
Takes a boolean. Configures whether packets should be prepended with four extra bytes (two flag bytes and two protocol bytes). If disabled, it indicates that the packets will be pure IP packets. Defaults to
"no".

_VNetHeader=_
Takes a boolean. Configures IFF_VNET_HDR flag for a tap device. It allows sending and receiving larger Generic Segmentation Offload (GSO) packets. This may increase throughput significantly. Defaults to
"no".

_User=_
User to grant access to the
/dev/net/tun
device.

_Group=_
Group to grant access to the
/dev/net/tun
device.

<a name="tap-section-options"></a>

# [Tap] Section Options


The
"[Tap]"
section only applies for netdevs of kind
"tap", and accepts the same keys as the
"[Tun]"
section.

<a name="wireguard-section-options"></a>

# [Wireguard] Section Options


The
"[WireGuard]"
section accepts the following keys:

_PrivateKey=_
The Base64 encoded private key for the interface. It can be generated using the
**wg genkey**
command (see
**wg**(8)). This option is mandatory to use WireGuard. Note that because this information is secret, you may want to set the permissions of the .netdev file to be owned by
"root:systemd-network"
with a
"0640"
file mode.

_ListenPort=_
Sets UDP port for listening. Takes either value between 1 and 65535 or
"auto". If
"auto"
is specified, the port is automatically generated based on interface name. Defaults to
"auto".

_FwMark=_
Sets a firewall mark on outgoing WireGuard packets from this interface.

<a name="wireguardpeer-section-options"></a>

# [Wireguardpeer] Section Options


The
"[WireGuardPeer]"
section accepts the following keys:

_PublicKey=_
Sets a Base64 encoded public key calculated by
**wg pubkey**
(see
**wg**(8)) from a private key, and usually transmitted out of band to the author of the configuration file. This option is mandatory for this section.

_PresharedKey=_
Optional preshared key for the interface. It can be generated by the
**wg genpsk**
command. This option adds an additional layer of symmetric-key cryptography to be mixed into the already existing public-key cryptography, for post-quantum resistance. Note that because this information is secret, you may want to set the permissions of the .netdev file to be owned by
"root:systemd-networkd"
with a
"0640"
file mode.

_AllowedIPs=_
Sets a comma-separated list of IP (v4 or v6) addresses with CIDR masks from which this peer is allowed to send incoming traffic and to which outgoing traffic for this peer is directed. The catch-all 0.0.0.0/0 may be specified for matching all IPv4 addresses, and ::/0 may be specified for matching all IPv6 addresses.

_Endpoint=_
Sets an endpoint IP address or hostname, followed by a colon, and then a port number. This endpoint will be updated automatically once to the most recent source IP address and port of correctly authenticated packets from the peer at configuration time.

_PersistentKeepalive=_
Sets a seconds interval, between 1 and 65535 inclusive, of how often to send an authenticated empty packet to the peer for the purpose of keeping a stateful firewall or NAT mapping valid persistently. For example, if the interface very rarely sends traffic, but it might at anytime receive traffic from a peer, and it is behind NAT, the interface might benefit from having a persistent keepalive interval of 25 seconds. If set to 0 or "off", this option is disabled. By default or when unspecified, this option is off. Most users will not need this.

<a name="bond-section-options"></a>

# [Bond] Section Options


The
"[Bond]"
section accepts the following key:

_Mode=_
Specifies one of the bonding policies. The default is
"balance-rr"
(round robin). Possible values are
"balance-rr",
"active-backup",
"balance-xor",
"broadcast",
"802.3ad",
"balance-tlb", and
"balance-alb".

_TransmitHashPolicy=_
Selects the transmit hash policy to use for slave selection in balance-xor, 802.3ad, and tlb modes. Possible values are
"layer2",
"layer3+4",
"layer2+3",
"encap2+3", and
"encap3+4".

_LACPTransmitRate=_
Specifies the rate with which link partner transmits Link Aggregation Control Protocol Data Unit packets in 802.3ad mode. Possible values are
"slow", which requests partner to transmit LACPDUs every 30 seconds, and
"fast", which requests partner to transmit LACPDUs every second. The default value is
"slow".

_MIIMonitorSec=_
Specifies the frequency that Media Independent Interface link monitoring will occur. A value of zero disables MII link monitoring. This value is rounded down to the nearest millisecond. The default value is 0.

_UpDelaySec=_
Specifies the delay before a link is enabled after a link up status has been detected. This value is rounded down to a multiple of MIIMonitorSec. The default value is 0.

_DownDelaySec=_
Specifies the delay before a link is disabled after a link down status has been detected. This value is rounded down to a multiple of MIIMonitorSec. The default value is 0.

_LearnPacketIntervalSec=_
Specifies the number of seconds between instances where the bonding driver sends learning packets to each slave peer switch. The valid range is 1–0x7fffffff; the default value is 1. This option has an effect only for the balance-tlb and balance-alb modes.

_AdSelect=_
Specifies the 802.3ad aggregation selection logic to use. Possible values are
"stable",
"bandwidth"
and
"count".

_AdActorSystemPriority=_
Specifies the 802.3ad actor system priority. Ranges [1-65535].

_AdUserPortKey=_
Specifies the 802.3ad user defined portion of the port key. Ranges [0-1023].

_AdActorSystem=_
Specifies the 802.3ad system mac address. This can not be either NULL or Multicast.

_FailOverMACPolicy=_
Specifies whether the active-backup mode should set all slaves to the same MAC address at the time of enslavement or, when enabled, to perform special handling of the bonds MAC address in accordance with the selected policy. The default policy is none. Possible values are
"none",
"active"
and
"follow".

_ARPValidate=_
Specifies whether or not ARP probes and replies should be validated in any mode that supports ARP monitoring, or whether non-ARP traffic should be filtered (disregarded) for link monitoring purposes. Possible values are
"none",
"active",
"backup"
and
"all".

_ARPIntervalSec=_
Specifies the ARP link monitoring frequency. A value of 0 disables ARP monitoring. The default value is 0, and the default unit seconds.

_ARPIPTargets=_
Specifies the IP addresses to use as ARP monitoring peers when ARPIntervalSec is greater than 0. These are the targets of the ARP request sent to determine the health of the link to the targets. Specify these values in IPv4 dotted decimal format. At least one IP address must be given for ARP monitoring to function. The maximum number of targets that can be specified is 16. The default value is no IP addresses.

_ARPAllTargets=_
Specifies the quantity of ARPIPTargets that must be reachable in order for the ARP monitor to consider a slave as being up. This option affects only active-backup mode for slaves with ARPValidate enabled. Possible values are
"any"
and
"all".

_PrimaryReselectPolicy=_
Specifies the reselection policy for the primary slave. This affects how the primary slave is chosen to become the active slave when failure of the active slave or recovery of the primary slave occurs. This option is designed to prevent flip-flopping between the primary slave and other slaves. Possible values are
"always",
"better"
and
"failure".

_ResendIGMP=_
Specifies the number of IGMP membership reports to be issued after a failover event. One membership report is issued immediately after the failover, subsequent packets are sent in each 200ms interval. The valid range is 0–255. Defaults to 1. A value of 0 prevents the IGMP membership report from being issued in response to the failover event.

_PacketsPerSlave=_
Specify the number of packets to transmit through a slave before moving to the next one. When set to 0, then a slave is chosen at random. The valid range is 0–65535. Defaults to 1. This option only has effect when in balance-rr mode.

_GratuitousARP=_
Specify the number of peer notifications (gratuitous ARPs and unsolicited IPv6 Neighbor Advertisements) to be issued after a failover event. As soon as the link is up on the new slave, a peer notification is sent on the bonding device and each VLAN sub-device. This is repeated at each link monitor interval (ARPIntervalSec or MIIMonitorSec, whichever is active) if the number is greater than 1. The valid range is 0–255. The default value is 1. These options affect only the active-backup mode.

_AllSlavesActive=_
Takes a boolean. Specifies that duplicate frames (received on inactive ports) should be dropped when false, or delivered when true. Normally, bonding will drop duplicate frames (received on inactive ports), which is desirable for most users. But there are some times it is nice to allow duplicate frames to be delivered. The default value is false (drop duplicate frames received on inactive ports).

_DynamicTransmitLoadBalancing=_
Takes a boolean. Specifies if dynamic shuffling of flows is enabled. Applies only for balance-tlb mode. Defaults to unset.

_MinLinks=_
Specifies the minimum number of links that must be active before asserting carrier. The default value is 0.

For more detail information see
\m[blue]**Linux Ethernet Bonding Driver HOWTO**\m[]\s-2\u[1]\d\s+2

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;/etc/systemd/network/25-bridge.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=bridge0
    Kind=bridge
.if n \{.RE
.\}

**Example&nbsp;2.&nbsp;/etc/systemd/network/25-vlan1.netdev**

.if n \{.RS 4
.\}
    [Match]
    Virtualization=no
    
    [NetDev]
    Name=vlan1
    Kind=vlan
    
    [VLAN]
    Id=1
.if n \{.RE
.\}

**Example&nbsp;3.&nbsp;/etc/systemd/network/25-ipip.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=ipip-tun
    Kind=ipip
    MTUBytes=1480
    
    [Tunnel]
    Local=192.168.223.238
    Remote=192.169.224.239
    TTL=64
.if n \{.RE
.\}

**Example&nbsp;4.&nbsp;/etc/systemd/network/1-fou-tunnel.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=fou-tun
    Kind=fou
    
    [FooOverUDP]
    Port=5555
    Protocol=4
          
.if n \{.RE
.\}

**Example&nbsp;5.&nbsp;/etc/systemd/network/25-fou-ipip.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=ipip-tun
    Kind=ipip
    
    [Tunnel]
    Independent=yes
    Local=10.65.208.212
    Remote=10.65.208.211
    FooOverUDP=yes
    FOUDestinationPort=5555
          
.if n \{.RE
.\}

**Example&nbsp;6.&nbsp;/etc/systemd/network/25-tap.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=tap-test
    Kind=tap
    
    [Tap]
    MultiQueue=yes
    PacketInfo=yes
.if n \{.RE
.\}

**Example&nbsp;7.&nbsp;/etc/systemd/network/25-sit.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=sit-tun
    Kind=sit
    MTUBytes=1480
    
    [Tunnel]
    Local=10.65.223.238
    Remote=10.65.223.239
.if n \{.RE
.\}

**Example&nbsp;8.&nbsp;/etc/systemd/network/25-6rd.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=6rd-tun
    Kind=sit
    MTUBytes=1480
    
    [Tunnel]
    Local=10.65.223.238
    IPv6RapidDeploymentPrefix=2602::/24
.if n \{.RE
.\}

**Example&nbsp;9.&nbsp;/etc/systemd/network/25-gre.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=gre-tun
    Kind=gre
    MTUBytes=1480
    
    [Tunnel]
    Local=10.65.223.238
    Remote=10.65.223.239
.if n \{.RE
.\}

**Example&nbsp;10.&nbsp;/etc/systemd/network/25-vti.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=vti-tun
    Kind=vti
    MTUBytes=1480
    
    [Tunnel]
    Local=10.65.223.238
    Remote=10.65.223.239
.if n \{.RE
.\}

**Example&nbsp;11.&nbsp;/etc/systemd/network/25-veth.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=veth-test
    Kind=veth
    
    [Peer]
    Name=veth-peer
.if n \{.RE
.\}

**Example&nbsp;12.&nbsp;/etc/systemd/network/25-bond.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=bond1
    Kind=bond
    
    [Bond]
    Mode=802.3ad
    TransmitHashPolicy=layer3+4
    MIIMonitorSec=1s
    LACPTransmitRate=fast
.if n \{.RE
.\}

**Example&nbsp;13.&nbsp;/etc/systemd/network/25-dummy.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=dummy-test
    Kind=dummy
    MACAddress=12:34:56:78:9a:bc
.if n \{.RE
.\}

**Example&nbsp;14.&nbsp;/etc/systemd/network/25-vrf.netdev**

Create a VRF interface with table 42.

.if n \{.RS 4
.\}
    [NetDev]
    Name=vrf-test
    Kind=vrf
    
    [VRF]
    Table=42
.if n \{.RE
.\}

**Example&nbsp;15.&nbsp;/etc/systemd/network/25-macvtap.netdev**

Create a MacVTap device.

.if n \{.RS 4
.\}
    [NetDev]
    Name=macvtap-test
    Kind=macvtap
          
.if n \{.RE
.\}

**Example&nbsp;16.&nbsp;/etc/systemd/network/25-wireguard.netdev**

.if n \{.RS 4
.\}
    [NetDev]
    Name=wg0
    Kind=wireguard
    
    [WireGuard]
    PrivateKey=EEGlnEPYJV//kbvvIqxKkQwOiS+UENyPncC4bF46ong=
    ListenPort=51820
    
    [WireGuardPeer]
    PublicKey=RDf+LSpeEre7YEIKaxg+wbpsNV7du+ktR99uBEtIiCA=
    AllowedIPs=fd31:bf08:57cb::/48,192.168.26.0/24
    Endpoint=wireguard.example.com:51820
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-networkd**(8),
**systemd.link**(5),
**systemd.network**(5)

<a name="notes"></a>

# Notes


*  1.  
  Linux Ethernet Bonding Driver HOWTO
      https://www.kernel.org/doc/Documentation/networking/bonding.txt
*  2.  
  RFC 2784
      https://tools.ietf.org/html/rfc2784
*  3.  
  IEEE 802.1Q
      http://www.ieee802.org/1/pages/802.1Q.html
*  4.  
  VRF
      https://www.kernel.org/doc/Documentation/networking/vrf.txt
*  5.  
  (DVOE)
      https://en.wikipedia.org/wiki/Distributed_Overlay_Virtual_Ethernet
*  6.  
  VXLAN Group Policy
      https://tools.ietf.org/html/draft-smith-vxlan-group-policy
*  7.  
  Type of Service in the Internet Protocol Suite
      http://tools.ietf.org/html/rfc1349
*  8.  
  RFC 6437
      https://tools.ietf.org/html/rfc6437
*  9.  
  RFC 2460
      https://tools.ietf.org/html/rfc2460
* 10.  
  RFC 2473
      https://tools.ietf.org/html/rfc2473#section-4.1.1
* 11.  
  ip-xfrm — transform configuration
      http://man7.org/linux/man-pages/man8/ip-xfrm.8.html
* 12.  
  Foo over UDP
      https://lwn.net/Articles/614348
* 13.  
  IPv6 Rapid Deployment
      https://tools.ietf.org/html/rfc5569
* 14.  
  Generic UDP Encapsulation
      https://lwn.net/Articles/615044
