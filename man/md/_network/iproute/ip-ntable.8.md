# ip\-ntable(8) - neighbour table configuration

iproute2, 20 Dec 2011

```

 .in +8 .ti -8 ip [ OPTIONS ] ntable  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 ip ntable change name NAME [  dev DEV ] [ thresh1 VAL ] [ thresh2 VAL ] [ thresh3 VAL ] [ gc_int MSEC ] [ base_reachable MSEC ] [ retrans MSEC ] [ gc_stale MSEC ] [ delay_probe MSEC ] [ queue LEN ] [ app_probs VAL ] [ ucast_probes VAL ] [ mcast_probes VAL ] [ anycast_delay MSEC ] [ proxy_delay MSEC ] [ proxy_queue LEN ] [ locktime MSEC ]
</synopsis>

<synopsis>
.ti -8 ip ntable show [  dev DEV ] [  name NAME ]
```


<a name="description"></a>

# Description

_ip ntable_
controls the parameters for the neighbour tables.


<a name="ip-ntable-show-list-the-ip-neighbour-tables"></a>

### ip ntable show - list the ip neighbour tables


This commands displays neighbour table parameters and statistics.


* **dev**_ DEV_  
  only list the table attached to this device.
  
* **name**_ NAME_  
  only lists the table with the given name.
  

<a name="ip-ntable-change-modify-table-parameter"></a>

### ip ntable change - modify table parameter


This command allows modifying table parameters such as timers and queue lengths.

* **name**_ NAME_  
  the name of the table to modify.
  
* **dev**_ DEV_  
  the name of the device to modify the table values.
  

<a name="examples"></a>

# Examples


ip ntable show dev eth0
Shows the neighbour table (IPv4 ARP and IPv6 ndisc) parameters on device eth0.

ip ntable change name arp_cache queue 8 dev eth0
Changes the number of packets queued while address is being resolved from the
default value (3) to 8 packets.


<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Manpage by Stephen Hemminger
