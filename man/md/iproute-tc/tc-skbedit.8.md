# skb editing action in tc(8) - SKB editing action

iproute2, 12 Jan 2015

```
.in +8 .ti -8 tc ... action skbedit [queue_mapping QUEUE_MAPPING ] [ priority PRIORITY ] [ mark MARK[/MASK] ] [ ptype PTYPE ] [ inheritdsfield ]
```

<a name="description"></a>

# Description

The
**skbedit**
action allows to change a packet's associated meta data. It complements the
**pedit**
action, which in turn allows to change parts of the packet data itself.

The most unique feature of
**skbedit**
is its ability to decide over which queue of an interface with multiple
transmit queues the packet is to be sent out. The number of available transmit
queues is reflected by sysfs entries within
_/sys/class/net/&lt;interface&gt;/queues_
with name
_tx-N_
(where
_N_
is the actual queue number).

<a name="options"></a>

# Options


* **queue_mapping**_ QUEUE_MAPPING_  
  Override the packet's transmit queue. Useful when applied to packets transmitted
  over MQ-capable network interfaces.
  _QUEUE_MAPPING_
  is an unsigned 16bit value in decimal format.
* **priority**_ PRIORITY_  
  Override the packet classification decision.
  _PRIORITY_
  is either
  **root**, **none**
  or a hexadecimal major class ID optionally followed by a colon
  (**:**)
  and a hexadecimal minor class ID.
* **mark**_ MARK[/MASK]_  
  Change the packet's firewall mark value.
  _MARK_
  is an unsigned 32bit value in automatically detected format (i.e., prefix with
  '**0x**'
  for hexadecimal interpretation, etc.).
  _MASK_
  defines the 32-bit mask selecting bits of mark value. Default is 0xffffffff.
* **ptype**_ PTYPE_  
  Override the packet's type. Useful for setting packet type to host when
  needing to allow ingressing packets with the wrong MAC address but
  correct IP address.
  _PTYPE_
  is one of: host, otherhost, broadcast, multicast
* **inheritdsfield**  
  Override the packet classification decision, and any value specified with
  **priority**, 
  using the information stored in the Differentiated Services Field of the
  IPv6/IPv4 header (RFC2474).

<a name="see-also"></a>

# See Also

**tc**(8),
**tc-pedit**(8)
