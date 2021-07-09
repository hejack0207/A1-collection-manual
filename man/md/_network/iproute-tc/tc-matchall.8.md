# match-all classifier in tc(8) - traffic control filter that matches every packet

iproute2, 21 Oct 2015

```
.in +8 .ti -8 tc filter ... matchall [  skip_sw | skip_hw  ] [  action ACTION_SPEC ] [  classid CLASSID ]
```

<a name="description"></a>

# Description

The
**matchall**
filter allows to classify every packet that flows on the port and run a
action on it.

<a name="options"></a>

# Options


* **action**_ ACTION_SPEC_  
  Apply an action from the generic actions framework on matching packets.
* **classid**_ CLASSID_  
  Push matching packets into the class identified by
  _CLASSID_.
* **skip_sw**  
  Do not process filter by software. If hardware has no offload support for this
  filter, or TC offload is not enabled for the interface, operation will fail.
* **skip_hw**  
  Do not process filter by hardware.

<a name="examples"></a>

# Examples

To create ingress mirroring from port eth1 to port eth2:
.EX

tc qdisc  add dev eth1 handle ffff: ingress
tc filter add dev eth1 parent ffff:           &nbsp;       matchall skip_sw                      &nbsp;       action mirred egress mirror           &nbsp;       dev eth2
.EE

The first command creats an ingress qdisc with handle
**ffff:**
on device
**eth1**
where the second command attaches a matchall filters on it that mirrors the
packets to device eth2.

To create egress mirroring from port eth1 to port eth2:
.EX

tc qdisc add dev eth1 handle 1: root prio
tc filter add dev eth1 parent 1:               &nbsp;       matchall skip_sw                       &nbsp;       action mirred egress mirror            &nbsp;       dev eth2
.EE

The first command creats an egress qdisc with handle
**1:**
that replaces the root qdisc on device
**eth1**
where the second command attaches a matchall filters on it that mirrors the
packets to device eth2.

To sample one of every 100 packets flowing into interface eth0 to psample group
12:
.EX

tc qdisc add dev eth0 handle ffff: ingress
tc filter add dev eth0 parent ffff: matchall &nbsp;    action sample rate 100 group 12
.EE

.EE

<a name="see-also"></a>

# See Also

**tc**(8),
