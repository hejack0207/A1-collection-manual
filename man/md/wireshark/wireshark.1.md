# wireshark(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

wireshark - Interactively dump and analyze network traffic

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" wireshark [&nbsp;-i&nbsp;<capture&nbsp;interface>|-&nbsp;] [&nbsp;-f&nbsp;<capture&nbsp;filter>&nbsp;] [&nbsp;-Y&nbsp;<displaY&nbsp;filter>&nbsp;] [&nbsp;-w&nbsp;<outfile>&nbsp;] [&nbsp;options&nbsp;] [&nbsp;<infile>&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Wireshark** is a \s-1GUI\s0 network protocol analyzer.  It lets you
interactively browse packet data from a live network or from a
previously saved capture file.  **Wireshark**'s native capture file format
is **pcapng** format, or **pcap** which is also the format used by **tcpdump** and
various other tools.

**Wireshark** can read / import the following file formats:

* ·  
  pcap - captures from **Wireshark**/**TShark**/**dumpcap**, **tcpdump**,
  and various other tools using libpcap's/Npcap's/WinPcap's/tcpdump's/WinDump's
  capture format
* ·  
  pcapng - next-generation\*(R" successor to pcap format
* ·  
  **snoop** and **atmsnoop** captures
* ·  
  Shomiti/Finisar **Surveyor** captures
* ·  
  Novell **LANalyzer** captures
* ·  
  Microsoft **Network Monitor** captures
* ·  
  \s-1AIX\s0's **iptrace** captures
* ·  
  Cinco Networks **NetXRay** captures
* ·  
  Network Associates Windows-based **Sniffer** captures
* ·  
  Network General/Network Associates DOS-based **Sniffer** (compressed or uncompressed) captures
* ·  
  \s-1AG\s0 Group/WildPackets/Savvius **EtherPeek**/**TokenPeek**/**AiroPeek**/**EtherHelp**/**PacketGrabber** captures
* ·  
  **\s-1RADCOM\s0**'s \s-1WAN/LAN\s0 analyzer captures
* ·  
  Network Instruments **Observer** version 9 captures
* ·  
  **Lucent/Ascend** router debug output
* ·  
  files from HP-UX's **nettl**
* ·  
  **Toshiba's** \s-1ISDN\s0 routers dump output
* ·  
  the output from **i4btrace** from the \s-1ISDN4BSD\s0 project
* ·  
  traces from the **EyeSDN** \s-1USB S0.\s0
* ·  
  the output in **IPLog** format from the Cisco Secure Intrusion Detection System
* ·  
  **pppd logs** (pppdump format)
* ·  
  the output from \s-1VMS\s0's **TCPIPtrace**/**TCPtrace**/**\s-1UCX$TRACE\s0** utilities
* ·  
  the text output from the **\s-1DBS\s0 Etherwatch** \s-1VMS\s0 utility
* ·  
  Visual Networks' **Visual UpTime** traffic capture
* ·  
  the output from **CoSine** L2 debug
* ·  
  the output from InfoVista's **5View** \s-1LAN\s0 agents
* ·  
  Endace Measurement Systems' \s-1ERF\s0 format captures
* ·  
  Linux Bluez Bluetooth stack **hcidump -w** traces
* ·  
  Catapult \s-1DCT2000\s0 .out files
* ·  
  Gammu generated text output from Nokia \s-1DCT3\s0 phones in Netmonitor mode
* ·  
  \s-1IBM\s0 Series (\s-1OS/400\s0) Comm traces (\s-1ASCII & UNICODE\s0)
* ·  
  Juniper Netscreen snoop files
* ·  
  Symbian \s-1OS\s0 btsnoop files
* ·  
  TamoSoft CommView files
* ·  
  Textronix K12xx 32bit .rf5 format files
* ·  
  Textronix K12 text file format captures
* ·  
  Apple PacketLogger files
* ·  
  Files from Aethra Telecommunications' \s-1PC108\s0 software for their test
  instruments
* ·  
  \s-1MPEG-2\s0 Transport Streams as defined in \s-1ISO/IEC 13818-1\s0
* ·  
  Rabbit Labs \s-1CAM\s0 Inspector files
* ·  
  Colasoft Capsa files

There is no need to tell **Wireshark** what type of
file you are reading; it will determine the file type by itself.
**Wireshark** is also capable of reading any of these file formats if they
are compressed using gzip.  **Wireshark** recognizes this directly from
the file; the '.gz' extension is not required for this purpose.

Like other protocol analyzers, **Wireshark**'s main window shows 3 views
of a packet.  It shows a summary line, briefly describing what the
packet is.  A packet details display is shown, allowing you to drill
down to exact protocol or field that you interested in.  Finally, a hex
dump shows you exactly what the packet looks like when it goes over the
wire.

In addition, **Wireshark** has some features that make it unique.  It can
assemble all the packets in a \s-1TCP\s0 conversation and show you the \s-1ASCII\s0
(or \s-1EBCDIC,\s0 or hex) data in that conversation.  Display filters in
**Wireshark** are very powerful; more fields are filterable in **Wireshark**
than in other protocol analyzers, and the syntax you can use to create
your filters is richer.  As **Wireshark** progresses, expect more and more
protocol fields to be allowed in display filters.

Packet capturing is performed with the pcap library.  The capture filter
syntax follows the rules of the pcap library.  This syntax is different
from the display filter syntax.

Compressed file support uses (and therefore requires) the zlib library.
If the zlib library is not present, **Wireshark** will compile, but will
be unable to read compressed files.

The pathname of a capture file to be read can be specified with the
**-r** option or can be specified as a command-line argument.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
Most users will want to start **Wireshark** without options and configure
it from the menus instead.  Those users may just skip this section.

* -a|--autostop  &lt;capture autostop condition&gt;  
  .IX Item "-a|--autostop &lt;capture autostop condition&gt;"
  Specify a criterion that specifies when **Wireshark** is to stop writing
  to a capture file.  The criterion is of the form _test_**:**_value_,
  where _test_ is one of:
  .Sp
  **duration**:_value_ Stop writing to a capture file after _value_ seconds have
  elapsed. Floating point values (e.g. 0.5) are allowed.
  .Sp
  **files**:_value_ Stop writing to capture files after _value_ number of files
  were written.
  .Sp
  **filesize**:_value_ Stop writing to a capture file after it reaches a size of
  _value_ kB.  If this option is used together with the -b option, Wireshark
  will stop writing to the current capture file and switch to the next one if
  filesize is reached.  Note that the filesize is limited to a maximum value of
  2 GiB.
  .Sp
  **packets**:_value_ Stop writing to a capture file after it contains _value_
  packets. Same as **-c**&lt;capture packet count&gt;.
* -b|--ring-buffer  &lt;capture ring buffer option&gt;  
  .IX Item "-b|--ring-buffer &lt;capture ring buffer option&gt;"
  Cause **Wireshark** to run in multiple files\*(R" mode.  In \*(L"multiple files\*(R" mode,
  **Wireshark** will write to several capture files.  When the first capture file
  fills up, **Wireshark** will switch writing to the next file and so on.
  .Sp
  The created filenames are based on the filename given with the **-w** flag,
  the number of the file and on the creation date and time,
  e.g. outfile_00001_20210714120117.pcap, outfile_00002_20210714120523.pcap, ...
  .Sp
  With the _files_ option it's also possible to form a ring buffer\*(R".
  This will fill up new files until the number of files specified,
  at which point **Wireshark** will discard the data in the first file and start
  writing to that file and so on.  If the _files_ option is not set,
  new files filled up until one of the capture stop conditions match (or
  until the disk is full).
  .Sp
  The criterion is of the form _key_**:**_value_,
  where _key_ is one of:
  .Sp
  **duration**:_value_ switch to the next file after _value_ seconds have
  elapsed, even if the current file is not completely filled up. Floating
  point values (e.g. 0.5) are allowed.
  .Sp
  **files**:_value_ begin again with the first file after _value_ number of
  files were written (form a ring buffer).  This value must be less than 100000.
  Caution should be used when using large numbers of files: some filesystems do
  not handle many files in a single directory well.  The **files** criterion
  requires one of the other criteria to be specified to
  control when to go to the next file.  It should be noted that each **-b**
  parameter takes exactly one criterion; to specify two criteria, each must be
  preceded by the **-b** option.
  .Sp
  **filesize**:_value_ switch to the next file after it reaches a size of
  _value_ kB.  Note that the filesize is limited to a maximum value of 2 GiB.
  .Sp
  **interval**:_value_ switch to the next file when the time is an exact
  multiple of _value_ seconds.
  .Sp
  **packets**:_value_ switch to the next file after it contains _value_
  packets.
  .Sp
  Example: **-b filesize:1000 -b files:5** results in a ring buffer of five files
  of size one megabyte each.
* -B|--buffer-size  &lt;capture buffer size&gt;  
  .IX Item "-B|--buffer-size &lt;capture buffer size&gt;"
  Set capture buffer size (in MiB, default is 2 MiB).  This is used by
  the capture driver to buffer packet data until that data can be written
  to disk.  If you encounter packet drops while capturing, try to increase
  this size.  Note that, while **Wireshark** attempts to set the buffer size
  to 2 MiB by default, and can be told to set it to a larger value, the
  system or interface on which you're capturing might silently limit the
  capture buffer size to a lower value or raise it to a higher value.
  .Sp
  This is available on \s-1UNIX\s0 systems with libpcap 1.0.0 or later and on
  Windows.  It is not available on \s-1UNIX\s0 systems with earlier versions of
  libpcap.
  .Sp
  This option can occur multiple times.  If used before the first
  occurrence of the **-i** option, it sets the default capture buffer size.
  If used after an **-i** option, it sets the capture buffer size for
  the interface specified by the last **-i** option occurring before
  this option.  If the capture buffer size is not set specifically,
  the default capture buffer size is used instead.
* -c  &lt;capture packet count&gt;  
  .IX Item "-c &lt;capture packet count&gt;"
  Set the maximum number of packets to read when capturing live
  data. Same as **-a packets:**&lt;capture packet count&gt;.
* -C  &lt;configuration profile&gt;  
  .IX Item "-C &lt;configuration profile&gt;"
  Start with the given configuration profile.
* --capture-comment &lt;comment&gt;  
  .IX Item "--capture-comment &lt;comment&gt;"
  Set the capture file comment, if supported by the capture format.
* -d  &lt;layer type&gt;==&lt;selector&gt;,&lt;decode-as protocol&gt;  
  .IX Item "-d &lt;layer type&gt;==&lt;selector&gt;,&lt;decode-as protocol&gt;"
  Like Wireshark's **Decode As...** feature, this lets you specify how a
  layer type should be dissected.  If the layer type in question (for example,
  **tcp.port** or **udp.port** for a \s-1TCP\s0 or \s-1UDP\s0 port number) has the specified
  selector value, packets should be dissected as the specified protocol.
  .Sp
  Example: **-d tcp.port==8888,http** will decode any traffic running over
  \s-1TCP\s0 port 8888 as \s-1HTTP.\s0
  .Sp
  See the **tshark**\|(1) manual page for more examples.
* -D|--list-interfaces  
  .IX Item "-D|--list-interfaces"
  Print a list of the interfaces on which **Wireshark** can capture, and
  exit.  For each network interface, a number and an
  interface name, possibly followed by a text description of the
  interface, is printed.  The interface name or the number can be supplied
  to the **-i** flag to specify an interface on which to capture.
  .Sp
  This can be useful on systems that don't have a command to list them
  (\s-1UNIX\s0 systems lacking **ifconfig -a** or Linux systems lacking
  **ip link show**). The number can be useful on Windows systems, where
  the interface name might be a long name or a \s-1GUID.\s0
  .Sp
  Note that can capture\*(R" means that **Wireshark** was able to open
  that device to do a live capture; if, on your system, a program doing a
  network capture must be run from an account with special privileges (for
  example, as root), then, if **Wireshark** is run with the **-D** flag and
  is not run from such an account, it will not list any interfaces.
* --display &lt;X display to use&gt;  
  .IX Item "--display &lt;X display to use&gt;"
  Specifies the X display to use.  A hostname and screen (otherhost:0.0)
  or just a screen (:0.0) can be specified.  This option is not available
  under Windows.
* --disable-protocol &lt;proto_name&gt;  
  .IX Item "--disable-protocol &lt;proto_name&gt;"
  Disable dissection of proto_name.
* --disable-heuristic &lt;short_name&gt;  
  .IX Item "--disable-heuristic &lt;short_name&gt;"
  Disable dissection of heuristic protocol.
* --enable-protocol &lt;proto_name&gt;  
  .IX Item "--enable-protocol &lt;proto_name&gt;"
  Enable dissection of proto_name.
* --enable-heuristic &lt;short_name&gt;  
  .IX Item "--enable-heuristic &lt;short_name&gt;"
  Enable dissection of heuristic protocol.
* -f  &lt;capture filter&gt;  
  .IX Item "-f &lt;capture filter&gt;"
  Set the capture filter expression.
  .Sp
  This option can occur multiple times.  If used before the first
  occurrence of the **-i** option, it sets the default capture filter expression.
  If used after an **-i** option, it sets the capture filter expression for
  the interface specified by the last **-i** option occurring before
  this option.  If the capture filter expression is not set specifically,
  the default capture filter expression is used if provided.
  .Sp
  Pre-defined capture filter names, as shown in the \s-1GUI\s0 menu item Capture-&gt;Capture Filters,
  can be used by prefixing the argument with predef:\*(R".
  Example: **-f predef:MyPredefinedHostOnlyFilter\*(R"**
* --fullscreen  
  .IX Item "--fullscreen"
  Start Wireshark in full screen mode (kiosk mode). To exit from fullscreen mode,
  open the View menu and select the Full Screen option. Alternatively, press the
  F11 key (or Ctrl + Cmd + F for macOS).
* -g  &lt;packet number&gt;  
  .IX Item "-g &lt;packet number&gt;"
  After reading in a capture file using the **-r** flag, go to the given _packet number_.
* -h|--help  
  .IX Item "-h|--help"
  Print the version number and options and exit.
* -H  
  .IX Item "-H"
  Hide the capture info dialog during live packet capture.
* -i|--interface  &lt;capture interface&gt;|-  
  .IX Item "-i|--interface &lt;capture interface&gt;|-"
  Set the name of the network interface or pipe to use for live packet
  capture.
  .Sp
  Network interface names should match one of the names listed in
  "**wireshark -D** (described above); a number, as reported by
  **wireshark -D**\*(L", can also be used.  If you're using \s-1UNIX, \*(R"\s0netstat
  -i, \*(R"**ifconfig -a**\*(L" or \*(R"**ip link**" might also work to list interface names,
  although not all versions of \s-1UNIX\s0 support the **-a** flag to **ifconfig**.
  .Sp
  If no interface is specified, **Wireshark** searches the list of
  interfaces, choosing the first non-loopback interface if there are any
  non-loopback interfaces, and choosing the first loopback interface if
  there are no non-loopback interfaces.  If there are no interfaces at all,
  **Wireshark** reports an error and doesn't start the capture.
  .Sp
  Pipe names should be either the name of a \s-1FIFO\s0 (named pipe) or -\*(R" to
  read data from the standard input.  On Windows systems, pipe names must be
  of the form "\e\epipe\e.\e**pipename**".  Data read from pipes must be in
  standard pcapng or pcap format. Pcapng data must have the same
  endianness as the capturing host.
  .Sp
  This option can occur multiple times. When capturing from multiple
  interfaces, the capture file will be saved in pcapng format.
* -I|--monitor-mode  
  .IX Item "-I|--monitor-mode"
  Put the interface in monitor mode\*(R"; this is supported only on \s-1IEEE
  802.11\s0 Wi-Fi interfaces, and supported only on some operating systems.
  .Sp
  Note that in monitor mode the adapter might disassociate from the
  network with which it's associated, so that you will not be able to use
  any wireless networks with that adapter.  This could prevent accessing
  files on a network server, or resolving host names or network addresses,
  if you are capturing in monitor mode and are not connected to another
  network with another adapter.
  .Sp
  This option can occur multiple times.  If used before the first
  occurrence of the **-i** option, it enables the monitor mode for all interfaces.
  If used after an **-i** option, it enables the monitor mode for
  the interface specified by the last **-i** option occurring before
  this option.
* -j  
  .IX Item "-j"
  Use after **-J** to change the behavior when no exact match is found for
  the filter.  With this option select the first packet before.
* -J  &lt;jump filter&gt;  
  .IX Item "-J &lt;jump filter&gt;"
  After reading in a capture file using the **-r** flag, jump to the packet
  matching the filter (display filter syntax).  If no exact match is found
  the first packet after that is selected.
* -k  
  .IX Item "-k"
  Start the capture session immediately.  If the **-i** flag was
  specified, the capture uses the specified interface.  Otherwise,
  **Wireshark** searches the list of interfaces, choosing the first
  non-loopback interface if there are any non-loopback interfaces, and
  choosing the first loopback interface if there are no non-loopback
  interfaces; if there are no interfaces, **Wireshark** reports an error and
  doesn't start the capture.
* -K  &lt;keytab&gt;  
  .IX Item "-K &lt;keytab&gt;"
  Load kerberos crypto keys from the specified keytab file.
  This option can be used multiple times to load keys from several files.
  .Sp
  Example: **-K krb5.keytab**
* -l  
  .IX Item "-l"
  Turn on automatic scrolling if the packet display is being updated
  automatically as packets arrive during a capture (as specified by the
  **-S** flag).
* -L|--list-data-link-types  
  .IX Item "-L|--list-data-link-types"
  List the data link types supported by the interface and exit.
* --list-time-stamp-types  
  .IX Item "--list-time-stamp-types"
  List time stamp types supported for the interface. If no time stamp type can be
  set, no time stamp types are listed.
* -n  
  .IX Item "-n"
  Disable network object name resolution (such as hostname, \s-1TCP\s0 and \s-1UDP\s0 port
  names), the **-N** flag might override this one.
* -N  &lt;name resolving flags&gt;  
  .IX Item "-N &lt;name resolving flags&gt;"
  Turn on name resolving only for particular types of addresses and port
  numbers, with name resolving for other types of addresses and port
  numbers turned off.  This flag overrides **-n** if both **-N** and **-n** are
  present.  If both **-N** and **-n** flags are not present, all name resolutions
  are turned on.
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
* -o  &lt;preference/recent setting&gt;  
  .IX Item "-o &lt;preference/recent setting&gt;"
  Set a preference or recent value, overriding the default value and any value
  read from a preference/recent file.  The argument to the flag is a string of
  the form _prefname_**:**_value_, where _prefname_ is the name of the
  preference/recent value (which is the same name that would appear in the
  preference/recent file), and _value_ is the value to which it should be set.
  Since **Ethereal** 0.10.12, the recent settings replaces the formerly used
  -B, -P and -T flags to manipulate the \s-1GUI\s0 dimensions.
  .Sp
  If _prefname_ is uat\*(R", you can override settings in various user access
  tables using the form uat**:**_uat filename_:_uat record_.  _uat filename_
  must be the name of a \s-1UAT\s0 file, e.g. _user\_dlts_.  _uat\_record_ must be in
  the form of a valid record for that file, including quotes.  For instance, to
  specify a user \s-1DLT\s0 from the command line, you would use
  .Sp
  .Vb 1
      -o "uat:user_dlts:\e"User 0 (DLT=147)\e",\e"cops\e",\e"0\e",\e"\e",\e"0\e",\e"\e""
  .Ve
* -p|--no-promiscuous-mode  
  .IX Item "-p|--no-promiscuous-mode"
  _Don't_ put the interface into promiscuous mode.  Note that the
  interface might be in promiscuous mode for some other reason; hence,
  **-p** cannot be used to ensure that the only traffic that is captured is
  traffic sent to or from the machine on which **Wireshark** is running,
  broadcast traffic, and multicast traffic to addresses received by that
  machine.
  .Sp
  This option can occur multiple times.  If used before the first
  occurrence of the **-i** option, no interface will be put into the
  promiscuous mode.
  If used after an **-i** option, the interface specified by the last **-i**
  option occurring before this option will not be put into the
  promiscuous mode.
* -P &lt;path setting&gt;  
  .IX Item "-P &lt;path setting&gt;"
  Special path settings usually detected automatically.  This is used for
  special cases, e.g. starting Wireshark from a known location on an \s-1USB\s0 stick.
  .Sp
  The criterion is of the form _key_**:**_path_, where _key_ is one of:
  .Sp
  **persconf**:_path_ path of personal configuration files, like the
  preferences files.
  .Sp
  **persdata**:_path_ path of personal data files, it's the folder initially
  opened.  After the very first initialization, the recent file will keep the
  folder last used.
* -r|--read-file  &lt;infile&gt;  
  .IX Item "-r|--read-file &lt;infile&gt;"
  Read packet data from _infile_, can be any supported capture file format
  (including gzipped files).  It's not possible to use named pipes or stdin
  here! To capture from a pipe or from stdin use **-i -**
* -R|--read-filter  &lt;read (display) filter&gt;  
  .IX Item "-R|--read-filter &lt;read (display) filter&gt;"
  When reading a capture file specified with the **-r** flag, causes the
  specified filter (which uses the syntax of display filters, rather than
  that of capture filters) to be applied to all packets read from the
  capture file; packets not matching the filter are discarded.
* -s|--snapshot-length  &lt;capture snaplen&gt;  
  .IX Item "-s|--snapshot-length &lt;capture snaplen&gt;"
  Set the default snapshot length to use when capturing live data.
  No more than _snaplen_ bytes of each network packet will be read into
  memory, or saved to disk.  A value of 0 specifies a snapshot length of
  262144, so that the full packet is captured; this is the default.
  .Sp
  This option can occur multiple times.  If used before the first
  occurrence of the **-i** option, it sets the default snapshot length.
  If used after an **-i** option, it sets the snapshot length for
  the interface specified by the last **-i** option occurring before
  this option.  If the snapshot length is not set specifically,
  the default snapshot length is used if provided.
* -S  
  .IX Item "-S"
  Automatically update the packet display as packets are coming in.
* -t  a|ad|adoy|d|dd|e|r|u|ud|udoy  
  .IX Item "-t a|ad|adoy|d|dd|e|r|u|ud|udoy"
  Set the format of the packet timestamp displayed in the packet list
  window.  The format can be one of:
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
* --time-stamp-type &lt;type&gt;  
  .IX Item "--time-stamp-type &lt;type&gt;"
  Change the interface's timestamp method. See --list-time-stamp-types.
* -u &lt;s|hms&gt;  
  .IX Item "-u &lt;s|hms&gt;"
  Output format of seconds (def: s: seconds)
* -v|--version  
  .IX Item "-v|--version"
  Print the full version information and exit.
* -w  &lt;outfile&gt;  
  .IX Item "-w &lt;outfile&gt;"
  Set the default capture file name, or '-' for standard output.
* -X &lt;eXtension options&gt;  
  .IX Item "-X &lt;eXtension options&gt;"
  Specify an option to be passed to an **Wireshark** module.  The eXtension option
  is in the form _extension\_key_**:**_value_, where _extension\_key_ can be:
  .Sp
  **lua\_script**:_lua\_script\_filename_ tells **Wireshark** to load the given script in addition to the
  default Lua scripts.
  .Sp
  **lua\_script**_num_:_argument_ tells **Wireshark** to pass the given argument
  to the lua script identified by 'num', which is the number indexed order of the 'lua_script' command.
  For example, if only one script was loaded with '-X lua_script:my.lua', then '-X lua_script1:foo'
  will pass the string 'foo' to the 'my.lua' script.  If two scripts were loaded, such as '-X lua_script:my.lua'
  and '-X lua_script:other.lua' in that order, then a '-X lua_script2:bar' would pass the string 'bar' to the second lua
  script, namely 'other.lua'.
  .Sp
  **read\_format**:_file\_format_ tells **Wireshark** to use the given file format to read in the
  file (the file given in the **-r** command option).
  .Sp
  **stdin\_descr**:_description_ tells **Wireshark** to use the given description when
  capturing from standard input (**-i -**).
* -y|--linktype  &lt;capture link type&gt;  
  .IX Item "-y|--linktype &lt;capture link type&gt;"
  If a capture is started from the command line with **-k**, set the data
  link type to use while capturing packets.  The values reported by **-L**
  are the values that can be used.
  .Sp
  This option can occur multiple times.  If used before the first
  occurrence of the **-i** option, it sets the default capture link type.
  If used after an **-i** option, it sets the capture link type for
  the interface specified by the last **-i** option occurring before
  this option.  If the capture link type is not set specifically,
  the default capture link type is used if provided.
* -Y|--display-filter  &lt;displaY filter&gt;  
  .IX Item "-Y|--display-filter &lt;displaY filter&gt;"
  Start with the given display filter.
* -z  &lt;statistics&gt;  
  .IX Item "-z &lt;statistics&gt;"
  Get **Wireshark** to collect various types of statistics and display the result
  in a window that updates in semi-real time.
  .Sp
  Currently implemented statistics are:
    * **-z help**  
      .IX Item "-z help"
      Display all possible values for **-z**.
    * **-z** afp,srt[,_filter_]  
      .IX Item "-z afp,srt[,filter]"
      Show Apple Filing Protocol service response time statistics.
    * **-z** conv,_type_[,_filter_]  
      .IX Item "-z conv,type[,filter]"
      Create a table that lists all conversations that could be seen in the
      capture.  _type_ specifies the conversation endpoint types for which we
      want to generate the statistics; currently the supported ones are:
      .Sp
      .Vb 9
        "eth"   Ethernet addresses
        "fc"    Fibre Channel addresses
        "fddi"  FDDI addresses
        "ip"    IPv4 addresses
        "ipv6"  IPv6 addresses
        "ipx"   IPX addresses
        "tcp"   TCP/IP socket pairs   Both IPv4 and IPv6 are supported
        "tr"    Token Ring addresses
        "udp"   UDP/IP socket pairs   Both IPv4 and IPv6 are supported
      .Ve
      .Sp
      If the optional _filter_ is specified, only those packets that match the
      filter will be used in the calculations.
      .Sp
      The table is presented with one line for each conversation and displays
      the number of packets/bytes in each direction as well as the total
      number of packets/bytes.  By default, the table is sorted according to
      the total number of packets.
      .Sp
      These tables can also be generated at runtime by selecting the appropriate
      conversation type from the menu Tools/Statistics/Conversation List/\*(R".
    * **-z** dcerpc,srt,_name-or-uuid_,_major_._minor_[,_filter_]  
      .IX Item "-z dcerpc,srt,name-or-uuid,major.minor[,filter]"
      Collect call/reply \s-1SRT\s0 (Service Response Time) data for \s-1DCERPC\s0 interface
      _name_ or _uuid_, version _major_._minor_.
      Data collected is the number of calls for each procedure, MinSRT, MaxSRT
      and AvgSRT.
      Interface _name_ and _uuid_ are case-insensitive.
      .Sp
      Example: **-z&nbsp;dcerpc,srt,12345778-1234-abcd-ef00-0123456789ac,1.0** will collect data for the \s-1CIFS SAMR\s0 Interface.
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_  is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z&nbsp;dcerpc,srt,12345778-1234-abcd-ef00-0123456789ac,1.0,ip.addr==1.2.3.4** will collect \s-1SAMR
      SRT\s0 statistics for a specific host.
    * **-z** bootp,stat[,_filter_]  
      .IX Item "-z bootp,stat[,filter]"
      Show \s-1DHCP\s0 (\s-1BOOTP\s0) statistics.
    * **-z** expert  
      .IX Item "-z expert"
      Show expert information.
    * **-z** fc,srt[,_filter_]  
      .IX Item "-z fc,srt[,filter]"
      Collect call/reply \s-1SRT\s0 (Service Response Time) data for \s-1FC.\s0  Data collected
      is the number of calls for each Fibre Channel command, MinSRT, MaxSRT and AvgSRT.
      .Sp
      Example: **-z fc,srt**
      will calculate the Service Response Time as the time delta between the
      First packet of the exchange and the Last packet of the exchange.
      .Sp
      The data will be presented as separate tables for all normal \s-1FC\s0 commands,
      Only those commands that are seen in the capture will have its stats
      displayed.
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z fc,srt,fc.id==01.02.03\*(R"** will collect stats only for
      \s-1FC\s0 packets exchanged by the host at \s-1FC\s0 address 01.02.03 .
    * **-z** h225,counter[_,filter_]  
      .IX Item "-z h225,counter[,filter]"
      Count ITU-T H.225 messages and their reasons.  In the first column you get a
      list of H.225 messages and H.225 message reasons which occur in the current
      capture file.  The number of occurrences of each message or reason is displayed
      in the second column.
      .Sp
      Example: **-z h225,counter**
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z h225,counter,ip.addr==1.2.3.4\*(R"** will collect stats only for
      H.225 packets exchanged by the host at \s-1IP\s0 address 1.2.3.4 .
    * **-z** h225,srt[_,filter_]  
      .IX Item "-z h225,srt[,filter]"
      Collect request/response \s-1SRT\s0 (Service Response Time) data for ITU-T H.225 \s-1RAS.\s0
      Data collected is the number of calls of each ITU-T H.225 \s-1RAS\s0 Message Type,
      Minimum \s-1SRT,\s0 Maximum \s-1SRT,\s0 Average \s-1SRT,\s0 Minimum in Packet, and Maximum in Packet.
      You will also get the number of Open Requests (Unresponded Requests),
      Discarded Responses (Responses without matching request) and Duplicate Messages.
      .Sp
      Example: **-z h225,srt**
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z h225,srt,ip.addr==1.2.3.4\*(R"** will collect stats only for
      ITU-T H.225 \s-1RAS\s0 packets exchanged by the host at \s-1IP\s0 address 1.2.3.4 .
    * **-z** io,stat  
      .IX Item "-z io,stat"
      Collect packet/bytes statistics for the capture in intervals of 1 second.
      This option will open a window with up to 5 color-coded graphs where
      number-of-packets-per-second or number-of-bytes-per-second statistics
      can be calculated and displayed.
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      This graph window can also be opened from the Analyze:Statistics:Traffic:IO-Stat
      menu item.
    * **-z** ldap,srt[,_filter_]  
      .IX Item "-z ldap,srt[,filter]"
      Collect call/reply \s-1SRT\s0 (Service Response Time) data for \s-1LDAP.\s0  Data collected
      is the number of calls for each implemented \s-1LDAP\s0 command, MinSRT, MaxSRT and AvgSRT.
      .Sp
      Example: **-z ldap,srt**
      will calculate the Service Response Time as the time delta between the
      Request and the Response.
      .Sp
      The data will be presented as separate tables for all implemented \s-1LDAP\s0 commands,
      Only those commands that are seen in the capture will have its stats
      displayed.
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: use **-z ldap,srt,ip.addr==10.1.1.1\*(R"** will collect stats only for
      \s-1LDAP\s0 packets exchanged by the host at \s-1IP\s0 address 10.1.1.1 .
      .Sp
      The only \s-1LDAP\s0 commands that are currently implemented and for which the stats will be available are:
      \s-1BIND
      SEARCH
      MODIFY
      ADD
      DELETE
      MODRDN
      COMPARE
      EXTENDED\s0
    * **-z** megaco,srt[_,filter_]  
      .IX Item "-z megaco,srt[,filter]"
      Collect request/response \s-1SRT\s0 (Service Response Time) data for \s-1MEGACO.\s0
      (This is similar to **-z smb,srt**).  Data collected is the number of calls
      for each known \s-1MEGACO\s0 Command, Minimum \s-1SRT,\s0 Maximum \s-1SRT\s0 and Average \s-1SRT.\s0
      .Sp
      Example: **-z megaco,srt**
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z megaco,srt,ip.addr==1.2.3.4\*(R"** will collect stats only for
      \s-1MEGACO\s0 packets exchanged by the host at \s-1IP\s0 address 1.2.3.4 .
    * **-z** mgcp,srt[_,filter_]  
      .IX Item "-z mgcp,srt[,filter]"
      Collect request/response \s-1SRT\s0 (Service Response Time) data for \s-1MGCP.\s0
      (This is similar to **-z smb,srt**).  Data collected is the number of calls
      for each known \s-1MGCP\s0 Type, Minimum \s-1SRT,\s0 Maximum \s-1SRT\s0 and Average \s-1SRT.\s0
      .Sp
      Example: **-z mgcp,srt**
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z mgcp,srt,ip.addr==1.2.3.4\*(R"** will collect stats only for
      \s-1MGCP\s0 packets exchanged by the host at \s-1IP\s0 address 1.2.3.4 .
    * **-z** mtp3,msus[,&lt;filter&gt;]  
      .IX Item "-z mtp3,msus[,&lt;filter&gt;]"
      Show \s-1MTP3 MSU\s0 statistics.
    * **-z** multicast,stat[,&lt;filter&gt;]  
      .IX Item "-z multicast,stat[,&lt;filter&gt;]"
      Show \s-1UDP\s0 multicast stream statistics.
    * **-z** rpc,programs  
      .IX Item "-z rpc,programs"
      Collect call/reply \s-1SRT\s0 data for all known ONC-RPC programs/versions.
      Data collected is the number of calls for each protocol/version, MinSRT,
      MaxSRT and AvgSRT.
    * **-z** rpc,srt,_name-or-number_,_version_[,&lt;filter&gt;]  
      .IX Item "-z rpc,srt,name-or-number,version[,&lt;filter&gt;]"
      Collect call/reply \s-1SRT\s0 (Service Response Time) data for program
      _name_/_version_ or _number_/_version_.
      Data collected is the number of calls for each procedure, MinSRT, MaxSRT and
      AvgSRT.
      Program _name_ is case-insensitive.
      .Sp
      Example: **-z rpc,srt,100003,3** will collect data for \s-1NFS\s0 v3.
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z&nbsp;rpc,srt,nfs,3,nfs.fh.hash==0x12345678** will collect \s-1NFS\s0 v3
      \s-1SRT\s0 statistics for a specific file.
    * **-z** scsi,srt,_cmdset_[,&lt;filter&gt;]  
      .IX Item "-z scsi,srt,cmdset[,&lt;filter&gt;]"
      Collect call/reply \s-1SRT\s0 (Service Response Time) data for \s-1SCSI\s0 commandset &lt;cmdset&gt;.
      .Sp
      Commandsets are 0:SBC   1:SSC  5:MMC
      .Sp
      Data collected
      is the number of calls for each procedure, MinSRT, MaxSRT and AvgSRT.
      .Sp
      Example: **-z scsi,srt,0** will collect data for \s-1SCSI BLOCK COMMANDS\s0 (\s-1SBC\s0).
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z scsi,srt,0,ip.addr==1.2.3.4** will collect \s-1SCSI SBC
      SRT\s0 statistics for a specific iscsi/ifcp/fcip host.
    * **-z** sip,stat[_,filter_]  
      .IX Item "-z sip,stat[,filter]"
      This option will activate a counter for \s-1SIP\s0 messages.  You will get the number
      of occurrences of each \s-1SIP\s0 Method and of each \s-1SIP\s0 Status-Code.  Additionally you
      also get the number of resent \s-1SIP\s0 Messages (only for \s-1SIP\s0 over \s-1UDP\s0).
      .Sp
      Example: **-z sip,stat**
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z sip,stat,ip.addr==1.2.3.4\*(R"** will collect stats only for
      \s-1SIP\s0 packets exchanged by the host at \s-1IP\s0 address 1.2.3.4 .
    * **-z** smb,srt[,_filter_]  
      .IX Item "-z smb,srt[,filter]"
      Collect call/reply \s-1SRT\s0 (Service Response Time) data for \s-1SMB.\s0  Data collected
      is the number of calls for each \s-1SMB\s0 command, MinSRT, MaxSRT and AvgSRT.
      .Sp
      Example: **-z smb,srt**
      .Sp
      The data will be presented as separate tables for all normal \s-1SMB\s0 commands,
      all Transaction2 commands and all \s-1NT\s0 Transaction commands.
      Only those commands that are seen in the capture will have their stats
      displayed.
      Only the first command in a xAndX command chain will be used in the
      calculation.  So for common SessionSetupAndX + TreeConnectAndX chains,
      only the SessionSetupAndX call will be used in the statistics.
      This is a flaw that might be fixed in the future.
      .Sp
      This option can be used multiple times on the command line.
      .Sp
      If the optional _filter_ is provided, the stats will only be calculated
      on those calls that match that filter.
      .Sp
      Example: **-z smb,srt,ip.addr==1.2.3.4\*(R"** will collect stats only for
      \s-1SMB\s0 packets exchanged by the host at \s-1IP\s0 address 1.2.3.4 .
    * **-z** voip,calls  
      .IX Item "-z voip,calls"
      This option will show a window that shows VoIP calls found in the capture file.
      This is the same window shown as when you go to the Statistics Menu and choose
      VoIP Calls.
      .Sp
      Example: **-z voip,calls**
    * **-z** wlan,stat[,&lt;filter&gt;]  
      .IX Item "-z wlan,stat[,&lt;filter&gt;]"
      Show \s-1IEEE 802.11\s0 network and station statistics.
    * **-z** wsp,stat[,&lt;filter&gt;]  
      .IX Item "-z wsp,stat[,&lt;filter&gt;]"
      Show \s-1WSP\s0 packet counters.

<a name="interface"></a>

# Interface

.IX Header "INTERFACE"

<a name="s-1menu-itemss0"></a>

### \s-1MENU ITEMS\s0

.IX Subsection "MENU ITEMS"

* File:Open  
  .IX Item "File:Open"
* File:Open Recent  
  .IX Item "File:Open Recent"
* File:Merge  
  .IX Item "File:Merge"
  Merge another capture file to the currently loaded one.  The _File:Merge_
  dialog box allows the merge Prepended\*(R", \*(L"Chronologically\*(R" or \*(L"Appended\*(R",
  relative to the already loaded one.
* File:Close  
  .IX Item "File:Close"
  Open or close a capture file.  The _File:Open_ dialog box
  allows a filter to be specified; when the capture file is read, the
  filter is applied to all packets read from the file, and packets not
  matching the filter are discarded.  The _File:Open Recent_ is a submenu
  and will show a list of previously opened files.
* File:Save  
  .IX Item "File:Save"
* File:Save As  
  .IX Item "File:Save As"
  Save the current capture, or the packets currently displayed from that
  capture, to a file.  Check boxes let you select whether to save all
  packets, or just those that have passed the current display filter and/or
  those that are currently marked, and an option menu lets you select (from
  a list of file formats in which at particular capture, or the packets
  currently displayed from that capture, can be saved), a file format in
  which to save it.
* File:File Set:List Files  
  .IX Item "File:File Set:List Files"
  Show a dialog box that lists all files of the file set matching the currently
  loaded file.  A file set is a compound of files resulting from a capture using
  the multiple files\*(R" / \*(L"ringbuffer\*(R" mode, recognizable by the filename pattern,
  e.g.: Filename_00001_20210714101530.pcap.
* File:File Set:Next File  
  .IX Item "File:File Set:Next File"
* File:File Set:Previous File  
  .IX Item "File:File Set:Previous File"
  If the currently loaded file is part of a file set (see above), open the
  next / previous file in that set.
* File:Export  
  .IX Item "File:Export"
  Export captured data into an external format.  Note: the data cannot be
  imported back into Wireshark, so be sure to keep the capture file.
* File:Print  
  .IX Item "File:Print"
  Print packet data from the current capture.  You can select the range of
  packets to be printed (which packets are printed), and the output format of
  each packet (how each packet is printed).  The output format will be similar
  to the displayed values, so a summary line, the packet details view, and/or
  the hex dump of the packet can be printed.
  .Sp
  Printing options can be set with the _Edit:Preferences_ menu item, or in the
  dialog box popped up by this menu item.
* File:Quit  
  .IX Item "File:Quit"
  Exit the application.
* Edit:Copy:Description  
  .IX Item "Edit:Copy:Description"
  Copies the description of the selected field in the protocol tree to
  the clipboard.
* Edit:Copy:Fieldname  
  .IX Item "Edit:Copy:Fieldname"
  Copies the fieldname of the selected field in the protocol tree to
  the clipboard.
* Edit:Copy:Value  
  .IX Item "Edit:Copy:Value"
  Copies the value of the selected field in the protocol tree to
  the clipboard.
* Edit:Copy:As Filter  
  .IX Item "Edit:Copy:As Filter"
  Create a display filter based on the data currently highlighted in the
  packet details and copy that filter to the clipboard.
  .Sp
  If that data is a field that can be tested in a display filter
  expression, the display filter will test that field; otherwise, the
  display filter will be based on the absolute offset within the packet.
  Therefore it could be unreliable if the packet contains protocols with
  variable-length headers, such as a source-routed token-ring packet.
* Edit:Find Packet  
  .IX Item "Edit:Find Packet"
  Search forward or backward, starting with the currently selected packet
  (or the most recently selected packet, if no packet is selected).  Search
  criteria can be a display filter expression, a string of hexadecimal
  digits, or a text string.
  .Sp
  When searching for a text string, you can search the packet data, or you
  can search the text in the Info column in the packet list pane or in the
  packet details pane.
  .Sp
  Hexadecimal digits can be separated by colons, periods, or dashes.
  Text string searches can be \s-1ASCII\s0 or Unicode (or both), and may be
  case insensitive.
* Edit:Find Next  
  .IX Item "Edit:Find Next"
* Edit:Find Previous  
  .IX Item "Edit:Find Previous"
  Search forward / backward for a packet matching the filter from the previous
  search, starting with the currently selected packet (or the most recently
  selected packet, if no packet is selected).
* Edit:Mark Packet (toggle)  
  .IX Item "Edit:Mark Packet (toggle)"
  Mark (or unmark if currently marked) the selected packet.  The field
  frame.marked\*(R" is set for packets that are marked, so that, for example,
  a display filters can be used to display only marked packets, and so that
  the Edit:Find Packet\*(R" dialog can be used to find the next or previous
  marked packet.
* Edit:Find Next Mark  
  .IX Item "Edit:Find Next Mark"
* Edit:Find Previous Mark  
  .IX Item "Edit:Find Previous Mark"
  Find next/previous marked packet.
* Edit:Mark All Packets  
  .IX Item "Edit:Mark All Packets"
* Edit:Unmark All Packets  
  .IX Item "Edit:Unmark All Packets"
  Mark / Unmark all packets that are currently displayed.
* Edit:Time Reference:Set Time Reference (toggle)  
  .IX Item "Edit:Time Reference:Set Time Reference (toggle)"
  Set (or unset if currently set) the selected packet as a Time Reference packet.
  When a packet is set as a Time Reference packet, the timestamps in the packet
  list pane will be replaced with the string *REF*\*(R".
  The relative time timestamp in later packets will then be calculated relative
  to the timestamp of this Time Reference packet and not the first packet in
  the capture.
  .Sp
  Packets that have been selected as Time Reference packets will always be
  displayed in the packet list pane.  Display filters will not affect or
  hide these packets.
  .Sp
  If there is a column displayed for Cumulative Bytes\*(R" this counter will
  be reset at every Time Reference packet.
* Edit:Time Reference:Find Next  
  .IX Item "Edit:Time Reference:Find Next"
* Edit:Time Reference:Find Previous  
  .IX Item "Edit:Time Reference:Find Previous"
  Search forward / backward for a time referenced packet.
* Edit:Configuration Profiles  
  .IX Item "Edit:Configuration Profiles"
  Manage configuration profiles to be able to use more than one set of
  preferences and configurations.
* Edit:Preferences  
  .IX Item "Edit:Preferences"
  Set the \s-1GUI,\s0 capture, printing and protocol options
  (see Preferences\*(R" dialog below).
* View:Main Toolbar  
  .IX Item "View:Main Toolbar"
* View:Filter Toolbar  
  .IX Item "View:Filter Toolbar"
* View:Statusbar  
  .IX Item "View:Statusbar"
  Show or hide the main window controls.
* View:Packet List  
  .IX Item "View:Packet List"
* View:Packet Details  
  .IX Item "View:Packet Details"
* View:Packet Bytes  
  .IX Item "View:Packet Bytes"
  Show or hide the main window panes.
* View:Time Display Format  
  .IX Item "View:Time Display Format"
  Set the format of the packet timestamp displayed in the packet list window.
* View:Name Resolution:Resolve Name  
  .IX Item "View:Name Resolution:Resolve Name"
  Try to resolve a name for the currently selected item.
* View:Name Resolution:Enable for ... Layer  
  .IX Item "View:Name Resolution:Enable for ... Layer"
  Enable or disable translation of addresses to names in the display.
* View:Colorize Packet List  
  .IX Item "View:Colorize Packet List"
  Enable or disable the coloring rules.  Disabling will improve performance.
* View:Auto Scroll in Live Capture  
  .IX Item "View:Auto Scroll in Live Capture"
  Enable or disable the automatic scrolling of the
  packet list while a live capture is in progress.
* View:Zoom In  
  .IX Item "View:Zoom In"
* View:Zoom Out  
  .IX Item "View:Zoom Out"
  Zoom into / out of the main window data (by changing the font size).
* View:Normal Size  
  .IX Item "View:Normal Size"
  Reset the zoom factor of zoom in / zoom out back to normal font size.
* View:Resize All Columns  
  .IX Item "View:Resize All Columns"
  Resize all columns to best fit the current packet display.
* View:Expand / Collapse Subtrees  
  .IX Item "View:Expand / Collapse Subtrees"
  Expands / Collapses the currently selected item and it's subtrees in the packet details.
* View:Expand All  
  .IX Item "View:Expand All"
* View:Collapse All  
  .IX Item "View:Collapse All"
  Expand / Collapse all branches of the packet details.
* View:Colorize Conversation  
  .IX Item "View:Colorize Conversation"
  Select color for a conversation.
* View:Reset Coloring 1-10  
  .IX Item "View:Reset Coloring 1-10"
  Reset Color for a conversation.
* View:Coloring Rules  
  .IX Item "View:Coloring Rules"
  Change the foreground and background colors of the packet information in
  the list of packets, based upon display filters.  The list of display
  filters is applied to each packet sequentially.  After the first display
  filter matches a packet, any additional display filters in the list are
  ignored.  Therefore, if you are filtering on the existence of protocols,
  you should list the higher-level protocols first, and the lower-level
  protocols last.
    * How Colorization Works  
      .IX Item "How Colorization Works"
      Packets are colored according to a list of color filters.  Each filter
      consists of a name, a filter expression and a coloration.  A packet is
      colored according to the first filter that it matches.  Color filter
      expressions use exactly the same syntax as display filter expressions.
      .Sp
      When Wireshark starts, the color filters are loaded from:
        * 1.  
          The user's personal color filters file or, if that does not exist,
        * 2.  
          The global color filters file.
          .Sp
          If neither of these exist then the packets will not be colored.
* View:Show Packet In New Window  
  .IX Item "View:Show Packet In New Window"
  Create a new window containing a packet details view and a hex dump
  window of the currently selected packet; this window will continue to
  display that packet's details and data even if another packet is
  selected.
* View:Reload  
  .IX Item "View:Reload"
  Reload a capture file.  Same as _File:Close_ and _File:Open_ the same
  file again.
* Go:Back  
  .IX Item "Go:Back"
  Go back in previously visited packets history.
* Go:Forward  
  .IX Item "Go:Forward"
  Go forward in previously visited packets history.
* Go:Go To Packet  
  .IX Item "Go:Go To Packet"
  Go to a particular numbered packet.
* Go:Go To Corresponding Packet  
  .IX Item "Go:Go To Corresponding Packet"
  If a field in the packet details pane containing a packet number is
  selected, go to the packet number specified by that field.  (This works
  only if the dissector that put that entry into the packet details put it
  into the details as a filterable field rather than just as text.) This
  can be used, for example, to go to the packet for the request
  corresponding to a reply, or the reply corresponding to a request, if
  that packet number has been put into the packet details.
* Go:Previous Packet  
  .IX Item "Go:Previous Packet"
* Go:Next Packet  
  .IX Item "Go:Next Packet"
* Go:First Packet  
  .IX Item "Go:First Packet"
* Go:Last Packet  
  .IX Item "Go:Last Packet"
  Go to the previous / next / first / last packet in the capture.
* Go:Previous Packet In Conversation  
  .IX Item "Go:Previous Packet In Conversation"
* Go:Next Packet In Conversation  
  .IX Item "Go:Next Packet In Conversation"
  Go to the previous / next packet of the conversation (\s-1TCP, UDP\s0 or \s-1IP\s0)
* Capture:Interfaces  
  .IX Item "Capture:Interfaces"
  Shows a dialog box with all currently known interfaces and displaying the
  current network traffic amount.  Capture sessions can be started from here.
  Beware: keeping this box open results in high system load!
* Capture:Options  
  .IX Item "Capture:Options"
  Initiate a live packet capture (see Capture Options Dialog\*(R"
  below).  If no filename is specified, a temporary file will be created
  to hold the capture.  The location of the file can be chosen by setting your
  \s-1TMPDIR\s0 environment variable before starting **Wireshark**.  Otherwise, the
  default \s-1TMPDIR\s0 location is system-dependent, but is likely either _/var/tmp_
  or _/tmp_.
* Capture:Start  
  .IX Item "Capture:Start"
  Start a live packet capture with the previously selected options.  This won't
  open the options dialog box, and can be convenient for repeatedly capturing
  with the same options.
* Capture:Stop  
  .IX Item "Capture:Stop"
  Stop a running live capture.
* Capture:Restart  
  .IX Item "Capture:Restart"
  While a live capture is running, stop it and restart with the same options
  again.  This can be convenient to remove irrelevant packets, if no valuable
  packets were captured so far.
* Capture:Capture Filters  
  .IX Item "Capture:Capture Filters"
  Edit the saved list of capture filters, allowing filters to be added,
  changed, or deleted.
* Analyze:Display Filters  
  .IX Item "Analyze:Display Filters"
  Edit the saved list of display filters, allowing filters to be added,
  changed, or deleted.
* Analyze:Display Filter Macros  
  .IX Item "Analyze:Display Filter Macros"
  Create shortcuts for complex macros
* Analyze:Apply as Filter  
  .IX Item "Analyze:Apply as Filter"
  Create a display filter based on the data currently highlighted in the
  packet details and apply the filter.
  .Sp
  If that data is a field that can be tested in a display filter
  expression, the display filter will test that field; otherwise, the
  display filter will be based on the absolute offset within the packet.
  Therefore it could be unreliable if the packet contains protocols with
  variable-length headers, such as a source-routed token-ring packet.
  .Sp
  The **Selected** option creates a display filter that tests for a match
  of the data; the **Not Selected** option creates a display filter that
  tests for a non-match of the data.  The **And Selected**, **Or Selected**,
  **And Not Selected**, and **Or Not Selected** options add to the end of
  the display filter in the strip at the top (or bottom) an \s-1AND\s0 or \s-1OR\s0
  operator followed by the new display filter expression.
* Analyze:Prepare as Filter  
  .IX Item "Analyze:Prepare as Filter"
  Create a display filter based on the data currently highlighted in the
  packet details.  The filter strip at the top (or bottom) is updated but
  it is not yet applied.
* Analyze:Enabled Protocols  
  .IX Item "Analyze:Enabled Protocols"
  Allow protocol dissection to be enabled or disabled for a specific
  protocol.  Individual protocols can be enabled or disabled by clicking
  on them in the list or by highlighting them and pressing the space bar.
  The entire list can be enabled, disabled, or inverted using the buttons
  below the list.
  .Sp
  When a protocol is disabled, dissection in a particular packet stops
  when that protocol is reached, and Wireshark moves on to the next packet.
  Any higher-layer protocols that would otherwise have been processed will
  not be displayed.  For example, disabling \s-1TCP\s0 will prevent the dissection
  and display of \s-1TCP, HTTP, SMTP,\s0 Telnet, and any other protocol exclusively
  dependent on \s-1TCP.\s0
  .Sp
  The list of protocols can be saved, so that Wireshark will start up with
  the protocols in that list disabled.
* Analyze:Decode As  
  .IX Item "Analyze:Decode As"
  If you have a packet selected, present a dialog allowing you to change
  which dissectors are used to decode this packet.  The dialog has one
  panel each for the link layer, network layer and transport layer
  protocol/port numbers, and will allow each of these to be changed
  independently.  For example, if the selected packet is a \s-1TCP\s0 packet to
  port 12345, using this dialog you can instruct Wireshark to decode all
  packets to or from that \s-1TCP\s0 port as \s-1HTTP\s0 packets.
* Analyze:User Specified Decodes  
  .IX Item "Analyze:User Specified Decodes"
  Create a new window showing whether any protocol \s-1ID\s0 to dissector
  mappings have been changed by the user.  This window also allows the
  user to reset all decodes to their default values.
* Analyze:Follow \s-1TCP\s0 Stream  
  .IX Item "Analyze:Follow TCP Stream"
  If you have a \s-1TCP\s0 packet selected, display the contents of the data
  stream for the \s-1TCP\s0 connection to which that packet belongs, as text, in
  a separate window, and leave the list of packets in a filtered state,
  with only those packets that are part of that \s-1TCP\s0 connection being
  displayed.  You can revert to your old view by pressing \s-1ENTER\s0 in the
  display filter text box, thereby invoking your old display filter (or
  resetting it back to no display filter).
  .Sp
  The window in which the data stream is displayed lets you select:
    * ·  
      whether to display the entire conversation, or one or the other side of
      it;
    * ·  
      whether the data being displayed is to be treated as \s-1ASCII\s0 or \s-1EBCDIC\s0
      text or as raw hex data;
      .Sp
      and lets you print what's currently being displayed, using the same
      print options that are used for the _File:Print Packet_ menu item, or
      save it as text to a file.
* Analyze:Follow \s-1UDP\s0 Stream  
  .IX Item "Analyze:Follow UDP Stream"
* Analyze:Follow \s-1TLS\s0 Stream  
  .IX Item "Analyze:Follow TLS Stream"
  (Similar to Analyze:Follow \s-1TCP\s0 Stream)
* Analyze:Expert Info  
  .IX Item "Analyze:Expert Info"
* Analyze:Expert Info Composite  
  .IX Item "Analyze:Expert Info Composite"
  (Kind of) a log of anomalies found by Wireshark in a capture file.
* Analyze:Conversation Filter  
  .IX Item "Analyze:Conversation Filter"
* Statistics:Summary  
  .IX Item "Statistics:Summary"
  Show summary information about the capture, including elapsed time,
  packet counts, byte counts, and the like.  If a display filter is in
  effect, summary information will be shown about the capture and about
  the packets currently being displayed.
* Statistics:Protocol Hierarchy  
  .IX Item "Statistics:Protocol Hierarchy"
  Show the number of packets, and the number of bytes in those packets,
  for each protocol in the trace.  It organizes the protocols in the same
  hierarchy in which they were found in the trace.  Besides counting the
  packets in which the protocol exists, a count is also made for packets
  in which the protocol is the last protocol in the stack.  These
  last-protocol counts show you how many packets (and the byte count
  associated with those packets) **ended** in a particular protocol.  In
  the table, they are listed under End Packets\*(R" and \*(L"End Bytes\*(R".
* Statistics:Conversations  
  .IX Item "Statistics:Conversations"
  Lists of conversations; selectable by protocol.  See Statistics:Conversation List below.
* Statistics:End Points  
  .IX Item "Statistics:End Points"
  List of End Point Addresses by protocol with packets/bytes/.... counts.
* Statistics:Packet Lengths  
  .IX Item "Statistics:Packet Lengths"
  Grouped counts of packet lengths (0-19 bytes, 20-39 bytes, ...)
* Statistics:I/O Graphs  
  .IX Item "Statistics:I/O Graphs"
  Open a window where up to 5 graphs in different colors can be displayed
  to indicate number of packets or number of bytes per second for all packets
  matching the specified filter.
  By default only one graph will be displayed showing number of packets per second.
  .Sp
  The top part of the window contains the graphs and scales for the X and
  Y axis.  If the graph is too long to fit inside the window there is a
  horizontal scrollbar below the drawing area that can scroll the graphs
  to the left or the right.  The horizontal axis displays the time into
  the capture and the vertical axis will display the measured quantity at
  that time.
  .Sp
  Below the drawing area and the scrollbar are the controls.  On the
  bottom left there will be five similar sets of controls to control each
  individual graph such as Display:&lt;button&gt;\*(R" which button will toggle
  that individual graph on/off.  If &lt;button&gt; is ticked, the graph will be
  displayed. Color:&lt;color&gt;\*(R" which is just a button to show which color
  will be used to draw that graph. Finally Filter:&lt;filter-text&gt;\*(R" which
  can be used to specify a display filter for that particular graph.
  .Sp
  If filter-text is empty then all packets will be used to calculate the
  quantity for that graph.  If filter-text is specified only those packets
  that match that display filter will be considered in the calculation of
  quantity.
  .Sp
  To the right of the 5 graph controls there are four menus to control
  global aspects of the draw area and graphs.  The Unit:\*(R" menu is used to
  control what to measure; packets/tick\*(R", \*(L"bytes/tick\*(R" or \*(L"advanced...\*(R"
  .Sp
  packets/tick will measure the number of packets matching the (if
  specified) display filter for the graph in each measurement interval.
  .Sp
  bytes/tick will measure the total number of bytes in all packets matching
  the (if specified) display filter for the graph in each measurement
  interval.
  .Sp
  advanced... see below
  .Sp
  Tick interval:\*(R" specifies what measurement intervals to use.  The
  default is 1 second and means that the data will be counted over 1
  second intervals.
  .Sp
  Pixels per tick:\*(R" specifies how many pixels wide each measurement
  interval will be in the drawing area.  The default is 5 pixels per tick.
  .Sp
  Y-scale:\*(R" controls the max value for the y-axis.  Default value is
  auto\*(R" which means that **Wireshark** will try to adjust the maxvalue
  automatically.
  .Sp
  advanced...\*(R" If Unit:advanced...  is selected the window will display
  two more controls for each of the five graphs.  One control will be a
  menu where the type of calculation can be selected from
  \s-1SUM,COUNT,MAX,MIN,AVG\s0 and \s-1LOAD,\s0 and one control, textbox, where the name of a
  single display filter field can be specified.
  .Sp
  The following restrictions apply to type and field combinations:
  .Sp
  \s-1SUM:\s0 available for all types of integers and will calculate the \s-1SUM\s0 of
  all occurrences of this field in the measurement interval.  Note that
  some field can occur multiple times in the same packet and then all
  instances will be summed up.  Example: 'tcp.len' which will count the
  amount of payload data transferred across \s-1TCP\s0 in each interval.
  .Sp
  \s-1COUNT:\s0 available for all field types.  This will \s-1COUNT\s0 the number of times
  certain field occurs in each interval.  Note that some fields
  may occur multiple times in each packet and if that is the case
  then each instance will be counted independently and \s-1COUNT\s0
  will be greater than the number of packets.
  .Sp
  \s-1MAX:\s0 available for all integer and relative time fields.  This will calculate
  the max seen integer/time value seen for the field during the interval.
  Example: 'smb.time' which will plot the maximum \s-1SMB\s0 response time.
  .Sp
  \s-1MIN:\s0 available for all integer and relative time fields.  This will calculate
  the min seen integer/time value seen for the field during the interval.
  Example: 'smb.time' which will plot the minimum \s-1SMB\s0 response time.
  .Sp
  \s-1AVG:\s0 available for all integer and relative time fields.This will
  calculate the average seen integer/time value seen for the field during
  the interval.  Example: 'smb.time' which will plot the average \s-1SMB\s0
  response time.
  .Sp
  \s-1LOAD:\s0 available only for relative time fields (response times).
  .Sp
  Example of advanced:
  Display how \s-1NFS\s0 response time \s-1MAX/MIN/AVG\s0 changes over time:
  .Sp
  Set first graph to:
  .Sp
  .Vb 2
     filter:nfs&&rpc.time
     Calc:MAX rpc.time
  .Ve
  .Sp
  Set second graph to
  .Sp
  .Vb 2
     filter:nfs&&rpc.time
     Calc:AVG rpc.time
  .Ve
  .Sp
  Set third graph to
  .Sp
  .Vb 2
     filter:nfs&&rpc.time
     Calc:MIN rpc.time
  .Ve
  .Sp
  Example of advanced:
  Display how the average packet size from host a.b.c.d changes over time.
  .Sp
  Set first graph to
  .Sp
  .Vb 2
     filter:ip.addr==a.b.c.d&&frame.pkt_len
     Calc:AVG frame.pkt_len
  .Ve
  .Sp
  \s-1LOAD:\s0
  The \s-1LOAD\s0 io-stat type is very different from anything you have ever seen
  before! While the response times themselves as plotted by \s-1MIN,MAX,AVG\s0 are
  indications on the Server load (which affects the Server response time),
  the \s-1LOAD\s0 measurement measures the Client \s-1LOAD.\s0
  What this measures is how much workload the client generates,
  i.e. how fast will the client issue new commands when the previous ones
  completed.
  i.e. the level of concurrency the client can maintain.
  The higher the number, the more and faster is the client issuing new
  commands.  When the \s-1LOAD\s0 goes down, it may be due to client load making
  the client slower in issuing new commands (there may be other reasons as
  well, maybe the client just doesn't have any commands it wants to issue
  right then).
  .Sp
  Load is measured in concurrency/number of overlapping i/o and the value
  1000 means there is a constant load of one i/o.
  .Sp
  In each tick interval the amount of overlap is measured.
  See the graph below containing three commands:
  Below the graph are the \s-1LOAD\s0 values for each interval that would be calculated.
  .Sp
  .Vb 8
    |     |     |     |     |     |     |     |     |
    |     |     |     |     |     |     |     |     |
    |     |  o=====*  |     |     |     |     |     |
    |     |     |     |     |     |     |     |     |
    |  o========*     | o============*  |     |     |
    |     |     |     |     |     |     |     |     |
    --------------------------------------------------&gt; Time
     500   1500   500  750   1000   500    0     0
  .Ve
* Statistics:Conversation List  
  .IX Item "Statistics:Conversation List"
  This option will open a new window that displays a list of all
  conversations between two endpoints.  The list has one row for each
  unique conversation and displays total number of packets/bytes seen as
  well as number of packets/bytes in each direction.
  .Sp
  By default the list is sorted according to the number of packets but by
  clicking on the column header; it is possible to re-sort the list in
  ascending or descending order by any column.
  .Sp
  By first selecting a conversation by clicking on it and then using the
  right mouse button (on those platforms that have a right
  mouse button) Wireshark will display a popup menu offering several different
  filter operations to apply to the capture.
  .Sp
  These statistics windows can also be invoked from the Wireshark command
  line using the **-z conv** argument.
* Statistics:Service Response Time  
  .IX Item "Statistics:Service Response Time"
    * ·  
      \s-1AFP\s0
    * ·  
      \s-1CAMEL\s0
    * ·  
      DCE-RPC
      .Sp
      Open a window to display Service Response Time statistics for an
      arbitrary DCE-RPC program
      interface and display **Procedure**, **Number of Calls**, **Minimum \s-1SRT\s0**,
      **Maximum \s-1SRT\s0** and **Average \s-1SRT\s0** for all procedures for that
      program/version.  These windows opened will update in semi-real time to
      reflect changes when doing live captures or when reading new capture
      files into **Wireshark**.
      .Sp
      This dialog will also allow an optional filter string to be used.
      If an optional filter string is used only such DCE-RPC request/response pairs
      that match that filter will be used to calculate the statistics.  If no filter
      string is specified all request/response pairs will be used.
    * ·  
      Diameter
    * ·  
      Fibre Channel
      .Sp
      Open a window to display Service Response Time statistics for Fibre Channel
      and display **\s-1FC\s0 Type**, **Number of Calls**, **Minimum \s-1SRT\s0**,
      **Maximum \s-1SRT\s0** and **Average \s-1SRT\s0** for all \s-1FC\s0 types.
      These windows opened will update in semi-real time to
      reflect changes when doing live captures or when reading new capture
      files into **Wireshark**.
      The Service Response Time is calculated as the time delta between the
      First packet of the exchange and the Last packet of the exchange.
      .Sp
      This dialog will also allow an optional filter string to be used.
      If an optional filter string is used only such \s-1FC\s0 first/last exchange pairs
      that match that filter will be used to calculate the statistics.  If no filter
      string is specified all request/response pairs will be used.
    * ·  
      \s-1GTP\s0
    * ·  
      H.225 \s-1RAS\s0
      .Sp
      Collect requests/response \s-1SRT\s0 (Service Response Time) data for ITU-T H.225 \s-1RAS.\s0
      Data collected is **number of calls** for each known ITU-T H.225 \s-1RAS\s0 Message Type,
      **Minimum \s-1SRT\s0**, **Maximum \s-1SRT\s0**, **Average \s-1SRT\s0**, **Minimum in Packet**, and **Maximum in Packet**.
      You will also get the number of **Open Requests** (Unresponded Requests),
      **Discarded Responses** (Responses without matching request) and Duplicate Messages.
      These windows opened will update in semi-real time to reflect changes when
      doing live captures or when reading new capture files into **Wireshark**.
      .Sp
      You can apply an optional filter string in a dialog box, before starting
      the calculation.  The statistics will only be calculated
      on those calls matching that filter.
    * ·  
      \s-1LDAP\s0
    * ·  
      \s-1MEGACO\s0
    * ·  
      \s-1MGCP\s0
      .Sp
      Collect requests/response \s-1SRT\s0 (Service Response Time) data for \s-1MGCP.\s0
      Data collected is **number of calls** for each known \s-1MGCP\s0 Type,
      **Minimum \s-1SRT\s0**, **Maximum \s-1SRT\s0**, **Average \s-1SRT\s0**, **Minimum in Packet**, and **Maximum in Packet**.
      These windows opened will update in semi-real time to reflect changes when
      doing live captures or when reading new capture files into **Wireshark**.
      .Sp
      You can apply an optional filter string in a dialog box, before starting
      the calculation.  The statistics will only be calculated
      on those calls matching that filter.
    * ·  
      \s-1NCP\s0
    * ·  
      ONC-RPC
      .Sp
      Open a window to display statistics for an arbitrary ONC-RPC program interface
      and display **Procedure**, **Number of Calls**, **Minimum \s-1SRT\s0**, **Maximum \s-1SRT\s0** and **Average \s-1SRT\s0** for all procedures for that program/version.
      These windows opened will update in semi-real time to reflect changes when
      doing live captures or when reading new capture files into **Wireshark**.
      .Sp
      This dialog will also allow an optional filter string to be used.
      If an optional filter string is used only such ONC-RPC request/response pairs
      that match that filter will be used to calculate the statistics.  If no filter
      string is specified all request/response pairs will be used.
      .Sp
      By first selecting a conversation by clicking on it and then using the
      right mouse button (on those platforms that have a right
      mouse button) Wireshark will display a popup menu offering several different
      filter operations to apply to the capture.
    * ·  
      \s-1RADIUS\s0
    * ·  
      \s-1SCSI\s0
    * ·  
      \s-1SMB\s0
      .Sp
      Collect call/reply \s-1SRT\s0 (Service Response Time) data for \s-1SMB.\s0  Data collected
      is the number of calls for each \s-1SMB\s0 command, MinSRT, MaxSRT and AvgSRT.
      .Sp
      The data will be presented as separate tables for all normal \s-1SMB\s0 commands,
      all Transaction2 commands and all \s-1NT\s0 Transaction commands.
      Only those commands that are seen in the capture will have its stats
      displayed.
      Only the first command in a xAndX command chain will be used in the
      calculation.  So for common SessionSetupAndX + TreeConnectAndX chains,
      only the SessionSetupAndX call will be used in the statistics.
      This is a flaw that might be fixed in the future.
      .Sp
      You can apply an optional filter string in a dialog box, before starting
      the calculation.  The stats will only be calculated
      on those calls matching that filter.
      .Sp
      By first selecting a conversation by clicking on it and then using the
      right mouse button (on those platforms that have a right
      mouse button) Wireshark will display a popup menu offering several different
      filter operations to apply to the capture.
    * ·  
      \s-1SMB2\s0
* Statistics:BOOTP-DHCP  
  .IX Item "Statistics:BOOTP-DHCP"
* Statistics:Compare  
  .IX Item "Statistics:Compare"
  Compare two Capture Files
* Statistics:Flow Graph  
  .IX Item "Statistics:Flow Graph"
  Flow Graph: General/TCP
* Statistics:HTTP  
  .IX Item "Statistics:HTTP"
  \s-1HTTP\s0 Load Distribution, Packet Counter & Requests
* Statistics:IP Addresses  
  .IX Item "Statistics:IP Addresses"
  Count/Rate/Percent by \s-1IP\s0 Address
* Statistics:IP Destinations  
  .IX Item "Statistics:IP Destinations"
  Count/Rate/Percent by \s-1IP\s0 Address/protocol/port
* Statistics:IP Protocol Types  
  .IX Item "Statistics:IP Protocol Types"
  Count/Rate/Percent by \s-1IP\s0 Protocol Types
* Statistics:ONC-RPC Programs  
  .IX Item "Statistics:ONC-RPC Programs"
  This dialog will open a window showing aggregated \s-1SRT\s0 statistics for all
  ONC-RPC Programs/versions that exist in the capture file.
* Statistics:TCP Stream Graph  
  .IX Item "Statistics:TCP Stream Graph"
  Graphs: Round Trip; Throughput; Time-Sequence (Stevens); Time-Sequence (tcptrace)
* Statistics:UDP Multicast streams  
  .IX Item "Statistics:UDP Multicast streams"
  Multicast Streams Counts/Rates/... by Source/Destination Address/Port pairs
* Statistics:WLAN Traffic  
  .IX Item "Statistics:WLAN Traffic"
  \s-1WLAN\s0 Traffic Statistics
* Telephony:ITU-T H.225  
  .IX Item "Telephony:ITU-T H.225"
  Count ITU-T H.225 messages and their reasons.  In the first column you get a
  list of H.225 messages and H.225 message reasons, which occur in the current
  capture file.  The number of occurrences of each message or reason will be displayed
  in the second column.
  This window opened will update in semi-real time to reflect changes when
  doing live captures or when reading new capture files into **Wireshark**.
  .Sp
  You can apply an optional filter string in a dialog box, before starting
  the counter.  The statistics will only be calculated
  on those calls matching that filter.
* Telephony:SIP  
  .IX Item "Telephony:SIP"
  Activate a counter for \s-1SIP\s0 messages.  You will get the number of occurrences of each
  \s-1SIP\s0 Method and of each \s-1SIP\s0 Status-Code.  Additionally you also get the number of
  resent \s-1SIP\s0 Messages (only for \s-1SIP\s0 over \s-1UDP\s0).
  .Sp
  This window opened will update in semi-real time to reflect changes when
  doing live captures or when reading new capture files into **Wireshark**.
  .Sp
  You can apply an optional filter string in a dialog box, before starting
  the counter.  The statistics will only be calculated
  on those calls matching that filter.
* Tools:Firewall \s-1ACL\s0 Rules  
  .IX Item "Tools:Firewall ACL Rules"
* Help:Contents  
  .IX Item "Help:Contents"
  Some help texts.
* Help:Supported Protocols  
  .IX Item "Help:Supported Protocols"
  List of supported protocols and display filter protocol fields.
* Help:Manual Pages  
  .IX Item "Help:Manual Pages"
  Display locally installed \s-1HTML\s0 versions of these manual pages in a web browser.
* Help:Wireshark Online  
  .IX Item "Help:Wireshark Online"
  Various links to online resources to be open in a web browser, like
  &lt;https://www.wireshark.org&gt;.
* Help:About Wireshark  
  .IX Item "Help:About Wireshark"
  See various information about Wireshark (see About\*(R" dialog below), like the
  version, the folders used, the available plugins, ...

<a name="s-1windowss0"></a>

### \s-1WINDOWS\s0

.IX Subsection "WINDOWS"

* Main Window  
  .IX Item "Main Window"
  The main window contains the usual things like the menu, some toolbars, the
  main area and a statusbar.  The main area is split into three panes, you can
  resize each pane using a thumb\*(R" at the right end of each divider line.
  .Sp
  The main window is much more flexible than before.  The layout of the main
  window can be customized by the _Layout_ page in the dialog box popped
  up by _Edit:Preferences_, the following will describe the layout with the
  default settings.
    * Main Toolbar  
      .IX Item "Main Toolbar"
      Some menu items are available for quick access here.  There is no way to
      customize the items in the toolbar, however the toolbar can be hidden by
      _View:Main Toolbar_.
    * Filter Toolbar  
      .IX Item "Filter Toolbar"
      A display filter can be entered into the filter toolbar.
      A filter for \s-1HTTP, HTTPS,\s0 and \s-1DNS\s0 traffic might look like this:
      .Sp
      .Vb 1
        tcp.port in {80 443 53}
      .Ve
      .Sp
      Selecting the _Filter:_ button lets you choose from a list of named
      filters that you can optionally save.  Pressing the Return or Enter
      keys, or selecting the _Apply_ button, will cause the filter to be
      applied to the current list of packets.  Selecting the _Reset_ button
      clears the display filter so that all packets are displayed (again).
      .Sp
      There is no way to customize the items in the toolbar, however the toolbar
      can be hidden by _View:Filter Toolbar_.
    * Packet List Pane  
      .IX Item "Packet List Pane"
      The top pane contains the list of network packets that you can scroll
      through and select.  By default, the packet number, packet timestamp,
      source and destination addresses, protocol, and description are
      displayed for each packet; the _Columns_ page in the dialog box popped
      up by _Edit:Preferences_ lets you change this (although, unfortunately,
      you currently have to save the preferences, and exit and restart
      Wireshark, for those changes to take effect).
      .Sp
      If you click on the heading for a column, the display will be sorted by
      that column; clicking on the heading again will reverse the sort order
      for that column.
      .Sp
      An effort is made to display information as high up the protocol stack
      as possible, e.g. \s-1IP\s0 addresses are displayed for \s-1IP\s0 packets, but the
      \s-1MAC\s0 layer address is displayed for unknown packet types.
      .Sp
      The right mouse button can be used to pop up a menu of operations.
      .Sp
      The middle mouse button can be used to mark a packet.
    * Packet Details Pane  
      .IX Item "Packet Details Pane"
      The middle pane contains a display of the details of the
      currently-selected packet.  The display shows each field and its value
      in each protocol header in the stack.  The right mouse button can be
      used to pop up a menu of operations.
    * Packet Bytes Pane  
      .IX Item "Packet Bytes Pane"
      The lowest pane contains a hex and \s-1ASCII\s0 dump of the actual packet data.
      Selecting a field in the packet details highlights the corresponding
      bytes in this section.
      .Sp
      The right mouse button can be used to pop up a menu of operations.
    * Statusbar  
      .IX Item "Statusbar"
      The statusbar is divided into three parts, on the left some context dependent
      things are shown, like information about the loaded file, in the center the
      number of packets are displayed, and on the right the current configuration
      profile.
      .Sp
      The statusbar can be hidden by _View:Statusbar_.
* Preferences  
  .IX Item "Preferences"
  The _Preferences_ dialog lets you control various personal preferences
  for the behavior of **Wireshark**.
    * User Interface Preferences  
      .IX Item "User Interface Preferences"
      The _User Interface_ page is used to modify small aspects of the \s-1GUI\s0 to
      your own personal taste:
        * Selection Bars  
          .IX Item "Selection Bars"
          The selection bar in the packet list and packet details can have either
          a browse\*(R" or \*(L"select\*(R" behavior.  If the selection bar has a \*(L"browse\*(R"
          behavior, the arrow keys will move an outline of the selection bar,
          allowing you to browse the rest of the list or details without changing
          the selection until you press the space bar.  If the selection bar has a
          select\*(R" behavior, the arrow keys will move the selection bar and change
          the selection to the new item in the packet list or packet details.
        * Save Window Position  
          .IX Item "Save Window Position"
          If this item is selected, the position of the main Wireshark window will
          be saved when Wireshark exits, and used when Wireshark is started again.
        * Save Window Size  
          .IX Item "Save Window Size"
          If this item is selected, the size of the main Wireshark window will
          be saved when Wireshark exits, and used when Wireshark is started again.
        * Save Window Maximized state  
          .IX Item "Save Window Maximized state"
          If this item is selected the maximize state of the main Wireshark window
          will be saved when Wireshark exists, and used when Wireshark is started again.
        * File Open Dialog Behavior  
          .IX Item "File Open Dialog Behavior"
          This item allows the user to select how Wireshark handles the listing
          of the File Open\*(R" Dialog when opening trace files.  \*(L"Remember Last
          Directory causes Wireshark to automatically position the dialog in the
          directory of the most recently opened file, even between launches of Wireshark.
          Always Open in Directory\*(R" allows the user to define a persistent directory
          that the dialog will always default to.
        * Directory  
          .IX Item "Directory"
          Allows the user to specify a persistent File Open directory.  Trailing
          slashes or backslashes will automatically be added.
        * File Open Preview timeout  
          .IX Item "File Open Preview timeout"
          This items allows the user to define how much time is spend reading the
          capture file to present preview data in the File Open dialog.
        * Open Recent maximum list entries  
          .IX Item "Open Recent maximum list entries"
          The File menu supports a recent file list.  This items allows the user to
          specify how many files are kept track of in this list.
        * Ask for unsaved capture files  
          .IX Item "Ask for unsaved capture files"
          When closing a capture file or Wireshark itself if the file isn't saved yet
          the user is presented the option to save the file when this item is set.
        * Wrap during find  
          .IX Item "Wrap during find"
          This items determines the behavior when reaching the beginning or the end
          of a capture file.  When set the search wraps around and continues, otherwise
          it stops.
        * Settings dialogs show a save button  
          .IX Item "Settings dialogs show a save button"
          This item determines if the various dialogs sport an explicit Save button
          or that save is implicit in \s-1OK /\s0 Apply.
        * Web browser command  
          .IX Item "Web browser command"
          This entry specifies the command line to launch a web browser.  It is used
          to access online content, like the Wiki and user guide.  Use '%s' to place
          the request \s-1URL\s0 in the command line.
    * Layout Preferences  
      .IX Item "Layout Preferences"
      The _Layout_ page lets you specify the general layout of the main window.
      You can choose from six different layouts and fill the three panes with the
      contents you like.
        * Scrollbars  
          .IX Item "Scrollbars"
          The vertical scrollbars in the three panes can be set to be either on
          the left or the right.
        * Alternating row colors  
          .IX Item "Alternating row colors"
        * Hex Display  
          .IX Item "Hex Display"
          The highlight method in the hex dump display for the selected protocol
          item can be set to use either inverse video, or bold characters.
        * Toolbar style  
          .IX Item "Toolbar style"
        * Filter toolbar placement  
          .IX Item "Filter toolbar placement"
        * Custom window title  
          .IX Item "Custom window title"
    * Column Preferences  
      .IX Item "Column Preferences"
      The _Columns_ page lets you specify the number, title, and format
      of each column in the packet list.
      .Sp
      The _Column title_ entry is used to specify the title of the column
      displayed at the top of the packet list.  The type of data that the column
      displays can be specified using the _Column format_ option menu.
      The row of buttons on the left perform the following actions:
        * New  
          .IX Item "New"
          Adds a new column to the list.
        * Delete  
          .IX Item "Delete"
          Deletes the currently selected list item.
        * Up / Down  
          .IX Item "Up / Down"
          Moves the selected list item up or down one position.
    * Font Preferences  
      .IX Item "Font Preferences"
      The _Font_ page lets you select the font to be used for most text.
    * Color Preferences  
      .IX Item "Color Preferences"
      The _Colors_ page can be used to change the color of the text
      displayed in the \s-1TCP\s0 stream window and for marked packets.  To change a color,
      simply select an attribute from the Set:\*(R" menu and use the color selector to
      get the desired color.  The new text colors are displayed as a sample text.
    * Capture Preferences  
      .IX Item "Capture Preferences"
      The _Capture_ page lets you specify various parameters for capturing
      live packet data; these are used the first time a capture is started.
      .Sp
      The _Interface:_ combo box lets you specify the interface from which to
      capture packet data, or the name of a \s-1FIFO\s0 from which to get the packet
      data.
      .Sp
      The _Data link type:_ option menu lets you, for some interfaces, select
      the data link header you want to see on the packets you capture.  For
      example, in some OSes and with some versions of libpcap, you can choose,
      on an 802.11 interface, whether the packets should appear as Ethernet
      packets (with a fake Ethernet header) or as 802.11 packets.
      .Sp
      The _Limit each packet to ... bytes_ check box lets you set the
      snapshot length to use when capturing live data; turn on the check box,
      and then set the number of bytes to use as the snapshot length.
      .Sp
      The _Filter:_ text entry lets you set a capture filter expression to be
      used when capturing.
      .Sp
      If any of the environment variables \s-1SSH_CONNECTION, SSH_CLIENT,
      REMOTEHOST, DISPLAY,\s0 or \s-1SESSIONNAME\s0 are set, Wireshark will create a
      default capture filter that excludes traffic from the hosts and ports
      defined in those variables.
      .Sp
      The _Capture packets in promiscuous mode_ check box lets you specify
      whether to put the interface in promiscuous mode when capturing.
      .Sp
      The _Update list of packets in real time_ check box lets you specify
      that the display should be updated as packets are seen.
      .Sp
      The _Automatic scrolling in live capture_ check box lets you specify
      whether, in an Update list of packets in real time\*(R" capture, the packet
      list pane should automatically scroll to show the most recently captured
      packets.
    * Printing Preferences  
      .IX Item "Printing Preferences"
      The radio buttons at the top of the _Printing_ page allow you choose
      between printing packets with the _File:Print Packet_ menu item as text
      or PostScript, and sending the output directly to a command or saving it
      to a file.  The _Command:_ text entry box, on UNIX-compatible systems,
      is the command to send files to (usually **lpr**), and the _File:_ entry
      box lets you enter the name of the file you wish to save to.
      Additionally, you can select the _File:_ button to browse the file
      system for a particular save file.
    * Name Resolution Preferences  
      .IX Item "Name Resolution Preferences"
      The _Enable \s-1MAC\s0 name resolution_, _Enable network name resolution_ and
      _Enable transport name resolution_ check boxes let you specify whether
      \s-1MAC\s0 addresses, network addresses, and transport-layer port numbers
      should be translated to names.
      .Sp
      The _Enable concurrent \s-1DNS\s0 name resolution_ allows Wireshark to send out
      multiple name resolution requests and not wait for the result before
      continuing dissection.  This speeds up dissection with network name
      resolution but initially may miss resolutions.  The number of concurrent
      requests can be set here as well.
      .Sp
      _\s-1SMI\s0 paths_
      .Sp
      _\s-1SMI\s0 modules_
    * \s-1RTP\s0 Player Preferences  
      .IX Item "RTP Player Preferences"
      This page allows you to select the number of channels visible in the
      \s-1RTP\s0 player window.  It determines the height of the window, more channels
      are possible and visible by means of a scroll bar.
    * Protocol Preferences  
      .IX Item "Protocol Preferences"
      There are also pages for various protocols that Wireshark dissects,
      controlling the way Wireshark handles those protocols.
* Edit Capture Filter List  
  .IX Item "Edit Capture Filter List"
* Edit Display Filter List  
  .IX Item "Edit Display Filter List"
* Capture Filter  
  .IX Item "Capture Filter"
* Display Filter  
  .IX Item "Display Filter"
* Read Filter  
  .IX Item "Read Filter"
* Search Filter  
  .IX Item "Search Filter"
  The _Edit Capture Filter List_ dialog lets you create, modify, and
  delete capture filters, and the _Edit Display Filter List_ dialog lets
  you create, modify, and delete display filters.
  .Sp
  The _Capture Filter_ dialog lets you do all of the editing operations
  listed, and also lets you choose or construct a filter to be used when
  capturing packets.
  .Sp
  The _Display Filter_ dialog lets you do all of the editing operations
  listed, and also lets you choose or construct a filter to be used to
  filter the current capture being viewed.
  .Sp
  The _Read Filter_ dialog lets you do all of the editing operations
  listed, and also lets you choose or construct a filter to be used to
  as a read filter for a capture file you open.
  .Sp
  The _Search Filter_ dialog lets you do all of the editing operations
  listed, and also lets you choose or construct a filter expression to be
  used in a find operation.
  .Sp
  In all of those dialogs, the _Filter name_ entry specifies a
  descriptive name for a filter, e.g.  **Web and \s-1DNS\s0 traffic**.  The
  _Filter string_ entry is the text that actually describes the filtering
  action to take, as described above.The dialog buttons perform the
  following actions:
    * New  
      .IX Item "New"
      If there is text in the two entry boxes, creates a new associated list
      item.
    * Edit  
      .IX Item "Edit"
      Modifies the currently selected list item to match what's in the entry
      boxes.
    * Delete  
      .IX Item "Delete"
      Deletes the currently selected list item.
    * Add Expression...  
      .IX Item "Add Expression..."
      For display filter expressions, pops up a dialog box to allow you to
      construct a filter expression to test a particular field; it offers
      lists of field names, and, when appropriate, lists from which to select
      tests to perform on the field and values with which to compare it.  In
      that dialog box, the \s-1OK\s0 button will cause the filter expression you
      constructed to be entered into the _Filter string_ entry at the current
      cursor position.
    * \s-1OK\s0  
      .IX Item "OK"
      In the _Capture Filter_ dialog, closes the dialog box and makes the
      filter in the _Filter string_ entry the filter in the Capture
      Preferences dialog.  In the _Display Filter_ dialog, closes the dialog
      box and makes the filter in the _Filter string_ entry the current
      display filter, and applies it to the current capture.  In the Read
      Filter dialog, closes the dialog box and makes the filter in the
      _Filter string_ entry the filter in the _Open Capture File_ dialog.
      In the _Search Filter_ dialog, closes the dialog box and makes the
      filter in the _Filter string_ entry the filter in the _Find Packet_
      dialog.
    * Apply  
      .IX Item "Apply"
      Makes the filter in the _Filter string_ entry the current display
      filter, and applies it to the current capture.
    * Save  
      .IX Item "Save"
      If the list of filters being edited is the list of
      capture filters, saves the current filter list to the personal capture
      filters file, and if the list of filters being edited is the list of
      display filters, saves the current filter list to the personal display
      filters file.
    * Close  
      .IX Item "Close"
      Closes the dialog without doing anything with the filter in the Filter
      string entry.
* The Color Filters Dialog  
  .IX Item "The Color Filters Dialog"
  This dialog displays a list of color filters and allows it to be
  modified.
    * \s-1THE FILTER LIST\s0  
      .IX Item "THE FILTER LIST"
      Single rows may be selected by clicking.  Multiple rows may be selected
      by using the ctrl and shift keys in combination with the mouse button.
    * \s-1NEW\s0  
      .IX Item "NEW"
      Adds a new filter at the bottom of the list and opens the Edit Color
      Filter dialog box.  You will have to alter the filter expression at
      least before the filter will be accepted.  The format of color filter
      expressions is identical to that of display filters.  The new filter is
      selected, so it may immediately be moved up and down, deleted or edited.
      To avoid confusion all filters are unselected before the new filter is
      created.
    * \s-1EDIT\s0  
      .IX Item "EDIT"
      Opens the Edit Color Filter dialog box for the selected filter. (If this
      button is disabled you may have more than one filter selected, making it
      ambiguous which is to be edited.)
    * \s-1ENABLE\s0  
      .IX Item "ENABLE"
      Enables the selected color filter(s).
    * \s-1DISABLE\s0  
      .IX Item "DISABLE"
      Disables the selected color filter(s).
    * \s-1DELETE\s0  
      .IX Item "DELETE"
      Deletes the selected color filter(s).
    * \s-1EXPORT\s0  
      .IX Item "EXPORT"
      Allows you to choose a file in which to save the current list of color
      filters.  You may also choose to save only the selected filters.  A
      button is provided to save the filters in the global color filters file
      (you must have sufficient permissions to write this file, of course).
    * \s-1IMPORT\s0  
      .IX Item "IMPORT"
      Allows you to choose a file containing color filters which are then
      added to the bottom of the current list.  All the added filters are
      selected, so they may be moved to the correct position in the list as a
      group.  To avoid confusion, all filters are unselected before the new
      filters are imported.  A button is provided to load the filters from the
      global color filters file.
    * \s-1CLEAR\s0  
      .IX Item "CLEAR"
      Deletes your personal color filters file, reloads the global
      color filters file, if any, and closes the dialog.
    * \s-1UP\s0  
      .IX Item "UP"
      Moves the selected filter(s) up the list, making it more likely that
      they will be used to color packets.
    * \s-1DOWN\s0  
      .IX Item "DOWN"
      Moves the selected filter(s) down the list, making it less likely that
      they will be used to color packets.
    * \s-1OK\s0  
      .IX Item "OK"
      Closes the dialog and uses the color filters as they stand.
    * \s-1APPLY\s0  
      .IX Item "APPLY"
      Colors the packets according to the current list of color filters, but
      does not close the dialog.
    * \s-1SAVE\s0  
      .IX Item "SAVE"
      Saves the current list of color filters in your personal color filters
      file.  Unless you do this they will not be used the next time you start
      Wireshark.
    * \s-1CLOSE\s0  
      .IX Item "CLOSE"
      Closes the dialog without changing the coloration of the packets.  Note
      that changes you have made to the current list of color filters are not
      undone.
* Capture Options Dialog  
  .IX Item "Capture Options Dialog"
  The _Capture Options Dialog_ lets you specify various parameters for
  capturing live packet data.
  .Sp
  The _Interface:_ field lets you specify the interface from which to
  capture packet data or a command from which to get the packet data via a
  pipe.
  .Sp
  The _Link layer header type:_ field lets you specify the interfaces link
  layer header type.  This field is usually disabled, as most interface have
  only one header type.
  .Sp
  The _Capture packets in promiscuous mode_ check box lets you specify
  whether the interface should be put into promiscuous mode when
  capturing.
  .Sp
  The _Limit each packet to ... bytes_ check box and field lets you
  specify a maximum number of bytes per packet to capture and save; if the
  check box is not checked, the limit will be 262144 bytes.
  .Sp
  The _Capture Filter:_ entry lets you specify the capture filter using a
  tcpdump-style filter string as described above.
  .Sp
  The _File:_ entry lets you specify the file into which captured packets
  should be saved, as in the _Printer Options_ dialog above.  If not
  specified, the captured packets will be saved in a temporary file; you
  can save those packets to a file with the _File:Save As_ menu item.
  .Sp
  The _Use multiple files_ check box lets you specify that the capture
  should be done in multiple files\*(R" mode.  This option is disabled, if the
  _Update list of packets in real time_ option is checked.
  .Sp
  The _Next file every ...  megabyte(s)_ check box and fields lets
  you specify that a switch to a next file should be done
  if the specified filesize is reached.  You can also select the appropriate
  unit, but beware that the filesize has a maximum of 2 GiB.
  The check box is forced to be checked, as multiple files\*(R" mode requires a
  file size to be specified.
  .Sp
  The _Next file every ... minute(s)_ check box and fields lets
  you specify that the switch to a next file should be done after the specified
  time has elapsed, even if the specified capture size is not reached.
  .Sp
  The _Ring buffer with ... files_ field lets you specify the number
  of files of a ring buffer.  This feature will capture into the first file
  again, after the specified number of files have been used.
  .Sp
  The _Stop capture after ... files_ field lets you specify the number
  of capture files used, until the capture is stopped.
  .Sp
  The _Stop capture after ... packet(s)_ check box and field let
  you specify that Wireshark should stop capturing after having captured
  some number of packets; if the check box is not checked, Wireshark will
  not stop capturing at some fixed number of captured packets.
  .Sp
  The _Stop capture after ... megabyte(s)_ check box and field lets
  you specify that Wireshark should stop capturing after the file to which
  captured packets are being saved grows as large as or larger than some
  specified number of megabytes.  If the check box is not checked, Wireshark
  will not stop capturing at some capture file size (although the operating
  system on which Wireshark is running, or the available disk space, may still
  limit the maximum size of a capture file).  This option is disabled, if
  multiple files\*(R" mode is used,
  .Sp
  The _Stop capture after ...  second(s)_ check box and field let you
  specify that Wireshark should stop capturing after it has been capturing
  for some number of seconds; if the check box is not checked, Wireshark
  will not stop capturing after some fixed time has elapsed.
  .Sp
  The _Update list of packets in real time_ check box lets you specify
  whether the display should be updated as packets are captured and, if
  you specify that, the _Automatic scrolling in live capture_ check box
  lets you specify the packet list pane should automatically scroll to
  show the most recently captured packets as new packets arrive.
  .Sp
  The _Enable \s-1MAC\s0 name resolution_, _Enable network name resolution_ and
  _Enable transport name resolution_ check boxes let you specify whether
  \s-1MAC\s0 addresses, network addresses, and transport-layer port numbers
  should be translated to names.
* About  
  .IX Item "About"
  The _About_ dialog lets you view various information about Wireshark.
* About:Wireshark  
  .IX Item "About:Wireshark"
  The _Wireshark_ page lets you view general information about Wireshark,
  like the installed version, licensing information and such.
* About:Authors  
  .IX Item "About:Authors"
  The _Authors_ page shows the author and all contributors.
* About:Folders  
  .IX Item "About:Folders"
  The _Folders_ page lets you view the directory names where Wireshark is
  searching it's various configuration and other files.
* About:Plugins  
  .IX Item "About:Plugins"
  The _Plugins_ page lets you view the dissector plugin modules
  available on your system.
  .Sp
  The _Plugins List_ shows the name and version of each dissector plugin
  module found on your system.
  .Sp
  On Unix-compatible systems, the plugins are looked for in the following
  directories: the _lib/wireshark/plugins/$VERSION_ directory under the
  main installation directory (for example,
  _/usr/local/lib/wireshark/plugins/$VERSION_), and then
  _\f(CI$HOME/.wireshark/plugins_.
  .Sp
  On Windows systems, the plugins are looked for in the following
  directories: _plugins\e$VERSION_ directory under the main installation
  directory (for example, _C:\eProgram Files\eWireshark\eplugins\e$VERSION_),
  and then _\f(CI%APPDATA%\eWireshark\eplugins\e$VERSION_ (or, if \f(CW%APPDATA% isn't
  defined, _\f(CI%USERPROFILE%\eApplication Data\eWireshark\eplugins\e$VERSION_).
  .Sp
  \f(CW$VERSION is the version number of the plugin interface, which
  is typically the version number of Wireshark.  Note that a dissector
  plugin module may support more than one protocol; there is not
  necessarily a one-to-one correspondence between dissector plugin modules
  and protocols.  Protocols supported by a dissector plugin module are
  enabled and disabled using the _Edit:Protocols_ dialog box, just as
  protocols built into Wireshark are.

<a name="capture-filter-syntax"></a>

# Capture Filter Syntax

.IX Header "CAPTURE FILTER SYNTAX"
See the manual page of **pcap-filter**\|(7) or, if that doesn't exist, **tcpdump**\|(8),
or, if that doesn't exist, &lt;https://gitlab.com/wireshark/wireshark/-/wikis/CaptureFilters&gt;.

<a name="display-filter-syntax"></a>

# Display Filter Syntax

.IX Header "DISPLAY FILTER SYNTAX"
For a complete table of protocol and protocol fields that are filterable
in **Wireshark** see the **wireshark-filter**\|(4) manual page.

<a name="files"></a>

# Files

.IX Header "FILES"
These files contains various **Wireshark** configuration settings.

* Preferences  
  .IX Item "Preferences"
  The _preferences_ files contain global (system-wide) and personal
  preference settings.  If the system-wide preference file exists, it is
  read first, overriding the default settings.  If the personal preferences
  file exists, it is read next, overriding any previous values.  Note: If
  the command line flag **-o** is used (possibly more than once), it will
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
    # Vertical scrollbars should be on right side?
    # TRUE or FALSE (case-insensitive).
    gui.scrollbar_on_right: TRUE
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
  .Sp
  Note: Whenever the preferences are saved by using the _Save_ button
  in the _Edit:Preferences_ dialog box, your personal preferences file
  will be overwritten with the new settings, destroying any comments and
  unknown/obsolete settings that were in the file.
* Recent  
  .IX Item "Recent"
  The _recent_ file contains personal settings (mostly \s-1GUI\s0 related) such
  as the current **Wireshark** window size.  The file is saved at program exit and
  read in at program start automatically.  Note: The command line flag **-o**
  may be used to override settings from this file.
  .Sp
  The settings in this file have the same format as in the _preferences_
  files, and the same directory as for the personal preferences file is
  used.
  .Sp
  Note: Whenever Wireshark is closed, your recent file
  will be overwritten with the new settings, destroying any comments and
  unknown/obsolete settings that were in the file.
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
  If a protocol is listed in the global _disabled\_protos_ file, it is not
  displayed in the _Analyze:Enabled Protocols_ dialog box, and so cannot
  be enabled by the user.
  .Sp
  The global _disabled\_protos_ file uses the same directory as the global
  preferences file.
  .Sp
  The personal _disabled\_protos_ file uses the same directory as the
  personal preferences file.
  .Sp
  Note: Whenever the disabled protocols list is saved by using the _Save_
  button in the _Analyze:Enabled Protocols_ dialog box, your personal
  disabled protocols file will be overwritten with the new settings,
  destroying any comments that were in the file.
* Name Resolution (hosts)  
  .IX Item "Name Resolution (hosts)"
  If the personal _hosts_ file exists, it is
  used to resolve IPv4 and IPv6 addresses before any other
  attempts are made to resolve them.  The file has the standard _hosts_
  file syntax; each line contains one \s-1IP\s0 address and name, separated by
  whitespace.  The same directory as for the personal preferences file is used.
  .Sp
  Capture filter name resolution is handled by libpcap on UNIX-compatible
  systems and WinPcap on Windows.  As such the Wireshark personal _hosts_ file
  will not be consulted for capture filter name resolution.
* Name Resolution (subnets)  
  .IX Item "Name Resolution (subnets)"
  If an IPv4 address cannot be translated via name resolution (no exact
  match is found) then a partial match is attempted via the _subnets_ file.
  Both the global _subnets_ file and personal _subnets_ files are used
  if they exist.
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
  names.  First the personal _ethers_ file is tried and if an address is not
  found there the global _ethers_ file is tried next.
  .Sp
  Each line contains one hardware address and name, separated by
  whitespace.  The digits of the hardware address are separated by colons
  (:), dashes (-) or periods (.).  The same separator character must be
  used consistently in an address.  The following three lines are valid
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
  systems and WinPcap on Windows.  As such the Wireshark personal _ethers_ file
  will not be consulted for capture filter name resolution.
* Name Resolution (manuf)  
  .IX Item "Name Resolution (manuf)"
  The _manuf_ file is used to match the 3-byte vendor portion of a 6-byte
  hardware address with the manufacturer's name; it can also contain well-known
  \s-1MAC\s0 addresses and address ranges specified with a netmask.  The format of the
  file is the same as the _ethers_ files, except that entries such as:
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
  of the address must match.  The above entry, for example, has 40
  significant bits, or 5 bytes, and would match addresses from
  00-00-0C-07-AC-00 through 00-00-0C-07-AC-FF.  The mask need not be a
  multiple of 8.
  .Sp
  The _manuf_ file is looked for in the same directory as the global
  preferences file.
* Name Resolution (services)  
  .IX Item "Name Resolution (services)"
  The _services_ file is used to translate port numbers into names.
  Both the global _services_ file and personal _services_ files are used
  if they exist.
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
  names.  First the global _ipxnets_ file is tried and if that address is not
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
* Capture Filters  
  .IX Item "Capture Filters"
  The _cfilters_ files contain system-wide and personal capture filters.
  Each line contains one filter, starting with the string displayed in the
  dialog box in quotation marks, followed by the filter string itself:
  .Sp
  .Vb 2
    "HTTP" port 80
    "DCERPC" port 135
  .Ve
  .Sp
  The global _cfilters_ file uses the same directory as the
  global preferences file.
  .Sp
  The personal _cfilters_ file uses the same directory as the personal
  preferences file.  It is written through the Capture:Capture Filters
  dialog.
  .Sp
  If the global _cfilters_ file exists, it is used only if the personal
  _cfilters_ file does not exist; global and personal capture filters are
  not merged.
* Display Filters  
  .IX Item "Display Filters"
  The _dfilters_ files contain system-wide and personal display filters.
  Each line contains one filter, starting with the string displayed in the
  dialog box in quotation marks, followed by the filter string itself:
  .Sp
  .Vb 2
    "HTTP" http
    "DCERPC" dcerpc
  .Ve
  .Sp
  The global _dfilters_ file uses the same directory as the
  global preferences file.
  .Sp
  The personal _dfilters_ file uses the same directory as the
  personal preferences file.  It is written through the Analyze:Display
  Filters dialog.
  .Sp
  If the global _dfilters_ file exists, it is used only if the personal
  _dfilters_ file does not exist; global and personal display filters are
  not merged.
* Color Filters (Coloring Rules)  
  .IX Item "Color Filters (Coloring Rules)"
  The _colorfilters_ files contain system-wide and personal color filters.
  Each line contains one filter, starting with the string displayed in the
  dialog box, followed by the corresponding display filter.  Then the
  background and foreground colors are appended:
  .Sp
  .Vb 3
    # a comment
    @tcp@tcp@[59345,58980,65534][0,0,0]
    @udp@udp@[28834,57427,65533][0,0,0]
  .Ve
  .Sp
  The global _colorfilters_ file uses the same directory as the
  global preferences file.
  .Sp
  The personal _colorfilters_ file uses the same directory as the
  personal preferences file.  It is written through the View:Coloring Rules
  dialog.
  .Sp
  If the global _colorfilters_ file exists, it is used only if the personal
  _colorfilters_ file does not exist; global and personal color filters are
  not merged.
* Plugins  
  .IX Item "Plugins"
  See above in the description of the About:Plugins page.

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
  If this environment variable is set, **Wireshark** will call **abort**\|(3)
  when a dissector bug is encountered.  **abort**\|(3) will cause the program to
  exit abnormally; if you are running **Wireshark** in a debugger, it
  should halt in the debugger and allow inspection of the process, and, if
  you are not running it in a debugger, it will, on some OSes, assuming
  your environment is configured correctly, generate a core dump file.
  This can be useful to developers attempting to troubleshoot a problem
  with a protocol dissector.
* \s-1WIRESHARK_ABORT_ON_TOO_MANY_ITEMS\s0  
  .IX Item "WIRESHARK_ABORT_ON_TOO_MANY_ITEMS"
  If this environment variable is set, **Wireshark** will call **abort**\|(3)
  if a dissector tries to add too many items to a tree (generally this
  is an indication of the dissector not breaking out of a loop soon enough).
  **abort**\|(3) will cause the program to exit abnormally; if you are running
  **Wireshark** in a debugger, it should halt in the debugger and allow
  inspection of the process, and, if you are not running it in a debugger,
  it will, on some OSes, assuming your environment is configured correctly,
  generate a core dump file.  This can be useful to developers attempting to
  troubleshoot a problem with a protocol dissector.
* \s-1WIRESHARK_QUIT_AFTER_CAPTURE\s0  
  .IX Item "WIRESHARK_QUIT_AFTER_CAPTURE"
  Cause **Wireshark** to exit after the end of the capture session.  This
  doesn't automatically start a capture; you must still use **-k** to do
  that.  You must also specify an autostop condition, e.g.  **-c** or -a
  duration:....  This means that you will not be able to see the results
  of the capture after it stops; it's primarily useful for testing.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark-filter**\|(4), **tshark**\|(1), **editcap**\|(1), **pcap**\|(3), **dumpcap**\|(1), **mergecap**\|(1),
**text2pcap**\|(1), **pcap-filter**\|(7) or **tcpdump**\|(8)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The latest version of **Wireshark** can be found at
&lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
    .SS "Original Author"
    .IX Subsection "Original Author"
    .Vb 1
        Gerald Combs            <gerald[AT]wireshark.org>
    .Ve
    .SS "Contributors"
    .IX Subsection "Contributors"
    .Vb 10
        Gilbert Ramirez         <gram[AT]alumni.rice.edu>
        Thomas Bottom           <tom.bottom[AT]labxtechnologies.com>
        Chris Pane              <chris.pane[AT]labxtechnologies.com>
        Hannes R. Boehm         <hannes[AT]boehm.org>
        Mike Hall               <mike[AT]hallzone.net>
        Bobo Rajec              <bobo[AT]bsp-consulting.sk>
        Laurent Deniel          <laurent.deniel[AT]free.fr>
        Don Lafontaine          <lafont02[AT]cn.ca>
        Guy Harris              <guy[AT]alum.mit.edu>
        Simon Wilkinson         <sxw[AT]dcs.ed.ac.uk>
        Jorg Mayer              <jmayer[AT]loplof.de>
        Martin Maciaszek        <fastjack[AT]i-s-o.net>
        Didier Jorand           <Didier.Jorand[AT]alcatel.fr>
        Jun-ichiro itojun Hagino <itojun[AT]itojun.org>
        Richard Sharpe          <realrichardsharpe[AT]gmail.com>
        John McDermott          <jjm[AT]jkintl.com>
        Jeff Jahr               <jjahr[AT]shastanets.com>
        Brad Robel-Forrest      <bradr[AT]watchguard.com>
        Ashok Narayanan         <ashokn[AT]cisco.com>
        Aaron Hillegass         <aaron[AT]classmax.com>
        Jason Lango             <jal[AT]netapp.com>
        Johan Feyaerts          <Johan.Feyaerts[AT]siemens.com>
        Olivier Abad            <oabad[AT]noos.fr>
        Thierry Andry           <Thierry.Andry[AT]advalvas.be>
        Jeff Foster             <jfoste[AT]woodward.com>
        Peter Torvals           <petertv[AT]xoommail.com>
        Christophe Tronche      <ch.tronche[AT]computer.org>
        Nathan Neulinger        <nneul[AT]umr.edu>
        Tomislav Vujec          <tvujec[AT]carnet.hr>
        Kojak                   <kojak[AT]bigwig.net>
        Uwe Girlich             <Uwe.Girlich[AT]philosys.de>
        Warren Young            <tangent[AT]mail.com>
        Heikki Vatiainen        <hessu[AT]cs.tut.fi>
        Greg Hankins            <gregh[AT]twoguys.org>
        Jerry Talkington        <jtalkington[AT]users.sourceforge.net>
        Dave Chapeskie          <dchapes[AT]ddm.on.ca>
        James Coe               <jammer[AT]cin.net>
        Bert Driehuis           <driehuis[AT]playbeing.org>
        Stuart Stanley          <stuarts[AT]mxmail.net>
        John Thomes             <john[AT]ensemblecom.com>
        Laurent Cazalet         <laurent.cazalet[AT]mailclub.net>
        Thomas Parvais          <thomas.parvais[AT]advalvas.be>
        Gerrit Gehnen           <G.Gehnen[AT]atrie.de>
        Craig Newell            <craign[AT]cheque.uq.edu.au>
        Ed Meaney               <emeaney[AT]cisco.com>
        Dietmar Petras          <DPetras[AT]ELSA.de>
        Fred Reimer             <fwr[AT]ga.prestige.net>
        Florian Lohoff          <flo[AT]rfc822.org>
        Jochen Friedrich        <jochen+ethereal[AT]scram.de>
        Paul Welchinski         <paul.welchinski[AT]telusplanet.net>
        Doug Nazar              <nazard[AT]dragoninc.on.ca>
        Andreas Sikkema         <h323[AT]ramdyne.nl>
        Mark Muhlestein         <mmm[AT]netapp.com>
        Graham Bloice           <graham.bloice[AT]trihedral.com>
        Ralf Schneider          <ralf.schneider[AT]alcatel.se>
        Yaniv Kaul              <mykaul[AT]gmail.com>
        Paul Ionescu            <paul[AT]acorp.ro>
        Mark Burton             <markb[AT]ordern.com>
        Stefan Raab             <sraab[AT]cisco.com>
        Mark Clayton            <clayton[AT]shore.net>
        Michael Rozhavsky       <mike[AT]tochna.technion.ac.il>
        Dug Song                <dugsong[AT]monkey.org>
        Michael Tuxen           <tuexen[AT]wireshark.org>
        Bruce Korb              <bkorb[AT]sco.com>
        Jose Pedro Oliveira     <jpo[AT]di.uminho.pt>
        David Frascone          <dave[AT]frascone.com>
        Peter Kjellerstedt      <pkj[AT]axis.com>
        Phil Techau             <phil_t[AT]altavista.net>
        Wes Hardaker            <hardaker[AT]users.sourceforge.net>
        Robert Tsai             <rtsai[AT]netapp.com>
        Craig Metz              <cmetz[AT]inner.net>
        Per Flock               <per.flock[AT]axis.com>
        Jack Keane              <jkeane[AT]OpenReach.com>
        Brian Wellington        <bwelling[AT]xbill.org>
        Santeri Paavolainen     <santtu[AT]ssh.com>
        Ulrich Kiermayr         <uk[AT]ap.univie.ac.at>
        Neil Hunter             <neil.hunter[AT]energis-squared.com>
        Ralf Holzer             <ralf[AT]well.com>
        Craig Rodrigues         <rodrigc[AT]attbi.com>
        Ed Warnicke             <hagbard[AT]physics.rutgers.edu>
        Johan Jorgensen         <johan.jorgensen[AT]axis.com>
        Frank Singleton         <frank.singleton[AT]ericsson.com>
        Kevin Shi               <techishi[AT]ms22.hinet.net>
        Mike Frisch             <mfrisch[AT]isurfer.ca>
        Burke Lau               <burke_lau[AT]agilent.com>
        Martti Kuparinen        <martti.kuparinen[AT]iki.fi>
        David Hampton           <dhampton[AT]mac.com>
        Kent Engstrom           <kent[AT]unit.liu.se>
        Ronnie Sahlberg         <ronniesahlberg[AT]gmail.com>
        Borosa Tomislav         <tomislav.borosa[AT]SIEMENS.HR>
        Alexandre P. Ferreira   <alexandref[AT]tcoip.com.br>
        Simharajan Srishylam    <Simharajan.Srishylam[AT]netapp.com>
        Greg Kilfoyle           <gregk[AT]redback.com>
        James E. Flemer         <jflemer[AT]acm.jhu.edu>
        Peter Lei               <peterlei[AT]cisco.com>
        Thomas Gimpel           <thomas.gimpel[AT]ferrari.de>
        Albert Chin             <china[AT]thewrittenword.com>
        Charles Levert          <charles[AT]comm.polymtl.ca>
        Todd Sabin              <tas[AT]webspan.net>
        Eduardo Perez Ureta     <eperez[AT]dei.inf.uc3m.es>
        Martin Thomas           <martin_a_thomas[AT]yahoo.com>
        Hartmut Mueller         <hartmut[AT]wendolene.ping.de>
        Michal Melerowicz       <Michal.Melerowicz[AT]nokia.com>
        Hannes Gredler          <hannes[AT]juniper.net>
        Inoue                   <inoue[AT]ainet.or.jp>
        Olivier Biot            <obiot.ethereal[AT]gmail.com>
        Patrick Wolfe           <pjw[AT]zocalo.cellular.ameritech.com>
        Martin Held             <Martin.Held[AT]icn.siemens.de>
        Riaan Swart             <rswart[AT]cs.sun.ac.za>
        Christian Lacunza       <celacunza[AT]gmx.net>
        Scott Renfro            <scott[AT]renfro.org>
        Juan Toledo             <toledo[AT]users.sourceforge.net>
        Jean-Christian Pennetier <jeanchristian.pennetier[AT]rd.francetelecom.fr>
        Jian Yu                 <bgp4news[AT]yahoo.com>
        Eran Mann               <emann[AT]opticalaccess.com>
        Andy Hood               <ajhood[AT]fl.net.au>
        Randy McEoin            <rmceoin[AT]ahbelo.com>
        Edgar Iglesias          <edgar.iglesias[AT]axis.com>
        Martina Obermeier       <Martina.Obermeier[AT]icn.siemens.de>
        Javier Achirica         <achirica[AT]ttd.net>
        B. Johannessen          <bob[AT]havoq.com>
        Thierry Pelle           <thierry.pelle[AT]laposte.net>
        Francisco Javier Cabello <fjcabello[AT]vtools.es>
        Laurent Rabret          <laurent.rabret[AT]rd.francetelecom.fr>
        nuf si                  <gnippiks[AT]yahoo.com>
        Jeff Morriss            <jeff.morriss.ws[AT]gmail.com>
        Aamer Akhter            <aakhter[AT]cisco.com>
        Pekka Savola            <pekkas[AT]netcore.fi>
        David Eisner            <deisner[AT]gmail.com>
        Steve Dickson           <steved[AT]talarian.com>
        Markus Seehofer         <Markus.Seehofer[AT]hirschmann.de>
        Lee Berger              <lberger[AT]roy.org>
        Motonori Shindo         <motonori[AT]shin.do>
        Terje Krogdahl          <tekr[AT]nextra.com>
        Jean-Francois Mule      <jfm[AT]cablelabs.com>
        Thomas Wittwer          <thomas.wittwer[AT]iclip.ch>
        Matthias Nyffenegger    <matthias.nyffenegger[AT]iclip.ch>
        Palle Lyckegaard        <Palle[AT]lyckegaard.dk>
        Nicolas Balkota         <balkota[AT]mac.com>
        Tom Uijldert            <Tom.Uijldert[AT]cmg.nl>
        Akira Endoh             <endoh[AT]netmarks.co.jp>
        Graeme Hewson           <ghewson[AT]wormhole.me.uk>
        Pasi Eronen             <pe[AT]iki.fi>
        Georg von Zezschwitz    <gvz[AT]2scale.net>
        Steffen Weinreich       <steve[AT]weinreich.org>
        Marc Milgram            <ethereal[AT]mmilgram.NOSPAMmail.net>
        Gordon McKinney         <gordon[AT]night-ray.com>
        Pavel Novotny           <Pavel.Novotny[AT]icn.siemens.de>
        Shinsuke Suzuki         <suz[AT]kame.net>
        Andrew C. Feren         <acferen[AT]yahoo.com>
        Tomas Kukosa            <tomas.kukosa[AT]siemens.com>
        Andreas Stockmeier      <a.stockmeier[AT]avm.de>
        Pekka Nikander          <pekka.nikander[AT]nomadiclab.com>
        Hamish Moffatt          <hamish[AT]cloud.net.au>
        Kazushi Sugyo           <k-sugyou[AT]nwsl.mesh.ad.jp>
        Tim Potter              <tpot[AT]samba.org>
        Raghu Angadi            <rangadi[AT]inktomi.com>
        Taisuke Sasaki          <sasaki[AT]soft.net.fujitsu.co.jp>
        Tim Newsham             <newsham[AT]lava.net>
        Tom Nisbet              <Tnisbet[AT]VisualNetworks.com>
        Darren New              <dnew[AT]san.rr.com>
        Pavel Mores             <pvl[AT]uh.cz>
        Bernd Becker            <bb[AT]bernd-becker.de>
        Heinz Prantner          <Heinz.Prantner[AT]radisys.com>
        Irfan Khan              <ikhan[AT]qualcomm.com>
        Jayaram V.R             <vjayar[AT]cisco.com>
        Dinesh Dutt             <ddutt[AT]cisco.com>
        Nagarjuna Venna         <nvenna[AT]Brixnet.com>
        Jirka Novak             <j.novak[AT]netsystem.cz>
        Ricardo Barroetavena    <rbarroetavena[AT]veufort.com>
        Alan Harrison           <alanharrison[AT]mail.com>
        Mike Frantzen           <frantzen[AT]w4g.org>
        Charlie Duke            <cduke[AT]fvc.com>
        Alfred Arnold           <Alfred.Arnold[AT]elsa.de>
        Dermot Bradley          <dermot.bradley[AT]openwave.com>
        Adam Sulmicki           <adam[AT]cfar.umd.edu>
        Kari Tiirikainen        <kari.tiirikainen[AT]nokia.com>
        John Mackenzie          <John.A.Mackenzie[AT]t-online.de>
        Peter Valchev           <pvalchev[AT]openbsd.org>
        Alex Rozin              <Arozin[AT]mrv.com>
        Jouni Malinen           <jkmaline[AT]cc.hut.fi>
        Paul E. Erkkila         <pee[AT]erkkila.org>
        Jakob Schlyter          <jakob[AT]openbsd.org>
        Jim Sienicki            <sienicki[AT]issanni.com>
        Steven French           <sfrench[AT]us.ibm.com>
        Diana Eichert           <deicher[AT]sandia.gov>
        Blair Cooper            <blair[AT]teamon.com>
        Kikuchi Ayamura         <ayamura[AT]ayamura.org>
        Didier Gautheron        <dgautheron[AT]magic.fr>
        Phil Williams           <csypbw[AT]comp.leeds.ac.uk>
        Kevin Humphries         <khumphries[AT]networld.com>
        Erik Nordstrom          <erik.nordstrom[AT]it.uu.se>
        Devin Heitmueller       <dheitmueller[AT]netilla.com>
        Chenjiang Hu            <chu[AT]chiaro.com>
        Kan Sasaki              <sasaki[AT]fcc.ad.jp>
        Stefan Wenk             <stefan.wenk[AT]gmx.at>
        Ruud Linders            <ruud[AT]lucent.com>
        Andrew Esh              <Andrew.Esh[AT]tricord.com>
        Greg Morris             <GMORRIS[AT]novell.com>
        Dirk Steinberg          <dws[AT]dirksteinberg.de>
        Kari Heikkila           <kari.o.heikkila[AT]nokia.com>
        Olivier Dreux           <Olivier.Dreux[AT]alcatel.fr>
        Michael Stiller         <ms[AT]2scale.net>
        Antti Tuominen          <ajtuomin[AT]tml.hut.fi>
        Martin Gignac           <lmcgign[AT]mobilitylab.net>
        John Wells              <wells[AT]ieee.org>
        Loic Tortay             <tortay[AT]cc.in2p3.fr>
        Steve Housley           <Steve_Housley[AT]eur.3com.com>
        Peter Hawkins           <peter[AT]hawkins.emu.id.au>
        Bill Fumerola           <billf[AT]FreeBSD.org>
        Chris Waters            <chris[AT]waters.co.nz>
        Solomon Peachy          <pizza[AT]shaftnet.org>
        Jaime Fournier          <Jaime.Fournier[AT]hush.com>
        Markus Steinmann        <ms[AT]seh.de>
        Tsutomu Mieno           <iitom[AT]utouto.com>
        Yasuhiro Shirasaki      <yasuhiro[AT]gnome.gr.jp>
        Anand V. Narwani        <anand[AT]narwani.org>
        Christopher K. St. John <cks[AT]distributopia.com>
        Nix                     <nix[AT]esperi.demon.co.uk>
        Liviu Daia              <Liviu.Daia[AT]imar.ro>
        Richard Urwin           <richard[AT]soronlin.org.uk>
        Prabhakar Krishnan      <Prabhakar.Krishnan[AT]netapp.com>
        Jim McDonough           <jmcd[AT]us.ibm.com>
        Sergei Shokhor          <sshokhor[AT]uroam.com>
        Hidetaka Ogawa          <ogawa[AT]bs2.qnes.nec.co.jp>
        Jan Kratochvil          <short[AT]ucw.cz>
        Alfred Koebler          <ak[AT]icon-sult.de>
        Vassilii Khachaturov    <Vassilii.Khachaturov[AT]comverse.com>
        Bill Studenmund         <wrstuden[AT]wasabisystems.com>
        Brian Bruns             <camber[AT]ais.org>
        Flavio Poletti          <flavio[AT]polettix.it>
        Marcus Haebler          <haeblerm[AT]yahoo.com>
        Ulf Lamping             <ulf.lamping[AT]web.de>
        Matthew Smart           <smart[AT]monkey.org>
        Luke Howard             <lukeh[AT]au.padl.com>
        PC Drew                 <drewpc[AT]ibsncentral.com>
        Renzo Tomas             <renzo.toma[AT]xs4all.nl>
        Clive A. Stubbings      <eth[AT]vjet.demon.co.uk>
        Steve Langasek          <vorlon[AT]netexpress.net>
        Brad Hards              <bhards[AT]bigpond.net.au>
        cjs 2895                <cjs2895[AT]hotmail.com>
        Lutz Jaenicke           <Lutz.Jaenicke[AT]aet.TU-Cottbus.DE>
        Senthil Kumar Nagappan  <sknagappan[AT]yahoo.com>
        Jason House             <jhouse[AT]mitre.org>
        Peter Fales             <psfales[AT]lucent.com>
        Fritz Budiyanto         <fritzb88[AT]yahoo.com>
        Jean-Baptiste Marchand  <Jean-Baptiste.Marchand[AT]hsc.fr>
        Andreas Trauer          <andreas.trauer[AT]siemens.com>
        Ronald Henderson        <Ronald.Henderson[AT]CognicaseUSA.com>
        Brian Ginsbach          <ginsbach[AT]cray.com>
        Dave Richards           <d_m_richards[AT]comcast.net>
        Martin Regner           <martin.regner[AT]chello.se>
        Jason Greene            <jason[AT]inetgurus.net>
        Marco Molteni           <mmolteni[AT]cisco.com>
        James Harris            <jharris[AT]fourhorsemen.org>
        rmkml                   <rmkml[AT]wanadoo.fr>
        Anders Broman           <anders.broman[AT]ericsson.com>
        Christian Falckenberg   <christian.falckenberg[AT]nortelnetworks.com>
        Huagang Xie             <xie[AT]lids.org>
        Pasi Kovanen            <Pasi.Kovanen[AT]tahoenetworks.fi>
        Teemu Rinta-aho         <teemu.rinta-aho[AT]nomadiclab.com>
        Martijn Schipper        <mschipper[AT]globespanvirata.com>
        Wayne Parrott           <wayne_p[AT]pacific.net.au>
        Laurent Meyer           <laurent.meyer6[AT]wanadoo.fr>
        Lars Roland             <Lars.Roland[AT]gmx.net>
        Miha Jemec              <m.jemec[AT]iskratel.si>
        Markus Friedl           <markus[AT]openbsd.org>
        Todd Montgomery         <tmontgom[AT]tibco.com>
        emre                    <emre[AT]flash.net>
        Stephen Shelley         <steve.shelley[AT]attbi.com>
        Erwin Rol               <erwin[AT]erwinrol.com>
        Duncan Laurie           <duncan[AT]sun.com>
        Tony Schene             <schene[AT]pcisys.net>
        Matthijs Melchior       <mmelchior[AT]xs4all.nl>
        Garth Bushell           <gbushell[AT]elipsan.com>
        Mark C. Brown           <mbrown[AT]hp.com>
        Can Erkin Acar          <canacar[AT]eee.metu.edu.tr>
        Martin Warnes           <martin.warnes[AT]ntlworld.com>
        J Bruce Fields          <bfields[AT]fieldses.org>
        tz                      <tz1[AT]mac.com>
        Jeff Liu                <jqliu[AT]broadcom.com>
        Niels Koot              <Niels.Koot[AT]logicacmg.com>
        Lionel Ains             <lains[AT]gmx.net>
        Joakim Wiberg           <jow[AT]hms-networks.com>
        Jeff Rizzo              <riz[AT]boogers.sf.ca.us>
        Christoph Wiest         <ch.wiest[AT]tesionmail.de>
        Xuan Zhang              <xz[AT]aemail4u.com>
        Thierry Martin          <thierry.martin[AT]accellent-group.com>
        Oleg Terletsky          <oleg.terletsky[AT]comverse.com>
        Michael Lum             <mlum[AT]telostech.com>
        Shiang-Ming Huang       <smhuang[AT]pcs.csie.nctu.edu.tw>
        Tony Lindstrom          <tony.lindstrom[AT]ericsson.com>
        Niklas Ogren            <niklas.ogren[AT]71.se>
        Jesper Peterson         <jesper[AT]endace.com>
        Giles Scott             <gscott[AT]arubanetworks.com>
        Vincent Jardin          <vincent.jardin[AT]6wind.com>
        Jean-Michel Fayard      <jean-michel.fayard[AT]moufrei.de>
        Josef Korelus           <jkor[AT]quick.cz>
        Brian K. Teravskis      <Brian_Teravskis[AT]Cargill.com>
        Nathan Jennings         <natej.git[AT]gmail.com>
        Hans Viens              <hviens[AT]mediatrix.com>
        Kevin A. Noll           <kevin.noll[AT]versatile.com>
        Emanuele Caratti        <wiz[AT]libero.it>
        Graeme Reid             <graeme.reid[AT]norwoodsystems.com>
        Lars Ruoff              <lars.ruoff[AT]sxb.bsf.alcatel.fr>
        Samuel Qu               <samuel.qu[AT]utstar.com>
        Baktha Muralitharan     <muralidb[AT]cisco.com>
        Loic Minier             <lool[AT]dooz.org>
        Marcel Holtmann         <marcel[AT]holtmann.org>
        Scott Emberley          <scotte[AT]netinst.com>
        Brian Fundakowski Feldman <bfeldman[AT]fla.fujitsu.com>
        Yuriy Sidelnikov        <ysidelnikov[AT]hotmail.com>
        Matthias Drochner       <M.Drochner[AT]fz-juelich.de>
        Dave Sclarsky           <dave_sclarsky[AT]cnt.com>
        Scott Hovis             <scott.hovis[AT]ums.msfc.nasa.gov>
        David Fort              <david.fort[AT]irisa.fr>
        Felix Fei               <felix.fei[AT]utstar.com>
        Christoph Neusch        <christoph.neusch[AT]nortelnetworks.com>
        Jan Kiszka              <jan.kiszka[AT]web.de>
        Joshua Craig Douglas    <jdouglas[AT]enterasys.com>
        Dick Gooris             <gooris[AT]alcatel-lucent.com>
        Michael Shuldman        <michaels[AT]inet.no>
        Tadaaki Nagao           <nagao[AT]iij.ad.jp>
        Aaron Woo               <woo[AT]itd.nrl.navy.mil>
        Chris Wilson            <chris[AT]mxtelecom.com>
        Rolf Fiedler            <Rolf.Fiedler[AT]Innoventif.com>
        Alastair Maw            <ethereal[AT]almaw.com>
        Sam Leffler             <sam[AT]errno.com>
        Martin Mathieson        <martin.r.mathieson[AT]googlemail.com>
        Christian Wagner        <Christian.Wagner[AT]stud.uni-karlsruhe.de>
        Edwin Calo              <calo[AT]fusemail.com>
        Ian Schorr              <ischorr[AT]comcast.net>
        Rowan McFarland         <rmcfarla[AT]cisco.com>
        John Engelhart          <johne[AT]zang.com>
        Ryuji Somegawa          <ryuji-so[AT]is.aist-nara.ac.jp>
        metatech                <metatechbe[AT]gmail.com>
        Brian Wheeler           <Brian.Wheeler[AT]arrisi.com>
        Josh Bailey             <joshbailey[AT]lucent.com>
        Jelmer Vernooij         <jelmer[AT]samba.org>
        Duncan Sargeant         <dunc-ethereal-dev[AT]rcpt.to>
        Love Hornquist A*ostrand  <lha[AT]it.su.se>
        Lukas Pokorny           <maskis[AT]seznam.cz>
        Carlos Pignataro        <cpignata[AT]cisco.com>
        Thomas Anders           <thomas.anders[AT]blue-cable.de>
        Rich Coe                <Richard.Coe[AT]med.ge.com>
        Dominic Bechaz          <bdo[AT]zhwin.ch>
        Richard van der Hoff        <richardv[AT]mxtelecom.com>
        Shaun Jackman               <sjackman[AT]gmail.com>
        Jon Oberheide           <jon[AT]oberheide.org>
        Henry Ptasinski             <henryp[AT]broadcom.com>
        Roberto Morro               <roberto.morro[AT]telecomitalia.it>
        Chris Maynard               <Christopher.Maynard[AT]GTECH.COM>
        SEKINE Hideki               <sekineh[AT]gf7.so-net.ne.jp>
        Jeff Connelly               <shellreef+mp2p[AT]gmail.com>
        Irene Rungeler              <ruengeler[AT]wireshark.org>
        M. Ortega y Strupp  <moys[AT]loplof.de>
        Kelly Byrd          <kbyrd-ethereal[AT]memcpy.com>
        Luis Ontanon                <luis.ontanon[AT]gmail.com>
        Luca Deri           <deri[AT]ntop.org>
        Viorel Suman                <vsuman[AT]avmob.ro>
        Alejandro Vaquero   <alejandro.vaquero[AT]verso.com>
        Francesco Fondelli  <francesco.fondelli[AT]gmail.com>
        Artem Tamazov           <artem.tamazov[AT]tellabs.com>
        Dmitry Trebich          <dmitry.trebich[AT]gmail.com>
        Bill Meier          <wmeier[AT]newsguy.com>
        Susanne Edlund              <Susanne.Edlund[AT]ericsson.com>
        Victor Stratan              <hidralisk[AT]yahoo.com>
        Peter Johansson             <PeterJohansson73[AT]gmail.com>
        Stefan Metzmacher   <metze[AT]samba.org>
        Abhijit Menon-Sen   <ams[AT]oryx.com>
        James Fields                <jvfields[AT]tds.net>
        Kevin Johnson               <kjohnson[AT]secureideas.net>
        Mike Duigou         <bondolo[AT]dev.java.net>
        Deepak Jain         <jain1971[AT]yahoo.com>
        Stefano Pettini             <spettini[AT]users.sourceforge.net>
        Jon Ringle          <ml-ethereal[AT]ringle.org>
        Tim Endean          <endeant[AT]hotmail.com>
        Charlie Lenahan             <clenahan[AT]fortresstech.com>
        Takeshi Nakashima   <T.Nakashima[AT]jp.yokogawa.com>
        Shoichi Sakane              <sakane[AT]tanu.org>
        Michael Richardson  <Michael.Richardson[AT]protiviti.com>
        Olivier Jacques             <olivier.jacques[AT]hp.com>
        Francisco Alcoba    <francisco.alcoba[AT]ericsson.com>
        Nils O. Selasdal    <noselasd[AT]asgaard.homelinux.org>
        Guillaume Chazarain         <guichaz[AT]yahoo.fr>
        Angelo Bannack              <angelo.bannack[AT]siemens.com>
        Paolo Frigo         <paolofrigo[AT]gmail.com>
        Jeremy J Ouellette  <jouellet[AT]scires.com>
        Aboo Valappil               <valappil_aboo[AT]emc.com>
        Fred Hoekstra               <fred.hoekstra[AT]philips.com>
        Ankur Aggarwal              <ankur[AT]in.athenasemi.com>
        Lucian Piros                <lpiros[AT]avmob.ro>
        Juan Gonzalez               <juan.gonzalez[AT]pikatech.com>
        Brian Bogora                <brian_bogora[AT]mitel.com>
        Jim Young           <sysjhy[AT]langate.gsu.edu>
        Jeff Snyder         <jeff[AT]mxtelecom.com>
        William Fiveash             <William.Fiveash[AT]sun.com>
        Graeme Lunt         <graeme.lunt[AT]smhs.co.uk>
        Menno Andriesse             <s5066[AT]nc3a.nato.int>
        Stig Bjorlykke              <stig[AT]bjorlykke.org>
        Kyle J. Harms               <kyle.j.harms[AT]boeing.com>
        Eric Wedel          <ewedel[AT]bluearc.com>
        Secfire                     <secfire[AT]gmail.com>
        Eric Hultin         <Eric.Hultin[AT]arrisi.com>
        Paolo Abeni         <paolo.abeni[AT]email.it>
        W. Borgert          <debacle[AT]debian.org>
        Frederic Roudaut    <frederic.roudaut[AT]irisa.fr>
        Christoph Scholz    <scholz_ch[AT]web.de>
        Wolfgang Hansmann   <hansmann[AT]cs.uni-bonn.de>
        Kees Cook           <kees[AT]outflux.net>
        Thomas Dreibholz    <dreibh[AT]iem.uni-due.de>
        Authesserre Samuel  <sauthess[AT]gmail.com>
        Balint Reczey               <balint[AT]balintreczey.hu>
        Stephen Fisher              <stephenfisher[AT]centurylink.net>
        Krzysztof Burghardt <krzysztof[AT]burghardt.pl>
        Peter Racz          <racz[AT]ifi.unizh.ch>
        Jakob Bratkovic             <j.bratkovic[AT]iskratel.si>
        Mark Lewis          <mlewis[AT]altera.com>
        David Buechi                <bhd[AT]zhwin.ch>
        Bill Florac         <bill.florac[AT]etcconnect.com>
        Alex Burlyga                <Alex.Burlyga[AT]netapp.com>
        Douglas Pratley             <Douglas.pratley[AT]detica.com>
        Giorgio Tino                <giorgio.tino[AT]cacetech.com>
        Davide Schiera              <davide.schiera[AT]riverbed.com>
        Sebastien Tandel    <sebastien[AT]tandel.be>
        Clay Jones          <clay.jones[AT]email.com>
        Kriang Lerdsuwanakij        <lerdsuwa[AT]users.sourceforge.net>
        Abhik Sarkar                <sarkar.abhik[AT]gmail.com>
        Robin Seggelmann    <seggelmann[AT]fh-muenster.de>
        Chris Bontje                <cbontje[AT]gmail.com>
        Ryan Wamsley                <wamslers[AT]sbcglobal.net>
        Dave Butt           <davidbutt[AT]mxtelecom.com>
        Julian Cable                <julian_cable[AT]yahoo.com>
        Joost Yervante Damad        <joost[AT]teluna.org>
        Martin Sustrik              <sustrik[AT]imatix.com>
        Jon Smirl           <jonsmirl[AT]gmail.com>
        David Kennedy               <sgsguy[AT]gmail.com>
        Matthijs Mekking    <matthijs[AT]mlnetlabs.nl>
        Dustin Johnson              <dustin[AT]dustinj.us>
        Victor Fajardo              <vfajardo[AT]tari.toshiba.com>
        Tamas Regos         <tamas.regos[AT]ericsson.com>
        Moshe van der Sterre        <moshevds[AT]gmail.com>
        Rob Casey           <rcasey[AT]gmail.com>
        Ted Percival                <ted[AT]midg3t.net>
        Marc Petit-Huguenin <marc[AT]petit-huguenin.org>
        Florent Drouin              <florent.drouin[AT]alcatel-lucent.fr>
        Karen Feng          <kfeng[AT]fas.harvard.edu>
        Stephen Croll               <croll[AT]mobilemetrics.net>
        Jens Brauer         <jensb[AT]cs.tu-berlin.de>
        Sake Blok           <sake[AT]euronet.nl>
        Fulko Hew           <fulko.hew[AT]gmail.com>
        Yukiyo Akisada              <Yukiyo.Akisada[AT]jp.yokogawa.com>
        Andy Chu            <chu.dev[AT]gmail.com>
        Shane Kearns                <shane.kearns[AT]symbian.com>
        Loris Degioanni             <loris.degioanni[AT]riverbed.com>
        Sven Meier          <msv[AT]zhwin.ch>
        Holger Pfrommer             <hpfrommer[AT]hilscher.com>
        Hariharan Ananthakrishnan <hariharan.a[AT]gmail.com>
        Hannes Kalber               <hannes.kaelber--wireshark[AT]x2e.de>
        Stephen Donnelly    <stephen[AT]endace.com>
        Philip Frey         <frey.philip[AT]gmail.com>
        Yves Geissbuehler   <yves.geissbuehler[AT]gmail.com>
        Shigeo Nakamura             <naka_shigeo[AT]yahoo.co.jp>
        Sven Eckelmann              <sven[AT]narfation.org>
        Edward J. Paradise  <pdice[AT]cisco.com>
        Brian Stormont              <nospam[AT]stormyprods.com>
        Vincent Helfre              <vincent.helfre[AT]ericsson.com>
        Brooss                      <brooss.teambb[AT]gmail.com>
        Joan Ramio          <joan[AT]ramio.cat>
        David Castleford    <david.castleford[AT]orange-ftgroup.com>
        Peter Harris                <pharris[AT]opentext.com>
        Martin Lutz         <MartinL[AT]copadata.at>
        Johnny Mitrevski    <mitrevj[AT]hotmail.com>
        Neil Horman         <nhorman[AT]tuxdriver.com>
        Andreas Schuler             <krater[AT]badterrorist.com>
        Matthias Wenzel             <dect[AT]mazzoo.de>
        Christian Durrer    <christian.durrer[AT]sensemail.ch>
        Naoyoshi Ueda               <piyomaru3141[AT]gmail.com>
        Javier Cardona              <javier[AT]cozybit.com>
        Jens Steinhauser    <jens.steinhauser[AT]omicron.at>
        Julien Kerihuel             <j.kerihuel[AT]openchange.org>
        Vincenzo Condoleo   <vcondole[AT]hsr.ch>
        Mohammad Ebrahim Mohammadi Panah <mebrahim[AT]gmail.com>
        Greg Schwendimann   <gregs[AT]iol.unh.edu>
        Nick Lewis          <nick.lewis[AT]atltelecom.com>
        Fred Fierling               <fff[AT]exegin.com>
        Samu Varjonen               <samu.varjonen[AT]hiit.fi>
        Alexis La Goutte    <alexis.lagoutte[AT]gmail.com>
        Varun Notibala              <nbvarun[AT]gmail.com>
        Nathan Hartwell             <nhartwell[AT]gmail.com>
        Don Chirieleison    <donc[AT]mitre.org>
        Harald Welte                <laforge[AT]gnumonks.org>
        Chris Costa         <chcosta75[AT]hotmail.com>
        Bruno Premont               <bonbons[AT]linux-vserver.org>
        Florian Forster             <octo[AT]verplant.org>
        Ivan Sy Jr.         <ivan_jr[AT]yahoo.com>
        Matthieu Patou              <mat[AT]matws.net>
        Kovarththanan Rajaratnam <kovarththanan.rajaratnam[AT]gmail.com>
        Matt Watchinski             <mwatchinski[AT]sourcefire.com>
        Ravi Kondamuru              <Ravi.Kondamuru[AT]citrix.com>
        Jan Gerbecks                <jan.gerbecks[AT]stud.uni-due.de>
        Vladimir Smrekar    <vladimir.smrekar[AT]gmail.com>
        Tobias Erichsen     <t.erichsen[AT]gmx.de>
        Erwin van Eijk              <erwin.vaneijk[AT]gmail.com>
        Venkateshwaran Dorai        <venkateshwaran.d[AT]gmail.com>
        Ben Greear          <greearb[AT]candelatech.com>
        Richard Kummel              <r.kuemmel[AT]beckhoff.de>
        Yi Yu                       <yiyu.inbox[AT]gmail.com>
        Aniruddha A         <aniruddha.a[AT]gmail.com>
        David Aggeler               <david_aggeler[AT]hispeed.ch>
        Jens Kilian         <jjk[AT]acm.org>
        David Bond          <mokon[AT]mokon.net>
        Paul J. Metzger             <pjm[AT]ll.mit.edu>
        Robert Hogan                <robert[AT]roberthogan.net>
        Torrey Atcitty              <torrey.atcitty[AT]harman.com>
        Dave Olsen          <dave.olsen[AT]harman.com>
        Craig Gunther               <craig.gunther[AT]harman.com>
        Levi Pearson                <levi.pearson[AT]harman.com>
        Allan M. Madsen             <allan.m[AT]madsen.dk>
        Slava                       <slavak[AT]gmail.com>
        H.sivank            <hsivank[AT]gmail.com>
        Edgar Gladkich              <edgar.gladkich[AT]inacon.de>
        Michael Bernhard    <michael.bernhard[AT]bfh.ch>
        Holger Hans Peter Freyther <zecke[AT]selfish.org>
        Jose Pico           <jose[AT]taddong.com>
        David Perez         <david[AT]taddong.com>
        Hakon Nessjo*/en              <haakon.nessjoen[AT]gmail.com>
        Herbert Lischka             <herbert[AT]lischka-berlin.de>
        Felix Kramer                <sauter-cumulus[AT]de.sauter-bc.com>
        Tom Hughes          <tom[AT]compton.nu>
        Owen Kirby          <osk[AT]exegin.com>
        Colin OFlynn               <coflynn[AT]newae.com>
        Juha Siltanen               <juha.siltanen[AT]nsn.com>
        Cal Turney          <cturney[AT]charter.net>
        Lukasz Kotasa               <lukasz.kotasa[AT]tieto.com>
        Jason Masker                <jason[AT]masker.net>
        Giuliano Fabris             <giuliano.fabris[AT]appeartv.com>
        Alexander Koeppe    <format_c[AT]online.de>
        Holger Grandy               <Holger.Grandy[AT]bmw-carit.de>
        Hadriel Kaplan              <hadrielk[AT]yahoo.com>
        Srinivasa Pradeep   <sippyemail-wireshark[AT]yahoo.com>
        Lori Tribble                <ljtconsulting[AT]gmail.com>
        Thomas Boehne               <TBoehne[AT]ADwin.de>
        Gerhard Gappmeier   <gerhard.gappmeier[AT]ascolab.com>
        Hannes Mezger               <hannes.mezger[AT]ascolab.com>
        David Katz          <dkatz[AT]airspan.com>
        Toralf Forster              <toralf.foerster[AT]gmx.de>
        Stephane Bryant             <stephane[AT]glycon.org>
        Emil Wojak          <emil[AT]wojak.eu>
        Steve Huston                <shuston[AT]riverace.com>
        Lorand Jakab                <ljakab[AT]ac.upc.edu>
        Grzegorz Szczytowski        <Grzegorz.Szczytowski[AT]gmail.com>
        Martin Kaiser               <wireshark[AT]kaiser.cx>
        Jakub Zawadzki              <darkjames-ws[AT]darkjames.pl>
        Roland Knall                <roland.knall[AT]br-automation.com>
        Xiao Xiangquan              <xiaoxiangquan[AT]gmail.com>
        Hans-Christoph Schemmel     <hans-christoph.schemmel[AT]cinterion.com>
        Tyson Key           <tyson.key[AT]gmail.com>
        Johannes Jochen             <johannes.jochen[AT]belden.com>
        Florian Fainelli    <florian[AT]openwrt.org>
        Daniel Willmann             <daniel[AT]totalueberwachung.de>
        Brian Cavagnolo             <brian[AT]cozybit.com>
        Allison                     <aobourn[AT]isilon.com>
        Edwin Groothuis             <wireshark[AT]mavetju.org>
        Andrew Kampjes              <andrew.kampjes[AT]endace.com>
        Kurnia Hendrawan    <kurnia.hendrawan[AT]consistec.de>
        Leonard Tracy               <letracy[AT]cisco.com>
        Elliott Aldrich             <elliott[AT]aldrichart.com>
        Glenn Matthews              <glenn.matthews[AT]cisco.com>
        Donnie Savage               <dsavage[AT]cisco.com>
        Spenser Sheng               <spenser.sheng[AT]ericsson.com>
        Benjamin Stocks             <bmstocks[AT]ra.rockwell.com>
        Florian Reichert    <refl[AT]zhaw.ch>
        Martin Renold               <reld[AT]zhaw.ch>
        Iain Arnell         <iarnell[AT]epo.org>
        Mariusz Okroj               <okrojmariusz[AT]gmail.com>
        Ivan Lawrow         <ivan.lawrow[AT]jennic.com>
        Kari Vatjus-Anttila <kari.vatjus-anttila[AT]cie.fi>
        Shobhank Sharma             <ssharma5[AT]ncsu.edu>
        Salil Kanitkar              <sskanitk[AT]ncsu.edu>
        Michael Sakaluk             <mdsakalu[AT]ncsu.edu>
        Mayuresh Raut               <msraut[AT]ncsu.edu>
        Sheetal Kshirsagar  <sdkshirs[AT]ncsu.edu>
        Andrew Williams             <anwilli5[AT]ncsu.edu>
        Per Liedberg                <per.liedberg[AT]ericsson.com>
        Gaurav Tungatkar    <gauravstt[AT]gmail.com>
        Bill Schiller               <bill.schiller[AT]emerson.com>
        Aditya Ambadkar             <arambadk[AT]ncsu.edu>
        Diana Chris         <dvchris[AT]ncsu.edu>
        Guy Martin          <gmsoft[AT]tuxicoman.be>
        Deepti Ragha                <dlragha[AT]ncsu.edu>
        Niels de Vos                <ndevos[AT]redhat.com>
        Clement Marrast             <clement.marrast[AT]molex.com>
        Jacob Nordgren              <jnordgren[AT]gmail.com>
        Rishie Sharma               <rishie[AT]kth.se>
        Richard Stearn              <richard[AT]rns-stearn.demon.co.uk>
        Tobias Rutz         <tobias.rutz[AT]work-microwave.de>
        MichaX XabXdzki             <michal.labedzki[AT]wireshark.org>
        MichaX Orynicz              <michal.orynicz[AT]tieto.com>
        Wido Kelling                <kellingwido[AT]aol.com>
        Kaushal Shah                <kshah3[AT]ncsu.edu>
        Subramanian Ramachandran <sramach6[AT]ncsu.edu>
        Manuel Hofer                <manuel[AT]mnlhfr.at>
        Gaurav Patwardhan   <gspatwar[AT]ncsu.edu>
        Peter Hatina                <phatina[AT]redhat.com>
        Tomasz MoX          <desowin[AT]gmail.com>
        Uli Heilmeier               <uh[AT]heilmeier.eu>
        Rupesh Patro                <rbpatro[AT]ncsu.edu>
        Vaibhav Katkade             <katkade_v[AT]yahoo.com>
        Allan W. Nielsen    <anielsen[AT]vitesse.com>
        Ishraq Ibne Ashraf  <ishraq[AT]tinkerforge.com>
        Robert Grange               <robionekenobi[AT]bluewin.ch>
        Zoltan Lajos Kis    <zoltan.lajos.kis[AT]ericsson.com>
        Juan Antonio Montesinos <juan.mondl[AT]gmail.com>
        Anish Bhatt         <anish[AT]chelsio.com>
        Dmitry Bazhenov             <dima_b[AT]pigeonpoint.com>
        Masatake Yamato             <yamato[AT]redhat.com>
        John Miner          <wiresharkdissectorcoder[AT]gmail.com>
        XX X (Megumi Takeshita) <megumi[AT]ikeriri.ne.jp>
        Remi Vichery                <remi.vichery[AT]gmail.com>
        Kevin Cox           <kevincox[AT]kevincox.ca>
        David Ameiss                <dameiss[AT]29west.com>
        Sean O. Stalley             <sean.stalley[AT]intel.com>
        Qiaoyin Yang                <qiaoyin.yang[AT]gmail.com>
        Thomas Wiens                <th.wiens[AT]gmx.de>
        Gilles Roudiere             <gilles[AT]roudiere.net>
        Alexander Gaertner  <gaertner.alex[AT]gmx.de>
        Raphael Doursenaud  <rdoursenaud[AT]free.fr>
        Ryan Doyle          <ryan[AT]doylenet.net>
        Jesse Gross         <jesse[AT]nicira.com>
        Joe Fowler          <fowlerja[AT]us.ibm.com>
        Enrico Jorns                <ejo[AT]pengutronix.de>
        Hitesh K Maisheri   <maisheri.hitesh[AT]gmail.com>
        Dario Lombardo              <lomato[AT]gmail.com>
        Pratik Yeole                <pyeole[AT]ncsu.edu>
        Guillaume Autran    <gautran[AT]clearpath.ai>
        Barbu Paul - Gheorghe       <barbu.paul.gheorghe[AT]gmail.com>
        Martin Kacer        <kacer.martin[AT]gmail.com>
        Ben Stewart         <bst[AT]google.com>
        Sumit Kumar Jha             <sjha3[AT]ncsu.edu>
        Kim Kempf           <kim.kempf[AT]apcon.com>
        S. Shapira          <sswsdev[AT]gmail.com>
        Lazar Sumar         <bugzilla[AT]lazar.co.nz>
        Kingson Chan        <k.chan[AT]samsung.com>
        Ege Elgun           <e.elgun[AT]samsung.com>
        Connor Newton   <c.newton[AT]samsung.com>
        Huang Qiangxiong        <qiangxiong.huang[AT]qq.com>
        Jeffrey Nichols             <jsnichols[AT]suprocktech.com>
    .Ve
    
    and by:
    
    .Vb 10
        Georgi Guninski             <guninski[AT]guninski.com>
        Jason Copenhaver    <jcopenha[AT]typedef.org>
        Eric Perie          <eric.perie[AT]colubris.com>
        David Yon           <yon[AT]tacticalsoftware.com>
        Marcio Franco               <franco.marcio[AT]rd.francetelecom.fr>
        Kaloian Stoilov             <kalkata[AT]yahoo.com>
        Steven Lass         <stevenlass[AT]mail.com>
        Gregory Stark               <gsstark[AT]mit.edu>
        Darren Steele               <steeley[AT]steeley.co.uk>
        Michael Kopp                <michael.kopp[AT]isarnet.de>
        Bernd Leibing               <bernd.leibing[AT]kiz.uni-ulm.de>
        Chris Heath         <chris[AT]heathens.co.nz>
        Gisle Vanem         <gvanem[AT]broadpark.no>
        Ritchie                     <ritchie[AT]tipsybottle.com>
        Aki Immonen         <aki.immonen[AT]golftalma.fi>
        David E. Weekly             <david[AT]weekly.org>
        Steve Ford          <sford[AT]geeky-boy.com>
        Masaki Chikama              <masaki-c[AT]is.aist-nara.ac.jp>
        Mohammad Hanif              <mhanif[AT]nexthop.com>
        Reinhard Speyerer   <rspmn[AT]arcor.de>
        Patrick Kursawe             <phosphan[AT]gentoo.org>
        Arsen Chaloyan              <achaloyan[AT]yahoo.com>
        Arnaud Jacques              <webmaster[AT]securiteinfo.com>
        D. Manzella         <manzella[AT]lucent.com>
        Jari Mustajarvi             <jari.mustajarvi[AT]nokia.com>
        Pierre Juhen                <pierre.juhen[AT]wanadoo.fr>
        David Richards              <drichards[AT]alum.mit.edu>
        Shusaku Ueda                <ueda[AT]sra.co.jp>
        Jonathan Perkins    <jonathan.perkins[AT]ipaccess.com>
        Holger Schurig              <h.schurig[AT]mn-logistik.de>
        Peter J. Creath             <peter-ethereal[AT]creath.net>
        Magnus Hansson              <mah[AT]hms.se>
        Pavel Kankovsky             <kan[AT]dcit.cz>
        Nick Black          <dank[AT]reflexsecurity.com>
        Bill Guyton         <guyton[AT]bguyton.com>
        Chernishov Yury             <Chernishov[AT]iskrauraltel.ru>
        Thomas Palmer               <Thomas.Palmer[AT]Gunter.AF.mil>
        Clinton Work                <clinton[AT]scripty.com>
        Joe Marcus Clarke   <marcus[AT]marcuscom.com>
        Kendy Kutzner               <kutzner[AT]tm.uka.de>
        James H. Cloos Jr.  <cloos[AT]jhcloos.com>
        Tim Farley          <tfarley[AT]iss.net>
        Daniel Thompson             <daniel.thompson[AT]st.com>
        Chris Jepeway               <thai-dragon[AT]eleven29.com>
        Matthew Bradley             <matthew.bradley[AT]cnsonline.net>
        Nathan Alger                <nathan[AT]wasted.com>
        Stas Grabois                <sagig[AT]radware.com>
        Ainsley Pereira             <APereira[AT]Witness.com>
        Philippe Mazeau             <philippe.mazeau[AT]swissvoice.net>
        Carles Kishimoto    <ckishimo[AT]ac.upc.es>
        Dennis Lim          <postadal[AT]suse.cz>
        Dennis Lim          <Dennis.Lim[AT]motorola.com>
        Martin van der Werff        <martin[AT]vanderwerff.org>
        Marco van den Bovenkamp     <marco[AT]linuxgoeroe.dhs.org>
        Ming Zhang          <mingz[AT]ele.uri.edu>
        Neil Piercy         <Neil.Piercy[AT]ipaccess.com>
        Remi Denis-Courmont <courmisch[AT]via.ecp.fr>
        Thomas Palmer               <tpalmer[AT]elmore.rr.com>
        Marten Svantesson   <f95-msv[AT]f.kth.se>
        Steve Sommars               (e-mail address removed at contributors request)
        Kestutis Kupciunas  <kesha[AT]soften.ktu.lt>
        Rene Pilz           <rene.pilz[AT]ftw.at>
        Laurent Constantin  <laurent.constantin[AT]aql.fr>
        Martin Pichlmaier   <martin.pichlmaier[AT]siemens.com>
        Mark Phillips               <msp[AT]nortelnetworks.com>
        Nils Ohlmeier               <lists[AT]ohlmeier.org>
        Ignacio Goyret              <igoyret[AT]lucent.com>
        Bart Braem          <bart.braem[AT]gmail.com>
        Shingo Horisawa             <name4n5[AT]hotmail.com>
        Lane Hu                     <lane.hu[AT]utstar.com>
        Marc Poulhie`s               <marc.poulhies[AT]epfl.ch>
        Tomasz Mrugalski    <thomson[AT]klub.com.pl>
        Brett Kuskie                <mstrprgmmr[AT]chek.com>
        Brian Caswell               <bmc[AT]sourcefire.com>
        Yann                        <yann_eads[AT]hotmail.com>
        Julien Leproust             <julien[AT]via.ecp.fr>
        Mutsuya Irie                <irie[AT]sakura-catv.ne.jp>
        Yoshihiro Oyama             <y.oyama[AT]netagent.co.jp>
        Chris Eagle         <cseagle[AT]nps.edu>
        Dominique Bastien   <dbastien[AT]accedian.com>
        Nicolas Dichtel             <nicolas.dichtel[AT]6wind.com>
        Ricardo Muggli              <ricardo.muggli[AT]mnsu.edu>
        Vladimir Kondratiev <vladimir.kondratiev[AT]gmail.com>
        Jaap Keuter         <jaap.keuter[AT]xs4all.nl>
        Frederic Peters             <fpeters[AT]debian.org>
        Anton Ivanov                <anthony_johnson[AT]mail.ru>
        Ilya Konstantinov   <future[AT]shiny.co.il>
        Neil Kettle                 <mu-b[AT]65535.com>
        Steve Karg          <skarg[AT]users.sourceforge.net>
        Javier Acuna                <javier.acuna[AT]sixbell.cl>
        Miklos Szurdi               <szurdimiklos[AT]yahoo.com>
        Cvetan Ivanov               <zezo[AT]spnet.net>
        Vasanth Manickam    <vasanth.manickam[AT]bt.com>
        Julian Onions               <julian.onions[AT]gmail.com>
        Samuel Thibault             <samuel.thibault[AT]ens-lyon.org>
        Peter KovaX         <peter.kovar[AT]gmail.com>
        Paul Ollis          <paul.ollis[AT]roke.co.uk>
        Dominik Kuhlen              <dkuhlen[AT]gmx.net>
        Karl Knoebl         <karl.knoebl[AT]siemens.com>
        Maria-Luiza Crivat  <luizacri[AT]gmail.com>
        Brice Augustin              <bricecotte[AT]gmail.com>
        Matt Thornton               <MATT_THORNTON[AT]appsig.com>
        Timo Metsala                <timo.metsala[AT]gmail.com>
        Tomer Shani         <thetour[AT]japan.com>
        Manu Pathak         <mapathak[AT]cisco.com>
        John Sullivan               <john[AT]kanargh.force9.co.uk>
        Martin Andre                <andre[AT]clarinet.u-strasbg.fr>
        Andrei Emeltchenko  <Andrei.Emeltchenko[AT]nokia.com>
        Kirby Files         <kfiles[AT]masergy.com>
        Ravi Valmikam               <rvalmikam[AT]airvananet.com>
        Diego Petteno`               <flameeyes[AT]gentoo.org>
        Daniel Black                <dragonheart[AT]gentoo.org>
        Christoph Werle             <Christoph.Werle[AT]ira.uka.de>
        Aaron Christensen   <aaronmf[AT]gmail.com>
        Ian Abel            <ianabel[AT]mxtelecom.com>
        Bryant Eastham              <beastham[AT]slc.mew.com>
        Taner Kurtulus              <taner.kurtulus[AT]tubitak.gov.tr>
        Joe Breher          <linux[AT]q-music.com>
        Patrick vd Lageweg  <patrick[AT]bitwizard.nl>
        Thomas Sillaber             <Thomas.Sillaber[AT]gmx.de>
        Mike Davies         <m.davies[AT]btinternet.com>
        Boris Misenov               <Boris.Misenov[AT]oktelabs.ru>
        Joe McEachern               <joe[AT]qacafe.com>
        Charles Lepple              <clepple[AT]gmail.com>
        Tuomas Maattanen    <maattanen[AT]iki.fi>
        Joe Eykholt         <joe[AT]nuovasystems.com>
        Ian Brumby          <ian.brumby[AT]baesystems.com>
        Todd J Martin               <todd.martin[AT]acm.org>
        Scott Robinson              <scott.robinson[AT]flukenetworks.com>
        Martin Peylo                <wireshark[AT]izac.de>
        Stephane Loeuillet  <leroutier[AT]gmail.com>
        Andrei Rubaniuk             <rubaniuk[AT]mail.ru>
        Mikael Magnusson    <mikma264[AT]gmail.com>
        Timo Teras          <timo.teras[AT]iki.fi>
        Marton Ne*'meth               <nm127[AT]freemail.hu>
        Kai Blin            <kai[AT]samba.org>
        Olivier Montanuy    <olivier.montanuy[AT]orange-ftgroup.com>
        Thomas Morin                <thomas.morin[AT]orange-ftgroup.com>
        Jesus Roman         <jroman[AT]teldat.com>
        Giodi Giorgi                <g.giorgi[AT]gmail.com>
        Peter Hertting              <Peter.Hertting[AT]gmx.net>
        Jess Balint         <jbalint[AT]gmail.com>
        Bahaa Naamneh               <b.naamneh[AT]gmail.com>
        Magnus Sorman               <magnus.sorman[AT]ericsson.com>
        Pascal Quantin              <pascal.quantin[AT]gmail.com>
        Roy Marples         <roy[AT]marples.name>
        Ward van Wanrooij   <ward[AT]ward.nu>
        Federico Mena Quintero      <federico[AT]novell.com>
        Andreas Heise               <andreas.heise[AT]nextiraone.de>
        Alex Lindberg               <alindber[AT]yahoo.com>
        Rama Chitta         <rama[AT]gear6.com>
        Roberto Mariani             <jelot-wireshark[AT]jelot.it>
        Sandhya Gopinath    <Sandhya.Gopinath[AT]citrix.com>
        Raghav SN           <Raghav.SN[AT]citrix.com>
        Murali Raja         <Murali.Raja[AT]citrix.com>
        Devesh Prakash              <Devesh.Prakash[AT]citrix.com>
        Darryl Champagne    <dchampagne[AT]sta.samsung.com>
        Michael Speck               <Michael.Speck[AT]avl.com>
        Gerasimos Dimitriadis       <dimeg[AT]intracom.gr>
        Robert Simac                <rsimac[AT]cronsult.com>
        Johanna Sochos              <johanna.sochos[AT]swissqual.com>
        Felix Obenhuber             <felix[AT]obenhuber.de>
        Hilko Bengen                <bengen--wireshark[AT]hilluzination.de>
        Hadar Shoham                <hadar.shoham[AT]gmail.com>
        Robert Bullen               <robert[AT]robertbullen.com>
        Chuck Kristofek             <chuck.kristofek[AT]ngc.com>
        Markus Renz         <Markus.Renz[AT]hirschmann.de>
        Toshihiro Kataoka   <kataoka.toshihiro[AT]gmail.com>
        Petr Lautrbach              <plautrba[AT]redhat.com>
        Frank Lahm          <franklahm[AT]googlemail.com>
        Jon Ellch           <jellch[AT]harris.com>
        Alex Badea          <vamposdecampos[AT]gmail.com>
        Dirk Jagdmann               <doj[AT]cubic.org>
        RSA                         <ryazanov.s.a[AT]gmail.com>
        Juliusz Chroboczek  <jch[AT]pps.jussieu.fr>
        Vladimir Kazansky   <vovjo[AT]yandex.ru>
        Peter Paluch                <peter.paluch[AT]fri.uniza.sk>
        Tom Brezinski               <tombr[AT]netinst.com>
        Nick Glass          <nick.glass[AT]lycos.com>
        Michael Mann                <mmann78[AT]netscape.net>
        Romain Fliedel              <romain.fliedel+wireshark[AT]gmail.com>
        Michael Chen                <michaelc[AT]idssoftware.com>
        Paul Stath          <pstath[AT]axxcelera.com>
        DeCount                     <aatrade[AT]libero.it>
        Andras Veres-Szentkiralyi <vsza[AT]vsza.hu>
        Jakob Hirsch                <jh.wireshark-bugzilla[AT]plonk.de>
        XXXXX XXXXXXXX              <dpb[AT]corrigendum.ru>
        XXXXX XXXXXXXX              <billyjeans[AT]gmail.com>
        Evan Huus           <eapache[AT]gmail.com>
        Tom Cook            <tcook[AT]ixiacom.com>
        Tom Alexander               <talexander[AT]ixiacom.com>
        Klaus Heckelmann    <klaus.heckelmann[AT]nashtech.com>
        Ben Bowen           <bbowen[AT]godaddy.com>
        Bodo Petermann              <bp245[AT]hotmail.com>
        Martin Kupec                <martin.kupec[AT]kupson.cz>
        Litao Gao           <ltgao[AT]juniper.net>
        Niels Widger                <niels[AT]qacafe.com>
        Pontus Fuchs                <pontus.fuchs[AT]gmail.com>
        Bill Parker         <wp02855[AT]gmail.com>
        Tomofumi Hayashi    <s1061123[AT]gmail.com>
        Tim Hentenaar               <tim.hentenaar[AT]gmail.com>
        Krishnamurthy Mayya <krishnamurthymayya[AT]gmail.com>
        Nikitha Malgi               <nikitha01[AT]gmail.com>
        Adam Butcher                <adam[AT]jessamine.co.uk>
        Hendrik Uhlmann             <Hendrik.Uhlmann[AT]rheinmetall.com>
        Sebastiano Di Paola <sebastiano.dipaola[AT]gmail.com>
        Steven J. Magnani   <steve[AT]digidescorp.com>
        David Arnold                <davida[AT]pobox.com>
        Alexander Chemeris  <alexander.chemeris[AT]gmail.com>
        Ivan Klyuchnikov    <kluchnikovi[AT]gmail.com>
        Max Baker           <max[AT]warped.org>
        Diederik de Groot   <dkgroot[AT]talon.nl>
        Hauke Mehrtens              <hauke[AT]hauke-m.de>
        0xBismarck          <0xbismarck[AT]gmail.com>
        Peter Van Eynde             <pevaneyn[AT]cisco.com>
        Marko Hrastovec             <marko.hrastovec[AT]sloveniacontrol.si>
        Mike Garratt                <mg.wireshark[AT]evn.co.nz>
        Fabio Tarabelloni   <fabio.tarabelloni[AT]reloc.it>
        Chas Williams               <chas[AT]cmf.nrl.navy.mil>
        Javier Godoy                <uce[AT]rjgodoy.com.ar>
        Matt Texier         <matthieu[AT]texier.tv>
        Linas Vepstas               <linasvepstas[AT]gmail.com>
        Simon Zhong         <szhong[AT]juniper.net>
        Bart Van Assche             <bvanassche[AT]acm.org>
        Peter Lemenkov              <lemenkov[AT]gmail.com>
        Karl Beldan         <karl.beldan[AT]gmail.com>
        Jiri Engelthaler    <engycz[AT]gmail.com>
        Stephen Ludin               <sludin[AT]ludin.org>
        Andreas Urke                <andurke[AT]gmail.com>
        Patrik Lundquist    <patrik.lundquist[AT]gmail.com>
        Mark Vitale         <mvitale[AT]sinenomine.net>
        Peter Wu            <peter[AT]lekensteyn.nl>
        Jerry Negele                <jerry.negele[AT]arrisi.com>
        Hannes Hofer                <hhofer[AT]barracuda.com>
        Luca Coelho         <luca[AT]coelho.fi>
        Masayuki Takemura   <masayuki.takemura[AT]gmail.com>
        Ed Beroset          <beroset[AT]mindspring.com>
        e.yimjia            <jy.m12.0[AT]gmail.com>
        Jonathon Jongsma    <jjongsma[AT]redhat.com>
        Zeljko Ancimer              <zancimer[AT]gmail.com>
        Deon van der Westhuysen     <deonvdw[AT]gmail.com>
        Ibrahim Can Yuce    <canyuce[AT]gmail.com>
        Robert Jongbloed    <robertj[AT]voxlucida.com.au>
        Pavel Moravec               <pmoravec[AT]redhat.com>
        Robert Long         <rlong[AT]sandia.gov>
        James Lynch         <lynch007[AT]gmail.com>
        Chidambaram Arunachalam     <carunach[AT]cisco.com>
        Joao Valverde               <j[AT]v6e.pt>
        Benoit Canet                <benoit[AT]scylladb.com>
        Hakon O*/ye Amundsen      <haakon.amundsen[AT]nordicsemi.no>
        Jeffrey Wildman             <jeffrey.wildman[AT]ll.mit.edu>
    .Ve
    .SS "From git log"
    .IX Subsection "From git log"
    .Vb 10
        Achuthan Paramanathan       <acp[AT]kamstrup.com>
        Adam Goldman                <adam.goldman[AT]intel.com>
        Adam Mitz           <mitza[AT]objectcomputing.com>
        Adam Mitz           <mitza[AT]ociweb.com>
        Adam Morrison               <adammo[AT]extrahop.com>
        Adam Pridgen                <adam.pridgen[AT]thecoverofnight.com>
        Adam Schwalm                <adam.schwalm[AT]dynetics.com>
        Adam Wujek          <adam.wujek[AT]cern.ch>
        Aditya Jain         <aditya.jain[AT]samsung.com>
        Adrian Granados             <adrian[AT]adriangranados.com>
        Adrian Simionov             <daniel.simionov[AT]gmail.com>
        Adrian-Ken Rueegsegger      <ken[AT]codelabs.ch>
        Adrien Aubry                <adraub[AT]gmail.com>
        Adrien Destugues    <adestugues[AT]toulouse.viveris.com>
        Adrien Destugues    <adrien.destugues[AT]opensource.viveris.fr>
        Ahmad Fatoum                <ahmad[AT]a3f.at>
        Ajay Panicker               <apanicke[AT]google.com>
        Alan Birtles                <alan.birtles[AT]eu.sony.com>
        Alan Partis         <alpartis[AT]thundernet.com>
        Aleksej Matis               <amat[AT]magure.de>
        Alex Badea          <abadea[AT]ixiacom.com>
        Alex Nik            <rage.iz.me[AT]gmail.com>
        Alex Sirr           <alexsirruw[AT]gmail.com>
        Alex Tessmer                <dev[AT]tessmer.me>
        AlexL                       <loginov.alex.valer[AT]gmail.com>
        Alexander Couzens   <lynxis[AT]fe80.eu>
        Alexander Dahl              <ada[AT]thorsis.com>
        Alexander Gryanko   <xpahos[AT]gmail.com>
        Alexander Gartner   <sphinxs1988[AT]googlemail.com>
        Alexander Meier             <MeierAPunkt[AT]googlemail.com>
        Alexander Nogikh    <wp32pw[AT]gmail.com>
        Alexander Stein             <alexanders83[AT]web.de>
        Alexander Wetzel    <alexander.wetzel[AT]web.de>
        Alexandr Savca              <alexandr.savca89[AT]gmail.com>
        Alexis Green                <alexis.green[AT]nokia.com>
        Alfred Koebler              <alfred.koebler[AT]gmx.de>
        Ali Sabil           <ali.sabil[AT]koperadev.com>
        Alistair Leslie-Hughes      <leslie_alistair[AT]hotmail.com>
        Allan Moller Madsen <almomadk[AT]gmail.com>
        Ambarish Malpani    <ambarish[AT]defend7.com>
        Ameya Deshpande             <ameya.181co205[AT]nitk.edu.in>
        Ameya Deshpande             <ameyanrd[AT]gmail.com>
        Ameya Deshpande             <ameyanrd[AT]outlook.com>
        Amine Kherbouche    <amine.kherbouche[AT]6wind.com>
        Amit Khatri         <amit7861234[AT]gmail.com>
        Amitoj Setia                <asetia[AT]juniper.net>
        Ana Pantar          <ana.pantar[AT]gmail.com>
        Anael Fiaux         <anael[AT]fiaux.org>
        Anders Esbensen             <Anders.Esbensen[AT]silabs.com>
        Andre Luyer         <andre[AT]luyer.nl>
        Andre Puschmann             <andre[AT]softwareradiosystems.com>
        Andreas Gruenbacher <andreas.gruenbacher[AT]gmail.com>
        Andreas Karlsson    <se.nakarlsson[AT]gmail.com>
        Andreas Leibold             <andreas.leibold[AT]harman.com>
        Andreas Schultz             <andreas.schultz[AT]travelping.com>
        Andreas Stieger             <andreas.stieger[AT]gmx.de>
        Andreas Urke                <arurke[AT]netwurke.com>
        Andrei Cipu         <acipu[AT]ixiacom.com>
        Andrew Chernyh              <andrew.chernyh[AT]gmail.com>
        Andrew Hoag         <Andrew.Hoag[AT]aireon.com>
        Andrey Kulikov              <amdei[AT]cryptopro.ru>
        Andrey Tverd                <andr.tverd[AT]gmail.com>
        Andrii Vladyka              <a.vladyka[AT]ukr.net>
        Andy Ling           <Andy.Ling[AT]quantel.com>
        Andy Ling           <andy.ling[AT]s-a-m.com>
        Andy Zhao           <jinhzhx[AT]gmail.com>
        Angelos Drossos             <wireshark.develangel[AT]mail.drossos.de>
        Anil Kumar          <anilkumar911[AT]gmail.com>
        Anndy Ke            <anndymaktub[AT]yahoo.com.tw>
        Anthony Coddington  <anthony.coddington[AT]endace.com>
        Anthony Crawford    <anthony.r.crawford[AT]charter.com>
        Anton Butenko               <ant.butenko[AT]gmail.com>
        Anton Glukhov               <anton.a.glukhov[AT]gmail.com>
        Anton Kharchenko    <astotal[AT]gmail.com>
        Anton Thomasson             <anton.thomasson[AT]ericsson.com>
        Antony Bridle               <ant.bridle[AT]gmail.com>
        Apeksha Singhal             <apeksha.singhal[AT]gmail.com>
        Arjen Zonneveld             <arjen[AT]bz2.nl>
        Arnd Hannemann              <arnd[AT]arndnet.de>
        Artem Mygaiev               <joculator[AT]gmail.com>
        Artur Nowosielski   <artnowo[AT]gmail.com>
        Arvind Dalvi                <ardalvi[AT]outlook.in>
        Asaf Kave           <kaveasaf[AT]gmail.com>
        Ashish Shukla               <shukla.a[AT]gmail.com>
        Atli Gumundsson    <atli[AT]tern.is>
        Audric Schiltknecht <audric.schiltknecht[AT]external.thalesaleniaspace.com>
        Aurelien Aptel              <aaptel[AT]suse.com>
        Aymeric Moizard             <amoizard[AT]gmail.com>
        Babak Farrokhi              <babak[AT]farrokhi.net>
        Balint Reczey               <rbalint[AT]ubuntu.com>
        Bartolo Otrit               <bartolootrit[AT]gmail.com>
        Baruch Siach                <baruch[AT]tkos.co.il>
        Basil                       <addremover[AT]gmail.com>
        Bastien Bailly              <babassbailly[AT]free.fr>
        BaXak Kalfa         <basakkalfa[AT]gmail.com>
        Ben Bass            <ben.bass[AT]metaswitch.com>
        Ben Burwell         <bburwell[AT]lutron.com>
        Ben Fox-Moore               <ben.foxmoore[AT]accelleran.com>
        Ben Huddleston              <ben.huddleston[AT]couchbase.com>
        Benjamin Aschenbrenner      <benjamin.aschenbrenner[AT]gmail.com>
        Benjamin Coddington <bcodding[AT]redhat.com>
        Benjamin Hesmans    <benjamin.hesmans[AT]uclouvain.be>
        Benjamin Parzella   <bparzella[AT]gmail.com>
        Benjamin Roch               <benjamin.roch[AT]tttech.com>
        Benoit Grange               <benoit.grange[AT]gmail.com>
        Bert van Leeuwen    <bert.vanleeuwen[AT]gmail.com>
        Bertrand Bonnefoy-Claudet <bertrandbc[AT]gmail.com>
        Bharath Ravindranath        <bravindranath[AT]arista.com>
        Binh Trinh          <beango[AT]gmail.com>
        Birol Capa          <birol.capa[AT]siemens.com>
        Bjoern Riemer               <bjoern.riemer[AT]fokus.fraunhofer.de>
        Bjorn Ruytenberg    <bjorn[AT]bjornweb.nl>
        Bob Hinden          <bob.hinden[AT]gmail.com>
        Bob Kuo                     <bobjkuo[AT]gmail.com>
        Boris Bochkarev             <Boris-Bochkaryov[AT]yandex.ru>
        Bradford Boyle              <bradford.d.boyle[AT]gmail.com>
        Brandon Enochs              <enochs.brandon[AT]gmail.com>
        Branislav Makan             <branislav.makan1994[AT]gmail.com>
        Brendan OConnor    <brendan[AT]leviathansecurity.com>
        Brenton Rothchild   <brentonr[AT]dorm.org>
        Brian Whitney               <brian.m.whitney[AT]outlook.com>
        Britt McKinley              <bmckinley[AT]sonusnet.com>
        Bruno Verstuyft             <bruno.verstuyft[AT]excentis.com>
        Camille Guerin              <guerincamille56[AT]gmail.com>
        Carlo Carraro               <colrack[AT]gmail.com>
        Carlos Velasco              <carlos.velasco[AT]nimastelecom.com>
        Cathy Yang          <cathy.y.yang[AT]ericsson.com>
        Cedric Izoard               <cedric.izoard[AT]ceva-dsp.com>
        Cenk GundoXan               <cnkgndgn[AT]gmail.com>
        Cenk GundoXan               <mail+dev[AT]gundogan.net>
        Chaitanya T K               <chaitanya.mgit[AT]gmail.com>
        Chaoyong Zhou               <bgnvendor[AT]163.com>
        Charles Nepveu              <charles.nepveu[AT]verint.com>
        Charlie Lenahan             <clenahan[AT]sonicbison.com>
        Chema Gonzalez              <chemag[AT]gmail.com>
        Chris Brandson              <chris.brandson[AT]gmail.com>
        Chris Dunlop                <chris.dunlop3[AT]gmail.com>
        Chris Wills         <xenkrs[AT]outlook.com>
        Christian Ambach    <ambi[AT]samba.org>
        Christian Kreibich  <christian[AT]corelight.com>
        Christian Krump             <christian.krump[AT]br-automation.com>
        Christian Lamparter <chunkeey[AT]googlemail.com>
        Christian M. Amsuss <chrysn[AT]fsfe.org>
        Christian Reusch    <creusch[AT]crnetpackets.com>
        Christian Tellefsen <chris-git[AT]tellefsen.net>
        Christian Ullrich   <chris[AT]chrullrich.net>
        Christoph Burger-Scheidlin <mail[AT]christoph.burger-scheidlin.name>
        Christoph Jahnigen  <nuabaranda[AT]web.de>
        Christoph Portner   <christoph.portner[AT]gmail.com>
        Christoph Schlosser <christoph[AT]schlosser.xyz>
        Christoph Wurm              <wurm[AT]elastic.co>
        Christophe GUERBER  <christophe.guerber[AT]gmail.com>
        Christopher Farman  <christopher.farman[AT]couchbase.com>
        Christopher Kilgour <techie[AT]whiterocker.com>
        Chuan He            <bupthc[AT]gmail.com>
        Chuck Craft         <bubbasnmp[AT]gmail.com>
        Chuck Lever         <chuck.lever[AT]oracle.com>
        Chugzilla           <chugzilla77[AT]gmail.com>
        Chun-Yeow Yeoh              <yeohchunyeow[AT]gmail.com>
        Claudius Zingerli   <czingerl[AT]gmail.com>
        Clement Notin               <clement.notin[AT]gmail.com>
        Cody Doucette               <doucette[AT]bu.edu>
        Colin Foster                <colin.foster[AT]in-advantage.com>
        Colin Sames         <sames.colin[AT]gmail.com>
        Constantine Gavrilov        <constg[AT]il.ibm.com>
        Craig Jackson               <cejackson51[AT]gmail.com>
        Cedric Delmas               <cedricde[AT]outlook.fr>
        D. W. Poon          <dwpoon[AT]mail.ubc.ca>
        Daan De Meyer               <daan.j.demeyer[AT]gmail.com>
        Damir Franusic              <damir.franusic[AT]gmail.com>
        Dan Robertson               <danlrobertson89[AT]gmail.com>
        Dana Sy                     <dana.hayden.sy[AT]gmail.com>
        Daniel Hirschberger <daniel.hirschberger+wireshark[AT]rub.de>
        Daniel Kamil Kozar  <dkk089[AT]gmail.com>
        Daniel Mack         <daniel[AT]zonque.org>
        Daniel McLean               <maczor[AT]gmail.com>
        Daniel Mouscher             <dmouscher[AT]gmail.com>
        Daniel Stenberg             <daniel[AT]haxx.se>
        Daniel Tan          <BACdaBASpert[AT]optigo.net>
        Daniel Willmann             <dwillmann[AT]sysmocom.de>
        Daniele Lacamera    <daniele.lacamera[AT]technicolor.com>
        Daniel van Eeden    <wireshark[AT]myname.nl>
        Darien Spencer              <cusneud[AT]mail.com>
        Darius Davis                <darius[AT]vmware.com>
        Darshan Nevgi               <darshan.sn[AT]samsung.com>
        Dave Barach         <dave[AT]barachs.net>
        Dave Goodell                <dave[AT]goodell.io>
        Dave Pifke          <dave[AT]pifke.org>
        Dave Rigby          <daver[AT]couchbase.com>
        Dave Tapuska                <dtapuska[AT]google.com>
        David Aggeler               <david_aggeler[AT]yahoo.com>
        David Ameiss                <david[AT]ameissnet.com>
        David Arnold                <d[AT]0x1.org>
        David Barrera               <davidbb[AT]gmail.com>
        David Bastiani              <daveb64[AT]yahoo.com>
        David Creswick              <dcrewi[AT]gyrae.net>
        David Kreitschmann  <dkreitschmann[AT]seemoo.tu-darmstadt.de>
        David McKay         <mckay.david[AT]gmail.com>
        David Morsberger    <dave[AT]morsberger.com>
        David Perry         <boolean263[AT]protonmail.com>
        David Perry         <d.perry[AT]utoronto.ca>
        David Snowdon               <daves[AT]metamako.com>
        David Tapuska               <dave[AT]tapuska.com>
        David Zoller                <zollerd[AT]gmail.com>
        Davide Caratti              <davide.caratti[AT]gmail.com>
        Deep Datta          <ddatta[AT]ixiacom.com>
        Deep Datta          <deep.datta[AT]keysight.com>
        Denis Janssen               <janssend[AT]gmail.com>
        Dennis Bush         <bush[AT]tcnj.edu>
        Dennis Lanov                <dennis.lanov[AT]gmail.com>
        Derick Rethans              <github[AT]derickrethans.nl>
        Devan Lai           <devanl[AT]davisinstruments.com>
        Devin Heitmueller   <dheitmueller[AT]kernellabs.com>
        Dhananjay Patki             <dhpatki[AT]cisco.com>
        Dhiru Kholia                <kholia[AT]kth.se>
        DiablosOffens               <DiablosOffens[AT]gmx.de>
        Didier Arenzana             <darenzana[AT]yahoo.fr>
        Didier Barvaux              <didier.barvaux[AT]toulouse.viveris.com>
        Diederik de Groot   <ddegroot[AT]talon.nl>
        Dieter Dobbelaere   <dieter.dobbelaere[AT]excentis.com>
        Dirk Eibach         <dirk.eibach[AT]gdsys.cc>
        Dirk Rommen         <dirk.roemmen[AT]cslab.de>
        Dirk Weise          <code[AT]dirk-weise.de>
        Disha Daniel                <ddaniel[AT]empirix.com>
        Dmitriy Eliseev             <eliseev_d[AT]ntcees.ru>
        Dmitry Bravikov             <dmitry[AT]bravikov.pro>
        Dmitry Lazurkin             <dilaz03[AT]gmail.com>
        Dmitry Linikov              <linikov[AT]arrival.com>
        Dmitry Radivonchik  <mitya[AT]oktetlabs.ru>
        Dom Gifford         <Dominic.Gifford[AT]atmel.com>
        Dominic Chen                <d.c.ddcc[AT]gmail.com>
        Dongle Su           <agdsdl[AT]sina.com.cn>
        Doug Brown          <doug[AT]downtowndougbrown.com>
        Dr. Lars Voelker    <lars-github[AT]larsvoelker.de>
        Dr. Lars Volker             <lars.voelker[AT]bmw.de>
        Dr. Lars Volker             <lars.voelker[AT]technica-engineering.de>
        Dwayne Rich         <dwayne_rich[AT]selinc.com>
        Dylan Ulis          <daulis0[AT]gmail.com>
        Daniel Bakai                <bakaidl[AT]gmail.com>
        Ebben Aries         <exa[AT]fb.com>
        Ed Beroset          <beroset[AT]ieee.org>
        Ederson de Souza    <ederson.desouza[AT]intel.com>
        Edward Dao          <edmailbox[AT]gmail.com>
        Edward Smith                <edward.smith[AT]nowlegent.com>
        Edwin Groothuis             <edwin[AT]mavetju.org>
        Eelco Chaudron              <echaudro[AT]redhat.com>
        Eldon Stegall               <wireshark-gerrit[AT]eldondev.com>
        Eliot Lear          <lear[AT]cisco.com>
        Emery Hemingway             <emery[AT]vfemail.net>
        Emmanuel Grumbach   <emmanuel.grumbach[AT]intel.com>
        Enrique Giraldo             <enrique.giraldo[AT]wslw.es>
        Eric Anderson               <andersoe[AT]cs.cmu.edu>
        Eric Wang           <terminal_0[AT]aol.com>
        Eric Wetzel         <thewetzel[AT]gmail.com>
        Eric Wild           <ewild[AT]sysmocom.de>
        Erik de Jong                <erikdejong[AT]gmail.com>
        Erika Szelleova             <szelleerika[AT]gmail.com>
        Ethan Everett               <ethan.everett[AT]meraki.net>
        Ethan Young         <imfargo[AT]gmail.com>
        Etienne Dechamps    <etienne[AT]edechamps.fr>
        Etienne MARAIS              <etienne[AT]marais.green>
        Etienne Millon              <etienne[AT]cryptosense.com>
        Eugene Adell                <eugene.adell[AT]gmail.com>
        Eugene Exarevsky    <eugene.exarevsky[AT]dsr-company.com>
        Eugene Sukhodolin   <eugene[AT]sukhodolin.com>
        Evan Welsh          <noreply[AT]evanwelsh.com>
        Evelio Vila         <eveliovila[AT]gmail.com>
        Fabian Raetz                <fabian.raetz[AT]gmail.com>
        Fabrice Fontaine    <fontaine.fabrice[AT]gmail.com>
        Fabrizio Demaria    <fabrizio.demaria[AT]intel.com>
        Felix Ruess         <felix.ruess[AT]roboception.de>
        Filip Sohajek               <filip.sohajek[AT]gmail.com>
        Filipe Lains                <lains[AT]archlinux.org>
        Flavio Santes               <flavio.santes[AT]1byt3.com>
        Florian Adamsky             <fa-git[AT]haktar.org>
        Florian Bezold              <florian.bezold[AT]esrlabs.com>
        Florian Lohoff              <f[AT]zz.de>
        Francisco Javier Sanchez-Roselly <franciscojavier.sanchezroselly[AT]ujaen.es>
        Francisco Jose Alvarez      <francisco.alvarez[AT]galgus.net>
        Francois Nguyen             <francois[AT]daily-prophet.org>
        Francois Schneider  <francois.schneider[AT]airbus.com>
        Francois-Xavier Le Bail     <fx.lebail[AT]yahoo.com>
        Frank Carpenter             <frank.carpenter[AT]spectralink.com>
        Franklin Mathieu    <franklinmathieu[AT]gmail.com>
        Gabor Vaszkun               <vaszkun[AT]gmail.com>
        Gabriel Ganne               <gabriel.ganne[AT]enea.com>
        Gandharav Katyal    <gandharav4ever[AT]gmail.com>
        Ganesh Nawsupe              <ganesh991[AT]gmail.com>
        Garming Sam         <garming[AT]catalyst.net.nz>
        Gene Cumm           <gene.cumm[AT]gmail.com>
        Georg Brandl                <georg[AT]python.org>
        Georg Richter               <georg[AT]mariadb.org>
        George Hopkins              <george-hopkins[AT]null.net>
        George Powers               <gpowers[AT]google.com>
        Gerard Garcia               <ggarcia[AT]deic.uab.cat>
        Gergely Nagy                <ngg[AT]ngg.hu>
        Gerhard KHUENY              <Gerhard.KHUENY[AT]bachmann.info>
        Gianluca Borello    <g.borello[AT]gmail.com>
        Gilles Dufour               <dufour.gilles[AT]gmail.com>
        Gizem Yurdagul              <gizemnuryurdagul[AT]gmail.com>
        Glenden Lee         <thornhillextreme[AT]gmail.com>
        Gloria Pozuelo              <gloria.pozuelo[AT]bics.com>
        Gordon Ross         <gordon.w.ross[AT]gmail.com>
        Graham Shanks               <graham.shanks[AT]blueyonder.co.uk>
        Greg Morris         <greg.morris[AT]microfocus.com>
        Gregor Beck         <gbeck[AT]sernet.de>
        Gregor Jasny                <gjasny[AT]googlemail.com>
        Gregor Jasny                <gregor.jasny[AT]logmein.com>
        Gregor Miernik              <gregor.miernik[AT]hytec.de>
        Grzegorz Niemirowski        <grzegorz[AT]grzegorz.net>
        Guillaume Autran    <gautran[AT]clearpathrobotics.com>
        Guy Davies          <aguydavies[AT]gmail.com>
        Guy Harris          <gharris[AT]sonic.net>
        Gunther Deschner    <gd[AT]samba.org>
        Hal Rosenstock              <hal.rosenstock[AT]gmail.com>
        Hanspeter Portner   <dev[AT]open-music-kontrollers.ch>
        Harald Welte                <laforge[AT]osmocom.org>
        Hassan Sultan               <sultah[AT]amazon.com>
        Hauke Mehrtens              <hauke.mehrtens[AT]intel.com>
        Helmut Buchsbaum    <helmut.buchsbaum[AT]gmail.com>
        Herwin Weststrate   <herwin[AT]quarantainenet.nl>
        Hessam Jalali               <hessam.jalali[AT]gmail.com>
        Hiroaki KAWAI               <hiroaki.kawai[AT]gmail.com>
        Hiroshi Ioka                <hirochachacha[AT]gmail.com>
        Hitoshi Irino               <irino[AT]sfc.wide.ad.jp>
        Holger Hans Peter Freyther <holger[AT]moiji-mobile.com>
        IWASE Yusuke                <iwase.yusuke0[AT]gmail.com>
        Iain R. Learmonth   <irl[AT]fsfe.org>
        Ian Chard           <ian[AT]chard.org>
        Ido Schimmel                <idosch[AT]mellanox.com>
        Ignacio Martinez    <ignacio.martinez.rivera[AT]gmail.com>
        Igor Passchier              <igor.passchier[AT]tassinternational.com>
        Ike Gilbert         <ike[AT]imgilbert.com>
        Ilya Gavrilov               <ilya.dev[AT]gmail.com>
        Indraneel Guha              <indraneelg[AT]gmail.com>
        Ionut Ceausu                <ionut.ceausu[AT]gmail.com>
        Isaac Boukris               <iboukris[AT]gmail.com>
        Ismael Mendez Matamoros     <ismael[AT]rti.com>
        Ivan Ermakov                <iermakov[AT]yahoo.com>
        Ivan Nardi          <nardi.ivan[AT]gmail.com>
        Ivan Quach          <ivan.quach[AT]aireon.com>
        Ivan Secerin                <ivan.severin.m[AT]gmail.com>
        J. Bruce Fields             <bfields[AT]redhat.com>
        JC Wren                     <jcwren[AT]jcwren.com>
        Jack Culhane                <jackculhane[AT]gmail.com>
        Jaime Caamano Ruiz  <jcaamano[AT]suse.com>
        Jakub Adam          <jakub.adam[AT]collabora.com>
        Jakub Pawlowski             <jpawlowski[AT]google.com>
        Jambukumar Kulandaivel      <jambukumar[AT]codeaurora.org>
        James Coleman               <jamesc[AT]dspsrv.com>
        James Ko            <jck[AT]exegin.com>
        Jamie Hare          <jamie.n.hare[AT]gmail.com>
        Jamil Nimeh         <jnimeh[AT]gmail.com>
        Jan Holthuis                <jan.holthuis[AT]ruhr-uni-bochum.de>
        Jan Kaisrlik                <j.kaisrlik[AT]seznam.cz>
        Jan Seda            <hodor[AT]hodor.cz>
        Jan Spevak          <jan.spevak[AT]nokia.com>
        Jan-Hendrik Bolte   <jabolte[AT]uos.de>
        Jano Svitok         <jsv[AT]whitestein.com>
        Jared Rittle                <jrittle[AT]cisco.com>
        Jason Cohen         <j.cohen[AT]f5.com>
        Jason Cohen         <kryojenik2[AT]gmail.com>
        Jason Heimann               <jheimann[AT]pertino.com>
        Jason Uher          <jason.uher[AT]jhuapl.edu>
        Jason Zhekov                <jasssonpet[AT]gmail.com>
        Javier Cardona              <jcardona[AT]fb.com>
        Jean Thomas         <jeanthomas[AT]sierrawireless.com>
        Jean-Philippe Lebel <jpl[AT]ds.tools>
        Jeff Dyer           <jmasterfunk[AT]gmail.com>
        Jeff Layton         <jlayton[AT]redhat.com>
        Jeff Oconnell               <jeffo[AT]rulez.com>
        Jeff Widman         <jeff[AT]jeffwidman.com>
        Jeffrey Forhan              <jforhan[AT]cisco.com>
        Jeffrey Goff                <jgoff[AT]arubanetworks.com>
        Jeffrey Smith               <whydoubt[AT]gmail.com>
        Jens Kilian         <jens.kilian[AT]advantest.com>
        Jeremiejig          <me[AT]jeremiejig.fr>
        Jeremy Browne               <jer[AT]ifni.ca>
        Jeremy Hitt         <jeremy.hitt[AT]isilon.com>
        Jeremy Kerr         <jk[AT]ozlabs.org>
        Jeremy Martin               <boardermartin[AT]gmail.com>
        Jeroen Roovers              <jer[AT]gentoo.org>
        Jeroen Sack         <jeroen[AT]jeroensack.nl>
        Jesse Gross         <jesse[AT]kernel.org>
        Jiajun Wang         <me[AT]jiajunw.com>
        Jim Borden          <jim.borden[AT]couchbase.com>
        Jim Schaettle               <jimschaettle[AT]gmail.com>
        Jim Walker          <jim[AT]couchbase.com>
        Jim Young           <jim.young.ws[AT]gmail.com>
        Jim Young           <jyoung[AT]gsu.edu>
        Jiri Pirko          <jiri[AT]resnulli.us>
        Jo Rueschel         <wireshark[AT]rueschel.de>
        Joakim Andersson    <joakim.andersson[AT]nordicsemi.no>
        Joakim Karlsson             <oakimk[AT]gmail.com>
        Joakim Karlsson A   <joakim.a.karlsson[AT]ericsson.com>
        Joel Colledge               <joel.colledge[AT]linbit.com>
        Joeri de Ruiter             <joeri[AT]cypherpunk.nl>
        Johan Wahl          <johan.wahl[AT]ericsson.com>
        Johannes Altmanninger       <aclopte[AT]gmail.com>
        Johannes Singler    <johannes[AT]singler.name>
        John A. Thacker             <johnthacker[AT]gmail.com>
        John Bankier                <opensource.jbankier[AT]gmail.com>
        John Keeping                <john[AT]metanate.com>
        John Miner          <optommp[AT]gmail.com>
        John Serock         <serock-wireshark-dev[AT]outlook.com>
        John Tapparo                <j.tapparo[AT]f5.com>
        John Viklund                <john.viklund[AT]effnet.com>
        Jon DeVree          <nuxi[AT]vault24.org>
        Jon Dennis          <j.dennis[AT]cablelabs.com>
        Jonas Falkevik              <jonas.falkevik[AT]gmail.com>
        Jonas Jonsson               <jonas[AT]ludd.ltu.se>
        Jonathan Brucker    <jonathan.brucke[AT]gmail.com>
        Jonathan Fleming    <jonathan[AT]optigo.net>
        Jonathan Munoz              <jonathan.munoz[AT]inria.fr>
        Jordan Keister              <grokspawn[AT]gmail.com>
        Jorge Mora          <jmora1300[AT]gmail.com>
        Jorge Power         <jpower[AT]rsscorp.org>
        Jose Rubio          <joserubiovidales[AT]gmail.com>
        Josef Baumgartner   <josef.baumgartner[AT]br-automation.com>
        Joseph Huffman              <jhuffman[AT]codeaurora.org>
        Josip Medved                <jmedved[AT]jmedved.com>
        Josselin VALLET             <josselin.vallet[AT]toulouse.viveris.com>
        Juan Jose Martin Carrascosa <juanjo[AT]rti.com>
        Juan Matias         <jmrepetti[AT]gmail.com>
        Juan Pablo Mendoza  <jpablo[AT]gmail.com>
        Juergen Kosel               <juergen.kosel[AT]gmx.de>
        Juhani Puurula              <juhani.puurula[AT]arm.com>
        Julian Cable                <julian.cable[AT]yahoo.com>
        Julian Renz         <julian[AT]renz.cloud>
        Julien STAUB                <atsju2[AT]yahoo.fr>
        Jun Wang            <sdn_app[AT]163.com>
        Junpei Yoshino              <junpei.yoshino[AT]gmail.com>
        Justin Dailey               <justin[AT]mti-systems.com>
        Justin Helgesen             <justinhelgesen[AT]gmail.com>
        Justin J. Novack    <jnovack[AT]gmail.com>
        JustinKu            <jiunrong[AT]gmail.com>
        Jero*^me LAFORGE              <jerome.laforge[AT]gmail.com>
        Ka-Shu Wong         <kswong[AT]exablaze.com>
        Karl Knoebl         <karl.knoebl[AT]technikum-wien.at>
        Kary Rogers         <kary.rogers[AT]gmail.com>
        Kasper Deng         <kasper.deng[AT]ericsson.com>
        Keith Scott         <keithlscott[AT]gmail.com>
        Ken Aaker           <kenaaker[AT]gmail.com>
        Kenneth Soerensen   <knnthsrnsn[AT]gmail.com>
        Kenny Root          <kenny[AT]the-b.org>
        Kevin A. Noll               <kevinanoll[AT]gmail.com>
        Kevin Bracey                <kevin.bracey[AT]arm.com>
        Kevin Cernekee              <cernekee[AT]chromium.org>
        Kevin Grigorenko    <kevin.grigorenko[AT]us.ibm.com>
        Kevin Hausman               <kevin.hausman[AT]sentaca.com>
        Kevin Herron                <kevinherron[AT]gmail.com>
        Kevin Hogan         <kwabena[AT]google.com>
        Khalifa NDIAYE              <khalifa.ndiaye[AT]orange.com>
        Kim Backstro*:m               <kim.backstrom[AT]gmail.com>
        Kirill Chernyshov   <nideff.ru[AT]gmail.com>
        Krunal Soni         <krunaldsoni[AT]gmail.com>
        Krzysztof Opasiak   <k.opasiak[AT]samsung.com>
        Lajos Olah          <lajos.olah.jr[AT]gmail.com>
        Lars Christensen    <larsch[AT]belunktum.dk>
        Lars Sundstrom              <lars.x.sundstrom[AT]ericsson.com>
        Lasse Luttermann Poulsen <lasse.luttermann[AT]gmail.com>
        Laszlo Papp         <laszlo.papp[AT]hubersuhner.com>
        Laurenz Kamp                <laurenz.kamp[AT]gmx.de>
        Lee Mitchell                <lee[AT]indigopepper.com>
        Lee Serin           <serinee95[AT]gmail.com>
        Lev Stipakov                <lstipakov[AT]gmail.com>
        Lichen Liu          <llc123456a[AT]gmail.com>
        Lin Sun                     <lin.sun[AT]zoom.us>
        Loganaden Velvindron        <logan[AT]cyberstorm.mu>
        Lorenzo Vannucci    <vannucci[AT]ntop.org>
        Loris Degioanni             <loris[AT]sysdig.com>
        Lotte Steenbrink    <lotte[AT]zombietetris.de>
        Luca Melette                <luca[AT]srlabs.de>
        Lucas Simopoulos    <lsimopoulos[AT]gmail.com>
        Ludovic Cintrat             <l.cintrat[AT]traxens.com>
        Luis Rosa           <lmrosa[AT]dei.uc.pt>
        Lukas Emersberger   <lukas.emersberger[AT]gmail.com>
        Luke Chou           <luke.chou[AT]gmail.com>
        Luke Lynch          <llynch2017[AT]my.fit.edu>
        Luke Mewburn                <luke[AT]mewburn.net>
        Lutz Kresge         <LutzKr[AT]protonmail.ch>
        Leo Gaspard         <leo[AT]gaspard.io>
        Maarten Bezemer             <maarten.bezemer[AT]gmail.com>
        Magnus Henoch               <magnus.henoch[AT]gmail.com>
        Maka0                       <Maka0[AT]yurei.net>
        Makoto Shimamura    <makoto.shimamura[AT]toshiba.co.jp>
        Maksim Salau                <maksim.salau[AT]gmail.com>
        Malcolm Walters             <malcolm.walters[AT]acano.com>
        MaliXa VuXiniX              <malishav[AT]gmail.com>
        Manfred                     <mx2927[AT]gmail.com>
        Marc Bevand         <mbevand[AT]google.com>
        Marc Fournier               <marc.fournier[AT]camptocamp.com>
        Marcel Essig                <marcel.essig[AT]gmx.de>
        Marcelo Ricardo Leitner     <marcelo.leitner[AT]gmail.com>
        Marcin Rokicki              <marcin.rokicki[AT]gmail.com>
        Marcus Sundberg             <marcus.sundberg[AT]aptilo.com>
        Marian XurkoviX             <md[AT]bts.sk>
        Marie Janssen               <jamuraa[AT]google.com>
        Marios Makassikis   <mmakassikis[AT]gmail.com>
        Marius Paliga               <marius.paliga[AT]gmail.com>
        Mariusz Zaborski    <oshogbo[AT]vexillium.org>
        Mark Ciechanowski   <markciechanowski[AT]gmail.com>
        Mark Cunningham             <launchpad[AT]markcunningham.ie>
        Mark Phillips               <mark.s.phillips[AT]outlook.com>
        Mark Weel           <markweel[AT]hotmail.com>
        Markku Leinio               <markku[AT]iki.fi>
        Marko Hrastovec             <marko.hrastovec[AT]gmail.com>
        Markus Becker               <markus.becker[AT]tridonic.com>
        Marouen Ghodhbane   <marouen.ghodhbane[AT]nxp.com>
        Martin                      <martin.lutz[AT]gmail.com>
        Martin Boye Petersen        <martinboyepetersen[AT]gmail.com>
        Martin Fesser               <martin.fesser[AT]allegro-packets.com>
        Martin Heusse               <martin.heusse[AT]imag.fr>
        Martin Mathieson    <martin.mathieson[AT]keysight.com>
        Martin Sehnoutka    <msehnout[AT]redhat.com>
        Martin Tibensky             <martin.tibensky[AT]alcatel-lucent.com>
        Martin Tschoepe             <martin.tschoepe[AT]web.de>
        Martin Vit          <martin[AT]voipmonitor.org>
        Masashi Honma               <masashi.honma[AT]gmail.com>
        Matej KoXik         <5764c029b688c1c0d24a2e97cd764f[AT]gmail.com>
        Matej Tkac          <matej.tkac.mt[AT]gmail.com>
        Mathias Kurth               <mathias.kurth[AT]commsolid.com>
        Mathy Vanhoef               <Mathy.Vanhoef[AT]nyu.edu>
        Matt Carabine               <matt.carabine[AT]hotmail.co.uk>
        Matt Lawrence               <bugzilla.wireshark[AT]erisa.co.uk>
        Matt Parker         <matt.parker[AT]poly.com>
        Matt Porter         <mporter[AT]konsulko.com>
        Matthew Weant               <msweant[AT]gmail.com>
        Matthias Lang               <matthias[AT]corelatus.com>
        Matthieu Coudron    <matthieu.coudron[AT]lip6.fr>
        Max Dmitrichenko    <dmitrmax[AT]gmail.com>
        Maxim Kropp         <maxim.kropp[AT]hotmail.de>
        Maxim Sharabayko    <maxim.sharabayko[AT]gmail.com>
        Maximilian Kohler   <maximilian.kohler[AT]viavisolutions.com>
        Mehmet Oguz Sakaoglu        <mehmet.oguz.mnz[AT]gmail.com>
        Merlin Chlosta              <merlin.chlosta+gnuradio[AT]ruhr-uni-bochum.de>
    Micha Reiser            <michafamreiser.ch>
        Michael Adam                <obnox[AT]samba.org>
        Michael Bouchaud (yoz)      <michael.bouchaud[AT]toulouse.viveris.com>
        Michael Cistera             <michael.cistera[AT]netscout.com>
        Michael Honsel              <lesnoh[AT]gmx.de>
        Michael Mann                <Michael.Mann[AT]jbtc.com>
        Michael McConville  <mmcco[AT]mykolab.com>
        Michael McTernan    <mike.mcternan[AT]wavemobile.com>
        Michael Oed         <michael.oed[AT]gmail.com>
        Michael Penick              <penick[AT]gmail.com>
        Michael Pergament   <mpergament[AT]googlemail.com>
        Michael Schmitt             <mschmitt[AT]fastmail.net>
        Michael Sweet               <michael.r.sweet[AT]gmail.com>
        Michael Vigovsky    <upliner[AT]gmail.com>
        Michail Koreshkov   <drkor[AT]hotbox.ru>
        Michal Kubecek              <mkubecek[AT]suse.cz>
        Michal Pazdera              <michal.pazdera[AT]gmail.com>
        Michal Privozni*'k    <mprivozn[AT]redhat.com>
        Michal Ruprich              <michalruprich[AT]gmail.com>
        Michal Slavka               <slavka.michal[AT]gmail.com>
        Michalis Kapsalakis <kapsalis1989[AT]gmail.com>
        Michael Bouchaud    <michael.bouchaud[AT]external.thalesaleniaspace.com>
        Michael Bouchaud    <michael.bouchaud[AT]gmail.com>
        MichaX Skalski              <mskalski13[AT]gmail.com>
        Michele Baldessari  <michele[AT]acksyn.org>
        Miguel Company              <MiguelCompany[AT]eprosima.com>
        Mihai Codrean               <mihaicodrean[AT]gmail.com>
        Mikael Kanstrup             <mikael.kanstrup[AT]gmail.com>
        Mike Frysinger              <vapier[AT]chromium.org>
        Mike Gerschefske    <msgersch2[AT]gmail.com>
        Mike Lugo           <mlugo.apx[AT]gmail.com>
        Mike Morrin         <morrinmike[AT]gmail.com>
        Mike Ryan           <mikeryan[AT]lacklustre.net>
        Mikhail Gusarov             <dottedmag[AT]dottedmag.net>
        Milan Stute         <mstute[AT]seemoo.tu-darmstadt.de>
        Milos Jovanovic             <jeyem815[AT]gmail.com>
        Miltos Patsiouras   <mipatsio[AT]gmail.com>
        Minh Phan           <phanducnhatminh[AT]gmail.com>
        Mirko Parthey               <mirko.parthey[AT]web.de>
        Moraney Jalil               <moraney.jalil[AT]outlook.com>
        Morten Tryfoss              <morten[AT]tryfoss.no>
        Moshe Kaplan                <me[AT]moshekaplan.com>
        Nathan Cole         <nath[AT]thecoleresidence.co.uk>
        Nathan Houghton             <nathan[AT]brainwerk.org>
        Nathaniel Clark             <Nathaniel.Clark[AT]misrule.us>
        Nathaniel Clark             <nathaniel.l.clark[AT]intel.com>
        Neels Hofmeyr               <neels[AT]hofmeyr.de>
        Neil Ostroff                <neil[AT]mangosoup.com>
        Niall Dugera                <niall.dugera[AT]anam.com>
        Nick Bedbury                <npbedbur[AT]syr.edu>
        Nick Calus          <ncalus[AT]nalys-group.com>
        Nick Carter         <ncarter100[AT]gmail.com>
        Nick James          <mookito[AT]tuta.io>
        Nick Lowe           <nick.lowe[AT]gmail.com>
        Nicolas BERTIN              <nicolas.bertin[AT]al-enterprise.com>
        Nicolas Cavallari   <nicolas.cavallari[AT]green-communications.fr>
        Nicolas Darchis             <ndarchis[AT]cisco.com>
        Nicolas S. Dade             <nic.dade[AT]gmail.com>
        Nikhil Acharya Prakash      <nikhilap[AT]arista.com>
        Nikita Ryaskin              <nikita.ryaskin[AT]dsr-corporation.com>
        Nikolai Ipatyev             <wallprime[AT]yandex.com>
        Nikolay Kovtun              <nikolay.kovtun[AT]dsr-corporation.com>
        Nils Bjorklund              <nils.bjorklund[AT]effnet.com>
        Nils Ohlmeier               <github[AT]ohlmeier.org>
        Nitzan Carmi                <nitzanc[AT]mellanox.com>
        Noel Power          <noel.power[AT]suse.com>
        Nora Sandler                <nsandler[AT]securityinnovation.com>
        Odysseus Yang               <wiresharkyyh[AT]outlook.com>
        Olaf Bergmann               <bergmann[AT]tzi.org>
        Olaf Flaschel               <olaf.flaschel[AT]vestifi.de>
        Olga Kornievskaia   <kolga[AT]netapp.com>
        Oliver                      <cellotape[AT]gmail.com>
        Oliver Downard              <oliver.downard[AT]couchbase.com>
        Oliver Smith                <osmith[AT]sysmocom.de>
        Olivier Verriest    <verri[AT]x25.pm>
        Oren Koler          <clicker78[AT]gmail.com>
        Orgad Shaneh                <orgad.shaneh[AT]audiocodes.com>
        Orgad Shaneh                <orgads[AT]gmail.com>
        Oscar Gonzalez de Dios      <oscar.gonzalezdedios[AT]telefonica.com>
        Osman Sakalla               <osman.sakalla[AT]ericsson.com>
        Owen Williams               <williams.owen[AT]gmail.com>
        PHO                 <pho[AT]cielonegro.org>
        Paolo Abeni         <pabeni[AT]redhat.com>
        Paolo Abeni         <paolo.abeni[AT]gmail.com>
        Parav Pandit                <paravpandit[AT]yahoo.com>
        Pascal Artho                <pascalartho[AT]gmail.com>
        Pascal Quantin              <pascal[AT]wireshark.org>
        Pascal S. de Kloe   <pascal[AT]quies.net>
        Patrice Fournier    <patrice.fournier[AT]ifax.com>
        Patricia Lindner    <plindner6912[AT]gmail.com>
        Patrick MacArthur   <pmacarth[AT]iol.unh.edu>
        Patrick Servello    <patrick.servello[AT]gmail.com>
        Patrik MoXko                <patrikmosko95[AT]gmail.com>
        Patryk Nowak                <patryk.nowak[AT]tieto.com>
        Pau Espin Pedrol    <pespin[AT]sysmocom.de>
        Paul Aurich         <paul[AT]darkrain42.org>
        Paul Chambon                <pchambon[AT]toulouse.viveris.com>
        Paul Emge           <paul.emge[AT]digidescorp.com>
        Paul Offord         <paul.offord[AT]advance7.com>
        Paul Thomas         <pthomas8589[AT]gmail.com>
        Paul Williamson             <paul[AT]mustbeart.com>
        Paul Zander         <p.j.zander[AT]lighting.com>
        PaulThompson                <lankygitster[AT]gmail.com>
        Paulo Roberto Brandao       <betobrandao[AT]gmail.com>
        Pavel Karneliuk             <pavel_karneliuk[AT]epam.com>
        Pavel Moravec               <mgr.pavel[AT]gmail.com>
        Pavel Odintsov              <pavel.odintsov[AT]gmail.com>
        Pavel Strnad                <strnadp[AT]tiscali.cz>
        Pavlos Antoniou             <pant[AT]intracom-telecom.com>
        Pedro Jose Marron   <pjmarron[AT]locoslab.com>
        Pedro Malagon               <malagon[AT]die.upm.es>
        Peng Li                     <seudut[AT]gmail.com>
        Peng Tao            <tao.peng[AT]primarydata.com>
        Peter Hamilton              <qmear55[AT]protonmail.com>
        Peter Krystad               <peter.krystad[AT]linux.intel.com>
        Peter Membrey               <peter[AT]membrey.hk>
        Peter Oettig                <peter.oettig[AT]1und1.de>
        Peter Ross          <peter.ross[AT]dsto.defence.gov.au>
        Petr Gotthard               <petr.gotthard[AT]honeywell.com>
        Petr Janecek                <janecek[AT]ucw.cz>
        Petr Stuchlik               <stuchl4n3k[AT]gmail.com>
        Petr Sumbera                <petr.sumbera[AT]oracle.com>
        Petr Xtetiar                <petr.stetiar[AT]gaben.cz>
        Phil Beeson         <bugzilla[AT]philbeeson.com>
        Philip Rosenberg-Watt       <p.rosenberg-watt[AT]cablelabs.com>
        Philipp Hancke              <fippo[AT]andyet.net>
        Pino Toscano                <pino[AT]debian.org>
        Piotr PawXowski             <ppiotru[AT]gmail.com>
        Piotr Sarna         <sarna[AT]scylladb.com>
        Piotr Smolinski             <piotr.smolinski[AT]confluent.io>
        Piotr Tulpan                <piotr.tulpan[AT]netscan.pl>
        Piotr Winiarczyk    <wino45[AT]gmail.com>
        Poornima G          <pgurusid[AT]redhat.com>
        Prashanth Pai               <ppai[AT]redhat.com>
        Prerit Jain         <prerit.jain[AT]gmail.com>
        Prerit Jain         <prerit.jain[AT]samsung.com>
        Prince Paul         <prince.paul.k[AT]gmail.com>
        Priyanka Mondal             <priyanka02010[AT]gmail.com>
        Radhashyam Behera   <radhashyambehera[AT]gmail.com>
        Rado Radoulov               <rad0x6f[AT]gmail.com>
        RafaX KuXnia                <rafal.kuznia[AT]protonmail.com>
        Rainer Keller               <Rainer.Keller[AT]qt.io>
        Ralf Nasilowski             <Ralf.Nasilowski[AT]ise.de>
        Ralph Boehme                <slow[AT]samba.org>
        Rasmus Jonsson              <wasmus[AT]zom.bi>
        Ray Gomez           <rayvincent.gomez[AT]gmail.com>
        Rediet                      <getachew.redieteab[AT]orange.com>
        Remi Gacogne                <remi.gacogne[AT]powerdns.com>
        Remous-Aris Koutsiamanis <aris[AT]ariskou.com>
        Rene Nielsen                <rene.nielsen[AT]microchip.com>
        Ricardo Cristian Ramirez <r.cristian.ramirez[AT]gmail.com>
        Rich Coe            <richcoe2[AT]gmail.com>
        Richard Kuemmel             <kuemmel.ric[AT]googlemail.com>
        Richard Laager              <rlaager[AT]wiktel.com>
        Richard Smith               <pcy190[AT]126.com>
        Rickard Holmberg    <rickard[AT]avkrok.net>
        Rishi Dev Singh             <rishi.dev[AT]samsung.com>
        Robert Beardsworth  <rob_beardsworth[AT]hotmail.com>
        Robert Cragie               <robert.cragie[AT]gmail.com>
        Robert P            <tehownt[AT]gmail.com>
        Robert Sauter               <sauter[AT]locoslab.com>
        Rody Liu            <rody.liu[AT]ericsson.com>
        Roger Light         <roger[AT]atchoo.org>
        Rohan Saini         <rohan.saini[AT]nokia.com>
        Roland Haenel               <roland[AT]haenel.me>
        Roland Knall                <rknall[AT]gmail.com>
        Romain Tartie`re             <romain[AT]blogreen.org>
        Roman Koshelev              <roman.koshelev[AT]bk.ru>
        Roman Leonhartsberger       <ro.leonhartsberger[AT]gmail.com>
        Roman Volkov                <volkoff_roman[AT]ukr.net>
        Ronen Boazi         <ronen.boazi[AT]intel.com>
        Ross Jacobs         <rossbjacobs[AT]gmail.com>
        Roy Chateau         <chateau.royw[AT]gmail.com>
        Rudra Rugge         <rrugge[AT]juniper.net>
        Rui ZHANG           <rzhang[AT]grandstream.cn>
        Russel Howe         <russel[AT]appliedinvention.com>
        Russell Lowes               <russelll[AT]metamako.com>
        Rustam Safargalin   <rustam.safargalin[AT]sifox.ru>
        Ryan Mullen         <rmmullen[AT]gmail.com>
        Remy Le*'one          <remy.leone[AT]gmail.com>
        Saku Ytti           <saku[AT]ytti.fi>
        Sam Cisneros                <Sam.Cisneros15[AT]protonmail.com>
        Samiran Saha                <ssahasamiran[AT]gmail.com>
        Sandeep Dahiya              <sdahiya[AT]gmail.com>
        Sander Steffann             <sander[AT]steffann.nl>
        Sanket Godbole              <sanket.godbole[AT]spirent.com>
        Sawssen Hadded              <saw.hadded[AT]gmail.com>
        Sayuri Mizushima    <yamaguchi55[AT]protonmail.ch>
        Scott Deandrea              <sdeandrea[AT]apple.com>
        Sebastian Kloeppel  <sk[AT]nakedape.net>
        Sebastian Schildt   <sebastian[AT]frozenlight.de>
        Selva Kumar         <v.selvamuthukumar[AT]gmail.com>
        Selvamegala         <sselvamegala[AT]gmail.com>
        Sergey Avseyev              <sergey.avseyev[AT]gmail.com>
        Sergey Bogdanov             <Sergey.Bogdanov[AT]astrosoft.ru>
        Sergey Rak          <sergrak[AT]iotecha.com>
        Sergio Moreno Mozota        <sergio.morenomozota[AT]telefonica.com>
        Seth Alexander              <seth.alexander[AT]cosmicaes.com>
        Sharvil Nanavati    <sharvil[AT]playground.global>
        Shekhar Chandra             <ranushekhar[AT]gmail.com>
        Shinjo Park         <peremen[AT]gmail.com>
        Shoichi Sakane              <wireshark-shoichi[AT]tanu.org>
        Shu Shen            <shu.shen[AT]gmail.com>
        Shuai Xiao          <iamhihi[AT]gmail.com>
        Shudong Zhou                <shudongzhou[AT]gmail.com>
        Signat Sibirskiy    <ord.blant[AT]gmail.com>
        Silvio Gissi                <silvio.gissi[AT]gmail.com>
        Simon Barber                <simon.barber[AT]meraki.net>
        Simon Graham                <simgrxp[AT]gmail.com>
        Simon Holesch               <simon[AT]holesch.de>
        Simon Long          <hobei[AT]whitedoor.plus.com>
        Simon Vans-Colina   <simon[AT]monzo.com>
        Simon Zhong         <szhong.jnpr[AT]gmail.com>
        Slava Bacherikov    <slava[AT]bacher09.org>
        Slava Shwartsman    <slavash[AT]mellanox.com>
        Solganik Alexander  <solganik[AT]gmail.com>
        Sontol Bonggol              <sonbonggol[AT]gmail.com>
        Soumya Koduri               <skoduri[AT]redhat.com>
        Steev Klimaszewski  <threeway[AT]gmail.com>
        Stefan Battmer              <stefan.battmer[AT]matrix-vision.de>
        Stefan Doehla               <stefan.doehla[AT]iis.fraunhofer.de>
        Stefan Hajnoczi             <stefanha[AT]redhat.com>
        Stefan Poschel              <github[AT]basicmaster.de>
        Stefan Tatschner    <stefan[AT]rumpelsepp.org>
        Stefan Volkel               <sv[AT]its-v.de>
        Stella Randall              <stella.randall[AT]emeerson.com>
        Stephan Kappertz    <octopus.sk[AT]googlemail.com>
        Stephane Bryant             <stephane.ml.bryant[AT]gmail.com>
        Stephen Donnelly    <stephen.donnelly[AT]endace.com>
        Steve Osselton              <steve.osselton[AT]gmail.com>
        Sultan Qasim Khan   <sultan.qasimkhan[AT]nccgroup.com>
        Sunil Mushran               <sunil.mushran[AT]oracle.com>
        Sven Eckelmann              <sven[AT]open-mesh.com>
        Sven Schnelle               <svens[AT]stackframe.org>
        Swapnil Roy         <swapnil.advent[AT]gmail.com>
        Sylvain Munaut              <tnt[AT]246tNt.com>
        Sebastien Deronne   <sebastien.deronne[AT]gmail.com>
        Sebastien RAILLARD  <sr[AT]coexsi.fr>
        T. Scholz           <scholzt234[AT]googlemail.com>
        Tadeusz Struk               <tadeusz.struk[AT]intel.com>
        Tadeusz Struk               <tstruk[AT]gmail.com>
        Taisuke Sasaki              <taisasak[AT]cisco.com>
        Tamir Duberstein    <tamird[AT]google.com>
        Tatsuhiro Tsujikawa <tatsuhiro.t[AT]gmail.com>
        Tengfei Chang               <tengfei.chang[AT]inria.fr>
        Teyut                       <teyut[AT]free.fr>
        Thibault Gerondal   <github[AT]tycale.be>
        Thies Moeller               <thies.moeller[AT]baslerweb.com>
        Thiyagarajan P              <psvthiyagarajan[AT]gmail.com>
        Thomas Chen         <funorpain[AT]gmail.com>
        Thomas Dreibholz    <dreibh[AT]simula.no>
        Thomas Klausner             <tk[AT]giga.or.at>
        Thomas Portassau    <thomas.portassau[AT]hotmail.fr>
        Thomas Shen         <thomashen[AT]gmail.com>
        Thomas Vogt         <gitwiresharktv[AT]ist-einmalig.de>
        Thomas dOtreppe    <tdotreppe[AT]aircrack-ng.org>
        Tigran Mkrtchyan    <tigran.mkrtchyan[AT]desy.de>
        Tim (Thanh) Nguyen  <tnnguyen[AT]broadcom.com>
        Tim Cuthbertson             <tim[AT]gfxmonk.net>
        Tim Furlong         <tim.furlong[AT]gmail.com>
        Timo Warns          <timow+github[AT]DiningPhilosopher.DE>
        Timothy Geiser              <slimshady007[AT]inbox.lv>
        Tobias Brunner              <tobias[AT]strongswan.org>
        Tobias Mueller              <muelli[AT]cryptobitch.de>
        Tobias Rasmusson    <tobias.rasmusson[AT]gmail.com>
        Tobias Stoeckmann   <tobias[AT]stoeckmann.org>
        Tom                 <tom916[AT]qq.com>
        Tom Haynes          <loghyr[AT]hammerspace.com>
        Tom Haynes          <loghyr[AT]primarydata.com>
        Tom Nisbet          <t.talk[AT]nisbethome.com>
        Tom Yan                     <tom.yan[AT]nokia-sbell.com>
        Tomas Konecny               <tomas.konecny[AT]eldis.cz>
        Tomas Kukosa                <kukosa[AT]herman.cz>
        Tomas Kukosa                <tkeksa[AT]gmail.com>
        Tomas Kukosa                <tomas.kukosa[AT]ixperta.com>
        Tomas Liscak                <tomas.liscak[AT]nokia.com>
        Tony Ciavarella             <tony.ciavarella[AT]squalllinesoftware.com>
        Topi Miettinen              <toiwoton[AT]gmail.com>
        Trond Myklebust             <trond.myklebust[AT]primarydata.com>
        Trond Norbye                <trond[AT]couchbase.com>
        Ulf                 <ulf33286[AT]gmail.com>
        Uli Schlachter              <psychon[AT]znc.in>
        Umberto Corponi             <umberto.corponi[AT]athonet.com>
        Uri Simchoni                <urisimchoni[AT]gmail.com>
        Uwe Kleine-Konig    <uwe[AT]kleine-koenig.org>
        Vadim Fedorenko             <vadimjunk[AT]gmail.com>
        Vadim Yanitskiy             <axilirator[AT]gmail.com>
        Vadim Yanitskiy             <vyanitskiy[AT]sysmocom.de>
        Vahap Emin Agaogullari      <vahapemin44[AT]gmail.com>
        ValdikSS            <iam[AT]valdikss.org.ru>
        Valentin Vidic              <Valentin.Vidic[AT]CARNet.hr>
        Valerii Zapodovnikov        <val.zapod.vz[AT]gmail.com>
        Vanson Lim          <vlim[AT]cisco.com>
        Vasil Velichkov             <vvvelichkov[AT]gmail.com>
        Victor Barratault   <victor.barratault[AT]gmail.com>
        Victor Dodon                <dodonvictor[AT]gmail.com>
        Victor Voronkov             <victor.voronkov[AT]gmail.com>
        Vidar Madsen                <vidarino[AT]gmail.com>
        Vik                 <vkp129+ubuntu[AT]gmail.com>
        Vikhyat Umrao               <vumrao[AT]redhat.com>
        Vikram Hegde                <vikram.h[AT]samsung.com>
        Ville Skytta                <ville.skytta[AT]iki.fi>
        Vincent Helfre              <vincent.helfre[AT]gmx.net>
        Vincenzo Reale              <smart2128[AT]baslug.org>
        Vivek Pandey                <vivek_pandey[AT]comcast.com>
        Vladimir Kondratiev <qca_vkondrat[AT]qca.qualcomm.com>
        Vladimir Rutsky             <rutsky[AT]google.com>
        Vladislav Grishenko <themiron[AT]mail.ru>
        Vladlen Popov               <vladlen.popov[AT]yahoo.com>
        Volker Lendecke             <vl[AT]samba.org>
        Volodymyr Khomenko  <Khomenko.Volodymyr[AT]gmail.com>
        Volodymyr Khomenko  <volodymyr[AT]vastdata.com>
        Volodymyr Veskera   <volodymyrv[AT]interfacemasters.com>
        Warren Moxam                <warrenmptgrey[AT]gmail.com>
        Wasim Abu Moch              <wasim[AT]mellanox.com>
        Weston Andros Adamson       <dros[AT]primarydata.com>
        Weston Schmidt              <weston_schmidt[AT]alumni.purdue.edu>
        Will Glynn          <will[AT]willglynn.com>
        Will Robertson              <aliask[AT]gmail.com>
        William Tu          <u9012063[AT]gmail.com>
        Xavier Brouckaert   <xabrouck[AT]cisco.com>
        Xiaochuan Sun               <linuxvxworks[AT]gmail.com>
        Xiaoxia Lang                <xxlang[AT]grandstream.cn>
        Xu                  <alvin.xu[AT]nokia-sbell.com>
        XuNiu                       <993273596[AT]qq.com>
        YFdyh000            <yfdyh000[AT]gmail.com>
        Yan Burman          <yanb[AT]mellanox.com>
        Yang Luo            <hsluoyz[AT]qq.com>
        Yann Diorcet                <yann[AT]diorcet.fr>
        Yann Garcia         <yann.garcia[AT]fscom.frSkype>
        Yann Lejeune                <ylejeune[AT]netyl.org>
        Yann Pomare`de               <yann.pomarede[AT]gmail.com>
        Yannik Enss         <Yannik.Enss[AT]rohde-schwarz.com>
        Yasuyuki Tanaka             <yasuyuki.tanaka[AT]inria.fr>
        Yehonatan Zecharia  <yonti95[AT]gmail.com>
        Yoshihiro Ueda              <uyoshihiro[AT]users.noreply.gitlab.com>
        Yoshiyuki Kurauchi  <ahochauwaaaaa[AT]gmail.com>
        Yuri Chislov                <yuri.chislov[AT]gmail.com>
        Yurii Lysyi         <yurii.lysyi[AT]ericsson.com>
        Yury Gargay         <yury.gargay[AT]gmail.com>
        Zachary Holcomb             <zholcomb2017[AT]my.fit.edu>
        ZdenXk Xambersky    <zzdevel[AT]seznam.cz>
        Zhao Lin            <zlbinghamton[AT]gmail.com>
        Zhenhua Hu          <fattiger1102[AT]gmail.com>
        ZhongYao Luo                <LuoZhongYao[AT]gmail.com>
        akuchekar           <akuchekar[AT]empirix.com>
        anonsvn                     <anonsvn[AT]localhost>
        atul358                     <atul358[AT]gmail.com>
        cff339                      <cff339[AT]gmail.com>
        cheloftus           <cheloftus[AT]gmail.com>
        dennisschagt                <dennisschagt[AT]gmail.com>
        eckart haug         <wireshark[AT]syntacs.com>
        ishaangandhi                <ishaangandhi[AT]gmail.com>
        jfp_martin          <john[AT]purplemeanie.co.uk>
        kardam                      <netkardam[AT]gmail.com>
        kkoizumi            <kkoizumi46[AT]gmail.com>
        liningjie           <1350445139[AT]qq.com>
        mkg20001            <mkg20001[AT]gmail.com>
        naf                 <naf[AT]sdf.org>
        nickvsnetworking    <nick[AT]nickvsnetworking.com>
        pegah hajiani               <pegah_haj[AT]yahoo.com>
        rbroker                     <rstbroker[AT]gmail.com>
        shqking                     <shqking[AT]gmail.com>
        subhav8                     <subhadevi88[AT]gmail.com>
        zhongweisitu                <zsitu[AT]extremenetworks.com>
        zhudewen            <zhudewen[AT]iauto.com>
        Emilio Gonzalez             <egg997[AT]gmail.com>
        Eric Piel           <piel[AT]delmic.com>
        Oyvind Ro*/nningstad  <ronningstad[AT]gmail.com>
        XXXXXXX XXXXXXX             <dmitrycvet[AT]gmail.com>
    .Ve
    .SS "Acknowledgements"
    .IX Subsection "Acknowledgements"
    Dan Lasley <dlasley[s-1ATs0]promus.com> gave permission for his dumpit() hex-dump routine to be used.
    
    Mattia Cazzola <mattiac[s-1ATs0]alinet.it> provided a patch to the hex dump display routine.
    
    We use the exception module from Kazlib, a C library written by Kaz Kylheku <kaz[s-1ATs0]kylheku.com>. Thanks go to him for his well-written library. The Kazlib home page can be found at http://www.kylheku.com/~kaz/kazlib.html
    
    We use Lua BitOp, written by Mike Pall, for bitwise operations on numbers in Lua. The Lua BitOp home page can be found at https://bitop.luajit.org
    
    snax <snax[s-1ATs0]shmoo.com> gave permission to use his(?) weak key detection code from Airsnort.
    
    s-1IANAs0 gave permission for their port-numbers file to be used.
    
    We use the natural order string comparison algorithm, written by Martin Pool <mbp[s-1ATs0]sourcefrog.net>.
    
    Emanuel Eichhammer <support[s-1ATs0]qcustomplot.com> granted permission to use QCustomPlot.
    
    Insecure.Com s-1LLCs0 (The Nmap Project*(R") has granted the Wireshark Foundation permission to distribute Npcap with our Windows installers.
