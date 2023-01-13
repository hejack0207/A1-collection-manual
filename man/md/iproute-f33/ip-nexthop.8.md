# ip\-nexthop(8) - nexthop object management

iproute2, 30 May 2019

```

 .in +8 .ti -8 ip [ ip-OPTIONS ] nexthop  { COMMAND |  help } 
 .ti -8
</synopsis>

<synopsis>
.ti -8 ip nexthop {  show | flush }   SELECTOR
</synopsis>

<synopsis>
.ti -8 ip nexthop { add | replace } id  ID NH
</synopsis>

<synopsis>
.ti -8 ip nexthop { get | del } id   ID
</synopsis>

<synopsis>
.ti -8 SELECTOR :=  [ id ID ] [   dev DEV ] [   vrf NAME ] [   master DEV ] [  groups ] 
</synopsis>

<synopsis>
.ti -8 NH := {  blackhole | [   via ADDRESS ] [   dev DEV ] [  onlink ] [  encap ENCAP ] |   group GROUP } 
</synopsis>

<synopsis>
.ti -8 ENCAP := [  ENCAP_MPLS ] 
</synopsis>

<synopsis>
.ti -8 ENCAP_MPLS :=  mpls [  LABEL ] [  ttl TTL ]
</synopsis>

<synopsis>
.ti -8 GROUP :=  id[,weight[/...]
```


<a name="description"></a>

# Description

**ip nexthop**
is used to manipulate entries in the kernel's nexthop tables.

* ip nexthop add id ID  
  add new nexthop entry
* ip nexthop replace id ID  
  change the configuration of a nexthop or add new one
    * **via**_ [ FAMILY ] ADDRESS_  
      the address of the nexthop router, in the address family FAMILY.
      Address family must match address family of nexthop instance.
    * **dev**_ NAME_  
      is the output device.
    * **onlink**  
      pretend that the nexthop is directly attached to this link,
      even if it does not match any interface prefix.
    * **encap**_ ENCAPTYPE ENCAPHDR_  
      attach tunnel encapsulation attributes to this route.

_ENCAPTYPE_
is a string specifying the supported encapsulation type. Namely:

.in +8
**mpls**
- encapsulation type MPLS

.in -8
_ENCAPHDR_
is a set of encapsulation attributes specific to the
_ENCAPTYPE._

.in +8
**mpls**
.in +2
_MPLSLABEL_
- mpls label stack with labels separated by
_/_


**ttl**
_TTL_
- TTL to use for MPLS header or 0 to inherit from IP header
.in -2


* **group**_ GROUP_  
  create a nexthop group. Group specification is id with an optional
  weight (id,weight) and a '/' as a separator between entries.
* **blackhole**  
  create a blackhole nexthop


* ip nexthop delete id ID  
  delete nexthop with given id.
  
* ip nexthop show  
  show the contents of the nexthop table or the nexthops
  selected by some criteria.
    * **dev**_ DEV _  
      show the nexthops using the given device.
    * **vrf**_ NAME _  
      show the nexthops using devices associated with the vrf name
    * **master**_ DEV _  
      show the nexthops using devices enslaved to given master device
    * **groups**  
      show only nexthop groups
* ip nexthop flush  
  flushes nexthops selected by some criteria. Criteria options are the same
  as show.
  
* ip nexthop get id ID  
  get a single nexthop by id
  

<a name="examples"></a>

# Examples


ip nexthop ls
Show all nexthop entries in the kernel.

ip nexthop add id 1 via 192.168.1.1 dev eth0
Adds an IPv4 nexthop with id 1 using the gateway 192.168.1.1 out device eth0.

ip nexthop add id 2 encap mpls 200/300 via 10.1.1.1 dev eth0
Adds an IPv4 nexthop with mpls encapsulation attributes attached to it.

ip nexthop add id 3 group 1/2
Adds a nexthop with id 3. The nexthop is a group using nexthops with ids
1 and 2 at equal weight.

ip nexthop add id 4 group 1,5/2,11
Adds a nexthop with id 4. The nexthop is a group using nexthops with ids
1 and 2 with nexthop 1 at weight 5 and nexthop 2 at weight 11.

<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Original Manpage by David Ahern &lt;[dsahern@kernel.org](mailto:dsahern@kernel.org)&gt;
