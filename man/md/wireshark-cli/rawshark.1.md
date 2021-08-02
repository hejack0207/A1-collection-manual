# rawshark(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

rawshark - Dump and analyze raw pcap data

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" rawshark [&nbsp;-d&nbsp;<encap:linktype>|<proto:protoname>&nbsp;] [&nbsp;-F&nbsp;<field&nbsp;to&nbsp;display>&nbsp;] [&nbsp;-h&nbsp;] [&nbsp;-l&nbsp;] [&nbsp;-m&nbsp;<bytes>&nbsp;] [&nbsp;-n&nbsp;] [&nbsp;-N&nbsp;<name&nbsp;resolving&nbsp;flags>&nbsp;] [&nbsp;-o&nbsp;<preference&nbsp;setting>&nbsp;]&nbsp;... [&nbsp;-p&nbsp;] [&nbsp;-r&nbsp;<pipe>|-&nbsp;] [&nbsp;-R&nbsp;<read&nbsp;(display)&nbsp;filter>&nbsp;] [&nbsp;-s&nbsp;] [&nbsp;-S&nbsp;<field&nbsp;format>&nbsp;] [&nbsp;-t&nbsp;a|ad|adoy|d|dd|e|r|u|ud|udoy&nbsp;] [&nbsp;-v&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Rawshark** reads a stream of packets from a file or pipe, and prints a line
describing its output, followed by a set of matching fields for each packet
on stdout.

<a name="input"></a>

# Input

.IX Header "INPUT"
Unlike **TShark**, **Rawshark** makes no assumptions about encapsulation or
input. The **-d** and **-r** flags must be specified in order for it to run.
One or more **-F** flags should be specified in order for the output to be
useful. The other flags listed above follow the same conventions as
**Wireshark** and **TShark**.

**Rawshark** expects input records with the following format by default. This
matches the format of the packet header and packet data in a pcap-formatted
file on disk.

.Vb 7
    struct rawshark_rec_s {
        uint32_t ts_sec;      /* Time stamp (seconds) */
        uint32_t ts_usec;     /* Time stamp (microseconds) */
        uint32_t caplen;      /* Length of the packet buffer */
        uint32_t len;         /* "On the wire" length of the packet */
        uint8_t data[caplen]; /* Packet data */
    };
.Ve

If **-p** is supplied **rawshark** expects the following format.  This
matches the _struct pcap\_pkthdr_ structure and packet data used in
libpcap, Npcap, or WinPcap.  This structure's format is platform-dependent; the
size of the _tv\_sec_ field in the _struct timeval_ structure could be
32 bits or 64 bits.  For **rawshark** to work, the layout of the
structure in the input must match the layout of the structure in
**rawshark**.  Note that this format will probably be the same as the
previous format if **rawshark** is a 32-bit program, but will not
necessarily be the same if **rawshark** is a 64-bit program.

.Vb 6
    struct rawshark_rec_s {
        struct timeval ts;    /* Time stamp */
        uint32_t caplen;      /* Length of the packet buffer */
        uint32_t len;         /* "On the wire" length of the packet */
        uint8_t data[caplen]; /* Packet data */
    };
.Ve

In either case, the endianness (byte ordering) of each integer must match the
system on which **rawshark** is running.

<a name="output"></a>

# Output

.IX Header "OUTPUT"
If one or more fields are specified via the **-F** flag, **Rawshark** prints
the number, field type, and display format for each field on the first line
as packet number\*(R" 0. For each record, the packet number, matching fields,
and a 1\*(R" or \*(L"0\*(R" are printed to indicate if the field matched any supplied
display filter. A -\*(R" is used to signal the end of a field description and
at the end of each packet line. For example, the flags -F ip.src -F
dns.qry.type might generate the following output:

.Vb 5
    0 FT_IPv4 BASE_NONE - 1 FT_UINT16 BASE_HEX -
    1 1="1" 0="192.168.77.10" 1 -
    2 1="1" 0="192.168.77.250" 1 -
    3 0="192.168.77.10" 1 -
    4 0="74.125.19.104" 1 -
.Ve

Note that packets 1 and 2 are \s-1DNS\s0 queries, and 3 and 4 are not. Adding **-R not dns\*(R"** still prints each line, but there's an indication
that packets 1 and 2 didn't pass the filter:

.Vb 5
    0 FT_IPv4 BASE_NONE - 1 FT_UINT16 BASE_HEX -
    1 1="1" 0="192.168.77.10" 0 -
    2 1="1" 0="192.168.77.250" 0 -
    3 0="192.168.77.10" 1 -
    4 0="74.125.19.104" 1 -
.Ve

Also note that the output may be in any order, and that multiple matching
fields might be displayed.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -d  &lt;encapsulation&gt;  
  .IX Item "-d &lt;encapsulation&gt;"
  Specify how the packet data should be dissected. The encapsulation is of the
  form _type_**:**_value_, where _type_ is one of:
  .Sp
  **encap**:_name_ Packet data should be dissected using the
  libpcap/Npcap/WinPcap data link type (\s-1DLT\s0) _name_, e.g. **encap:EN10MB** for
  Ethernet.  Names are converted using **pcap\_datalink\_name\_to\_val()**.
  A complete list of DLTs can be found at
  &lt;https://www.tcpdump.org/linktypes.html&gt;.
  .Sp
  **encap**:_number_ Packet data should be dissected using the
  libpcap/Npcap/WinPcap \s-1LINKTYPE_\s0 _number_, e.g. **encap:105** for raw \s-1IEEE
  802.11\s0 or **encap:101** for raw \s-1IP.\s0
  .Sp
  **proto**:_protocol_ Packet data should be passed to the specified Wireshark
  protocol dissector, e.g. **proto:http** for \s-1HTTP\s0 data.
* -F  &lt;field to display&gt;  
  .IX Item "-F &lt;field to display&gt;"
  Add the matching field to the output. Fields are any valid display filter
  field. More than one **-F** flag may be specified, and each field can match
  multiple times in a given packet. A single field may be specified per **-F**
  flag. If you want to apply a display filter, use the **-R** flag.
* -h  
  .IX Item "-h"
  Print the version and options and exits.
* -l  
  .IX Item "-l"
  Flush the standard output after the information for each packet is
  printed.  (This is not, strictly speaking, line-buffered if **-V**
  was specified; however, it is the same as line-buffered if **-V** wasn't
  specified, as only one line is printed for each packet, and, as **-l** is
  normally used when piping a live capture to a program or script, so that
  output for a packet shows up as soon as the packet is seen and
  dissected, it should work just as well as true line-buffering.  We do
  this as a workaround for a deficiency in the Microsoft Visual  C
  library.)
  .Sp
  This may be useful when piping the output of **TShark** to another
  program, as it means that the program to which the output is piped will
  see the dissected data for a packet as soon as **TShark** sees the
  packet and generates that output, rather than seeing it only when the
  standard output buffer containing that data fills up.
* -m  &lt;memory limit bytes&gt;  
  .IX Item "-m &lt;memory limit bytes&gt;"
  Limit rawshark's memory usage to the specified number of bytes. \s-1POSIX\s0
  (non-Windows) only.
* -n  
  .IX Item "-n"
  Disable network object name resolution (such as hostname, \s-1TCP\s0 and \s-1UDP\s0 port
  names), the **-N** flag might override this one.
* -N  &lt;name resolving flags&gt;  
  .IX Item "-N &lt;name resolving flags&gt;"
  Turn on name resolving only for particular types of addresses and port
  numbers, with name resolving for other types of addresses and port
  numbers turned off. This flag overrides **-n** if both **-N** and **-n** are
  present. If both **-N** and **-n** flags are not present, all name resolutions are
  turned on.
  .Sp
  The argument is a string that may contain the letters:
  .Sp
  **m** to enable \s-1MAC\s0 address resolution
  .Sp
  **n** to enable network address resolution
  .Sp
  **N** to enable using external resolvers (e.g., \s-1DNS\s0) for network address
  resolution
  .Sp
  **t** to enable transport-layer port number resolution
  .Sp
  **d** to enable resolution from captured \s-1DNS\s0 packets
  .Sp
  **v** to enable \s-1VLAN\s0 IDs to names resolution
* -o  &lt;preference&gt;:&lt;value&gt;  
  .IX Item "-o &lt;preference&gt;:&lt;value&gt;"
  Set a preference value, overriding the default value and any value read
  from a preference file.  The argument to the option is a string of the
  form _prefname_**:**_value_, where _prefname_ is the name of the
  preference (which is the same name that would appear in the preference
  file), and _value_ is the value to which it should be set.
* -p  
  .IX Item "-p"
  Assume that packet data is preceded by a pcap_pkthdr struct as defined in
  pcap.h. On some systems the size of the timestamp data will be different from
  the data written to disk. On other systems they are identical and this flag has
  no effect.
* -r  &lt;pipe&gt;|-  
  .IX Item "-r &lt;pipe&gt;|-"
  Read packet data from _input source_. It can be either the name of a \s-1FIFO\s0
  (named pipe) or \`\`-'' to read data from the standard input, and must have
  the record format specified above.
  .Sp
  If you are sending data to rawshark from a parent process on Windows you
  should not close rawshark's standard input handle prematurely, otherwise
  the C runtime might trigger an exception.
* -R  &lt;read (display) filter&gt;  
  .IX Item "-R &lt;read (display) filter&gt;"
  Cause the specified filter (which uses the syntax of read/display filters,
  rather than that of capture filters) to be applied before printing the output.
* -s  
  .IX Item "-s"
  Allows standard pcap files to be used as input, by skipping over the 24
  byte pcap file header.
* -S  
  .IX Item "-S"
  Use the specified format string to print each field. The following formats
  are supported:
  .Sp
  **\f(CB%D** Field name or description, e.g. Type\*(R" for dns.qry.type
  .Sp
  **\f(CB%N** Base 10 numeric value of the field.
  .Sp
  **\f(CB%S** String value of the field.
  .Sp
  For something similar to Wireshark's standard display (Type: A (1)\*(R") you
  could use **\f(CB%D: \f(CB%S (%N)**.
* -t  a|ad|adoy|d|dd|e|r|u|ud|udoy  
  .IX Item "-t a|ad|adoy|d|dd|e|r|u|ud|udoy"
  Set the format of the packet timestamp printed in summary lines.
  The format can be one of:
  .Sp
  **a** absolute: The absolute time, as local time in your time zone,
  is the actual time the packet was captured, with no date displayed
  .Sp
  **ad** absolute with date: The absolute date, displayed as YYYY-MM-DD,
  and time, as local time in your time zone, is the actual time and date
  the packet was captured
  .Sp
  **adoy** absolute with date using day of year: The absolute date,
  displayed as \s-1YYYY/DOY,\s0 and time, as local time in your time zone,
  is the actual time and date the packet was captured
  .Sp
  **d** delta: The delta time is the time since the previous packet was
  captured
  .Sp
  **dd** delta_displayed: The delta_displayed time is the time since the
  previous displayed packet was captured
  .Sp
  **e** epoch: The time in seconds since epoch (Jan 1, 1970 00:00:00)
  .Sp
  **r** relative: The relative time is the time elapsed between the first packet
  and the current packet
  .Sp
  **u** \s-1UTC:\s0 The absolute time, as \s-1UTC,\s0 is the actual time the packet was
  captured, with no date displayed
  .Sp
  **ud** \s-1UTC\s0 with date: The absolute date, displayed as YYYY-MM-DD,
  and time, as \s-1UTC,\s0 is the actual time and date the packet was captured
  .Sp
  **udoy** \s-1UTC\s0 with date using day of year: The absolute date, displayed
  as \s-1YYYY/DOY,\s0 and time, as \s-1UTC,\s0 is the actual time and date the packet
  was captured
  .Sp
  The default format is relative.
* -v  
  .IX Item "-v"
  Print the version and exit.

<a name="read-filter-syntax"></a>

# Read Filter Syntax

.IX Header "READ FILTER SYNTAX"
For a complete table of protocol and protocol fields that are filterable
in **TShark** see the **wireshark-filter**\|(4) manual page.

<a name="files"></a>

# Files

.IX Header "FILES"
These files contains various **Wireshark** configuration values.

* Preferences  
  .IX Item "Preferences"
  The _preferences_ files contain global (system-wide) and personal
  preference settings. If the system-wide preference file exists, it is
  read first, overriding the default settings. If the personal preferences
  file exists, it is read next, overriding any previous values. Note: If
  the command line option **-o** is used (possibly more than once), it will
  in turn override values from the preferences files.
  .Sp
  The preferences settings are in the form _prefname_**:**_value_,
  one per line,
  where _prefname_ is the name of the preference
  and _value_ is the value to
  which it should be set; white space is allowed between **:** and
  _value_.  A preference setting can be continued on subsequent lines by
  indenting the continuation lines with white space.  A **#** character
  starts a comment that runs to the end of the line:
  .Sp
  .Vb 3
    # Capture in promiscuous mode?
    # TRUE or FALSE (case-insensitive).
    capture.prom_mode: TRUE
  .Ve
  .Sp
  The global preferences file is looked for in the _wireshark_ directory
  under the _share_ subdirectory of the main installation directory (for
  example, _/usr/local/share/wireshark/preferences_) on UNIX-compatible
  systems, and in the main installation directory (for example,
  _C:\eProgram Files\eWireshark\epreferences_) on Windows systems.
  .Sp
  The personal preferences file is looked for in
  _\f(CI$XDG\_CONFIG\_HOME/wireshark/preferences_
  (or, if _\f(CI$XDG\_CONFIG\_HOME/wireshark_ does not exist while _\f(CI$HOME/.wireshark_
  is present, _\f(CI$HOME/.wireshark/preferences_) on
  UNIX-compatible systems and _\f(CI%APPDATA%\eWireshark\epreferences_ (or, if
  \f(CW%APPDATA% isn't defined, \f(CI%USERPROFILE%\eApplication
  Data\eWireshark\epreferences) on Windows systems.
* Disabled (Enabled) Protocols  
  .IX Item "Disabled (Enabled) Protocols"
  The _disabled\_protos_ files contain system-wide and personal lists of
  protocols that have been disabled, so that their dissectors are never
  called.  The files contain protocol names, one per line, where the
  protocol name is the same name that would be used in a display filter
  for the protocol:
  .Sp
  .Vb 2
    http
    tcp     # a comment
  .Ve
  .Sp
  The global _disabled\_protos_ file uses the same directory as the global
  preferences file.
  .Sp
  The personal _disabled\_protos_ file uses the same directory as the
  personal preferences file.
* Name Resolution (hosts)  
  .IX Item "Name Resolution (hosts)"
  If the personal _hosts_ file exists, it is
  used to resolve IPv4 and IPv6 addresses before any other
  attempts are made to resolve them.  The file has the standard _hosts_
  file syntax; each line contains one \s-1IP\s0 address and name, separated by
  whitespace. The same directory as for the personal preferences file is
  used.
  .Sp
  Capture filter name resolution is handled by libpcap on UNIX-compatible
  systems and Npcap or WinPcap on Windows.  As such the Wireshark personal
  _hosts_ file will not be consulted for capture filter name resolution.
* Name Resolution (subnets)  
  .IX Item "Name Resolution (subnets)"
  If an IPv4 address cannot be translated via name resolution (no exact
  match is found) then a partial match is attempted via the _subnets_ file.
  .Sp
  Each line of this file consists of an IPv4 address, a subnet mask length
  separated only by a / and a name separated by whitespace. While the address
  must be a full IPv4 address, any values beyond the mask length are subsequently
  ignored.
  .Sp
  An example is:
  .Sp
  # Comments must be prepended by the # sign!
  192.168.0.0/24 ws_test_network
  .Sp
  A partially matched name will be printed as subnet-name.remaining-address\*(R".
  For example, 192.168.0.1\*(R" under the subnet above would be printed as
  ws_test_network.1\*(R"; if the mask length above had been 16 rather than 24, the
  printed address would be \`\`ws_test_network.0.1".
* Name Resolution (ethers)  
  .IX Item "Name Resolution (ethers)"
  The _ethers_ files are consulted to correlate 6-byte hardware addresses to
  names. First the personal _ethers_ file is tried and if an address is not
  found there the global _ethers_ file is tried next.
  .Sp
  Each line contains one hardware address and name, separated by
  whitespace.  The digits of the hardware address are separated by colons
  (:), dashes (-) or periods (.).  The same separator character must be
  used consistently in an address. The following three lines are valid
  lines of an _ethers_ file:
  .Sp
  .Vb 3
    ff:ff:ff:ff:ff:ff          Broadcast
    c0-00-ff-ff-ff-ff          TR_broadcast
    00.00.00.00.00.00          Zero_broadcast
  .Ve
  .Sp
  The global _ethers_ file is looked for in the _/etc_ directory on
  UNIX-compatible systems, and in the main installation directory (for
  example, _C:\eProgram Files\eWireshark_) on Windows systems.
  .Sp
  The personal _ethers_ file is looked for in the same directory as the personal
  preferences file.
  .Sp
  Capture filter name resolution is handled by libpcap on UNIX-compatible
  systems and Npcap or WinPcap on Windows.  As such the Wireshark personal
  _ethers_ file will not be consulted for capture filter name resolution.
* Name Resolution (manuf)  
  .IX Item "Name Resolution (manuf)"
  The _manuf_ file is used to match the 3-byte vendor portion of a 6-byte
  hardware address with the manufacturer's name; it can also contain well-known
  \s-1MAC\s0 addresses and address ranges specified with a netmask.  The format of the
  file is the same as the _ethers_ files, except that entries of the form:
  .Sp
  .Vb 1
    00:00:0C      Cisco
  .Ve
  .Sp
  can be provided, with the 3-byte \s-1OUI\s0 and the name for a vendor, and
  entries such as:
  .Sp
  .Vb 1
    00-00-0C-07-AC/40     All-HSRP-routers
  .Ve
  .Sp
  can be specified, with a \s-1MAC\s0 address and a mask indicating how many bits
  of the address must match. The above entry, for example, has 40
  significant bits, or 5 bytes, and would match addresses from
  00-00-0C-07-AC-00 through 00-00-0C-07-AC-FF. The mask need not be a
  multiple of 8.
  .Sp
  The _manuf_ file is looked for in the same directory as the global
  preferences file.
* Name Resolution (services)  
  .IX Item "Name Resolution (services)"
  The _services_ file is used to translate port numbers into names.
  .Sp
  The file has the standard _services_ file syntax; each line contains one
  (service) name and one transport identifier separated by white space.  The
  transport identifier includes one port number and one transport protocol name
  (typically tcp, udp, or sctp) separated by a /.
  .Sp
  An example is:
  .Sp
  mydns       5045/udp     # My own Domain Name Server
  mydns       5045/tcp     # My own Domain Name Server
* Name Resolution (ipxnets)  
  .IX Item "Name Resolution (ipxnets)"
  The _ipxnets_ files are used to correlate 4-byte \s-1IPX\s0 network numbers to
  names. First the global _ipxnets_ file is tried and if that address is not
  found there the personal one is tried next.
  .Sp
  The format is the same as the _ethers_
  file, except that each address is four bytes instead of six.
  Additionally, the address can be represented as a single hexadecimal
  number, as is more common in the \s-1IPX\s0 world, rather than four hex octets.
  For example, these four lines are valid lines of an _ipxnets_ file:
  .Sp
  .Vb 4
    C0.A8.2C.00              HR
    c0-a8-1c-00              CEO
    00:00:BE:EF              IT_Server1
    110f                     FileServer3
  .Ve
  .Sp
  The global _ipxnets_ file is looked for in the _/etc_ directory on
  UNIX-compatible systems, and in the main installation directory (for
  example, _C:\eProgram Files\eWireshark_) on Windows systems.
  .Sp
  The personal _ipxnets_ file is looked for in the same directory as the
  personal preferences file.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"

* \s-1WIRESHARK_CONFIG_DIR\s0  
  .IX Item "WIRESHARK_CONFIG_DIR"
  This environment variable overrides the location of personal configuration
  files. It defaults to _\f(CI$XDG\_CONFIG\_HOME/wireshark_ (or _\f(CI$HOME/.wireshark_ if
  the former is missing while the latter exists). On Windows,
  _\f(CI%APPDATA%\eWireshark_ is used instead. Available since Wireshark 3.0.
* \s-1WIRESHARK_DEBUG_WMEM_OVERRIDE\s0  
  .IX Item "WIRESHARK_DEBUG_WMEM_OVERRIDE"
  Setting this environment variable forces the wmem framework to use the
  specified allocator backend for *all* allocations, regardless of which
  backend is normally specified by the code. This is mainly useful to developers
  when testing or debugging. See _\s-1README\s0.wmem_ in the source distribution for
  details.
* \s-1WIRESHARK_RUN_FROM_BUILD_DIRECTORY\s0  
  .IX Item "WIRESHARK_RUN_FROM_BUILD_DIRECTORY"
  This environment variable causes the plugins and other data files to be loaded
  from the build directory (where the program was compiled) rather than from the
  standard locations.  It has no effect when the program in question is running
  with root (or setuid) permissions on *NIX.
* \s-1WIRESHARK_DATA_DIR\s0  
  .IX Item "WIRESHARK_DATA_DIR"
  This environment variable causes the various data files to be loaded from
  a directory other than the standard locations.  It has no effect when the
  program in question is running with root (or setuid) permissions on *NIX.
* \s-1ERF_RECORDS_TO_CHECK\s0  
  .IX Item "ERF_RECORDS_TO_CHECK"
  This environment variable controls the number of \s-1ERF\s0 records checked when
  deciding if a file really is in the \s-1ERF\s0 format.  Setting this environment
  variable a number higher than the default (20) would make false positives
  less likely.
* \s-1IPFIX_RECORDS_TO_CHECK\s0  
  .IX Item "IPFIX_RECORDS_TO_CHECK"
  This environment variable controls the number of \s-1IPFIX\s0 records checked when
  deciding if a file really is in the \s-1IPFIX\s0 format.  Setting this environment
  variable a number higher than the default (20) would make false positives
  less likely.
* \s-1WIRESHARK_ABORT_ON_DISSECTOR_BUG\s0  
  .IX Item "WIRESHARK_ABORT_ON_DISSECTOR_BUG"
  If this environment variable is set, **Rawshark** will call **abort**\|(3)
  when a dissector bug is encountered.  **abort**\|(3) will cause the program to
  exit abnormally; if you are running **Rawshark** in a debugger, it
  should halt in the debugger and allow inspection of the process, and, if
  you are not running it in a debugger, it will, on some OSes, assuming
  your environment is configured correctly, generate a core dump file.
  This can be useful to developers attempting to troubleshoot a problem
  with a protocol dissector.
* \s-1WIRESHARK_ABORT_ON_TOO_MANY_ITEMS\s0  
  .IX Item "WIRESHARK_ABORT_ON_TOO_MANY_ITEMS"
  If this environment variable is set, **Rawshark** will call **abort**\|(3)
  if a dissector tries to add too many items to a tree (generally this
  is an indication of the dissector not breaking out of a loop soon enough).
  **abort**\|(3) will cause the program to exit abnormally; if you are running
  **Rawshark** in a debugger, it should halt in the debugger and allow
  inspection of the process, and, if you are not running it in a debugger,
  it will, on some OSes, assuming your environment is configured correctly,
  generate a core dump file.  This can be useful to developers attempting to
  troubleshoot a problem with a protocol dissector.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark-filter**\|(4), **wireshark**\|(1), **tshark**\|(1), **editcap**\|(1), **pcap**\|(3), **dumpcap**\|(1),
**text2pcap**\|(1), **pcap-filter**\|(7) or **tcpdump**\|(8)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Rawshark** is part of the **Wireshark** distribution. The latest version of
**Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
**Rawshark** uses the same packet dissection code that **Wireshark** does, as
well as using many other modules from **Wireshark**; see the list of authors
in the **Wireshark** man page for a list of authors of that code.
