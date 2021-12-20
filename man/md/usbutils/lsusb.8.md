# lsusb(8)

usbutils-010, 6 May 2009

.IX lsusb

<a name="name"></a>

# Name

lsusb - list USB devices

<a name="synopsis"></a>

# Synopsis

```
lsusb [ options ]
```

<a name="description"></a>

# Description

**lsusb**
is a utility for displaying information about USB buses in the system and
the devices connected to them.


<a name="options"></a>

# Options


* **-v, --verbose**  
  Tells
  _lsusb_
  to be verbose and display detailed information about the devices shown.
  This includes configuration descriptors for the device's current speed.
  Class descriptors will be shown, when available, for USB device classes
  including hub, audio, HID, communications, and chipcard.
* **-s** [[_bus_]**:**][_devnum_]  
  Show only devices in specified
  _bus_
  and/or
  _devnum._
  Both ID's are given in decimal and may be omitted.
* **-d** [_vendor_]**:**[_product_]  
  Show only devices with the specified vendor and product ID.
  Both ID's are given in hexadecimal.
* **-D _device_**  
  Do not scan the /dev/bus/usb directory,
  instead display only information
  about the device whose device file is given.
  The device file should be something like /dev/bus/usb/001/001.
  This option displays detailed information like the **v** option;
  you must be root to do this.
* **-t**  
  Tells
  _lsusb_
  to dump the physical USB device hierarchy as a tree. This overrides the
  **v** option.
* **-V, --version**  
  Print  version information on standard output,
  then exit successfully.
  

<a name="return-value"></a>

# Return Value

If the specified device is not found, a non-zero exit code is returned.


<a name="files"></a>

# Files


* **/usr/share/hwdata/usb.ids**  
  A list of all known USB ID's (vendors, products, classes, subclasses and protocols).
  

<a name="see-also"></a>

# See Also

**lspci**(8),
**usbview**(8).


<a name="author"></a>

# Author

Thomas Sailer, &lt;[sailer@ife.ee](mailto:sailer@ife.ee).ethz.ch&gt;.
