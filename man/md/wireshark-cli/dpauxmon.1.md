# dpauxmon(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

dpauxmon - Provide interfaces to capture DisplayPort AUX channel data.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" dpauxmon [&nbsp;--help&nbsp;] [&nbsp;--version&nbsp;] [&nbsp;--extcap-interfaces&nbsp;] [&nbsp;--extcap-dlts&nbsp;] [&nbsp;--extcap-interface=<interface>&nbsp;] [&nbsp;--extcap-config&nbsp;] [&nbsp;--extcap-capture-filter=<capture&nbsp;filter>&nbsp;] [&nbsp;--capture&nbsp;] [&nbsp;--fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe>&nbsp;] [&nbsp;--interface_id=<Interface&nbsp;\s-1ID\s0&nbsp;to&nbsp;capture>&nbsp;] 
 dpauxmon --extcap-interfaces 
 dpauxmon --extcap-interface=<interface> --extcap-dlts 
 dpauxmon --extcap-interface=<interface> --extcap-config 
 dpauxmon --extcap-interface=<interface> --fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe> --capture --interface_id=interface_id
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**dpauxmon** is an extcap tool that can capture DisplayPort \s-1AUX\s0 channel data
from linux kernel drivers using the generic netlink interface.

Supported interfaces:

* 1. dpauxmon  
  .IX Item "1. dpauxmon"

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
  Start capturing from specified interface and save it in place specified by --fifo.
* --fifo=&lt;path to file or pipe&gt;  
  .IX Item "--fifo=&lt;path to file or pipe&gt;"
  Save captured packet to file or send it through pipe.
* --interface_idt=&lt;interface id&gt;  
  .IX Item "--interface_idt=&lt;interface id&gt;"
  The interface for capture.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see program arguments:

.Vb 1
    dpauxmon --help
.Ve

To see program version:

.Vb 1
    dpauxmon --version
.Ve

To see interfaces:

.Vb 1
    dpauxmon --extcap-interfaces
.Ve

Only one interface (dpauxmon) is supported.

.Vb 2
  Output:
    interface {value=dpauxmon}{display=DisplayPort AUX channel capture}
.Ve

To see interface DLTs:

.Vb 1
    dpauxmon --extcap-interface=dpauxmon --extcap-dlts

  Output:
    dlt {number=275}{name=dpauxmon}{display=DisplayPort AUX channel monitor DLT}
.Ve

To see interface configuration options:

.Vb 1
    dpauxmon --extcap-interface=dpauxmon --extcap-config

  Output:
    dpauxmon --extcap-interface=dpauxmon --extcap-config
    arg {number=0}{call=--interface_id}{display=Interface Id}
        {type=unsigned}{tooltip=The Interface Id}
        {required=true}
.Ve

To capture:

.Vb 1
    dpauxmon --extcap-interface=dpauxmon --fifo=/tmp/dpauxmon.pcap --capture --interface_id 0
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **extcap**\|(4)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**dpauxmon** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  -------- ------
  Dirk Eibach             &lt;dirk.eibach[AT]gdsys.cc&gt;
.Ve
