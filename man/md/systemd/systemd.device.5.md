# systemd\&.device(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.device - Device unit configuration

<a name="synopsis"></a>

# Synopsis

```

 device.device
```

<a name="description"></a>

# Description


A unit configuration file whose name ends in
".device"
encodes information about a device unit as exposed in the sysfs/**udev**(7)
device tree.

This unit type has no specific options. See
**systemd.unit**(5)
for the common options of all unit configuration files. The common configuration items are configured in the generic
"[Unit]"
and
"[Install]"
sections. A separate
"[Device]"
section does not exist, since no device-specific options may be configured.

systemd will dynamically create device units for all kernel devices that are marked with the "systemd" udev tag (by default all block and network devices, and a few others). This may be used to define dependencies between devices and other units. To tag a udev device, use
"TAG+="systemd""
in the udev rules file, see
**udev**(7)
for details.

Device units are named after the
/sys
and
/dev
paths they control. Example: the device
/dev/sda5
is exposed in systemd as
dev-sda5.device. For details about the escaping logic used to convert a file system path to a unit name see
**systemd.unit**(5).

Device units will be reloaded by systemd whenever the corresponding device generates a
"changed"
event. Other units can use
_ReloadPropagatedFrom=_
to react to that event

<a name="automatic-dependencies"></a>

# Automatic Dependencies


<a name="implicit-dependencies"></a>

### Implicit Dependencies


Many unit types automatically acquire dependencies on device units of devices they require. For example,
.socket
unit acquire dependencies on the device units of the network interface specified in
_BindToDevice=_. Similar, swap and mount units acquire dependencies on the units encapsulating their backing block devices.

<a name="default-dependencies"></a>

### Default Dependencies


There are no default dependencies for device units.

<a name="the-udev-database"></a>

# The Udev Database


Unit settings of device units may either be configured via unit files, or directly from the udev database. The following udev device properties are understood by the service manager:

_SYSTEMD\_WANTS=_, _SYSTEMD\_USER\_WANTS=_
Adds dependencies of type
_Wants=_
from the device unit to the specified units.
_SYSTEMD\_WANTS=_
is read by the system service manager,
_SYSTEMD\_USER\_WANTS=_
by user service manager instances. These properties may be used to activate arbitrary units when a specific device becomes available.

Note that this and the other udev device properties are not taken into account unless the device is tagged with the
"systemd"
tag in the udev database, because otherwise the device is not exposed as a systemd unit (see above).

Note that systemd will only act on
_Wants=_
dependencies when a device first becomes active. It will not act on them if they are added to devices that are already active. Use
_SYSTEMD\_READY=_
(see below) to configure when a udev device shall be considered active, and thus when to trigger the dependencies.

The specified property value should be a space-separated list of valid unit names. If a unit template name is specified (that is, a unit name containing an
"@"
character indicating a unit name to use for multiple instantiation, but with an empty instance name following the
"@"), it will be automatically instantiated by the devices
"sysfs"
path (that is: the path is escaped and inserted as instance name into the template unit name). This is useful in order to instantiate a specific template unit once for each device that appears and matches specific properties.

_SYSTEMD\_ALIAS=_
Adds an additional alias name to the device unit. This must be an absolute path that is automatically transformed into a unit name. (See above.)

_SYSTEMD\_READY=_
If set to 0, systemd will consider this device unplugged even if it shows up in the udev tree. If this property is unset or set to 1, the device will be considered plugged if it is visible in the udev tree.

This option is useful for devices that initially show up in an uninitialized state in the tree, and for which a
"changed"
event is generated the moment they are fully set up. Note that
_SYSTEMD\_WANTS=_
(see above) is not acted on as long as
_SYSTEMD\_READY=0_
is set for a device.

_ID\_MODEL\_FROM\_DATABASE=_, _ID\_MODEL=_
If set, this property is used as description string for the device unit.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd.unit**(5),
**udev**(7),
**systemd.directives**(7)
