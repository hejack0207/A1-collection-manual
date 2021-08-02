# randpkt(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

randpkt - Random packet generator

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" randpkt [&nbsp;-b&nbsp;<maxbytes>&nbsp;] [&nbsp;-c&nbsp;<count>&nbsp;] [&nbsp;-t&nbsp;<type>&nbsp;] <filename>
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**randpkt** is a small utility that creates a **pcap** trace file
full of random packets.

By creating many randomized packets of a certain type, you can
test packet sniffers to see how well they handle malformed packets.
The sniffer can never trust the data that it sees in the packet because
you can always sniff a very bad packet that conforms to no standard.
**randpkt** produces _very bad_ packets.

When creating packets of a certain type, **randpkt** uses a sample
packet that is stored internally to **randpkt**. It uses this as the
starting point for your random packets, and then adds extra random
bytes to the end of this sample packet.

For example, if you choose to create random \s-1ARP\s0 packets, **randpkt**
will create a packet which contains a predetermined Ethernet \s-1II\s0 header,
with the Type field set to \s-1ARP.\s0 After the Ethernet \s-1II\s0 header, it will
put a random number of bytes with random values.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -b &lt;maxbytes&gt;  
  .IX Item "-b &lt;maxbytes&gt;"
  Default 5000.
  .Sp
  Defines the maximum number of bytes added to the sample packet.
  If you choose a **maxbytes** value that is less than the size of the
  sample packet, then your packets would contain only the sample
  packet... not much variance there! **randpkt** exits on that condition.
* -c &lt;count&gt;  
  .IX Item "-c &lt;count&gt;"
  Default 1000.
  .Sp
  Defines the number of packets to generate.
* -t &lt;type&gt;  
  .IX Item "-t &lt;type&gt;"
  Default Ethernet \s-1II\s0 frame.
  .Sp
  Defines the type of packet to generate:
  .Sp
  .Vb 10
          arp             Address Resolution Protocol
          bgp             Border Gateway Protocol
          bvlc            BACnet Virtual Link Control
          dns             Domain Name Service
          eth             Ethernet
          fddi            Fiber Distributed Data Interface
          giop            General Inter-ORB Protocol
          icmp            Internet Control Message Protocol
          ip              Internet Protocol
          ipv6            Internet Protocol Version 6
          llc             Logical Link Control
          m2m             WiMAX M2M Encapsulation Protocol
          megaco          MEGACO
          nbns            NetBIOS-over-TCP Name Service
          ncp2222         NetWare Core Protocol
          sctp            Stream Control Transmission Protocol
          syslog          Syslog message
          tds             TDS NetLib
          tcp             Transmission Control Protocol
          tr              Token-Ring
          udp             User Datagram Protocol
          usb             Universal Serial Bus
          usb-linux       Universal Serial Bus with Linux specific header
  .Ve

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see a description of the randpkt options use:

.Vb 1
    randpkt
.Ve

To generate a capture file with 1000 \s-1DNS\s0 packets use:

.Vb 1
    randpkt -b 500 -t dns rand_dns.pcap
.Ve

To generate a small capture file with just a single \s-1LLC\s0 frame use:

.Vb 1
    randpkt -b 100 -c 1 -t llc single_llc.pcap
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pcap**\|(3), **editcap**\|(1)
