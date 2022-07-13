# hciconfig(1) - configure Bluetooth devices

BlueZ, Nov 11 2002

```
hciconfig -h
hciconfig [\|-a\|]
hciconfig [\|-a\|] hciX [\|command [\|command parameters\|]\|]
```


<a name="description"></a>

# Description


**hciconfig**
is used to configure Bluetooth devices.
_hciX_
is the name of a Bluetooth device installed in the system. If
_hciX_
is not given,
**hciconfig**
prints name and basic information about all the Bluetooth devices installed in
the system. If
_hciX_
is given but no command is given, it prints basic information on device
_hciX_
only. Basic information is
interface type, BD address, ACL MTU, SCO MTU, flags (up, init, running, raw,
page scan enabled, inquiry scan enabled, inquiry, authentication enabled,
encryption enabled).

<a name="options"></a>

# Options


* **-h, --help**  
  Gives a list of possible commands.
* **-a, --all**  
  Other than the basic info, print features, packet type, link policy, link mode,
  name, class, version.

<a name="commands"></a>

# Commands


* **up**  
  Open and initialize HCI device.
* **down**  
  Close HCI device.
* **reset**  
  Reset HCI device.
* **rstat**  
  Reset statistic counters.
* **auth**  
  Enable authentication (sets device to security mode 3).
* **noauth**  
  Disable authentication.
* **encrypt**  
  Enable encryption (sets device to security mode 3).
* **noencrypt**  
  Disable encryption.
* **secmgr**  
  Enable security manager (current kernel support is limited).
* **nosecmgr**  
  Disable security manager.
* **piscan**  
  Enable page and inquiry scan.
* **noscan**  
  Disable page and inquiry scan.
* **iscan**  
  Enable inquiry scan, disable page scan.
* **pscan**  
  Enable page scan, disable inquiry scan.
* **ptype** [_type_]  
  With no
  _type_
  , displays the current packet types. Otherwise, all the packet types specified
  by
  _type_
  are set.
  _type_
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
* **name**_ [name]_  
  With no
  _name_,
  prints local name. Otherwise, sets local name to
  _name_.
* **class**_ [class]_  
  With no
  _class_,
  prints class of device. Otherwise, sets class of device to
  _class_.
  .I
  class
  is a 24-bit hex number describing the class of device, as specified in section
  1.2 of the Bluetooth Assigned Numers document.
* **voice**_ [voice]_  
  With no
  _voice_,
  prints voice setting. Otherwise, sets voice setting to
  _voice_.
  _voice_
  is a 16-bit hex number describing the voice setting.
* **iac**_ [iac]_  
  With no
  _iac_,
  prints the current IAC setting. Otherwise, sets the IAC to
  _iac_.
* **inqtpl**_ [level]_  
  With no
  _level_,
  prints out the current inquiry transmit power level. Otherwise, sets
  inquiry transmit power level to
  _level_.
* **inqmode**_ [mode]_  
  With no
  _mode_,
  prints out the current inquiry mode. Otherwise, sets inquiry mode to
  _mode_.
* **inqdata**_ [data]_  
  With no
  _name_,
  prints out the current inquiry data. Otherwise, sets inquiry data to
  _data_.
* **inqtype**_ [type]_  
  With no
  _type_,
  prints out the current inquiry scan type. Otherwise, sets inquiry scan type to
  _type_.
* **inqparams** [_win_:_int_]  
  With no
  _win_:_int_,
  prints inquiry scan window and interval. Otherwise, sets inquiry scan window
  to
  _win_
  slots and inquiry scan interval to
  _int_
  slots.
* **pageparms** [_win_:_int_]  
  With no
  _win_:_int_,
  prints page scan window and interval. Otherwise, sets page scan window to
  _win_
  slots and page scan interval to
  _int_
  slots.
* **pageto**_ [to]_  
  With no
  _to_,
  prints page timeout. Otherwise, sets page timeout
  to .I
  to
  slots.
* **afhmode**_ [mode]_  
  With no
  _mode_,
  prints out the current AFH mode. Otherwise, sets AFH mode to
  _mode_.
* **sspmode**_ [mode]_  
  With no
  _mode_,
  prints out the current Simple Pairing mode. Otherwise, sets Simple Pairing mode to
  _mode_.
* **aclmtu** _mtu_:_pkt_  
  Sets ACL MTU to
  to
  _mtu_
  bytes and ACL buffer size to
  _pkt_
  packets.
* **scomtu** _mtu_:_pkt_  
  Sets SCO MTU to
  _mtu_
  bytes and SCO buffer size to
  _pkt_
  packets.
* **delkey**_ &lt;bdaddr&gt;_  
  This command deletes the stored link key for
  _bdaddr_
  from the device.
* **oobdata**  
  Get local OOB data (invalidates previously read data).
* **commands**  
  Display supported commands.
* **features**  
  Display device features.
* **version**  
  Display version information.
* **revision**  
  Display revision information.
* **lm**_ [mode]_  
  With no
  _mode_
  , prints link mode.
  **MASTER**
  or
  **SLAVE**
  mean, respectively, to ask to become master or to remain slave when a
  connection request comes in. The additional keyword
  **ACCEPT**
  means that baseband  connections will be accepted even if there are no
  listening
  _AF_BLUETOOTH_
  sockets.
  _mode_
  is
  **NONE**
  or a comma-separated list of keywords, where possible keywords are
  **MASTER**
  and
  **ACCEPT .**
  **NONE**
  sets link policy to the default behaviour of remaining slave and not accepting
  baseband connections when there are no listening
  _AF_BLUETOOTH_
  sockets. If
  **MASTER**
  is present, the device will ask to become master if a connection request comes
  in. If
  **ACCEPT**
  is present, the device will accept baseband connections even when there are no
  listening
  _AF_BLUETOOTH_
  sockets.

<a name="authors"></a>

# Authors

Written by Maxim Krasnyansky &lt;[maxk@qualcomm.com](mailto:maxk@qualcomm.com)&gt; and Marcel Holtmann &lt;marcel@holtmann.org&gt;

man page by Fabrizio Gennari &lt;[fabrizio.gennari@philips.com](mailto:fabrizio.gennari@philips.com)&gt;
