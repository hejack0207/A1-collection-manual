# flower filter in tc(8)

iproute2, 22 Oct 2015

	"Usage: ct clear\n"
		"	ct commit [force] [zone ZONE] [mark MASKED_MARK] [label MASKED_LABEL] [nat NAT_SPEC] [OFFLOAD_POLICY]\n"
		"	ct [nat] [zone ZONE] [OFFLOAD_POLICY]\n"
		"Where: ZONE is the conntrack zone table number\n"
		"	NAT_SPEC is {src|dst} addr addr1[-addr2] [port port1[-port2]]\n"
		"	OFFLOAD_POLICY is [policy_pkts PACKETS] [policy_timeout TIMEOUT]\n"

<a name="name"></a>

# Name

flower - flow based traffic control filter

<a name="synopsis"></a>

# Synopsis

```
.in +8 .ti -8 tc filter ... flower [  MATCH_LIST ] [  action ACTION_SPEC ] [  classid CLASSID ] [  hw_tc TCID ]
</synopsis>


<synopsis>
.ti -8 MATCH_LIST := [ MATCH_LIST ] MATCH
</synopsis>

<synopsis>
.ti -8 MATCH := {  indev ifname |  verbose  |  skip_sw | skip_hw  | {  dst_mac | src_mac }  MASKED_LLADDR |  vlan_id VID |  vlan_prio PRIORITY |  vlan_ethtype { ipv4 | ipv6 |  ETH_TYPE } |  cvlan_id VID |  cvlan_prio PRIORITY |  cvlan_ethtype { ipv4 | ipv6 |  ETH_TYPE } |  mpls LSE_LIST |  mpls_label LABEL |  mpls_tc TC |  mpls_bos BOS |  mpls_ttl TTL |  ip_proto { tcp | udp | sctp | icmp | icmpv6 |  IP_PROTO } |  ip_tos MASKED_IP_TOS |  ip_ttl MASKED_IP_TTL | {  dst_ip | src_ip }  PREFIX | {  dst_port | src_port } {  MASKED_NUMBER |  min_port_number-max_port_number } |  tcp_flags MASKED_TCP_FLAGS |  type MASKED_TYPE |  code MASKED_CODE | {  arp_tip | arp_sip }  IPV4_PREFIX |  arp_op { request | reply |  OP } | {  arp_tha | arp_sha }  MASKED_LLADDR |  enc_key_id KEY-ID | { enc_dst_ip | enc_src_ip } {  ipv4_address | ipv6_address } |  enc_dst_port port_number |  enc_tos TOS |  enc_ttl TTL |  { geneve_opts | vxlan_opts | erspan_opts } OPTIONS |  ip_flags IP_FLAGS }
</synopsis>

<synopsis>
.ti -8 LSE_LIST := [ LSE_LIST ] LSE
</synopsis>

<synopsis>
.ti -8 LSE :=  lse depth DEPTH {  label LABEL |  tc TC |  bos BOS |  ttl TTL }
```


<a name="description"></a>

# Description

The
**flower**
filter matches flows to the set of keys specified and assigns an arbitrarily
chosen class ID to packets belonging to them. Additionally (or alternatively) an
action from the generic action framework may be called.

<a name="options"></a>

# Options


* **action**_ ACTION_SPEC_  
  Apply an action from the generic actions framework on matching packets.
* **classid**_ CLASSID_  
  Specify a class to pass matching packets on to.
  _CLASSID_
  is in the form
  **X**:**Y**, while **X** and **Y**
  are interpreted as numbers in hexadecimal format.
* **hw_tc**_ TCID_  
  Specify a hardware traffic class to pass matching packets on to. TCID is in the
  range 0 through 15.
* **indev**_ ifname_  
  Match on incoming interface name. Obviously this makes sense only for forwarded
  flows.
  _ifname_
  is the name of an interface which must exist at the time of
  **tc**
  invocation.
* **verbose**  
  Enable verbose logging, including offloading errors when not using
  **skip_sw**
  flag.
* **skip_sw**  
  Do not process filter by software. If hardware has no offload support for this
  filter, or TC offload is not enabled for the interface, operation will fail.
* **skip_hw**  
  Do not process filter by hardware.
* **dst_mac**_ MASKED_LLADDR_  
  .TQ
  **src_mac**_ MASKED_LLADDR_
  Match on source or destination MAC address.  A mask may be optionally
  provided to limit the bits of the address which are matched. A mask is
  provided by following the address with a slash and then the mask. It may be
  provided in LLADDR format, in which case it is a bitwise mask, or as a
  number of high bits to match. If the mask is missing then a match on all
  bits is assumed.
* **vlan_id**_ VID_  
  Match on vlan tag id.
  _VID_
  is an unsigned 12bit value in decimal format.
* **vlan_prio**_ PRIORITY_  
  Match on vlan tag priority.
  _PRIORITY_
  is an unsigned 3bit value in decimal format.
* **vlan_ethtype**_ VLAN_ETH_TYPE_  
  Match on layer three protocol.
  _VLAN_ETH_TYPE_
  may be either
  **ipv4**, **ipv6**
  or an unsigned 16bit value in hexadecimal format. To match on QinQ packet, it must be 802.1Q or 802.1AD.
* **cvlan_id**_ VID_  
  Match on QinQ inner vlan tag id.
  _VID_
  is an unsigned 12bit value in decimal format.
* **cvlan_prio**_ PRIORITY_  
  Match on QinQ inner vlan tag priority.
  _PRIORITY_
  is an unsigned 3bit value in decimal format.
* **cvlan_ethtype**_ VLAN_ETH_TYPE_  
  Match on QinQ layer three protocol.
  _VLAN_ETH_TYPE_
  may be either
  **ipv4**, **ipv6**
  or an unsigned 16bit value in hexadecimal format.
  
* **mpls**_ LSE_LIST_  
  Match on the MPLS label stack.
  _LSE_LIST_
  is a list of Label Stack Entries, each introduced by the
  **lse** keyword.
  This option can't be used together with the standalone
  **mpls_label**, **mpls_tc**, **mpls_bos** and **mpls_ttl** options.
    * **lse**_ LSE_OPTIONS_  
      Match on an MPLS Label Stack Entry.
      _LSE_OPTIONS_
      is a list of options that describe the properties of the LSE to match.
        * **depth**_ DEPTH_  
          The depth of the Label Stack Entry to consider. Depth starts at 1 (the
          outermost Label Stack Entry). The maximum usable depth may be limited by the
          kernel. This option is mandatory.
          _DEPTH_
          is an unsigned 8 bit value in decimal format.
        * **label**_ LABEL_  
          Match on the MPLS Label field at the specified
          **depth**.
          _LABEL_
          is an unsigned 20 bit value in decimal format.
        * **tc**_ TC_  
          Match on the MPLS Traffic Class field at the specified
          **depth**.
          _TC_
          is an unsigned 3 bit value in decimal format.
        * **bos**_ BOS_  
          Match on the MPLS Bottom Of Stack field at the specified
          **depth**.
          _BOS_
          is a 1 bit value in decimal format.
        * **ttl**_ TTL_  
          Match on the MPLS Time To Live field at the specified
          **depth**.
          _TTL_
          is an unsigned 8 bit value in decimal format.
  
* **mpls_label**_ LABEL_  
  Match the label id in the outermost MPLS label stack entry.
  _LABEL_
  is an unsigned 20 bit value in decimal format.
* **mpls_tc**_ TC_  
  Match on the MPLS TC field, which is typically used for packet priority,
  in the outermost MPLS label stack entry.
  _TC_
  is an unsigned 3 bit value in decimal format.
* **mpls_bos**_ BOS_  
  Match on the MPLS Bottom Of Stack field in the outermost MPLS label stack
  entry.
  _BOS_
  is a 1 bit value in decimal format.
* **mpls_ttl**_ TTL_  
  Match on the MPLS Time To Live field in the outermost MPLS label stack
  entry.
  _TTL_
  is an unsigned 8 bit value in decimal format.
* **ip_proto**_ IP_PROTO_  
  Match on layer four protocol.
  _IP_PROTO_
  may be
  **tcp**, **udp**, **sctp**, **icmp**, **icmpv6**
  or an unsigned 8bit value in hexadecimal format.
* **ip_tos**_ MASKED_IP_TOS_  
  Match on ipv4 TOS or ipv6 traffic-class - eight bits in hexadecimal format.
  A mask may be optionally provided to limit the bits which are matched. A mask
  is provided by following the value with a slash and then the mask. If the mask
  is missing then a match on all bits is assumed.
* **ip_ttl**_ MASKED_IP_TTL_  
  Match on ipv4 TTL or ipv6 hop-limit  - eight bits value in decimal or hexadecimal format.
  A mask may be optionally provided to limit the bits which are matched. Same
  logic is used for the mask as with matching on ip_tos.
* **dst_ip**_ PREFIX_  
  .TQ
  **src_ip**_ PREFIX_
  Match on source or destination IP address.
  _PREFIX_
  must be a valid IPv4 or IPv6 address, depending on the **protocol**
  option to tc filter, optionally followed by a slash and the prefix length.
  If the prefix is missing, **tc** assumes a full-length host match.
* _dst_port_ { _MASKED_NUMBER_ | _ MIN_VALUE-MAX_VALUE _}  
  .TQ
  _src_port_ { _MASKED_NUMBER_ | _ MIN_VALUE-MAX_VALUE _}
  Match on layer 4 protocol source or destination port number, with an
  optional mask. Alternatively, the mininum and maximum values can be
  specified to match on a range of layer 4 protocol source or destination
  port numbers. Only available for
  **ip_proto** values **udp**, **tcp** and **sctp**
  which have to be specified in beforehand.
* **tcp_flags**_ MASKED_TCP_FLAGS_  
  Match on TCP flags represented as 12bit bitfield in in hexadecimal format.
  A mask may be optionally provided to limit the bits which are matched. A mask
  is provided by following the value with a slash and then the mask. If the mask
  is missing then a match on all bits is assumed.
* **type**_ MASKED_TYPE_  
  .TQ
  **code**_ MASKED_CODE_
  Match on ICMP type or code. A mask may be optionally provided to limit the
  bits of the address which are matched. A mask is provided by following the
  address with a slash and then the mask. The mask must be as a number which
  represents a bitwise mask If the mask is missing then a match on all bits
  is assumed.  Only available for
  **ip_proto** values **icmp** and **icmpv6**
  which have to be specified in beforehand.
* **arp_tip**_ IPV4_PREFIX_  
  .TQ
  **arp_sip**_ IPV4_PREFIX_
  Match on ARP or RARP sender or target IP address.
  _IPV4_PREFIX_
  must be a valid IPv4 address optionally followed by a slash and the prefix
  length. If the prefix is missing, **tc** assumes a full-length host
  match.
* **arp_op**_ ARP_OP_  
  Match on ARP or RARP operation.
  _ARP_OP_
  may be
  **request**, **reply**
  or an integer value 0, 1 or 2.  A mask may be optionally provided to limit
  the bits of the operation which are matched. A mask is provided by
  following the address with a slash and then the mask. It may be provided as
  an unsigned 8 bit value representing a bitwise mask. If the mask is missing
  then a match on all bits is assumed.
* **arp_sha**_ MASKED_LLADDR_  
  .TQ
  **arp_tha**_ MASKED_LLADDR_
  Match on ARP or RARP sender or target MAC address.  A mask may be optionally
  provided to limit the bits of the address which are matched. A mask is
  provided by following the address with a slash and then the mask. It may be
  provided in LLADDR format, in which case it is a bitwise mask, or as a
  number of high bits to match. If the mask is missing then a match on all
  bits is assumed.
* **enc_key_id**_ NUMBER_  
  .TQ
  **enc_dst_ip**_ PREFIX_
  .TQ
  **enc_src_ip**_ PREFIX_
  .TQ
  **enc_dst_port**_ NUMBER_
  .TQ
  **enc_tos**_ NUMBER_
  .TQ
  **enc_ttl**_ NUMBER_
  .TQ  
* **ct_state**_ CT_STATE_  
  .TQ
  **ct_zone**_ CT_MASKED_ZONE_
  .TQ
  **ct_mark**_ CT_MASKED_MARK_
  .TQ
  **ct_label**_ CT_MASKED_LABEL_
  Matches on connection tracking info
    * _CT_STATE_  
      Match the connection state, and can ne combination of [{+|-}flag] flags, where flag can be one of
        * trk - Tracked connection.  
        * new - New connection.  
        * est - Established connection.  
        * Example: +trk+est  
    * _CT_MASKED_ZONE_  
      Match the connection zone, and can be masked.
    * _CT_MASKED_MARK_  
      32bit match on the connection mark, and can be masked.
    * _CT_MASKED_LABEL_  
      128bit match on the connection label, and can be masked.
* **geneve_opts**_ OPTIONS_  
  .TQ
  **vxlan_opts**_ OPTIONS_
  .TQ
  **erspan_opts**_ OPTIONS_
  Match on IP tunnel metadata. Key id
  _NUMBER_
  is a 32 bit tunnel key id (e.g. VNI for VXLAN tunnel).
  _PREFIX_
  must be a valid IPv4 or IPv6 address optionally followed by a slash and the
  prefix length. If the prefix is missing, **tc** assumes a full-length
  host match.  Dst port
  _NUMBER_
  is a 16 bit UDP dst port. Tos
  _NUMBER_
  is an 8 bit tos (dscp+ecn) value, ttl
  _NUMBER_
  is an 8 bit time-to-live value. geneve_opts
  _OPTIONS_
  must be a valid list of comma-separated geneve options where each option
  consists of a key optionally followed by a slash and corresponding mask. If
  the masks is missing, **tc** assumes a full-length match. The options can
  be described in the form CLASS:TYPE:DATA/CLASS_MASK:TYPE_MASK:DATA_MASK,
  where CLASS is represented as a 16bit hexadecimal value, TYPE as an 8bit
  hexadecimal value and DATA as a variable length hexadecimal value.
  vxlan_opts
  _OPTIONS_
  doesn't support multiple options, and it consists of a key followed by a slash
  and corresponding mask. If the mask is missing, **tc** assumes a full-length
  match. The option can be described in the form GBP/GBP_MASK, where GBP is
  represented as a 32bit number.
  erspan_opts
  _OPTIONS_
  doesn't support multiple options, and it consists of a key followed by a slash
  and corresponding mask. If the mask is missing, **tc** assumes a full-length
  match. The option can be described in the form
  VERSION:INDEX:DIR:HWID/VERSION:INDEX_MASK:DIR_MASK:HWID_MASK, where VERSION is
  represented as a 8bit number, INDEX as an 32bit number, DIR and HWID as a 8bit
  number. Multiple options is not supported. Note INDEX/INDEX_MASK is used when
  VERSION is 1, and DIR/DIR_MASK and HWID/HWID_MASK are used when VERSION is 2.
* **ip_flags**_ IP_FLAGS_  
  _IP_FLAGS_
  may be either
  **frag**, **nofrag**, **firstfrag** or **nofirstfrag**
  where frag and nofrag could be used to match on fragmented packets or not,
  respectively. firstfrag and nofirstfrag can be used to further distinguish
  fragmented packet. firstfrag can be used to indicate the first fragmented
  packet. nofirstfrag can be used to indicates subsequent fragmented packets
  or non-fragmented packets.

<a name="notes"></a>

# Notes

As stated above where applicable, matches of a certain layer implicitly depend
on the matches of the next lower layer. Precisely, layer one and two matches
(**indev**,  **dst\_mac** and **src\_mac**)
have no dependency,
MPLS and layer three matches
(**mpls**, **mpls\_label**, **mpls\_tc**, **mpls\_bos**, **mpls\_ttl**,
**ip\_proto**, **dst\_ip**, **src\_ip**, **arp\_tip**, **arp\_sip**,
**arp\_op**, **arp\_tha**, **arp\_sha** and **ip\_flags**)
depend on the
**protocol**
option of tc filter, layer four port matches
(**dst\_port** and **src\_port**)
depend on
**ip_proto**
being set to
**tcp**, **udp** or **sctp,**
and finally ICMP matches (**code** and **type**) depend on
**ip_proto**
being set to
**icmp** or **icmpv6.**

There can be only used one mask per one prio. If user needs to specify different
mask, he has to use different prio.

<a name="see-also"></a>

# See Also

**tc**(8),
**tc-flow**(8)
