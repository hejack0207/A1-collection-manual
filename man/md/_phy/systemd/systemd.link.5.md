# systemd\&.link(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.link - Network device configuration

<a name="synopsis"></a>

# Synopsis

```

 link.link
```

<a name="description"></a>

# Description


Network link configuration is performed by the
**net\_setup\_link**
udev builtin.

The link files are read from the files located in the system network directory
/usr/lib/systemd/network, the volatile runtime network directory
/run/systemd/network, and the local administration network directory
/etc/systemd/network. Link files must have the extension
.link; other extensions are ignored. All link files are collectively sorted and processed in lexical order, regardless of the directories in which they live. However, files with identical filenames replace each other. Files in
/etc
have the highest priority, files in
/run
take precedence over files with the same name in
/usr/lib. This can be used to override a system-supplied link file with a local file if needed. As a special case, an empty file (file size 0) or symlink with the same name pointing to
/dev/null
disables the configuration file entirely (it is "masked").

The link file contains a [Match] section, which determines if a given link file may be applied to a given device, as well as a [Link] section specifying how the device should be configured. The first (in lexical order) of the link files that matches a given device is applied. Note that a default file
99-default.link
is shipped by the system. Any user-supplied
.link
should hence have a lexically earlier name to be considered at all.

See
**udevadm**(8)
for diagnosing problems with
.link
files.

<a name="match-section-options"></a>

# [Match] Section Options


A link file is said to match a device if each of the entries in the [Match] section matches, or if the section is empty. The following keys are accepted:

_MACAddress=_
A whitespace-separated list of hardware addresses. Use full colon-, hyphen- or dot-delimited hexadecimal. See the example below. This option may appear more than once, in which case the lists are merged. If the empty string is assigned to this option, the list of hardware addresses defined prior to this is reset.

Example:

.if n \{.RS 4
.\}
    MACAddress=01:23:45:67:89:ab 00-11-22-33-44-55 AABB.CCDD.EEFF
.if n \{.RE
.\}

_OriginalName=_
A whitespace-separated list of shell-style globs matching the device name, as exposed by the udev property "INTERFACE". This cannot be used to match on names that have already been changed from userspace. Caution is advised when matching on kernel-assigned names, as they are known to be unstable between reboots.

_Path=_
A whitespace-separated list of shell-style globs matching the persistent path, as exposed by the udev property
_ID\_PATH_.

_Driver=_
A whitespace-separated list of shell-style globs matching the driver currently bound to the device, as exposed by the udev property
_ID\_NET\_DRIVER_
of its parent device, or if that is not set, the driver as exposed by
**ethtool -i**
of the device itself.

_Type=_
A whitespace-separated list of shell-style globs matching the device type, as exposed by the udev property
_DEVTYPE_.

_Host=_
Matches against the hostname or machine ID of the host. See
_ConditionHost=_
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

_Virtualization=_
Checks whether the system is executed in a virtualized environment and optionally test whether it is a specific implementation. See
_ConditionVirtualization=_
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

_KernelCommandLine=_
Checks whether a specific kernel command line option is set. See
_ConditionKernelCommandLine=_
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

_KernelVersion=_
Checks whether the kernel version (as reported by
**uname -r**) matches a certain expression. See
_ConditionKernelVersion=_
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

_Architecture=_
Checks whether the system is running on a specific architecture. See
_ConditionArchitecture=_
in
**systemd.unit**(5)
for details. When prefixed with an exclamation mark ("!"), the result is negated. If an empty string is assigned, then previously assigned value is cleared.

<a name="link-section-options"></a>

# [Link] Section Options


The [Link] section accepts the following keys:

_Description=_
A description of the device.

_Alias=_
The
_ifalias_
interface property is set to this value.

_MACAddressPolicy=_
The policy by which the MAC address should be set. The available policies are:

**persistent**
If the hardware has a persistent MAC address, as most hardware should, and if it is used by the kernel, nothing is done. Otherwise, a new MAC address is generated which is guaranteed to be the same on every boot for the given machine and the given device, but which is otherwise random. This feature depends on ID_NET_NAME_* properties to exist for the link. On hardware where these properties are not set, the generation of a persistent MAC address will fail.

**random**
If the kernel is using a random MAC address, nothing is done. Otherwise, a new address is randomly generated each time the device appears, typically at boot. Either way, the random address will have the
"unicast"
and
"locally administered"
bits set.

**none**
Keeps the MAC address assigned by the kernel.

_MACAddress=_
The MAC address to use, if no
_MACAddressPolicy=_
is specified.

_NamePolicy=_
An ordered, space-separated list of policies by which the interface name should be set.
_NamePolicy=_
may be disabled by specifying
**net.ifnames=0**
on the kernel command line. Each of the policies may fail, and the first successful one is used. The name is not set directly, but is exported to udev as the property
**ID\_NET\_NAME**, which is, by default, used by a udev rule to set
_NAME_. The available policies are:

**kernel**
If the kernel claims that the name it has set for a device is predictable, then no renaming is performed.

**database**
The name is set based on entries in the udevs Hardware Database with the key
_ID\_NET\_NAME\_FROM\_DATABASE_.

**onboard**
The name is set based on information given by the firmware for on-board devices, as exported by the udev property
_ID\_NET\_NAME\_ONBOARD_.

**slot**
The name is set based on information given by the firmware for hot-plug devices, as exported by the udev property
_ID\_NET\_NAME\_SLOT_.

**path**
The name is set based on the devices physical location, as exported by the udev property
_ID\_NET\_NAME\_PATH_.

**mac**
The name is set based on the devices persistent MAC address, as exported by the udev property
_ID\_NET\_NAME\_MAC_.

**keep**
If the device already had a name given by userspace (as part of creation of the device or a rename), keep it.

_Name=_
The interface name to use in case all the policies specified in
_NamePolicy=_
fail, or in case
_NamePolicy=_
is missing or disabled.

Note that specifying a name that the kernel might use for another interface (for example
"eth0") is dangerous because the name assignment done by udev will race with the assignment done by the kernel, and only one interface may use the name. Depending on the order of operations, either udev or the kernel will win, making the naming unpredictable. It is best to use some different prefix, for example
"internal0"/"external0"
or
"lan0"/"lan1"/"lan3".

_MTUBytes=_
The maximum transmission unit in bytes to set for the device. The usual suffixes K, M, G, are supported and are understood to the base of 1024.

_BitsPerSecond=_
The speed to set for the device, the value is rounded down to the nearest Mbps. The usual suffixes K, M, G, are supported and are understood to the base of 1000.

_Duplex=_
The duplex mode to set for the device. The accepted values are
**half**
and
**full**.

_AutoNegotiation=_
Takes a boolean. If set to yes, automatic negotiation of transmission parameters is enabled. Autonegotiation is a procedure by which two connected ethernet devices choose common transmission parameters, such as speed, duplex mode, and flow control. When unset, the kernels default will be used.

Note that if autonegotiation is enabled, speed and duplex settings are read-only. If autonegotation is disabled, speed and duplex settings are writable if the driver supports multiple link modes.

_WakeOnLan=_
The Wake-on-LAN policy to set for the device. The supported values are:

**phy**
Wake on PHY activity.

**unicast**
Wake on unicast messages.

**multicast**
Wake on multicast messages.

**broadcast**
Wake on broadcast messages.

**arp**
Wake on ARP.

**magic**
Wake on receipt of a magic packet.

**secureon**
Enable secureon(tm) password for MagicPacket(tm).

**off**
Never wake.

Defaults to
**off**.

_Port=_
The port option is used to select the device port. The supported values are:

**tp**
An Ethernet interface using Twisted-Pair cable as the medium.

**aui**
Attachment Unit Interface (AUI). Normally used with hubs.

**bnc**
An Ethernet interface using BNC connectors and co-axial cable.

**mii**
An Ethernet interface using a Media Independent Interface (MII).

**fibre**
An Ethernet interface using Optical Fibre as the medium.

_Advertise=_
This sets what speeds and duplex modes of operation are advertised for auto-negotiation. This implies
"AutoNegotiation=yes". The supported values are:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Supported advertise values**
.TS
allbox tab(:);
lB lB lB.
T{
Advertise
T}:T{
Speed (Mbps)
T}:T{
Duplex Mode
T}
.T&
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l.
T{
**10baset-half**
T}:T{
10
T}:T{
half
T}
T{
**10baset-full**
T}:T{
10
T}:T{
full
T}
T{
**100baset-half**
T}:T{
100
T}:T{
half
T}
T{
**100baset-full**
T}:T{
100
T}:T{
full
T}
T{
**1000baset-half**
T}:T{
1000
T}:T{
half
T}
T{
**1000baset-full**
T}:T{
1000
T}:T{
full
T}
T{
**10000baset-full**
T}:T{
10000
T}:T{
full
T}
T{
**2500basex-full**
T}:T{
2500
T}:T{
full
T}
T{
**1000basekx-full**
T}:T{
1000
T}:T{
full
T}
T{
**10000basekx4-full**
T}:T{
10000
T}:T{
full
T}
T{
**10000basekr-full**
T}:T{
10000
T}:T{
full
T}
T{
**10000baser-fec**
T}:T{
10000
T}:T{
full
T}
T{
**20000basemld2-full**
T}:T{
20000
T}:T{
full
T}
T{
**20000basekr2-full**
T}:T{
20000
T}:T{
full
T}
.TE

By default this is unset, i.e. all possible modes will be advertised. This option may be specified more than once, in which case all specified speeds and modes are advertised. If the empty string is assigned to this option, the list is reset, and all prior assignments have no effect.

_TCPSegmentationOffload=_
Takes a boolean. If set to true, the TCP Segmentation Offload (TSO) is enabled. When unset, the kernels default will be used.

_TCP6SegmentationOffload=_
Takes a boolean. If set to true, the TCP6 Segmentation Offload (tx-tcp6-segmentation) is enabled. When unset, the kernels default will be used.

_GenericSegmentationOffload=_
Takes a boolean. If set to true, the Generic Segmentation Offload (GSO) is enabled. When unset, the kernels default will be used.

_GenericReceiveOffload=_
Takes a boolean. If set to true, the Generic Receive Offload (GRO) is enabled. When unset, the kernels default will be used.

_LargeReceiveOffload=_
Takes a boolean. If set to true, the Large Receive Offload (LRO) is enabled. When unset, the kernels default will be used.

_RxChannels=_
Sets the number of receive channels (a number between 1 and 4294967295) .

_TxChannels=_
Sets the number of transmit channels (a number between 1 and 4294967295).

_OtherChannels=_
Sets the number of other channels (a number between 1 and 4294967295).

_CombinedChannels=_
Sets the number of combined set channels (a number between 1 and 4294967295).

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;/usr/lib/systemd/network/99-default.link**

The link file
99-default.link
that is shipped with systemd defines the default naming policy for links.

.if n \{.RS 4
.\}
    [Link]
    NamePolicy=kernel database onboard slot path
    MACAddressPolicy=persistent
.if n \{.RE
.\}

**Example&nbsp;2.&nbsp;/etc/systemd/network/10-dmz.link**

This example assigns the fixed name
"dmz0"
to the interface with the MAC address 00:a0:de:63:7a:e6:

.if n \{.RS 4
.\}
    [Match]
    MACAddress=00:a0:de:63:7a:e6
    
    [Link]
    Name=dmz0
.if n \{.RE
.\}

**Example&nbsp;3.&nbsp;/etc/systemd/network/10-internet.link**

This example assigns the fixed name
"internet0"
to the interface with the device path
"pci-0000:00:1a.0-*":

.if n \{.RS 4
.\}
    [Match]
    Path=pci-0000:00:1a.0-*
    
    [Link]
    Name=internet0
.if n \{.RE
.\}

**Example&nbsp;4.&nbsp;/etc/systemd/network/25-wireless.link**

Heres an overly complex example that shows the use of a large number of [Match] and [Link] settings.

.if n \{.RS 4
.\}
    [Match]
    MACAddress=12:34:56:78:9a:bc
    Driver=brcmsmac
    Path=pci-0000:02:00.0-*
    Type=wlan
    Virtualization=no
    Host=my-laptop
    Architecture=x86-64
    
    [Link]
    Name=wireless0
    MTUBytes=1450
    BitsPerSecond=10M
    WakeOnLan=magic
    MACAddress=cb:a9:87:65:43:21
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd-udevd.service**(8),
**udevadm**(8),
**systemd.netdev**(5),
**systemd.network**(5)
