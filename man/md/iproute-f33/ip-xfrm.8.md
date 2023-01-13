# ip\-xfrm(8) - transform configuration

iproute2, 20 Dec 2011

```

 .in +8 .ti -8 ip [ OPTIONS ] xfrm  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 "ip xfrm" XFRM-OBJECT { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 XFRM-OBJECT := state | policy | monitor 

</synopsis>

<synopsis>
.ti -8 ip xfrm state { add | update }  ID [ ALGO-LIST ] [ mode MODE ] [ mark MARK [ mask MASK ] ] [ reqid REQID ] [ seq SEQ ] [ replay-window SIZE ] [ replay-seq SEQ ] [ replay-oseq SEQ ] [ replay-seq-hi SEQ ] [ replay-oseq-hi SEQ ] [ flag FLAG-LIST ] [ sel SELECTOR ] [ LIMIT-LIST ] [ encap ENCAP ] [ coa ADDR[/PLEN] ] [ ctx CTX ] [ extra-flag EXTRA-FLAG-LIST ] [ output-mark OUTPUT-MARK ] [ if_id IF-ID ]
</synopsis>

<synopsis>
.ti -8 "ip xfrm state allocspi" ID [ mode MODE ] [ mark MARK [ mask MASK ] ] [ reqid REQID ] [ seq SEQ ] [ min SPI max SPI ]
</synopsis>

<synopsis>
.ti -8 ip xfrm state { delete | get }  ID [ mark MARK [ mask MASK ] ]
</synopsis>

<synopsis>
.ti -8 ip [ -4 | -6 ] xfrm state deleteall [ ID ] [ mode MODE ] [ reqid REQID ] [ flag FLAG-LIST ]
</synopsis>

<synopsis>
.ti -8 ip [ -4 | -6 ] xfrm state list [ ID ] [ nokeys ] [ mode MODE ] [ reqid REQID ] [ flag FLAG-LIST ]
</synopsis>

<synopsis>
.ti -8 ip xfrm state flush [ proto XFRM-PROTO ]
</synopsis>

<synopsis>
.ti -8 ip xfrm state count
</synopsis>

<synopsis>
.ti -8 ID := [ src ADDR ] [ dst ADDR ] [ proto XFRM-PROTO ] [ spi SPI ]
</synopsis>

<synopsis>
.ti -8 XFRM-PROTO := esp | ah | comp | route2 | hao
</synopsis>

<synopsis>
.ti -8 ALGO-LIST := [ ALGO-LIST ] ALGO
</synopsis>

<synopsis>
.ti -8 ALGO := { enc | auth }  ALGO-NAME ALGO-KEYMAT |
auth-trunc ALGO-NAME ALGO-KEYMAT ALGO-TRUNC-LEN |
aead ALGO-NAME ALGO-KEYMAT ALGO-ICV-LEN |
comp ALGO-NAME
</synopsis>

<synopsis>
.ti -8 MODE :=  transport | tunnel | beet | ro | in_trigger
</synopsis>

<synopsis>
.ti -8 FLAG-LIST := [ FLAG-LIST ] FLAG
</synopsis>

<synopsis>
.ti -8 FLAG := noecn | decap-dscp | nopmtudisc | wildrecv | icmp |  af-unspec | align4 | esn
</synopsis>

<synopsis>
.ti -8 SELECTOR := [ src ADDR[/PLEN] ] [ dst ADDR[/PLEN] ] [ dev DEV ]
[ UPSPEC ]
</synopsis>

<synopsis>
.ti -8 UPSPEC :=  proto { PROTO |
{ tcp | udp | sctp | dccp } [ sport PORT ] [ dport PORT ] |
{ icmp | ipv6-icmp | mobility-header } [ type NUMBER ] [ code NUMBER ] |
gre [ key { DOTTED-QUAD | NUMBER } ] }
</synopsis>

<synopsis>
.ti -8 LIMIT-LIST := [ LIMIT-LIST ] limit LIMIT
</synopsis>

<synopsis>
.ti -8 LIMIT := { time-soft | time-hard | time-use-soft | time-use-hard } SECONDS |
{ byte-soft | byte-hard } SIZE |
{ packet-soft | packet-hard } COUNT
</synopsis>

<synopsis>
.ti -8 ENCAP := { espinudp | espinudp-nonike | espintcp } SPORT DPORT OADDR
</synopsis>

<synopsis>
.ti -8 EXTRA-FLAG-LIST := [ EXTRA-FLAG-LIST ] EXTRA-FLAG
</synopsis>

<synopsis>
.ti -8 EXTRA-FLAG :=  dont-encap-dscp
</synopsis>

<synopsis>
.ti -8 ip xfrm policy { add | update } SELECTOR dir DIR [ ctx CTX ] [ mark MARK [ mask MASK ] ] [ index INDEX ] [ ptype PTYPE ] [ action ACTION ] [ priority PRIORITY ] [ flag FLAG-LIST ] [ if_id IF-ID ] [ LIMIT-LIST ] [ TMPL-LIST ]
</synopsis>

<synopsis>
.ti -8 ip xfrm policy { delete | get } { SELECTOR |  index INDEX } dir DIR [ ctx CTX ] [ mark MARK [ mask MASK ] ] [ ptype PTYPE ] [ if_id IF-ID ]
</synopsis>

<synopsis>
.ti -8 ip [ -4 | -6 ] xfrm policy { deleteall | list } [ nosock ] [ SELECTOR ] [ dir DIR ] [ index INDEX ] [ ptype PTYPE ] [ action ACTION ] [ priority PRIORITY ] [ flag FLAG-LIST]
</synopsis>

<synopsis>
.ti -8 "ip xfrm policy flush" [ ptype PTYPE ]
</synopsis>

<synopsis>
.ti -8 "ip xfrm policy count"
</synopsis>

<synopsis>
.ti -8 "ip xfrm policy set" [ hthresh4 LBITS RBITS ] [ hthresh6 LBITS RBITS ]
</synopsis>

<synopsis>
.ti -8 SELECTOR := [ src ADDR[/PLEN] ] [ dst ADDR[/PLEN] ] [ dev DEV ] [ UPSPEC ]
</synopsis>

<synopsis>
.ti -8 UPSPEC :=  proto { PROTO |
{ tcp | udp | sctp | dccp } [ sport PORT ] [ dport PORT ] |
{ icmp | ipv6-icmp | mobility-header } [ type NUMBER ] [ code NUMBER ] |
gre [ key { DOTTED-QUAD | NUMBER } ] }
</synopsis>

<synopsis>
.ti -8 DIR :=  in | out | fwd
</synopsis>

<synopsis>
.ti -8 PTYPE :=  main | sub
</synopsis>

<synopsis>
.ti -8 ACTION :=  allow | block
</synopsis>

<synopsis>
.ti -8 FLAG-LIST := [ FLAG-LIST ] FLAG
</synopsis>

<synopsis>
.ti -8 FLAG := localok | icmp
</synopsis>

<synopsis>
.ti -8 LIMIT-LIST := [ LIMIT-LIST ] limit LIMIT
</synopsis>

<synopsis>
.ti -8 LIMIT := { time-soft | time-hard | time-use-soft | time-use-hard } SECONDS |
{ byte-soft | byte-hard } SIZE |
{ packet-soft | packet-hard } COUNT
</synopsis>

<synopsis>
.ti -8 TMPL-LIST := [ TMPL-LIST ] tmpl TMPL
</synopsis>

<synopsis>
.ti -8 TMPL := ID [ mode MODE ] [ reqid REQID ] [ level LEVEL ]
</synopsis>

<synopsis>
.ti -8 ID := [ src ADDR ] [ dst ADDR ] [ proto XFRM-PROTO ] [ spi SPI ]
</synopsis>

<synopsis>
.ti -8 XFRM-PROTO := esp | ah | comp | route2 | hao
</synopsis>

<synopsis>
.ti -8 MODE :=  transport | tunnel | beet | ro | in_trigger
</synopsis>

<synopsis>
.ti -8 LEVEL := required | use
</synopsis>

<synopsis>
.ti -8 ip xfrm monitor [ all-nsid ] [ nokeys ] [ all  | LISTofXFRM-OBJECTS ]
</synopsis>

<synopsis>
.ti -8 LISTofXFRM-OBJECTS := [ LISTofXFRM-OBJECTS ] XFRM-OBJECT
</synopsis>

<synopsis>
.ti -8 XFRM-OBJECT :=  acquire | expire | SA | policy | aevent | report
</synopsis>

<synopsis>
.in -8
```


<a name="description"></a>

# Description


xfrm is an IP framework for transforming packets (such as encrypting
their payloads). This framework is used to implement the IPsec protocol
suite (with the
**state**
object operating on the Security Association Database, and the
**policy**
object operating on the Security Policy Database). It is also used for
the IP Payload Compression Protocol and features of Mobile IPv6.

.TS
l l.
ip xfrm state add	add new state into xfrm
ip xfrm state update	update existing state in xfrm
ip xfrm state allocspi	allocate an SPI value
ip xfrm state delete	delete existing state in xfrm
ip xfrm state get	get existing state in xfrm
ip xfrm state deleteall	delete all existing state in xfrm
ip xfrm state list	print out the list of existing state in xfrm
ip xfrm state flush	flush all state in xfrm
ip xfrm state count	count all existing state in xfrm
.TE


* _ID_  
  is specified by a source address, destination address,
  transform protocol _XFRM-PROTO_,
  and/or Security Parameter Index
  _SPI_.
  (For IP Payload Compression, the Compression Parameter Index or CPI is used for
  _SPI_.)
  
* _XFRM-PROTO_  
  specifies a transform protocol:
  IPsec Encapsulating Security Payload (**esp**),
  IPsec Authentication Header (**ah**),
  IP Payload Compression (**comp**),
  Mobile IPv6 Type 2 Routing Header (**route2**), or
  Mobile IPv6 Home Address Option (**hao**).
  
* _ALGO-LIST_  
  contains one or more algorithms to use. Each algorithm
  _ALGO_
  is specified by:
    * \[bu]  
      the algorithm type:
      encryption (**enc**),
      authentication (**auth** or **auth-trunc**),
      authenticated encryption with associated data (**aead**), or
      compression (**comp**)
    * \[bu]  
      the algorithm name
      _ALGO-NAME_
      (see below)
    * \[bu]  
      (for all except **comp**)
      the keying material
      _ALGO-KEYMAT_,
      which may include both a key and a salt or nonce value; refer to the
      corresponding RFC
    * \[bu]  
      (for **auth-trunc** only)
      the truncation length
      _ALGO-TRUNC-LEN_
      in bits
    * \[bu]  
      (for **aead** only)
      the Integrity Check Value length
      _ALGO-ICV-LEN_
      in bits
  
  .nh
      Encryption algorithms include
      **ecb(cipher_null)**, **cbc(des)**, **cbc(des3_ede)**, **cbc(cast5)**,
      **cbc(blowfish)**, **cbc(aes)**, **cbc(serpent)**, **cbc(camellia)**,
      **cbc(twofish)**, and **rfc3686(ctr(aes))**.
      
      Authentication algorithms include
      **digest_null**, **hmac(md5)**, **hmac(sha1)**, **hmac(sha256)**,
      **hmac(sha384)**, **hmac(sha512)**, **hmac(rmd160)**, and **xcbc(aes)**.
      
      Authenticated encryption with associated data (AEAD) algorithms include
      **rfc4106(gcm(aes))**, **rfc4309(ccm(aes))**, and **rfc4543(gcm(aes))**.
      
      Compression algorithms include
      **deflate**, **lzs**, and **lzjh**.
  
* _MODE_  
  specifies a mode of operation for the transform protocol. IPsec and IP Payload
  Compression modes are
  **transport**, **tunnel**,
  and (for IPsec ESP only) Bound End-to-End Tunnel
  (**beet**).
  Mobile IPv6 modes are route optimization
  (**ro**)
  and inbound trigger
  (**in_trigger**).
  
* _FLAG-LIST_  
  contains one or more of the following optional flags:
  **noecn**, **decap-dscp**, **nopmtudisc**, **wildrecv**, **icmp**, 
  **af-unspec**, **align4**, or **esn**.
  
* _SELECTOR_  
  selects the traffic that will be controlled by the policy, based on the source
  address, the destination address, the network device, and/or
  _UPSPEC_.
  
* _UPSPEC_  
  selects traffic by protocol. For the
  **tcp**, **udp**, **sctp**, or **dccp**
  protocols, the source and destination port can optionally be specified.
  For the
  **icmp**, **ipv6-icmp**, or **mobility-header**
  protocols, the type and code numbers can optionally be specified.
  For the
  **gre**
  protocol, the key can optionally be specified as a dotted-quad or number.
  Other protocols can be selected by name or number
  _PROTO_.
  
* _LIMIT-LIST_  
  sets limits in seconds, bytes, or numbers of packets.
  
* _ENCAP_  
  encapsulates packets with protocol
  **espinudp**, **espinudp-nonike**, or **espintcp**,
  using source port _SPORT_, destination port _DPORT_
  , and original address _OADDR_.
  
* _MARK_  
  used to match xfrm policies and states
  
* _OUTPUT-MARK_  
  used to set the output mark to influence the routing
  of the packets emitted by the state
  
* _IF-ID_  
  xfrm interface identifier used to in both xfrm policies and states
  


.TS
l l.
ip xfrm policy add	add a new policy
ip xfrm policy update	update an existing policy
ip xfrm policy delete	delete an existing policy
ip xfrm policy get	get an existing policy
ip xfrm policy deleteall	delete all existing xfrm policies
ip xfrm policy list	print out the list of xfrm policies
ip xfrm policy flush	flush policies
.TE


* **nosock**  
  filter (remove) all socket policies from the output.
  
* _SELECTOR_  
  selects the traffic that will be controlled by the policy, based on the source
  address, the destination address, the network device, and/or
  _UPSPEC_.
  
* _UPSPEC_  
  selects traffic by protocol. For the
  **tcp**, **udp**, **sctp**, or **dccp**
  protocols, the source and destination port can optionally be specified.
  For the
  **icmp**, **ipv6-icmp**, or **mobility-header**
  protocols, the type and code numbers can optionally be specified.
  For the
  **gre**
  protocol, the key can optionally be specified as a dotted-quad or number.
  Other protocols can be selected by name or number
  _PROTO_.
  
* _DIR_  
  selects the policy direction as
  **in**, **out**, or **fwd**.
  
* _CTX_  
  sets the security context.
  
* _PTYPE_  
  can be
  **main** (default) or **sub**.
  
* _ACTION_  
  can be
  **allow** (default) or **block**.
  
* _PRIORITY_  
  is a number that defaults to zero.
  
* _FLAG-LIST_  
  contains one or both of the following optional flags:
  **local** or **icmp**.
  
* _LIMIT-LIST_  
  sets limits in seconds, bytes, or numbers of packets.
  
* _TMPL-LIST_  
  is a template list specified using
  _ID_, _MODE_, _REQID_, and/or _LEVEL_. 
  
* _ID_  
  is specified by a source address, destination address,
  transform protocol _XFRM-PROTO_,
  and/or Security Parameter Index
  _SPI_.
  (For IP Payload Compression, the Compression Parameter Index or CPI is used for
  _SPI_.)
  
* _XFRM-PROTO_  
  specifies a transform protocol:
  IPsec Encapsulating Security Payload (**esp**),
  IPsec Authentication Header (**ah**),
  IP Payload Compression (**comp**),
  Mobile IPv6 Type 2 Routing Header (**route2**), or
  Mobile IPv6 Home Address Option (**hao**).
  
* _MODE_  
  specifies a mode of operation for the transform protocol. IPsec and IP Payload
  Compression modes are
  **transport**, **tunnel**,
  and (for IPsec ESP only) Bound End-to-End Tunnel
  (**beet**).
  Mobile IPv6 modes are route optimization
  (**ro**)
  and inbound trigger
  (**in_trigger**).
  
* _LEVEL_  
  can be
  **required** (default) or **use**.
  


.TS
l l.
ip xfrm policy count	count existing policies
.TE


Use one or more -s options to display more details, including policy hash table
information.



.TS
l l.
ip xfrm policy set	configure the policy hash table
.TE


Security policies whose address prefix lengths are greater than or equal
policy hash table thresholds are hashed. Others are stored in the
policy_inexact chained list.


* _LBITS_  
  specifies the minimum local address prefix length of policies that are
  stored in the Security Policy Database hash table.
  
* _RBITS_  
  specifies the minimum remote address prefix length of policies that are
  stored in the Security Policy Database hash table.
  


.TS
l l.
ip xfrm monitor 	state monitoring for xfrm objects
.TE


The xfrm objects to monitor can be optionally specified.


If the
**all-nsid**
option is set, the program listens to all network namespaces that have a
nsid assigned into the network namespace were the program is running.
A prefix is displayed to show the network namespace where the message
originates. Example:

.in +2
[nsid 1]Flushed state proto 0
.in -2



<a name="author"></a>

# Author

Manpage revised by David Ward &lt;[david.ward@ll.mit](mailto:david.ward@ll.mit).edu&gt;  
Manpage revised by Christophe Gouault &lt;[christophe.gouault@6wind.com](mailto:christophe.gouault@6wind.com)&gt;  
Manpage revised by Nicolas Dichtel &lt;[nicolas.dichtel@6wind.com](mailto:nicolas.dichtel@6wind.com)&gt;
