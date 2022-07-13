# sdptool(1) - control and interrogate SDP servers

```

 sdptool [options]  {command}  [command parameters ...]
```

<a name="description"></a>

# Description


**sdptool** provides the interface for
performing SDP queries on Bluetooth devices, and administering a
local SDP database.

<a name="commands"></a>

# Commands


The following commands are available.  In all cases **bdaddr**
specifies the device to search or browse.  If _local_ is used
for **bdaddr**, then the local SDP database is searched.

Services are identified and manipulated with a 4-byte **record\_handle**
(NOT the service name).  To find a service's **record\_handle**, look for the
"Service RecHandle" line in the **search** or **browse** results

* **search [--bdaddr bdaddr] [--tree] [--raw] [--xml] service\_name**  
  Search for services..
* ""  
  Known service names are DID, SP, DUN, LAN, FAX, OPUSH,
  FTP, HS, HF, HFAG, SAP, NAP, GN, PANU, HCRP, HID, CIP,
  A2SRC, A2SNK, AVRCT, AVRTG, UDIUE, UDITE and SYNCML.
* **browse [--tree] [--raw] [--xml] [bdaddr]**  
  Browse all available services on the device
  specified by a Bluetooth address as a parameter.
* **records [--tree] [--raw] [--xml] bdaddr**  
  Retrieve all possible service records.
* **add [ --handle=N --channel=N ]**  
  Add a service to the local
  SDP database.
* ""  
  You can specify a handle for this record using
  the **--handle** option.
* ""  
  You can specify a channel to add the service on
  using the **--channel** option.
* ""  
  NOTE: Local adapters configuration will not be updated and this command should
  be used only for SDP testing.
* **del record\_handle**  
  Remove a service from the local
  SDP database.
* ""  
  NOTE: Local adapters configuration will not be updated and this command should
  be used only for SDP testing.
* **get [--tree] [--raw] [--xml] [--bdaddr bdaddr] record\_handle**  
  Retrieve a service from the local
  SDP database.
* **setattr record_handle attrib_id attrib\_value**  
  Set or add an attribute to an SDP record.
  
* **setseq record_handle attrib_id attrib\_values**  
  Set or add an attribute sequence to an
  SDP record.

<a name="options"></a>

# Options


* **--help**  
  Displays help on using sdptool.
  

<a name="examples"></a>

# Examples


sdptool browse 00:80:98:24:15:6D

sdptool browse local

sdptool add DUN

sdptool del 0x10000

<a name="bugs"></a>

# Bugs


Documentation needs improving.

<a name="author"></a>

# Author


Maxim Krasnyansky &lt;[maxk@qualcomm.com](mailto:maxk@qualcomm.com)&gt;. Man page written
by Edd Dumbill &lt;[ejad@debian.org](mailto:ejad@debian.org)&gt;.

