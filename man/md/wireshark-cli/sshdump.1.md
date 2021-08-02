# sshdump(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

sshdump - Provide interfaces to capture from a remote host through SSH using a remote capture binary.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" sshdump [&nbsp;--help&nbsp;] [&nbsp;--version&nbsp;] [&nbsp;--extcap-interfaces&nbsp;] [&nbsp;--extcap-dlts&nbsp;] [&nbsp;--extcap-interface=<interface>&nbsp;] [&nbsp;--extcap-config&nbsp;] [&nbsp;--extcap-capture-filter=<capture&nbsp;filter>&nbsp;] [&nbsp;--capture&nbsp;] [&nbsp;--fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe>&nbsp;] [&nbsp;--remote-host=<\s-1IP\s0&nbsp;address>&nbsp;] [&nbsp;--remote-port=<\s-1TCP\s0&nbsp;port>&nbsp;] [&nbsp;--remote-username=<username>&nbsp;] [&nbsp;--remote-password=<password>&nbsp;] [&nbsp;--sshkey=<public&nbsp;key&nbsp;path<gt ]> [&nbsp;--remote-interface=<interface>&nbsp;] [&nbsp;--remote-capture-command=<capture&nbsp;command>&nbsp;] [&nbsp;--remote-sudo&nbsp;] 
 sshdump --extcap-interfaces 
 sshdump --extcap-interface=<interface> --extcap-dlts 
 sshdump --extcap-interface=<interface> --extcap-config 
 sshdump --extcap-interface=<interface> --fifo=<path&nbsp;to&nbsp;file&nbsp;or&nbsp;pipe> --capture --remote-host=myremotehost --remote-port=22 --remote-username=user --remote-interface=eth2 --remote-capture-command='tcpdump&nbsp;-U&nbsp;-i&nbsp;eth0&nbsp;-w-'
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Sshdump** is an extcap tool that allows one to run a remote capture
tool over a \s-1SSH\s0 connection. The requirement is that the capture
executable must have the capabilities to capture from the wanted
interface.

The feature is functionally equivalent to run commands like

.Vb 2
    $ ssh remoteuser@remotehost -p 22222 tcpdump -U -i IFACE -w -\*(Aq &gt; FILE &
    $ wireshark FILE

    $ ssh remoteuser@remotehost /sbin/dumpcap -i IFACE -P -w - -f "not port 22"\*(Aq &gt; FILE &
    $ wireshark FILE

    $ ssh somehost dumpcap -P -w - -f udp | tshark -i -
.Ve

Typically sshdump is not invoked directly. Instead it can be configured through
the Wireshark graphical user interface or its command line. The following will
start Wireshark and start capturing from host **remotehost**:

.Vb 1
    $ wireshark -oextcap.sshdump.remotehost:"remotehost"\*(Aq -i sshdump -k
.Ve

To explicitly control the remote capture command:

.Vb 3
    $ wireshark -oextcap.sshdump.remotehost:"remotehost"\*(Aq \e
                -oextcap.sshdump.remotecapturecommand:"tcpdump -i eth0 -Uw- not port 22"\*(Aq \e
                -i sshdump -k
.Ve

Supported interfaces:

* 1. ssh  
  .IX Item "1. ssh"

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
* --sshkey=&lt;\s-1SSH\s0 private key path&gt;  
  .IX Item "--sshkey=&lt;SSH private key path&gt;"
  The path to a private key for authentication.
* --remote-interface=&lt;remote interface&gt;  
  .IX Item "--remote-interface=&lt;remote interface&gt;"
  The remote network interface to capture from.
* --remote-capture-command=&lt;capture command&gt;  
  .IX Item "--remote-capture-command=&lt;capture command&gt;"
  A custom remote capture command that produces the remote stream that is shown in Wireshark.
  The command must be able to produce a \s-1PCAP\s0 stream written to \s-1STDOUT.\s0 See below for more
  examples.
  .Sp
  If using tcpdump, use the **-w-** option to ensure that packets are written to
  standard output (stdout). Include the **-U** option to write packets as soon as
  they are received.
  .Sp
  When specified, this command will be used as is, options such as the capture
  filter (**--extcap-capture-filter**) will not be appended.
* --extcap-capture-filter=&lt;capture filter&gt;  
  .IX Item "--extcap-capture-filter=&lt;capture filter&gt;"
  The capture filter. It corresponds to the value provided via the **tshark -f**
  option, and the Capture Filter field next to the interfaces list in the
  Wireshark interface.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see program arguments:

.Vb 1
    sshdump --help
.Ve

To see program version:

.Vb 1
    sshdump --version
.Ve

To see interfaces:

.Vb 1
    sshdump --extcap-interfaces
.Ve

Only one interface (sshdump) is supported.

.Vb 2
  Output:
    interface {value=sshdump}{display=SSH remote capture}
.Ve

To see interface DLTs:

.Vb 1
    sshdump --extcap-interface=sshdump --extcap-dlts

  Output:
    dlt {number=147}{name=sshdump}{display=Remote capture dependent DLT}
.Ve

To see interface configuration options:

.Vb 1
    sshdump --extcap-interface=sshdump --extcap-config

  Output:

    arg {number=0}{call=--remote-host}{display=Remote SSH server address}{type=string}
        {tooltip=The remote SSH host. It can be both an IP address or a hostname}{required=true}{group=Server}
    arg {number=1}{call=--remote-port}{display=Remote SSH server port}{type=unsigned}
        {tooltip=The remote SSH host port (1-65535)}{range=1,65535}{group=Server}
    arg {number=2}{call=--remote-username}{display=Remote SSH server username}{type=string}
        {tooltip=The remote SSH username. If not provided, the current user will be used}{group=Authentication}
    arg {number=3}{call=--remote-password}{display=Remote SSH server password}{type=password}
        {tooltip=The SSH password, used when other methods (SSH agent or key files) are unavailable.}{group=Authentication}
    arg {number=4}{call=--sshkey}{display=Path to SSH private key}{type=fileselect}
        {tooltip=The path on the local filesystem of the private ssh key}{group=Authentication}
    arg {number=5}{call=--sshkey-passphrase}{display=SSH key passphrase}{type=password}
        {tooltip=Passphrase to unlock the SSH private key}{group=Authentication}
    arg {number=6}{call=--proxycommand}{display=ProxyCommand}{type=string}
        {tooltip=The command to use as proxy for the SSH connection}{group=Authentication}
    arg {number=7}{call=--remote-interface}{display=Remote interface}{type=string}
        {tooltip=The remote network interface used for capture}{group=Capture}
    arg {number=8}{call=--remote-capture-command}{display=Remote capture command}{type=string}
        {tooltip=The remote command used to capture}{group=Capture}
    arg {number=9}{call=--remote-sudo}{display=Use sudo on the remote machine}{type=boolean}
        {tooltip=Prepend the capture command with sudo on the remote machine}{group=Capture}
    arg {number=10}{call=--remote-noprom}{display=No promiscuous mode}{type=boolflag}
        {tooltip=Dont use promiscuous mode on the remote machine}{group=Capture}
    arg {number=11}{call=--remote-filter}{display=Remote capture filter}{type=string}
        {tooltip=The remote capture filter}{default=not ((host myhost) and port 22)}{group=Capture}
    arg {number=12}{call=--remote-count}{display=Packets to capture}{type=unsigned}{default=0}
        {tooltip=The number of remote packets to capture. (Default: inf)}{group=Capture}
    arg {number=13}{call=--debug}{display=Run in debug mode}{type=boolflag}{default=false}
        {tooltip=Print debug messages}{required=false}{group=Debug}
    arg {number=14}{call=--debug-file}{display=Use a file for debug}{type=string}
        {tooltip=Set a file where the debug messages are written}{required=false}{group=Debug}
.Ve

To capture:

.Vb 2
    sshdump --extcap-interface=sshdump --fifo=/tmp/ssh.pcap --capture --remote-host 192.168.1.10
    --remote-username user --remote-filter "not port 22"
.Ve

To use different capture binaries:

.Vb 2
    sshdump --extcap-interface=sshdump --fifo=/tmp/ssh.pcap --capture --remote-host 192.168.1.10
    --remote-capture-command=dumpcap -i eth0 -P -w -\*(Aq

    sshdump --extcap-interface=sshdump --fifo=/tmp/ssh.pcap --capture --remote-host 192.168.1.10
    --remote-capture-command=sudo tcpdump -i eth0 -U -w -\*(Aq
.Ve

\s-1NOTE:\s0 To stop capturing CTRL+C/kill/terminate application.

The sshdump binary can be renamed to support multiple instances. For instance if we want sshdump
to show up twice in wireshark (for instance to handle multiple profiles), we can copy sshdump to
sshdump-host1 and sshdump-host2. Each binary will show up an interface name same as the executable
name. Those executables not being sshdump\*(R" will show up as \*(L"custom version\*(R" in the interface description.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **extcap**\|(4), **tcpdump**\|(1)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Sshdump** is part of the **Wireshark** distribution.  The latest version
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
