# wireshark-filter(4)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

wireshark-filter - Wireshark display filter syntax and reference

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" wireshark [other options] [&nbsp;-Y&nbsp;display&nbsp;filter&nbsp;expression\*(R"&nbsp;|&nbsp;b<--display-filter \*(L"display filter expression\*(R" ]> 
 tshark [other options] [&nbsp;-Y&nbsp;display&nbsp;filter&nbsp;expression\*(R"&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Wireshark** and **TShark** share a powerful filter engine that helps remove
the noise from a packet trace and lets you see only the packets that interest
you.  If a packet meets the requirements expressed in your filter, then it
is displayed in the list of packets.  Display filters let you compare the
fields within a protocol against a specific value, compare fields against
fields, and check the existence of specified fields or protocols.

Filters are also used by other features such as statistics generation and
packet list colorization (the latter is only available to **Wireshark**). This
manual page describes their syntax. A comprehensive reference of filter fields
can be found within Wireshark and in the display filter reference at
&lt;https://www.wireshark.org/docs/dfref/&gt;.

<a name="filter-syntax"></a>

# Filter Syntax

.IX Header "FILTER SYNTAX"

<a name="check-whether-a-field-or-protocol-exists"></a>

### Check whether a field or protocol exists

.IX Subsection "Check whether a field or protocol exists"
The simplest filter allows you to check for the existence of a protocol or
field.  If you want to see all packets which contain the \s-1IP\s0 protocol, the
filter would be ip\*(R" (without the quotation marks). To see all packets
that contain a Token-Ring \s-1RIF\s0 field, use tr.rif\*(R".

Think of a protocol or field in a filter as implicitly having the exists\*(R"
operator.

<a name="comparison-operators"></a>

### Comparison operators

.IX Subsection "Comparison operators"
Fields can also be compared against values.  The comparison operators
can be expressed either through English-like abbreviations or through
C-like symbols:

.Vb 6
    eq, ==    Equal
    ne, !=    Not Equal
    gt, &gt;     Greater Than
    lt, &lt;     Less Than
    ge, &gt;=    Greater than or Equal to
    le, &lt;=    Less than or Equal to
.Ve

<a name="search-and-match-operators"></a>

### Search and match operators

.IX Subsection "Search and match operators"
Additional operators exist expressed only in English, not C-like syntax:

.Vb 3
    contains     Does the protocol, field or slice contain a value
    matches, ~   Does the protocol or text string match the given
                 case-insensitive Perl-compatible regular expression
.Ve

The contains\*(R" operator allows a filter to search for a sequence of
characters, expressed as a string (quoted or unquoted), or bytes,
expressed as a byte array, or for a single character, expressed as a
C-style character constant.  For example, to search for a given \s-1HTTP
URL\s0 in a capture, the following filter can be used:

.Vb 1
    http contains "https://www.wireshark.org"
.Ve

The contains\*(R" operator cannot be used on atomic fields,
such as numbers or \s-1IP\s0 addresses.

The matches\*(R"  or \*(L"~\*(R" operator allows a filter to apply to a specified
Perl-compatible regular expression (\s-1PCRE\s0).  The matches\*(R" operator is only
implemented for protocols and for protocol fields with a text string
representation. Matches are case-insensitive by default.  For example,
to search for a given \s-1WAP WSP\s0 User-Agent, you can write:

.Vb 1
    wsp.user_agent matches "cldc"
.Ve

This would match cldc\*(R", \*(L"\s-1CLDC\*(R",\s0 \*(L"cLdC\*(R" or any other combination of upper
and lower case letters.

You can force case sensitivity using

.Vb 1
    wsp.user_agent matches "(?-i)cldc"
.Ve

This is an example of \s-1PCRE\s0's **(?**option**)** construct. **(?-i)** performs a
case-sensitive pattern match but other options can be specified as well. More
information can be found in the **pcrepattern**\|(3) man page at
&lt;https://perldoc.perl.org/perlre.html&gt;).

<a name="functions"></a>

### Functions

.IX Subsection "Functions"
The filter language has the following functions:

.Vb 5
    upper(string-field) - converts a string field to uppercase
    lower(string-field) - converts a string field to lowercase
    len(field)          - returns the byte length of a string or bytes field
    count(field)        - returns the number of field occurrences in a frame
    string(field)       - converts a non-string field to string
.Ve

**upper()** and **lower()** are useful for performing case-insensitive string
comparisons. For example:

.Vb 2
    upper(ncp.nds_stream_name) contains "MACRO"
    lower(mount.dump.hostname) == "angel"
.Ve

**string()** converts a field value to a string, suitable for use with operators like
matches\*(R" or \*(L"contains\*(R". Integer fields are converted to their decimal representation.
It can be used with IP/Ethernet addresses (as well as others), but not with string or
byte fields. For example:

.Vb 1
    string(frame.number) matches "[13579]$"
.Ve

gives you all the odd packets.

<a name="protocol-field-types"></a>

### Protocol field types

.IX Subsection "Protocol field types"
Each protocol field is typed. The types are:

.Vb 10
    ASN.1 object identifier
    Boolean
    Character string
    Compiled Perl-Compatible Regular Expression (GRegex) object
    Date and time
    Ethernet or other MAC address
    EUI64 address
    Floating point (double-precision)
    Floating point (single-precision)
    Frame number
    Globally Unique Identifier
    IPv4 address
    IPv6 address
    IPX network number
    Label
    Protocol
    Sequence of bytes
    Signed integer, 1, 2, 3, 4, or 8 bytes
    Time offset
    Unsigned integer, 1, 2, 3, 4, or 8 bytes
    1-byte ASCII character
.Ve

An integer may be expressed in decimal, octal, or hexadecimal notation,
or as a C-style character constant.  The following six display filters
are equivalent:

.Vb 6
    frame.pkt_len &gt; 10
    frame.pkt_len &gt; 012
    frame.pkt_len &gt; 0xa
    frame.pkt_len &gt; \en\*(Aq
    frame.pkt_len &gt; \exa\*(Aq
    frame.pkt_len &gt; \e012\*(Aq
.Ve

Boolean values are either true or false.  In a display filter expression
testing the value of a Boolean field, true\*(R" is expressed as 1 or any
other non-zero value, and false\*(R" is expressed as zero.  For example, a
token-ring packet's source route field is Boolean.  To find any
source-routed packets, a display filter would be:

.Vb 1
    tr.sr == 1
.Ve

Non source-routed packets can be found with:

.Vb 1
    tr.sr == 0
.Ve

Ethernet addresses and byte arrays are represented by hex
digits.  The hex digits may be separated by colons, periods, or hyphens:

.Vb 4
    eth.dst eq ff:ff:ff:ff:ff:ff
    aim.data == 0.1.0.d
    fddi.src == aa-aa-aa-aa-aa-aa
    echo.data == 7a
.Ve

IPv4 addresses can be represented in either dotted decimal notation or
by using the hostname:

.Vb 2
    ip.dst eq www.mit.edu
    ip.src == 192.168.1.1
.Ve

IPv4 addresses can be compared with the same logical relations as numbers:
eq, ne, gt, ge, lt, and le.  The IPv4 address is stored in host order,
so you do not have to worry about the endianness of an IPv4 address
when using it in a display filter.

Classless InterDomain Routing (\s-1CIDR\s0) notation can be used to test if an
IPv4 address is in a certain subnet.  For example, this display filter
will find all packets in the 129.111 Class-B network:

.Vb 1
    ip.addr == 129.111.0.0/16
.Ve

Remember, the number after the slash represents the number of bits used
to represent the network.  \s-1CIDR\s0 notation can also be used with
hostnames, as in this example of finding \s-1IP\s0 addresses on the same Class C
network as 'sneezy':

.Vb 1
    ip.addr eq sneezy/24
.Ve

The \s-1CIDR\s0 notation can only be used on \s-1IP\s0 addresses or hostnames, not in
variable names.  So, a display filter like ip.src/24 == ip.dst/24\*(R" is
not valid (yet).

\s-1IPX\s0 networks are represented by unsigned 32-bit integers.  Most likely
you will be using hexadecimal when testing \s-1IPX\s0 network values:

.Vb 1
    ipx.src.net == 0xc0a82c00
.Ve

Strings are enclosed in double quotes:

.Vb 1
    http.request.method == "POST"
.Ve

Inside double quotes, you may use a backslash to embed a double quote
or an arbitrary byte represented in either octal or hexadecimal.

.Vb 1
    browser.comment == "An embedded \e" double-quote"
.Ve

Use of hexadecimal to look for \s-1HEAD\*(R":\s0

.Vb 1
    http.request.method == "\ex48EAD"
.Ve

Use of octal to look for \s-1HEAD\*(R":\s0

.Vb 1
    http.request.method == "\e110EAD"
.Ve

This means that you must escape backslashes with backslashes inside
double quotes.

.Vb 1
    smb.path contains "\e\e\e\eSERVER\e\eSHARE"
.Ve

looks for \e\eSERVER\eSHARE in smb.path\*(R".

<a name="the-slice-operator"></a>

### The slice operator

.IX Subsection "The slice operator"
You can take a slice of a field if the field is a text string or a
byte array.
For example, you can filter on
the vendor portion of an ethernet address (the first three bytes) like
this:

.Vb 1
    eth.src[0:3] == 00:00:83
.Ve

Another example is:

.Vb 1
    http.content_type[0:4] == "text"
.Ve

You can use the slice operator on a protocol name, too.
The frame\*(R" protocol can be useful, encompassing all the data captured
by **Wireshark** or **TShark**.

.Vb 3
    token[0:5] ne 0.0.0.1.1
    llc[0] eq aa
    frame[100-199] contains "wireshark"
.Ve

The following syntax governs slices:

.Vb 5
    [i:j]    i = start_offset, j = length
    [i-j]    i = start_offset, j = end_offset, inclusive.
    [i]      i = start_offset, length = 1
    [:j]     start_offset = 0, length = j
    [i:]     start_offset = i, end_offset = end_of_field
.Ve

Offsets can be negative, in which case they indicate the
offset from the **end** of the field.  The last byte of the field is at offset
-1, the last but one byte is at offset -2, and so on.
Here's how to check the last four bytes of a frame:

.Vb 1
    frame[-4:4] == 0.1.2.3
.Ve

or

.Vb 1
    frame[-4:] == 0.1.2.3
.Ve

A slice is always compared against either a string or a byte sequence.
As a special case, when the slice is only 1 byte wide, you can compare
it against a hex integer that 0xff or less (which means it fits inside
one byte). This is not allowed for byte sequences greater than one byte,
because then one would need to specify the endianness of the multi-byte
integer. Also, this is not allowed for decimal numbers, since they
would be confused with hex numbers that are already allowed as
byte strings. Nevertheless, single-byte hex integers can be convenient:

.Vb 1
    frame[4] == 0xff
.Ve

Slices can be combined. You can concatenate them using the comma operator:

.Vb 1
    ftp[1,3-5,9:] == 01:03:04:05:09:0a:0b
.Ve

This concatenates offset 1, offsets 3-5, and offset 9 to the end of the ftp
data.

<a name="the-membership-operator"></a>

### The membership operator

.IX Subsection "The membership operator"
A field may be checked for matches against a set of values simply with the
membership operator. For instance, you may find traffic on common \s-1HTTP/HTTPS\s0
ports with the following filter:

.Vb 1
    tcp.port in {80 443 8080}
.Ve

as opposed to the more verbose:

.Vb 1
    tcp.port == 80 or tcp.port == 443 or tcp.port == 8080
.Ve

To find \s-1HTTP\s0 requests using the \s-1HEAD\s0 or \s-1GET\s0 methods:

.Vb 1
    http.request.method in {"HEAD" "GET"}
.Ve

The set of values can also contain ranges:

.Vb 3
    tcp.port in {443 4430..4434}
    ip.addr in {10.0.0.5 .. 10.0.0.9 192.168.1.1..192.168.1.9}
    frame.time_delta in {10 .. 10.5}
.Ve

<a name="type-conversions"></a>

### Type conversions

.IX Subsection "Type conversions"
If a field is a text string or a byte array, it can be expressed in whichever
way is most convenient.

So, for instance, the following filters are equivalent:

.Vb 2
    http.request.method == "GET"
    http.request.method == 47.45.54
.Ve

A range can also be expressed in either way:

.Vb 2
    frame[60:2] gt 50.51
    frame[60:2] gt "PQ"
.Ve

<a name="bit-field-operations"></a>

### Bit field operations

.IX Subsection "Bit field operations"
It is also possible to define tests with bit field operations. Currently the
following bit field operation is supported:

.Vb 1
    bitwise_and, &      Bitwise AND
.Ve

The bitwise \s-1AND\s0 operation allows testing to see if one or more bits are set.
Bitwise \s-1AND\s0 operates on integer protocol fields and slices.

When testing for \s-1TCP SYN\s0 packets, you can write:

.Vb 1
    tcp.flags & 0x02
.Ve

That expression will match all packets that contain a tcp.flags\*(R" field
with the 0x02 bit, i.e. the \s-1SYN\s0 bit, set.

Similarly, filtering for all \s-1WSP GET\s0 and extended \s-1GET\s0 methods is achieved with:

.Vb 1
    wsp.pdu_type & 0x40
.Ve

When using slices, the bit mask must be specified as a byte string, and it must
have the same number of bytes as the slice itself, as in:

.Vb 1
    ip[42:2] & 40:ff
.Ve

<a name="logical-expressions"></a>

### Logical expressions

.IX Subsection "Logical expressions"
Tests can be combined using logical expressions.
These too are expressible in C-like syntax or with English-like
abbreviations:

.Vb 3
    and, &&   Logical AND
    or,  ||   Logical OR
    not, !    Logical NOT
.Ve

Expressions can be grouped by parentheses as well.  The following are
all valid display filter expressions:

.Vb 4
    tcp.port == 80 and ip.src == 192.168.2.1
    not llc
    http and frame[100-199] contains "wireshark"
    (ipx.src.net == 0xbad && ipx.src.node == 0.0.0.0.0.1) || ip
.Ve

Remember that whenever a protocol or field name occurs in an expression, the
exists\*(R" operator is implicitly called. The \*(L"exists\*(R" operator has the highest
priority. This means that the first filter expression must be read as show me
the packets for which tcp.port exists and equals 80, and ip.src exists and
equals 192.168.2.1. The second filter expression means \*(L"show me the packets
where not (llc exists), or in other words \*(L"where llc does not exist\*(R" and hence
will match all packets that do not contain the llc protocol.
The third filter expression includes the constraint that offset 199 in the
frame exists, in other words the length of the frame is at least 200.

A special caveat must be given regarding fields that occur more than
once per packet.  ip.addr\*(R" occurs twice per \s-1IP\s0 packet, once for the
source address, and once for the destination address.  Likewise,
tr.rif.ring\*(R" fields can occur more than once per packet.  The following
two expressions are not equivalent:

.Vb 2
        ip.addr ne 192.168.4.1
    not ip.addr eq 192.168.4.1
.Ve

The first filter says show me packets where an ip.addr exists that
does not equal 192.168.4.1.  That is, as long as one ip.addr in the
packet does not equal 192.168.4.1, the packet passes the display
filter.  The other ip.addr could equal 192.168.4.1 and the packet would
still be displayed.
The second filter says don't show me any packets that have an
ip.addr field equal to 192.168.4.1.  If one ip.addr is 192.168.4.1,
the packet does not pass.  If **neither** ip.addr field is 192.168.4.1,
then the packet is displayed.

It is easy to think of the 'ne' and 'eq' operators as having an implicit
exists\*(R" modifier when dealing with multiply-recurring fields.  \*(L"ip.addr
ne 192.168.4.1 can be thought of as \*(L"there exists an ip.addr that does
not equal 192.168.4.1.  \*(L"not ip.addr eq 192.168.4.1\*(R" can be thought of as
there does not exist an ip.addr equal to 192.168.4.1\*(R".

Be careful with multiply-recurring fields; they can be confusing.

Care must also be taken when using the display filter to remove noise
from the packet trace. If, for example, you want to filter out all \s-1IP\s0
multicast packets to address 224.1.2.3, then using:

.Vb 1
    ip.dst ne 224.1.2.3
.Ve

may be too restrictive. Filtering with ip.dst\*(R" selects only those
**\s-1IP\s0** packets that satisfy the rule. Any other packets, including all
non-IP packets, will not be displayed. To display the non-IP
packets as well, you can use one of the following two expressions:

.Vb 2
    not ip or ip.dst ne 224.1.2.3
    not ip.addr eq 224.1.2.3
.Ve

The first filter uses not ip\*(R" to include all non-IP packets and then
lets ip.dst ne 224.1.2.3\*(R" filter out the unwanted \s-1IP\s0 packets. The
second filter has already been explained above where filtering with
multiply occurring fields was discussed.

<a name="filter-field-reference"></a>

# Filter Field Reference

.IX Header "FILTER FIELD REFERENCE"
The entire list of display filters is too large to list here. You can
can find references and examples at the following locations:

* ·  
  The online Display Filter Reference: &lt;https://www.wireshark.org/docs/dfref/&gt;
* ·  
  _Help:Supported Protocols_ in Wireshark
* ·  
  \f(CW`tshark -G fields\*(C' on the command line
* ·  
  The Wireshark wiki: &lt;https://gitlab.com/wireshark/wireshark/-/wikis/DisplayFilters&gt;

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The **wireshark-filters** manpage is part of the **Wireshark** distribution.
The latest version of **Wireshark** can be found at
&lt;https://www.wireshark.org&gt;.

Regular expressions in the matches\*(R" operator are provided by GRegex in GLib.
See &lt;https://developer.gnome.org/glib/2.32/glib-regex-syntax.html&gt; or &lt;https://www.pcre.org/&gt; for more information.

This manpage does not describe the capture filter syntax, which is
different. See the manual page of **pcap-filter**\|(7) or, if that doesn't exist,
**tcpdump**\|(8), or, if that doesn't exist, &lt;https://gitlab.com/wireshark/wireshark/-/wikis/CaptureFilters&gt;
for a description of capture filters.

Display Filters are also described in the User's Guide:
&lt;https://www.wireshark.org/docs/wsug_html_chunked/ChWorkBuildDisplayFilterSection.html&gt;

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **editcap**\|(1), **pcap**\|(3), **pcap-filter**\|(7) or **tcpdump**\|(8) if it
doesn't exist.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
See the list of authors in the **Wireshark** man page for a list of authors of
that code.
