# nat action in tc(8) - stateless native address translation action

iproute2, 12 Jan 2015

```
.in +8 .ti -8 tc ... action nat DIRECTION OLD NEW
</synopsis>

<synopsis>
.ti -8 DIRECTION := {  ingress | egress }
</synopsis>

<synopsis>
.ti -8 OLD := IPV4_ADDR_SPEC
</synopsis>

<synopsis>
.ti -8 NEW := IPV4_ADDR_SPEC
</synopsis>

<synopsis>
.ti -8 IPV4_ADDR_SPEC := {  default | any | all |  in_addr[/{prefix|netmask}]
```

<a name="description"></a>

# Description

The
**nat**
action allows to perform NAT without the overhead of conntrack, which is
desirable if the number of flows or addresses to perform NAT on is large. This
action is best used in combination with the
**u32**
filter to allow for efficient lookups of a large number of stateless NAT rules
in constant time.

<a name="options"></a>

# Options


* **ingress**  
  Translate destination addresses, i.e. perform DNAT.
* **egress**  
  Translate source addresses, i.e. perform SNAT.
* _OLD_  
  Specifies addresses which should be translated.
* _NEW_  
  Specifies addresses which
  _OLD_
  should be translated into.

<a name="notes"></a>

# Notes

The accepted address format in
_OLD_ and _NEW_
is quite flexible. It may either consist of one of the keywords
**default**, **any** or **all**,
representing the all-zero IP address or a combination of IP address and netmask
or prefix length separated by a slash
(**/**)
sign. In any case, the mask (or prefix length) value of
_OLD_
is used for
_NEW_
as well so that a one-to-one mapping of addresses is assured.

Address translation is done using a combination of binary operations. First, the
original (source or destination) address is matched against the value of
_OLD_.
If the original address fits, the new address is created by taking the leading
bits from
_NEW_
(defined by the netmask of
_OLD_)
and taking the remaining bits from the original address.

There is rudimental support for upper layer protocols, namely TCP, UDP and ICMP.
While for the first two only checksum recalculation is performed, the action
also takes care of embedded IP headers in ICMP packets by translating the
respective address therein, too.

<a name="see-also"></a>

# See Also

**tc**(8)
