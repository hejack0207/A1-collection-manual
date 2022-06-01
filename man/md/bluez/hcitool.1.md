# hcitool(1) - configure Bluetooth connections

BlueZ, Nov 12 2002

```
hcitool [-h]
hcitool [-i <hciX>] [command [command parameters]]
```


<a name="description"></a>

# Description


.B
hcitool
is used to configure Bluetooth connections and send some special command to
Bluetooth devices. If no
.B
command
is given, or if the option
.B
-h
is used,
.B
hcitool
prints some usage information and exits.

<a name="options"></a>

# Options


* **-h**  
  Gives a list of possible commands
* **-i**_ &lt;hciX&gt;_  
  The command is applied to device
  .I
  hciX
  , which must be the name of an installed Bluetooth device. If not specified,
  the command will be sent to the first available Bluetooth device.

<a name="commands"></a>

# Commands


* **dev**  
  Display local devices
* **inq**  
  Inquire remote devices. For each discovered device, Bluetooth device address,
  clock offset and class are printed.
* **scan**  
  Inquire remote devices. For each discovered device, device name are printed.
* **name**_ &lt;bdaddr&gt;_  
  Print device name of remote device with Bluetooth address
  _bdaddr_.
* **info**_ &lt;bdaddr&gt;_  
  Print device name, version and supported features of remote device with
  Bluetooth address
  _bdaddr_.
* **spinq**  
  Start periodic inquiry process. No inquiry results are printed.
* **epinq**  
  Exit periodic inquiry process.
* **cmd**_ &lt;ogf&gt; &lt;ocf&gt; [parameters]_  
  Submit an arbitrary HCI command to local device.
  _ogf_,
  _ocf_
  and
  _parameters_
  are hexadecimal bytes.
* **con**  
  Display active baseband connections
* **cc**_ [--role=m|s] [--pkt-type=&lt;ptype&gt;] &lt;bdaddr&gt;_  
  Create baseband connection to remote device with Bluetooth address
  _bdaddr_.
  Option
  .I
  --pkt-type
  specifies a list of allowed packet types.
  .I
  &lt;ptype&gt;
  is a comma-separated list of packet types, where the possible packet types are
  **DM1**,
  **DM3**,
  **DM5**,
  **DH1**,
  **DH3**,
  **DH5**,
  **HV1**,
  **HV2**,
  **HV3**.
  Default is to allow all packet types. Option
  .I
  --role
  can have value
  .I
  m
  (do not allow role switch, stay master) or
  .I
  s
  (allow role switch, become slave if the peer asks to become master). Default is
  _m_.
* **dc**_ &lt;bdaddr&gt; [reason]_  
  Delete baseband connection from remote device with Bluetooth address
  _bdaddr_.
  The reason can be one of the Bluetooth HCI error codes. Default is
  _19_
  for user ended connections. The value must be given in decimal.
* **sr**_ &lt;bdaddr&gt; &lt;role&gt;_  
  Switch role for the baseband connection from the remote device to
  **master**
  or
  **slave**.
* **cpt**_ &lt;bdaddr&gt; &lt;packet types&gt;_  
  Change packet types for baseband connection to device with Bluetooth address
  _bdaddr_.
  .I
  packet types
  is a comma-separated list of packet types, where the possible packet types are
  **DM1**,
  **DM3**,
  **DM5**,
  **DH1**,
  **DH3**,
  **DH5**,
  **HV1**,
  **HV2**,
  **HV3**.
* **rssi**_ &lt;bdaddr&gt;_  
  Display received signal strength information for the connection to the device
  with Bluetooth address
  _bdaddr_.
* **lq**_ &lt;bdaddr&gt;_  
  Display link quality for the connection to the device with Bluetooth address
  _bdaddr_.
* **tpl**_ &lt;bdaddr&gt; [type]_  
  Display transmit power level for the connection to the device with Bluetooth address
  _bdaddr_.
  The type can be
  **0**
  for the current transmit power level (which is default) or
  **1**
  for the maximum transmit power level.
* **afh**_ &lt;bdaddr&gt;_  
  Display AFH channel map for the connection to the device with Bluetooth address
  _bdaddr_.
* **lp**_ &lt;bdaddr&gt; [value]_  
  With no
  _value_,
  displays link policy settings for the connection to the device with Bluetooth address
  _bdaddr_.
  If
  _value_
  is given, sets the link policy settings for that connection to
  _value_.
  Possible values are RSWITCH, HOLD, SNIFF and PARK.
* **lst**_ &lt;bdaddr&gt; [value]_  
  With no
  _value_,
  displays link supervision timeout for the connection to the device with Bluetooth address
  _bdaddr_.
  If
  .I
  value
  is given, sets the link supervision timeout for that connection to
  .I
  value
  slots, or to infinite if
  .I
  value
  is 0.
* **auth**_ &lt;bdaddr&gt;_  
  Request authentication for the device with Bluetooth address
  _bdaddr_.
* **enc**_ &lt;bdaddr&gt; [encrypt enable]_  
  Enable or disable the encryption for the device with Bluetooth address
  _bdaddr_.
* **key**_ &lt;bdaddr&gt;_  
  Change the connection link key for the device with Bluetooth address
  _bdaddr_.
* **clkoff**_ &lt;bdaddr&gt;_  
  Read the clock offset for the device with Bluetooth address
  _bdaddr_.
* **clock**_ [bdaddr] [which clock]_  
  Read the clock for the device with Bluetooth address
  _bdaddr_.
  The clock can be
  **0**
  for the local clock or
  **1**
  for the piconet clock (which is default).
* **lescan**_ [--privacy] [--passive] [--whitelist] [--discovery=g|l] [--duplicates]_  
  Start LE scan
* **leinfo**_ [--static] [--random] &lt;bdaddr&gt;_  
  Get LE remote information
* **lewladd**_ [--random] &lt;bdaddr&gt;_  
  Add device to LE White List
* **lewlrm**_ &lt;bdaddr&gt;_  
  Remove device from LE White List
* **lewlsz**  
  Read size of LE White List
* **lewlclr**  
  Clear LE White List
* **lerladd**_ [--local irk] [--peer irk] [--random] &lt;bdaddr&gt;_  
  Add device to LE Resolving List
* **lerlrm**_ &lt;bdaddr&gt;_  
  Remove device from LE Resolving List
* **lerlclr**  
  Clear LE Resolving List
* **lerlsz**  
  Read size of LE Resolving List
* **lerlon**  
  Enable LE Address Resolution
* **lerloff**  
  Disable LE Address Resolution
* **lecc**_ [--static] [--random] &lt;bdaddr&gt; | [--whitelist]_  
  Create a LE Connection
* **ledc**_ &lt;handle&gt; [reason]_  
  Disconnect a LE Connection
* **lecup**_ &lt;handle&gt; &lt;min&gt; &lt;max&gt; &lt;latency&gt; &lt;timeout&gt;_  
  LE Connection Update

<a name="authors"></a>

# Authors

Written by Maxim Krasnyansky &lt;[maxk@qualcomm.com](mailto:maxk@qualcomm.com)&gt; and Marcel Holtmann &lt;marcel@holtmann.org&gt;

man page by Fabrizio Gennari &lt;[fabrizio.gennari@philips.com](mailto:fabrizio.gennari@philips.com)&gt;
