# devlink\-dev(8) - devlink device configuration

iproute2, 14 Mar 2016

```

 .in +8 .ti -8 devlink [ OPTIONS ] dev  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] | -n[no-nice-names] }
</synopsis>

<synopsis>
.ti -8 devlink dev show [ DEV ]
</synopsis>

<synopsis>
.ti -8 devlink dev help
</synopsis>

<synopsis>
.ti -8 devlink dev eswitch set DEV [ mode { legacy | switchdev }  ] [ inline-mode { none | link | network | transport }  ] [ encap-mode { none | basic }  ]
</synopsis>

<synopsis>
.ti -8 devlink dev eswitch show DEV
</synopsis>

<synopsis>
.ti -8 devlink dev param set DEV name PARAMETER value VALUE cmode { runtime | driverinit | permanent } 
</synopsis>

<synopsis>
.ti -8 devlink dev param show [ DEV name PARAMETER ]
</synopsis>

<synopsis>
.ti -8 devlink dev reload DEV [ netns { PID | NAME | ID } ]
</synopsis>

<synopsis>
.ti -8 devlink dev info [ DEV ]
</synopsis>

<synopsis>
.ti -8 devlink dev flash DEV file PATH [ target ID ]
```


<a name="description"></a>

# Description


<a name="devlink-dev-show-display-devlink-device-attributes"></a>

### devlink dev show - display devlink device attributes



_DEV_
- specifies the devlink device to show.
If this argument is omitted all devices are listed.

.in +4
Format is:
.in +2
BUS_NAME/BUS_ADDRESS


<a name="devlink-dev-eswitch-show-display-devlink-device-eswitch-attributes"></a>

### devlink dev eswitch show - display devlink device eswitch attributes


<a name="devlink-dev-eswitch-set-sets-devlink-device-eswitch-attributes"></a>

### devlink dev eswitch set  - sets devlink device eswitch attributes



* **mode** { **legacy** | **switchdev** }   
  Set eswitch mode
  
  _legacy_
  - Legacy SRIOV
  
  _switchdev_
  - SRIOV switchdev offloads
  
* **inline-mode** { **none** | **link** | **network** | **transport** }   
  Some HWs need the VF driver to put part of the packet headers on the TX descriptor so the e-switch can do proper matching and steering.
  
  _none_
  - None
  
  _link_
  - L2 mode
  
  _network_
  - L3 mode
  
  _transport_
  - L4 mode
  
* **encap-mode** { **none** | **basic** }   
  Set eswitch encapsulation support
  
  _none_
  - Disable encapsulation support
  
  _basic_
  - Enable encapsulation support
  

<a name="devlink-dev-param-set-set-new-value-to-devlink-device-configuration-parameter"></a>

### devlink dev param set  - set new value to devlink device configuration parameter



* **name**_ PARAMETER_  
  Specify parameter name to set.
  
* **value**_ VALUE_  
  New value to set.
  
* **cmode** { **runtime** | **driverinit** | **permanent** }   
  Configuration mode in which the new value is set.
  
  _runtime_
  - Set new value while driver is running. This configuration mode doesn't require any reset to apply the new value.
  
  _driverinit_
  - Set new value which will be applied during driver initialization. This configuration mode requires restart driver by devlink reload command to apply the new value.
  
  _permanent_
  - New value is written to device's non-volatile memory. This configuration mode requires hard reset to apply the new value.
  

<a name="devlink-dev-param-show-display-devlink-device-supported-configuration-parameters-attributes"></a>

### devlink dev param show - display devlink device supported configuration parameters attributes


**name**
_PARAMETER_
Specify parameter name to show.
If this argument is omitted all parameters supported by devlink devices are listed.


<a name="devlink-dev-reload-perform-hot-reload-of-the-driver"></a>

### devlink dev reload - perform hot reload of the driver.



_DEV_
- Specifies the devlink device to reload.

**netns**
{_ PID _|_ NAME _|_ ID _}
- Specifies the network namespace to reload into, either by pid, name or id.


<a name="devlink-dev-info-display-device-information"></a>

### devlink dev info - display device information.

Display device information provided by the driver. This command can be used
to query versions of the hardware components or device components which
can't be updated (
_fixed_
) as well as device firmware which can be updated. For firmware components
_running_
displays the versions of firmware currently loaded into the device, while
_stored_
reports the versions in device's flash.
_Running_
and
_stored_
versions may differ after flash has been updated, but before reboot.


_DEV_
- specifies the devlink device to show.
If this argument is omitted all devices are listed.


<a name="devlink-dev-flash-write-devices-non-volatile-memory"></a>

### devlink dev flash - write device's non-volatile memory.



_DEV_
- specifies the devlink device to write to.

**file**
_PATH_
- Path to the file which will be written into device's flash. The path needs
to be relative to one of the directories searched by the kernel firmware loaded,
such as /lib/firmware.

**component**
_NAME_
- If device stores multiple firmware images in non-volatile memory, this
parameter may be used to indicate which firmware image should be written.
The value of
_NAME_
should match the component names from
**devlink dev info**
and may be driver-dependent.


<a name="examples"></a>

# Examples


devlink dev show
Shows the state of all devlink devices on the system.

devlink dev show pci/0000:01:00.0
Shows the state of specified devlink device.

devlink dev eswitch show pci/0000:01:00.0
Shows the eswitch mode of specified devlink device.

devlink dev eswitch set pci/0000:01:00.0 mode switchdev
Sets the eswitch mode of specified devlink device to switchdev.

devlink dev param show pci/0000:01:00.0 name max_macs
Shows the parameter max_macs attributes.

devlink dev param set pci/0000:01:00.0 name internal_error_reset value true cmode runtime
Sets the parameter internal_error_reset of specified devlink device to true.

devlink dev reload pci/0000:01:00.0
Performs hot reload of specified devlink device.

devlink dev flash pci/0000:01:00.0 file firmware.bin
Flashes the specified devlink device with provided firmware file name. If the driver supports it, user gets updates about the flash status. For example:  
Preparing to flash  
Flashing 100%  
Flashing done


<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-port**(8),
**devlink-sb**(8),
**devlink-monitor**(8),  


<a name="author"></a>

# Author

Jiri Pirko &lt;[jiri@mellanox.com](mailto:jiri@mellanox.com)&gt;
