# devlink\-sb(8) - devlink shared buffer configuration

iproute2, 14 Apr 2016

```

 .in +8 .ti -8 devlink [ OPTIONS ] sb  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] | -n[no-nice-names] }
</synopsis>

<synopsis>
.ti -8 devlink sb show  [ DEV [  sb SB_INDEX ] ]
</synopsis>

<synopsis>
.ti -8 devlink sb pool show  [ DEV [  sb SB_INDEX ]
pool POOL_INDEX ]
</synopsis>

<synopsis>
.ti -8 devlink sb pool set DEV [ sb SB_INDEX ]
pool POOL_INDEX
size POOL_SIZE
thtype { static | dynamic }
</synopsis>

<synopsis>
.ti -8 devlink sb port pool show  [ DEV/PORT_INDEX [  sb SB_INDEX ]
pool POOL_INDEX ]
</synopsis>

<synopsis>
.ti -8 devlink sb port pool set DEV/PORT_INDEX [ sb SB_INDEX ]
pool POOL_INDEX
th THRESHOLD 
</synopsis>

<synopsis>
.ti -8 devlink sb tc bind show  [ DEV/PORT_INDEX [  sb SB_INDEX ]
tc TC_INDEX
type { ingress | egress } ]
</synopsis>

<synopsis>
.ti -8 devlink sb tc bind set DEV/PORT_INDEX [ sb SB_INDEX ]
tc TC_INDEX
type { ingress | egress }
pool POOL_INDEX
th THRESHOLD 
</synopsis>

<synopsis>
.ti -8 devlink sb occupancy show  { DEV | DEV/PORT_INDEX } [  sb SB_INDEX ] 
</synopsis>

<synopsis>
.ti -8 devlink sb occupancy snapshot  DEV [  sb SB_INDEX ]
</synopsis>

<synopsis>
.ti -8 devlink sb occupancy clearmax  DEV [  sb SB_INDEX ]
</synopsis>

<synopsis>
.ti -8 devlink sb help
```


<a name="description"></a>

# Description


<a name="devlink-sb-show-display-available-shared-buffers-and-their-attributes"></a>

### devlink sb show - display available shared buffers and their attributes



_DEV_
- specifies the devlink device to show shared buffers.
If this argument is omitted all shared buffers of all devices are listed.


_SB_INDEX_
- specifies the shared buffer.
If this argument is omitted shared buffer with index 0 is selected.
Behaviour of this argument it the same for every command.


<a name="devlink-sb-pool-show-display-available-pools-and-their-attributes"></a>

### devlink sb pool show - display available pools and their attributes



_DEV_
- specifies the devlink device to show pools.
If this argument is omitted all pools of all devices are listed.

Display available pools listing their
**type, size, thtype**
and
**cell_size. cell_size**
is the allocation granularity of memory within the shared buffer. Drivers
may round up, round down or reject
**size**
passed to the set command if it is not multiple of
**cell_size.**


<a name="devlink-sb-pool-set-set-attributes-of-pool"></a>

### devlink sb pool set - set attributes of pool



_DEV_
- specifies the devlink device to set pool.


* **size**_ POOL_SIZE_  
  size of the pool in Bytes.
  
* **thtype** { **static** | **dynamic** }   
  pool threshold type.
  
  _static_
  - Threshold values for the pool will be passed in Bytes.
  
  _dynamic_
  - Threshold values ("to_alpha") for the pool will be used to compute alpha parameter according to formula:  
  .in +16
  alpha = 2 ^ (to_alpha - 10)
  .in -16
  
  .in +10
  The range of the passed value is between 0 to 20. The computed alpha is used to determine the maximum usage of the flow:
  .in -10  
  .in +16
  max_usage = alpha / (1 + alpha) * Free_Buffer
  .in -16
  

<a name="devlink-sb-port-pool-show-display-port-pool-combinations-and-threshold-for-each"></a>

### devlink sb port pool show - display port-pool combinations and threshold for each

_DEV/PORT_INDEX_
- specifies the devlink port.


* **pool**_ POOL_INDEX_  
  pool index.
  

<a name="devlink-sb-port-pool-set-set-port-pool-threshold"></a>

### devlink sb port pool set - set port-pool threshold

_DEV/PORT_INDEX_
- specifies the devlink port.


* **pool**_ POOL_INDEX_  
  pool index.
  
* **th**_ THRESHOLD_  
  threshold value. Type of the value is either Bytes or "to_alpha", depends on
  **thtype**
  set for the pool.
  

<a name="devlink-sb-tc-bind-show-display-port-tc-to-pool-bindings-and-threshold-for-each"></a>

### devlink sb tc bind show - display port-TC to pool bindings and threshold for each


_DEV/PORT_INDEX_
- specifies the devlink port.


* **tc**_ TC_INDEX_  
  index of either ingress or egress TC, usually in range 0 to 8 (depends on device).
  
* **type** { **ingress** | **egress** }   
  TC type.
  

<a name="devlink-sb-tc-bind-set-set-port-tc-to-pool-binding-with-specified-threshold"></a>

### devlink sb tc bind set - set port-TC to pool binding with specified threshold


_DEV/PORT_INDEX_
- specifies the devlink port.


* **tc**_ TC_INDEX_  
  index of either ingress or egress TC, usually in range 0 to 8 (depends on device).
  
* **type** { **ingress** | **egress** }   
  TC type.
  
* **pool**_ POOL_INDEX_  
  index of pool to bind this to.
  
* **th**_ THRESHOLD_  
  threshold value. Type of the value is either Bytes or "to_alpha", depends on
  **thtype**
  set for the pool.
  

<a name="devlink-sb-occupancy-show-display-shared-buffer-occupancy-values-for-device-or-port"></a>

### devlink sb occupancy show - display shared buffer occupancy values for device or port



This command is used to browse shared buffer occupancy values. Values are showed for every port-pool combination as well as for all port-TC combinations (with pool this port-TC is bound to). Format of value is:  
.in +16
current_value/max_value
.in -16
Note that before showing values, one has to issue
**occupancy snapshot**
command first.


_DEV_
- specifies the devlink device to show occupancy values for.

_DEV/PORT_INDEX_
- specifies the devlink port to show occupancy values for.


<a name="devlink-sb-occupancy-snapshot-take-occupancy-snapshot-of-shared-buffer-for-device"></a>

### devlink sb occupancy snapshot - take occupancy snapshot of shared buffer for device

This command is used to take a snapshot of shared buffer occupancy values. After that, the values can be showed using
**occupancy show**
command.


_DEV_
- specifies the devlink device to take occupancy snapshot on.


<a name="devlink-sb-occupancy-clearmax-clear-occupancy-watermarks-of-shared-buffer-for-device"></a>

### devlink sb occupancy clearmax - clear occupancy watermarks of shared buffer for device

This command is used to reset maximal occupancy values reached for whole device. Note that before browsing reset values, one has to issue
**occupancy snapshot**
command.


_DEV_
- specifies the devlink device to clear occupancy watermarks on.


<a name="examples"></a>

# Examples


devlink sb show
List available share buffers.

devlink sb pool show
List available pools and their config.

devlink sb port pool show pci/0000:03:00.0/1 pool 0
Show port-pool setup for specified port and pool.

sudo devlink sb port pool set pci/0000:03:00.0/1 pool 0 th 15
Change threshold for port specified port and pool.

devlink sb tc bind show pci/0000:03:00.0/1 tc 0 type ingress
Show pool binding and threshold for specified port and TC.

sudo devlink sb tc bind set pci/0000:03:00.0/1 tc 0 type ingress pool 0 th 9
Set pool binding and threshold for specified port and TC.

sudo devlink sb occupancy snapshot pci/0000:03:00.0
Make a snapshot of occupancy of shared buffer for specified devlink device.

devlink sb occupancy show pci/0000:03:00.0/1
Show occupancy for specified port from the snapshot.

sudo devlink sb occupancy clearmax pci/0000:03:00.0
Clear watermarks for shared buffer of specified devlink device.



<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-dev**(8),
**devlink-port**(8),
**devlink-monitor**(8),  


<a name="author"></a>

# Author

Jiri Pirko &lt;[jiri@mellanox.com](mailto:jiri@mellanox.com)&gt;
