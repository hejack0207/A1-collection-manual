# firewall mark classifier in tc(8) - fwmark traffic control filter

iproute2, 21 Oct 2015

```
.in +8 .ti -8 tc filter ... fw [ classid CLASSID ] [  action ACTION_SPEC ]
```

<a name="description"></a>

# Description

the
**fw**
filter allows to classify packets based on a previously set
**fwmark** by **iptables**.
If it is identical to the filter's
**handle**,
the filter matches.
**iptables**
allows to mark single packets with the
**MARK**
target, or whole connections using
**CONNMARK**.
The benefit of using this filter instead of doing the
heavy-lifting with
**tc**
itself is that on one hand it might be convenient to keep packet filtering and
classification in one place, possibly having to match a packet just once, and on
the other users familiar with
**iptables** but not **tc**
will have a less hard time adding QoS to their setups.

<a name="options"></a>

# Options


* **classid**_ CLASSID_  
  Push matching packets to the class identified by
  _CLASSID_.
* **action**_ ACTION_SPEC_  
  Apply an action from the generic actions framework on matching packets.

<a name="examples"></a>

# Examples

Take e.g. the following tc filter statement:

.EX
tc filter add ... handle 6 fw classid 1:1
.EE

will match if the packet's
**fwmark**
value is
**6**.
This is a sample
**iptables**
statement marking packets coming in on eth0:

.EX
iptables -t mangle -A PREROUTING -i eth0 -j MARK --set-mark 6
.EE

<a name="see-also"></a>

# See Also

**tc**(8),
**iptables**(8),
**iptables-extensions**(8)
