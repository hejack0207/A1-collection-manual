# tipc-bearer(8) - show or modify TIPC bearers

iproute2, 02 Jun 2015

```
.in +8
</synopsis>

<synopsis>
.ti -8 tipc bearer add media udp name NAME remoteip REMOTEIP

</synopsis>

<synopsis>
.ti -8 tipc bearer enable [ domain DOMAIN ] [ priority PRIORITY ] media
{ { eth | ib } device DEVICE } |
{ udp name NAME localip LOCALIP [ localport LOCALPORT ] [ remoteip REMOTEIP ] [ remoteport REMOTEPORT ] }

</synopsis>

<synopsis>
.ti -8 tipc bearer disable media
{ { eth | ib } device DEVICE } |
{ udp name NAME }

</synopsis>

<synopsis>
.ti -8 tipc bearer set { priority  PRIORITY | tolerance TOLERANCE | window WINDOW } media
{ { eth | ib } device DEVICE } |
{ udp name NAME }

</synopsis>

<synopsis>
.ti -8 tipc bearer get [ priority | tolerance | window ] media
{ { eth | ib } device DEVICE } |
{ udp name NAME [ localip | localport | remoteip | remoteport ] }

</synopsis>

<synopsis>
.ti -8 tipc bearer list

```


<a name="options"></a>

# Options

Options (flags) that can be passed anywhere in the command chain.

* **-h**,** --help**  
  Show help about last valid command. For example
  **tipc bearer --help**
  will show bearer help and
  **tipc --help**
  will show general help. The position of the option in the string is irrelevant.

<a name="description"></a>

# Description



<a name="bearer-identification"></a>

### Bearer identification


* **media **_MEDIA_    
  Specifies the TIPC media type for a particular bearer to operate on.
  Different media types have different ways of identifying a unique bearer.
  For example,
  **ib **and **eth**
  identify a bearer with a
  _DEVICE_
  while
  **udp**
  identify a bearer with a
  _LOCALIP _and a _NAME_
  
  **ib**
  - Infiniband

**eth**
- Ethernet

**udp**
- User Datagram Protocol (UDP)



* **name **_NAME_    
  Logical bearer identifier valid for bearers on
  **udp**
  media.
  
* **device **_DEVICE_    
  Physical bearer device valid for bearers on
  **eth**
  and
  **ib**
  media.
  

<a name="bearer-properties"></a>

### Bearer properties



* **domain**    
  The addressing domain (region) in which a bearer will establish links and accept
  link establish requests.
  
* **priority**    
  Default link priority inherited by all links subsequently established over a
  bearer. A single bearer can only host one link to a particular node. This means
  the default link priority for a bearer typically affects which bearer to use
  when communicating with a particular node in an multi bearer setup. For more
  info about link priority see
  **tipc-link**(8)
  
* **tolerance**    
  Default link tolerance inherited by all links subsequently established over a
  bearer. For more info about link tolerance see
  **tipc-link**(8)
  
* **window**    
  Default link window inherited by all links subsequently established over a
  bearer. For more info about the link window size see
  **tipc-link**(8)
  

<a name="udp-bearer-options"></a>

### UDP bearer options



* **localip **_LOCALIP_    
  Specify a local IP v4/v6 address for a
  **udp**
  bearer.
  
* **localport **_LOCALPORT_    
  Specify the local port for a
  **udp**
  bearer. The default port 6118 is used if no port is specified.
  
* **remoteip **_REMOTEIP_    
  Specify a remote IP for a
  **udp**
  bearer. If no remote IP is specified a
  **udp**
  bearer runs in multicast mode and tries to auto-discover its neighbours.
  The multicast IP address is generated based on the TIPC network ID. If a remote
  IP is specified the
  **udp**
  bearer runs in point-to-point mode.
  
  Multiple
  **remoteip**
  addresses can be added via the
  **bearer add**
  command. Adding one or more unicast
  **remoteip**
  addresses to an existing
  **udp**
  bearer puts the bearer in replicast mode where IP
  multicast is emulated by sending multiple unicast messages to each configured
  **remoteip.**
  When a peer sees a TIPC discovery message from an unknown peer the peer address
  is automatically added to the
  **remoteip**
  (replicast) list, thus only one side of
  a link needs to be manually configured. A
  **remoteip**
  address cannot be added to a multicast bearer.
  
* **remoteport **_REMOTEPORT_    
  Specify the remote port for a
  **udp**
  bearer. The default port 6118 is used if no port is specified.
  

<a name="exit-status"></a>

# Exit Status

Exit status is 0 if command was successful or a positive integer upon failure.


<a name="see-also"></a>

# See Also

**tipc**(8),
**tipc-link**(8),
**tipc-media**(8),
**tipc-nametable**(8),
**tipc-node**(8),
**tipc-peer**(8),
**tipc-socket**(8)  

<a name="reporting-bugs"></a>

# Reporting Bugs

Report any bugs to the Network Developers mailing list
**&lt;netdev@vger.kernel.org&gt;**
where the development and maintenance is primarily done.
You do not have to be subscribed to the list to send a message there.


<a name="author"></a>

# Author

Richard Alpe &lt;[richard.alpe@ericsson.com](mailto:richard.alpe@ericsson.com)&gt;
