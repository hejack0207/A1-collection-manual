# ntpdc(8)

4.2.8p15, 23 Jun 2020

-Font]ntpdc
- vendor-specific NTPD control program

<a name="synopsis"></a>

# Synopsis

```
\fB-Font]ntpdc
</synopsis>

<synopsis>
[\fB-Font]-flags\f[]] [\fB-Font]-flag\f[] [\f\*[I-Font]value\f[]]] [\fB-Font]--option-name\f[][[=| ]\f\*[I-Font]value\f[]]] [ host ...] 
 .ne 2
```


<a name="description"></a>

# Description

-Font]ntpdc
is deprecated.
Please use
\fCntpq\f[](8)\f[] instead - it can do everything
-Font]ntpdc
used to do, and it does so using a much more sane interface.

.ne 2

-Font]ntpdc
is a utility program used to query
\fCntpd\f[](8)\f[]
about its
current state and to request changes in that state.
It uses NTP mode 7 control message formats described in the source code.
The program may
be run either in interactive mode or controlled using command line
arguments.
Extensive state and statistics information is available
through the
-Font]ntpdc
interface.
In addition, nearly all the
configuration options which can be specified at startup using
ntpd's configuration file may also be specified at run time using
-Font]ntpdc.

<a name="options"></a>

# Options


* .NOP -Font]-4\f[], \f\*[B-Font]--ipv4\f[]  
  Force IPv4 DNS name resolution.
  This option must not appear in combination with any of the following options:
  ipv6.

Force DNS resolution of following host names on the command line
to the IPv4 namespace.

* .NOP -Font]-6\f[], \f\*[B-Font]--ipv6\f[]  
  Force IPv6 DNS name resolution.
  This option must not appear in combination with any of the following options:
  ipv4.

Force DNS resolution of following host names on the command line
to the IPv6 namespace.

* .NOP -Font]-c\f[] \f\*[I-Font]cmd\f[], \f\*[B-Font]--command\f[]=\f\*[I-Font]cmd\f[]  
  run a command and exit.
  This option may appear an unlimited number of times.

The following argument is interpreted as an interactive format command
and is added to the list of commands to be executed on the specified
host(s).

* .NOP -Font]-d\f[], \f\*[B-Font]--debug-level\f[]  
  Increase debug verbosity level.
  This option may appear an unlimited number of times.


* .NOP -Font]-D\f[] \f\*[I-Font]number\f[], \f\*[B-Font]--set-debug-level\f[]=\f\*[I-Font]number\f[]  
  Set the debug verbosity level.
  This option may appear an unlimited number of times.
  This option takes an integer number as its argument.


* .NOP -Font]-i\f[], \f\*[B-Font]--interactive\f[]  
  Force ntpq to operate in interactive mode.
  This option must not appear in combination with any of the following options:
  command, listpeers, peers, showpeers.

Force ntpq to operate in interactive mode.  Prompts will be written
to the standard output and commands read from the standard input.

* .NOP -Font]-l\f[], \f\*[B-Font]--listpeers\f[]  
  Print a list of the peers.
  This option must not appear in combination with any of the following options:
  command.

Print a list of the peers known to the server as well as a summary of
their state. This is equivalent to the 'listpeers' interactive command.

* .NOP -Font]-n\f[], \f\*[B-Font]--numeric\f[]  
  numeric host addresses.

Output all host addresses in dotted-quad numeric format rather than
converting to the canonical host names. 

* .NOP -Font]-p\f[], \f\*[B-Font]--peers\f[]  
  Print a list of the peers.
  This option must not appear in combination with any of the following options:
  command.

Print a list of the peers known to the server as well as a summary
of their state. This is equivalent to the 'peers' interactive command.

* .NOP -Font]-s\f[], \f\*[B-Font]--showpeers\f[]  
  Show a list of the peers.
  This option must not appear in combination with any of the following options:
  command.

Print a list of the peers known to the server as well as a summary
of their state. This is equivalent to the 'dmpeers' interactive command.

* .NOP -Font]-?\f[], \f\*[B-Font]--help\f[]  
  Display usage information and exit.
* .NOP -Font]-!\f[], \f\*[B-Font]--more-help\f[]  
  Pass the extended usage information through a pager.
* .NOP -Font]-&gt;\f[] [\f\*[I-Font]cfgfile\f[]], \f\*[B-Font]--save-opts\f[] [=\f\*[I-Font]cfgfile\f[]]  
  Save the option state to _cfgfile_.  The default is the _last_
  configuration file listed in the **OPTION PRESETS** section, below.
  The command will exit after updating the config file.
* .NOP -Font]-&lt;\f[] \f\*[I-Font]cfgfile\f[], \f\*[B-Font]--load-opts\f[]=\f\*[I-Font]cfgfile\f[], \f\*[B-Font]--no-load-opts\f[]  
  Load options from _cfgfile_.
  The _no-load-opts_ form will disable the loading
  of earlier config/rc/ini files.  _--no-load-opts_ is handled early,
  out of order.
* .NOP -Font]--version\f[] [{\f\*[I-Font]v|c|n\f[]}]  
  Output version of program and exit.  The default mode is \`v', a simple
  version.  The \`c' mode will print copyright information and \`n' will
  print the full copyright notice.


<a name="option-presets"></a>

# Option Presets

Any option that is not marked as _not presettable_ may be preset
by loading values from configuration ("RC" or ".INI") file(s) and values from
environment variables named:
      NTPDC_<option-name> or NTPDC
The environmental presets take precedence (are processed later than)
the configuration files.
The _homerc_ files are "_$HOME_", and "_._".
If any of these are directories, then the file _.ntprc_
is searched for within those directories.

<a name="usage"></a>

# Usage

If one or more request options are included on the command line
when
-Font]ntpdc
is executed, each of the requests will be sent
to the NTP servers running on each of the hosts given as command
line arguments, or on localhost by default.
If no request options
are given,
-Font]ntpdc
will attempt to read commands from the
standard input and execute these on the NTP server running on the
first host given on the command line, again defaulting to localhost
when no other host is specified.
The
-Font]ntpdc
utility will prompt for
commands if the standard input is a terminal device.

.ne 2

The
-Font]ntpdc
utility uses NTP mode 7 packets to communicate with the
NTP server, and hence can be used to query any compatible server on
the network which permits it.
Note that since NTP is a UDP protocol
this communication will be somewhat unreliable, especially over
large distances in terms of network topology.
The
-Font]ntpdc
utility makes
no attempt to retransmit requests, and will time requests out if
the remote host is not heard from within a suitable timeout
time.

.ne 2

The operation of
-Font]ntpdc
are specific to the particular
implementation of the
\fCntpd\f[](8)\f[]
daemon and can be expected to
work only with this and maybe some previous versions of the daemon.
Requests from a remote
-Font]ntpdc
utility which affect the
state of the local server must be authenticated, which requires
both the remote program and local server share a common key and key
identifier.

.ne 2

Note that in contexts where a host name is expected, a
-Font]-4\f[]
qualifier preceding the host name forces DNS resolution to the IPv4 namespace,
while a
-Font]-6\f[]
qualifier forces DNS resolution to the IPv6 namespace.
Specifying a command line option other than
-Font]-i\f[]
or
-Font]-n\f[]
will cause the specified query (queries) to be sent to
the indicated host(s) immediately.
Otherwise,
-Font]ntpdc
will
attempt to read interactive format commands from the standard
input.

<a name="interactive-commands"></a>

### Interactive Commands

Interactive format commands consist of a keyword followed by zero
to four arguments.
Only enough characters of the full keyword to
uniquely identify the command need be typed.
The output of a
command is normally sent to the standard output, but optionally the
output of individual commands may be sent to a file by appending a
\[oq]&gt;\[cq],
followed by a file name, to the command line.

.ne 2

A number of interactive format commands are executed entirely
within the
-Font]ntpdc
utility itself and do not result in NTP
mode 7 requests being sent to a server.
These are described
following.

* .NOP -Font]?\f[] \f\*[I-Font]command_keyword\f[]  
* .NOP -Font]help\f[] \f\*[I-Font]command_keyword\f[]  
  A
  \[oq]-Font]?\f[]\[cq]
  will print a list of all the command
  keywords known to this incarnation of
  -Font]ntpdc.
  A
  \[oq]-Font]?\f[]\[cq]
  followed by a command keyword will print function and usage
  information about the command.
  This command is probably a better
  source of information about
  \fCntpq\f[](8)\f[]
  than this manual
  page.
* .NOP -Font]delay\f[] \f\*[I-Font]milliseconds\f[]  
  Specify a time interval to be added to timestamps included in
  requests which require authentication.
  This is used to enable
  (unreliable) server reconfiguration over long delay network paths
  or between machines whose clocks are unsynchronized.
  Actually the
  server does not now require timestamps in authenticated requests,
  so this command may be obsolete.
* .NOP -Font]host\f[] \f\*[I-Font]hostname\f[]  
  Set the host to which future queries will be sent.
  Hostname may
  be either a host name or a numeric address.
* .NOP -Font]hostnames\f[] [\f\*[B-Font]yes\f[] | \f\*[B-Font]no\f[]]  
  If
  -Font]yes\f[]
  is specified, host names are printed in
  information displays.
  If
  -Font]no\f[]
  is specified, numeric
  addresses are printed instead.
  The default is
  -Font]yes\f[],
  unless
  modified using the command line
  -Font]-n\f[]
  switch.
* .NOP -Font]keyid\f[] \f\*[I-Font]keyid\f[]  
  This command allows the specification of a key number to be
  used to authenticate configuration requests.
  This must correspond
  to a key number the server has been configured to use for this
  purpose.
* .NOP -Font]quit\f[]  
  Exit
  -Font]ntpdc.
* .NOP -Font]passwd\f[]  
  This command prompts you to type in a password (which will not
  be echoed) which will be used to authenticate configuration
  requests.
  The password must correspond to the key configured for
  use by the NTP server for this purpose if such requests are to be
  successful.
* .NOP -Font]timeout\f[] \f\*[I-Font]milliseconds\f[]  
  Specify a timeout period for responses to server queries.
  The
  default is about 8000 milliseconds.
  Note that since
  -Font]ntpdc
  retries each query once after a timeout, the total waiting time for
  a timeout will be twice the timeout value set.


<a name="control-message-commands"></a>

### Control Message Commands

Query commands result in NTP mode 7 packets containing requests for
information being sent to the server.
These are read-only commands
in that they make no modification of the server configuration
state.

* .NOP -Font]listpeers\f[]  
  Obtains and prints a brief list of the peers for which the
  server is maintaining state.
  These should include all configured
  peer associations as well as those peers whose stratum is such that
  they are considered by the server to be possible future
  synchronization candidates.
* .NOP -Font]peers\f[]  
  Obtains a list of peers for which the server is maintaining
  state, along with a summary of that state.
  Summary information
  includes the address of the remote peer, the local interface
  address (0.0.0.0 if a local address has yet to be determined), the
  stratum of the remote peer (a stratum of 16 indicates the remote
  peer is unsynchronized), the polling interval, in seconds, the
  reachability register, in octal, and the current estimated delay,
  offset and dispersion of the peer, all in seconds.

.ne 2

The character in the left margin indicates the mode this peer
entry is operating in.
A
\[oq]+\[cq]
denotes symmetric active, a
\[oq]-\[cq]
indicates symmetric passive, a
\[oq]=\[cq]
means the
remote server is being polled in client mode, a
\[oq]^\[cq]
indicates that the server is broadcasting to this address, a
\[oq]~\[cq]
denotes that the remote peer is sending broadcasts and a
\[oq]~\[cq]
denotes that the remote peer is sending broadcasts and a
\[oq]*\[cq]
marks the peer the server is currently synchronizing
to.

.ne 2

The contents of the host field may be one of four forms.
It may
be a host name, an IP address, a reference clock implementation
name with its parameter or
**REFCLK\f[]**()\f[]
On
-Font]hostnames\f[]
-Font]no\f[]
only IP-addresses
will be displayed.

* .NOP -Font]dmpeers\f[]  
  A slightly different peer summary list.
  Identical to the output
  of the
  -Font]peers\f[]
  command, except for the character in the
  leftmost column.
  Characters only appear beside peers which were
  included in the final stage of the clock selection algorithm.
  A
  \[oq].\[cq]
  indicates that this peer was cast off in the falseticker
  detection, while a
  \[oq]+\[cq]
  indicates that the peer made it
  through.
  A
  \[oq]*\[cq]
  denotes the peer the server is currently
  synchronizing with.
* .NOP -Font]showpeer\f[] \f\*[I-Font]peer_address\f[] [\f\*[I-Font]...\f[]]  
  Shows a detailed display of the current peer variables for one
  or more peers.
  Most of these values are described in the NTP
  Version 2 specification.
* .NOP -Font]pstats\f[] \f\*[I-Font]peer_address\f[] [\f\*[I-Font]...\f[]]  
  Show per-peer statistic counters associated with the specified
  peer(s).
* .NOP -Font]clockstat\f[] \f\*[I-Font]clock_peer_address\f[] [\f\*[I-Font]...\f[]]  
  Obtain and print information concerning a peer clock.
  The
  values obtained provide information on the setting of fudge factors
  and other clock performance information.
* .NOP -Font]kerninfo\f[]  
  Obtain and print kernel phase-lock loop operating parameters.
  This information is available only if the kernel has been specially
  modified for a precision timekeeping function.
* .NOP -Font]loopinfo\f[] [\f\*[B-Font]oneline\f[] | \f\*[B-Font]multiline\f[]]  
  Print the values of selected loop filter variables.
  The loop
  filter is the part of NTP which deals with adjusting the local
  system clock.
  The
  \[oq]offset\[cq]
  is the last offset given to the
  loop filter by the packet processing code.
  The
  \[oq]frequency\[cq]
  is the frequency error of the local clock in parts-per-million
  (ppm).
  The
  \[oq]time_const\[cq]
  controls the stiffness of the
  phase-lock loop and thus the speed at which it can adapt to
  oscillator drift.
  The
  \[oq]watchdog timer\[cq]
  value is the number
  of seconds which have elapsed since the last sample offset was
  given to the loop filter.
  The
  -Font]oneline\f[]
  and
  -Font]multiline\f[]
  options specify the format in which this
  information is to be printed, with
  -Font]multiline\f[]
  as the
  default.
* .NOP -Font]sysinfo\f[]  
  Print a variety of system state variables, i.e., state related
  to the local server.
  All except the last four lines are described
  in the NTP Version 3 specification, RFC-1305.

.ne 2

The
\[oq]system flags\[cq]
show various system flags, some of
which can be set and cleared by the
-Font]enable\f[]
and
-Font]disable\f[]
configuration commands, respectively.
These are
the
-Font]auth\f[],
-Font]bclient\f[],
-Font]monitor\f[],
-Font]pll\f[],
-Font]pps\f[]
and
-Font]stats\f[]
flags.
See the
\fCntpd\f[](8)\f[]
documentation for the meaning of these flags.
There
are two additional flags which are read only, the
-Font]kernel_pll\f[]
and
-Font]kernel_pps\f[].
These flags indicate
the synchronization status when the precision time kernel
modifications are in use.
The
\[oq]kernel_pll\[cq]
indicates that
the local clock is being disciplined by the kernel, while the
\[oq]kernel_pps\[cq]
indicates the kernel discipline is provided by the PPS
signal.

.ne 2

The
\[oq]stability\[cq]
is the residual frequency error remaining
after the system frequency correction is applied and is intended for
maintenance and debugging.
In most architectures, this value will
initially decrease from as high as 500 ppm to a nominal value in
the range .01 to 0.1 ppm.
If it remains high for some time after
starting the daemon, something may be wrong with the local clock,
or the value of the kernel variable
kern.clockrate.tick\f[]
may be
incorrect.

.ne 2

The
\[oq]broadcastdelay\[cq]
shows the default broadcast delay,
as set by the
-Font]broadcastdelay\f[]
configuration command.

.ne 2

The
\[oq]authdelay\[cq]
shows the default authentication delay,
as set by the
-Font]authdelay\f[]
configuration command.

* .NOP -Font]sysstats\f[]  
  Print statistics counters maintained in the protocol
  module.
* .NOP -Font]memstats\f[]  
  Print statistics counters related to memory allocation
  code.
* .NOP -Font]iostats\f[]  
  Print statistics counters maintained in the input-output
  module.
* .NOP -Font]timerstats\f[]  
  Print statistics counters maintained in the timer/event queue
  support code.
* .NOP -Font]reslist\f[]  
  Obtain and print the server's restriction list.
  This list is
  (usually) printed in sorted order and may help to understand how
  the restrictions are applied.
* .NOP -Font]monlist\f[] [\f\*[I-Font]version\f[]]  
  Obtain and print traffic counts collected and maintained by the
  monitor facility.
  The version number should not normally need to be
  specified.
* .NOP -Font]clkbug\f[] \f\*[I-Font]clock_peer_address\f[] [\f\*[I-Font]...\f[]]  
  Obtain debugging information for a reference clock driver.
  This
  information is provided only by some clock drivers and is mostly
  undecodable without a copy of the driver source in hand.


<a name="runtime-configuration-requests"></a>

### Runtime Configuration Requests

All requests which cause state changes in the server are
authenticated by the server using a configured NTP key (the
facility can also be disabled by the server by not configuring a
key).
The key number and the corresponding key must also be made
known to
-Font]ntpdc.
This can be done using the
-Font]keyid\f[]
and
-Font]passwd\f[]
commands, the latter of which will prompt at the terminal for a
password to use as the encryption key.
You will also be prompted
automatically for both the key number and password the first time a
command which would result in an authenticated request to the
server is given.
Authentication not only provides verification that
the requester has permission to make such changes, but also gives
an extra degree of protection again transmission errors.

.ne 2

Authenticated requests always include a timestamp in the packet
data, which is included in the computation of the authentication
code.
This timestamp is compared by the server to its receive time
stamp.
If they differ by more than a small amount the request is
rejected.
This is done for two reasons.
First, it makes simple
replay attacks on the server, by someone who might be able to
overhear traffic on your LAN, much more difficult.
Second, it makes
it more difficult to request configuration changes to your server
from topologically remote hosts.
While the reconfiguration facility
will work well with a server on the local host, and may work
adequately between time-synchronized hosts on the same LAN, it will
work very poorly for more distant hosts.
As such, if reasonable
passwords are chosen, care is taken in the distribution and
protection of keys and appropriate source address restrictions are
applied, the run time reconfiguration facility should provide an
adequate level of security.

.ne 2

The following commands all make authenticated requests.

* .NOP -Font]addpeer\f[] \f\*[I-Font]peer_address\f[] [\f\*[I-Font]keyid\f[]] [\f\*[I-Font]version\f[]] [\f\*[B-Font]prefer\f[]]  
  Add a configured peer association at the given address and
  operating in symmetric active mode.
  Note that an existing
  association with the same peer may be deleted when this command is
  executed, or may simply be converted to conform to the new
  configuration, as appropriate.
  If the optional
  -Font]keyid\f[]
  is a
  nonzero integer, all outgoing packets to the remote server will
  have an authentication field attached encrypted with this key.
  If
  the value is 0 (or not given) no authentication will be done.
  The
  -Font]version\f[]
  can be 1, 2 or 3 and defaults to 3.
  The
  -Font]prefer\f[]
  keyword indicates a preferred peer (and thus will
  be used primarily for clock synchronisation if possible).
  The
  preferred peer also determines the validity of the PPS signal - if
  the preferred peer is suitable for synchronisation so is the PPS
  signal.
* .NOP -Font]addserver\f[] \f\*[I-Font]peer_address\f[] [\f\*[I-Font]keyid\f[]] [\f\*[I-Font]version\f[]] [\f\*[B-Font]prefer\f[]]  
  Identical to the addpeer command, except that the operating
  mode is client.
* .NOP -Font]broadcast\f[] \f\*[I-Font]peer_address\f[] [\f\*[I-Font]keyid\f[]] [\f\*[I-Font]version\f[]] [\f\*[B-Font]prefer\f[]]  
  Identical to the addpeer command, except that the operating
  mode is broadcast.
  In this case a valid key identifier and key are
  required.
  The
  -Font]peer_address\f[]
  parameter can be the broadcast
  address of the local network or a multicast group address assigned
  to NTP.
  If a multicast address, a multicast-capable kernel is
  required.
* .NOP -Font]unconfig\f[] \f\*[I-Font]peer_address\f[] [\f\*[I-Font]...\f[]]  
  This command causes the configured bit to be removed from the
  specified peer(s).
  In many cases this will cause the peer
  association to be deleted.
  When appropriate, however, the
  association may persist in an unconfigured mode if the remote peer
  is willing to continue on in this fashion.
* .NOP -Font]fudge\f[] \f\*[I-Font]peer_address\f[] [\f\*[B-Font]time1\f[]] [\f\*[B-Font]time2\f[]] [\f\*[I-Font]stratum\f[]] [\f\*[I-Font]refid\f[]]  
  This command provides a way to set certain data for a reference
  clock.
  See the source listing for further information.
* .NOP -Font]enable\f[] [\f\*[B-Font]auth\f[] | \f\*[B-Font]bclient\f[] | \f\*[B-Font]calibrate\f[] | \f\*[B-Font]kernel\f[] | \f\*[B-Font]monitor\f[] | \f\*[B-Font]ntp\f[] | \f\*[B-Font]pps\f[] | \f\*[B-Font]stats\f[]]  
* .NOP -Font]disable\f[] [\f\*[B-Font]auth\f[] | \f\*[B-Font]bclient\f[] | \f\*[B-Font]calibrate\f[] | \f\*[B-Font]kernel\f[] | \f\*[B-Font]monitor\f[] | \f\*[B-Font]ntp\f[] | \f\*[B-Font]pps\f[] | \f\*[B-Font]stats\f[]]  
  These commands operate in the same way as the
  -Font]enable\f[]
  and
  -Font]disable\f[]
  configuration file commands of
  \fCntpd\f[](8)\f[].
    * .NOP -Font]auth\f[]  
      Enables the server to synchronize with unconfigured peers only
      if the peer has been correctly authenticated using either public key
      or private key cryptography.
      The default for this flag is enable.
    * .NOP -Font]bclient\f[]  
      Enables the server to listen for a message from a broadcast or
      multicast server, as in the multicastclient command with
      default address.
      The default for this flag is disable.
    * .NOP -Font]calibrate\f[]  
      Enables the calibrate feature for reference clocks.
      The default for this flag is disable.
    * .NOP -Font]kernel\f[]  
      Enables the kernel time discipline, if available.
      The default for this flag is enable if support is available, otherwise disable.
    * .NOP -Font]monitor\f[]  
      Enables the monitoring facility.
      See the documentation here about the
      -Font]monlist\f[]
      command or further information.
      The default for this flag is enable.
    * .NOP -Font]ntp\f[]  
      Enables time and frequency discipline.
      In effect, this switch opens and closes the feedback loop,
      which is useful for testing.
      The default for this flag is enable.
    * .NOP -Font]pps\f[]  
      Enables the pulse-per-second (PPS) signal when frequency
      and time is disciplined by the precision time kernel modifications.
      See the
      "A Kernel Model for Precision Timekeeping"
      (available as part of the HTML documentation
      provided in
      /usr/share/doc/ntp\f[])
      page for further information.
      The default for this flag is disable.
    * .NOP -Font]stats\f[]  
      Enables the statistics facility.
      See the
      Monitoring\f[] Options\f[]
      section of
      \fCntp.conf\f[](5)\f[]
      for further information.
      The default for this flag is disable.
* .NOP -Font]restrict\f[] \f\*[I-Font]address\f[] \f\*[I-Font]mask\f[] \f\*[I-Font]flag\f[] [\f\*[I-Font]...\f[]]  
  This command operates in the same way as the
  -Font]restrict\f[]
  configuration file commands of
  \fCntpd\f[](8)\f[].
* .NOP -Font]unrestrict\f[] \f\*[I-Font]address\f[] \f\*[I-Font]mask\f[] \f\*[I-Font]flag\f[] [\f\*[I-Font]...\f[]]  
  Unrestrict the matching entry from the restrict list.
* .NOP -Font]delrestrict\f[] \f\*[I-Font]address\f[] \f\*[I-Font]mask\f[] [\f\*[B-Font]ntpport\f[]]  
  Delete the matching entry from the restrict list.
* .NOP -Font]readkeys\f[]  
  Causes the current set of authentication keys to be purged and
  a new set to be obtained by rereading the keys file (which must
  have been specified in the
  \fCntpd\f[](8)\f[]
  configuration file).
  This
  allows encryption keys to be changed without restarting the
  server.
* .NOP -Font]trustedkey\f[] \f\*[I-Font]keyid\f[] [\f\*[I-Font]...\f[]]  
* .NOP -Font]untrustedkey\f[] \f\*[I-Font]keyid\f[] [\f\*[I-Font]...\f[]]  
  These commands operate in the same way as the
  -Font]trustedkey\f[]
  and
  -Font]untrustedkey\f[]
  configuration file
  commands of
  \fCntpd\f[](8)\f[].
* .NOP -Font]authinfo\f[]  
  Returns information concerning the authentication module,
  including known keys and counts of encryptions and decryptions
  which have been done.
* .NOP -Font]traps\f[]  
  Display the traps set in the server.
  See the source listing for
  further information.
* .NOP -Font]addtrap\f[] \f\*[I-Font]address\f[] [\f\*[I-Font]port\f[]] [\f\*[I-Font]interface\f[]]  
  Set a trap for asynchronous messages.
  See the source listing
  for further information.
* .NOP -Font]clrtrap\f[] \f\*[I-Font]address\f[] [\f\*[I-Font]port\f[]] [\f\*[I-Font]interface\f[]]  
  Clear a trap for asynchronous messages.
  See the source listing
  for further information.
* .NOP -Font]reset\f[]  
  Clear the statistics counters in various modules of the server.
  See the source listing for further information.


<a name="environment"></a>

# Environment

See **OPTION PRESETS** for configuration environment variables.

<a name="files"></a>

# Files

See **OPTION PRESETS** for configuration files.

<a name="exit-status"></a>

# Exit Status

One of the following exit values will be returned:

* .NOP 0 " (EXIT_SUCCESS)"
  Successful program execution.
* .NOP 1 " (EXIT_FAILURE)"
  The operation failed or the command syntax was not valid.
* .NOP 66 " (EX_NOINPUT)"
  A specified configuration file could not be loaded.
* .NOP 70 " (EX_SOFTWARE)"
  libopts had an internal operational error.  Please report
  it to autogen-users@lists.sourceforge.net.  Thank you.


<a name="see-also"></a>

# See Also

\fCntp.conf\f[](5)\f[],
\fCntpd\f[](8)\f[]
David L. Mills,
_Network Time Protocol (Version 3)_,
RFC1305



<a name="authors"></a>

# Authors

The formatting directives in this document came from FreeBSD.

<a name="copyright"></a>

# Copyright

Copyright (C) 1992-2020 The University of Delaware and Network Time Foundation all rights reserved.
This program is released under the terms of the NTP license, &lt;http://ntp.org/license&gt;.

<a name="bugs"></a>

# Bugs

The
-Font]ntpdc
utility is a crude hack.
Much of the information it shows is
deadly boring and could only be loved by its implementer.
The
program was designed so that new (and temporary) features were easy
to hack in, at great expense to the program's ease of use.
Despite
this, the program is occasionally useful.

.ne 2

Please report bugs to http://bugs.ntp.org .

.ne 2

Please send bug reports to: http://bugs.ntp.org, bugs@ntp.org

<a name="notes"></a>

# Notes

This manual page was _AutoGen_-erated from the **ntpdc**
option definitions.
