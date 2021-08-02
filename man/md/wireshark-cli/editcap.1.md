# editcap(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

editcap - Edit and/or translate the format of capture files

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" editcap [&nbsp;-a&nbsp;<frame:comment>&nbsp;] [&nbsp;-A&nbsp;<start&nbsp;time>&nbsp;] [&nbsp;-B&nbsp;<stop&nbsp;time>&nbsp;] [&nbsp;-c&nbsp;<packets&nbsp;per&nbsp;file>&nbsp;] [&nbsp;-C&nbsp;[offset:]<choplen>&nbsp;] [&nbsp;-E&nbsp;<error&nbsp;probability>&nbsp;] [&nbsp;-F&nbsp;<file&nbsp;format>&nbsp;] [&nbsp;-h&nbsp;] [&nbsp;-i&nbsp;<seconds&nbsp;per&nbsp;file>&nbsp;] [&nbsp;-o&nbsp;<change&nbsp;offset>&nbsp;] [&nbsp;-L&nbsp;] [&nbsp;-r&nbsp;] [&nbsp;-s&nbsp;<snaplen>&nbsp;] [&nbsp;-S&nbsp;<strict&nbsp;time&nbsp;adjustment>&nbsp;] [&nbsp;-t&nbsp;<time&nbsp;adjustment>&nbsp;] [&nbsp;-T&nbsp;<encapsulation&nbsp;type>&nbsp;] [&nbsp;-v&nbsp;] [&nbsp;--inject-secrets&nbsp;<secrets&nbsp;type>,<file>&nbsp;] [&nbsp;--discard-all-secrets&nbsp;] [&nbsp;--capture-comment&nbsp;<comment>&nbsp;] [&nbsp;--discard-capture-comment&nbsp;] infile outfile [&nbsp;packet#[-packet#]&nbsp;...&nbsp;] 
 editcap &nbsp;-d&nbsp; | &nbsp;-D&nbsp;<dup&nbsp;window>&nbsp; | &nbsp;-w&nbsp;<dup&nbsp;time&nbsp;window>&nbsp; [&nbsp;-v&nbsp;] [&nbsp;-I&nbsp;<bytes&nbsp;to&nbsp;ignore>&nbsp;] [&nbsp;--skip-radiotap-header&nbsp;] infile outfile 
 editcap [&nbsp;-V&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Editcap** is a program that reads some or all of the captured packets from the
_infile_, optionally converts them in various ways and writes the
resulting packets to the capture _outfile_ (or outfiles).

By default, it reads all packets from the _infile_ and writes them to the
_outfile_ in pcapng file format.

An optional list of packet numbers can be specified on the command tail;
individual packet numbers separated by whitespace and/or ranges of packet
numbers can be specified as _start_-_end_, referring to all packets from
_start_ to _end_.  By default the selected packets with those numbers will
_not_ be written to the capture file.  If the **-r** flag is specified, the
whole packet selection is reversed; in that case _only_ the selected packets
will be written to the capture file.

**Editcap** can also be used to remove duplicate packets.  Several different
options (**-d**, **-D** and **-w**) are used to control the packet window
or relative time window to be used for duplicate comparison.

**Editcap** can be used to assign comment strings to frame numbers.

**Editcap** is able to detect, read and write the same capture files that
are supported by **Wireshark**.
The input file doesn't need a specific filename extension; the file
format and an optional gzip compression will be automatically detected.
Near the beginning of the \s-1DESCRIPTION\s0 section of **wireshark**\|(1) or
&lt;https://www.wireshark.org/docs/man-pages/wireshark.html&gt;
is a detailed description of the way **Wireshark** handles this, which is
the same way **Editcap** handles this.

**Editcap** can write the file in several output formats. The **-F**
flag can be used to specify the format in which to write the capture
file; **editcap -F** provides a list of the available output formats.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -a  &lt;framenum:comment&gt;  
  .IX Item "-a &lt;framenum:comment&gt;"
  For the specifiqed frame number, assign the given comment string.
  Can be repeated for multiple frames.  Quotes should be used with comment
  strings that include spaces.
* -A  &lt;start time&gt;  
  .IX Item "-A &lt;start time&gt;"
  Saves only the packets whose timestamp is on or after start time.
  The time is given in the following format YYYY-MM-DD HH:MM:SS[.nnnnnnnnn]
  (the decimal and fractional seconds are optional).
* -B  &lt;stop time&gt;  
  .IX Item "-B &lt;stop time&gt;"
  Saves only the packets whose timestamp is before stop time.
  The time is given in the following format YYYY-MM-DD HH:MM:SS[.nnnnnnnnn]
  (the decimal and fractional seconds are optional).
* -c  &lt;packets per file&gt;  
  .IX Item "-c &lt;packets per file&gt;"
  Splits the packet output to different files based on uniform packet counts
  with a maximum of &lt;packets per file&gt; each. Each output file will
  be created with a suffix -nnnnn, starting with 00000. If the specified
  number of packets is written to the output file, the next output file is
  opened. The default is to use a single output file.
* -C  [offset:]&lt;choplen&gt;  
  .IX Item "-C [offset:]&lt;choplen&gt;"
  Sets the chop length to use when writing the packet data. Each packet is
  chopped by &lt;choplen&gt; bytes of data. Positive values chop at the packet
  beginning while negative values chop at the packet end.
  .Sp
  If an optional offset precedes the &lt;choplen&gt;, then the bytes chopped will be
  offset from that value. Positive offsets are from the packet beginning, while
  negative offsets are from the packet end.
  .Sp
  This is useful for chopping headers for decapsulation of an entire capture,
  removing tunneling headers, or in the rare case that the conversion between two
  file formats leaves some random bytes at the end of each packet. Another use is
  for removing vlan tags.
  .Sp
  \s-1NOTE:\s0 This option can be used more than once, effectively allowing you to chop
  bytes from up to two different areas of a packet in a single pass provided that
  you specify at least one chop length as a positive value and at least one as a
  negative value.  All positive chop lengths are added together as are all
  negative chop lengths.
* -d  
  .IX Item "-d"
  Attempts to remove duplicate packets.  The length and \s-1MD5\s0 hash of the
  current packet are compared to the previous four (4) packets.  If a
  match is found, the current packet is skipped.  This option is equivalent
  to using the option **-D 5**.
* -D  &lt;dup window&gt;  
  .IX Item "-D &lt;dup window&gt;"
  Attempts to remove duplicate packets.  The length and \s-1MD5\s0 hash of the
  current packet are compared to the previous &lt;dup window&gt; - 1 packets.
  If a match is found, the current packet is skipped.
  .Sp
  The use of the option **-D 0** combined with the **-v** option is useful
  in that each packet's Packet number, Len and \s-1MD5\s0 Hash will be printed
  to standard out.  This verbose output (specifically the \s-1MD5\s0 hash strings)
  can be useful in scripts to identify duplicate packets across trace
  files.
  .Sp
  The &lt;dup window&gt; is specified as an integer value between 0 and 1000000 (inclusive).
  .Sp
  \s-1NOTE:\s0 Specifying large &lt;dup window&gt; values with large tracefiles can
  result in very long processing times for **editcap**.
* -E  &lt;error probability&gt;  
  .IX Item "-E &lt;error probability&gt;"
  Sets the probability that bytes in the output file are randomly changed.
  **Editcap** uses that probability (between 0.0 and 1.0 inclusive)
  to apply errors to each data byte in the file.  For instance, a
  probability of 0.02 means that each byte has a 2% chance of having an error.
  .Sp
  This option is meant to be used for fuzz-testing protocol dissectors.
* -F  &lt;file format&gt;  
  .IX Item "-F &lt;file format&gt;"
  Sets the file format of the output capture file.
  **Editcap** can write the file in several formats, **editcap -F**
  provides a list of the available output formats. The default
  is the **pcapng** format.
* -h  
  .IX Item "-h"
  Prints the version and options and exits.
* -i  &lt;seconds per file&gt;  
  .IX Item "-i &lt;seconds per file&gt;"
  Splits the packet output to different files based on uniform time
  intervals using a maximum interval of &lt;seconds per file&gt; each. Floating
  point values (e.g. 0.5) are allowed. Each output file will be created
  with a suffix -nnnnn, starting with 00000. If packets for the specified
  time interval are written to the output file, the next output file is
  opened. The default is to use a single output file.
* -I  &lt;bytes to ignore&gt;  
  .IX Item "-I &lt;bytes to ignore&gt;"
  Ignore the specified number of bytes at the beginning of the frame during \s-1MD5\s0 hash calculation,
  unless the frame is too short, then the full frame is used.
  Useful to remove duplicated packets taken on several routers (different mac addresses for example)
  e.g. -I 26 in case of Ether/IP will ignore ether(14) and \s-1IP\s0 header(20 - 4(src ip) - 4(dst ip)).
  The default value is 0.
* -L  
  .IX Item "-L"
  Adjust the original frame length accordingly when chopping and/or snapping
  (in addition to the captured length, which is always adjusted regardless of
  whether **-L** is specified or not).  See also **-C &lt;choplen**&gt; and **-s &lt;snaplen**&gt;.
* -o  &lt;change offset&gt;  
  .IX Item "-o &lt;change offset&gt;"
  When used in conjunction with -E, skip some bytes from the beginning of the packet
  from being changed. In this way some headers don't get changed, and the fuzzer is
  more focused on a smaller part of the packet. Keeping a part of the packet fixed
  the same dissector is triggered, that make the fuzzing more precise.
* -r  
  .IX Item "-r"
  Reverse the packet selection.
  Causes the packets whose packet numbers are specified on the command
  line to be written to the output capture file, instead of discarding them.
* -s  &lt;snaplen&gt;  
  .IX Item "-s &lt;snaplen&gt;"
  Sets the snapshot length to use when writing the data.
  If the **-s** flag is used to specify a snapshot length, packets in the
  input file with more captured data than the specified snapshot length
  will have only the amount of data specified by the snapshot length
  written to the output file.
  .Sp
  This may be useful if the program that is
  to read the output file cannot handle packets larger than a certain size
  (for example, the versions of snoop in Solaris 2.5.1 and Solaris 2.6
  appear to reject Ethernet packets larger than the standard Ethernet \s-1MTU,\s0
  making them incapable of handling gigabit Ethernet captures if jumbo
  packets were used).
* --seed  &lt;seed&gt;  
  .IX Item "--seed &lt;seed&gt;"
  When used in conjunction with -E, set the seed for the pseudo-random number generator.
  This is useful for recreating a particular sequence of errors.
* --skip-radiotap-header  
  .IX Item "--skip-radiotap-header"
  Skip the radiotap header of each frame when checking for packet duplicates. This is useful
  when processing a capture created by combining outputs of multiple capture devices on the same
  channel in the vicinity of each other.
* -S  &lt;strict time adjustment&gt;  
  .IX Item "-S &lt;strict time adjustment&gt;"
  Time adjust selected packets to ensure strict chronological order.
  .Sp
  The &lt;strict time adjustment&gt; value represents relative seconds
  specified as [-]_seconds_[_.fractional seconds_].
  .Sp
  As the capture file is processed each packet's absolute time is
  _possibly_ adjusted to be equal to or greater than the previous
  packet's absolute timestamp depending on the &lt;strict time
  adjustment&gt; value.
  .Sp
  If &lt;strict time adjustment&gt; value is 0 or greater (e.g. 0.000001)
  then **only** packets with a timestamp less than the previous packet
  will adjusted.  The adjusted timestamp value will be set to be
  equal to the timestamp value of the previous packet plus the value
  of the &lt;strict time adjustment&gt; value.  A &lt;strict time adjustment&gt;
  value of 0 will adjust the minimum number of timestamp values
  necessary to ensure that the resulting capture file is in
  strict chronological order.
  .Sp
  If &lt;strict time adjustment&gt; value is specified as a
  negative value, then the timestamp values of **all**
  packets will be adjusted to be equal to the timestamp value
  of the previous packet plus the absolute value of the
  &lt;lt&gt;strict time adjustment&lt;gt&gt; value. A &lt;strict time
  adjustment&gt; value of -0 will result in all packets
  having the timestamp value of the first packet.
  .Sp
  This feature is useful when the trace file has an occasional
  packet with a negative delta time relative to the previous
  packet.
* -t  &lt;time adjustment&gt;  
  .IX Item "-t &lt;time adjustment&gt;"
  Sets the time adjustment to use on selected packets.
  If the **-t** flag is used to specify a time adjustment, the specified
  adjustment will be applied to all selected packets in the capture file.
  The adjustment is specified as [-]_seconds_[_.fractional seconds_].
  For example, **-t** 3600 advances the timestamp on selected packets by one
  hour while **-t** -0.5 reduces the timestamp on selected packets by
  one-half second.
  .Sp
  This feature is useful when synchronizing dumps
  collected on different machines where the time difference between the
  two machines is known or can be estimated.
* -T  &lt;encapsulation type&gt;  
  .IX Item "-T &lt;encapsulation type&gt;"
  Sets the packet encapsulation type of the output capture file.
  If the **-T** flag is used to specify an encapsulation type, the
  encapsulation type of the output capture file will be forced to the
  specified type.
  **editcap -T** provides a list of the available types. The default
  type is the one appropriate to the encapsulation type of the input
  capture file.
  .Sp
  Note: this merely
  forces the encapsulation type of the output file to be the specified
  type; the packet headers of the packets will not be translated from the
  encapsulation type of the input capture file to the specified
  encapsulation type (for example, it will not translate an Ethernet
  capture to an \s-1FDDI\s0 capture if an Ethernet capture is read and '-T
  fddi' is specified). If you need to remove/add headers from/to a
  packet, you will need **od**\|(1)/**text2pcap**\|(1).
* -v  
  .IX Item "-v"
  Causes **editcap** to print verbose messages while it's working.
  .Sp
  Use of **-v** with the de-duplication switches of **-d**, **-D** or **-w**
  will cause all \s-1MD5\s0 hashes to be printed whether the packet is skipped
  or not.
* -V  
  .IX Item "-V"
  Print the version and exit.
* -w  &lt;dup time window&gt;  
  .IX Item "-w &lt;dup time window&gt;"
  Attempts to remove duplicate packets.  The current packet's arrival time
  is compared with up to 1000000 previous packets.  If the packet's relative
  arrival time is _less than or equal to_ the &lt;dup time window&gt; of a previous packet
  and the packet length and \s-1MD5\s0 hash of the current packet are the same then
  the packet to skipped.  The duplicate comparison test stops when
  the current packet's relative arrival time is greater than &lt;dup time window&gt;.
  .Sp
  The &lt;dup time window&gt; is specified as _seconds_[_.fractional seconds_].
  .Sp
  The [.fractional seconds] component can be specified to nine (9) decimal
  places (billionths of a second) but most typical trace files have resolution
  to six (6) decimal places (millionths of a second).
  .Sp
  \s-1NOTE:\s0 Specifying large &lt;dup time window&gt; values with large tracefiles can
  result in very long processing times for **editcap**.
  .Sp
  \s-1NOTE:\s0 The **-w** option assumes that the packets are in chronological order.
  If the packets are \s-1NOT\s0 in chronological order then the **-w** duplication
  removal option may not identify some duplicates.
* --inject-secrets &lt;secrets type&gt;,&lt;file&gt;  
  .IX Item "--inject-secrets &lt;secrets type&gt;,&lt;file&gt;"
  Inserts the contents of &lt;file&gt; into a Decryption Secrets Block (\s-1DSB\s0)
  within the pcapng output file. This enables decryption without requiring
  additional configuration in protocol preferences.
  .Sp
  The file format is described by &lt;secrets type&gt; which can be one of:
  .Sp
  _tls_  \s-1TLS\s0 Key Log as described at &lt;https://developer.mozilla.org/NSS_Key_Log_Format&gt;
  _wg_   WireGuard Key Log, see &lt;https://gitlab.com/wireshark/wireshark/-/wikis/WireGuard#key-log-format&gt;
  .Sp
  This option may be specified multiple times. The available options for
  &lt;secrets type&gt; can be listed with **--inject-secrets help**.
* --discard-all-secrets  
  .IX Item "--discard-all-secrets"
  Discard all decryption secrets from the input file when writing the
  output file.  Does not discard secrets added by **--inject-secrets** in
  the same command line.
* --capture-comment &lt;comment&gt;  
  .IX Item "--capture-comment &lt;comment&gt;"
  Adds the given comment to the Section Header Block (\s-1SHB\s0) of the pcapng
  output file. New comments will be added _after_ any comments present in the
  input file unless **--discard-capture-comment** is also specified.
  .Sp
  This option may be specified multiple times. Note that Wireshark currently only
  recognizes the first comment of a capture file.
* --discard-capture-comment  
  .IX Item "--discard-capture-comment"
  Discard all capture file comments from the input file when writing the output
  file. Does not discard comments added by **--capture-comment** in the same
  command line.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see more detailed description of the options use:

.Vb 1
    editcap -h
.Ve

To shrink the capture file by truncating the packets at 64 bytes and writing it as Sun snoop file use:

.Vb 1
    editcap -s 64 -F snoop capture.pcapng shortcapture.snoop
.Ve

To delete packet 1000 from the capture file use:

.Vb 1
    editcap capture.pcapng sans1000.pcapng 1000
.Ve

To limit a capture file to packets from number 200 to 750 (inclusive) use:

.Vb 1
    editcap -r capture.pcapng small.pcapng 200-750
.Ve

To get all packets from number 1-500 (inclusive) use:

.Vb 1
    editcap -r capture.pcapng first500.pcapng 1-500
.Ve

or

.Vb 1
    editcap capture.pcapng first500.pcapng 501-9999999
.Ve

To exclude packets 1, 5, 10 to 20 and 30 to 40 from the new file use:

.Vb 1
    editcap capture.pcapng exclude.pcapng 1 5 10-20 30-40
.Ve

To select just packets 1, 5, 10 to 20 and 30 to 40 for the new file use:

.Vb 1
    editcap -r capture.pcapng select.pcapng 1 5 10-20 30-40
.Ve

To remove duplicate packets seen within the prior four frames use:

.Vb 1
    editcap -d capture.pcapng dedup.pcapng
.Ve

To remove duplicate packets seen within the prior four frames while skipping radiotap headers use:

.Vb 1
    editcap -d --skip-radiotap-header capture.pcapng dedup.pcapng
.Ve

To remove duplicate packets seen within the prior 100 frames use:

.Vb 1
    editcap -D 101 capture.pcapng dedup.pcapng
.Ve

To remove duplicate packets seen _equal to or less than_ 1/10th of a second:

.Vb 1
    editcap -w 0.1 capture.pcapng dedup.pcapng
.Ve

To display the \s-1MD5\s0 hash for all of the packets (and \s-1NOT\s0 generate any
real output file):

.Vb 1
    editcap -v -D 0 capture.pcapng /dev/null
.Ve

or on Windows systems

.Vb 1
    editcap -v -D 0 capture.pcapng NUL
.Ve

To advance the timestamps of each packet forward by 3.0827 seconds:

.Vb 1
    editcap -t 3.0827 capture.pcapng adjusted.pcapng
.Ve

To ensure all timestamps are in strict chronological order:

.Vb 1
    editcap -S 0 capture.pcapng adjusted.pcapng
.Ve

To introduce 5% random errors in a capture file use:

.Vb 1
    editcap -E 0.05 capture.pcapng capture_error.pcapng
.Ve

To remove vlan tags from all packets within an Ethernet-encapsulated capture
file, use:

.Vb 1
    editcap -L -C 12:4 capture_vlan.pcapng capture_no_vlan.pcapng
.Ve

To chop both the 10 byte and 20 byte regions from the following 75 byte packet
in a single pass, use any of the 8 possible methods provided below:

.Vb 1
    &lt;--------------------------- 75 ----------------------------&gt;

    +---+-------+-----------+---------------+-------------------+
    | 5 |   10  |     15    |       20      |         25        |
    +---+-------+-----------+---------------+-------------------+

    1) editcap -C 5:10 -C -25:-20 capture.pcapng chopped.pcapng
    2) editcap -C 5:10 -C 50:-20 capture.pcapng chopped.pcapng
    3) editcap -C -70:10 -C -25:-20 capture.pcapng chopped.pcapng
    4) editcap -C -70:10 -C 50:-20 capture.pcapng chopped.pcapng
    5) editcap -C 30:20 -C -60:-10 capture.pcapng chopped.pcapng
    6) editcap -C 30:20 -C 15:-10 capture.pcapng chopped.pcapng
    7) editcap -C -45:20 -C -60:-10 capture.pcapng chopped.pcapng
    8) editcap -C -45:20 -C 15:-10 capture.pcapng chopped.pcapng
.Ve

To add comment strings to the first 2 input frames, use:

.Vb 1
    editcap -a "1:1st frame" -a 2:Second capture.pcapng capture-comments.pcapng
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pcap**\|(3), **wireshark**\|(1), **tshark**\|(1), **mergecap**\|(1), **dumpcap**\|(1), **capinfos**\|(1),
**text2pcap**\|(1), **reordercap**\|(1), **od**\|(1), **pcap-filter**\|(7) or **tcpdump**\|(8)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Editcap** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  -------- ------
  Richard Sharpe           &lt;sharpe[AT]ns.aus.com&gt;


  Contributors
  ------------
  Guy Harris               &lt;guy[AT]alum.mit.edu&gt;
  Ulf Lamping              &lt;ulf.lamping[AT]web.de&gt;
.Ve
