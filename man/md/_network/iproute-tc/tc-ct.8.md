# ct action in tc(8) - tc connection tracking action

iproute2, 14 May 2020

```
.in +8 .ti -8 tc ... action ct commit [ force ] [ zone  ZONE ] [ mark  MASKED_MARK ] [ label  MASKED_LABEL ] [ nat  NAT_SPEC ]
</synopsis>

<synopsis>
.ti -8 tc ... action ct [ nat ] [ zone  ZONE ]
</synopsis>

<synopsis>
.ti -8 tc ... action ct clear
```


<a name="description"></a>

# Description

The ct action is a tc action for sending packets and interacting with the netfilter conntrack module.

It can (as shown in the synopsis, in order):

Send the packet to conntrack, and commit the connection, while configuring
a 32bit mark, 128bit label, and src/dst nat.

Send the packet to conntrack, which will mark the packet with the connection's state and
configured metadata (mark/label), and execute previous configured nat.

Clear the packet's of previous connection tracking state.


<a name="options"></a>

# Options


* **zone**_ ZONE_  
  Specify a conntrack zone number on which to send the packet to conntrack.
* **mark**_ MASKED_MARK_  
  Specify a masked 32bit mark to set for the connection (only valid with commit).
* **label**_ MASKED_LABEL_  
  Specify a masked 128bit label to set for the connection (only valid with commit).
* **nat**_ NAT_SPEC_  
  **Where**_ NAT_SPEC _**:= {src|dst} addr**_ addr1_**[-**_addr2_**] [port **_port1_**[-**_port2_**]]**
  
  Specify src/dst and range of nat to configure for the connection (only valid with commit).
    * src/dst - configure src or dst nat  
    * **""**_addr1_**/**_addr2_** - IPv4/IPv6 addresses**  
    * **""**_port1_**/**_port2_** - Port numbers**  
* **nat**  
  Restore any previous configured nat.
* **clear**  
  Remove any conntrack state and metadata (mark/label) from the packet (must only option specified).
* **force**  
  Forces conntrack direction for a previously commited connections, so that current direction will become the original direction (only valid with commit).
  

<a name="examples"></a>

# Examples

Example showing natted firewall in conntrack zone 2, and conntrack mark usage:
.EX

#Add ingress qdisc on eth0 and eth1 interfaces
    $ tc qdisc add dev eth0 handle ingress
    $ tc qdisc add dev eth1 handle ingress
    
    #Setup filters on eth0, allowing opening new connections in zone 2, and doing src nat + mark for each new connection
    $ tc filter add dev eth0 ingress prio 1 chain 0 proto ip flower ip_proto tcp ct_state -trk action ct zone 2 pipe action goto chain 2
    $ tc filter add dev eth0 ingress prio 1 chain 2 proto ip flower ct_state +trk+new action ct zone 2 commit mark 0xbb nat src addr 5.5.5.7 pipe action mirred egress redirect dev eth1
    $ tc filter add dev eth0 ingress prio 1 chain 2 proto ip flower ct_zone 2 ct_mark 0xbb ct_state +trk+est action ct nat pipe action mirred egress redirect dev eth1
    
    #Setup filters on eth1, allowing only established connections of zone 2 through, and reverse nat (dst nat in this case)
    $ tc filter add dev eth1 ingress prio 1 chain 0 proto ip flower ip_proto tcp ct_state -trk action ct zone 2 pipe action goto chain 1
    $ tc filter add dev eth1 ingress prio 1 chain 1 proto ip flower ct_zone 2 ct_mark 0xbb ct_state +trk+est action ct nat pipe action mirred egress redirect dev eth0

.EE


<a name="see-also"></a>

# See Also

**tc**(8),
**tc-flower**(8)
**tc-mirred**(8)

<a name="authors"></a>

# Authors

Paul Blakey &lt;[paulb@mellanox.com](mailto:paulb@mellanox.com)&gt;

Marcelo Ricardo Leitner &lt;[marcelo.leitner@gmail.com](mailto:marcelo.leitner@gmail.com)&gt;

Yossi Kuperman &lt;[yossiku@mellanox.com](mailto:yossiku@mellanox.com)&gt;
