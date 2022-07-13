# l2ping(1) - Send L2CAP echo request and receive answer

BlueZ, Jan 22 2002

```
l2ping [\|-i <hciX>\|] [\|-s size\|] [\|-c count\|] [\|-t timeout\|] [\|-d delay\|] [\|-f\|] [\|-r\|] [\|-v\|] bd_addr
```


<a name="description"></a>

# Description


L2ping sends a L2CAP echo request to the Bluetooth MAC address
_bd_addr_
given in dotted hex notation.

<a name="options"></a>

# Options


* **-i**_ &lt;hciX&gt;_  
  The command is applied to device
  .BI
  hciX
  , which must be the name of an installed Bluetooth device (X = 0, 1, 2, ...)
  If not specified, the command will be sent to the first available Bluetooth
  device.
* **-s**_ size_  
  The
  _size_
  of the data packets to be sent.
* **-c**_ count_  
  Send
  _count_
  number of packets then exit.
* **-t**_ timeout_  
  Wait
  _timeout_
  seconds for the response.
* **-d**_ delay_  
  Wait
  _delay_
  seconds between pings.
* **-f**  
  Kind of flood ping. Use with care! It reduces the delay time between packets
  to 0.
* **-r**  
  Reverse ping (gnip?). Send echo response instead of echo request.
* **-v**  
  Verify response payload is identical to request payload. It is not required for
  remote stacks to return the request payload, but most stacks do (including
  Bluez).
* _bd_addr_  
  The Bluetooth MAC address to be pinged in dotted hex notation like
  **01:02:03:ab:cd:ef**
  or
  **01:EF:cd:aB:02:03**

<a name="authors"></a>

# Authors

Written by Maxim Krasnyansky &lt;[maxk@qualcomm.com](mailto:maxk@qualcomm.com)&gt; and Marcel Holtmann &lt;marcel@holtmann.org&gt;

man page by Nils Faerber &lt;[nils@kernelconcepts.de](mailto:nils@kernelconcepts.de)&gt;, Adam Laurie &lt;adam@algroup.co.uk&gt;.
