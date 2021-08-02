# randpktdump(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

randpktdump - Provide an interface to generate random captures using randpkt

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" randpktdump [&nbsp;--help&nbsp;] [&nbsp;--version&nbsp;] [&nbsp;--extcap-interfaces&nbsp;] [&nbsp;--extcap-dlts&nbsp;] [&nbsp;--extcap-interface=<interface>&nbsp;] [&nbsp;--extcap-config&nbsp;] [&nbsp;--capture&nbsp;] [&nbsp;--fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe>&nbsp;] [&nbsp;--maxbytes=<bytes>&nbsp;] [&nbsp;--count=<num>&nbsp;] [&nbsp;--delay=<ms>&nbsp;] [&nbsp;--random-type=<true|false>&nbsp;] [&nbsp;--all-random=<true|false>&nbsp;] [&nbsp;--type=<packet&nbsp;type>&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**randpktdump** is a extcap tool that provides access to the random
packet generator (randpkt). It is mainly used for testing and
educational purpose.

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
* --maxbytes=&lt;bytes&gt;  
  .IX Item "--maxbytes=&lt;bytes&gt;"
  Set the max number of bytes per packet.
* --count=&lt;num&gt;  
  .IX Item "--count=&lt;num&gt;"
  Number of packets to generate (-1 for infinite).
* --delay=&lt;ms&gt;  
  .IX Item "--delay=&lt;ms&gt;"
  Wait a number of milliseconds after writing each packet.
* --random-type  
  .IX Item "--random-type"
  Choose a random packet type for all packets if set to true.
* --all-random  
  .IX Item "--all-random"
  Choose a different random packet type for each packet if set to true.
* --type=&lt;packet type&gt;  
  .IX Item "--type=&lt;packet type&gt;"
  Use the selected packet type. To list all the available packet type, run randpktdump --help.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see program arguments:

.Vb 1
    randpktdump --help
.Ve

To see program version:

.Vb 1
    randpktdump --version
.Ve

To see interfaces:

.Vb 1
    randpktdump --extcap-interfaces

  Example output:
    interface {value=randpkt}{display=Random packet generator}
.Ve

To see interface DLTs:

.Vb 1
    randpktdump --extcap-interface=randpkt --extcap-dlts

  Example output:
    dlt {number=1}{name=randpkt}{display=Ethernet}
.Ve

To see interface configuration options:

.Vb 1
    randpktdump --extcap-interface=randpkt --extcap-config

  Example output:
    arg {number=0}{call=--maxbytes}{display=Max bytes in a packet}{type=unsigned}{range=1,5000}{default=5000}{tooltip=The max number of bytes in a packet}
    arg {number=1}{call=--count}{display=Number of packets}{type=long}{default=1000}{tooltip=Number of packets to generate (-1 for infinite)}
    arg {number=2}{call=--delay}{display=Packet delay (ms)}{type=long}{default=0}{tooltip=Milliseconds to wait after writing each packet}
    arg {number=3}{call=--random-type}{display=Random type}{type=boolflag}{default=false}{tooltip=The packets type is randomly chosen}
    arg {number=4}{call=--all-random}{display=All random packets}{type=boolflag}{default=false}{tooltip=Packet type for each packet is randomly chosen}
    arg {number=5}{call=--type}{display=Type of packet}{type=selector}{tooltip=Type of packet to generate}
    value {arg=5}{value=arp}{display=Address Resolution Protocol}
    [...]
    value {arg=5}{value=usb-linux}{display=Universal Serial Bus with Linux specific header}
.Ve

To capture:

.Vb 1
    randpktdump --extcap-interface=randpkt --fifo=/tmp/randpkt.pcapng --capture
.Ve

\s-1NOTE:\s0 To stop capturing CTRL+C/kill/terminate application.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **extcap**\|(4), **randpkt**\|(1)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**randpktdump** is part of the **Wireshark** distribution.  The latest version
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
