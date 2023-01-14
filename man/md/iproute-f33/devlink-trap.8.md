# devlink\-trap(8) - devlink trap configuration

iproute2, 2 August 2019

```

 .in +8 .ti -8 devlink [ OPTIONS ] trap { COMMAND | help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -v[erbose] | -s[tatistics] }
</synopsis>

<synopsis>
.ti -8 "devlink trap show" [ DEV trap TRAP ]
</synopsis>

<synopsis>
.ti -8 devlink trap set DEV trap TRAP [ action { trap | drop | mirror } ]
</synopsis>

<synopsis>
.ti -8 "devlink trap group show" [ DEV group GROUP ]
</synopsis>

<synopsis>
.ti -8 devlink trap group set DEV group GROUP [ action { trap | drop | mirror } ]
[ policer POLICER ] [ nopolicer ]
</synopsis>

<synopsis>
.ti -8 devlink trap policer set DEV policer POLICER [ rate RATE ] [ burst BURST ]
</synopsis>

<synopsis>
.ti -8 devlink trap help
```


<a name="description"></a>

# Description


<a name="devlink-trap-show-display-available-packet-traps-and-their-attributes"></a>

### devlink trap show - display available packet traps and their attributes



_DEV_
- specifies the devlink device from which to show packet traps.
If this argument is omitted all packet traps of all devices are listed.


**trap **_TRAP_
- specifies the packet trap.
Only applicable if a devlink device is also specified.


<a name="devlink-trap-set-set-attributes-of-a-packet-trap"></a>

### devlink trap set - set attributes of a packet trap



_DEV_
- specifies the devlink device the packet trap belongs to.


**trap **_TRAP_
- specifies the packet trap.


* **action** { **trap** | **drop** | **mirror** }   
  packet trap action.
  
  _trap_
  - the sole copy of the packet is sent to the CPU.
  
  _drop_
  - the packet is dropped by the underlying device and a copy is not sent to the CPU.
  
  _mirror_
  - the packet is forwarded by the underlying device and a copy is sent to the CPU.
  

<a name="devlink-trap-group-show-display-available-packet-trap-groups-and-their-attributes"></a>

### devlink trap group show - display available packet trap groups and their attributes



_DEV_
- specifies the devlink device from which to show packet trap groups.
If this argument is omitted all packet trap groups of all devices are listed.


**group **_GROUP_
- specifies the packet trap group.
Only applicable if a devlink device is also specified.


<a name="devlink-trap-group-set-set-attributes-of-a-packet-trap-group"></a>

### devlink trap group set - set attributes of a packet trap group



_DEV_
- specifies the devlink device the packet trap group belongs to.


**group **_GROUP_
- specifies the packet trap group.


* **action** { **trap** | **drop** | **mirror** }   
  packet trap action. The action is set for all the packet traps member in the
  trap group. The actions of non-drop traps cannot be changed and are thus
  skipped.
  
* **policer**_ POLICER_  
  packet trap policer. The policer to bind to the packet trap group. A value of
  "0" will unbind the currently bound policer.
  
* **nopolicer**  
  Unbind packet trap policer from the packet trap group.
  

<a name="devlink-trap-policer-set-set-attributes-of-packet-trap-policer"></a>

### devlink trap policer set - set attributes of packet trap policer



_DEV_
- specifies the devlink device the packet trap policer belongs to.


**policer **_POLICER_
- specifies the packet trap policer.


**rate**_ RATE _
- packet trap policer rate in packets per second.


**burst**_ BURST _
- packet trap policer burst size in packets.


<a name="examples"></a>

# Examples


devlink trap show
List available packet traps.

devlink trap group show
List available packet trap groups.

devlink -vs trap show pci/0000:01:00.0 trap source_mac_is_multicast
Show attributes and statistics of a specific packet trap.

devlink -s trap group show pci/0000:01:00.0 group l2_drops
Show attributes and statistics of a specific packet trap group.

devlink trap set pci/0000:01:00.0 trap source_mac_is_multicast action trap
Set the action of a specific packet trap to 'trap'.

devlink trap policer show
List available packet trap policers.

devlink -s trap policer show pci/0000:01:00.0 policer 1
Show attributes and statistics of a specific packet trap policer.

devlink trap policer set pci/0000:01:00.0 policer 1 rate 1000 burst 128
Set the rate and burst size of a specific packet trap policer.


<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-dev**(8),
**devlink-monitor**(8),  


<a name="author"></a>

# Author

Ido Schimmel &lt;[idosch@mellanox.com](mailto:idosch@mellanox.com)&gt;
