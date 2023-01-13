# devlink\-resource(8) - devlink device resource configuration

iproute2, 11 Feb 2018

```

 .in +8 .ti -8 devlink [ OPTIONS ] resource  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -v[erbose] }
</synopsis>

<synopsis>
.ti -8 devlink resource show DEV
</synopsis>

<synopsis>
.ti -8 devlink resource help
</synopsis>

<synopsis>
.ti -8 devlink resource set DEV path RESOURCE_PATH size RESOURCE_SIZE
```


<a name="description"></a>

# Description


<a name="devlink-resource-show-display-devlink-devices-resosources"></a>

### devlink resource show - display devlink device's resosources



_DEV_
- specifies the devlink device to show.

.in +4
Format is:
.in +2
BUS_NAME/BUS_ADDRESS


<a name="devlink-resource-set-sets-resource-size-of-specific-resource"></a>

### devlink resource set - sets resource size of specific resource



_DEV_
- specifies the devlink device.


* **path**_ RESOURCE_PATH_  
  Resource's path.
  
* **size**_ RESOURCE_SIZE_  
  The new resource's size.
  

<a name="examples"></a>

# Examples


devlink resource show pci/0000:01:00.0
Shows the resources of the specified devlink device.

devlink resource set pci/0000:01:00.0 /kvd/linear 98304
Sets the size of the specified resource for the specified devlink device.


<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-port**(8),
**devlink-sb**(8),
**devlink-monitor**(8),  


<a name="author"></a>

# Author

Arkadi Sharshevsky &lt;[arkadis@mellanox.com](mailto:arkadis@mellanox.com)&gt;
