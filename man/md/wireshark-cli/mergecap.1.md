# mergecap(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

mergecap - Merges two or more capture files into one

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" mergecap [&nbsp;-a&nbsp;] [&nbsp;-F&nbsp;<file&nbsp;format>&nbsp;] [&nbsp;-h&nbsp;] [&nbsp;-I&nbsp;<\s-1IDB\s0&nbsp;merge&nbsp;mode>&nbsp;] [&nbsp;-s&nbsp;<snaplen>&nbsp;] [&nbsp;-v&nbsp;] [&nbsp;-V&nbsp;] -w&nbsp;<outfile>|- <infile> [<infile> ...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Mergecap** is a program that combines multiple saved capture files into
a single output file specified by the **-w** argument.  **Mergecap** knows
how to read **pcap** and **pcapng** capture files, including those of
**tcpdump**, **Wireshark** and other tools that write captures in those
formats.

By default, **Mergecap** writes the capture file in **pcapng** format, and
writes all of the packets from the input capture files to the output file.

**Mergecap** is able to detect, read and write the same capture files that
are supported by **Wireshark**.
The input files don't need a specific filename extension; the file
format and an optional gzip compression will be automatically detected.
Near the beginning of the \s-1DESCRIPTION\s0 section of **wireshark**\|(1) or
&lt;https://www.wireshark.org/docs/man-pages/wireshark.html&gt;
is a detailed description of the way **Wireshark** handles this, which is
the same way **Mergecap** handles this.

**Mergecap** can write the file in several output formats.
The **-F** flag can be used to specify the format in which to write the
capture file, **mergecap -F** provides a list of the available output
formats.

Packets from the input files are merged in chronological order based on
each frame's timestamp, unless the **-a** flag is specified.  **Mergecap**
assumes that frames within a single capture file are already stored in
chronological order.  When the **-a** flag is specified, packets are
copied directly from each input file to the output file, independent of
each frame's timestamp.

The output file frame encapsulation type is set to the type of the input
files if all input files have the same type.  If not all of the input
files have the same frame encapsulation type, the output file type is
set to \s-1WTAP_ENCAP_PER_PACKET.\s0  Note that some capture file formats, most
notably **pcap**, do not currently support \s-1WTAP_ENCAP_PER_PACKET.\s0
This combination will cause the output file creation to fail.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -a  
  .IX Item "-a"
  Causes the frame timestamps to be ignored, writing all packets from the
  first input file followed by all packets from the second input file.  By
  default, when **-a** is not specified, the contents of the input files
  are merged in chronological order based on each frame's timestamp.
  .Sp
  Note: when merging, **mergecap** assumes that packets within a capture
  file are already in chronological order.
* -F  &lt;file format&gt;  
  .IX Item "-F &lt;file format&gt;"
  Sets the file format of the output capture file. **Mergecap** can write
  the file in several formats; **mergecap -F** provides a list of the
  available output formats.  By default this is the **pcapng** format.
* -h  
  .IX Item "-h"
  Prints the version and options and exits.
* -I  &lt;\s-1IDB\s0 merge mode&gt;  
  .IX Item "-I &lt;IDB merge mode&gt;"
  Sets the Interface Description Block (\s-1IDB\s0) merge mode to use during merging.
  **mergecap -I** provides a list of the available \s-1IDB\s0 merge modes.
  .Sp
  Every input file has one or more IDBs, which describe the interface(s) the
  capture was performed on originally. This includes encapsulation type,
  interface name, etc. When mergecap merges multiple input files, it has to
  merge these IDBs somehow for the new merged output file. This flag controls
  how that is accomplished. The currently available modes are:
      .Sp
          **none**: No merging of IDBs is performed, and instead all IDBs are
          copied to the merged output file.
      .Sp
          **all**: IDBs are merged only if all input files have the same number
          of IDBs, and each \s-1IDB\s0 matches their respective entry in the
          other files. This is the default mode.
      .Sp
          **any**: Any and all duplicate IDBs are merged into one \s-1IDB,\s0 regardless
          of what file they are in.
      .Sp
      Note that an \s-1IDB\s0 is only considered a matching duplicate if it has the same
      encapsulation type, name, speed, time precision, comments, description, etc.
* -s  &lt;snaplen&gt;  
  .IX Item "-s &lt;snaplen&gt;"
  Sets the snapshot length to use when writing the data.
  If the **-s** flag is used to specify a snapshot length, frames in the
  input file with more captured data than the specified snapshot length
  will have only the amount of data specified by the snapshot length
  written to the output file.  This may be useful if the program that is
  to read the output file cannot handle packets larger than a certain size
  (for example, the versions of snoop in Solaris 2.5.1 and Solaris 2.6
  appear to reject Ethernet frames larger than the standard Ethernet \s-1MTU,\s0
  making them incapable of handling gigabit Ethernet captures if jumbo
  frames were used).
* -v  
  .IX Item "-v"
  Causes **mergecap** to print a number of messages while it's working.
* -V  
  .IX Item "-V"
  Print the version and exit.
* -w  &lt;outfile&gt;|-  
  .IX Item "-w &lt;outfile&gt;|-"
  Sets the output filename. If the name is '**-**', stdout will be used.
  This setting is mandatory.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To merge two capture files together into a third capture file, in which
the last packet of one file arrives 100 seconds before the first packet
of another file, use the following sequence of commands.

First, use:

.Vb 1
    capinfos -aeS a.pcap b.pcap
.Ve

to determine the start and end times of the two capture files, as
seconds since January 1, 1970, 00:00:00 \s-1UTC.\s0

If a.pcap starts at 1009932757 and b.pcap ends at 873660281, then the
time adjustment to b.pcap that would make it end 100 seconds before
a.pcap begins would be 1009932757 - 873660281 - 100 = 136272376 seconds.

Thus, the next step would be to use:

.Vb 1
    editcap -t 136272376 b.pcap b-shifted.pcap
.Ve

to generate a version of b.pcap with its time stamps shifted 136272376
ahead.

Then the final step would be to use :

.Vb 1
    mergecap -w compare.pcap a.pcap b-shifted.pcap
.Ve

to merge a.pcap and the shifted b.pcap into compare.pcap.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pcap**\|(3), **wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **editcap**\|(1), **text2pcap**\|(1),
**pcap-filter**\|(7) or **tcpdump**\|(8)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Mergecap** is based heavily upon **editcap** by Richard Sharpe
&lt;sharpe[\s-1AT\s0]ns.aus.com&gt; and Guy Harris &lt;guy[\s-1AT\s0]alum.mit.edu&gt;.

**Mergecap** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  -------- ------
  Scott Renfro             &lt;scott[AT]renfro.org&gt;


  Contributors
  ------------
  Bill Guyton              &lt;guyton[AT]bguyton.com&gt;
.Ve
