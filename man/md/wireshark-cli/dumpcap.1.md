# dumpcap(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

dumpcap - Dump network traffic

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" dumpcap [&nbsp;-a|--autostop&nbsp;<capture&nbsp;autostop&nbsp;condition>&nbsp;]&nbsp;... [&nbsp;-b|--ring-buffer&nbsp;<capture&nbsp;ring&nbsp;buffer&nbsp;option>]&nbsp;... [&nbsp;-B|--buffer-size&nbsp;<capture&nbsp;buffer&nbsp;size>&nbsp;]&nbsp; [&nbsp;-c&nbsp;<capture&nbsp;packet&nbsp;count>&nbsp;] [&nbsp;-C&nbsp;<byte&nbsp;limit>&nbsp;] [&nbsp;-d&nbsp;] [&nbsp;-D|--list-interfaces&nbsp;] [&nbsp;-f&nbsp;<capture&nbsp;filter>&nbsp;] [&nbsp;-g&nbsp;] [&nbsp;-h|--help&nbsp;] [&nbsp;-i|--interface&nbsp;<capture&nbsp;interface>|rpcap://<host>:<port>/<capture&nbsp;interface>|TCP@<host>:<port>|-&nbsp;] [&nbsp;-I|--monitor-mode&nbsp;] [&nbsp;-k&nbsp;<freq>,[<type>],[<center_freq1>],[<center_freq2>] [&nbsp;-L|--list-data-link-types&nbsp;] [&nbsp;-M&nbsp;] [&nbsp;-n&nbsp;] [&nbsp;-N&nbsp;<packet&nbsp;limit>&nbsp;] [&nbsp;-p|--no-promiscuous-mode&nbsp;] [&nbsp;-P&nbsp;] [&nbsp;-q&nbsp;] [&nbsp;-s|--snapshot-length&nbsp;<capture&nbsp;snaplen>&nbsp;] [&nbsp;-S&nbsp;] [&nbsp;-t&nbsp;] [&nbsp;-v|--version&nbsp;] [&nbsp;-w&nbsp;<outfile>&nbsp;] [&nbsp;-y|--linktype&nbsp;<capture&nbsp;link&nbsp;type>&nbsp;] [&nbsp;--capture-comment&nbsp;<comment>&nbsp;] [&nbsp;--list-time-stamp-types&nbsp;] [&nbsp;--time-stamp-type&nbsp;<type>&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Dumpcap** is a network traffic dump tool.  It lets you capture packet
data from a live network and write the packets to a file.  **Dumpcap**'s
default capture file format is **pcapng** format.
When the **-P** option is specified, the output file is written in the
**pcap** format.

Without any options set it will use the libpcap, Npcap, or WinPcap library to
capture traffic from the first available network interface and writes
the received raw packet data, along with the packets' time stamps into a
pcap file.

If the **-w** option is not specified, **Dumpcap** writes to a newly
created pcap file with a randomly chosen name.
If the **-w** option is specified, **Dumpcap** writes to the file
specified by that option.

Packet capturing is performed with the pcap library.  The capture filter
syntax follows the rules of the pcap library.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -a|--autostop  &lt;capture autostop condition&gt;  
  .IX Item "-a|--autostop &lt;capture autostop condition&gt;"
  Specify a criterion that specifies when **Dumpcap** is to stop writing
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
  _value_ kB. If this option is used together with the -b option, dumpcap will
  stop writing to the current capture file and switch to the next one if filesize
  is reached.  Note that the filesize is limited to a maximum value of 2 GiB.
  .Sp
  **packets**:_value_ Stop writing to a capture file after _value_ packets
  have been written. Same as **-c** &lt;capture packet count&gt;.
* -b|--ring-buffer  &lt;capture ring buffer option&gt;  
  .IX Item "-b|--ring-buffer &lt;capture ring buffer option&gt;"
  Cause **Dumpcap** to run in multiple files\*(R" mode.  In \*(L"multiple files\*(R" mode,
  **Dumpcap** will write to several capture files. When the first capture file
  fills up, **Dumpcap** will switch writing to the next file and so on.
  .Sp
  The created filenames are based on the filename given with the **-w** option,
  the number of the file and on the creation date and time,
  e.g. outfile_00001_20210714120117.pcap, outfile_00002_20210714120523.pcap, ...
  .Sp
  With the _files_ option it's also possible to form a ring buffer\*(R".
  This will fill up new files until the number of files specified,
  at which point **Dumpcap** will discard the data in the first file and start
  writing to that file and so on. If the _files_ option is not set,
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
  requires either **duration**, **interval** or **filesize** to be specified to
  control when to go to the next file.  It should be noted that each **-b**
  parameter takes exactly one criterion; to specify two criterion, each must be
  preceded by the **-b** option.
  .Sp
  **filesize**:_value_ switch to the next file after it reaches a size of
  _value_ kB.  Note that the filesize is limited to a maximum value of 2 GiB.
  .Sp
  **interval**:_value_ switch to the next file when the time is an exact
  multiple of _value_ seconds.  For example, use 3600 to switch to a new file
  every hour on the hour.
  .Sp
  **packets**:_value_ switch to the next file after it contains _value_
  packets.
  .Sp
  **printname**:_filename_ print the name of the most recently written file
  to _filename_ after the file is closed. _filename_ can be \f(CW`stdout\*(C' or \f(CW\*(C\`-\*(C'
  for standard output, or \f(CW`stderr\*(C' for standard error.
  .Sp
  Example: **-b filesize:1000 -b files:5** results in a ring buffer of five files
  of size one megabyte each.
* -B|--buffer-size  &lt;capture buffer size&gt;  
  .IX Item "-B|--buffer-size &lt;capture buffer size&gt;"
  Set capture buffer size (in MiB, default is 2 MiB).  This is used by
  the capture driver to buffer packet data until that data can be written
  to disk.  If you encounter packet drops while capturing, try to increase
  this size.  Note that, while **Dumpcap** attempts to set the buffer size
  to 2 MiB by default, and can be told to set it to a larger value, the
  system or interface on which you're capturing might silently limit the
  capture buffer size to a lower value or raise it to a higher value.
  .Sp
  This is available on \s-1UNIX\s0 systems with libpcap 1.0.0 or later and on
  Windows.  It is not available on \s-1UNIX\s0 systems with earlier versions of
  libpcap.
  .Sp
  This option can occur multiple times. If used before the first
  occurrence of the **-i** option, it sets the default capture buffer size.
  If used after an **-i** option, it sets the capture buffer size for
  the interface specified by the last **-i** option occurring before
  this option. If the capture buffer size is not set specifically,
  the default capture buffer size is used instead.
* -c  &lt;capture packet count&gt;  
  .IX Item "-c &lt;capture packet count&gt;"
  Set the maximum number of packets to read when capturing live
  data. Same as **-a packets:**&lt;capture packet count&gt;.
* -C  &lt;byte limit&gt;  
  .IX Item "-C &lt;byte limit&gt;"
  Limit the amount of memory in bytes used for storing captured packets
  in memory while processing it.
  If used in combination with the **-N** option, both limits will apply.
  Setting this limit will enable the usage of the separate thread per interface.
* -d  
  .IX Item "-d"
  Dump the code generated for the capture filter in a human-readable form,
  and exit.
* -D|--list-interfaces  
  .IX Item "-D|--list-interfaces"
  Print a list of the interfaces on which **Dumpcap** can capture, and
  exit.  For each network interface, a number and an
  interface name, possibly followed by a text description of the
  interface, is printed.  The interface name or the number can be supplied
  to the **-i** option to specify an interface on which to capture.
  .Sp
  This can be useful on systems that don't have a command to list them
  (\s-1UNIX\s0 systems lacking **ifconfig -a** or Linux systems lacking
  **ip link show**). The number can be useful on Windows systems, where
  the interface name might be a long name or a \s-1GUID.\s0
  .Sp
  Note that can capture\*(R" means that **Dumpcap** was able to open
  that device to do a live capture. Depending on your system you may need to
  run dumpcap from an account with special privileges (for example, as root)
  to be able to capture network traffic.
  If "**dumpcap -D**" is not run from such an account, it will not list
  any interfaces.
* -f  &lt;capture filter&gt;  
  .IX Item "-f &lt;capture filter&gt;"
  Set the capture filter expression.
  .Sp
  The entire filter expression must be specified as a single argument (which means
  that if it contains spaces, it must be quoted).
  .Sp
  This option can occur multiple times. If used before the first
  occurrence of the **-i** option, it sets the default capture filter expression.
  If used after an **-i** option, it sets the capture filter expression for
  the interface specified by the last **-i** option occurring before
  this option. If the capture filter expression is not set specifically,
  the default capture filter expression is used if provided.
  .Sp
  Pre-defined capture filter names, as shown in the \s-1GUI\s0 menu item Capture-&gt;Capture Filters,
  can be used by prefixing the argument with predef:\*(R".
  Example: **-f predef:MyPredefinedHostOnlyFilter\*(R"**
* -g  
  .IX Item "-g"
  This option causes the output file(s) to be created with group-read permission
  (meaning that the output file(s) can be read by other members of the calling
  user's group).
* -h|--help  
  .IX Item "-h|--help"
  Print the version and options and exits.
* -i|--interface  &lt;capture interface&gt;|rpcap://&lt;host&gt;:&lt;port&gt;/&lt;capture interface&gt;|TCP@&lt;host&gt;:&lt;port&gt;|-  
  .IX Item "-i|--interface &lt;capture interface&gt;|rpcap://&lt;host&gt;:&lt;port&gt;/&lt;capture interface&gt;|TCP@&lt;host&gt;:&lt;port&gt;|-"
  Set the name of the network interface or pipe to use for live packet
  capture.
  .Sp
  Network interface names should match one of the names listed in
  "**dumpcap -D** (described above); a number, as reported by
  **dumpcap -D**\*(L", can also be used.  If you're using \s-1UNIX, \*(R"\s0netstat
  -i, \*(R"**ifconfig -a**\*(L" or \*(R"**ip link**" might also work to list interface names,
  although not all versions of \s-1UNIX\s0 support the **-a** option to **ifconfig**.
  .Sp
  If no interface is specified, **Dumpcap** searches the list of
  interfaces, choosing the first non-loopback interface if there are any
  non-loopback interfaces, and choosing the first loopback interface if
  there are no non-loopback interfaces. If there are no interfaces at all,
  **Dumpcap** reports an error and doesn't start the capture.
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
  This option can occur multiple times. If used before the first
  occurrence of the **-i** option, it enables the monitor mode for all interfaces.
  If used after an **-i** option, it enables the monitor mode for
  the interface specified by the last **-i** option occurring before
  this option.
* -k  &lt;freq&gt;,[&lt;type&gt;],[&lt;center_freq1&gt;],[&lt;center_freq2&gt;&gt;  
  .IX Item "-k &lt;freq&gt;,[&lt;type&gt;],[&lt;center_freq1&gt;],[&lt;center_freq2&gt;&gt;"
  Set the channel on the interface; this is supported only on \s-1IEEE
  802.11\s0 Wi-Fi interfaces, and supported only on some operating systems.
  .Sp
  _freq_ is the frequency of the channel.  _type_ is the type of the
  channel, for 802.11n and 802.11ac.  The values for _type_ are
    * \s-1NOHT\s0  
      .IX Item "NOHT"
      Used for non-802.11n/non-802.1ac channels
    * \s-1HT20\s0  
      .IX Item "HT20"
      20 MHz channel
    * \s-1HT40-\s0  
      .IX Item "HT40-"
      40 MHz primary channel and a lower secondary channel
    * \s-1HT40+\s0  
      .IX Item "HT40+"
      40 MHz primary channel and a higher secondary channel
    * \s-1HT80\s0  
      .IX Item "HT80"
      80 MHz channel, with _centerfreq1_ as its center frequency
    * \s-1VHT80+80\s0  
      .IX Item "VHT80+80"
      two 80 MHz channels combined, with _centerfreq1_ and _centerfreq2_ as
      the center frequencies of the two channels
    * \s-1VHT160\s0  
      .IX Item "VHT160"
      160 MHz channel, with _centerfreq1_ as its center frequency
* -L|--list-data-link-types  
  .IX Item "-L|--list-data-link-types"
  List the data link types supported by the interface and exit. The reported
  link types can be used for the **-y** option.
* -M  
  .IX Item "-M"
  When used with **-D**, **-L**, **-S** or **--list-time-stamp-types** print
  machine-readable output.
  The machine-readable output is intended to be read by **Wireshark** and
  **TShark**; its format is subject to change from release to release.
* -n  
  .IX Item "-n"
  Save files as pcapng. This is the default.
* -N  &lt;packet limit&gt;  
  .IX Item "-N &lt;packet limit&gt;"
  Limit the number of packets used for storing captured packets
  in memory while processing it.
  If used in combination with the **-C** option, both limits will apply.
  Setting this limit will enable the usage of the separate thread per interface.
* -p|--no-promiscuous-mode  
  .IX Item "-p|--no-promiscuous-mode"
  _Don't_ put the interface into promiscuous mode.  Note that the
  interface might be in promiscuous mode for some other reason; hence,
  **-p** cannot be used to ensure that the only traffic that is captured is
  traffic sent to or from the machine on which **Dumpcap** is running,
  broadcast traffic, and multicast traffic to addresses received by that
  machine.
  .Sp
  This option can occur multiple times. If used before the first
  occurrence of the **-i** option, no interface will be put into the
  promiscuous mode.
  If used after an **-i** option, the interface specified by the last **-i**
  option occurring before this option will not be put into the
  promiscuous mode.
* -P  
  .IX Item "-P"
  Save files as pcap instead of the default pcapng. In situations that require
  pcapng, such as capturing from multiple interfaces, this option will be
  overridden.
* -q  
  .IX Item "-q"
  When capturing packets, don't display the continuous count of packets
  captured that is normally shown when saving a capture to a file;
  instead, just display, at the end of the capture, a count of packets
  captured.  On systems that support the \s-1SIGINFO\s0 signal, such as various
  BSDs, you can cause the current count to be displayed by typing your
  status\*(R" character (typically control-T, although it
  might be set to disabled\*(R" by default on at least some BSDs, so you'd
  have to explicitly set it to use it).
* -s|--snapshot-length  &lt;capture snaplen&gt;  
  .IX Item "-s|--snapshot-length &lt;capture snaplen&gt;"
  Set the default snapshot length to use when capturing live data.
  No more than _snaplen_ bytes of each network packet will be read into
  memory, or saved to disk.  A value of 0 specifies a snapshot length of
  262144, so that the full packet is captured; this is the default.
  .Sp
  This option can occur multiple times. If used before the first
  occurrence of the **-i** option, it sets the default snapshot length.
  If used after an **-i** option, it sets the snapshot length for
  the interface specified by the last **-i** option occurring before
  this option. If the snapshot length is not set specifically,
  the default snapshot length is used if provided.
* -S  
  .IX Item "-S"
  Print statistics for each interface once every second.
* -t  
  .IX Item "-t"
  Use a separate thread per interface.
* -v|--version  
  .IX Item "-v|--version"
  Print the version and exit.
* -w  &lt;outfile&gt;  
  .IX Item "-w &lt;outfile&gt;"
  Write raw packet data to _outfile_. Use -\*(R" for stdout.
* -y|--linktype  &lt;capture link type&gt;  
  .IX Item "-y|--linktype &lt;capture link type&gt;"
  Set the data link type to use while capturing packets.  The values
  reported by **-L** are the values that can be used.
  .Sp
  This option can occur multiple times. If used before the first
  occurrence of the **-i** option, it sets the default capture link type.
  If used after an **-i** option, it sets the capture link type for
  the interface specified by the last **-i** option occurring before
  this option. If the capture link type is not set specifically,
  the default capture link type is used if provided.
* --capture-comment  &lt;comment&gt;  
  .IX Item "--capture-comment &lt;comment&gt;"
  Add a capture comment to the output file.
  .Sp
  This option is only available if we output the captured packets to a
  single file in pcapng format. Only one capture comment may be set per
  output file.
* --list-time-stamp-types  
  .IX Item "--list-time-stamp-types"
  List time stamp types supported for the interface. If no time stamp type can be
  set, no time stamp types are listed.
* --time-stamp-type  &lt;type&gt;  
  .IX Item "--time-stamp-type &lt;type&gt;"
  Change the interface's timestamp method.

<a name="capture-filter-syntax"></a>

# Capture Filter Syntax

.IX Header "CAPTURE FILTER SYNTAX"
See the manual page of **pcap-filter**\|(7) or, if that doesn't exist, **tcpdump**\|(8),
or, if that doesn't exist, &lt;https://gitlab.com/wireshark/wireshark/-/wikis/CaptureFilters&gt;.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **editcap**\|(1), **mergecap**\|(1), **capinfos**\|(1), **pcap**\|(3),
**pcap-filter**\|(7) or **tcpdump**\|(8)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Dumpcap** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
**Dumpcap** is derived from the **Wireshark** capturing engine code;
see the list of
authors in the **Wireshark** man page for a list of authors of that code.
