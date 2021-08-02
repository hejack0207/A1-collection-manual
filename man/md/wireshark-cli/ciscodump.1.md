# ciscodump(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

ciscodump - Provide interfaces to capture from a remote Cisco router through SSH.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" ciscodump [&nbsp;--help&nbsp;] [&nbsp;--version&nbsp;] [&nbsp;--extcap-interfaces&nbsp;] [&nbsp;--extcap-dlts&nbsp;] [&nbsp;--extcap-interface=<interface>&nbsp;] [&nbsp;--extcap-config&nbsp;] [&nbsp;--extcap-capture-filter=<capture&nbsp;filter>&nbsp;] [&nbsp;--capture&nbsp;] [&nbsp;--fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe>&nbsp;] [&nbsp;--remote-host=<\s-1IP\s0&nbsp;address>&nbsp;] [&nbsp;--remote-port=<\s-1TCP\s0&nbsp;port>&nbsp;] [&nbsp;--remote-username=<username>&nbsp;] [&nbsp;--remote-password=<password>&nbsp;] [&nbsp;--remote-filter=<filter<gt ]> [&nbsp;--sshkey=<public&nbsp;key&nbsp;path<gt ]> [&nbsp;--remote-interface=<interface>&nbsp;] 
 ciscodump --extcap-interfaces 
 ciscodump --extcap-interface=<interface> --extcap-dlts 
 ciscodump --extcap-interface=<interface> --extcap-config 
 ciscodump --extcap-interface=<interface> --fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe> --capture --remote-host=remoterouter --remote-port=22 --remote-username=user --remote-interface=<the&nbsp;router&nbsp;interface>
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Ciscodump** is an extcap tool that relies on Cisco \s-1EPC\s0 to allow a user to run a remote capture
on a Cisco router in a \s-1SSH\s0 connection. The minimum \s-1IOS\s0 version supporting this feature is 12.4(20)T. More details can be
found here:
https://www.cisco.com/c/en/us/products/collateral/ios-nx-os-software/ios-embedded-packet-capture/datasheet_c78-502727.html

Supported interfaces:

* 1. cisco  
  .IX Item "1. cisco"

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
* --remote-host=&lt;remote host&gt;  
  .IX Item "--remote-host=&lt;remote host&gt;"
  The address of the remote host for capture.
* --remote-port=&lt;remote port&gt;  
  .IX Item "--remote-port=&lt;remote port&gt;"
  The \s-1SSH\s0 port of the remote host.
* --remote-username=&lt;username&gt;  
  .IX Item "--remote-username=&lt;username&gt;"
  The username for ssh authentication.
* --remote-password=&lt;password&gt;  
  .IX Item "--remote-password=&lt;password&gt;"
  The password to use (if not ssh-agent and pubkey are used). \s-1WARNING:\s0 the
  passwords are stored in plaintext and visible to all users on this system. It is
  recommended to use keyfiles with a \s-1SSH\s0 agent.
* --remote-filter=&lt;filter&gt;  
  .IX Item "--remote-filter=&lt;filter&gt;"
  The remote filter on the router. This is a capture filter that follows the Cisco
  \s-1IOS\s0 standards
  (https://www.cisco.com/c/en/us/support/docs/ip/access-lists/26448-ACLsamples.html).
  Multiple filters can be specified using a comma between them. \s-1BEWARE:\s0 when using
  a filter, the default behavior is to drop all the packets except the ones that
  fall into the filter.
  .Sp
  Examples:
  .Sp
  .Vb 1
      permit ip host MYHOST any, permit ip any host MYHOST (capture the traffic for MYHOST)
  
      deny ip host MYHOST any, deny ip any host MYHOST, permit ip any any (capture all the traffic except MYHOST)
  .Ve
* --sshkey=&lt;\s-1SSH\s0 private key path&gt;  
  .IX Item "--sshkey=&lt;SSH private key path&gt;"
  The path to a private key for authentication.
* --remote-interface=&lt;remote interface&gt;  
  .IX Item "--remote-interface=&lt;remote interface&gt;"
  The remote network interface to capture from.
* --extcap-capture-filter=&lt;capture filter&gt;  
  .IX Item "--extcap-capture-filter=&lt;capture filter&gt;"
  Unused (compatibility only).

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see program arguments:

.Vb 1
    ciscodump --help
.Ve

To see program version:

.Vb 1
    ciscodump --version
.Ve

To see interfaces:

.Vb 1
    ciscodump --extcap-interfaces
.Ve

Only one interface (cisco) is supported.

.Vb 2
  Output:
    interface {value=cisco}{display=SSH remote capture}
.Ve

To see interface DLTs:

.Vb 1
    ciscodump --extcap-interface=cisco --extcap-dlts

  Output:
    dlt {number=147}{name=cisco}{display=Remote capture dependent DLT}
.Ve

To see interface configuration options:

.Vb 1
    ciscodump --extcap-interface=cisco --extcap-config

  Output:
    ciscodump --extcap-interface=cisco --extcap-config
    arg {number=0}{call=--remote-host}{display=Remote SSH server address}
        {type=string}{tooltip=The remote SSH host. It can be both an IP address or a hostname}
        {required=true}
    arg {number=1}{call=--remote-port}{display=Remote SSH server port}{type=unsigned}
        {default=22}{tooltip=The remote SSH host port (1-65535)}{range=1,65535}
    arg {number=2}{call=--remote-username}{display=Remote SSH server username}{type=string}
        {default=&lt;current user&gt;}{tooltip=The remote SSH username. If not provided, the current
        user will be used}
    arg {number=3}{call=--remote-password}{display=Remote SSH server password}{type=string}
        {tooltip=The SSH password, used when other methods (SSH agent or key files) are unavailable.}
    arg {number=4}{call=--sshkey}{display=Path to SSH private key}{type=fileselect}
        {tooltip=The path on the local filesystem of the private ssh key}
    arg {number=5}{call--sshkey-passphrase}{display=SSH key passphrase}
        {type=string}{tooltip=Passphrase to unlock the SSH private key}
    arg {number=6}{call=--remote-interface}{display=Remote interface}{type=string}
        {required=true}{tooltip=The remote network interface used for capture}
    arg {number=7}{call=--remote-filter}{display=Remote capture filter}{type=string}
        {default=(null)}{tooltip=The remote capture filter}
    arg {number=8}{call=--remote-count}{display=Packets to capture}{type=unsigned}{required=true}
        {tooltip=The number of remote packets to capture.}
.Ve

To capture:

.Vb 3
    ciscodump --extcap-interface cisco --fifo=/tmp/cisco.pcap --capture --remote-host 192.168.1.10
        --remote-username user --remote-interface gigabit0/0
        --remote-filter "permit ip host 192.168.1.1 any, permit ip any host 192.168.1.1"
.Ve

\s-1NOTE:\s0 Packet count is mandatory, hence the capture will start after this number.

<a name="known-issues"></a>

# Known Issues

.IX Header "KNOWN ISSUES"
The configuration of the capture on the routers is a multi-step process. If the \s-1SSH\s0 connection is interrupted during
it, the configuration can be in an inconsistent state. That can happen also if the capture is stopped and ciscodump
can't clean the configuration up. In this case it is necessary to log into the router and manually clean the
configuration, removing both the capture point (\s-1WIRESHARK_CAPTURE_POINT\s0), the capture buffer (\s-1WIRESHARK_CAPTURE_BUFFER\s0)
and the capture filter (\s-1WIRESHARK_CAPTURE_FILTER\s0).

Another known issues is related to the number of captured packets (--remote-count). Due to the nature of the capture
buffer, ciscodump waits for the capture to complete and then issues the command to show it. It means that if the user
specifies a number of packets above the currently captured, the show command is never shown. Not only is the count of
the maximum number of captured packets, but it is also the _exact_ number of expected packets.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **extcap**\|(4), **sshdump**\|(1)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**ciscodump** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  -------- ------
  Dario Lombardo             &lt;lomato[AT]gmail.com&gt;
.Ve
