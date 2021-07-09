# iptables action in tc(8) - tc iptables action

iproute2, 3 Mar 2016

```
.in +8 .ti -8 tc ... action xt -j TARGET [ TARGET_OPTS ]
```

<a name="description"></a>

# Description

The
**xt**
action allows to call arbitrary iptables targets for packets matching the filter
this action is attached to.

<a name="options"></a>

# Options


* **-j**_ TARGET [_ TARGET_OPTS _]_  
  Perform a jump to the given iptables target, optionally passing any target
  specific options in
  _TARGET_OPTS_.

<a name="examples"></a>

# Examples

The following will attach a
**u32**
filter to the
**ingress**
qdisc matching ICMP replies and using the
**xt**
action to make the kernel yell 'PONG' each time:

.EX
tc qdisc add dev eth0 ingress
tc filter add dev eth0 parent ffff: proto ip u32 \	match ip protocol 1 0xff \	match ip icmp_type 0 0xff \	action xt -j LOG --log-prefix PONG
.EE

<a name="see-also"></a>

# See Also

**tc**(8),
**tc-u32**(8),
**iptables-extensions**(8)
