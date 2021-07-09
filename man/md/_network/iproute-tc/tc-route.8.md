# route classifier in tc(8) - route traffic control filter

iproute2, 21 Oct 2015

```
.in +8 .ti -8 tc filter ... route [ from REALM |  fromif TAG ] [  to REALM ] [  classid CLASSID ] [  action ACTION_SPEC ]
```

<a name="description"></a>

# Description

Match packets based on routing table entries. This filter centers around the
possibility to assign a
**realm**
to routing table entries. For any packet to be classified by this filter, a
routing table lookup is performed and the returned
**realm**
is used to decide on whether the packet is a match or not.

<a name="options"></a>

# Options


* **action**_ ACTION_SPEC_  
  Apply an action from the generic actions framework on matching packets.
* **classid**_ CLASSID_  
  Push matching packets into the class identified by
  _CLASSID_.
* **from**_ REALM_  
  .TQ
  **fromif**_ TAG_
  Perform source route lookups.
  _TAG_
  is the name of an interface which must be present on the system at the time of
  **tc**
  invocation.
* **to**_ REALM_  
  Match if normal (i.e., destination) routing returns the given
  _REALM_.

<a name="examples"></a>

# Examples

Consider the subnet 192.168.2.0/24 being attached to eth0:

.EX
ip route add 192.168.2.0/24 dev eth0 realm 2
.EE

The following
**route**
filter will then match packets from that subnet:

.EX
tc filter add ... route from 2 classid 1:2
.EE

and pass packets on to class 1:2.

<a name="notes"></a>

# Notes

Due to implementation details,
**realm**
values must be in a range from 0 to 255, inclusive. Alternatively, a verbose
name defined in /etc/iproute2/rt_realms may be given instead.

<a name="see-also"></a>

# See Also

**tc**(8),
**ip-route**(8)
