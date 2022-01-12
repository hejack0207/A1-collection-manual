# usb-devices(1)

usbutils-010, 23 June 2009

.IX usb-devices

<a name="name"></a>

# Name

usb-devices - print USB device details

<a name="synopsis"></a>

# Synopsis

```
usb-devices
```


<a name="description"></a>

# Description

**usb-devices**
is a (bash) shell script that can be used to display details of USB
buses in the system and the devices connected to them.

The output of the script is similar to the _usb/devices_ file
available either under _/proc/bus_ (if usbfs is mounted), or under
_/sys/kernel/debug_ (if debugfs is mounted there). The script is
primarily intended to be used if the file is not available.

In contrast to the _usb/devices_ file, this script only lists
_active_ interfaces (those marked with a "*" in the _usb/devices_
file) and their endpoints.

Be advised that there can be differences in the way information is sorted,
as well as in the format of the output.


<a name="return-value"></a>

# Return Value

If sysfs is not mounted, a non-zero exit code is returned.


<a name="files"></a>

# Files


* **/sys/bus/usb/devices/usb***  
  The part of the sysfs tree the script walks through to assemble the
  printed information.
* **/proc/bus/usb/devices**  
  Location where the _usb/devices_ file can normally be found for
  Linux kernels before 2.6.31, if usbfs is mounted.
* **/sys/kernel/debug/usb/devices**  
  Location where the _usb/devices_ file can normally be found for
  Linux kernel 2.6.31 and later, if debugfs is mounted.
  

<a name="see-also"></a>

# See Also

**lsusb**(8),
**usbview**(8).


<a name="authors"></a>

# Authors

Greg Kroah-Hartman &lt;[greg@kroah.com](mailto:greg@kroah.com)&gt;

Randy Dunlap &lt;[rdunlap@xenotime.net](mailto:rdunlap@xenotime.net)&gt;

Frans Pop &lt;[elendil@planet.nl](mailto:elendil@planet.nl)&gt;
