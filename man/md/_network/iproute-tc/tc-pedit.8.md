# generic packet editor action in tc(8) - generic packet editor action

iproute2, 12 Jan 2015

```
.in +8 .ti -8 tc ... action pedit [ex] munge { RAW_OP | LAYERED_OP | EXTENDED_LAYERED_OP } [ CONTROL ]
</synopsis>

<synopsis>
.ti -8 RAW_OP :=  offset OFFSET { u8 | u16 | u32 } [ AT_SPEC ] CMD_SPEC
</synopsis>

<synopsis>
.ti -8 AT_SPEC :=  at AT offmask MASK shift SHIFT
</synopsis>

<synopsis>
.ti -8 LAYERED_OP := {  ip IPHDR_FIELD | ip BEYOND_IPHDR_FIELD } CMD_SPEC
</synopsis>

<synopsis>
.ti -8 EXTENDED_LAYERED_OP := {  eth ETHHDR_FIELD | ip IPHDR_FIELD | ip EX_IPHDR_FIELD | ip6 IP6HDR_FIELD | tcp TCPHDR_FIELD | udp UDPHDR_FIELD } CMD_SPEC
</synopsis>

<synopsis>
.ti -8 ETHHDR_FIELD := {  src | dst | type }
</synopsis>

<synopsis>
.ti -8 IPHDR_FIELD := {  src | dst | tos | dsfield | ihl | protocol | precedence | nofrag | firstfrag | ce | df }
</synopsis>

<synopsis>
.ti -8 BEYOND_IPHDR_FIELD := {  dport | sport | icmp_type | icmp_code }
</synopsis>

<synopsis>
.ti -8 EX_IPHDR_FIELD := {  ttl }
</synopsis>


<synopsis>
.ti -8 IP6HDR_FIELD := {  src | dst | traffic_class | flow_lbl | payload_len |  nexthdr | hoplimit }
</synopsis>

<synopsis>
.ti -8 TCPHDR_FIELD := {  sport | dport | flags }
</synopsis>

<synopsis>
.ti -8 UDPHDR_FIELD := {  sport | dport }
</synopsis>

<synopsis>
.ti -8 CMD_SPEC := { clear | invert | set VAL |  add VAL |  preserve } [ retain RVAL ]
</synopsis>

<synopsis>
.ti -8 CONTROL := { reclassify | pipe | drop | shot | continue | pass | goto chain CHAIN_INDEX }
```

<a name="description"></a>

# Description

The
**pedit**
action can be used to change arbitrary packet data. The location of data to
change can either be specified by giving an offset and size as in
_RAW_OP_,
or for header values by naming the header and field to edit the size is then
chosen automatically based on the header field size.

<a name="options"></a>

# Options


* **ex**  
  Use extended pedit.
  _EXTENDED_LAYERED_OP_
  and the add
  _CMD_SPEC_
  are allowed only in this mode.
* **offset**_ OFFSET _**{ **u32 **| **u16 **| **u8 **}**  
  Specify the offset at which to change data.
  _OFFSET_
  is a signed integer, it's base is automatically chosen (e.g. hex if prefixed by
  **0x**
  or octal if prefixed by
  **0**).
  The second argument specifies the length of data to change, that is four bytes
  (**u32**),
  two bytes
  (**u16**)
  or a single byte
  (**u8**).
* **at**_ AT _**offmask**_ MASK _**shift**_ SHIFT_  
  This is an optional part of
  _RAW_OP_
  which allows to have a variable
  _OFFSET_
  depending on packet data at offset
  _AT_,
  which is binary ANDed with
  _MASK_
  and right-shifted by
  _SHIFT_
  before adding it to
  _OFFSET_.
* **eth**_ ETHHDR_FIELD_  
  Change an ETH header field. The supported keywords for
  _ETHHDR_FIELD_
  are:
    * **src**  
      .TQ
      **dst**
      Source or destination MAC address in the standard format: XX:XX:XX:XX:XX:XX
    * **type**  
      Ether-type in numeric value
* **ip**_ IPHDR_FIELD_  
  Change an IPv4 header field. The supported keywords for
  _IPHDR_FIELD_
  are:
    * **src**  
      .TQ
      **dst**
      Source or destination IP address, a four-byte value.
    * **tos**  
      .TQ
      **dsfield**
      .TQ
      **precedence**
      Type Of Service field, an eight-bit value.
    * **ihl**  
      Change the IP Header Length field, a four-bit value.
    * **protocol**  
      Next-layer Protocol field, an eight-bit value.
    * **nofrag**  
      .TQ
      **firstfrag**
      .TQ
      **ce**
      .TQ
      **df**
      .TQ
      **mf**
      Change IP header flags. Note that the value to pass to the
      **set**
      command is not just a bit value, but the full byte including the flags field.
      Though only the relevant bits of that value are respected, the rest ignored.
* **ip**_ BEYOND_IPHDR_FIELD_  
  Supported only for non-extended layered op. It is passed to the kernel as
  offsets relative to the beginning of the IP header and assumes the IP header is
  of minimum size (20 bytes). The supported keywords for
  _BEYOND_IPHDR_FIELD_
  are:
    * **dport**  
      .TQ
      **sport**
      Destination or source port numbers, a 16-bit value. Indeed, IPv4 headers don't
      contain this information. Instead, this will set an offset which suits at least
      TCP and UDP if the IP header is of minimum size (20 bytes). If not, this will do
      unexpected things.
    * **icmp_type**  
      .TQ
      **icmp_code**
      Again, this allows to change data past the actual IP header itself. It assumes
      an ICMP header is present immediately following the (minimal sized) IP header.
      If it is not or the latter is bigger than the minimum of 20 bytes, this will do
      unexpected things. These fields are eight-bit values.
* **ip**_ EX_IPHDR_FIELD_  
  Supported only when
  _ex_
  is used. The supported keywords for
  _EX_IPHDR_FIELD_
  are:
    * **ttl**  
* **ip6**_ IP6HDR_FIELD_  
  The supported keywords for
  _IP6HDR_FIELD_
  are:
    * **src**  
      .TQ
      **dst**
      .TQ
      **traffic_class**
      .TQ
      **flow_lbl**
      .TQ
      **payload_len**
      .TQ
      **nexthdr**
      .TQ
      **hoplimit**
* **tcp**_ TCPHDR_FIELD_  
  The supported keywords for
  _TCPHDR_FIELD_
  are:
    * **sport**  
      .TQ
      **dport**
      Source or destination TCP port number, a 16-bit value.
    * **flags**  
* **udp**_ UDPHDR_FIELD_  
  The supported keywords for
  _UDPHDR_FIELD_
  are:
    * **sport**  
      .TQ
      **dport**
      Source or destination TCP port number, a 16-bit value.
* **clear**  
  Clear the addressed data (i.e., set it to zero).
* **invert**  
  Swap every bit in the addressed data.
* **set**_ VAL_  
  Set the addressed data to a specific value. The size of
  _VAL_
  is defined by either one of the
  **u32**, **u16** or **u8**
  keywords in
  _RAW_OP_,
  or the size of the addressed header field in
  _LAYERED_OP_.
* **add**_ VAL_  
  Add the addressed data by a specific value. The size of
  _VAL_
  is defined by the size of the addressed header field in
  _EXTENDED_LAYERED_OP_.
  This operation is supported only for extended layered op.
* **preserve**  
  Keep the addressed data as is.
* **retain**_ RVAL_  
  This optional extra part of
  _CMD_SPEC_
  allows to exclude bits from being changed. Supported only for 32 bits fields
  or smaller.
* _CONTROL_  
  The following keywords allow to control how the tree of qdisc, classes,
  filters and actions is further traversed after this action.
    * **reclassify**  
      Restart with the first filter in the current list.
    * **pipe**  
      Continue with the next action attached to the same filter.
    * **drop**  
      .TQ
      **shot**
      Drop the packet.
    * **continue**  
      Continue classification with the next filter in line.
    * **pass**  
      Finish classification process and return to calling qdisc for further packet
      processing. This is the default.

<a name="examples"></a>

# Examples

Being able to edit packet data, one could do all kinds of things, such as e.g.
implementing port redirection. Certainly not the most useful application, but
as an example it should do:

First, qdiscs need to be set up to attach filters to. For the receive path, a simple
**ingress**
qdisc will do, for transmit path a classful qdisc
(**HTB**
in this case) is necessary:

.EX
tc qdisc replace dev eth0 root handle 1: htb
tc qdisc add dev eth0 ingress handle ffff:
.EE

Finally, a filter with
**pedit**
action can be added for each direction. In this case,
**u32**
is used matching on the port number to redirect from, while
**pedit**
then does the actual rewriting:

.EX
tc filter add dev eth0 parent 1: u32 \	match ip dport 23 0xffff \	action pedit pedit munge ip dport set 22
tc filter add dev eth0 parent ffff: u32 \	match ip sport 22 0xffff \	action pedit pedit munge ip sport set 23
tc filter add dev eth0 parent ffff: u32 \	match ip sport 22 0xffff \	action pedit ex munge ip dst set 192.168.1.199
tc filter add dev eth0 parent ffff: u32 \	match ip sport 22 0xffff \	action pedit ex munge ip6 dst set fe80::dacb:8aff:fec7:320e
tc filter add dev eth0 parent ffff: u32 \	match ip sport 22 0xffff \	action pedit ex munge eth dst set 11:22:33:44:55:66
tc filter add dev eth0 parent ffff: u32 \	match ip dport 23 0xffff \	action pedit ex munge tcp dport set 22
.EE

To rewrite just part of a field, use the
**retain**
directive. E.g. to overwrite the DSCP part of a dsfield with $DSCP, without
touching ECN:

.EX
tc filter add dev eth0 ingress flower ... \	action pedit ex munge ip dsfield set $((DSCP &lt;&lt; 2)) retain 0xfc
.EE

And vice versa, to set ECN to e.g. 1 without impacting DSCP:

.EX
tc filter add dev eth0 ingress flower ... \	action pedit ex munge ip dsfield set 1 retain 0x3
.EE


<a name="see-also"></a>

# See Also

**tc**(8),
**tc-htb**(8),
**tc-u32**(8)
