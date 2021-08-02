# sdjournal(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

sdjournal - Provide an interface to capture systemd journal entries.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" sdjournal [&nbsp;--help&nbsp;] [&nbsp;--version&nbsp;] [&nbsp;--extcap-interfaces&nbsp;] [&nbsp;--extcap-dlts&nbsp;] [&nbsp;--extcap-interface=<interface>&nbsp;] [&nbsp;--extcap-config&nbsp;] [&nbsp;--capture&nbsp;] [&nbsp;--fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe>&nbsp;] [&nbsp;--start-from=<entry&nbsp;count>&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**sdjournal** is an extcap tool that allows one to capture systemd
journal entries. It can be used to correlate system events with
network traffic.

Supported interfaces:

* 1. sdjournal  
  .IX Item "1. sdjournal"

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
  Start capturing from specified interface and write raw packet data to the location specified by --fifo.
* --fifo=&lt;path to file or pipe&gt;  
  .IX Item "--fifo=&lt;path to file or pipe&gt;"
  Save captured packet to file or send it through pipe.
* --start-from=&lt;entry count&gt;  
  .IX Item "--start-from=&lt;entry count&gt;"
  Start from the last &lt;entry count&gt; entries, similar to the
  -n\*(R" or \*(L"--lines\*(R" argument for the **tail**\|(1) command. Values prefixed
  with a **+** sign start from the beginning of the journal, otherwise
  the count starts from the end. The default value is 10. To include
  all entries use **+0**.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see program arguments:

.Vb 1
    sdjournal --help
.Ve

To see program version:

.Vb 1
    sdjournal --version
.Ve

To see interfaces:

.Vb 1
    sdjournal --extcap-interfaces
.Ve

Only one interface (sdjournal) is supported.

.Vb 2
  Output:
    interface {value=sdjournal}{display=systemd journal capture}
.Ve

To see interface DLTs:

.Vb 1
    sdjournal --extcap-interface=sdjournal --extcap-dlts

  Output:
    dlt {number=147}{name=sdjournal}{display=USER0}
.Ve

To see interface configuration options:

.Vb 1
    sdjournal --extcap-interface=sdjournal --extcap-config

  Output:

    arg {number=0}{call=--start-from}{display=Starting position}{type=string}
        {tooltip=The journal starting position. Values with a leading "+" start from the beginning, similar to the "tail" command}
.Ve

To capture:

.Vb 1
    sdjournal --extcap-interface=sdjournal --fifo=/tmp/sdjournal.pcap --capture
.Ve

To capture all entries since the system was booted:

.Vb 1
    sdjournal --extcap-interface=sdjournal --fifo=/tmp/sdjournal.pcap --capture --start-from +0
.Ve

\s-1NOTE:\s0 To stop capturing CTRL+C/kill/terminate application.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **extcap**\|(4), **tcpdump**\|(1)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**sdjournal** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  -------- ------
  Gerald Combs             &lt;gerald[AT]wireshark.org&gt;
.Ve
