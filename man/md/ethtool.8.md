# ethtool(8) - query or control network driver and hardware settings

Version 4.17, June 2018


<a name="synopsis"></a>

# Synopsis


```
.na .nh .HP ethtool devname .HP ethtool -h|--help .HP ethtool --version .HP ethtool -a|--show-pause devname .HP ethtool -A|--pause devname .B2 autoneg on off .B2 rx on off .B2 tx on off .HP ethtool -c|--show-coalesce devname .HP ethtool -C|--coalesce devname .B2 adaptive-rx on off .B2 adaptive-tx on off .BN rx-usecs .BN rx-frames .BN rx-usecs-irq .BN rx-frames-irq .BN tx-usecs .BN tx-frames .BN tx-usecs-irq .BN tx-frames-irq .BN stats-block-usecs .BN pkt-rate-low .BN rx-usecs-low .BN rx-frames-low .BN tx-usecs-low .BN tx-frames-low .BN pkt-rate-high .BN rx-usecs-high .BN rx-frames-high .BN tx-usecs-high .BN tx-frames-high .BN sample-interval .HP ethtool -g|--show-ring devname .HP ethtool -G|--set-ring devname .BN rx .BN rx-mini .BN rx-jumbo .BN tx .HP ethtool -i|--driver devname .HP ethtool -d|--register-dump devname .B2 raw on off .B2 hex on off [file name] .HP ethtool -e|--eeprom-dump devname .B2 raw on off .BN offset .BN length .HP ethtool -E|--change-eeprom devname .BN magic .BN offset .BN length .BN value .HP ethtool -k|--show-features|--show-offload devname .HP ethtool -K|--features|--offload devname feature .A1 on off ... .HP ethtool -p|--identify devname [N] .HP ethtool -P|--show-permaddr devname .HP ethtool -r|--negotiate devname .HP ethtool -S|--statistics devname .HP ethtool --phy-statistics devname .HP ethtool -t|--test devname [] .HP ethtool -s devname .BN speed .B2 duplex half full .B4 port tp aui bnc mii fibre .B3 mdix auto on off .B2 autoneg on off .BN advertise .BN phyad .B2 xcvr internal external [wol&nbsp;] [sopass&nbsp;] [msglvl N&nbsp;| msglvl&nbsp;type .A1 on off ...] .HP ethtool -n|-u|--show-nfc|--show-ntuple devname [&nbsp;rx-flow-hash&nbsp;&nbsp;|
rule&nbsp;N ] .HP ethtool -N|-U|--config-nfc|--config-ntuple devname rx-flow-hash&nbsp;&nbsp;​\*(HO&nbsp;|
flow-type  [src&nbsp;&nbsp;[m&nbsp;\*(MA]] [dst&nbsp;&nbsp;[m&nbsp;\*(MA]] .BM proto [src-ip&nbsp;&nbsp;[m&nbsp;\*(PA]] [dst-ip&nbsp;&nbsp;[m&nbsp;\*(PA]] .BM tos .BM tclass .BM l4proto .BM src-port .BM dst-port .BM spi .BM l4data .BM vlan-etype .BM vlan .BM user-def [dst-mac&nbsp;&nbsp;[m&nbsp;\*(MA]] .BN action .BN context .BN loc |
delete&nbsp;N .HP ethtool -w|--get-dump devname [data filename] .HP ethtool&nbsp;-W|--set-dump devname N .HP ethtool -T|--show-time-stamping devname .HP ethtool -x|--show-rxfh-indir|--show-rxfh devname .HP ethtool -X|--set-rxfh-indir|--rxfh devname [hkey&nbsp;:\...] [&nbsp;equal N&nbsp;| weight&nbsp;W0 W1 ...&nbsp;|&nbsp;default&nbsp;] [hfunc FUNC] [context CTX |&nbsp;new] [delete] .HP ethtool -f|--flash devname file [N] .HP ethtool -l|--show-channels devname .HP ethtool -L|--set-channels devname .BN rx .BN tx .BN other .BN combined .HP ethtool -m|--dump-module-eeprom|--module-info devname .B2 raw on off .B2 hex on off .BN offset .BN length .HP ethtool --show-priv-flags devname .HP ethtool --set-priv-flags devname flag .A1 on off ... .HP ethtool --show-eee devname .HP ethtool --set-eee devname .B2 eee on off .B2 tx-lpi on off .BN tx-timer .BN advertise .HP ethtool --set-phy-tunable devname [ downshift .A1 on off .BN count ] .HP ethtool --get-phy-tunable devname [downshift] .HP ethtool --reset devname .BN flags [mgmt] [mgmt-shared] [irq] [irq-shared] [dma] [dma-shared] [filter] [filter-shared] [offload] [offload-shared] [mac] [mac-shared] [phy] [phy-shared] [ram] [ram-shared] [ap] [ap-shared] [dedicated] [all] .HP ethtool --show-fec devname .HP ethtool --set-fec devname .B4 encoding auto off rs baser
```



<a name="description"></a>

# Description

**ethtool**
is used to query and control network device driver and hardware
settings, particularly for wired Ethernet devices.

_devname_
is the name of the network device on which ethtool should operate.


<a name="options"></a>

# Options

**ethtool**
with a single argument specifying the device name prints current
settings of the specified device.

* **-h --help**  
  Shows a short help message.
* **--version**  
  Shows the ethtool version number.
* **-a --show-pause**  
  Queries the specified Ethernet device for pause parameter information.
* **-A --pause**  
  Changes the pause parameters of the specified Ethernet device.
    * .A2 autoneg on off  
      Specifies whether pause autonegotiation should be enabled.
    * .A2 rx on off  
      Specifies whether RX pause should be enabled.
    * .A2 tx on off  
      Specifies whether TX pause should be enabled.
* **-c --show-coalesce**  
  Queries the specified network device for coalescing information.
* **-C --coalesce**  
  Changes the coalescing settings of the specified network device.
* **-g --show-ring**  
  Queries the specified network device for rx/tx ring parameter information.
* **-G --set-ring**  
  Changes the rx/tx ring parameters of the specified network device.
    * **rx**_&nbsp;N_  
      Changes the number of ring entries for the Rx ring.
    * **rx-mini**_&nbsp;N_  
      Changes the number of ring entries for the Rx Mini ring.
    * **rx-jumbo**_&nbsp;N_  
      Changes the number of ring entries for the Rx Jumbo ring.
    * **tx**_&nbsp;N_  
      Changes the number of ring entries for the Tx ring.
* **-i --driver**  
  Queries the specified network device for associated driver information.
* **-d --register-dump**  
  Retrieves and prints a register dump for the specified network device.
  The register format for some devices is known and decoded others
  are printed in hex.
  When 
  _raw_
  is enabled, then ethtool dumps the raw register data to stdout.
  If
  _file_
  is specified, then use contents of previous raw register dump, rather
  than reading from the device.
* **-e --eeprom-dump**  
  Retrieves and prints an EEPROM dump for the specified network device.
  When raw is enabled, then it dumps the raw EEPROM data to stdout. The
  length and offset parameters allow dumping certain portions of the EEPROM.
  Default is to dump the entire EEPROM.
    * **raw**_&nbsp;on|off_  
    * **offset**_&nbsp;N_  
    * **length**_&nbsp;N_  
* **-E --change-eeprom**  
  If value is specified, changes EEPROM byte for the specified network device.
  offset and value specify which byte and it's new value. If value is not
  specified, stdin is read and written to the EEPROM. The length and offset
  parameters allow writing to certain portions of the EEPROM.
  Because of the persistent nature of writing to the EEPROM, a device-specific
  magic key must be specified to prevent the accidental writing to the EEPROM.
* **-k --show-features --show-offload**  
  Queries the specified network device for the state of protocol
  offload and other features.
* **-K --features --offload**  
  Changes the offload parameters and other features of the specified
  network device.  The following feature names are built-in and others
  may be defined by the kernel.
    * .A2 rx on off  
      Specifies whether RX checksumming should be enabled.
    * .A2 tx on off  
      Specifies whether TX checksumming should be enabled.
    * .A2 sg on off  
      Specifies whether scatter-gather should be enabled.
    * .A2 tso on off  
      Specifies whether TCP segmentation offload should be enabled.
    * .A2 ufo on off  
      Specifies whether UDP fragmentation offload should be enabled 
    * .A2 gso on off  
      Specifies whether generic segmentation offload should be enabled 
    * .A2 gro on off  
      Specifies whether generic receive offload should be enabled
    * .A2 lro on off  
      Specifies whether large receive offload should be enabled
    * .A2 rxvlan on off  
      Specifies whether RX VLAN acceleration should be enabled
    * .A2 txvlan on off  
      Specifies whether TX VLAN acceleration should be enabled
    * .A2 ntuple on off  
      Specifies whether Rx ntuple filters and actions should be enabled
    * .A2 rxhash on off  
      Specifies whether receive hashing offload should be enabled
* **-p --identify**  
  Initiates adapter-specific action intended to enable an operator to
  easily identify the adapter by sight.  Typically this involves
  blinking one or more LEDs on the specific network port.
    * .BN  
      Length of time to perform phys-id, in seconds.
* **-P --show-permaddr**  
  Queries the specified network device for permanent hardware address.
* **-r --negotiate**  
  Restarts auto-negotiation on the specified Ethernet device, if
  auto-negotiation is enabled.
* **-S --statistics**  
  Queries the specified network device for NIC- and driver-specific
  statistics.
* **--phy-statistics**  
  Queries the specified network device for PHY specific statistics.
* **-t --test**  
  Executes adapter selftest on the specified network device. Possible test modes are:
    * **offline**  
      Perform full set of tests, possibly interrupting normal operation
      during the tests,
    * **online**  
      Perform limited set of tests, not interrupting normal operation,
    * **external_lb**  
      Perform full set of tests, as for **offline**, and additionally an
      external-loopback test.
* **-s --change**  
  Allows changing some or all settings of the specified network device.
  All following options only apply if
  **-s**
  was specified.
    * **speed**_&nbsp;N_  
      Set speed in Mb/s.
      **ethtool**
      with just the device name as an argument will show you the supported device speeds.
    * .A2 duplex half full  
      Sets full or half duplex mode.
    * .A4 port tp aui bnc mii fibre  
      Selects device port.
    * .A3 mdix auto on off  
      Selects MDI-X mode for port. May be used to override the automatic
      detection feature of most adapters. An argument of **auto** means
      automatic detection of MDI status, **on** forces MDI-X (crossover)
      mode, while **off** means MDI (straight through) mode.  The driver
      should guarantee that this command takes effect immediately, and if
      necessary may reset the link to cause the change to take effect.
    * .A2 autoneg on off  
      Specifies whether autonegotiation should be enabled. Autonegotiation 
      is enabled by default, but in some network devices may have trouble
      with it, so you can disable it if really necessary. 
    * **advertise**_&nbsp;N_  
      Sets the speed and duplex advertised by autonegotiation.  The argument is
      a hexadecimal value using one or a combination of the following values:
      .TS
      nokeep;
      lB	l	lB.
      0x001	10baseT Half
      0x002	10baseT Full
      0x004	100baseT Half
      0x008	100baseT Full
      0x010	1000baseT Half	(not supported by IEEE standards)
      0x020	1000baseT Full
      0x20000	1000baseKX Full
      0x20000000000	1000baseX Full
      0x800000000000	2500baseT Full
      0x8000	2500baseX Full	(not supported by IEEE standards)
      0x1000000000000	5000baseT Full
      0x1000	10000baseT Full
      0x40000	10000baseKX4 Full
      0x80000	10000baseKR Full
      0x40000000000	10000baseCR  Full
      0x80000000000	10000baseSR  Full
      0x100000000000	10000baseLR  Full
      0x200000000000	10000baseLRM Full
      0x400000000000	10000baseER  Full
      0x200000	20000baseMLD2 Full	(not supported by IEEE standards)
      0x400000	20000baseKR2 Full	(not supported by IEEE standards)
      0x80000000	25000baseCR Full
      0x100000000	25000baseKR Full
      0x200000000	25000baseSR Full
      0x800000	40000baseKR4 Full
      0x1000000	40000baseCR4 Full
      0x2000000	40000baseSR4 Full
      0x4000000	40000baseLR4 Full
      0x400000000	50000baseCR2 Full
      0x800000000	50000baseKR2 Full
      0x10000000000	50000baseSR2 Full
      0x8000000	56000baseKR4 Full
      0x10000000	56000baseCR4 Full
      0x20000000	56000baseSR4 Full
      0x40000000	56000baseLR4 Full
      0x1000000000	100000baseKR4 Full
      0x2000000000	100000baseSR4 Full
      0x4000000000	100000baseCR4 Full
      0x8000000000	100000baseLR4_ER4 Full
      .TE
    * **phyad**_&nbsp;N_  
      PHY address.
    * .A2 xcvr internal external  
      Selects transceiver type. Currently only internal and external can be
      specified, in the future further types might be added.
    * **wol**&nbsp;  
      Sets Wake-on-LAN options.  Not all devices support this.  The argument to 
      this option is a string of characters specifying which options to enable.
      .TS
      nokeep;
      lB	l.
      p	Wake on PHY activity
      u	Wake on unicast messages
      m	Wake on multicast messages
      b	Wake on broadcast messages
      a	Wake on ARP
      g	Wake on MagicPacket\[tm]
      s	Enable SecureOn\[tm] password for MagicPacket\[tm]
      d	T{
      Disable (wake on nothing).  This option clears all previous options.
      T}
      .TE
    * **sopass **  
      Sets the SecureOn\[tm] password.  The argument to this option must be 6
      bytes in Ethernet MAC hex format ().

**msglvl**_&nbsp;N_  
**msglvl**_&nbsp;type_
.A1 on off
...
Sets the driver message type flags by name or number. _type_
names the type of message to enable or disable; _N_ specifies the
new flags numerically. The defined type names and numbers are:
.TS
nokeep;
lB	l	l.
drv	0x0001  General driver status
probe	0x0002  Hardware probing
link	0x0004  Link state
timer	0x0008  Periodic status check
ifdown	0x0010  Interface being brought down
ifup	0x0020  Interface being brought up
rx_err	0x0040  Receive error
tx_err	0x0080  Transmit error
tx_queued	0x0100  Transmit queueing
intr	0x0200  Interrupt handling
tx_done	0x0400  Transmit completion
rx_status	0x0800  Receive completion
pktdata	0x1000  Packet contents
hw	0x2000  Hardware status
wol	0x4000  Wake-on-LAN status
.TE

The precise meanings of these type flags differ between drivers.

* **-n -u --show-nfc --show-ntuple**  
  Retrieves receive network flow classification options or rules.
    * **rx-flow-hash**&nbsp;  
      Retrieves the hash options for the specified flow type.
      .TS
      nokeep;
      lB	l.
      tcp4	TCP over IPv4
      udp4	UDP over IPv4
      ah4	IPSEC AH over IPv4
      esp4	IPSEC ESP over IPv4
      sctp4	SCTP over IPv4
      tcp6	TCP over IPv6
      udp6	UDP over IPv6
      ah6	IPSEC AH over IPv6
      esp6	IPSEC ESP over IPv6
      sctp6	SCTP over IPv6
      .TE
    * **rule**_&nbsp;N_  
      Retrieves the RX classification rule with the given ID.

* **-N -U --config-nfc --config-ntuple**  
  Configures receive network flow classification options or rules.
    * **rx-flow-hash**&nbsp;**​**\*(HO  
      Configures the hash options for the specified flow type.
      .TS
      nokeep;
      lB	l.
      m	Hash on the Layer 2 destination address of the rx packet.
      v	Hash on the VLAN tag of the rx packet.
      t	Hash on the Layer 3 protocol field of the rx packet.
      s	Hash on the IP source address of the rx packet.
      d	Hash on the IP destination address of the rx packet.
      f	Hash on bytes 0 and 1 of the Layer 4 header of the rx packet.
      n	Hash on bytes 2 and 3 of the Layer 4 header of the rx packet.
      r	T{
      Discard all packets of this flow type. When this option is set, all
      other options are ignored.
      T}
      .TE
    * **flow-type **  
      Inserts or updates a classification rule for the specified flow type.
      .TS
      nokeep;
      lB	l.
      ether	Ethernet
      ip4	Raw IPv4
      tcp4	TCP over IPv4
      udp4	UDP over IPv4
      sctp4	SCTP over IPv4
      ah4	IPSEC AH over IPv4
      esp4	IPSEC ESP over IPv4
      ip6	Raw IPv6
      tcp6	TCP over IPv6
      udp6	UDP over IPv6
      sctp6	SCTP over IPv6
      ah6	IPSEC AH over IPv6
      esp6	IPSEC ESP over IPv6
      .TE

For all fields that allow both a value and a mask to be specified, the
mask may be specified immediately after the value using the **m**
keyword, or separately using the field name keyword with **-mask**
appended, e.g. **src-mask**.

* **src**&nbsp;&nbsp;[**m**&nbsp;\*(MA]  
  Includes the source MAC address, specified as 6 bytes in hexadecimal
  separated by colons, along with an optional mask.  Valid only for
  flow-type ether.
* **dst**&nbsp;&nbsp;[**m**&nbsp;\*(MA]  
  Includes the destination MAC address, specified as 6 bytes in hexadecimal
  separated by colons, along with an optional mask.  Valid only for
  flow-type ether.
* **proto**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Includes the Ethernet protocol number (ethertype) and an optional mask.
  Valid only for flow-type ether.
* **src-ip**&nbsp;&nbsp;[**m**&nbsp;\*(PA]  
  Specify the source IP address of the incoming packet to match along with
  an optional mask.  Valid for all IP based flow-types.
* **dst-ip**&nbsp;&nbsp;[**m**&nbsp;\*(PA]  
  Specify the destination IP address of the incoming packet to match along
  with an optional mask.  Valid for all IP based flow-types.
* **tos**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Specify the value of the Type of Service field in the incoming packet to
  match along with an optional mask.  Applies to all IPv4 based flow-types.
* **tclass**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Specify the value of the Traffic Class field in the incoming packet to
  match along with an optional mask.  Applies to all IPv6 based flow-types.
* **l4proto**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Includes the layer 4 protocol number and optional mask.  Valid only for
  flow-types ip4 and ip6.
* **src-port**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Specify the value of the source port field (applicable to TCP/UDP packets)
  in the incoming packet to match along with an optional mask.  Valid for
  flow-types ip4, tcp4, udp4, and sctp4 and their IPv6 equivalents.
* **dst-port**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Specify the value of the destination port field (applicable to TCP/UDP
  packets)in the incoming packet to match along with an optional mask.
  Valid for flow-types ip4, tcp4, udp4, and sctp4 and their IPv6 equivalents.
* **spi**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Specify the value of the security parameter index field (applicable to
  AH/ESP packets)in the incoming packet to match along with an optional
  mask.  Valid for flow-types ip4, ah4, and esp4 and their IPv6 equivalents.
* **l4data**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Specify the value of the first 4 Bytes of Layer 4 in the incoming packet to
  match along with an optional mask.  Valid for ip4 and ip6 flow-types.
* **vlan-etype**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Includes the VLAN tag Ethertype and an optional mask.
* **vlan**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Includes the VLAN tag and an optional mask.
* **user-def**_&nbsp;N_**\&nbsp;[\m**_&nbsp;N_**\]\**  
  Includes 64-bits of user-specific data and an optional mask.
* **dst-mac**&nbsp;&nbsp;[**m**&nbsp;\*(MA]  
  Includes the destination MAC address, specified as 6 bytes in hexadecimal
  separated by colons, along with an optional mask.
  Valid for all IP based flow-types.
* **action**_&nbsp;N_  
  Specifies the Rx queue to send packets to, or some other action.
  .TS
  nokeep;
  lB	l.
  -1	Drop the matched flow
  0 or higher	Rx queue to route the flow
  .TE
* **context**_&nbsp;N_  
  Specifies the RSS context to spread packets over multiple queues; either
  **0**
  for the default RSS context, or a value returned by
  **ethtool&nbsp;-X&nbsp;**_..._**&nbsp;context**
  **new**.
* **vf**_&nbsp;N_  
  Specifies the Virtual Function the filter applies to. Not compatible with action.
* **queue**_&nbsp;N_  
  Specifies the Rx queue to send packets to. Not compatible with action.
* **loc**_&nbsp;N_  
  Specify the location/ID to insert the rule. This will overwrite
  any rule present in that location and will not go through any
  of the rule ordering process.
* **delete**_&nbsp;N_  
  Deletes the RX classification rule with the given ID.

* **-w --get-dump**  
  Retrieves and prints firmware dump for the specified network device.
  By default, it prints out the dump flag, version and length of the dump data.
  When
  _data_
  is indicated, then ethtool fetches the dump data and directs it to a
  _file._
* **-W --set-dump**  
  Sets the dump flag for the device.
* **-T --show-time-stamping**  
  Show the device's time stamping capabilities and associated PTP
  hardware clock.
* **-x --show-rxfh-indir --show-rxfh**  
  Retrieves the receive flow hash indirection table and/or RSS hash key.
* **-X --set-rxfh-indir --rxfh**  
  Configures the receive flow hash indirection table and/or RSS hash key.
    * **hkey**  
      Sets RSS hash key of the specified network device. RSS hash key should be of device supported length.
      Hash key format must be in xx:yy:zz:aa:bb:cc format meaning both the nibbles of a byte should be mentioned
      even if a nibble is zero.
    * **hfunc**  
      Sets RSS hash function of the specified network device.
      List of RSS hash functions which kernel supports is shown as a part of the --show-rxfh command output.
    * **equal&nbsp;**_N_  
      Sets the receive flow hash indirection table to spread flows evenly
      between the first _N_ receive queues.
    * **weight** _W0 W1_ ...  
      Sets the receive flow hash indirection table to spread flows between
      receive queues according to the given weights.  The sum of the weights
      must be non-zero and must not exceed the size of the indirection table.
    * **default**  
      Sets the receive flow hash indirection table to its default value.
    * **context CTX** | **new**  
      Specifies an RSS context to act on; either
      **new**
      to allocate a new RSS context, or
      _CTX_,
      a value returned by a previous
      _..._**&nbsp;context**
      **new**.
    * **delete**  
      Delete the specified RSS context.  May only be used in conjunction with
      **context**
      and a non-zero
      _CTX_
      value.
* **-f --flash**  
  Write a firmware image to flash or other non-volatile memory on the
  device.
    * _file_  
      Specifies the filename of the firmware image.  The firmware must first
      be installed in one of the directories where the kernel firmware
      loader or firmware agent will look, such as /lib/firmware.
    * _N_  
      If the device stores multiple firmware images in separate regions of
      non-volatile memory, this parameter may be used to specify which
      region is to be written.  The default is 0, requesting that all
      regions are written.  All other values are driver-dependent.
* **-l --show-channels**  
  Queries the specified network device for the numbers of channels it has.
  A channel is an IRQ and the set of queues that can trigger that IRQ.
* **-L --set-channels**  
  Changes the numbers of channels of the specified network device.
    * **rx**_&nbsp;N_  
      Changes the number of channels with only receive queues.
    * **tx**_&nbsp;N_  
      Changes the number of channels with only transmit queues.
    * **other**_&nbsp;N_  
      Changes the number of channels used only for other purposes e.g. link interrupts or SR-IOV co-ordination.
    * **combined**_&nbsp;N_  
      Changes the number of multi-purpose channels.
* **-m --dump-module-eeprom --module-info**  
  Retrieves and if possible decodes the EEPROM from plugin modules, e.g SFP+, QSFP.
  If the driver and module support it, the optical diagnostic information is also
  read and decoded.
* **--show-priv-flags**  
  Queries the specified network device for its private flags.  The
  names and meanings of private flags (if any) are defined by each
  network device driver.
* **--set-priv-flags**  
  Sets the device's private flags as specified.

_flag_
.A1 on off
Sets the state of the named private flag.

* **--show-eee**  
  Queries the specified network device for its support of Energy-Efficient
  Ethernet (according to the IEEE 802.3az specifications)
* **--set-eee**  
  Sets the device EEE behaviour.
    * .A2 eee on off  
      Enables/disables the device support of EEE.
    * .A2 tx-lpi on off  
      Determines whether the device should assert its Tx LPI.
    * **advertise**_&nbsp;N_  
      Sets the speeds for which the device should advertise EEE capabilities.
      Values are as for
      **--change advertise**
    * **tx-timer**_&nbsp;N_  
      Sets the amount of time the device should stay in idle mode prior to asserting
      its Tx LPI (in microseconds). This has meaning only when Tx LPI is enabled.
* **--set-phy-tunable**  
  Sets the PHY tunable parameters.
    * .A2 downshift on off  
      Specifies whether downshift should be enabled
      .TS
      nokeep;
      lB	l.
      **count**_&nbsp;N_
      Sets the PHY downshift re-tries count.
      .TE
* **--get-phy-tunable**  
  Gets the PHY tunable parameters.
    * **downshift**  
      For operation in cabling environments that are incompatible with 1000BASE-T,
      PHY device provides an automatic link speed downshift operation.
      Link speed downshift after N failed 1000BASE-T auto-negotiation attempts.
      Downshift is useful where cable does not have the 4 pairs instance.
      
      Gets the PHY downshift count/status.
* **--reset**  
  Reset hardware components specified by flags and components listed below
    * **flags**_&nbsp;N_  
      Resets the components based on direct flags mask
    * **mgmt**  
      Management processor
    * **irq**  
      Interrupt requester
    * **dma**  
      DMA engine
    * **filter**  
      Filtering/flow direction
    * **offload**  
      Protocol offload
    * **mac**  
      Media access controller
    * **phy**  
      Transceiver/PHY
    * **ram**  
      RAM shared between multiple components
      **ap**
      Application Processor
    * **dedicated**  
      All components dedicated to this interface
    * **all**  
      All components used by this interface, even if shared
* **--show-fec**  
  Queries the specified network device for its support of Forward Error Correction.
* **--set-fec**  
  Configures Forward Error Correction for the specified network device.
  
  Forward Error Correction modes selected by a user are expected to be persisted
  after any hotplug events. If a module is swapped that does not support the
  current FEC mode, the driver or firmware must take the link down
  administratively and report the problem in the system logs for users to correct.
    * .A4 encoding auto off rs baser  
      Sets the FEC encoding for the device.
      .TS
      nokeep;
      lB	l.
      auto	Use the driver's default encoding
      off	Turn off FEC
      RS	Force RS-FEC encoding
      BaseR	Force BaseR encoding
      .TE

<a name="bugs"></a>

# Bugs

Not supported (in part or whole) on all network drivers.

<a name="author"></a>

# Author

**ethtool**
was written by David Miller.

Modifications by 
Jeff Garzik, 
Tim Hockin,
Jakub Jelinek,
Andre Majorel,
Eli Kupermann,
Scott Feldman,
Andi Kleen,
Alexander Duyck,
Sucheta Chakraborty,
Jesse Brandeburg,
Ben Hutchings,
Scott Branden.

<a name="availability"></a>

# Availability

**ethtool**
is available from
[](http://www.kernel.org/pub/software/network/ethtool/)
