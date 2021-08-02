# udpdump(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

udpdump - Provide an UDP receiver that gets packets from network devices (like Aruba routers) and exports them in PCAP format.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" udpdump [&nbsp;--help&nbsp;] [&nbsp;--version&nbsp;] [&nbsp;--extcap-interfaces&nbsp;] [&nbsp;--extcap-dlts&nbsp;] [&nbsp;--extcap-interface=<interface>&nbsp;] [&nbsp;--extcap-config&nbsp;] [&nbsp;--capture&nbsp;] [&nbsp;--fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe>&nbsp;] [&nbsp;--port=<port>&nbsp;] [&nbsp;--payload=<type>&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**udpdump** is a extcap tool that provides an \s-1UDP\s0 receiver that listens for exported datagrams coming from
any source (like Aruba routers) and exports them in \s-1PCAP\s0 format. This provides the user two basic
functionalities: the first one is to have a listener that prevents the localhost to send back an \s-1ICMP\s0
port-unreachable packet. The second one is to strip out the lower layers (layer 2, \s-1IP, UDP\s0) that are useless
(are used just as export vector). The format of the exported datagrams are \s-1EXPORTED_PDU,\s0 as specified in
https://gitlab.com/wireshark/wireshark/-/raw/master/epan/exported_pdu.h

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* --help  
  .IX Item "--help"
  Print program arguments.
* --version  
  .IX Item "--version"
  Print program version.
* --extcap-interfaces  
  .IX Item "--extcap-interfaces"
  List available interfaces.
* --extcap-interface=&lt;interface&gt;  
  .IX Item "--extcap-interface=&lt;interface&gt;"
  Use specified interfaces.
* --extcap-dlts  
  .IX Item "--extcap-dlts"
  List DLTs of specified interface.
* --extcap-config  
  .IX Item "--extcap-config"
  List configuration options of specified interface.
* --capture  
  .IX Item "--capture"
  Start capturing from specified interface save saved it in place specified by --fifo.
* --fifo=&lt;path to file or pipe&gt;  
  .IX Item "--fifo=&lt;path to file or pipe&gt;"
  Save captured packet to file or send it through pipe.
* --port=&lt;port&gt;  
  .IX Item "--port=&lt;port&gt;"
  Set the listener port. Port 5555 is the default.
* --payload=&lt;type&gt;  
  .IX Item "--payload=&lt;type&gt;"
  Set the payload of the exported \s-1PDU.\s0 Default: data.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see program arguments:

.Vb 1
    udpdump --help
.Ve

To see program version:

.Vb 1
    udpdump --version
.Ve

To see interfaces:

.Vb 1
    udpdump --extcap-interfaces

  Example output:
    interface {value=udpdump}{display=UDP Listener remote capture}
.Ve

To see interface DLTs:

.Vb 1
    udpdump --extcap-interface=udpdump --extcap-dlts

  Example output:
    dlt {number=252}{name=udpdump}{display=Exported PDUs}
.Ve

To see interface configuration options:

.Vb 1
    udpdump --extcap-interface=udpdump --extcap-config

  Example output:
    arg {number=0}{call=--port}{display=Listen port}{type=unsigned}{range=1,65535}{default=5555}{tooltip=The port the receiver listens on}
.Ve

To capture:

.Vb 1
    udpdump --extcap-interface=randpkt --fifo=/tmp/randpkt.pcapng --capture
.Ve

\s-1NOTE:\s0 To stop capturing CTRL+C/kill/terminate application.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **extcap**\|(4)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**udpdump** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  ---------------
  Dario Lombardo             &lt;lomato[AT]gmail.com&gt;
.Ve
