# ciptool(1) - Bluetooth Common ISDN Access Profile (CIP)

"", JUNE 6, 2003

```
ciptool [ options ] < command >
```

<a name="description"></a>

# Description

**ciptool**
is used to set up, maintain, and inspect the CIP configuration
of the Bluetooth subsystem in the Linux kernel.

<a name="options"></a>

# Options


* **-h**  
  Gives a list of possible commands.
* **-i**_ &lt;hciX&gt; | &lt;bdaddr&gt;_  
  The command is applied to device
  .I
  hciX
  , which must be the name or the address of an installed Bluetooth
  device. If not specified, the command will be use the first
  available Bluetooth device.

<a name="commands"></a>

# Commands


* **show**  
  Display information about the connected devices.
* **search**  
  Search for Bluetooth devices and connect to first one that
  offers CIP support.
* **connect**_ &lt;bdaddr&gt; [psm]_  
  Connect the local device to the remote Bluetooth device on the
  specified PSM number. If no PSM is specified, it will use the
  SDP to retrieve it from the remote device.
* **release**_ [bdaddr]_  
  Release a connection to the specific device. If no address is
  given and only one device is connected this will be released.
* **loopback**_ &lt;bdaddr&gt; [psm]_  
  Create a connection to the remote device for Bluetooth testing.
  This command will not provide a CAPI controller, because it is
  only for testing the CAPI Message Transport Protocol.

<a name="author"></a>

# Author

Written by Marcel Holtmann &lt;[marcel@holtmann.org](mailto:marcel@holtmann.org)&gt;.  
