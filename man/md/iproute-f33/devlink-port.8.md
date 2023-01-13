# devlink\-port(8) - devlink port configuration

iproute2, 14 Mar 2016

```

 .in +8 .ti -8 devlink [ OPTIONS ] port  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] | -n[no-nice-names] }
</synopsis>

<synopsis>
.ti -8 devlink port set  DEV/PORT_INDEX [  type { eth | ib | auto } ]
</synopsis>

<synopsis>
.ti -8 devlink port split  DEV/PORT_INDEX count COUNT
</synopsis>

<synopsis>
.ti -8 devlink port unsplit  DEV/PORT_INDEX
</synopsis>

<synopsis>
.ti -8 devlink port show [ DEV/PORT_INDEX ]
</synopsis>

<synopsis>
.ti -8 devlink port help
```


<a name="description"></a>

# Description


<a name="devlink-port-set-change-devlink-port-attributes"></a>

### devlink port set - change devlink port attributes



**DEV/PORT_INDEX**
- specifies the devlink port to operate on.

.in +4
Format is:
.in +2
BUS_NAME/BUS_ADDRESS/PORT_INDEX


* **type** { **eth** | **ib** | **auto** }   
  set port type
  
  _eth_
  - Ethernet
  
  _ib_
  - Infiniband
  
  _auto_
  - autoselect
  

<a name="devlink-port-split-split-devlink-port-into-more"></a>

### devlink port split - split devlink port into more



**DEV/PORT_INDEX**
- specifies the devlink port to operate on.


* **count**_ COUNT_  
  number of ports to split to.
  

<a name="devlink-port-unsplit-unsplit-previously-split-devlink-port"></a>

### devlink port unsplit - unsplit previously split devlink port

Could be performed on any split port of the same split group.


**DEV/PORT_INDEX**
- specifies the devlink port to operate on.


<a name="devlink-port-show-display-devlink-port-attributes"></a>

### devlink port show - display devlink port attributes



_DEV/PORT_INDEX_
- specifies the devlink port to show.
If this argument is omitted all ports are listed.


<a name="examples"></a>

# Examples


devlink port show
Shows the state of all devlink ports on the system.

devlink port show pci/0000:01:00.0/1
Shows the state of specified devlink port.

devlink port set pci/0000:01:00.0/1 type eth
Set type of specified devlink port to Ethernet.

devlink port split pci/0000:01:00.0/1 count 4
Split the specified devlink port into four ports.

devlink port unsplit pci/0000:01:00.0/1
Unplit the specified previously split devlink port.


<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-dev**(8),
**devlink-sb**(8),
**devlink-monitor**(8),  


<a name="author"></a>

# Author

Jiri Pirko &lt;[jiri@mellanox.com](mailto:jiri@mellanox.com)&gt;
