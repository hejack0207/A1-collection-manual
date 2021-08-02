# ovs\-fields(7)

Open vSwitch, 2.10.1

.fp 5 L CR              



.if \n[.g] .mso www.tmac

<a name="name"></a>

# Name

ovs-fields - protocol header fields in OpenFlow and Open vSwitch



<a name="introduction"></a>

# Introduction


This document aims to comprehensively document all of the fields, both standard and non-standard, supported by OpenFlow or Open vSwitch, regardless of origin\[char46]

<a name="fields"></a>

### Fields


A _field_ is a property of a packet\[char46] Most familiarly, data
fields are fields that can be extracted from a packet\[char46] Most data fields are copied directly from protocol headers, e\[char46]g\[char46] at layer 2, the Ethernet source and destination addresses, or the VLAN ID; at layer 3, the IPv4 or IPv6 source and destination; and at layer 4, the TCP or UDP ports\[char46] Other data fields are computed, e\[char46]g\[char46] **ip\_frag** describes whether a packet is a fragment but it is not copied directly from the IP header\[char46]

Data fields that are always present as a consequence of the basic networking technology in use are called called _root fields_\[char46] Open vSwitch 2\[char46]7 and earlier considered Ethernet fields to be root fields, and this remains the default mode of operation for Open vSwitch bridges\[char46] When a packet is received from a non-Ethernet interfaces, such as a layer-3 LISP tunnel, Open vSwitch 2\[char46]7 and earlier force-fit the packet to this Ethernet-centric point of view by pretending that an Ethernet header is present whose Ethernet type that indicates the packet’s actual type (and whose source and destination addresses are all-zero)\[char46]

Open vSwitch 2\[char46]8 and later implement the \`\`packet type-aware pipeline’’ concept introduced in OpenFlow 1\[char46]5\[char46] Such a pipeline does not have any root fields\[char46] Instead, a new metadata field, **packet\_type**, indicates the basic type of the packet, which can be Ethernet, IPv4, IPv6, or another type\[char46] For backward compatibility, by default Open vSwitch 2\[char46]8 imitates the behavior of Open vSwitch 2\[char46]7 and earlier\[char46] Later versions of Open vSwitch may change the default, and in the meantime controllers can turn off this legacy behavior, on a port-by-port basis, by setting **options:packet\_type** to **ptap** in the **Interface** table\[char46] This is significant only for ports that can handle non-Ethernet packets, which is currently just LISP, VXLAN-GPE, and GRE tunnel ports\[char46] See **ovs-vwitchd\[char46]conf\[char46]db**(5) for more information\[char46]

Non-root data fields are not always present\[char46] A packet contains ARP fields, for example, only when its packet type is ARP or when it is an Ethernet packet whose Ethernet header indicates the Ethertype for ARP, 0x0806\[char46] In this documentation, we say that a field is _applicable_ when it is present in a packet, and _inapplicable_ when it is not\[char46] (These are not standard terms\[char46]) We refer to the conditions that determine whether a field is applicable as _prerequisites_\[char46] Some VLAN-related fields are a special case: these fields are always applicable for Ethernet packets, but have a designated value or bit that indicates whether a VLAN header is present, with the remaining values or bits indicating the VLAN header’s content (if it is present)\[char46]

An inapplicable field does not have a value, not even a nominal \`\`value’’ such as all-zero-bits\[char46] In many circumstances, OpenFlow and Open vSwitch allow references only to applicable fields\[char46] For example, one may match (see _Matching_, below) a given field only if the match includes the field’s prerequisite, e\[char46]g\[char46] matching an ARP field is only allowed if one also matches on Ethertype 0x0806 or the **packet\_type** for ARP in a packet type-aware bridge\[char46]

Sometimes a packet may contain multiple instances of a header\[char46] For example, a packet may contain multiple VLAN or MPLS headers, and tunnels can cause any data field to recur\[char46] OpenFlow and Open vSwitch do not address these cases uniformly\[char46] For VLAN and MPLS headers, only the outermost header is accessible, so that inner headers may be accessed only by \`\`popping’’ (removing) the outer header\[char46] (Open vSwitch supports only a single VLAN header in any case\[char46]) For tunnels, e\[char46]g\[char46] GRE or VXLAN, the outer header and inner headers are treated as different data fields\[char46]

Many network protocols are built in layers as a stack of concatenated headers\[char46] Each header typically contains a \`\`next type’’ field that indicates the type of the protocol header that follows, e\[char46]g\[char46] Ethernet contains an Ethertype and IPv4 contains a IP protocol type\[char46] The exceptional cases, where protocols are layered but an outer layer does not indicate the protocol type for the inner layer, or gives only an ambiguous indication, are troublesome\[char46] An MPLS header, for example, only indicates whether another MPLS header or some other protocol follows, and in the latter case the inner protocol must be known from the context\[char46] In these exceptional cases, OpenFlow and Open vSwitch cannot provide insight into the inner protocol data fields without additional context, and thus they treat all later data fields as inapplicable until an OpenFlow action explicitly specifies what protocol follows\[char46] In the case of MPLS, the OpenFlow \`\`pop MPLS’’ action that removes the last MPLS header from a packet provides this context, as the Ethertype of the payload\[char46] See _Layer 2\[char46]5: MPLS_ for more information\[char46]

OpenFlow and Open vSwitch support some fields other than data fields\[char46] _Metadata fields_ relate to the origin or treatment of a packet, but they are not extracted from the packet data itself\[char46] One example is the physical port on which a packet arrived at the switch\[char46] _Register fields_ act like variables: they give an OpenFlow switch space for temporary storage while processing a packet\[char46] Existing metadata and register fields have no prerequisites\[char46]

A field’s value consists of an integral number of bytes\[char46] For data fields, sometimes those bytes are taken directly from the packet\[char46] Other data fields are copied from a packet with padding (usually with zeros and in the most significant positions)\[char46] The remaining data fields are transformed in other ways as they are copied from the packets, to make them more useful for matching\[char46]

<a name="matching"></a>

### Matching


The most important use of fields in OpenFlow is _matching_, to determine whether particular field values agree with a set of constraints called a _match_\[char46] A match consists of zero or more constraints on individual fields, all of which must be met to satisfy the match\[char46] (A match that contains no constraints is always satisfied\[char46]) OpenFlow and Open vSwitch support a number of forms of matching on individual fields:

* _Exact match_, e\[char46]g\[char46] **nw\_src=10\[char46]1\[char46]2\[char46]3**  
  Only a particular value of the field is matched; for example, only one particular source IP address\[char46] Exact matches are written as **_field=value**\[char46] The forms accepted for value_ depend on the field\[char46]
* All fields support exact matches\[char46]
* _Bitwise match_, e\[char46]g\[char46] **nw\_src=10\[char46]1\[char46]0\[char46]0/255\[char46]255\[char46]0\[char46]0**  
  Specific bits in the field must have specified values; for example, only source IP addresses in a particular subnet\[char46] Bitwise matches are written as **_field=value/mask**, where value_ and _mask_ take one of the forms accepted for an exact match on _field_\[char46] Some fields accept other forms for bitwise matches; for example, **nw\_src=10\[char46]1\[char46]0\[char46]0/255\[char46]255\[char46]0\[char46]0** may also be written **nw\_src=10\[char46]1\[char46]0\[char46]0/16**\[char46]
* Most OpenFlow switches do not allow every bitwise matching on every field (and before OpenFlow 1\[char46]2, the protocol did not even provide for the possibility for most fields)\[char46] Even switches that do allow bitwise matching on a given field may restrict the masks that are allowed, e\[char46]g\[char46] by allowing matches only on contiguous sets of bits starting from the most significant bit, that is, \`\`CIDR’’ masks [RFC 4632]\[char46] Open vSwitch does not allows bitwise matching on every field, but it allows arbitrary bitwise masks on any field that does support bitwise matching\[char46] (Older versions had some restrictions, as documented in the descriptions of individual fields\[char46])
* _Wildcard_, e\[char46]g\[char46] \`\`any **nw\_src**’’  
  The value of the field is not constrained\[char46] Wildcarded fields may be written as **field=***, although it is unusual to mention them at all\[char46] (When specifying a wildcard explicitly in a command invocation, be sure to using quoting to protect against shell expansion\[char46])
* There is a tiny difference between wildcarding a field and not specifying any match on a field: wildcarding a field requires satisfying the field’s prerequisites\[char46]

Some types of matches on individual fields cannot be expressed directly with OpenFlow and Open vSwitch\[char46] These can be expressed indirectly:

* _Set match_, e\[char46]g\[char46] \`\`**tcp\_dst** \[mo] {80, 443, 8080}’’  
  The value of a field is one of a specified set of values; for example, the TCP destination port is 80, 443, or 8080\[char46]
* For matches used in flows (see _Flows_, below), multiple flows can simulate set matches\[char46]
* _Range match_, e\[char46]g\[char46] \`\`1000 \[&lt;=] **tcp\_dst** \[&lt;=] 1999’’  
  The value of the field must lie within a numerical range, for example, TCP destination ports between 1000 and 1999\[char46]
* Range matches can be expressed as a collection of bitwise matches\[char46] For example, suppose that the goal is to match TCP source ports 1000 to 1999, inclusive\[char46] The binary representations of 1000 and 1999 are:
*     fL  
    fL01111101000  
    fL11111001111  
    fL      
* The following series of bitwise matches will match 1000 and 1999 and all the values in between:
*     fL  
    fL01111101xxx  
    fL0111111xxxx  
    fL10xxxxxxxxx  
    fL110xxxxxxxx  
    fL1110xxxxxxx  
    fL11110xxxxxx  
    fL1111100xxxx  
    fL      
* which can be written as the following matches:
*       
    tcp,tp_src=0x03e8/0xfff8  
    tcp,tp_src=0x03f0/0xfff0  
    tcp,tp_src=0x0400/0xfe00  
    tcp,tp_src=0x0600/0xff00  
    tcp,tp_src=0x0700/0xff80  
    tcp,tp_src=0x0780/0xffc0  
    tcp,tp_src=0x07c0/0xfff0  
          
* _Inequality match_, e\[char46]g\[char46] \`\`**tcp\_dst** \[!=] 80’’  
  The value of the field differs from a specified value, for example, all TCP destination ports except 80\[char46]
* An inequality match on an _n_-bit field can be expressed as a disjunction of _n_ 1-bit matches\[char46] For example, the inequality match \`\`**vlan\_pcp** \[!=] 5’’ can be expressed as \`\`**vlan\_pcp** = 0/4 or **vlan\_pcp** = 2/2 or **vlan\_pcp** = 0/1\[char46]’’ For matches used in flows (see _Flows_, below), sometimes one can more compactly express inequality as a higher-priority flow that matches the exceptional case paired with a lower-priority flow that matches the general case\[char46]
* Alternatively, an inequality match may be converted to a pair of range matches, e\[char46]g\[char46] **tcp_src \[!=] 80** may be expressed as \`\`0 \[&lt;=] **tcp\_src** &lt; 80 or 80 &lt; **tcp\_src** \[&lt;=] 65535’’, and then each range match may in turn be converted to a bitwise match\[char46]
* _Conjunctive match_, e\[char46]g\[char46] \`\`**tcp\_src** \[mo] {80, 443, 8080} and **tcp\_dst** \[mo] {80, 443, 8080}’’  
  As an OpenFlow extension, Open vSwitch supports matching on conditions on conjunctions of the previously mentioned forms of matching\[char46] See the documentation for **conj\_id** for more information\[char46]

All of these supported forms of matching are special cases of bitwise matching\[char46] In some cases this influences the design of field values\[char46] **ip\_frag** is the most prominent example: it is designed to make all of the practically useful checks for IP fragmentation possible as a single bitwise match\[char46]
.ST "Shorthands"

Some matches are very commonly used, so Open vSwitch accepts shorthand notations\[char46] In some cases, Open vSwitch also uses shorthand notations when it displays matches\[char46] The following shorthands are defined, with their long forms shown on the right side:

* **eth**  
  **packet\_type=(0,0)** (Open vSwitch 2\[char46]8 and later)
* **ip**  
  **eth\_type=0x0800**
* **ipv6**  
  **eth\_type=0x86dd**
* **icmp**  
  **eth\_type=0x0800,ip\_proto=1**
* **icmp6**  
  **eth\_type=0x86dd,ip\_proto=58**
* **tcp**  
  **eth\_type=0x0800,ip\_proto=6**
* **tcp6**  
  **eth\_type=0x86dd,ip\_proto=6**
* **udp**  
  **eth\_type=0x0800,ip\_proto=17**
* **udp6**  
  **eth\_type=0x86dd,ip\_proto=17**
* **sctp**  
  **eth\_type=0x0800,ip\_proto=132**
* **sctp6**  
  **eth\_type=0x86dd,ip\_proto=132**
* **arp**  
  **eth\_type=0x0806**
* **rarp**  
  **eth\_type=0x8035**
* **mpls**  
  **eth\_type=0x8847**
* **mplsm**  
  **eth\_type=0x8848**

<a name="evolution-of-openflow-fields"></a>

### Evolution of OpenFlow Fields


The discussion so far applies to all OpenFlow and Open vSwitch versions\[char46] This section starts to draw in specific information by explaining, in broad terms, the treatment of fields and matches in each OpenFlow version\[char46]
.ST "OpenFlow 1\[char46]0"

OpenFlow 1\[char46]0 defined the OpenFlow protocol format of a match as a fixed-length data structure that could match on the following fields:

* ·  
  Ingress port\[char46]
* ·  
  Ethernet source and destination MAC\[char46]
* ·  
  Ethertype (with a special value to match frames that lack an Ethertype)\[char46]
* ·  
  VLAN ID and priority\[char46]
* ·  
  IPv4 source, destination, protocol, and DSCP\[char46]
* ·  
  TCP source and destination port\[char46]
* ·  
  UDP source and destination port\[char46]
* ·  
  ICMPv4 type and code\[char46]
* ·  
  ARP IPv4 addresses (SPA and TPA) and opcode\[char46]

Each supported field corresponded to some member of the data structure\[char46] Some members represented multiple fields, in the case of the TCP, UDP, ICMPv4, and ARP fields whose presence is mutually exclusive\[char46] This also meant that some members were poor fits for their fields: only the low 8 bits of the 16-bit ARP opcode could be represented, and the ICMPv4 type and code were padded with 8 bits of zeros to fit in the 16-bit members primarily meant for TCP and UDP ports\[char46] An additional bitmap member indicated, for each member, whether its field should be an \`\`exact’’ or \`\`wildcarded’’ match (see _Matching_), with additional support for CIDR prefix matching on the IPv4 source and destination fields\[char46]

Simplicity was recognized early on as the main virtue of this approach\[char46] Obviously, any fixed-length data structure cannot support matching new protocols that do not fit\[char46] There was no room, for example, for matching IPv6 fields, which was not a priority at the time\[char46] Lack of room to support matching the Ethernet addresses inside ARP packets actually caused more of a design problem later, leading to an Open vSwitch extension action specialized for dropping \`\`spoofed’’ ARP packets in which the frame and ARP Ethernet source addressed differed\[char46] (This extension was never standardized\[char46] Open vSwitch dropped support for it a few releases after it added support for full ARP matching\[char46])

The design of the OpenFlow fixed-length matches also illustrates compromises, in both directions, between the strengths and weaknesses of software and hardware that have always influenced the design of OpenFlow\[char46] Support for matching ARP fields that do fit in the data structure was only added late in the design process (and remained optional in OpenFlow 1\[char46]0), for example, because common switch ASICs did not support matching these fields\[char46]

The compromises in favor of software occurred for more complicated reasons\[char46] The OpenFlow designers did not know how to implement matching in software that was fast, dynamic, and general\[char46] (A way was later found [Srinivasan]\[char46]) Thus, the designers sought to support dynamic, general matching that would be fast in realistic special cases, in particular when all of the matches were _microflows_, that is, matches that specify every field present in a packet, because such matches can be implemented as a single hash table lookup\[char46] Contemporary research supported the feasibility of this approach: the number of microflows in a campus network had been measured to peak at about 10,000 [Casado, section 3\[char46]2]\[char46] (Calculations show that this can only be true in a lightly loaded network [Pepelnjak]\[char46])

As a result, OpenFlow 1\[char46]0 required switches to treat microflow matches as the highest possible priority\[char46] This let software switches perform the microflow hash table lookup first\[char46] Only on failure to match a microflow did the switch need to fall back to checking the more general and presumed slower matches\[char46] Also, the OpenFlow 1\[char46]0 flow match was minimally flexible, with no support for general bitwise matching, partly on the basis that this seemed more likely amenable to relatively efficient software implementation\[char46] (CIDR masking for IPv4 addresses was added relatively late in the OpenFlow 1\[char46]0 design process\[char46])

Microflow matching was later discovered to aid some hardware implementations\[char46] The TCAM chips used for matching in hardware do not support priority in the same way as OpenFlow but instead tie priority to ordering [Pagiamtzis]\[char46] Thus, adding a new match with a priority between the priorities of existing matches can require reordering an arbitrary number of TCAM entries\[char46] On the other hand, when microflows are highest priority, they can be managed as a set-aside portion of the TCAM entries\[char46]

The emphasis on matching microflows also led designers to carefully consider the bandwidth requirements between switch and controller: to maximize the number of microflow setups per second, one must minimize the size of each flow’s description\[char46] This favored the fixed-length format in use, because it expressed common TCP and UDP microflows in fewer bytes than more flexible \`\`type-length-value’’ (TLV) formats\[char46] (Early versions of OpenFlow also avoided TLVs in general to head off protocol fragmentation\[char46])
.SU "Inapplicable Fields"

OpenFlow 1\[char46]0 does not clearly specify how to treat inapplicable fields\[char46] The members for inapplicable fields are always present in the match data structure, as are the bits that indicate whether the fields are matched, and the \`\`correct’’ member and bit values for inapplicable fields is unclear\[char46] OpenFlow 1\[char46]0 implementations changed their behavior over time as priorities shifted\[char46] The early OpenFlow reference implementation, motivated to make every flow a microflow to enable hashing, treated inapplicable fields as exact matches on a value of 0\[char46] Initially, this behavior was implemented in the reference controller only\[char46]

Later, the reference switch was also changed to actually force any wildcarded inapplicable fields into exact matches on 0\[char46] The latter behavior sometimes caused problems, because the modified flow was the one reported back to the controller later when it queried the flow table, and the modifications sometimes meant that the controller could not properly recognize the flow that it had added\[char46] In retrospect, perhaps this problem should have alerted the designers to a design error, but the ability to use a single hash table was held to be more important than almost every other consideration at the time\[char46]

When more flexible match formats were introduced much later, they disallowed any mention of inapplicable fields as part of a match\[char46] This raised the question of how to translate between this new format and the OpenFlow 1\[char46]0 fixed format\[char46] It seemed somewhat inconsistent and backward to treat fields as exact-match in one format and forbid matching them in the other, so instead the treatment of inapplicable fields in the fixed-length format was changed from exact match on 0 to wildcarding\[char46] (A better classifier had by now eliminated software performance problems with wildcards\[char46])

The OpenFlow 1\[char46]0\[char46]1 errata (released only in 2012) added some additional explanation [OpenFlow 1\[char46]0\[char46]1, section 3\[char46]4], but it did not mandate specific behavior because of variation among implementations\[char46]
.ST "OpenFlow 1\[char46]1"

The OpenFlow 1\[char46]1 protocol match format was designed as a type/length/value (TLV) format to allow for future flexibility\[char46] The specification standardized only a single type **OFPMT\_STANDARD** (0) with a fixed-size payload, described here\[char46] The additional fields and bitwise masks in OpenFlow 1\[char46]1 cause this match structure to be over twice as large as in OpenFlow 1\[char46]0, 88 bytes versus 40\[char46]

OpenFlow 1\[char46]1 added support for the following fields:

* ·  
  SCTP source and destination port\[char46]
* ·  
  MPLS label and traffic control (TC) fields\[char46]
* ·  
  One 64-bit register (named \`\`metadata’’)\[char46]

OpenFlow 1\[char46]1 increased the width of the ingress port number field (and all other port numbers in the protocol) from 16 bits to 32 bits\[char46]

OpenFlow 1\[char46]1 increased matching flexibility by introducing arbitrary bitwise matching on Ethernet and IPv4 address fields and on the new \`\`metadata’’ register field\[char46] Switches were not required to support all possible masks [OpenFlow 1\[char46]1, section 4\[char46]3]\[char46]

By a strict reading of the specification, OpenFlow 1\[char46]1 removed support for matching ICMPv4 type and code [OpenFlow 1\[char46]1, section A\[char46]2\[char46]3], but this is likely an editing error because ICMP matching is described elsewhere [OpenFlow 1\[char46]1, Table 3, Table 4, Figure 4]\[char46] Open vSwitch does support ICMPv4 type and code matching with OpenFlow 1\[char46]1\[char46]

OpenFlow 1\[char46]1 avoided the pitfalls of inapplicable fields that OpenFlow 1\[char46]0 encountered, by requiring the switch to ignore the specified field values [OpenFlow 1\[char46]1, section A\[char46]2\[char46]3]\[char46] It also implied that the switch should ignore the bits that indicate whether to match inapplicable fields\[char46]
.SU "Physical Ingress Port"

OpenFlow 1\[char46]1 introduced a new pseudo-field, the physical ingress port\[char46] The physical ingress port is only a pseudo-field because it cannot be used for matching\[char46] It appears only one place in the protocol, in the \`\`packet-in’’ message that passes a packet received at the switch to an OpenFlow controller\[char46]

A packet’s ingress port and physical ingress port are identical except for packets processed by a switch feature such as bonding or tunneling that makes a packet appear to arrive on a \`\`virtual’’ port associated with the bond or the tunnel\[char46] For such packets, the ingress port is the virtual port and the physical ingress port is, naturally, the physical port\[char46] Open vSwitch implements both bonding and tunneling, but its bonding implementation does not use virtual ports and its tunnels are typically not on the same OpenFlow switch as their physical ingress ports (which need not be part of any switch), so the ingress port and physical ingress port are always the same in Open vSwitch\[char46]
.ST "OpenFlow 1\[char46]2"

OpenFlow 1\[char46]2 abandoned the fixed-length approach to matching\[char46] One reason was size, since adding support for IPv6 address matching (now seen as important), with bitwise masks, would have added 64 bytes to the match length, increasing it from 88 bytes in OpenFlow 1\[char46]1 to over 150 bytes\[char46] Extensibility had also become important as controller writers increasingly wanted support for new fields without having to change messages throughout the OpenFlow protocol\[char46] The challenges of carefully defining fixed-length matches to avoid problems with inapplicable fields had also become clear over time\[char46]

Therefore, OpenFlow 1\[char46]2 adopted a flow format using a flexible type-length-value (TLV) representation, in which each TLV expresses a match on one field\[char46] These TLVs were in turn encapsulated inside the outer TLV wrapper introduced in OpenFlow 1\[char46]1 with the new identifier **OFPMT\_OXM** (1)\[char46] (This wrapper fulfilled its intended purpose of reducing the amount of churn in the protocol when changing match formats; some messages that included matches remained unchanged from OpenFlow 1\[char46]1 to 1\[char46]2 and later versions\[char46])

OpenFlow 1\[char46]2 added support for the following fields:

* ·  
  ARP hardware addresses (SHA and THA)\[char46]
* ·  
  IPv4 ECN\[char46]
* ·  
  IPv6 source and destination addresses, flow label, DSCP, ECN, and protocol\[char46]
* ·  
  TCP, UDP, and SCTP port numbers when encapsulated inside IPv6\[char46]
* ·  
  ICMPv6 type and code\[char46]
* ·  
  ICMPv6 Neighbor Discovery target address and source and target Ethernet addresses\[char46]

The OpenFlow 1\[char46]2 format, called _OXM_ (OpenFlow Extensible
Match), was modeled closely on an extension to OpenFlow 1\[char46]0 introduced in Open vSwitch 1\[char46]1 called _NXM_ (Nicira Extended
Match)\[char46] Each OXM or NXM TLV has the following format:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "vendor/class" width .75
B1: box "field" width .4
"16" at B0.n above
"" at B0.s below
"7" at B1.n above
"" at B1.s below
line &lt;-&gt; "type" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
[
B0: box "HM" width .25
B1: box "length" width .4
"1" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "body" width 1.7
"length bytes" at B0.n above
"" at B0.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
.PE
\}

.if n \{
    fL        type  
    fL <---------------->  
    fL      16        7   1    8      length bytes  
    fL+------------+-----+--+------+ +------------+  
    fL|vendor/class|field|HM|length| |    body    |  
    fL+------------+-----+--+------+ +------------+  
    fL
\}

The most significant 16 bits of the NXM or OXM header, called **vendor** by NXM and **class** by OXM, identify an organization permitted to allocate identifiers for fields\[char46] NXM allocates only two vendors, 0x0000 for fields supported by OpenFlow 1\[char46]0 and 0x0001 for fields implemented as an Open vSwitch extension\[char46] OXM assigns classes as follows:

* 0x0000 (**OFPXMC\_NXM\_0**)\[char46]  
  .TQ .5in
  0x0001 (**OFPXMC\_NXM\_1**)\[char46]
  Reserved for NXM compatibility\[char46]
* 0x0002 to 0x7fff  
  Reserved for allocation to ONF members, but none yet assigned\[char46]
* 0x8000 (**OFPXMC\_OPENFLOW\_BASIC**)  
  Used for most standard OpenFlow fields\[char46]
* 0x8001 (**OFPXMC\_PACKET\_REGS**)  
  Used for packet register fields in OpenFlow 1\[char46]5 and later\[char46]
* 0x8002 to 0xfffe  
  Reserved for the OpenFlow specification\[char46]
* 0xffff (**OFPXMC\_EXPERIMENTER**)  
  Experimental use\[char46]

When **class** is 0xffff, the OXM header is extended to 64 bits by using the first 32 bits of the body as an **experimenter** field whose most significant byte is zero and whose remaining bytes are an Organizationally Unique Identifier (OUI) assigned by the IEEE [IEEE OUI], as shown below\[char46]


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "class" width .75
B1: box "field" width .4
"16" at B0.n above
"0xffff" at B0.s below
"7" at B1.n above
"" at B1.s below
line &lt;-&gt; "type" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
[
B0: box "HM" width .25
B1: box "length" width .4
"1" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "zero" width .4
B1: box "OUI" width 1
"8" at B0.n above
"0x00" at B0.s below
"24" at B1.n above
"" at B1.s below
line &lt;-&gt; "experimenter" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "body" width 1.7
"(length - 4) bytes" at B0.n above
"" at B0.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
.PE
\}

.if n \{
    fL     type                 experimenter  
    fL <---------->             <---------->  
    fL   16     7   1    8        8     24     (length - 4) bytes  
    fL+------+-----+--+------+ +------+-----+ +------------------+  
    fL|class |field|HM|length| | zero | OUI | |       body       |  
    fL+------+-----+--+------+ +------+-----+ +------------------+  
    fL 0xffff                    0x00
\}

OpenFlow says that support for experimenter fields is optional\[char46] Open vSwitch 2\[char46]4 and later does support them, so that it can support the following experimenter classes:

* 0x4f4e4600 (**ONFOXM\_ET**)  
  Used by official Open Networking Foundation extensions in OpenFlow 1\[char46]3 and later\[char46] e\[char46]g\[char46] [TCP Flags Match Field Extension]\[char46]
* 0x005ad650 (**NXOXM\_NSH**)  
  Used by Open vSwitch for NSH extensions, in the absence of an official ONF-assigned class\[char46] (This OUI is randomly generated\[char46])

Taken as a unit, **class** (or **vendor**), **field**, and **experimenter** (when present) uniquely identify a particular field\[char46]

When **hasmask** (abbreviated **HM** above) is 0, the OXM is an exact match on an entire field\[char46] In this case, the body (excluding the experimenter field, if present) is a single value to be matched\[char46]

When **hasmask** is 1, the OXM is a bitwise match\[char46] The body (excluding the experimenter field) consists of a value to match, followed by the bitwise mask to apply\[char46] A 1-bit in the mask indicates that the corresponding bit in the value should be matched and a 0-bit that it should be ignored\[char46] For example, for an IP address field, a value of 192\[char46]168\[char46]0\[char46]0 followed by a mask of 255\[char46]255\[char46]0\[char46]0 would match addresses in the 196\[char46]168\[char46]0\[char46]0/16 subnet\[char46]

* ·  
  Some fields might not support masking at all, and some fields that do support masking might restrict it to certain patterns\[char46] For example, fields that have IP address values might be restricted to CIDR masks\[char46] The descriptions of individual fields note these restrictions\[char46]
* ·  
  An OXM TLV with a mask that is all zeros is not useful (although it is not forbidden), because it is has the same effect as omitting the TLV entirely\[char46]
* ·  
  It is not meaningful to pair a 0-bit in an OXM mask with a 1-bit in its value, and Open vSwitch rejects such an OXM with the error **OFPBMC\_BAD\_WILDCARDS**, as required by OpenFlow 1\[char46]3 and later\[char46]

The **length** identifies the number of bytes in the body, including the 4-byte **experimenter** header, if it is present\[char46] Each OXM TLV has a fixed length; that is, given **class**, **field**, **experimenter** (if present), and **hasmask**, **length** is a constant\[char46] The **length** is included explicitly to allow software to minimally parse OXM TLVs of unknown types\[char46]

OXM TLVs must be ordered so that a field’s prerequisites are satisfied before it is parsed\[char46] For example, an OXM TLV that matches on the IPv4 source address field is only allowed following an OXM TLV that matches on the Ethertype for IPv4\[char46] Similarly, an OXM TLV that matches on the TCP source port must follow a TLV that matches an Ethertype of IPv4 or IPv6 and one that matches an IP protocol of TCP (in that order)\[char46] The order of OXM TLVs is not otherwise restricted; no canonical ordering is defined\[char46]

A given field may be matched only once in a series of OXM TLVs\[char46]
.ST "OpenFlow 1\[char46]3"

OpenFlow 1\[char46]3 showed OXM to be largely successful, by adding new fields without making any changes to how flow matches otherwise worked\[char46] It added OXMs for the following fields supported by Open vSwitch:

* ·  
  Tunnel ID for ports associated with e\[char46]g\[char46] VXLAN or keyed GRE\[char46]
* ·  
  MPLS \`\`bottom of stack’’ (BOS) bit\[char46]

OpenFlow 1\[char46]3 also added OXMs for the following fields not documented here and not yet implemented by Open vSwitch:

* ·  
  IPv6 extension header handling\[char46]
* ·  
  PBB I-SID\[char46]
.ST "OpenFlow 1\[char46]4"

OpenFlow 1\[char46]4 added OXMs for the following fields not documented here and not yet implemented by Open vSwitch:

* ·  
  PBB UCA\[char46]
.ST "OpenFlow 1\[char46]5"

OpenFlow 1\[char46]5 added OXMs for the following fields supported by Open vSwitch:

* ·  
  Packet type\[char46]
* ·  
  TCP flags\[char46]
* ·  
  Packet registers\[char46]
* ·  
  The output port in the OpenFlow action set\[char46]

<a name="fields-reference"></a>

# Fields Reference


The following sections document the fields that Open vSwitch supports\[char46] Each section provides introductory material on a group of related fields, followed by information on each individual field\[char46] In addition to field-specific information, each field begins with a table with entries for the following important properties:

* Name  
  The field’s name, used for parsing and formatting the field, e\[char46]g\[char46] in **ovs-ofctl** commands\[char46] For historical reasons, some fields have an additional name that is accepted as an alternative in parsing\[char46] This name, when there is one, is listed as well, e\[char46]g\[char46] \`\`**tun** (aka **tunnel\_id**)\[char46]’’
* Width  
  The field’s width, always a multiple of 8 bits\[char46] Some fields don’t use all of the bits, so this may be accompanied by an explanation\[char46] For example, OpenFlow embeds the 2-bit IP ECN field as as the low bits in an 8-bit byte, and so its width is expressed as \`\`8 bits (only the least-significant 2 bits may be nonzero)\[char46]’’
* Format  
  How a value for the field is formatted or parsed by, e\[char46]g\[char46], **ovs-ofctl**\[char46] Some possibilities are generic:
    * decimal  
      Formats as a decimal number\[char46] On input, accepts decimal numbers or hexadecimal numbers prefixed by **0x**\[char46]
    * hexadecimal  
      Formats as a hexadecimal number prefixed by **0x**\[char46] On input, accepts decimal numbers or hexadecimal numbers prefixed by **0x**\[char46] (The default for parsing is **not** hexadecimal: only a **0x** prefix causes input to be treated as hexadecimal\[char46])
    * Ethernet  
      Formats and accepts the common Ethernet address format **xx:xx:xx:xx:xx:xx**\[char46]
    * IPv4  
      Formats and accepts the dotted-quad format **a\[char46]b\[char46]c\[char46]d**\[char46] For bitwise matches, formats and accepts **address/length** CIDR notation in addition to **address/mask**\[char46]
    * IPv6  
      Formats and accepts the common IPv6 address formats, plus CIDR notation for bitwise matches\[char46]
    * OpenFlow 1\[char46]0 port  
      Accepts 16-bit port numbers in decimal, plus OpenFlow well-known port names (e\[char46]g\[char46] **IN\_PORT**) in uppercase or lowercase\[char46]
    * OpenFlow 1\[char46]1+ port  
      Same syntax as OpenFlow 1\[char46]0 ports but for 32-bit OpenFlow 1\[char46]1+ port number fields\[char46]
* Other, field-specific formats are explained along with their fields\[char46]
* Masking  
  For most fields, this says \`\`arbitrary bitwise masks,’’ meaning that a flow may match any combination of bits in the field\[char46] Some fields instead say \`\`exact match only,’’ which means that a flow that matches on this field must match on the whole field instead of just certain bits\[char46] Either way, this reports masking support for the latest version of Open vSwitch using OXM or NXM (that is, either OpenFlow 1\[char46]2+ or OpenFlow 1\[char46]0 plus Open vSwitch NXM extensions)\[char46] In particular, OpenFlow 1\[char46]0 (without NXM) and 1\[char46]1 don’t always support masking even if Open vSwitch itself does; refer to the **OpenFlow 1\[char46]0** and **OpenFlow 1\[char46]1** rows to learn about masking with these protocol versions\[char46]
* Prerequisites  
  Requirements that must be met to match on this field\[char46] For example, **ip\_src** has IPv4 as a prerequisite, meaning that a match must include **eth\_type=0x0800** to match on the IPv4 source address\[char46] The following prerequisites, with their requirements, are currently in use:
    * none  
      (no requirements)
    * VLAN VID  
      **vlan\_tci=0x1000/0x1000** (i\[char46]e\[char46] a VLAN header is present)
    * ARP  
      **eth\_type=0x0806** (ARP) or **eth\_type=0x8035** (RARP)
    * IPv4  
      **eth\_type=0x0800**
    * IPv6  
      **eth\_type=0x86dd**
    * IPv4/IPv6  
      IPv4 or IPv6
    * MPLS  
      **eth\_type=0x8847** or **eth\_type=0x8848**
    * TCP  
      IPv4/IPv6 and **ip\_proto=6**
    * UDP  
      IPv4/IPv6 and **ip\_proto=17**
    * SCTP  
      IPv4/IPv6 and **ip\_proto=132**
    * ICMPv4  
      IPv4 and **ip\_proto=1**
    * ICMPv6  
      IPv6 and **ip\_proto=58**
    * ND solicit  
      ICMPv6 and **icmp\_type=135** and **icmp\_code=0**
    * ND advert  
      ICMPv6 and **icmp\_type=136** and **icmp\_code=0**
    * ND  
      ND solicit or ND advert
* The TCP, UDP, and SCTP prerequisites also have the special requirement that **nw\_frag** is not being used to select \`\`later fragments\[char46]’’ This is because only the first fragment of a fragmented IPv4 or IPv6 datagram contains the TCP or UDP header\[char46]
* Access  
  Most fields are \`\`read/write,’’ which means that common OpenFlow actions like **set\_field** can modify them\[char46] Fields that are \`\`read-only’’ cannot be modified in these general-purpose ways, although there may be other ways that actions can modify them\[char46]
* OpenFlow 1\[char46]0  
  .TQ .5in
  OpenFlow 1\[char46]1
  These rows report the level of support that OpenFlow 1\[char46]0 or OpenFlow 1\[char46]1, respectively, has for a field\[char46] For OpenFlow 1\[char46]0, supported fields are reported as either \`\`yes (exact match only)’’ for fields that do not support any bitwise masking or \`\`yes (CIDR match only)’’ for fields that support CIDR masking\[char46] OpenFlow 1\[char46]1 supported fields report either \`\`yes (exact match only)’’ or simply \`\`yes’’ for fields that do support arbitrary masks\[char46] These OpenFlow versions supported a fixed collection of fields that cannot be extended, so many more fields are reported as \`\`not supported\[char46]’’
* OXM  
  .TQ .5in
  NXM
  These rows report the OXM and NXM code points that correspond to a given field\[char46] Either or both may be \`\`none\[char46]’’
* A field that has only an OXM code point is usually one that was standardized before it was added to Open vSwitch\[char46] A field that has only an NXM code point is usually one that is not yet standardized\[char46] When a field has both OXM and NXM code points, it usually indicates that it was introduced as an Open vSwitch extension under the NXM code point, then later standardized under the OXM code point\[char46] A field can have more than one OXM code point if it was standardized in OpenFlow 1\[char46]4 or later and additionally introduced as an official ONF extension for OpenFlow 1\[char46]3\[char46] (A field that has neither OXM nor NXM code point is typically an obsolete field that is supported in some other form using OXM or NXM\[char46])
* Each code point in these rows is described in the form \`\`**NAME** (_number_) since OpenFlow _spec_ and Open vSwitch _version_,’’ e\[char46]g\[char46] \`\`**OXM\_OF\_ETH\_TYPE** (5) since OpenFlow 1\[char46]2 and Open vSwitch 1\[char46]7\[char46]’’ First, **NAME**, which specifies a name for the code point, starts with a prefix that designates a class and, in some cases, a vendor, as listed in the following table:
* .TS
  tab(;);
  l l l.
  Prefix;Vendor;Class
  \_;\_;\_
  **NXM\_OF**;(none);\fL0x0000;
  **NXM\_NX**;(none);\fL0x0001;
  **OXM\_OF**;(none);\fL0x8000;
  **OXM\_OF\_PKT\_REG**;(none);\fL0x8001;
  **NXOXM\_ET**;\fL0x00002320;\fL0xffff;
  **NXOXM\_NSH**;\fL0x005ad650;\fL0xffff;
  **ONFOXM\_ET**;\fL0x4f4e4600;\fL0xffff;
  .TE
* For more information on OXM/NXM classes and vendors, refer back to **OpenFlow 1\[char46]2** under **Evolution of OpenFlow Fields**\[char46] The _number_ is the field number within the class and vendor\[char46] The OpenFlow _spec_ is the version of OpenFlow that standardized the code point\[char46] It is omitted for NXM code points because they are nonstandard\[char46] The _version_ is the version of Open vSwitch that first supported the code point\[char46]
.bp

<a name="conjunctive-match-fields"></a>

# Conjunctive Match Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**conj\_id**;4;no;no;none;OVS 2.4+
.TE


An individual OpenFlow flow can match only a single value for each field\[char46] However, situations often arise where one wants to match one of a set of values within a field or fields\[char46] For matching a single field against a set, it is straightforward and efficient to add multiple flows to the flow table, one for each value in the set\[char46] For example, one might use the following flows to send packets with IP source address _a_, _b_, _c_, or _d_ to the OpenFlow controller:


      
          ip,ip_src=a actions=controller  
          ip,ip_src=b actions=controller  
          ip,ip_src=c actions=controller  
          ip,ip_src=d actions=controller  
        


Similarly, these flows send packets with IP destination address _e_, _f_, _g_, or _h_ to the OpenFlow controller:


      
          ip,ip_dst=e actions=controller  
          ip,ip_dst=f actions=controller  
          ip,ip_dst=g actions=controller  
          ip,ip_dst=h actions=controller  
        


Installing all of the above flows in a single flow table yields a disjunctive effect: a packet is sent to the controller if **ip\_src** \[mo] {_a_,_b_,_c_,_d_} or **ip\_dst** \[mo] {_e_,_f_,_g_,_h_} (or both)\[char46] (Pedantically, if both of the above sets of flows are present in the flow table, they should have different priorities, because OpenFlow says that the results are undefined when two flows with same priority can both match a single packet\[char46])


Suppose, on the other hand, one wishes to match conjunctively, that is, to send a packet to the controller only if both **ip\_src** \[mo] {_a_,_b_,_c_,_d_} and **ip\_dst** \[mo] {_e_,_f_,_g_,_h_}\[char46] This requires 4 \[mu] 4 = 16 flows, one for each possible pairing of **ip\_src** and **ip\_dst**\[char46] That is acceptable for our small example, but it does not gracefully extend to larger sets or greater numbers of dimensions\[char46]


The **conjunction** action is a solution for conjunctive matches that is built into Open vSwitch\[char46] A **conjunction** action ties groups of individual OpenFlow flows into higher-level \`\`conjunctive flows’’\[char46] Each group corresponds to one dimension, and each flow within the group matches one possible value for the dimension\[char46] A packet that matches one flow from each group matches the conjunctive flow\[char46]


To implement a conjunctive flow with **conjunction**, assign the conjunctive flow a 32-bit _id_, which must be unique within an OpenFlow table\[char46] Assign each of the _n_ \[&gt;=] 2 dimensions a unique number from 1 to _n_; the ordering is unimportant\[char46] Add one flow to the OpenFlow flow table for each possible value of each dimension with **conjunction(_id, k/n)** as the flow’s actions, where k_ is the number assigned to the flow’s dimension\[char46] Together, these flows specify the conjunctive flow’s match condition\[char46] When the conjunctive match condition is met, Open vSwitch looks up one more flow that specifies the conjunctive flow’s actions and receives its statistics\[char46] This flow is found by setting **conj\_id** to the specified _id_ and then again searching the flow table\[char46]


The following flows provide an example\[char46] Whenever the IP source is one of the values in the flows that match on the IP source (dimension 1 of 2), **and** the IP destination is one of the values in the flows that match on IP destination (dimension 2 of 2), Open vSwitch searches for a flow that matches **conj\_id** against the conjunction ID (1234), finding the first flow listed below\[char46]


      
          conj_id=1234 actions=controller  
          ip,ip_src=10[char46]0[char46]0[char46]1 actions=conjunction(1234, 1/2)  
          ip,ip_src=10[char46]0[char46]0[char46]4 actions=conjunction(1234, 1/2)  
          ip,ip_src=10[char46]0[char46]0[char46]6 actions=conjunction(1234, 1/2)  
          ip,ip_src=10[char46]0[char46]0[char46]7 actions=conjunction(1234, 1/2)  
          ip,ip_dst=10[char46]0[char46]0[char46]2 actions=conjunction(1234, 2/2)  
          ip,ip_dst=10[char46]0[char46]0[char46]5 actions=conjunction(1234, 2/2)  
          ip,ip_dst=10[char46]0[char46]0[char46]7 actions=conjunction(1234, 2/2)  
          ip,ip_dst=10[char46]0[char46]0[char46]8 actions=conjunction(1234, 2/2)  
        


Many subtleties exist:


* ·  
  In the example above, every flow in a single dimension has the same form, that is, dimension 1 matches on **ip\_src** and dimension 2 on **ip\_dst**, but this is not a requirement\[char46] Different flows within a dimension may match on different bits within a field (e\[char46]g\[char46] IP network prefixes of different lengths, or TCP/UDP port ranges as bitwise matches), or even on entirely different fields (e\[char46]g\[char46] to match packets for TCP source port 80 or TCP destination port 80)\[char46]
* ·  
  The flows within a dimension can vary their matches across more than one field, e\[char46]g\[char46] to match only specific pairs of IP source and destination addresses or L4 port numbers\[char46]
* ·  
  A flow may have multiple **conjunction** actions, with different **id** values\[char46] This is useful for multiple conjunctive flows with overlapping sets\[char46] If one conjunctive flow matches packets with both **ip\_src** \[mo] {_a_,_b_} and **ip\_dst** \[mo] {_d_,_e_} and a second conjunctive flow matches **ip\_src** \[mo] {_b_,_c_} and **ip\_dst** \[mo] {_f_,_g_}, for example, then the flow that matches **ip\_src=**_b_ would have two **conjunction** actions, one for each conjunctive flow\[char46] The order of **conjunction** actions within a list of actions is not significant\[char46]
* ·  
  A flow with **conjunction** actions may also include **note** actions for annotations, but not any other kind of actions\[char46] (They would not be useful because they would never be executed\[char46])
* ·  
  All of the flows that constitute a conjunctive flow with a given _id_ must have the same priority\[char46] (Flows with the same _id_ but different priorities are currently treated as different conjunctive flows, that is, currently _id_ values need only be unique within an OpenFlow table at a given priority\[char46] This behavior isn’t guaranteed to stay the same in later releases, so please use _id_ values unique within an OpenFlow table\[char46])
* ·  
  Conjunctive flows must not overlap with each other, at a given priority, that is, any given packet must be able to match at most one conjunctive flow at a given priority\[char46] Overlapping conjunctive flows yield unpredictable results\[char46]
* ·  
  Following a conjunctive flow match, the search for the flow with **conj\_id=**_id_ is done in the same general-purpose way as other flow table searches, so one can use flows with **conj\_id=**_id_ to act differently depending on circumstances\[char46] (One exception is that the search for the **conj\_id=**_id_ flow itself ignores conjunctive flows, to avoid recursion\[char46]) If the search with **conj\_id=**_id_ fails, Open vSwitch acts as if the conjunctive flow had not matched at all, and continues searching the flow table for other matching flows\[char46]
* ·  
  OpenFlow prerequisite checking occurs for the flow with **conj\_id=**_id_ in the same way as any other flow, e\[char46]g\[char46] in an OpenFlow 1\[char46]1+ context, putting a **mod\_nw\_src** action into the example above would require adding an **ip** match, like this:
*       
              conj_id=1234,ip actions=mod_nw_src:1[char46]2[char46]3[char46]4,controller  
            
* ·  
OpenFlow prerequisite checking also occurs for the individual flows that comprise a conjunctive match in the same way as any other flow\[char46]  
* ·  
  The flows that constitute a conjunctive flow do not have useful statistics\[char46] They are never updated with byte or packet counts, and so on\[char46] (For such a flow, therefore, the idle and hard timeouts work much the same way\[char46])
* ·  
  Sometimes there is a choice of which flows include a particular match\[char46] For example, suppose that we added an extra constraint to our example, to match on **ip\_src** \[mo] {_a_,_b_,_c_,_d_} and **ip\_dst** \[mo] {_e_,_f_,_g_,_h_} and **tcp\_dst** = _i_\[char46] One way to implement this is to add the new constraint to the **conj\_id** flow, like this:
*       
              conj_id=1234,tcp,tcp_dst=i actions=mod_nw_src:1[char46]2[char46]3[char46]4,controller  
            
* but **this is not recommended** because of the cost of the extra flow table lookup\[char46] Instead, add the constraint to the individual flows, either in one of the dimensions or (slightly better) all of them\[char46]
* ·  
  A conjunctive match must have _n_ \[&gt;=] 2 dimensions (otherwise a conjunctive match is not necessary)\[char46] Open vSwitch enforces this\[char46]
* ·  
  Each dimension within a conjunctive match should ordinarily have more than one flow\[char46] Open vSwitch does not enforce this\[char46]


**Conjunction ID Field**
.TS
tab(;);
l lx.
Name:;**conj\_id**
Width:;32 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;none
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CONJ\_ID** (37) since Open vSwitch 2.4
T}
.TE


Used for conjunctive matching\[char46] See above for more information\[char46]
.bp

<a name="tunnel-fields"></a>

# Tunnel Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**tun\_id** aka **tunnel\_id**;8;yes;yes;none;OF 1.3+ and OVS 1.1+
**tun\_src**;4;yes;yes;none;OVS 2.0+
**tun\_dst**;4;yes;yes;none;OVS 2.0+
**tun\_ipv6\_src**;16;yes;yes;none;OVS 2.5+
**tun\_ipv6\_dst**;16;yes;yes;none;OVS 2.5+
**tun\_gbp\_id**;2;yes;yes;none;OVS 2.4+
**tun\_gbp\_flags**;1;yes;yes;none;OVS 2.4+
**tun\_erspan\_ver**;1 (low 4 bits);yes;yes;none;OVS 2.10+
**tun\_erspan\_idx**;4 (low 20 bits);yes;yes;none;OVS 2.10+
**tun\_erspan\_dir**;1 (low 1 bits);yes;yes;none;OVS 2.10+
**tun\_erspan\_hwid**;1 (low 6 bits);yes;yes;none;OVS 2.10+
**tun\_metadata0**;124;yes;yes;none;OVS 2.5+
**tun\_metadata1**;124;yes;yes;none;OVS 2.5+
**tun\_metadata2**;124;yes;yes;none;OVS 2.5+
**tun\_metadata3**;124;yes;yes;none;OVS 2.5+
**tun\_metadata4**;124;yes;yes;none;OVS 2.5+
**tun\_metadata5**;124;yes;yes;none;OVS 2.5+
**tun\_metadata6**;124;yes;yes;none;OVS 2.5+
**tun\_metadata7**;124;yes;yes;none;OVS 2.5+
**tun\_metadata8**;124;yes;yes;none;OVS 2.5+
**tun\_metadata9**;124;yes;yes;none;OVS 2.5+
**tun\_metadata10**;124;yes;yes;none;OVS 2.5+
**tun\_metadata11**;124;yes;yes;none;OVS 2.5+
**tun\_metadata12**;124;yes;yes;none;OVS 2.5+
**tun\_metadata13**;124;yes;yes;none;OVS 2.5+
**tun\_metadata14**;124;yes;yes;none;OVS 2.5+
**tun\_metadata15**;124;yes;yes;none;OVS 2.5+
**tun\_metadata16**;124;yes;yes;none;OVS 2.5+
**tun\_metadata17**;124;yes;yes;none;OVS 2.5+
**tun\_metadata18**;124;yes;yes;none;OVS 2.5+
**tun\_metadata19**;124;yes;yes;none;OVS 2.5+
**tun\_metadata20**;124;yes;yes;none;OVS 2.5+
**tun\_metadata21**;124;yes;yes;none;OVS 2.5+
**tun\_metadata22**;124;yes;yes;none;OVS 2.5+
**tun\_metadata23**;124;yes;yes;none;OVS 2.5+
**tun\_metadata24**;124;yes;yes;none;OVS 2.5+
**tun\_metadata25**;124;yes;yes;none;OVS 2.5+
**tun\_metadata26**;124;yes;yes;none;OVS 2.5+
**tun\_metadata27**;124;yes;yes;none;OVS 2.5+
**tun\_metadata28**;124;yes;yes;none;OVS 2.5+
**tun\_metadata29**;124;yes;yes;none;OVS 2.5+
**tun\_metadata30**;124;yes;yes;none;OVS 2.5+
**tun\_metadata31**;124;yes;yes;none;OVS 2.5+
**tun\_metadata32**;124;yes;yes;none;OVS 2.5+
**tun\_metadata33**;124;yes;yes;none;OVS 2.5+
**tun\_metadata34**;124;yes;yes;none;OVS 2.5+
**tun\_metadata35**;124;yes;yes;none;OVS 2.5+
**tun\_metadata36**;124;yes;yes;none;OVS 2.5+
**tun\_metadata37**;124;yes;yes;none;OVS 2.5+
**tun\_metadata38**;124;yes;yes;none;OVS 2.5+
**tun\_metadata39**;124;yes;yes;none;OVS 2.5+
**tun\_metadata40**;124;yes;yes;none;OVS 2.5+
**tun\_metadata41**;124;yes;yes;none;OVS 2.5+
**tun\_metadata42**;124;yes;yes;none;OVS 2.5+
**tun\_metadata43**;124;yes;yes;none;OVS 2.5+
**tun\_metadata44**;124;yes;yes;none;OVS 2.5+
**tun\_metadata45**;124;yes;yes;none;OVS 2.5+
**tun\_metadata46**;124;yes;yes;none;OVS 2.5+
**tun\_metadata47**;124;yes;yes;none;OVS 2.5+
**tun\_metadata48**;124;yes;yes;none;OVS 2.5+
**tun\_metadata49**;124;yes;yes;none;OVS 2.5+
**tun\_metadata50**;124;yes;yes;none;OVS 2.5+
**tun\_metadata51**;124;yes;yes;none;OVS 2.5+
**tun\_metadata52**;124;yes;yes;none;OVS 2.5+
**tun\_metadata53**;124;yes;yes;none;OVS 2.5+
**tun\_metadata54**;124;yes;yes;none;OVS 2.5+
**tun\_metadata55**;124;yes;yes;none;OVS 2.5+
**tun\_metadata56**;124;yes;yes;none;OVS 2.5+
**tun\_metadata57**;124;yes;yes;none;OVS 2.5+
**tun\_metadata58**;124;yes;yes;none;OVS 2.5+
**tun\_metadata59**;124;yes;yes;none;OVS 2.5+
**tun\_metadata60**;124;yes;yes;none;OVS 2.5+
**tun\_metadata61**;124;yes;yes;none;OVS 2.5+
**tun\_metadata62**;124;yes;yes;none;OVS 2.5+
**tun\_metadata63**;124;yes;yes;none;OVS 2.5+
**tun\_flags**;2 (low 1 bits);yes;yes;none;OVS 2.5+
.TE


The fields in this group relate to tunnels, which Open vSwitch supports in several forms (GRE, VXLAN, and so on)\[char46] Most of these fields do appear in the wire format of a packet, so they are data fields from that point of view, but they are metadata from an OpenFlow flow table point of view because they do not appear in packets that are forwarded to the controller or to ordinary (non-tunnel) output ports\[char46]


Open vSwitch supports a spectrum of usage models for mapping tunnels to OpenFlow ports:


* \`\`Port-based’’ tunnels  
  In this model, an OpenFlow port represents one tunnel: it matches a particular type of tunnel traffic between two IP endpoints, with a particular tunnel key (if keys are in use)\[char46] In this situation, **in\_port** suffices to distinguish one tunnel from another, so the tunnel header fields have little importance for OpenFlow processing\[char46] (They are still populated and may be used if it is convenient\[char46]) The tunnel header fields play no role in sending packets out such an OpenFlow port, either, because the OpenFlow port itself fully specifies the tunnel headers\[char46]
* The following Open vSwitch commands create a bridge **br-int**, add port **tap0** to the bridge as OpenFlow port 1, establish a port-based GRE tunnel between the local host and remote IP 192\[char46]168\[char46]1\[char46]1 using GRE key 5001 as OpenFlow port 2, and arranges to forward all traffic from **tap0** to the tunnel and vice versa:
*       
    ovs-vsctl add-br br-int  
    ovs-vsctl add-port br-int tap0 -- set interface tap0 ofport_request=1  
    ovs-vsctl add-port br-int gre0 --  
        set interface gre0 ofport_request=2 type=gre e  
                           options:remote_ip=192[char46]168[char46]1[char46]1 options:key=5001  
    ovs-ofctl add-flow br-int in_port=1,actions=2  
    ovs-ofctl add-flow br-int in_port=2,actions=1  
            
* \`\`Flow-based’’ tunnels  
  In this model, one OpenFlow port represents all possible tunnels of a given type with an endpoint on the current host, for example, all GRE tunnels\[char46] In this situation, **in\_port** only indicates that traffic was received on the particular kind of tunnel\[char46] This is where the tunnel header fields are most important: they allow the OpenFlow tables to discriminate among tunnels based on their IP endpoints or keys\[char46] Tunnel header fields also determine the IP endpoints and keys of packets sent out such a tunnel port\[char46]
* The following Open vSwitch commands create a bridge **br-int**, add port **tap0** to the bridge as OpenFlow port 1, establish a flow-based GRE tunnel port 3, and arranges to forward all traffic from **tap0** to remote IP 192\[char46]168\[char46]1\[char46]1 over a GRE tunnel with key 5001 and vice versa:
*       
    ovs-vsctl add-br br-int  
    ovs-vsctl add-port br-int tap0 -- set interface tap0 ofport_request=1  
    ovs-vsctl add-port br-int allgre --  
        set interface gre0 ofport_request=3 type=gre e  
                           options:remote_ip=flow options:key=flow  
    ovs-ofctl add-flow br-int e  
        ’in_port=1 actions=set_tunnel:5001,set_field:192[char46]168[char46]1[char46]1->tun_dst,3’  
    ovs-ofctl add-flow br-int ’in_port=3,tun_src=192[char46]168[char46]1[char46]1,tun_id=5001 actions=1’  
            
* Mixed models\[char46]  
  One may define both flow-based and port-based tunnels at the same time\[char46] For example, it is valid and possibly useful to create and configure both **gre0** and **allgre** tunnel ports described above\[char46]
* Traffic is attributed on ingress to the most specific matching tunnel\[char46] For example, **gre0** is more specific than **allgre**\[char46] Therefore, if both exist, then **gre0** will be the ingress port for any GRE traffic received from 192\[char46]168\[char46]1\[char46]1 with key 5001\[char46]
* On egress, traffic may be directed to any appropriate tunnel port\[char46] If both **gre0** and **allgre** are configured as already described, then the actions **2** and **set\_tunnel:5001,set\_field:192\[char46]168\[char46]1\[char46]1-&gt;tun\_dst,3** send the same tunnel traffic\[char46]
* Intermediate models\[char46]  
  Ports may be configured as partially flow-based\[char46] For example, one may define an OpenFlow port that represents tunnels between a pair of endpoints but leaves the flow table to discriminate on the flow key\[char46]


**ovs-vswitchd\[char46]conf\[char46]db**(5) describes all the details of tunnel configuration\[char46]


These fields do not have any prerequisites, which means that a flow may match on any or all of them, in any combination\[char46]


These fields are zeros for packets that did not arrive on a tunnel\[char46]


**Tunnel ID Field**
.TS
tab(;);
l lx.
Name:;**tun\_id** (aka **tunnel\_id**)
Width:;64 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_TUNNEL\_ID** (38) since OpenFlow 1.3 and Open vSwitch 1.10
T}
NXM:;T{
**NXM\_NX\_TUN\_ID** (16) since Open vSwitch 1.1
T}
.TE




Many kinds of tunnels support a tunnel ID:

* ·  
  VXLAN and Geneve have a 24-bit virtual network identifier (VNI)\[char46]
* ·  
  LISP has a 24-bit instance ID\[char46]
* ·  
  GRE has an optional 32-bit key\[char46]
* ·  
  STT has a 64-bit key\[char46]
* ·  
  ERSPAN has a 10-bit key (Session ID)\[char46]


When a packet is received from a tunnel, this field holds the tunnel ID in its least significant bits, zero-extended to fit\[char46] This field is zero if the tunnel does not support an ID, or if no ID is in use for a tunnel type that has an optional ID, or if an ID of zero received, or if the packet was not received over a tunnel\[char46]


When a packet is output to a tunnel port, the tunnel configuration determines whether the tunnel ID is taken from this field or bound to a fixed value\[char46] See the earlier description of \`\`port-based’’ and \`\`flow-based’’ tunnels for more information\[char46]


The following diagram shows the origin of this field in a typical keyed GRE tunnel:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.4
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"47" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "type" width 0.4
B2: box "key" width .4 fill
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"0x6558" at B1.s below
"32" at B2.n above
"" at B2.s below
line &lt;-&gt; "GRE" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4               GRE           Ethernet  
    fL <----------->   <--------------->   <------------>   <---------->  
    fL 48  48   16           8   32  32    16    16   32    48  48   16  
    fL+---+---+-----+ +---+-----+---+---+ +---+------+---+ +---+---+----+  
    fL|dst|src|type | |...|proto|src|dst| |...| type |key| |dst|src|type| ...  
    fL+---+---+-----+ +---+-----+---+---+ +---+------+---+ +---+---+----+  
    fL         0x800        47                 0x6558
\}


**Tunnel IPv4 Source Field**
.TS
tab(;);
l lx.
Name:;**tun\_src**
Width:;32 bits
Format:;IPv4
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_TUN\_IPV4\_SRC** (31) since Open vSwitch 2.0
T}
.TE




When a packet is received from a tunnel, this field is the source address in the outer IP header of the tunneled packet\[char46] This field is zero if the packet was not received over a tunnel\[char46]


When a packet is output to a flow-based tunnel port, this field influences the IPv4 source address used to send the packet\[char46] If it is zero, then the kernel chooses an appropriate IP address based using the routing table\[char46]


The following diagram shows the origin of this field in a typical keyed GRE tunnel:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.4
B2: box "src" width 0.4 fill
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"47" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "type" width 0.4
B2: box "key" width .4
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"0x6558" at B1.s below
"32" at B2.n above
"" at B2.s below
line &lt;-&gt; "GRE" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4               GRE           Ethernet  
    fL <----------->   <--------------->   <------------>   <---------->  
    fL 48  48   16           8   32  32    16    16   32    48  48   16  
    fL+---+---+-----+ +---+-----+---+---+ +---+------+---+ +---+---+----+  
    fL|dst|src|type | |...|proto|src|dst| |...| type |key| |dst|src|type| ...  
    fL+---+---+-----+ +---+-----+---+---+ +---+------+---+ +---+---+----+  
    fL         0x800        47                 0x6558
\}


**Tunnel IPv4 Destination Field**
.TS
tab(;);
l lx.
Name:;**tun\_dst**
Width:;32 bits
Format:;IPv4
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_TUN\_IPV4\_DST** (32) since Open vSwitch 2.0
T}
.TE




When a packet is received from a tunnel, this field is the destination address in the outer IP header of the tunneled packet\[char46] This field is zero if the packet was not received over a tunnel\[char46]


When a packet is output to a flow-based tunnel port, this field specifies the destination to which the tunnel packet is sent\[char46]


The following diagram shows the origin of this field in a typical keyed GRE tunnel:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.4
B2: box "src" width 0.4
B3: box "dst" width 0.4 fill
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"47" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "type" width 0.4
B2: box "key" width .4
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"0x6558" at B1.s below
"32" at B2.n above
"" at B2.s below
line &lt;-&gt; "GRE" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4               GRE           Ethernet  
    fL <----------->   <--------------->   <------------>   <---------->  
    fL 48  48   16           8   32  32    16    16   32    48  48   16  
    fL+---+---+-----+ +---+-----+---+---+ +---+------+---+ +---+---+----+  
    fL|dst|src|type | |...|proto|src|dst| |...| type |key| |dst|src|type| ...  
    fL+---+---+-----+ +---+-----+---+---+ +---+------+---+ +---+---+----+  
    fL         0x800        47                 0x6558
\}


**Tunnel IPv6 Source Field**
.TS
tab(;);
l lx.
Name:;**tun\_ipv6\_src**
Width:;128 bits
Format:;IPv6
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_TUN\_IPV6\_SRC** (109) since Open vSwitch 2.5
T}
.TE


Similar to **tun\_src**, but for tunnels over IPv6\[char46]


**Tunnel IPv6 Destination Field**
.TS
tab(;);
l lx.
Name:;**tun\_ipv6\_dst**
Width:;128 bits
Format:;IPv6
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_TUN\_IPV6\_DST** (110) since Open vSwitch 2.5
T}
.TE


Similar to **tun\_dst**, but for tunnels over IPv6\[char46]


<a name="vxlan-group-based-policy-fields"></a>

### VXLAN Group-Based Policy Fields



The VXLAN header is defined as follows [RFC 7348], where the **I** bit must be set to 1, unlabeled bits or those labeled **reserved** must be set to 0, and Open vSwitch makes the VNI available via **tun\_id**:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "" width 0.15
B1: box "" width 0.15
B2: box "" width 0.15
B3: box "" width 0.15
B4: box "I" width 0.15
B5: box "" width 0.15
B6: box "" width 0.15
B7: box "" width 0.15
"1" at B0.n above
"" at B0.s below
"1" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
"1" at B3.n above
"" at B3.s below
"1" at B4.n above
"" at B4.s below
"1" at B5.n above
"" at B5.s below
"1" at B6.n above
"" at B6.s below
"1" at B7.n above
"" at B7.s below
line &lt;-&gt; "VXLAN flags" above from B0.nw + (0,textht) to B7.ne + (0,textht)
]
[
B0: box "reserved" width 1.2
B1: box "VNI" width 1.2
B2: box "reserved" width .5
"24" at B0.n above
"" at B0.s below
"24" at B1.n above
"" at B1.s below
"8" at B2.n above
"" at B2.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
.PE
\}

.if n \{
    fL   VXLAN flags  
    fL <------------->  
    fL 1 1 1 1 1 1 1 1    24    24     8  
    fL+-+-+-+-+-+-+-+-+--------+---+--------+  
    fL| | | | |I| | | |reserved|VNI|reserved|  
    fL+-+-+-+-+-+-+-+-+--------+---+--------+  
    fL
\}


VXLAN Group-Based Policy [VXLAN Group Policy Option] adds new interpretations to existing bits in the VXLAN header, reinterpreting it as follows, with changes highlighted:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "" width 0.15
B1: box "D" width 0.15 fill
B2: box "" width 0.15
B3: box "" width 0.15
B4: box "A" width 0.15 fill
B5: box "" width 0.15
B6: box "" width 0.15
B7: box "" width 0.15
"1" at B0.n above
"" at B0.s below
"1" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
"1" at B3.n above
"" at B3.s below
"1" at B4.n above
"" at B4.s below
"1" at B5.n above
"" at B5.s below
"1" at B6.n above
"" at B6.s below
"1" at B7.n above
"" at B7.s below
line &lt;-&gt; "GBP flags" above from B0.nw + (0,textht) to B7.ne + (0,textht)
]
[
B0: box "group policy ID" width 1.2 fill
B1: box "VNI" width 1.2
B2: box "reserved" width .5
"24" at B0.n above
"" at B0.s below
"24" at B1.n above
"" at B1.s below
"8" at B2.n above
"" at B2.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
.PE
\}

.if n \{
    fL    GBP flags  
    fL <------------->  
    fL 1 1 1 1 1 1 1 1       24        24     8  
    fL+-+-+-+-+-+-+-+-+---------------+---+--------+  
    fL| |D| | |A| | | |group policy ID|VNI|reserved|  
    fL+-+-+-+-+-+-+-+-+---------------+---+--------+  
    fL
\}


Open vSwitch makes GBP fields and flags available through the following fields\[char46] Only packets that arrive over a VXLAN tunnel with the GBP extension enabled have these fields set\[char46] In other packets they are zero on receive and ignored on transmit\[char46]


**VXLAN Group-Based Policy ID Field**
.TS
tab(;);
l lx.
Name:;**tun\_gbp\_id**
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_TUN\_GBP\_ID** (38) since Open vSwitch 2.4
T}
.TE




For a packet tunneled over VXLAN with the Group-Based Policy (GBP) extension, this field represents the GBP policy ID, as shown above\[char46]


**VXLAN Group-Based Policy Flags Field**
.TS
tab(;);
l lx.
Name:;**tun\_gbp\_flags**
Width:;8 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_TUN\_GBP\_FLAGS** (39) since Open vSwitch 2.4
T}
.TE




For a packet tunneled over VXLAN with the Group-Based Policy (GBP) extension, this field represents the GBP policy flags, as shown above\[char46]


The field has the format shown below:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "" width 0.15
B1: box "D" width 0.15
B2: box "" width 0.15
B3: box "" width 0.15
B4: box "A" width 0.15
B5: box "" width 0.15
B6: box "" width 0.15
B7: box "" width 0.15
"1" at B0.n above
"" at B0.s below
"1" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
"1" at B3.n above
"" at B3.s below
"1" at B4.n above
"" at B4.s below
"1" at B5.n above
"" at B5.s below
"1" at B6.n above
"" at B6.s below
"1" at B7.n above
"" at B7.s below
line &lt;-&gt; "GBP Flags" above from B0.nw + (0,textht) to B7.ne + (0,textht)
]
.PE
\}

.if n \{
    fL    GBP Flags  
    fL <------------->  
    fL 1 1 1 1 1 1 1 1  
    fL+-+-+-+-+-+-+-+-+  
    fL| |D| | |A| | | |  
    fL+-+-+-+-+-+-+-+-+  
    fL
\}


Unlabeled bits are reserved and must be transmitted as 0\[char46] The VXLAN GBP draft defines the other bits’ meanings as:

* **D** (Don’t Learn)  
  When set, this bit indicates that the egress tunnel endpoint must not learn the source address of the encapsulated frame\[char46]
* **A** (Applied)  
  When set, indicates that the group policy has already been applied to this packet\[char46] Devices must not apply policies when the A bit is set\[char46]


<a name="erspan-metadata-fields"></a>

### ERSPAN Metadata Fields



These fields provide access to features in the ERSPAN tunneling protocol [ERSPAN], which has two major versions: version 1 (aka type II) and version 2 (aka type III)\[char46]


Regardless of version, ERSPAN is encapsulated within a fixed 8-byte GRE header that consists of a 4-byte GRE base header and a 4-byte sequence number\[char46] The ERSPAN version 1 header format is:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box ". . ." width 0.4
B1: box "type" width 0.4
B2: box "seq" width .4
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"0x88be" at B1.s below
"32" at B2.n above
"" at B2.s below
line &lt;-&gt; "GRE" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "ver" width 0.4
B1: box ". . ." width 0.4
B2: box "session" width 0.5
B3: box ". . ." width 0.4
B4: box "idx" width 0.6
"4" at B0.n above
"1" at B0.s below
"18" at B1.n above
"" at B1.s below
"10" at B2.n above
"tun_id" at B2.s below
"12" at B3.n above
"" at B3.s below
"20" at B4.n above
"" at B4.s below
line &lt;-&gt; "ERSPAN v1" above from B0.nw + (0,textht) to B4.ne + (0,textht)
]
move .1
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL      GRE                ERSPAN v1            Ethernet  
    fL <------------>   <--------------------->   <---------->  
    fL 16    16   32     4  18    10    12  20    48  48   16  
    fL+---+------+---+ +---+---+-------+---+---+ +---+---+----+  
    fL|...| type |seq| |ver|...|session|...|idx| |dst|src|type| ...  
    fL+---+------+---+ +---+---+-------+---+---+ +---+---+----+  
    fL     0x88be        1      tun_id
\}


The ERSPAN version 2 header format is:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box ". . ." width 0.4
B1: box "type" width 0.4
B2: box "seq" width .4
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"0x22eb" at B1.s below
"32" at B2.n above
"" at B2.s below
line &lt;-&gt; "GRE" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "ver" width 0.4
B1: box ". . ." width 0.4
B2: box "session" width 0.5
B3: box "timestamp" width .7
B4: box ". . ." width 0.4
B5: box "hwid" width 0.4
B6: box "dir" width 0.4
B7: box ". . ." width 0.4
"4" at B0.n above
"2" at B0.s below
"18" at B1.n above
"" at B1.s below
"10" at B2.n above
"tun_id" at B2.s below
"32" at B3.n above
"" at B3.s below
"22" at B4.n above
"" at B4.s below
"6" at B5.n above
"" at B5.s below
"1" at B6.n above
"0/1" at B6.s below
"3" at B7.n above
"" at B7.s below
line &lt;-&gt; "ERSPAN v2" above from B0.nw + (0,textht) to B7.ne + (0,textht)
]
move .1
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL      GRE                         ERSPAN v2                      Ethernet  
    fL <------------>   <---------------------------------------->   <---------->  
    fL 16    16   32     4  18    10       32     22   6    1   3    48  48   16  
    fL+---+------+---+ +---+---+-------+---------+---+----+---+---+ +---+---+----+  
    fL|...| type |seq| |ver|...|session|timestamp|...|hwid|dir|...| |dst|src|type| ...  
    fL+---+------+---+ +---+---+-------+---------+---+----+---+---+ +---+---+----+  
    fL     0x22eb        2      tun_id                     0/1
\}


**ERSPAN Version Field**
.TS
tab(;);
l lx.
Name:;**tun\_erspan\_ver**
Width:;8 bits (only the least-significant 4 bits may be nonzero)
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_ET\_ERSPAN\_VER** (12) since Open vSwitch 2.10
T}
.TE


ERSPAN version number: 1 for version 1, or 2 for version 2\[char46]


**ERSPAN Index Field**
.TS
tab(;);
l lx.
Name:;**tun\_erspan\_idx**
Width:;32 bits (only the least-significant 20 bits may be nonzero)
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_ET\_ERSPAN\_IDX** (11) since Open vSwitch 2.10
T}
.TE


This field is a 20-bit index/port number associated with the ERSPAN traffic’s source port and direction (ingress/egress)\[char46] This field is platform dependent\[char46]


**ERSPAN Direction Field**
.TS
tab(;);
l lx.
Name:;**tun\_erspan\_dir**
Width:;8 bits (only the least-significant 1 bits may be nonzero)
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_ET\_ERSPAN\_DIR** (13) since Open vSwitch 2.10
T}
.TE


For ERSPAN v2, the mirrored traffic’s direction: 0 for ingress traffic, 1 for egress traffic\[char46]


**ERSPAN Hardware ID Field**
.TS
tab(;);
l lx.
Name:;**tun\_erspan\_hwid**
Width:;8 bits (only the least-significant 6 bits may be nonzero)
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_ET\_ERSPAN\_HWID** (14) since Open vSwitch 2.10
T}
.TE


A 6-bit unique identifier of an ERSPAN v2 engine within a system\[char46]


<a name="geneve-fields"></a>

### Geneve Fields



These fields provide access to additional features in the Geneve tunneling protocol [Geneve]\[char46] Their names are somewhat generic in the hope that the same fields could be reused for other protocols in the future; for example, the NSH protocol [NSH] supports TLV options whose form is identical to that for Geneve options\[char46]


**Generic Tunnel Option 0 Field**
.TS
tab(;);
l lx.
Name:;**tun\_metadata0**
Width:;992 bits (124 bytes)
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_TUN\_METADATA0** (40) since Open vSwitch 2.5
T}
.TE




The above information specifically covers generic tunnel option 0, but Open vSwitch supports 64 options, numbered 0 through 63, whose NXM field numbers are 40 through 103\[char46]


These fields provide OpenFlow access to the generic type-length-value options defined by the Geneve tunneling protocol or other protocols with options in the same TLV format as Geneve options\[char46] Each of these options has the following wire format:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "class" width 0.6
B1: box "type" width 0.5
B2: box "res" width 0.25
B3: box "length" width 0.4
"16" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"3" at B2.n above
"0" at B2.s below
"5" at B3.n above
"" at B3.s below
line &lt;-&gt; "header" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
[
B0: box "value" width 1.7
"4\[mu](length - 1) bytes" at B0.n above
"" at B0.s below
line &lt;-&gt; "body" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
.PE
\}

.if n \{
    fL        header                 body  
    fL <-------------------> <------------------>  
    fL  16    8    3    5    4[mu](length - 1) bytes  
    fL+-----+----+---+------+--------------------+  
    fL|class|type|res|length|       value        |  
    fL+-----+----+---+------+--------------------+  
    fL             0
\}


Taken together, the **class** and **type** in the option format mean that there are about 16 million distinct kinds of TLV options, too many to give individual OXM code points\[char46] Thus, Open vSwitch requires the user to define the TLV options of interest, by binding up to 64 TLV options to generic tunnel option NXM code points\[char46] Each option may have up to 124 bytes in its body, the maximum allowed by the TLV format, but bound options may total at most 252 bytes of body\[char46]


Open vSwitch extensions to the OpenFlow protocol bind TLV options to NXM code points\[char46] The **ovs-ofctl**(8) program offers one way to use these extensions, e\[char46]g\[char46] to configure a mapping from a TLV option with **class** **0xffff**, **type** **0**, and a body length of 4 bytes:

      
    ovs-ofctl add-tlv-map br0 "{class=0xffff,type=0,len=4}->tun_metadata0"  
          


Once a TLV option is properly bound, it can be accessed and modified like any other field, e\[char46]g\[char46] to send packets that have value 1234 for the option described above to the controller:

      
    ovs-ofctl add-flow br0 tun_metadata0=1234,actions=controller  
          


An option not received or not bound is matched as all zeros\[char46]


































































**Tunnel Flags Field**
.TS
tab(;);
l lx.
Name:;**tun\_flags**
Width:;16 bits (only the least-significant 1 bits may be nonzero)
Format:;tunnel flags
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_TUN\_FLAGS** (104) since Open vSwitch 2.5
T}
.TE




Flags indicating various aspects of the tunnel encapsulation\[char46]


Matches on this field are most conveniently written in terms of symbolic names (given in the diagram below), each preceded by either **+** for a flag that must be set, or **-** for a flag that must be unset, without any other delimiters between the flags\[char46] Flags not mentioned are wildcarded\[char46] For example, **tun\_flags=+oam** matches only OAM packets\[char46] Matches can also be written as **_flags/mask**, where flags_ and _mask_ are 16-bit numbers in decimal or in hexadecimal prefixed by **0x**\[char46]


Currently, only one flag is defined:

* **oam**  
  The tunnel protocol indicated that this is an OAM (Operations and Management) control packet\[char46]


The switch may reject matches against unknown flags\[char46]


Newer versions of Open vSwitch may introduce additional flags with new meanings\[char46] It is therefore not recommended to use an exact match on this field since the behavior of these new flags is unknown and should be ignored\[char46]


For non-tunneled packets, the value is 0\[char46]
.bp

<a name="metadata-fields"></a>

# Metadata Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**in\_port**;2;no;yes;none;OVS 1.1+
**in\_port\_oxm**;4;no;yes;none;OF 1.2+ and OVS 1.7+
**skb\_priority**;4;no;no;none;
**pkt\_mark**;4;yes;yes;none;OVS 2.0+
**actset\_output**;4;no;no;none;OF 1.3+ and OVS 2.4+
**packet\_type**;4;no;no;none;OF 1.5+ and OVS 2.8+
.TE


These fields relate to the origin or treatment of a packet, but they are not extracted from the packet data itself\[char46]


**Ingress Port Field**
.TS
tab(;);
l lx.
Name:;**in\_port**
Width:;16 bits
Format:;OpenFlow 1.0 port
Masking:;not maskable
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
none
T}
NXM:;T{
**NXM\_OF\_IN\_PORT** (0) since Open vSwitch 1.1
T}
.TE




The OpenFlow port on which the packet being processed arrived\[char46] This is a 16-bit field that holds an OpenFlow 1\[char46]0 port number\[char46] For receiving a packet, the only values that appear in this field are:

* 1 through **0xfeff** (65,279), inclusive\[char46]  
  Conventional OpenFlow port numbers\[char46]
* **OFPP\_LOCAL** (**0xfffe** or 65,534)\[char46]  
  The \`\`local’’ port, which in Open vSwitch is always named the same as the bridge itself\[char46] This represents a connection between the switch and the local TCP/IP stack\[char46] This port is where an IP address is most commonly configured on an Open vSwitch switch\[char46]
* OpenFlow does not require a switch to have a local port, but all existing versions of Open vSwitch have always included a local port\[char46] **Future Directions:** Future versions of Open vSwitch might be able to optionally omit the local port, if someone submits code to implement such a feature\[char46]
* **OFPP\_NONE** (OpenFlow 1\[char46]0) or **OFPP\_ANY** (OpenFlow 1\[char46]1+) (**0xffff** or 65,535)\[char46]  
  .TQ .5in
  **OFPP\_CONTROLLER** (**0xfffd** or 65,533)\[char46]
  When a controller injects a packet into an OpenFlow switch with a \`\`packet-out’’ request, it can specify one of these ingress ports to indicate that the packet was generated internally rather than having been received on some port\[char46]
* OpenFlow 1\[char46]0 specified **OFPP\_NONE** for this purpose\[char46] Despite that, some controllers used **OFPP\_CONTROLLER**, and some switches only accepted **OFPP\_CONTROLLER**, so OpenFlow 1\[char46]0\[char46]2 required support for both ports\[char46] OpenFlow 1\[char46]1 and later were more clearly drafted to allow only **OFPP\_CONTROLLER**\[char46] For maximum compatibility, Open vSwitch allows both ports with all OpenFlow versions\[char46]


Values not mentioned above will never appear when receiving a packet, including the following notable values:

* 0  
  Zero is not a valid OpenFlow port number\[char46]
* **OFPP\_MAX** (**0xff00** or 65,280)\[char46]  
  This value has only been clearly specified as a valid port number as of OpenFlow 1\[char46]3\[char46]3\[char46] Before that, its status was unclear, and so Open vSwitch has never allowed **OFPP\_MAX** to be used as a port number, so packets will never be received on this port\[char46] (Other OpenFlow switches, of course, might use it\[char46])
* **OFPP\_UNSET** (**0xfff7** or 65,527)  
  .TQ .5in
  **OFPP\_IN\_PORT** (**0xfff8** or 65,528)
  .TQ .5in
  **OFPP\_TABLE** (**0xfff9** or 65,529)
  .TQ .5in
  **OFPP\_NORMAL** (**0xfffa** or 65,530)
  .TQ .5in
  **OFPP\_FLOOD** (**0xfffb** or 65,531)
  .TQ .5in
  **OFPP\_ALL** (**0xfffc** or 65,532)
  These port numbers are used only in output actions and never appear as ingress ports\[char46]
* Most of these port numbers were defined in OpenFlow 1\[char46]0, but **OFPP\_UNSET** was only introduced in OpenFlow 1\[char46]5\[char46]


Values that will never appear when receiving a packet may still be matched against in the flow table\[char46] There are still circumstances in which those flows can be matched:

* ·  
  The **resubmit** Open vSwitch extension action allows a flow table lookup with an arbitrary ingress port\[char46]
* ·  
  An action that modifies the ingress port field (see below), such as e\[char46]g\[char46] **load** or **set\_field**, followed by an action or instruction that performs another flow table lookup, such as **resubmit** or **goto\_table**\[char46]


This field is heavily used for matching in OpenFlow tables, but for packet egress, it has only very limited roles:

* ·  
  OpenFlow requires suppressing output actions to **in\_port**\[char46] That is, the following two flows both drop all packets that arrive on port 1:
*       
    in_port=1,actions=1  
    in_port=1,actions=drop  
              
* (This behavior is occasionally useful for flooding to a subset of ports\[char46] Specifying **actions=1,2,3,4**, for example, outputs to ports 1, 2, 3, and 4, omitting the ingress port\[char46])
* ·  
  OpenFlow has a special port **OFPP\_IN\_PORT** (with value 0xfff8) that outputs to the ingress port\[char46] For example, in a switch that has four ports numbered 1 through 4, **actions=1,2,3,4,in\_port** outputs to ports 1, 2, 3, and 4, including the ingress port\[char46]


Because the ingress port field has so little influence on packet processing, it does not ordinarily make sense to modify the ingress port field\[char46] The field is writable only to support the occasional use case where the ingress port’s roles in packet egress, described above, become troublesome\[char46] For example, **actions=load:0-&gt;NXM\_OF\_IN\_PORT[],output:123** will output to port 123 regardless of whether it is in the ingress port\[char46] If the ingress port is important, then one may save and restore it on the stack:

      
    actions=push:NXM_OF_IN_PORT[],load:0->NXM_OF_IN_PORT[],output:123,pop:NXM_OF_IN_PORT[]  
          


or, in Open vSwitch 2\[char46]7 or later, use the **clone** action to save and restore it:

      
    actions=clone(load:0->NXM_OF_IN_PORT[],output:123)  
          


The ability to modify the ingress port is an Open vSwitch extension to OpenFlow\[char46]


**OXM Ingress Port Field**
.TS
tab(;);
l lx.
Name:;**in\_port\_oxm**
Width:;32 bits
Format:;OpenFlow 1.1+ port
Masking:;not maskable
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_IN\_PORT** (0) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
none
T}
.TE




OpenFlow 1\[char46]1 and later use a 32-bit port number, so this field supplies a 32-bit view of the ingress port\[char46] Current versions of Open vSwitch support only a 16-bit range of ports:

* ·  
  OpenFlow 1\[char46]0 ports **0x0000** to **0xfeff**, inclusive, map to OpenFlow 1\[char46]1 port numbers with the same values\[char46]
* ·  
  OpenFlow 1\[char46]0 ports **0xff00** to **0xffff**, inclusive, map to OpenFlow 1\[char46]1 port numbers **0xffffff00** to **0xffffffff**\[char46]
* ·  
  OpenFlow 1\[char46]1 ports **0x0000ff00** to **0xfffffeff** are not mapped and not supported\[char46]


**in\_port** and **in\_port\_oxm** are two views of the same information, so all of the comments on **in\_port** apply to **in\_port\_oxm** too\[char46] Modifying **in\_port** changes **in\_port\_oxm**, and vice versa\[char46]


Setting **in\_port\_oxm** to an unsupported value yields unspecified behavior\[char46]


**Output Queue Field**
.TS
tab(;);
l lx.
Name:;**skb\_priority**
Width:;32 bits
Format:;hexadecimal
Masking:;not maskable
Prerequisites:;none
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
none
T}
.TE




**Future Directions:** Open vSwitch implements the output queue as a field, but does not currently expose it through OXM or NXM for matching purposes\[char46] If this turns out to be a useful feature, it could be implemented in future versions\[char46] Only the **set\_queue**, **enqueue**, and **pop\_queue** actions currently influence the output queue\[char46]


This field influences how packets in the flow will be queued, for quality of service (QoS) purposes, when they egress the switch\[char46] Its range of meaningful values, and their meanings, varies greatly from one OpenFlow implementation to another\[char46] Even within a single implementation, there is no guarantee that all OpenFlow ports have the same queues configured or that all OpenFlow ports in an implementation can be configured the same way queue-wise\[char46]


Configuring queues on OpenFlow is not well standardized\[char46] On Linux, Open vSwitch supports queue configuration via OVSDB, specifically the **QoS** and **Queue** tables (see **ovs-vswitchd\[char46]conf\[char46]db(5)** for details)\[char46] Ports of Open vSwitch to other platforms might require queue configuration through some separate protocol (such as a CLI)\[char46] Even on Linux, Open vSwitch exposes only a fraction of the kernel’s queuing features through OVSDB, so advanced or unusual uses might require use of separate utilities (e\[char46]g\[char46] **tc**)\[char46] OpenFlow switches other than Open vSwitch might use OF-CONFIG or any of the configuration methods mentioned above\[char46] Finally, some OpenFlow switches have a fixed number of fixed-function queues (e\[char46]g\[char46] eight queues with strictly defined priorities) and others do not support any control over queuing\[char46]


The only output queue that all OpenFlow implementations must support is zero, to identify a default queue, whose properties are implementation-defined\[char46] Outputting a packet to a queue that does not exist on the output port yields unpredictable behavior: among the possibilities are that the packet might be dropped or transmitted with a very high or very low priority\[char46]


OpenFlow 1\[char46]0 only allowed output queues to be specified as part of an **enqueue** action that specified both a queue and an output port\[char46] That is, OpenFlow 1\[char46]0 treats the queue as an argument to an action, not as a field\[char46]


To increase flexibility, OpenFlow 1\[char46]1 added an action to set the output queue\[char46] This model was carried forward, without change, through OpenFlow 1\[char46]5\[char46]


Open vSwitch implements the native queuing model of each OpenFlow version it supports\[char46] Open vSwitch also includes an extension for setting the output queue as an action in OpenFlow 1\[char46]0\[char46]


When a packet ingresses into an OpenFlow switch, the output queue is ordinarily set to 0, indicating the default queue\[char46] However, Open vSwitch supports various ways to forward a packet from one OpenFlow switch to another within a single host\[char46] In these cases, Open vSwitch maintains the output queue across the forwarding step\[char46] For example:

* ·  
  A hop across an Open vSwitch \`\`patch port’’ (which does not actually involve queuing) preserves the output queue\[char46]
* ·  
  When a flow sets the output queue then outputs to an OpenFlow tunnel port, the encapsulation preserves the output queue\[char46] If the kernel TCP/IP stack routes the encapsulated packet directly to a physical interface, then that output honors the output queue\[char46] Alternatively, if the kernel routes the encapsulated packet to another Open vSwitch bridge, then the output queue set previously becomes the initial output queue on ingress to the second bridge and will thus be used for further output actions (unless overridden by a new \`\`set queue’’ action)\[char46]
* (This description reflects the current behavior of Open vSwitch on Linux\[char46] This behavior relies on details of the Linux TCP/IP stack\[char46] It could be difficult to make ports to other operating systems behave the same way\[char46])


**Packet Mark Field**
.TS
tab(;);
l lx.
Name:;**pkt\_mark**
Width:;32 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_PKT\_MARK** (33) since Open vSwitch 2.0
T}
.TE




Packet mark comes to Open vSwitch from the Linux kernel, in which the **sk\_buff** data structure that represents a packet contains a 32-bit member named **skb\_mark**\[char46] The value of **skb\_mark** propagates along with the packet it accompanies wherever the packet goes in the kernel\[char46] It has no predefined semantics but various kernel-user interfaces can set and match on it, which makes it suitable for \`\`marking’’ packets at one point in their handling and then acting on the mark later\[char46] With **iptables**, for example, one can mark some traffic specially at ingress and then handle that traffic differently at egress based on the marked value\[char46]


Packet mark is an attempt at a generalization of the **skb\_mark** concept beyond Linux, at least through more generic naming\[char46] Like **skb\_priority**, packet mark is preserved across forwarding steps within a machine\[char46] Unlike **skb\_priority**, packet mark has no direct effect on packet forwarding: the value set in packet mark does not matter unless some later OpenFlow table or switch matches on packet mark, or unless the packet passes through some other kernel subsystem that has been configured to interpret packet mark in specific ways, e\[char46]g\[char46] through **iptables** configuration mentioned above\[char46]


Preserving packet mark across kernel forwarding steps relies heavily on kernel support, which ports to non-Linux operating systems may not have\[char46] Regardless of operating system support, Open vSwitch supports packet mark within a single bridge and across patch ports\[char46]


The value of packet mark when a packet ingresses into the first Open vSwich bridge is typically zero, but it could be nonzero if its value was previously set by some kernel subsystem\[char46]


**Action Set Output Port Field**
.TS
tab(;);
l lx.
Name:;**actset\_output**
Width:;32 bits
Format:;OpenFlow 1.1+ port
Masking:;not maskable
Prerequisites:;none
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**ONFOXM\_ET\_ACTSET\_OUTPUT** (43) since OpenFlow 1.3 and Open vSwitch 2.4\[char59] **OXM\_OF\_ACTSET\_OUTPUT** (43) since OpenFlow 1.5 and Open vSwitch 2.4
T}
NXM:;T{
none
T}
.TE




Holds the output port currently in the OpenFlow action set (i\[char46]e\[char46] from an **output** action within a **write\_actions** instruction)\[char46] Its value is an OpenFlow port number\[char46] If there is no output port in the OpenFlow action set, or if the output port will be ignored (e\[char46]g\[char46] because there is an output group in the OpenFlow action set), then the value will be **OFPP\_UNSET**\[char46]


Open vSwitch allows any table to match this field\[char46] OpenFlow, however, only requires this field to be matchable from within an OpenFlow egress table (a feature that Open vSwitch does not yet implement)\[char46]




**Packet Type Field**
.TS
tab(;);
l lx.
Name:;**packet\_type**
Width:;32 bits
Format:;packet type
Masking:;not maskable
Prerequisites:;none
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_PACKET\_TYPE** (44) since OpenFlow 1.5 and Open vSwitch 2.8
T}
NXM:;T{
none
T}
.TE




The type of the packet in the format specified in OpenFlow 1\[char46]5:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "ns" width .75
B1: box "ns_type" width .75
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"" at B1.s below
line &lt;-&gt; "Packet type" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL Packet type  
    fL <--------->  
    fL 16    16  
    fL+---+-------+  
    fL|ns |ns_type| ...  
    fL+---+-------+  
    fL
\}


The upper 16 bits, _ns_, are a namespace\[char46] The meaning of _ns\_type_ depends on the namespace\[char46] The packet type field is specified and displayed in the format **(ns,ns\_type)**\[char46]


Open vSwitch currently supports the following classes of packet types for matching:

* **(0,0)**  
  Ethernet\[char46]
* **(1,ethertype)**  
  The specified _ethertype_\[char46] Open vSwitch can forward packets with any _ethertype_, but it can only match on and process data fields for the following supported packet types:
    * **(1,0x800)**  
      IPv4
    * **(1,0x806)**  
      ARP
    * **(1,0x86dd)**  
      IPv6
    * **(1,0x8847)**  
      MPLS
    * **(1,0x8848)**  
      MPLS multicast
    * **(1,0x8035)**  
      RARP
    * **(1,0x894f)**  
      NSH


Consider the distinction between a packet with packet_type=(0,0),
dl\_type=0x800 and one with **packet\_type=(1,0x800)**\[char46] The former is an Ethernet frame that contains an IPv4 packet, like this:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.4
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4  
    fL <----------->   <--------------->  
    fL 48  48   16           8   32  32  
    fL+---+---+-----+ +---+-----+---+---+  
    fL|dst|src|type | |...|proto|src|dst| ...  
    fL+---+---+-----+ +---+-----+---+---+  
    fL         0x800
\}


The latter is an IPv4 packet not encapsulated inside any outer frame, like this:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.4
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL       IPv4  
    fL <--------------->  
    fL       8   32  32  
    fL+---+-----+---+---+  
    fL|...|proto|src|dst| ...  
    fL+---+-----+---+---+  
    fL
\}


Matching on **packet\_type** is a pre-requisite for matching on any data field, but for backward compatibility, when a match on a data field is present without a **packet\_type** match, Open vSwitch acts as though a match on **(0,0)** (Ethernet) had been supplied\[char46] Similarly, when Open vSwitch sends flow match information to a controller, e\[char46]g\[char46] in a reply to a request to dump the flow table, Open vSwitch omits a match on packet type (0,0) if it would be implied by a data field match\[char46]
.bp

<a name="connection-tracking-fields"></a>

# Connection Tracking Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**ct\_state**;4;yes;no;none;OVS 2.5+
**ct\_zone**;2;no;no;none;OVS 2.5+
**ct\_mark**;4;yes;yes;none;OVS 2.5+
**ct\_label**;16;yes;yes;none;OVS 2.5+
**ct\_nw\_src**;4;yes;no;CT;OVS 2.8+
**ct\_nw\_dst**;4;yes;no;CT;OVS 2.8+
**ct\_ipv6\_src**;16;yes;no;CT;OVS 2.8+
**ct\_ipv6\_dst**;16;yes;no;CT;OVS 2.8+
**ct\_nw\_proto**;1;no;no;CT;OVS 2.8+
**ct\_tp\_src**;2;yes;no;CT;OVS 2.8+
**ct\_tp\_dst**;2;yes;no;CT;OVS 2.8+
.TE


Open vSwitch 2\[char46]5 and later support \`\`connection tracking,’’ which allows bidirectional streams of packets to be statefully grouped into connections\[char46] Open vSwitch connection tracking, for example, identifies the patterns of TCP packets that indicates a successfully initiated connection, as well as those that indicate that a connection has been torn down\[char46] Open vSwitch connection tracking can also identify related connections, such as FTP data connections spawned from FTP control connections\[char46]


An individual packet passing through the pipeline may be in one of two states, \`\`untracked’’ or \`\`tracked,’’ which may be distinguished via the \`\`trk’’ flag in **ct\_state**\[char46] A packet is _untracked_ at the beginning of the Open vSwitch pipeline and continues to be untracked until the pipeline invokes the **ct** action\[char46] The connection tracking fields are all zeroes in an untracked packet\[char46] When a flow in the Open vSwitch pipeline invokes the **ct** action, the action initializes the connection tracking fields and the packet becomes _tracked_ for the remainder of its processing\[char46]


The connection tracker stores connection state in an internal table, but it only adds a new entry to this table when a **ct** action for a new connection invokes **ct** with the **commit** parameter\[char46] For a given connection, when a pipeline has executed **ct**, but not yet with **commit**, the connection is said to be _uncommitted_\[char46] State for an uncommitted connection is ephemeral and does not persist past the end of the pipeline, so some features are only available to committed connections\[char46] A connection would typically be left uncommitted as a way to drop its packets\[char46]


Connection tracking is an Open vSwitch extension to OpenFlow\[char46]


**Connection Tracking State Field**
.TS
tab(;);
l lx.
Name:;**ct\_state**
Width:;32 bits
Format:;ct state
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_STATE** (105) since Open vSwitch 2.5
T}
.TE




This field holds several flags that can be used to determine the state of the connection to which the packet belongs\[char46]


Matches on this field are most conveniently written in terms of symbolic names (listed below), each preceded by either **+** for a flag that must be set, or **-** for a flag that must be unset, without any other delimiters between the flags\[char46] Flags not mentioned are wildcarded\[char46] For example, **tcp,ct\_state=+trk-new** matches TCP packets that have been run through the connection tracker and do not establish a new connection\[char46] Matches can also be written as **_flags/mask**, where flags_ and _mask_ are 32-bit numbers in decimal or in hexadecimal prefixed by **0x**\[char46]


The following flags are defined:

* **new** (0x01)  
  A new connection\[char46] Set to 1 if this is an uncommitted connection\[char46]
* **est** (0x02)  
  Part of an existing connection\[char46] Set to 1 if this is a committed connection\[char46]
* **rel** (0x04)  
  Related to an existing connection, e\[char46]g\[char46] an ICMP \`\`destination unreachable’’ message or an FTP data connections\[char46] This flag will only be 1 if the connection to which this one is related is committed\[char46]
* Connections identified as **rel** are separate from the originating connection and must be committed separately\[char46] All packets for a related connection will have the **rel** flag set, not just the initial packet\[char46]
* **rpl** (0x08)  
  This packet is in the reply direction, meaning that it is in the opposite direction from the packet that initiated the connection\[char46] This flag will only be 1 if the connection is committed\[char46]
* **inv** (0x10)  
  The state is invalid, meaning that the connection tracker couldn’t identify the connection\[char46] This flag is a catch-all for problems in the connection or the connection tracker, such as:
    * ·  
      L3/L4 protocol handler is not loaded/unavailable\[char46] With the Linux kernel datapath, this may mean that the **nf\_conntrack\_ipv4** or **nf\_conntrack\_ipv6** modules are not loaded\[char46]
    * ·  
      L3/L4 protocol handler determines that the packet is malformed\[char46]
    * ·  
      Packets are unexpected length for protocol\[char46]
* **trk** (0x20)  
  This packet is tracked, meaning that it has previously traversed the connection tracker\[char46] If this flag is not set, then no other flags will be set\[char46] If this flag is set, then the packet is tracked and other flags may also be set\[char46]
* **snat** (0x40)  
  This packet was transformed by source address/port translation by a preceding **ct** action\[char46] Open vSwitch 2\[char46]6 added this flag\[char46]
* **dnat** (0x80)  
  This packet was transformed by destination address/port translation by a preceding **ct** action\[char46] Open vSwitch 2\[char46]6 added this flag\[char46]


There are additional constraints on these flags, listed in decreasing order of precedence below:

* 1.  
  If **trk** is unset, no other flags are set\[char46]
* 2.  
  If **trk** is set, one or more other flags may be set\[char46]
* 3.  
  If **inv** is set, only the **trk** flag is also set\[char46]
* 4.  
  **new** and **est** are mutually exclusive\[char46]
* 5.  
  **new** and **rpl** are mutually exclusive\[char46]
* 6.  
  **rel** may be set in conjunction with any other flags\[char46]


Future versions of Open vSwitch may define new flags\[char46]


**Connection Tracking Zone Field**
.TS
tab(;);
l lx.
Name:;**ct\_zone**
Width:;16 bits
Format:;hexadecimal
Masking:;not maskable
Prerequisites:;none
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_ZONE** (106) since Open vSwitch 2.5
T}
.TE


A connection tracking zone, the zone value passed to the most recent **ct** action\[char46] Each zone is an independent connection tracking context, so tracking the same packet in multiple contexts requires using the **ct** action multiple times\[char46]


**Connection Tracking Mark Field**
.TS
tab(;);
l lx.
Name:;**ct\_mark**
Width:;32 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_MARK** (107) since Open vSwitch 2.5
T}
.TE


The metadata committed, by an action within the **exec** parameter to the **ct** action, to the connection to which the current packet belongs\[char46]


**Connection Tracking Label Field**
.TS
tab(;);
l lx.
Name:;**ct\_label**
Width:;128 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_LABEL** (108) since Open vSwitch 2.5
T}
.TE


The label committed, by an action within the **exec** parameter to the **ct** action, to the connection to which the current packet belongs\[char46]


Open vSwitch 2\[char46]8 introduced the matching support for connection tracker original direction 5-tuple fields\[char46]


For non-committed non-related connections the conntrack original direction tuple fields always have the same values as the corresponding headers in the packet itself\[char46] For any other packets of a committed connection the conntrack original direction tuple fields reflect the values from that initial non-committed non-related packet, and thus may be different from the actual packet headers, as the actual packet headers may be in reverse direction (for reply packets), transformed by NAT (when **nat** option was applied to the connection), or be of different protocol (i\[char46]e\[char46], when an ICMP response is sent to an UDP packet)\[char46] In case of related connections, e\[char46]g\[char46], an FTP data connection, the original direction tuple contains the original direction headers from the master connection, e\[char46]g\[char46], an FTP control connection\[char46]


The following fields are populated by the ct action, and require a match to a valid connection tracking state as a prerequisite, in addition to the IP or IPv6 ethertype match\[char46] Examples of valid connection tracking state matches include **ct\_state=+new**, **ct\_state=+est**, **ct\_state=+rel**, and **ct\_state=+trk-inv**\[char46]


**Connection Tracking Original Direction IPv4 Source Address Field**
.TS
tab(;);
l lx.
Name:;**ct\_nw\_src**
Width:;32 bits
Format:;IPv4
Masking:;arbitrary bitwise masks
Prerequisites:;CT
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_NW\_SRC** (120) since Open vSwitch 2.8
T}
.TE


Matches IPv4 conntrack original direction tuple source address\[char46] See the paragraphs above for general description to the conntrack original direction tuple\[char46] Introduced in Open vSwitch 2\[char46]8\[char46]


**Connection Tracking Original Direction IPv4 Destination Address Field**
.TS
tab(;);
l lx.
Name:;**ct\_nw\_dst**
Width:;32 bits
Format:;IPv4
Masking:;arbitrary bitwise masks
Prerequisites:;CT
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_NW\_DST** (121) since Open vSwitch 2.8
T}
.TE


Matches IPv4 conntrack original direction tuple destination address\[char46] See the paragraphs above for general description to the conntrack original direction tuple\[char46] Introduced in Open vSwitch 2\[char46]8\[char46]


**Connection Tracking Original Direction IPv6 Source Address Field**
.TS
tab(;);
l lx.
Name:;**ct\_ipv6\_src**
Width:;128 bits
Format:;IPv6
Masking:;arbitrary bitwise masks
Prerequisites:;CT
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_IPV6\_SRC** (122) since Open vSwitch 2.8
T}
.TE


Matches IPv6 conntrack original direction tuple source address\[char46] See the paragraphs above for general description to the conntrack original direction tuple\[char46] Introduced in Open vSwitch 2\[char46]8\[char46]


**Connection Tracking Original Direction IPv6 Destination Address Field**
.TS
tab(;);
l lx.
Name:;**ct\_ipv6\_dst**
Width:;128 bits
Format:;IPv6
Masking:;arbitrary bitwise masks
Prerequisites:;CT
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_IPV6\_DST** (123) since Open vSwitch 2.8
T}
.TE


Matches IPv6 conntrack original direction tuple destination address\[char46] See the paragraphs above for general description to the conntrack original direction tuple\[char46] Introduced in Open vSwitch 2\[char46]8\[char46]


**Connection Tracking Original Direction IP Protocol Field**
.TS
tab(;);
l lx.
Name:;**ct\_nw\_proto**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;CT
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_NW\_PROTO** (119) since Open vSwitch 2.8
T}
.TE


Matches conntrack original direction tuple IP protocol type, which is specified as a decimal number between 0 and 255, inclusive (e\[char46]g\[char46] 1 to match ICMP packets or 6 to match TCP packets)\[char46] In case of, for example, an ICMP response to an UDP packet, this may be different from the IP protocol type of the packet itself\[char46] See the paragraphs above for general description to the conntrack original direction tuple\[char46] Introduced in Open vSwitch 2\[char46]8\[char46]


**Connection Tracking Original Direction Transport Layer Source Port Field**
.TS
tab(;);
l lx.
Name:;**ct\_tp\_src**
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;CT
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_TP\_SRC** (124) since Open vSwitch 2.8
T}
.TE


Bitwise match on the conntrack original direction tuple transport source, when **MFF\_CT\_NW\_PROTO** has value 6 for TCP, 17 for UDP, or 132 for SCTP\[char46] When **MFF\_CT\_NW\_PROTO** has value 1 for ICMP, or 58 for ICMPv6, the lower 8 bits of **MFF\_CT\_TP\_SRC** matches the conntrack original direction ICMP type\[char46] See the paragraphs above for general description to the conntrack original direction tuple\[char46] Introduced in Open vSwitch 2\[char46]8\[char46]


**Connection Tracking Original Direction Transport Layer Source Port Field**
.TS
tab(;);
l lx.
Name:;**ct\_tp\_dst**
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;CT
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_CT\_TP\_DST** (125) since Open vSwitch 2.8
T}
.TE


Bitwise match on the conntrack original direction tuple transport destination port, when **MFF\_CT\_NW\_PROTO** has value 6 for TCP, 17 for UDP, or 132 for SCTP\[char46] When **MFF\_CT\_NW\_PROTO** has value 1 for ICMP, or 58 for ICMPv6, the lower 8 bits of **MFF\_CT\_TP\_DST** matches the conntrack original direction ICMP code\[char46] See the paragraphs above for general description to the conntrack original direction tuple\[char46] Introduced in Open vSwitch 2\[char46]8\[char46]
.bp

<a name="register-fields"></a>

# Register Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**metadata**;8;yes;yes;none;OF 1.2+ and OVS 1.8+
**reg0**;4;yes;yes;none;OVS 1.1+
**reg1**;4;yes;yes;none;OVS 1.1+
**reg2**;4;yes;yes;none;OVS 1.1+
**reg3**;4;yes;yes;none;OVS 1.1+
**reg4**;4;yes;yes;none;OVS 1.3+
**reg5**;4;yes;yes;none;OVS 1.7+
**reg6**;4;yes;yes;none;OVS 1.7+
**reg7**;4;yes;yes;none;OVS 1.7+
**reg8**;4;yes;yes;none;OVS 2.6+
**reg9**;4;yes;yes;none;OVS 2.6+
**reg10**;4;yes;yes;none;OVS 2.6+
**reg11**;4;yes;yes;none;OVS 2.6+
**reg12**;4;yes;yes;none;OVS 2.6+
**reg13**;4;yes;yes;none;OVS 2.6+
**reg14**;4;yes;yes;none;OVS 2.6+
**reg15**;4;yes;yes;none;OVS 2.6+
**xreg0**;8;yes;yes;none;OF 1.3+ and OVS 2.4+
**xreg1**;8;yes;yes;none;OF 1.3+ and OVS 2.4+
**xreg2**;8;yes;yes;none;OF 1.3+ and OVS 2.4+
**xreg3**;8;yes;yes;none;OF 1.3+ and OVS 2.4+
**xreg4**;8;yes;yes;none;OF 1.3+ and OVS 2.4+
**xreg5**;8;yes;yes;none;OF 1.3+ and OVS 2.4+
**xreg6**;8;yes;yes;none;OF 1.3+ and OVS 2.4+
**xreg7**;8;yes;yes;none;OF 1.3+ and OVS 2.4+
**xxreg0**;16;yes;yes;none;OVS 2.6+
**xxreg1**;16;yes;yes;none;OVS 2.6+
**xxreg2**;16;yes;yes;none;OVS 2.6+
**xxreg3**;16;yes;yes;none;OVS 2.6+
.TE


These fields give an OpenFlow switch space for temporary storage while the pipeline is running\[char46] Whereas metadata fields can have a meaningful initial value and can persist across some hops across OpenFlow switches, registers are always initially 0 and their values never persist across inter-switch hops (not even across patch ports)\[char46]


**OpenFlow Metadata Field**
.TS
tab(;);
l lx.
Name:;**metadata**
Width:;64 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;yes
OXM:;T{
**OXM\_OF\_METADATA** (2) since OpenFlow 1.2 and Open vSwitch 1.8
T}
NXM:;T{
none
T}
.TE




This field is the oldest standardized OpenFlow register field, introduced in OpenFlow 1\[char46]1\[char46] It was introduced to model the limited number of user-defined bits that some ASIC-based switches can carry through their pipelines\[char46] Because of hardware limitations, OpenFlow allows switches to support writing and masking only an implementation-defined subset of bits, even no bits at all\[char46] The Open vSwitch software switch always supports all 64 bits, but of course an Open vSwitch port to an ASIC would have the same restriction as the ASIC itself\[char46]


This field has an OXM code point, but OpenFlow 1\[char46]4 and earlier allow it to be modified only with a specialized instruction, not with a \`\`set-field’’ action\[char46] OpenFlow 1\[char46]5 removes this restriction\[char46] Open vSwitch does not enforce this restriction, regardless of OpenFlow version\[char46]


**Register 0 Field**
.TS
tab(;);
l lx.
Name:;**reg0**
Width:;32 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_REG0** (0) since Open vSwitch 1.1
T}
.TE


This is the first of several Open vSwitch registers, all of which have the same properties\[char46] Open vSwitch 1\[char46]1 introduced registers 0, 1, 2, and 3, version 1\[char46]3 added register 4, version 1\[char46]7 added registers 5, 6, and 7, and version 2\[char46]6 added registers 8 through 15\[char46]


















**Extended Register 0 Field**
.TS
tab(;);
l lx.
Name:;**xreg0**
Width:;64 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_PKT\_REG0** (0) since OpenFlow 1.3 and Open vSwitch 2.4
T}
NXM:;T{
none
T}
.TE




This is the first of the registers introduced in OpenFlow 1\[char46]5\[char46] OpenFlow 1\[char46]5 calls these fields just the \`\`packet registers,’’ but Open vSwitch already had 32-bit registers by that name, so Open vSwitch uses the name \`\`extended registers’’ in an attempt to reduce confusion\[char46] The standard allows for up to 128 registers, each 64 bits wide, but Open vSwitch only implements 4 (in versions 2\[char46]4 and 2\[char46]5) or 8 (in version 2\[char46]6 and later)\[char46]


Each of the 64-bit extended registers overlays two of the 32-bit registers: **xreg0** overlays **reg0** and **reg1**, with **reg0** supplying the most-significant bits of **xreg0** and **reg1** the least-significant\[char46] Similarly, **xreg1** overlays **reg2** and **reg3**, and so on\[char46]


The OpenFlow specification says, \`\`In most cases, the packet registers can not be matched in tables, i\[char46]e\[char46] they usually can not be used in the flow entry match structure’’ [OpenFlow 1\[char46]5, section 7\[char46]2\[char46]3\[char46]10], but there is no reason for a software switch to impose such a restriction, and Open vSwitch does not\[char46]










**Double-Extended Register 0 Field**
.TS
tab(;);
l lx.
Name:;**xxreg0**
Width:;128 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;none
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_XXREG0** (111) since Open vSwitch 2.6
T}
.TE




This is the first of the double-extended registers introduce in Open vSwitch 2\[char46]6\[char46] Each of the 128-bit extended registers overlays four of the 32-bit registers: **xxreg0** overlays **reg0** through **reg3**, with **reg0** supplying the most-significant bits of **xxreg0** and **reg3** the least-significant\[char46] **xxreg1** similarly overlays **reg4** through **reg7**, and so on\[char46]
.bp

<a name="layer-2-ethernet-fields"></a>

# Layer 2 (Ethernet) Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**eth\_src** aka **dl\_src**;6;yes;yes;Ethernet;OF 1.2+ and OVS 1.1+
**eth\_dst** aka **dl\_dst**;6;yes;yes;Ethernet;OF 1.2+ and OVS 1.1+
**eth\_type** aka **dl\_type**;2;no;no;Ethernet;OF 1.2+ and OVS 1.1+
.TE


Ethernet is the only layer-2 protocol that Open vSwitch supports\[char46] As with most software, Open vSwitch and OpenFlow regard an Ethernet frame to begin with the 14-byte header and end with the final byte of the payload; that is, the frame check sequence is not considered part of the frame\[char46]


**Ethernet Source Field**
.TS
tab(;);
l lx.
Name:;**eth\_src** (aka **dl\_src**)
Width:;48 bits
Format:;Ethernet
Masking:;arbitrary bitwise masks
Prerequisites:;Ethernet
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes
OXM:;T{
**OXM\_OF\_ETH\_SRC** (4) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_ETH\_SRC** (2) since Open vSwitch 1.1
T}
.TE




The Ethernet source address:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width .75
B1: box "src" width .75 fill
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet  
    fL <---------->  
    fL 48  48   16  
    fL+---+---+----+  
    fL|dst|src|type| ...  
    fL+---+---+----+  
    fL
\}


**Ethernet Destination Field**
.TS
tab(;);
l lx.
Name:;**eth\_dst** (aka **dl\_dst**)
Width:;48 bits
Format:;Ethernet
Masking:;arbitrary bitwise masks
Prerequisites:;Ethernet
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes
OXM:;T{
**OXM\_OF\_ETH\_DST** (3) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_ETH\_DST** (1) since Open vSwitch 1.1
T}
.TE




The Ethernet destination address:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width .75 fill
B1: box "src" width .75
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet  
    fL <---------->  
    fL 48  48   16  
    fL+---+---+----+  
    fL|dst|src|type| ...  
    fL+---+---+----+  
    fL
\}


Open vSwitch 1\[char46]8 and later support arbitrary masks for source and/or destination\[char46] Earlier versions only support masking the destination with the following masks:

* **01:00:00:00:00:00**  
  Match only the multicast bit\[char46] Thus, **dl\_dst=01:00:00:00:00:00/01:00:00:00:00:00** matches all multicast (including broadcast) Ethernet packets, and **dl\_dst=00:00:00:00:00:00/01:00:00:00:00:00** matches all unicast Ethernet packets\[char46]
* **fe:ff:ff:ff:ff:ff**  
  Match all bits except the multicast bit\[char46] This is probably not useful\[char46]
* **ff:ff:ff:ff:ff:ff**  
  Exact match (equivalent to omitting the mask)\[char46]
* **00:00:00:00:00:00**  
  Wildcard all bits (equivalent to **dl\_dst=***)\[char46]


**Ethernet Type Field**
.TS
tab(;);
l lx.
Name:;**eth\_type** (aka **dl\_type**)
Width:;16 bits
Format:;hexadecimal
Masking:;not maskable
Prerequisites:;Ethernet
Access:;read-only
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_ETH\_TYPE** (5) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_ETH\_TYPE** (3) since Open vSwitch 1.1
T}
.TE




The most commonly seen Ethernet frames today use a format called \`\`Ethernet II,’’ in which the last two bytes of the Ethernet header specify the Ethertype\[char46] For such a frame, this field is copied from those bytes of the header, like so:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width .75
B1: box "src" width .75
B2: box "type" width 0.4 fill
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"\[&gt;=]0x600" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL      Ethernet  
    fL <---------------->  
    fL 48  48      16  
    fL+---+---+----------+  
    fL|dst|src|   type   | ...  
    fL+---+---+----------+  
    fL         [>=]0x600
\}


Every Ethernet type has a value 0x600 (1,536) or greater\[char46] When the last two bytes of the Ethernet header have a value too small to be an Ethernet type, then the value found there is the total length of the frame in bytes, excluding the Ethernet header\[char46] An 802\[char46]2 LLC header typically follows the Ethernet header\[char46] OpenFlow and Open vSwitch only support LLC headers with DSAP and SSAP **0xaa** and control byte **0x03**, which indicate that a SNAP header follows the LLC header\[char46] In turn, OpenFlow and Open vSwitch only support a SNAP header with organization **0x000000**\[char46] In such a case, this field is copied from the type field in the SNAP header, like this:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width .75
B1: box "src" width .75
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"&lt;0x600" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "DSAP" width .4
B1: box "SSAP" width .4
B2: box "cntl" width .4
"8" at B0.n above
"0xaa" at B0.s below
"8" at B1.n above
"0xaa" at B1.s below
"8" at B2.n above
"0x03" at B2.s below
line &lt;-&gt; "LLC" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "org" width .75
B1: box "type" width .4 fill
"24" at B0.n above
"0x000000" at B0.s below
"16" at B1.n above
"\[&gt;=]0x600" at B1.s below
line &lt;-&gt; "SNAP" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL    Ethernet           LLC                SNAP  
    fL <------------>   <------------>   <----------------->  
    fL 48  48    16      8    8    8        24        16  
    fL+---+---+------+ +----+----+----+ +--------+----------+  
    fL|dst|src| type | |DSAP|SSAP|cntl| |  org   |   type   | ...  
    fL+---+---+------+ +----+----+----+ +--------+----------+  
    fL         <0x600   0xaa 0xaa 0x03   0x000000 [>=]0x600
\}


When an 802\[char46]1Q header is inserted after the Ethernet source and destination, this field is populated with the encapsulated Ethertype, not the 802\[char46]1Q Ethertype\[char46] With an Ethernet II inner frame, the result looks like this:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width .75
B1: box "src" width .75
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "TPID" width .4
B1: box "TCI" width .4
"16" at B0.n above
"0x8100" at B0.s below
"16" at B1.n above
"" at B1.s below
line &lt;-&gt; "802.1Q" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "type" width .4 fill
"16" at B0.n above
"\[&gt;=]0x600" at B0.s below
line &lt;-&gt; "Ethertype" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL Ethernet     802.1Q     Ethertype  
    fL <------>   <-------->   <-------->  
    fL  48  48      16   16        16  
    fL+----+---+ +------+---+ +----------+  
    fL|dst |src| | TPID |TCI| |   type   | ...  
    fL+----+---+ +------+---+ +----------+  
    fL            0x8100       [>=]0x600
\}


LLC and SNAP encapsulation look like this with an 802\[char46]1Q header:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width .75
B1: box "src" width .75
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "TPID" width .4
B1: box "TCI" width .4
"16" at B0.n above
"0x8100" at B0.s below
"16" at B1.n above
"" at B1.s below
line &lt;-&gt; "802.1Q" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "type" width 0.4
"16" at B0.n above
"&lt;0x600" at B0.s below
line &lt;-&gt; "Ethertype" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
move .1
[
B0: box "DSAP" width .4
B1: box "SSAP" width .4
B2: box "cntl" width .4
"8" at B0.n above
"0xaa" at B0.s below
"8" at B1.n above
"0xaa" at B1.s below
"8" at B2.n above
"0x03" at B2.s below
line &lt;-&gt; "LLC" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "org" width .75
B1: box "type" width .4 fill
"24" at B0.n above
"0x000000" at B0.s below
"16" at B1.n above
"\[&gt;=]0x600" at B1.s below
line &lt;-&gt; "SNAP" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL Ethernet     802.1Q     Ethertype        LLC                SNAP  
    fL <------>   <-------->   <------->   <------------>   <----------------->  
    fL  48  48      16   16       16        8    8    8        24        16  
    fL+----+---+ +------+---+ +---------+ +----+----+----+ +--------+----------+  
    fL|dst |src| | TPID |TCI| |  type   | |DSAP|SSAP|cntl| |  org   |   type   | ...  
    fL+----+---+ +------+---+ +---------+ +----+----+----+ +--------+----------+  
    fL            0x8100        <0x600     0xaa 0xaa 0x03   0x000000 [>=]0x600
\}


When a packet doesn’t match any of the header formats described above, Open vSwitch and OpenFlow set this field to **0x5ff** (**OFP\_DL\_TYPE\_NOT\_ETH\_TYPE**)\[char46]
.bp

<a name="vlan-fields"></a>

# Vlan Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**dl\_vlan**;2 (low 12 bits);no;yes;Ethernet;
**dl\_vlan\_pcp**;1 (low 3 bits);no;yes;Ethernet;
**vlan\_vid**;2 (low 12 bits);yes;yes;Ethernet;OF 1.2+ and OVS 1.7+
**vlan\_pcp**;1 (low 3 bits);no;yes;VLAN VID;OF 1.2+ and OVS 1.7+
**vlan\_tci**;2;yes;yes;Ethernet;OVS 1.1+
.TE


The 802\[char46]1Q VLAN header causes more trouble than any other 4 bytes in networking\[char46] OpenFlow 1\[char46]0, 1\[char46]1, and 1\[char46]2+ all treat VLANs differently\[char46] Open vSwitch extensions add another variant to the mix\[char46] Open vSwitch reconciles all four treatments as best it can\[char46]


<a name="vlan-header-format"></a>

### VLAN Header Format



An 802\[char46]1Q VLAN header consists of two 16-bit fields:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "Ethertype" width 1.8
"16" at B0.n above
"0x8100" at B0.s below
line &lt;-&gt; "TPID" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
[
B0: box "PCP" width .6
B1: box "CFI" width .3
B2: box "VID" width .9
"3" at B0.n above
"" at B0.s below
"1" at B1.n above
"0" at B1.s below
"12" at B2.n above
"" at B2.s below
line &lt;-&gt; "TCI" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
.PE
\}

.if n \{
    fL   TPID        TCI  
    fL <-------> <--------->  
    fL    16      3   1  12  
    fL+---------+---+---+---+  
    fL|Ethertype|PCP|CFI|VID|  
    fL+---------+---+---+---+  
    fL  0x8100        0
\}


The first 16 bits of the VLAN header, the _TPID_ (Tag Protocol IDentifier), is an Ethertype\[char46] When the VLAN header is inserted just after the source and destination MAC addresses in a Ethertype frame, the TPID serves to identify the presence of the VLAN\[char46] The standard TPID, the only one that Open vSwitch supports, is **0x8100**\[char46] OpenFlow 1\[char46]0 explicitly supports only TPID **0x8100**\[char46] OpenFlow 1\[char46]1, but not earlier or later versions, also requires support for TPID **0x88a8** (Open vSwitch does not support this)\[char46] OpenFlow 1\[char46]2 through 1\[char46]5 do not require support for specific TPIDs (the \`\`push vlan header’’ action does say that only **0x8100** and **0x88a8** should be pushed)\[char46] No version of OpenFlow provides a way to distinguish or match on the TPID\[char46]


The remaining 16 bits of the VLAN header, the _TCI_ (Tag Control Information), is subdivided into three subfields:


* ·  
  _PCP_ (Priority Control Point), is a 3-bit 802\[char46]1p _priority_\[char46] The lowest priority is value 1, the second-lowest is value 0, and priority increases from 2 up to highest priority 7\[char46]
* ·  
  _CFI_ (Canonical Format Indicator), is a 1-bit field\[char46] On an Ethernet network, its value is always 0\[char46] This led to it later being repurposed under the name _DEI_ (Drop Eligibility Indicator)\[char46] By either name, OpenFlow and Open vSwitch don’t provide any way to match or set this bit\[char46]
* ·  
  _VID_ (VLAN IDentifier), is a 12-bit VLAN\[char46] If the VID is 0, then the frame is not part of a VLAN\[char46] In that case, the VLAN header is called a _priority tag_ because it is only meaningful for assigning the frame a priority\[char46] VID **0xfff** (4,095) is reserved\[char46]


See **eth\_type** for illustrations of a complete Ethernet frame with 802\[char46]1Q tag included\[char46]


<a name="multiple-vlans"></a>

### Multiple VLANs



Open vSwitch can match only a single VLAN header\[char46] If more than one VLAN header is present, then **eth\_type** holds the TPID of the inner VLAN header\[char46] Open vSwitch stops parsing the packet after the inner TPID, so matching further into the packet (e\[char46]g\[char46] on the inner TCI or L3 fields) is not possible\[char46]


OpenFlow only directly supports matching a single VLAN header\[char46] In OpenFlow 1\[char46]1 or later, one OpenFlow table can match on the outermost VLAN header and pop it off, and a later OpenFlow table can match on the next outermost header\[char46] Open vSwitch does not support this\[char46]


<a name="vlan-field-details"></a>

### VLAN Field Details



The four variants have three different levels of expressiveness: OpenFlow 1\[char46]0 and 1\[char46]1 VLAN matching are less powerful than OpenFlow 1\[char46]2+ VLAN matching, which is less powerful than Open vSwitch extension VLAN matching\[char46]


<a name="openflow-1char460-vlan-fields"></a>

### OpenFlow 1\[char46]0 VLAN Fields



OpenFlow 1\[char46]0 uses two fields, called **dl\_vlan** and **dl\_vlan\_pcp**, each of which can be either exact-matched or wildcarded, to specify VLAN matches:


* ·  
  When both **dl\_vlan** and **dl\_vlan\_pcp** are wildcarded, the flow matches packets without an 802\[char46]1Q header or with any 802\[char46]1Q header\[char46]
* ·  
  The match **dl\_vlan=0xffff** causes a flow to match only packets without an 802\[char46]1Q header\[char46] Such a flow should also wildcard **dl\_vlan\_pcp**, since a packet without an 802\[char46]1Q header does not have a PCP\[char46] OpenFlow does not specify what to do if a match on PCP is actually present, but Open vSwitch ignores it\[char46]
* ·  
  Otherwise, the flow matches only packets with an 802\[char46]1Q header\[char46] If **dl\_vlan** is not wildcarded, then the flow only matches packets with the VLAN ID specified in **dl\_vlan**’s low 12 bits\[char46] If **dl\_vlan\_pcp** is not wildcarded, then the flow only matches packets with the priority specified in **dl\_vlan\_pcp**’s low 3 bits\[char46]
* OpenFlow does not specify how to interpret the high 4 bits of **dl\_vlan** or the high 5 bits of **dl\_vlan\_pcp**\[char46] Open vSwitch ignores them\[char46]




<a name="openflow-1char461-vlan-fields"></a>

### OpenFlow 1\[char46]1 VLAN Fields



VLAN matching in OpenFlow 1\[char46]1 is similar to OpenFlow 1\[char46]0\[char46] The one refinement is that when **dl\_vlan** matches on **0xfffe** (**OFVPID\_ANY**), the flow matches only packets with an 802\[char46]1Q header, with any VLAN ID\[char46] If **dl\_vlan\_pcp** is wildcarded, the flow matches any packet with an 802\[char46]1Q header, regardless of VLAN ID or priority\[char46] If **dl\_vlan\_pcp** is not wildcarded, then the flow only matches packets with the priority specified in **dl\_vlan\_pcp**’s low 3 bits\[char46]


OpenFlow 1\[char46]1 uses the name **OFPVID\_NONE**, instead of **OFP\_VLAN\_NONE**, for a **dl\_vlan** of **0xffff**, but it has the same meaning\[char46]


In OpenFlow 1\[char46]1, Open vSwitch reports error **OFPBMC\_BAD\_VALUE** for an attempt to match on **dl\_vlan** between 4,096 and **0xfffd**, inclusive, or **dl\_vlan\_pcp** greater than 7\[char46]


<a name="openflow-1char462-vlan-fields"></a>

### OpenFlow 1\[char46]2 VLAN Fields



**OpenFlow 1.2+ VLAN ID Field**
.TS
tab(;);
l lx.
Name:;**vlan\_vid**
Width:;16 bits (only the least-significant 12 bits may be nonzero)
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;Ethernet
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_VLAN\_VID** (6) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
none
T}
.TE




The OpenFlow standard describes this field as consisting of \`\`12+1’’ bits\[char46] On ingress, its value is 0 if no 802\[char46]1Q header is present, and otherwise it holds the VLAN VID in its least significant 12 bits, with bit 12 (**0x1000** aka **OFPVID\_PRESENT**) also set to 1\[char46] The three most significant bits are always zero:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "" width .6
B1: box "P" width .1
B2: box "VLAN ID" width .9
"3" at B0.n above
"0" at B0.s below
"1" at B1.n above
"" at B1.s below
"12" at B2.n above
"" at B2.s below
line &lt;-&gt; "OXM_OF_VLAN_VID" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
.PE
\}

.if n \{
    fL OXM_OF_VLAN_VID  
    fL <------------->  
    fL  3  1     12  
    fL+---+--+--------+  
    fL|   |P |VLAN ID |  
    fL+---+--+--------+  
    fL  0
\}


As a consequence of this field’s format, one may use it to match the VLAN ID in all of the ways available with the OpenFlow 1\[char46]0 and 1\[char46]1 formats, and a few new ways:

* Fully wildcarded  
  Matches any packet, that is, one without an 802\[char46]1Q header or with an 802\[char46]1Q header with any TCI value\[char46]
* Value **0x0000** (**OFPVID\_NONE**), mask **0xffff** (or no mask)  
  Matches only packets without an 802\[char46]1Q header\[char46]
* Value **0x1000**, mask **0x1000**  
  Matches any packet with an 802\[char46]1Q header, regardless of VLAN ID\[char46]
* Value **0x1009**, mask **0xffff** (or no mask)  
  Match only packets with an 802\[char46]1Q header with VLAN ID 9\[char46]
* Value **0x1001**, mask **0x1001**  
  Matches only packets that have an 802\[char46]1Q header with an odd-numbered VLAN ID\[char46] (This is just an example; one can match on any desired VLAN ID bit pattern\[char46])


**OpenFlow 1.2+ VLAN Priority Field**
.TS
tab(;);
l lx.
Name:;**vlan\_pcp**
Width:;8 bits (only the least-significant 3 bits may be nonzero)
Format:;decimal
Masking:;not maskable
Prerequisites:;VLAN VID
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_VLAN\_PCP** (7) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
none
T}
.TE




The 3 least significant bits may be used to match the PCP bits in an 802\[char46]1Q header\[char46] Other bits are always zero:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width 1.0
B1: box "PCP" width .6
"5" at B0.n above
"0" at B0.s below
"3" at B1.n above
"" at B1.s below
line &lt;-&gt; "OXM_OF_VLAN_VID" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL OXM_OF_VLAN_VID  
    fL <------------->  
    fL    5       3  
    fL+--------+------+  
    fL|  zero  | PCP  |  
    fL+--------+------+  
    fL    0
\}


This field may only be used when **vlan\_vid** is not wildcarded and does not exact match on 0 (which only matches when there is no 802\[char46]1Q header)\[char46]


See _VLAN Comparison Chart_, below, for some examples\[char46]


<a name="open-vswitch-extension-vlan-field"></a>

### Open vSwitch Extension VLAN Field



The **vlan\_tci** extension can describe more kinds of VLAN matches than the other variants\[char46] It is also simpler than the other variants\[char46]


**VLAN TCI Field**
.TS
tab(;);
l lx.
Name:;**vlan\_tci**
Width:;16 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;Ethernet
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
none
T}
NXM:;T{
**NXM\_OF\_VLAN\_TCI** (4) since Open vSwitch 1.1
T}
.TE




For a packet without an 802\[char46]1Q header, this field is zero\[char46] For a packet with an 802\[char46]1Q header, this field is the TCI with the bit in CFI’s position (marked **P** for \`\`present’’ below) forced to 1\[char46] Thus, for a packet in VLAN 9 with priority 7, it has the value **0xf009**:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "PCP" width .6
B1: box "P" width .2
B2: box "VID" width .9
"3" at B0.n above
"7" at B0.s below
"1" at B1.n above
"1" at B1.s below
"12" at B2.n above
"9" at B2.s below
line &lt;-&gt; "NXM_VLAN_TCI" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
.PE
\}

.if n \{
    fL NXM_VLAN_TCI  
    fL <---------->  
    fL  3   1   12  
    fL+----+--+----+  
    fL|PCP |P |VID |  
    fL+----+--+----+  
    fL  7   1   9
\}


Usage examples:

* **vlan\_tci=0**  
  Match packets without an 802\[char46]1Q header\[char46]
* **vlan\_tci=0x1000/0x1000**  
  Match packets with an 802\[char46]1Q header, regardless of VLAN and priority values\[char46]
* **vlan\_tci=0xf123**  
  Match packets tagged with priority 7 in VLAN 0x123\[char46]
* **vlan\_tci=0x1123/0x1fff**  
  Match packets tagged with VLAN 0x123 (and any priority)\[char46]
* **vlan\_tci=0x5000/0xf000**  
  Match packets tagged with priority 2 (in any VLAN)\[char46]
* **vlan\_tci=0/0xfff**  
  Match packets with no 802\[char46]1Q header or tagged with VLAN 0 (and any priority)\[char46]
* **vlan\_tci=0x5000/0xe000**  
  Match packets with no 802\[char46]1Q header or tagged with priority 2 (in any VLAN)\[char46]
* **vlan\_tci=0/0xefff**  
  Match packets with no 802\[char46]1Q header or tagged with VLAN 0 and priority 0\[char46]


See _VLAN Comparison Chart_, below, for more examples\[char46]


<a name="vlan-comparison-chart"></a>

### VLAN Comparison Chart



The following table describes each of several possible matching criteria on 802\[char46]1Q header may be expressed with each variation of the VLAN matching fields:


.TS
r r r r r.
Criteria        OpenFlow 1.0    OpenFlow 1.1    OpenFlow 1.2+   NXM
\_      \_      \_      \_      \_
[1]     \fL????/\fL1,\fL??/\fL?     \fL????/\fL1,\fL??/\fL?     \fL0000/\fL0000,\fL--  \fL0000/\fL0000
[2]     \fLffff/\fL0,\fL??/\fL?     \fLffff/\fL0,\fL??/\fL?     \fL0000/\fLffff,\fL--  \fL0000/\fLffff
[3]     \fL0xxx/\fL0,\fL??/\fL1     \fL0xxx/\fL0,\fL??/\fL1     \fL1xxx/\fLffff,\fL--  \fL1xxx/\fL1fff
[4]     \fL????/\fL1,\fL0y/\fL0     \fLfffe/\fL0,\fL0y/\fL0     \fL1000/\fL1000,\fL0y  \fLz000/\fLf000
[5]     \fL0xxx/\fL0,\fL0y/\fL0     \fL0xxx/\fL0,\fL0y/\fL0     \fL1xxx/\fLffff,\fL0y  \fLzxxx/\fLffff
.T&
r r c c r.
[6]     (none)  (none)  \fL1001/\fL1001,\fL--  \fL1001/\fL1001
.T&
r r c c c.
[7]     (none)  (none)  (none)  \fL3000/\fL3000
[8]     (none)  (none)  (none)  \fL0000/\fL0fff
[9]     (none)  (none)  (none)  \fL0000/\fLf000
[10]    (none)  (none)  (none)  \fL0000/\fLefff
.TE


All numbers in the table are expressed in hexadecimal\[char46] The columns in the table are interpreted as follows:


* Criteria  
  See the list below\[char46]
* OpenFlow 1\[char46]0  
  .TQ .5in
  OpenFlow 1\[char46]1
  \fLwwww/x,yy/z means VLAN ID match value \fLwwww with wildcard bit \fLx and VLAN PCP match value \fLyy with wildcard bit \fLz\[char46] \fL? means that the given bits are ignored (and conventionally \fL0 for \fLwwww or \fLyy, conventionally \fL1 for \fLx or \fLz)\[char46] \`\`(none)’’ means that OpenFlow 1\[char46]0 (or 1\[char46]1) cannot match with these criteria\[char46]
* OpenFlow 1\[char46]2+  
  \fLxxxx/yyyy,zz means **vlan\_vid** with value \fLxxxx and mask \fLyyyy, and **vlan\_pcp** (which is not maskable) with value \fLzz\[char46] \fL-- means that **vlan\_pcp** is omitted\[char46] \`\`(none)’’ means that OpenFlow 1\[char46]2 cannot match with these criteria\[char46]
* NXM  
  \fLxxxx/yyyy means **vlan\_tci** with value \fLxxxx and mask \fLyyyy\[char46]


The matching criteria described by the table are:


* [1]  
  Matches any packet, that is, one without an 802\[char46]1Q header or with an 802\[char46]1Q header with any TCI value\[char46]
* [2]  
  Matches only packets without an 802\[char46]1Q header\[char46]
* OpenFlow 1\[char46]0 doesn’t define the behavior if **dl\_vlan** is set to **0xffff** and **dl\_vlan\_pcp** is not wildcarded\[char46] (Open vSwitch always ignores **dl\_vlan\_pcp** when **dl\_vlan** is set to **0xffff**\[char46])
* OpenFlow 1\[char46]1 says explicitly to ignore **dl\_vlan\_pcp** when **dl\_vlan** is set to **0xffff**\[char46]
* OpenFlow 1\[char46]2 doesn’t say how to interpret a match with **vlan\_vid** value 0 and a mask with **OFPVID\_PRESENT** (**0x1000**) set to 1 and some other bits in the mask set to 1 also\[char46] Open vSwitch interprets it the same way as a mask of **0x1000**\[char46]
* Any NXM match with **vlan\_tci** value 0 and the CFI bit set to 1 in the mask is equivalent to the one listed in the table\[char46]
* [3]  
  Matches only packets that have an 802\[char46]1Q header with VID \fLxxx (and any PCP)\[char46]
* [4]  
  Matches only packets that have an 802\[char46]1Q header with PCP \fLy (and any VID)\[char46]
* OpenFlow 1\[char46]0 doesn’t clearly define the behavior for this case\[char46] Open vSwitch implements it this way\[char46]
* In the NXM value, \fLz equals (\fLy &lt;&lt; 1) | 1\[char46]
* [5]  
  Matches only packets that have an 802\[char46]1Q header with VID \fLxxx and PCP \fLy\[char46]
* In the NXM value, \fLz equals (\fLy &lt;&lt; 1) | 1\[char46]
* [6]  
  Matches only packets that have an 802\[char46]1Q header with an odd-numbered VID (and any PCP)\[char46] Only possible with OpenFlow 1\[char46]2 and NXM\[char46] (This is just an example; one can match on any desired VID bit pattern\[char46])
* [7]  
  Matches only packets that have an 802\[char46]1Q header with an odd-numbered PCP (and any VID)\[char46] Only possible with NXM\[char46] (This is just an example; one can match on any desired VID bit pattern\[char46])
* [8]  
  Matches packets with no 802\[char46]1Q header or with an 802\[char46]1Q header with a VID of 0\[char46] Only possible with NXM\[char46]
* [9]  
  Matches packets with no 802\[char46]1Q header or with an 802\[char46]1Q header with a PCP of 0\[char46] Only possible with NXM\[char46]
* [10]  
  Matches packets with no 802\[char46]1Q header or with an 802\[char46]1Q header with both VID and PCP of 0\[char46] Only possible with NXM\[char46]
.bp

<a name="layer-2char465-mpls-fields"></a>

# Layer 2\[Char46]5: Mpls Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**mpls\_label**;4 (low 20 bits);no;yes;MPLS;OF 1.2+ and OVS 1.11+
**mpls\_tc**;1 (low 3 bits);no;yes;MPLS;OF 1.2+ and OVS 1.11+
**mpls\_bos**;1 (low 1 bits);no;no;MPLS;OF 1.3+ and OVS 1.11+
**mpls\_ttl**;1;no;yes;MPLS;OVS 2.6+
.TE


One or more MPLS headers (more commonly called MPLS
labels) follow an Ethernet type field that specifies an MPLS Ethernet type [RFC 3032]\[char46] Ethertype **0x8847** is used for all unicast\[char46] Multicast MPLS is divided into two specific classes, one of which uses Ethertype **0x8847** and the other **0x8848** [RFC 5332]\[char46]


The most common overall packet format is Ethernet II, shown below (SNAP encapsulation may be used but is not ordinarily seen in Ethernet networks):



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.75
B1: box "src" width 0.75
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x8847" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "label" width .6
B1: box "TC" width .3
B2: box "S" width .1
B3: box "TTL" width .4
"20" at B0.n above
"" at B0.s below
"3" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
"8" at B3.n above
"" at B3.s below
line &lt;-&gt; "MPLS" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL    Ethernet           MPLS  
    fL <------------>   <------------>  
    fL 48  48    16      20   3  1  8  
    fL+---+---+------+ +-----+--+-+---+  
    fL|dst|src| type | |label|TC|S|TTL| ...  
    fL+---+---+------+ +-----+--+-+---+  
    fL         0x8847
\}


MPLS can be encapsulated inside an 802\[char46]1Q header, in which case the combination looks like this:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width .75
B1: box "src" width .75
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "TPID" width .4
B1: box "TCI" width .4
"16" at B0.n above
"0x8100" at B0.s below
"16" at B1.n above
"" at B1.s below
line &lt;-&gt; "802.1Q" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
move .1
[
B0: box "type" width .4
"16" at B0.n above
"0x8847" at B0.s below
line &lt;-&gt; "Ethertype" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
move .1
[
B0: box "label" width .6
B1: box "TC" width .3
B2: box "S" width .1
B3: box "TTL" width .4
"20" at B0.n above
"" at B0.s below
"3" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
"8" at B3.n above
"" at B3.s below
line &lt;-&gt; "MPLS" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL Ethernet     802.1Q     Ethertype        MPLS  
    fL <------>   <-------->   <------->   <------------>  
    fL  48  48      16   16       16        20   3  1  8  
    fL+----+---+ +------+---+ +---------+ +-----+--+-+---+  
    fL|dst |src| | TPID |TCI| |  type   | |label|TC|S|TTL| ...  
    fL+----+---+ +------+---+ +---------+ +-----+--+-+---+  
    fL            0x8100        0x8847
\}


The fields within an MPLS label are:


* Label, 20 bits\[char46]  
  An identifier\[char46]
* Traffic control (TC), 3 bits\[char46]  
  Used for quality of service\[char46]
* Bottom of stack (BOS), 1 bit (labeled just \`\`S’’ above)\[char46]  
  0 indicates that another MPLS label follows this one\[char46]
* 1 indicates that this MPLS label is the last one in the stack, so that some other protocol follows this one\[char46]
* Time to live (TTL), 8 bits\[char46]  
  Each hop across an MPLS network decrements the TTL by 1\[char46] If it reaches 0, the packet is discarded\[char46]
* OpenFlow does not make the MPLS TTL available as a match field, but actions are available to set and decrement the TTL\[char46] Open vSwitch 2\[char46]6 and later makes the MPLS TTL available as an extension\[char46]


<a name="mpls-label-stacks"></a>

### MPLS Label Stacks



Unlike the other encapsulations supported by OpenFlow and Open vSwitch, MPLS labels are routinely used in \`\`stacks’’ two or three deep and sometimes even deeper\[char46] Open vSwitch currently supports up to three labels\[char46]


The OpenFlow specification only supports matching on the outermost MPLS label at any given time\[char46] To match on the second label, one must first \`\`pop’’ the outer label and advance to another OpenFlow table, where the inner label may be matched\[char46] To match on the third label, one must pop the two outer labels, and so on\[char46] The Open Networking Foundation is considering support for directly matching on multiple MPLS labels for OpenFlow 1\[char46]6\[char46]


<a name="mpls-inner-protocol"></a>

### MPLS Inner Protocol



Unlike all other forms of encapsulation that Open vSwitch and OpenFlow support, an MPLS label does not indicate what inner protocol it encapsulates\[char46] Different deployments determine the inner protocol in different ways [RFC 3032]:


* ·  
  A few reserved label values do indicate an inner protocol\[char46] Label 0, the \`\`IPv4 Explicit NULL Label,’’ indicates inner IPv4\[char46] Label 2, the \`\`IPv6 Explicit NULL Label,’’ indicates inner IPv6\[char46]
* ·  
  Some deployments use a single inner protocol consistently\[char46]
* ·  
  In some deployments, the inner protocol must be inferred from the innermost label\[char46]
* ·  
  In some deployments, the inner protocol must be inferred from the innermost label and the encapsulated data, e\[char46]g\[char46] to distinguish between inner IPv4 and IPv6 based on whether the first nibble of the inner protocol data are **4** or **6**\[char46] OpenFlow and Open vSwitch do not currently support these cases\[char46]


Open vSwitch and OpenFlow do not infer the inner protocol, even if reserved label values are in use\[char46] Instead, the flow table must specify the inner protocol at the time it pops the bottommost MPLS label, using the Ethertype argument to the **pop\_mpls** action\[char46]


<a name="field-details"></a>

### Field Details



**MPLS Label Field**
.TS
tab(;);
l lx.
Name:;**mpls\_label**
Width:;32 bits (only the least-significant 20 bits may be nonzero)
Format:;decimal
Masking:;not maskable
Prerequisites:;MPLS
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_MPLS\_LABEL** (34) since OpenFlow 1.2 and Open vSwitch 1.11
T}
NXM:;T{
none
T}
.TE




The least significant 20 bits hold the \`\`label’’ field from the MPLS label\[char46] Other bits are zero:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width .6
B1: box "label" width 1.0
"12" at B0.n above
"0" at B0.s below
"20" at B1.n above
"" at B1.s below
line &lt;-&gt; "OXM_OF_MPLS_LABEL" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL OXM_OF_MPLS_LABEL  
    fL <--------------->  
    fL    12       20  
    fL+--------+--------+  
    fL|  zero  | label  |  
    fL+--------+--------+  
    fL    0
\}


Most label values are available for any use by deployments\[char46] Values under 16 are reserved\[char46]


**MPLS Traffic Class Field**
.TS
tab(;);
l lx.
Name:;**mpls\_tc**
Width:;8 bits (only the least-significant 3 bits may be nonzero)
Format:;decimal
Masking:;not maskable
Prerequisites:;MPLS
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_MPLS\_TC** (35) since OpenFlow 1.2 and Open vSwitch 1.11
T}
NXM:;T{
none
T}
.TE




The least significant 3 bits hold the TC field from the MPLS label\[char46] Other bits are zero:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width 1.0
B1: box "TC" width .6
"5" at B0.n above
"0" at B0.s below
"3" at B1.n above
"" at B1.s below
line &lt;-&gt; "OXM_OF_MPLS_TC" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL OXM_OF_MPLS_TC  
    fL <------------>  
    fL    5       3  
    fL+--------+-----+  
    fL|  zero  | TC  |  
    fL+--------+-----+  
    fL    0
\}


This field is intended for use for Quality of Service (QoS) and Explicit Congestion Notification purposes, but its particular interpretation is deployment specific\[char46]


Before 2009, this field was named EXP and reserved for experimental use [RFC 5462]\[char46]


**MPLS Bottom of Stack Field**
.TS
tab(;);
l lx.
Name:;**mpls\_bos**
Width:;8 bits (only the least-significant 1 bits may be nonzero)
Format:;decimal
Masking:;not maskable
Prerequisites:;MPLS
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_MPLS\_BOS** (36) since OpenFlow 1.3 and Open vSwitch 1.11
T}
NXM:;T{
none
T}
.TE




The least significant bit holds the BOS field from the MPLS label\[char46] Other bits are zero:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width 1.3
B1: box "BOS" width .3
"7" at B0.n above
"0" at B0.s below
"1" at B1.n above
"" at B1.s below
line &lt;-&gt; "OXM_OF_MPLS_BOS" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL OXM_OF_MPLS_BOS  
    fL <------------->  
    fL    7       1  
    fL+--------+------+  
    fL|  zero  | BOS  |  
    fL+--------+------+  
    fL    0
\}


This field is useful as part of processing a series of incoming MPLS labels\[char46] A flow that includes a **pop\_mpls** action should generally match on **mpls\_bos**:

* ·  
  When **mpls\_bos** is 1, there is another MPLS label following this one, so the Ethertype passed to **pop\_mpls** should be an MPLS Ethertype\[char46] For example: table=0,
  dl_type=0x8847, mpls_bos=1, actions=pop_mpls:0x8847,
  goto\_table:1
* ·  
  When **mpls\_bos** is 0, this MPLS label is the last one, so the Ethertype passed to **pop\_mpls** should be a non-MPLS Ethertype such as IPv4\[char46] For example: table=1, dl_type=0x8847,
  mpls_bos=0, actions=pop_mpls:0x0800, goto\_table:2


**MPLS Time-to-Live Field**
.TS
tab(;);
l lx.
Name:;**mpls\_ttl**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;MPLS
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_MPLS\_TTL** (30) since Open vSwitch 2.6
T}
.TE




Holds the 8-bit time-to-live field from the MPLS label:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "TTL" width .4
"8" at B0.n above
"" at B0.s below
line &lt;-&gt; "NXM_NX_MPLS_TTL" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
.PE
\}

.if n \{
    fL NXM_NX_MPLS_TTL  
    fL <------------->  
    fL        8  
    fL+---------------+  
    fL|      TTL      |  
    fL+---------------+  
    fL
\}
.bp

<a name="layer-3-ipv4-and-ipv6-fields"></a>

# Layer 3: Ipv4 and Ipv6 Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**ip\_src** aka **nw\_src**;4;yes;yes;IPv4;OF 1.2+ and OVS 1.1+
**ip\_dst** aka **nw\_dst**;4;yes;yes;IPv4;OF 1.2+ and OVS 1.1+
**ipv6\_src**;16;yes;yes;IPv6;OF 1.2+ and OVS 1.1+
**ipv6\_dst**;16;yes;yes;IPv6;OF 1.2+ and OVS 1.1+
**ipv6\_label**;4 (low 20 bits);yes;yes;IPv6;OF 1.2+ and OVS 1.4+
**nw\_proto** aka **ip\_proto**;1;no;no;IPv4/IPv6;OF 1.2+ and OVS 1.1+
**nw\_ttl**;1;no;yes;IPv4/IPv6;OVS 1.4+
**ip\_frag** aka **nw\_frag**;1 (low 2 bits);yes;no;IPv4/IPv6;OVS 1.3+
**nw\_tos**;1;no;yes;IPv4/IPv6;OVS 1.1+
**ip\_dscp**;1 (low 6 bits);no;yes;IPv4/IPv6;OF 1.2+ and OVS 1.7+
**nw\_ecn** aka **ip\_ecn**;1 (low 2 bits);no;yes;IPv4/IPv6;OF 1.2+ and OVS 1.4+
.TE


<a name="ipv4-specific-fields"></a>

### IPv4 Specific Fields



These fields are applicable only to IPv4 flows, that is, flows that match on the IPv4 Ethertype **0x0800**\[char46]


**IPv4 Source Address Field**
.TS
tab(;);
l lx.
Name:;**ip\_src** (aka **nw\_src**)
Width:;32 bits
Format:;IPv4
Masking:;arbitrary bitwise masks
Prerequisites:;IPv4
Access:;read/write
OpenFlow 1.0:;yes (CIDR match only)
OpenFlow 1.1:;yes
OXM:;T{
**OXM\_OF\_IPV4\_SRC** (11) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_IP\_SRC** (7) since Open vSwitch 1.1
T}
.TE




The source address from the IPv4 header:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.4
B2: box "src" width 0.4 fill
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4  
    fL <----------->   <--------------->  
    fL 48  48   16           8   32  32  
    fL+---+---+-----+ +---+-----+---+---+  
    fL|dst|src|type | |...|proto|src|dst| ...  
    fL+---+---+-----+ +---+-----+---+---+  
    fL         0x800
\}


For historical reasons, in an ARP or RARP flow, Open vSwitch interprets matches on **nw\_src** as actually referring to the ARP SPA\[char46]


**IPv4 Destination Address Field**
.TS
tab(;);
l lx.
Name:;**ip\_dst** (aka **nw\_dst**)
Width:;32 bits
Format:;IPv4
Masking:;arbitrary bitwise masks
Prerequisites:;IPv4
Access:;read/write
OpenFlow 1.0:;yes (CIDR match only)
OpenFlow 1.1:;yes
OXM:;T{
**OXM\_OF\_IPV4\_DST** (12) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_IP\_DST** (8) since Open vSwitch 1.1
T}
.TE




The destination address from the IPv4 header:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.4
B2: box "src" width 0.4
B3: box "dst" width 0.4 fill
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4  
    fL <----------->   <--------------->  
    fL 48  48   16           8   32  32  
    fL+---+---+-----+ +---+-----+---+---+  
    fL|dst|src|type | |...|proto|src|dst| ...  
    fL+---+---+-----+ +---+-----+---+---+  
    fL         0x800
\}


For historical reasons, in an ARP or RARP flow, Open vSwitch interprets matches on **nw\_dst** as actually referring to the ARP TPA\[char46]


<a name="ipv6-specific-fields"></a>

### IPv6 Specific Fields



These fields apply only to IPv6 flows, that is, flows that match on the IPv6 Ethertype **0x86dd**\[char46]


**IPv6 Source Address Field**
.TS
tab(;);
l lx.
Name:;**ipv6\_src**
Width:;128 bits
Format:;IPv6
Masking:;arbitrary bitwise masks
Prerequisites:;IPv6
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_IPV6\_SRC** (26) since OpenFlow 1.2 and Open vSwitch 1.1
T}
NXM:;T{
**NXM\_NX\_IPV6\_SRC** (19) since Open vSwitch 1.1
T}
.TE




The source address from the IPv6 header:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x86dd" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "next" width 0.3
B2: box "src" width 0.8 fill
B3: box "dst" width 0.8
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"128" at B2.n above
"" at B2.s below
"128" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv6" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL    Ethernet            IPv6  
    fL <------------>   <-------------->  
    fL 48  48    16          8   128 128  
    fL+---+---+------+ +---+----+---+---+  
    fL|dst|src| type | |...|next|src|dst| ...  
    fL+---+---+------+ +---+----+---+---+  
    fL         0x86dd
\}


Open vSwitch 1\[char46]8 added support for bitwise matching; earlier versions supported only CIDR masks\[char46]


**IPv6 Destination Address Field**
.TS
tab(;);
l lx.
Name:;**ipv6\_dst**
Width:;128 bits
Format:;IPv6
Masking:;arbitrary bitwise masks
Prerequisites:;IPv6
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_IPV6\_DST** (27) since OpenFlow 1.2 and Open vSwitch 1.1
T}
NXM:;T{
**NXM\_NX\_IPV6\_DST** (20) since Open vSwitch 1.1
T}
.TE




The destination address from the IPv6 header:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x86dd" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "next" width 0.3
B2: box "src" width 0.8
B3: box "dst" width 0.8 fill
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"128" at B2.n above
"" at B2.s below
"128" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv6" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL    Ethernet            IPv6  
    fL <------------>   <-------------->  
    fL 48  48    16          8   128 128  
    fL+---+---+------+ +---+----+---+---+  
    fL|dst|src| type | |...|next|src|dst| ...  
    fL+---+---+------+ +---+----+---+---+  
    fL         0x86dd
\}


Open vSwitch 1\[char46]8 added support for bitwise matching; earlier versions supported only CIDR masks\[char46]


**IPv6 Flow Label Field**
.TS
tab(;);
l lx.
Name:;**ipv6\_label**
Width:;32 bits (only the least-significant 20 bits may be nonzero)
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;IPv6
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_IPV6\_FLABEL** (28) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_IPV6\_LABEL** (27) since Open vSwitch 1.4
T}
.TE




The least significant 20 bits hold the flow label field from the IPv6 header\[char46] Other bits are zero:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width .6
B1: box "label" width 1.0
"12" at B0.n above
"0" at B0.s below
"20" at B1.n above
"" at B1.s below
line &lt;-&gt; "OXM_OF_IPV6_FLABEL" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL OXM_OF_IPV6_FLABEL  
    fL <---------------->  
    fL    12       20  
    fL+--------+---------+  
    fL|  zero  |  label  |  
    fL+--------+---------+  
    fL    0
\}


<a name="ipv4ipv6-fields"></a>

### IPv4/IPv6 Fields



These fields exist with at least approximately the same meaning in both IPv4 and IPv6, so they are treated as a single field for matching purposes\[char46] Any flow that matches on the IPv4 Ethertype **0x0800** or the IPv6 Ethertype **0x86dd** may match on these fields\[char46]


**IPv4/v6 Protocol Field**
.TS
tab(;);
l lx.
Name:;**nw\_proto** (aka **ip\_proto**)
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;IPv4/IPv6
Access:;read-only
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_IP\_PROTO** (10) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_IP\_PROTO** (6) since Open vSwitch 1.1
T}
.TE




Matches the IPv4 or IPv6 protocol type\[char46]


For historical reasons, in an ARP or RARP flow, Open vSwitch interprets matches on **nw\_proto** as actually referring to the ARP opcode\[char46] The ARP opcode is a 16-bit field, so for matching purposes ARP opcodes greater than 255 are treated as 0; this works adequately because in practice ARP and RARP only use opcodes 1 through 4\[char46]


**IPv4/v6 TTL/Hop Limit Field**
.TS
tab(;);
l lx.
Name:;**nw\_ttl**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;IPv4/IPv6
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_IP\_TTL** (29) since Open vSwitch 1.4
T}
.TE


The main reason to match on the TTL or hop limit field is to detect whether a **dec\_ttl** action will fail due to a TTL exceeded error\[char46] Another way that a controller can detect TTL exceeded is to listen for **OFPR\_INVALID\_TTL** \`\`packet-in’’ messages via OpenFlow\[char46]


**IPv4/v6 Fragment Bitmask Field**
.TS
tab(;);
l lx.
Name:;**ip\_frag** (aka **nw\_frag**)
Width:;8 bits (only the least-significant 2 bits may be nonzero)
Format:;frag
Masking:;arbitrary bitwise masks
Prerequisites:;IPv4/IPv6
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXM\_NX\_IP\_FRAG** (26) since Open vSwitch 1.3
T}
.TE




Specifies what kinds of IP fragments or non-fragments to match\[char46] The value for this field is most conveniently specified as one of the following:

* **no**  
  Match only non-fragmented packets\[char46]
* **yes**  
  Matches all fragments\[char46]
* **first**  
  Matches only fragments with offset 0\[char46]
* **later**  
  Matches only fragments with nonzero offset\[char46]
* **not\_later**  
  Matches non-fragmented packets and fragments with zero offset\[char46]


The field is internally formatted as 2 bits: bit 0 is 1 for an IP fragment with any offset (and otherwise 0), and bit 1 is 1 for an IP fragment with nonzero offset (and otherwise 0), like so:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width .9
B1: box "later" width .3
B2: box "any" width .3
"6" at B0.n above
"0" at B0.s below
"1" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
line &lt;-&gt; "NXM_NX_IP_FRAG" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
.PE
\}

.if n \{
    fL NXM_NX_IP_FRAG  
    fL <------------>  
    fL  6     1    1  
    fL+----+-----+---+  
    fL|zero|later|any|  
    fL+----+-----+---+  
    fL  0
\}


Even though 2 bits have 4 possible values, this field only uses 3 of them:

* ·  
  A packet that is not an IP fragment has value 0\[char46]
* ·  
  A packet that is an IP fragment with offset 0 (the first fragment) has bit 0 set and thus value 1\[char46]
* ·  
  A packet that is an IP fragment with nonzero offset has bits 0 and 1 set and thus value 3\[char46]


The switch may reject matches against values that can never appear\[char46]


It is important to understand how this field interacts with the OpenFlow fragment handling mode:

* ·  
  In **OFPC\_FRAG\_DROP** mode, the OpenFlow switch drops all IP fragments before they reach the flow table, so every packet that is available for matching will have value 0 in this field\[char46]
* ·  
  Open vSwitch does not implement **OFPC\_FRAG\_REASM** mode, but if it did then IP fragments would be reassembled before they reached the flow table and again every packet available for matching would always have value 0\[char46]
* ·  
  In **OFPC\_FRAG\_NORMAL** mode, all three values are possible, but OpenFlow 1\[char46]0 says that fragments’ transport ports are always 0, even for the first fragment, so this does not provide much extra information\[char46]
* ·  
  In **OFPC\_FRAG\_NX\_MATCH** mode, all three values are possible\[char46] For fragments with offset 0, Open vSwitch makes L4 header information available\[char46]


Thus, this field is likely to be most useful for an Open vSwitch switch configured in **OFPC\_FRAG\_NX\_MATCH** mode\[char46] See the description of the **set-frags** command in **ovs-ofctl**(8), for more details\[char46]

.ST "IPv4/IPv6 TOS Fields"


IPv4 and IPv6 contain a one-byte \`\`type of service’’ or TOS field that has the following format:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "DSCP" width .9
B1: box "ECN" width .3
"6" at B0.n above
"" at B0.s below
"2" at B1.n above
"" at B1.s below
line &lt;-&gt; "type of service" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL type of service  
    fL <------------->  
    fL    6       2  
    fL+--------+------+  
    fL|  DSCP  | ECN  |  
    fL+--------+------+  
    fL
\}


**IPv4/v6 DSCP (Bits 2-7) Field**
.TS
tab(;);
l lx.
Name:;**nw\_tos**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;IPv4/IPv6
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
none
T}
NXM:;T{
**NXM\_OF\_IP\_TOS** (5) since Open vSwitch 1.1
T}
.TE




This field is the TOS byte with the two ECN bits cleared to 0:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "DSCP" width .9
B1: box "zero" width .3
"6" at B0.n above
"" at B0.s below
"2" at B1.n above
"0" at B1.s below
line &lt;-&gt; "NXM_OF_IP_TOS" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL NXM_OF_IP_TOS  
    fL <----------->  
    fL   6      2  
    fL+------+------+  
    fL| DSCP | zero |  
    fL+------+------+  
    fL          0
\}


**IPv4/v6 DSCP (Bits 0-5) Field**
.TS
tab(;);
l lx.
Name:;**ip\_dscp**
Width:;8 bits (only the least-significant 6 bits may be nonzero)
Format:;decimal
Masking:;not maskable
Prerequisites:;IPv4/IPv6
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_IP\_DSCP** (8) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
none
T}
.TE




This field is the TOS byte shifted right to put the DSCP bits in the 6 least-significant bits:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width .3
B1: box "DSCP" width .9
"2" at B0.n above
"0" at B0.s below
"6" at B1.n above
"" at B1.s below
line &lt;-&gt; "OXM_OF_IP_DSCP" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL OXM_OF_IP_DSCP  
    fL <------------>  
    fL    2      6  
    fL+-------+------+  
    fL| zero  | DSCP |  
    fL+-------+------+  
    fL    0
\}


**IPv4/v6 ECN Field**
.TS
tab(;);
l lx.
Name:;**nw\_ecn** (aka **ip\_ecn**)
Width:;8 bits (only the least-significant 2 bits may be nonzero)
Format:;decimal
Masking:;not maskable
Prerequisites:;IPv4/IPv6
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_IP\_ECN** (9) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_IP\_ECN** (28) since Open vSwitch 1.4
T}
.TE




This field is the TOS byte with the DSCP bits cleared to 0:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width .9
B1: box "ECN" width .35
"6" at B0.n above
"0" at B0.s below
"2" at B1.n above
"" at B1.s below
line &lt;-&gt; "OXM_OF_IP_ECN" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL OXM_OF_IP_ECN  
    fL <----------->  
    fL    6      2  
    fL+-------+-----+  
    fL| zero  | ECN |  
    fL+-------+-----+  
    fL    0
\}
.bp

<a name="layer-3-arp-fields"></a>

# Layer 3: Arp Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**arp\_op**;2;no;yes;ARP;OF 1.2+ and OVS 1.1+
**arp\_spa**;4;yes;yes;ARP;OF 1.2+ and OVS 1.1+
**arp\_tpa**;4;yes;yes;ARP;OF 1.2+ and OVS 1.1+
**arp\_sha**;6;yes;yes;ARP;OF 1.2+ and OVS 1.1+
**arp\_tha**;6;yes;yes;ARP;OF 1.2+ and OVS 1.1+
.TE


In theory, Address Resolution Protocol, or ARP, is a generic protocol generic protocol that can be used to obtain the hardware address that corresponds to any higher-level protocol address\[char46] In contemporary usage, ARP is used only in Ethernet networks to obtain the Ethernet address for a given IPv4 address\[char46] OpenFlow and Open vSwitch only support this usage of ARP\[char46] For this use case, an ARP packet has the following format, with the ARP fields exposed as Open vSwitch fields highlighted:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x806" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "hrd" width .3
B1: box "pro" width .3
B2: box "hln" width .2
B3: box "pln" width .2
B4: box "op" width .2 fill
B5: box "sha" width 0.5 fill
B6: box "spa" width 0.3 fill
B7: box "tha" width 0.5 fill
B8: box "tpa" width 0.3 fill
"16" at B0.n above
"1" at B0.s below
"16" at B1.n above
"0x800" at B1.s below
"8" at B2.n above
"6" at B2.s below
"8" at B3.n above
"4" at B3.s below
"16" at B4.n above
"" at B4.s below
"48" at B5.n above
"" at B5.s below
"16" at B6.n above
"" at B6.s below
"48" at B7.n above
"" at B7.s below
"16" at B8.n above
"" at B8.s below
line &lt;-&gt; "ARP" above from B0.nw + (0,textht) to B8.ne + (0,textht)
]
.PE
\}

.if n \{
    fL   Ethernet                      ARP  
    fL <----------->   <---------------------------------->  
    fL 48  48   16     16   16    8   8  16 48  16  48  16  
    fL+---+---+-----+ +---+-----+---+---+--+---+---+---+---+  
    fL|dst|src|type | |hrd| pro |hln|pln|op|sha|spa|tha|tpa|  
    fL+---+---+-----+ +---+-----+---+---+--+---+---+---+---+  
    fL         0x806    1  0x800  6   4
\}


The ARP fields are also used for RARP, the Reverse Address Resolution Protocol, which shares ARP’s wire format\[char46]


**ARP Opcode Field**
.TS
tab(;);
l lx.
Name:;**arp\_op**
Width:;16 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;ARP
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_ARP\_OP** (21) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_ARP\_OP** (15) since Open vSwitch 1.1
T}
.TE


Even though this is a 16-bit field, Open vSwitch does not support ARP opcodes greater than 255; it treats them to zero\[char46] This works adequately because in practice ARP and RARP only use opcodes 1 through 4\[char46]


**ARP Source IPv4 Address Field**
.TS
tab(;);
l lx.
Name:;**arp\_spa**
Width:;32 bits
Format:;IPv4
Masking:;arbitrary bitwise masks
Prerequisites:;ARP
Access:;read/write
OpenFlow 1.0:;yes (CIDR match only)
OpenFlow 1.1:;yes
OXM:;T{
**OXM\_OF\_ARP\_SPA** (22) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_ARP\_SPA** (16) since Open vSwitch 1.1
T}
.TE



**ARP Target IPv4 Address Field**
.TS
tab(;);
l lx.
Name:;**arp\_tpa**
Width:;32 bits
Format:;IPv4
Masking:;arbitrary bitwise masks
Prerequisites:;ARP
Access:;read/write
OpenFlow 1.0:;yes (CIDR match only)
OpenFlow 1.1:;yes
OXM:;T{
**OXM\_OF\_ARP\_TPA** (23) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_ARP\_TPA** (17) since Open vSwitch 1.1
T}
.TE



**ARP Source Ethernet Address Field**
.TS
tab(;);
l lx.
Name:;**arp\_sha**
Width:;48 bits
Format:;Ethernet
Masking:;arbitrary bitwise masks
Prerequisites:;ARP
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_ARP\_SHA** (24) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_ARP\_SHA** (17) since Open vSwitch 1.1
T}
.TE



**ARP Target Ethernet Address Field**
.TS
tab(;);
l lx.
Name:;**arp\_tha**
Width:;48 bits
Format:;Ethernet
Masking:;arbitrary bitwise masks
Prerequisites:;ARP
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_ARP\_THA** (25) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_ARP\_THA** (18) since Open vSwitch 1.1
T}
.TE
.bp

<a name="layer-3-nsh-fields"></a>

# Layer 3: Nsh Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**nsh\_flags**;1;yes;yes;NSH;OVS 2.8+
**nsh\_ttl**;1;no;yes;NSH;OVS 2.9+
**nsh\_mdtype**;1;no;no;NSH;OVS 2.8+
**nsh\_np**;1;no;no;NSH;OVS 2.8+
**nsh\_spi** aka **nsp**;4 (low 24 bits);no;yes;NSH;OVS 2.8+
**nsh\_si** aka **nsi**;1;no;yes;NSH;OVS 2.8+
**nsh\_c1** aka **nshc1**;4;yes;yes;NSH;OVS 2.8+
**nsh\_c2** aka **nshc2**;4;yes;yes;NSH;OVS 2.8+
**nsh\_c3** aka **nshc3**;4;yes;yes;NSH;OVS 2.8+
**nsh\_c4** aka **nshc4**;4;yes;yes;NSH;OVS 2.8+
.TE


Service functions are widely deployed and essential in many networks\[char46] These service functions provide a range of features such as security, WAN acceleration, and server load balancing\[char46] Service functions may be instantiated at different points in the network infrastructure such as the wide area network, data center, and so forth\[char46]


Prior to development of the SFC architecture [RFC 7665] and the protocol specified in this document, current service function deployment models have been relatively static and bound to topology for insertion and policy selection\[char46] Furthermore, they do not adapt well to elastic service environments enabled by virtualization\[char46]


New data center network and cloud architectures require more flexible service function deployment models\[char46] Additionally, the transition to virtual platforms demands an agile service insertion model that supports dynamic and elastic service delivery\[char46] Specifically, the following functions are necessary:


* 1.  
  The movement of service functions and application workloads in the network\[char46]
* 2.  
  The ability to easily bind service policy to granular information, such as per-subscriber state\[char46]
* 3.  
  The capability to steer traffic to the requisite service function(s)\[char46]


The Network Service Header (NSH) specification defines a new data plane protocol, which is an encapsulation for service function chains\[char46] The NSH is designed to encapsulate an original packet or frame, and in turn be encapsulated by an outer transport encapsulation (which is used to deliver the NSH to NSH-aware network elements), as shown below:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "Transport Encapsulation" width 1.8
"" at B0.n above
"" at B0.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
[
B0: box "Network Service Header (NSH)" width 2.0
"" at B0.n above
"" at B0.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
[
B0: box "Original Packet/Frame" width 1.8
"" at B0.n above
"" at B0.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
.PE
\}

.if n \{
    fL  
    fL+-----------------------+----------------------------+---------------------+  
    fL|Transport Encapsulation|Network Service Header (NSH)|Original Packet/Frame|  
    fL+-----------------------+----------------------------+---------------------+  
    fL
\}


The NSH is composed of the following elements:


* 1.  
  Service Function Path identification\[char46]
* 2.  
  Indication of location within a Service Function Path\[char46]
* 3.  
  Optional, per packet metadata (fixed length or variable)\[char46]


[RFC 7665] provides an overview of a service chaining architecture that clearly defines the roles of the various elements and the scope of a service function chaining encapsulation\[char46] Figure 3 of [RFC 7665] depicts the SFC architectural components after classification\[char46] The NSH is the SFC encapsulation referenced in [RFC 7665]\[char46]


**flags field (2 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_flags**
Width:;8 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;NSH
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_FLAGS** (1) since Open vSwitch 2.8
T}
.TE



**TTL field (6 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_ttl**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;NSH
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_TTL** (10) since Open vSwitch 2.9
T}
.TE



**mdtype field (8 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_mdtype**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;NSH
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_MDTYPE** (2) since Open vSwitch 2.8
T}
.TE



**np (next protocol) field (8 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_np**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;NSH
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_NP** (3) since Open vSwitch 2.8
T}
.TE



**spi (service path identifier) field (24 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_spi** (aka **nsp**)
Width:;32 bits (only the least-significant 24 bits may be nonzero)
Format:;hexadecimal
Masking:;not maskable
Prerequisites:;NSH
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_SPI** (4) since Open vSwitch 2.8
T}
.TE



**si (service index) field (8 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_si** (aka **nsi**)
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;NSH
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_SI** (5) since Open vSwitch 2.8
T}
.TE



**c1 (Network Platform Context) field (32 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_c1** (aka **nshc1**)
Width:;32 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;NSH
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_C1** (6) since Open vSwitch 2.8
T}
.TE



**c2 (Network Shared Context) field (32 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_c2** (aka **nshc2**)
Width:;32 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;NSH
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_C2** (7) since Open vSwitch 2.8
T}
.TE



**c3 (Service Platform Context) field (32 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_c3** (aka **nshc3**)
Width:;32 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;NSH
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_C3** (8) since Open vSwitch 2.8
T}
.TE



**c4 (Service Shared Context) field (32 bits) Field**
.TS
tab(;);
l lx.
Name:;**nsh\_c4** (aka **nshc4**)
Width:;32 bits
Format:;hexadecimal
Masking:;arbitrary bitwise masks
Prerequisites:;NSH
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
none
T}
NXM:;T{
**NXOXM\_NSH\_C4** (9) since Open vSwitch 2.8
T}
.TE
.bp

<a name="layer-4-tcp-udp-and-sctp-fields"></a>

# Layer 4: Tcp, Udp, and Sctp Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**tcp\_src** aka **tp\_src**;2;yes;yes;TCP;OF 1.2+ and OVS 1.1+
**tcp\_dst** aka **tp\_dst**;2;yes;yes;TCP;OF 1.2+ and OVS 1.1+
**tcp\_flags**;2 (low 12 bits);yes;no;TCP;OF 1.3+ and OVS 2.1+
**udp\_src**;2;yes;yes;UDP;OF 1.2+ and OVS 1.1+
**udp\_dst**;2;yes;yes;UDP;OF 1.2+ and OVS 1.1+
**sctp\_src**;2;yes;yes;SCTP;OF 1.2+ and OVS 2.0+
**sctp\_dst**;2;yes;yes;SCTP;OF 1.2+ and OVS 2.0+
.TE


For matching purposes, no distinction is made whether these protocols are encapsulated within IPv4 or IPv6\[char46]


<a name="tcp"></a>

### TCP



The following diagram shows TCP within IPv4\[char46] Open vSwitch also supports TCP in IPv6\[char46] Only TCP fields implemented as Open vSwitch fields are shown:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.3
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"6" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box "src" width .2
B1: box "dst" width .2
B2: box ". . ." width .75
B3: box "flags" width .3
B4: box ". . ." width .6
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"" at B1.s below
"" at B2.n above
"" at B2.s below
"12" at B3.n above
"" at B3.s below
"" at B4.n above
"" at B4.s below
line &lt;-&gt; "TCP" above from B0.nw + (0,textht) to B4.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4                   TCP  
    fL <----------->   <--------------->   <------------------->  
    fL 48  48   16           8   32  32    16  16       12  
    fL+---+---+-----+ +---+-----+---+---+ +---+---+---+-----+---+  
    fL|dst|src|type | |...|proto|src|dst| |src|dst|...|flags|...| ...  
    fL+---+---+-----+ +---+-----+---+---+ +---+---+---+-----+---+  
    fL         0x800         6
\}


**TCP Source Port Field**
.TS
tab(;);
l lx.
Name:;**tcp\_src** (aka **tp\_src**)
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;TCP
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_TCP\_SRC** (13) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_TCP\_SRC** (9) since Open vSwitch 1.1
T}
.TE


Open vSwitch 1\[char46]6 added support for bitwise matching\[char46]


**TCP Destination Port Field**
.TS
tab(;);
l lx.
Name:;**tcp\_dst** (aka **tp\_dst**)
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;TCP
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_TCP\_DST** (14) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_TCP\_DST** (10) since Open vSwitch 1.1
T}
.TE


Open vSwitch 1\[char46]6 added support for bitwise matching\[char46]


**TCP Flags Field**
.TS
tab(;);
l lx.
Name:;**tcp\_flags**
Width:;16 bits (only the least-significant 12 bits may be nonzero)
Format:;TCP flags
Masking:;arbitrary bitwise masks
Prerequisites:;TCP
Access:;read-only
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**ONFOXM\_ET\_TCP\_FLAGS** (42) since OpenFlow 1.3 and Open vSwitch 2.4\[char59] **OXM\_OF\_TCP\_FLAGS** (42) since OpenFlow 1.5 and Open vSwitch 2.3
T}
NXM:;T{
**NXM\_NX\_TCP\_FLAGS** (34) since Open vSwitch 2.1
T}
.TE




This field holds the TCP flags\[char46] TCP currently defines 9 flag bits\[char46] An additional 3 bits are reserved\[char46] For more information, see [RFC 793], [RFC 3168], and [RFC 3540]\[char46]


Matches on this field are most conveniently written in terms of symbolic names (given in the diagram below), each preceded by either **+** for a flag that must be set, or **-** for a flag that must be unset, without any other delimiters between the flags\[char46] Flags not mentioned are wildcarded\[char46] For example, **tcp,tcp\_flags=+syn-ack** matches TCP SYNs that are not ACKs, and **tcp,tcp\_flags=+[200]** matches TCP packets with the reserved [200] flag set\[char46] Matches can also be written as **_flags/mask**, where flags_ and _mask_ are 16-bit numbers in decimal or in hexadecimal prefixed by **0x**\[char46]


The flag bits are:


.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "zero" width .9
"4" at B0.n above
"0" at B0.s below
line &lt;-&gt; invis "" above from B0.nw + (0,textht) to B0.ne + (0,textht)
]
[
B0: box "[800]" width .35
B1: box "[400]" width .35
B2: box "[200]" width .35
"1" at B0.n above
"" at B0.s below
"1" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
line &lt;-&gt; "reserved" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
[
B0: box "NS" width .35
B1: box "CWR" width .35
B2: box "ECE" width .35
"1" at B0.n above
"" at B0.s below
"1" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
line &lt;-&gt; "later RFCs" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
[
B0: box "URG" width .35
B1: box "ACK" width .35
B2: box "PSH" width .35
B3: box "RST" width .35
B4: box "SYN" width .35
B5: box "FIN" width .35
"1" at B0.n above
"" at B0.s below
"1" at B1.n above
"" at B1.s below
"1" at B2.n above
"" at B2.s below
"1" at B3.n above
"" at B3.s below
"1" at B4.n above
"" at B4.s below
"1" at B5.n above
"" at B5.s below
line &lt;-&gt; "RFC 793" above from B0.nw + (0,textht) to B5.ne + (0,textht)
]
.PE
\}

.if n \{
    fL          reserved      later RFCs         RFC 793  
    fL      <---------------> <--------> <--------------------->  
    fL  4     1     1     1   1   1   1   1   1   1   1   1   1  
    fL+----+-----+-----+-----+--+---+---+---+---+---+---+---+---+  
    fL|zero|[800]|[400]|[200]|NS|CWR|ECE|URG|ACK|PSH|RST|SYN|FIN|  
    fL+----+-----+-----+-----+--+---+---+---+---+---+---+---+---+  
    fL  0
\}


<a name="udp"></a>

### UDP



The following diagram shows UDP within IPv4\[char46] Open vSwitch also supports UDP in IPv6\[char46] Only UDP fields that Open vSwitch exposes as fields are shown:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.3
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"17" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box "src" width .2
B1: box "dst" width .2
B2: box ". . ." width .4
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"" at B1.s below
"" at B2.n above
"" at B2.s below
line &lt;-&gt; "UDP" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4              UDP  
    fL <----------->   <--------------->   <--------->  
    fL 48  48   16           8   32  32    16  16  
    fL+---+---+-----+ +---+-----+---+---+ +---+---+---+  
    fL|dst|src|type | |...|proto|src|dst| |src|dst|...| ...  
    fL+---+---+-----+ +---+-----+---+---+ +---+---+---+  
    fL         0x800        17
\}


**UDP Source Port Field**
.TS
tab(;);
l lx.
Name:;**udp\_src**
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;UDP
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_UDP\_SRC** (15) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_UDP\_SRC** (11) since Open vSwitch 1.1
T}
.TE



**UDP Destination Port Field**
.TS
tab(;);
l lx.
Name:;**udp\_dst**
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;UDP
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_UDP\_DST** (16) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_UDP\_DST** (12) since Open vSwitch 1.1
T}
.TE



<a name="sctp"></a>

### SCTP



The following diagram shows SCTP within IPv4\[char46] Open vSwitch also supports SCTP in IPv6\[char46] Only SCTP fields that Open vSwitch exposes as fields are shown:



.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.3
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"132" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box "src" width .2
B1: box "dst" width .2
B2: box ". . ." width .8
"16" at B0.n above
"" at B0.s below
"16" at B1.n above
"" at B1.s below
"" at B2.n above
"" at B2.s below
line &lt;-&gt; "SCTP" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4             SCTP  
    fL <----------->   <--------------->   <--------->  
    fL 48  48   16           8   32  32    16  16  
    fL+---+---+-----+ +---+-----+---+---+ +---+---+---+  
    fL|dst|src|type | |...|proto|src|dst| |src|dst|...| ...  
    fL+---+---+-----+ +---+-----+---+---+ +---+---+---+  
    fL         0x800        132
\}


**SCTP Source Port Field**
.TS
tab(;);
l lx.
Name:;**sctp\_src**
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;SCTP
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_SCTP\_SRC** (17) since OpenFlow 1.2 and Open vSwitch 2.0
T}
NXM:;T{
none
T}
.TE



**SCTP Destination Port Field**
.TS
tab(;);
l lx.
Name:;**sctp\_dst**
Width:;16 bits
Format:;decimal
Masking:;arbitrary bitwise masks
Prerequisites:;SCTP
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_SCTP\_DST** (18) since OpenFlow 1.2 and Open vSwitch 2.0
T}
NXM:;T{
none
T}
.TE
.bp

<a name="layer-4-icmpv4-and-icmpv6-fields"></a>

# Layer 4: Icmpv4 and Icmpv6 Fields


<a name="summary"></a>

### Summary:

.TS
tab(;);
l l l l l l l.
Name;Bytes;Mask;RW?;Prereqs;NXM/OXM Support
\_;\_;\_;\_;\_;\_
**icmp\_type**;1;no;yes;ICMPv4;OF 1.2+ and OVS 1.1+
**icmp\_code**;1;no;yes;ICMPv4;OF 1.2+ and OVS 1.1+
**icmpv6\_type**;1;no;yes;ICMPv6;OF 1.2+ and OVS 1.1+
**icmpv6\_code**;1;no;yes;ICMPv6;OF 1.2+ and OVS 1.1+
**nd\_target**;16;yes;yes;ND;OF 1.2+ and OVS 1.1+
**nd\_sll**;6;yes;yes;ND solicit;OF 1.2+ and OVS 1.1+
**nd\_tll**;6;yes;yes;ND advert;OF 1.2+ and OVS 1.1+
.TE


<a name="icmpv4"></a>

### ICMPv4




.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x800" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.4
B1: box "proto" width 0.3
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"1" at B1.s below
"32" at B2.n above
"" at B2.s below
"32" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv4" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box "type" width .3
B1: box "code" width .3
B2: box ". . ." width .8
"8" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"" at B2.n above
"" at B2.s below
line &lt;-&gt; "ICMPv4" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL   Ethernet            IPv4             ICMPv4  
    fL <----------->   <--------------->   <----------->  
    fL 48  48   16           8   32  32     8    8  
    fL+---+---+-----+ +---+-----+---+---+ +----+----+---+  
    fL|dst|src|type | |...|proto|src|dst| |type|code|...| ...  
    fL+---+---+-----+ +---+-----+---+---+ +----+----+---+  
    fL         0x800         1
\}


**ICMPv4 Type Field**
.TS
tab(;);
l lx.
Name:;**icmp\_type**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;ICMPv4
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_ICMPV4\_TYPE** (19) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_ICMP\_TYPE** (13) since Open vSwitch 1.1
T}
.TE




For historical reasons, in an ICMPv4 flow, Open vSwitch interprets matches on **tp\_src** as actually referring to the ICMP type\[char46]


**ICMPv4 Code Field**
.TS
tab(;);
l lx.
Name:;**icmp\_code**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;ICMPv4
Access:;read/write
OpenFlow 1.0:;yes (exact match only)
OpenFlow 1.1:;yes (exact match only)
OXM:;T{
**OXM\_OF\_ICMPV4\_CODE** (20) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_OF\_ICMP\_CODE** (14) since Open vSwitch 1.1
T}
.TE




For historical reasons, in an ICMPv4 flow, Open vSwitch interprets matches on **tp\_dst** as actually referring to the ICMP code\[char46]


<a name="icmpv6"></a>

### ICMPv6




.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x86dd" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.2
B1: box "next" width 0.3
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"58" at B1.s below
"128" at B2.n above
"" at B2.s below
"128" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv6" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box "type" width .3
B1: box "code" width .3
B2: box ". . ." width .8
"8" at B0.n above
"" at B0.s below
"8" at B1.n above
"" at B1.s below
"" at B2.n above
"" at B2.s below
line &lt;-&gt; "ICMPv6" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
". . ." ljust
.PE
\}

.if n \{
    fL    Ethernet            IPv6            ICMPv6  
    fL <------------>   <-------------->   <----------->  
    fL 48  48    16          8   128 128    8    8  
    fL+---+---+------+ +---+----+---+---+ +----+----+---+  
    fL|dst|src| type | |...|next|src|dst| |type|code|...| ...  
    fL+---+---+------+ +---+----+---+---+ +----+----+---+  
    fL         0x86dd        58
\}


**ICMPv6 Type Field**
.TS
tab(;);
l lx.
Name:;**icmpv6\_type**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;ICMPv6
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_ICMPV6\_TYPE** (29) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_ICMPV6\_TYPE** (21) since Open vSwitch 1.1
T}
.TE



**ICMPv6 Code Field**
.TS
tab(;);
l lx.
Name:;**icmpv6\_code**
Width:;8 bits
Format:;decimal
Masking:;not maskable
Prerequisites:;ICMPv6
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_ICMPV6\_CODE** (30) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_ICMPV6\_CODE** (22) since Open vSwitch 1.1
T}
.TE



<a name="icmpv6-neighbor-discovery"></a>

### ICMPv6 Neighbor Discovery




.if t \{
.PS
boxht = .2
textht = 1/6
fillval = .2
[
B0: box "dst" width 0.4
B1: box "src" width 0.4
B2: box "type" width 0.4
"48" at B0.n above
"" at B0.s below
"48" at B1.n above
"" at B1.s below
"16" at B2.n above
"0x86dd" at B2.s below
line &lt;-&gt; "Ethernet" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box ". . ." width 0.2
B1: box "next" width 0.3
B2: box "src" width 0.4
B3: box "dst" width 0.4
"" at B0.n above
"" at B0.s below
"8" at B1.n above
"58" at B1.s below
"128" at B2.n above
"" at B2.s below
"128" at B3.n above
"" at B3.s below
line &lt;-&gt; "IPv6" above from B0.nw + (0,textht) to B3.ne + (0,textht)
]
move .1
[
B0: box "type" width .3
B1: box "code" width .3
B2: box ". . ." width .8
"8" at B0.n above
"135/136" at B0.s below
"8" at B1.n above
"0" at B1.s below
"" at B2.n above
"" at B2.s below
line &lt;-&gt; "ICMPv6" above from B0.nw + (0,textht) to B2.ne + (0,textht)
]
move .1
[
B0: box "target" width .4
B1: box "option . . ." width .6
"128" at B0.n above
"" at B0.s below
"" at B1.n above
"" at B1.s below
line &lt;-&gt; "ICMPv6 ND" above from B0.nw + (0,textht) to B1.ne + (0,textht)
]
.PE
\}

.if n \{
    fL    Ethernet            IPv6              ICMPv6            ICMPv6 ND  
    fL <------------>   <-------------->   <-------------->   <--------------->  
    fL 48  48    16          8   128 128      8     8          128  
    fL+---+---+------+ +---+----+---+---+ +-------+----+---+ +------+----------+  
    fL|dst|src| type | |...|next|src|dst| | type  |code|...| |target|option ...|  
    fL+---+---+------+ +---+----+---+---+ +-------+----+---+ +------+----------+  
    fL         0x86dd        58            135/136  0
\}


**ICMPv6 Neighbor Discovery Target IPv6 Field**
.TS
tab(;);
l lx.
Name:;**nd\_target**
Width:;128 bits
Format:;IPv6
Masking:;arbitrary bitwise masks
Prerequisites:;ND
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_IPV6\_ND\_TARGET** (31) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_ND\_TARGET** (23) since Open vSwitch 1.1
T}
.TE



**ICMPv6 Neighbor Discovery Source Ethernet Address Field**
.TS
tab(;);
l lx.
Name:;**nd\_sll**
Width:;48 bits
Format:;Ethernet
Masking:;arbitrary bitwise masks
Prerequisites:;ND solicit
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_IPV6\_ND\_SLL** (32) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_ND\_SLL** (24) since Open vSwitch 1.1
T}
.TE



**ICMPv6 Neighbor Discovery Target Ethernet Address Field**
.TS
tab(;);
l lx.
Name:;**nd\_tll**
Width:;48 bits
Format:;Ethernet
Masking:;arbitrary bitwise masks
Prerequisites:;ND advert
Access:;read/write
OpenFlow 1.0:;not supported
OpenFlow 1.1:;not supported
OXM:;T{
**OXM\_OF\_IPV6\_ND\_TLL** (33) since OpenFlow 1.2 and Open vSwitch 1.7
T}
NXM:;T{
**NXM\_NX\_ND\_TLL** (25) since Open vSwitch 1.1
T}
.TE



<a name="references"></a>

# References


* Casado  
  M\[char46] Casado, M\[char46] J\[char46] Freedman, J\[char46] Pettit, J\[char46] Luo, N\[char46] McKeown, and S\[char46] Shenker, \`\`Ethane: Taking Control of the Enterprise,’’ Computer Communications Review, October 2007\[char46]
* ERSPAN  
  M\[char46] Foschiano, K\[char46] Ghosh, M\[char46] Mehta, \`\`Cisco Systems’ Encapsulated Remote Switch Port Analyzer (ERSPAN),’’
  .URL "https://tools.ietf.org/html/draft-foschiano-erspan-03"
  \[char46]
* EXT-56  
  J\[char46] Tonsing, \`\`Permit one of a set of prerequisites to apply, e\[char46]g\[char46] don’t preclude non-Ethernet media,’’
  .URL "https://rs.opennetworking.org/bugs/browse/EXT-56"
  (ONF members only)\[char46]
* EXT-112  
  J\[char46] Tourrilhes, \`\`Support non-Ethernet packets throughout the pipeline,’’
  .URL "https://rs.opennetworking.org/bugs/browse/EXT-112"
  (ONF members only)\[char46]
* EXT-134  
  J\[char46] Tourrilhes, \`\`Match first nibble of the MPLS payload,’’
  .URL "https://rs.opennetworking.org/bugs/browse/EXT-134"
  (ONF members only)\[char46]
* Geneve  
  J\[char46] Gross, I\[char46] Ganga, and T\[char46] Sridhar, editors, \`\`Geneve: Generic Network Virtualization Encapsulation,’’
  .URL "https://datatracker.ietf.org/doc/draft-ietf-nvo3-geneve/"
  \[char46]
* IEEE OUI  
  IEEE Standards Association, \`\`MAC Address Block Large (MA-L),’’
  .URL "https://standards.ieee.org/develop/regauth/oui/index.html"
  \[char46]
* NSH  
  P\[char46] Quinn and U\[char46] Elzur, editors, \`\`Network Service Header,’’
  .URL "https://datatracker.ietf.org/doc/draft-ietf-sfc-nsh/"
  \[char46]
* OpenFlow 1\[char46]0\[char46]1  
  Open Networking Foundation, \`\`OpenFlow Switch Errata, Version 1\[char46]0\[char46]1,’’ June 2012\[char46]
* OpenFlow 1\[char46]1  
  OpenFlow Consortium, \`\`OpenFlow Switch Specification Version 1\[char46]1\[char46]0 Implemented (Wire Protocol 0x02),’’ February 2011\[char46]
* OpenFlow 1\[char46]5  
  Open Networking Foundation, \`\`OpenFlow Switch Specification Version 1\[char46]5\[char46]0 (Protocol version 0x06),’’ December 2014\[char46]
* OpenFlow Extensions 1\[char46]3\[char46]x Package 2  
  Open Networking Foundation, \`\`OpenFlow Extensions 1\[char46]3\[char46]x Package 2,’’ December 2013\[char46]
* TCP Flags Match Field Extension  
  Open Networking Foundation, \`\`TCP flags match field Extension,’’ December 2014\[char46] In [OpenFlow Extensions 1\[char46]3\[char46]x Package 2]\[char46]
* Pepelnjak  
  I\[char46] Pepelnjak, \`\`OpenFlow and Fermi Estimates,’’
  .URL "http://blog.ipspace.net/2013/09/openflow-and-fermi-estimates.html"
  \[char46]
* RFC 793  
  \`\`Transmission Control Protocol,’’
  .URL "http://www.ietf.org/rfc/rfc793.txt"
  \[char46]
* RFC 3032  
  E\[char46] Rosen, D\[char46] Tappan, G\[char46] Fedorkow, Y\[char46] Rekhter, D\[char46] Farinacci, T\[char46] Li, and A\[char46] Conta, \`\`MPLS Label Stack Encoding,’’
  .URL "http://www.ietf.org/rfc/rfc3032.txt"
  \[char46]
* RFC 3168  
  K\[char46] Ramakrishnan, S\[char46] Floyd, and D\[char46] Black, \`\`The Addition of Explicit Congestion Notification (ECN) to IP,’’
  .URL "https://tools.ietf.org/html/rfc3168"
  \[char46]
* RFC 3540  
  N\[char46] Spring, D\[char46] Wetherall, and D\[char46] Ely, \`\`Robust Explicit Congestion Notification (ECN) Signaling with Nonces,’’
  .URL "https://tools.ietf.org/html/rfc3540"
  \[char46]
* RFC 4632  
  V\[char46] Fuller and T\[char46] Li, \`\`Classless Inter-domain Routing (CIDR): The Internet Address Assignment and Aggregation Plan,’’
  .URL "https://tools.ietf.org/html/rfc4632"
  \[char46]
* RFC 5462  
  L\[char46] Andersson and R\[char46] Asati, \`\`Multiprotocol Label Switching (MPLS) Label Stack Entry: \`\`EXP’’ Field Renamed to \`\`Traffic Class’’ Field,’’
  .URL "http://www.ietf.org/rfc/rfc5462.txt"
  \[char46]
* RFC 6830  
  D\[char46] Farinacci, V\[char46] Fuller, D\[char46] Meyer, and D\[char46] Lewis, \`\`The Locator/ID Separation Protocol (LISP),’’
  .URL "http://www.ietf.org/rfc/rfc6830.txt"
  \[char46]
* RFC 7348  
  M\[char46] Mahalingam, D\[char46] Dutt, K\[char46] Duda, P\[char46] Agarwal, L\[char46] Kreeger, T\[char46] Sridhar, M\[char46] Bursell, and C\[char46] Wright, \`\`Virtual eXtensible Local Area Network (VXLAN): A Framework for Overlaying Virtualized Layer 2 Networks over Layer 3 Networks, ’’
  .URL "https://tools.ietf.org/html/rfc7348"
  \[char46]
* RFC 7665  
  J\[char46] Halpern, Ed\[char46] and C\[char46] Pignataro, Ed\[char46], \`\`Service Function Chaining (SFC) Architecture,’’
  .URL "https://tools.ietf.org/html/rfc7665"
  \[char46]
* Srinivasan  
  V\[char46] Srinivasan, S\[char46] Suriy, and G\[char46] Varghese, \`\`Packet Classification using Tuple Space Search,’’ SIGCOMM 1999\[char46]
* Pagiamtzis  
  K\[char46] Pagiamtzis and A\[char46] Sheikholeslami, \`\`Content-addressable memory (CAM) circuits and architectures: A tutorial and survey,’’ IEEE Journal of Solid-State Circuits, vol\[char46] 41, no\[char46] 3, pp\[char46] 712-727, March 2006\[char46]
* VXLAN Group Policy Option  
  M\[char46] Smith and L\[char46] Kreeger, \`\` VXLAN Group Policy Option\[char46]’’ Internet-Draft\[char46]
  .URL "https://tools.ietf.org/html/draft-smith-vxlan-group-policy"
  \[char46]

<a name="authors"></a>

# Authors


Ben Pfaff, with advice from Justin Pettit and Jean Tourrilhes\[char46]
