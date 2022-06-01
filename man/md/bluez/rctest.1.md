# rctest(1) - RFCOMM testing

BlueZ, Jul 6 2009

```
rctest <mode> [options] [bdaddr]
```


<a name="description"></a>

# Description


.B
rctest
is used to test RFCOMM communications on the BlueZ stack


<a name="modes"></a>

# Modes


* **-r**  
  listen and receive
* **-w**  
  listen and send
* **-d**  
  listen and dump incoming data
* **-s**  
  connect and send
* **-u**  
  connect and receive
* **-n**  
  connect and be silent
* **-c**  
  connect, disconnect, connect, ...
* **-m**  
  multiple connects
  

<a name="options"></a>

# Options


* **-b&nbsp;**_bytes_  
  send/receive _bytes_ bytes
* **-i&nbsp;**_device_  
  select the specified _device_
* **-P&nbsp;**_channel_  
  select the specified _channel_
* **-U&nbsp;**_uuid_  
  select the specified _uuid_
* **-L&nbsp;**_seconds_  
  enable SO_LINGER options for _seconds_
* **-W&nbsp;**_seconds_  
  enable deferred setup for _seconds_
* **-B&nbsp;**_filename_  
  use data packets from _filename_
* **-N&nbsp;**_num_  
  send _num_ frames
* **-C&nbsp;**_num_  
  send _num_ frames before delay (default: 1)
* **-D&nbsp;**_milliseconds_  
  delay _milliseconds_ after sending _num_ frames (default: 0)
* **-A**  
  request authentication
* **-E**  
  request encryption
* **-S**  
  secure connection
* **-M**  
  become master
* **-T**  
  enable timestamps
  

<a name="authors"></a>

# Authors

Written by Marcel Holtmann &lt;[marcel@holtmann.org](mailto:marcel@holtmann.org)&gt; and Maxim Krasnyansky
&lt;[maxk@qualcomm.com](mailto:maxk@qualcomm.com)&gt;, man page by Filippo Giunchedi &lt;filippo@debian.org&gt;

