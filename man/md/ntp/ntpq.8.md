# ntpq(8)

4.2.8p15, 23 Jun 2020

-Font]ntpq
- standard NTP query program

<a name="synopsis"></a>

# Synopsis

```
\fB-Font]ntpq
</synopsis>

<synopsis>
[\fB-Font]-flags\f[]] [\fB-Font]-flag\f[] [\f\*[I-Font]value\f[]]] [\fB-Font]--option-name\f[][[=| ]\f\*[I-Font]value\f[]]] [ host ...] 
 .ne 2
```


<a name="description"></a>

# Description


.ne 2

The
-Font]ntpq
utility program is used to query NTP servers to monitor NTP operations
and performance, requesting
information about current state and/or changes in that state.
The program may be run either in interactive mode or controlled using
command line arguments.
Requests to read and write arbitrary
variables can be assembled, with raw and pretty-printed output
options being available.
The
-Font]ntpq
utility can also obtain and print a
list of peers in a common format by sending multiple queries to the
server.

.ne 2

If one or more request options is included on the command line
when
-Font]ntpq
is executed, each of the requests will be sent
to the NTP servers running on each of the hosts given as command
line arguments, or on localhost by default.
If no request options
are given,
-Font]ntpq
will attempt to read commands from the
standard input and execute these on the NTP server running on the
first host given on the command line, again defaulting to localhost
when no other host is specified.
The
-Font]ntpq
utility will prompt for
commands if the standard input is a terminal device.

.ne 2

-Font]ntpq
uses NTP mode 6 packets to communicate with the
NTP server, and hence can be used to query any compatible server on
the network which permits it.
Note that since NTP is a UDP protocol
this communication will be somewhat unreliable, especially over
large distances in terms of network topology.
The
-Font]ntpq
utility makes
one attempt to retransmit requests, and will time requests out if
the remote host is not heard from within a suitable timeout
time.

.ne 2

Note that in contexts where a host name is expected, a
-Font]-4\f[]
qualifier preceding the host name forces resolution to the IPv4
namespace, while a
-Font]-6\f[]
qualifier forces resolution to the IPv6 namespace.
For examples and usage, see the
Lq]NTP Debugging Techniques\*[Rq]
page.

.ne 2

Specifying a
command line option other than
-Font]-i\f[]
or
-Font]-n\f[]
will
cause the specified query (queries) to be sent to the indicated
host(s) immediately.
Otherwise,
-Font]ntpq
will attempt to read
interactive format commands from the standard input.

<a name="internal-commands"></a>

### Internal Commands


.ne 2

Interactive format commands consist of a keyword followed by zero
to four arguments.
Only enough characters of the full keyword to
uniquely identify the command need be typed.

.ne 2

A
number of interactive format commands are executed entirely within
the
-Font]ntpq
utility itself and do not result in NTP
requests being sent to a server.
These are described following.

* .NOP -Font]?\f[] [\f\*[I-Font]command\f[]]    
  .ns
* .NOP -Font]help\f[] [\f\*[I-Font]command\f[]]  
  A
  \[oq]?\[cq]
  by itself will print a list of all the commands
  known to
  -Font]ntpq.
  A
  \[oq]?\[cq]
  followed by a command name will print function and usage
  information about the command.  
  .ns
* .NOP -Font]addvars\f[] \f\*[I-Font]name\f[][=\f\*[I-Font]value\f[]][,...]    
  .ns
* .NOP -Font]rmvars\f[] \f\*[I-Font]name\f[][,...]    
  .ns
* .NOP -Font]clearvars\f[]    
  .ns
* .NOP -Font]showvars\f[]  
  The arguments to this command consist of a list of
  items of the form
  -Font]name\f[][=\f\*[I-Font]value\f[]],
  where the
  .NOP =-Font]value\f[]
  is ignored, and can be omitted,
  in requests to the server to read variables.
  The
  -Font]ntpq
  utility maintains an internal list in which data to be included in
  messages can be assembled, and displayed or set using the
  -Font]readlist\f[]
  and
  -Font]writelist\f[]
  commands described below.
  The
  -Font]addvars\f[]
  command allows variables and their optional values to be added to
  the list.
  If more than one variable is to be added, the list should
  be comma-separated and not contain white space.
  The
  -Font]rmvars\f[]
  command can be used to remove individual variables from the list,
  while the
  -Font]clearvars\f[]
  command removes all variables from the
  list.
  The
  -Font]showvars\f[]
  command displays the current list of optional variables.  
  .ns
* .NOP -Font]authenticate\f[] [\f\*[B-Font]yes\f[]|\f\*[B-Font]no\f[]]  
  Normally
  -Font]ntpq
  does not authenticate requests unless
  they are write requests.
  The command
  -Font]authenticate\f[] \f\*[B-Font]yes\f[]
  causes
  -Font]ntpq
  to send authentication with all requests it
  makes.
  Authenticated requests causes some servers to handle
  requests slightly differently.
  The command
  -Font]authenticate\f[]
  causes
  -Font]ntpq
  to display whether or not
  it is currently authenticating requests.  
  .ns
* .NOP -Font]cooked\f[]  
  Causes output from query commands to be "cooked", so that
  variables which are recognized by
  -Font]ntpq
  will have their
  values reformatted for human consumption.
  Variables which
  -Font]ntpq
  could not decode completely are
  marked with a trailing
  \[oq]?\[cq].  
  .ns
* .NOP -Font]debug\f[] [\f\*[B-Font]more\f[]|\f\*[B-Font]less\f[]|\f\*[B-Font]off\f[]]  
  With no argument, displays the current debug level.
  Otherwise, the debugging level is changed as indicated.  
  .ns
* .NOP -Font]delay\f[] [\f\*[I-Font]milliseconds\f[]]  
  Specify a time interval to be added to timestamps included in
  requests which require authentication.
  This is used to enable
  (unreliable) server reconfiguration over long delay network paths
  or between machines whose clocks are unsynchronized.
  Actually the
  server does not now require timestamps in authenticated requests,
  so this command may be obsolete.
  Without any arguments, displays the current delay.  
  .ns
* .NOP -Font]drefid\f[] [\f\*[B-Font]hash\f[]|\f\*[B-Font]ipv4\f[]]  
  Display refids as IPv4 or hash.
  Without any arguments, displays whether refids are shown as IPv4
  addresses or hashes.  
  .ns
* .NOP -Font]exit\f[]  
  Exit
  -Font]ntpq.  
  .ns
* .NOP -Font]host\f[] [\f\*[I-Font]name\f[]]  
  Set the host to which future queries will be sent.
  The
  -Font]name\f[]
  may be either a host name or a numeric address.
  Without any arguments, displays the current host.  
  .ns
* .NOP -Font]hostnames\f[] [\f\*[B-Font]yes\f[]|\f\*[B-Font]no\f[]]  
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
  Without any arguments, displays whether host names or numeric addresses
  are shown.  
  .ns
* .NOP -Font]keyid\f[] [\f\*[I-Font]keyid\f[]]  
  This command allows the specification of a key number to be
  used to authenticate configuration requests.
  This must correspond
  to the
  -Font]controlkey\f[]
  key number the server has been configured to use for this
  purpose.
  Without any arguments, displays the current
  -Font]keyid\f[].  
  .ns
* .NOP -Font]keytype\f[] [\f\*[I-Font]digest\f[]]  
  Specify the digest algorithm to use for authenticating requests, with default
  -Font]MD5\f[].
  If
  -Font]ntpq
  was built with OpenSSL support, and OpenSSL is installed,
  -Font]digest\f[]
  can be any message digest algorithm supported by OpenSSL.
  If no argument is given, the current
  -Font]keytype\f[] \f\*[I-Font]digest\f[]
  algorithm used is displayed.  
  .ns
* .NOP -Font]ntpversion\f[] [\f\*[B-Font]1\f[]|\f\*[B-Font]2\f[]|\f\*[B-Font]3\f[]|\f\*[B-Font]4\f[]]  
  Sets the NTP version number which
  -Font]ntpq
  claims in
  packets.
  Defaults to 3, and note that mode 6 control messages (and
  modes, for that matter) didn't exist in NTP version 1.
  There appear
  to be no servers left which demand version 1.
  With no argument, displays the current NTP version that will be used
  when communicating with servers.  
  .ns
* .NOP -Font]passwd\f[]  
  This command prompts you to type in a password (which will not
  be echoed) which will be used to authenticate configuration
  requests.
  The password must correspond to the key configured for
  use by the NTP server for this purpose if such requests are to be
  successful.  
  .ns
* .NOP -Font]poll\f[] [\f\*[I-Font]n\f[]] [\f\*[B-Font]verbose\f[]]  
  Poll an NTP server in client mode
  -Font]n\f[]
  times.
  Poll not implemented yet.  
  .ns
* .NOP -Font]quit\f[]  
  Exit
  -Font]ntpq.  
  .ns
* .NOP -Font]raw\f[]  
  Causes all output from query commands is printed as received
  from the remote server.
  The only formating/interpretation done on
  the data is to transform nonascii data into a printable (but barely
  understandable) form.  
  .ns
* .NOP -Font]timeout\f[] [\f\*[I-Font]milliseconds\f[]]  
  Specify a timeout period for responses to server queries.
  The
  default is about 5000 milliseconds.
  Without any arguments, displays the current timeout period.
  Note that since
  -Font]ntpq
  retries each query once after a timeout, the total waiting time for
  a timeout will be twice the timeout value set.  
  .ns
* .NOP -Font]version\f[]  
  Display the version of the
  -Font]ntpq
  program.


<a name="control-message-commands"></a>

### Control Message Commands

Association ids are used to identify system, peer and clock variables.
System variables are assigned an association id of zero and system name
space, while each association is assigned a nonzero association id and
peer namespace.
Most control commands send a single message to the server and expect a
single response message.
The exceptions are the
-Font]peers\f[]
command, which sends a series of messages,
and the
-Font]mreadlist\f[]
and
-Font]mreadvar\f[]
commands, which iterate over a range of associations.

* .NOP -Font]apeers\f[]  
  Display a list of peers in the form:
  .Dl [tally]remote refid assid st t when pool reach delay offset jitter
  where the output is just like the
  -Font]peers\f[]
  command except that the
  -Font]refid\f[]
  is displayed in hex format and the association number is also displayed.  
  .ns
* .NOP -Font]associations\f[]  
  Display a list of mobilized associations in the form:
  .Dl ind assid status conf reach auth condition last_event cnt
    * **·**  
    * **·**  
    * **·**  
    * **·**  
    * **·**  
    * **·**  
    * **·**  
    * **·**  
    * **·**  
    * **·**    
  .ns
* .NOP -Font]authinfo\f[]  
  Display the authentication statistics counters:
  time since reset, stored keys, free keys, key lookups, keys not found,
  uncached keys, expired keys, encryptions, decryptions.  
  .ns
* .NOP -Font]clocklist\f[] [\f\*[I-Font]associd\f[]]    
  .ns
* .NOP -Font]cl\f[] [\f\*[I-Font]associd\f[]]  
  Display all clock variables in the variable list for those associations
  supporting a reference clock.  
  .ns
* .NOP -Font]clockvar\f[] [\f\*[I-Font]associd\f[]] [\f\*[I-Font]name\f[][=\f\*[I-Font]value\f[]][] ,...]    
  .ns
* .NOP -Font]cv\f[] [\f\*[I-Font]associd\f[]] [\f\*[I-Font]name\f[][=\f\*[I-Font]value\f[]][] ,...]  
  Display a list of clock variables for those associations supporting a
  reference clock.  
  .ns
* .NOP -Font]:config\f[] \f\*[I-Font]configuration command line\f[]  
  Send the remainder of the command line, including whitespace, to the
  server as a run-time configuration command in the same format as a line
  in the configuration file.
  This command is experimental until further notice and clarification.
  Authentication is of course required.  
  .ns
* .NOP -Font]config-from-file\f[] \f\*[I-Font]filename\f[]  
  Send each line of
  -Font]filename\f[]
  to the server as run-time configuration commands in the same format as
  lines in the configuration file.
  This command is experimental until further notice and clarification.
  Authentication is required.  
  .ns
* .NOP -Font]ifstats\f[]  
  Display status and statistics counters for each local network interface address:
  interface number, interface name and address or broadcast, drop, flag,
  ttl, mc, received, sent, send failed, peers, uptime.
  Authentication is required.  
  .ns
* .NOP -Font]iostats\f[]  
  Display network and reference clock I/O statistics:
  time since reset, receive buffers, free receive buffers, used receive buffers,
  low water refills, dropped packets, ignored packets, received packets,
  packets sent, packet send failures, input wakeups, useful input wakeups.  
  .ns
* .NOP -Font]kerninfo\f[]  
  Display kernel loop and PPS statistics:
  associd, status, pll offset, pll frequency, maximum error,
  estimated error, kernel status, pll time constant, precision,
  frequency tolerance, pps frequency, pps stability, pps jitter,
  calibration interval, calibration cycles, jitter exceeded,
  stability exceeded, calibration errors.
  As with other ntpq output, times are in milliseconds; very small values
  may be shown as exponentials.
  The precision value displayed is in milliseconds as well, unlike the
  precision system variable.  
  .ns
* .NOP -Font]lassociations\f[]  
  Perform the same function as the associations command, except display
  mobilized and unmobilized associations, including all clients.  
  .ns
* .NOP -Font]lopeers\f[] [\f\*[B-Font]-4\f[]|\f\*[B-Font]-6\f[]]  
  Display a list of all peers and clients showing
  -Font]dstadr\f[]
  (associated with the given IP version).  
  .ns
* .NOP -Font]lpassociations\f[]  
  Display the last obtained list of associations, including all clients.  
  .ns
* .NOP -Font]lpeers\f[] [\f\*[B-Font]-4\f[]|\f\*[B-Font]-6\f[]]  
  Display a list of all peers and clients (associated with the given IP version).  
  .ns
* .NOP -Font]monstats\f[]  
  Display monitor facility status, statistics, and limits:
  enabled, addresses, peak addresses, maximum addresses,
  reclaim above count, reclaim older than, kilobytes, maximum kilobytes.  
  .ns
* .NOP -Font]mreadlist\f[] \f\*[I-Font]associdlo\f[] \f\*[I-Font]associdhi\f[]    
  .ns
* .NOP -Font]mrl\f[] \f\*[I-Font]associdlo\f[] \f\*[I-Font]associdhi\f[]  
  Perform the same function as the
  -Font]readlist\f[]
  command for a range of association ids.  
  .ns
* .NOP -Font]mreadvar\f[] \f\*[I-Font]associdlo\f[] \f\*[I-Font]associdhi\f[] [\f\*[I-Font]name\f[]][,...]  
  This range may be determined from the list displayed by any
  command showing associations.  
  .ns
* .NOP -Font]mrv\f[] \f\*[I-Font]associdlo\f[] \f\*[I-Font]associdhi\f[] [\f\*[I-Font]name\f[]][,...]  
  Perform the same function as the
  -Font]readvar\f[]
  command for a range of association ids.
  This range may be determined from the list displayed by any
  command showing associations.  
  .ns
* .NOP -Font]mrulist\f[] [\f\*[B-Font]limited\f[] | \f\*[B-Font]kod\f[] | \f\*[B-Font]mincount\f[]=\f\*[I-Font]count\f[] | \f\*[B-Font]laddr\f[]=\f\*[I-Font]localaddr\f[] | \f\*[B-Font]sort\f[]=[-]\f\*[I-Font]sortorder\f[] | \f\*[B-Font]resany\f[]=\f\*[I-Font]hexmask\f[] | \f\*[B-Font]resall\f[]=\f\*[I-Font]hexmask\f[]]  
  Display traffic counts of the most recently seen source addresses
  collected and maintained by the monitor facility.
  With the exception of
  -Font]sort\f[]=[-]\f\*[I-Font]sortorder\f[],
  the options filter the list returned by
  \fCntpd\f[](8)\f[].
  The
  -Font]limited\f[]
  and
  -Font]kod\f[]
  options return only entries representing client addresses from which the
  last packet received triggered either discarding or a KoD response.
  The
  -Font]mincount\f[]=\f\*[I-Font]count\f[]
  option filters entries representing less than
  -Font]count\f[]
  packets.
  The
  -Font]laddr\f[]=\f\*[I-Font]localaddr\f[]
  option filters entries for packets received on any local address other than
  -Font]localaddr\f[].
  -Font]resany\f[]=\f\*[I-Font]hexmask\f[]
  and
  -Font]resall\f[]=\f\*[I-Font]hexmask\f[]
  filter entries containing none or less than all, respectively, of the bits in
  -Font]hexmask\f[],
  which must begin with
  -Font]0x\f[].
  The
  -Font]sortorder\f[]
  defaults to
  -Font]lstint\f[]
  and may be 
  -Font]addr\f[],
  -Font]avgint\f[],
  -Font]count\f[],
  -Font]lstint\f[],
  or any of those preceded by
  \[oq]-\[cq]
  to reverse the sort order.
  The output columns are:
    * .NOP Column  
      Description  
      .ns
    * .NOP -Font]lstint\f[]  
      Interval in seconds between the receipt of the most recent packet from
      this address and the completion of the retrieval of the MRU list by
      -Font]ntpq.  
      .ns
    * .NOP -Font]avgint\f[]  
      Average interval in s between packets from this address.  
      .ns
    * .NOP -Font]rstr\f[]  
      Restriction flags associated with this address.
      Most are copied unchanged from the matching
      -Font]restrict\f[]
      command, however 0x400 (kod) and 0x20 (limited) flags are cleared unless
      the last packet from this address triggered a rate control response.  
      .ns
    * .NOP -Font]r\f[]  
      Rate control indicator, either
      a period,
      -Font]L\f[]
      or
      -Font]K\f[]
      for no rate control response,
      rate limiting by discarding, or rate limiting with a KoD response, respectively.  
      .ns
    * .NOP -Font]m\f[]  
      Packet mode.  
      .ns
    * .NOP -Font]v\f[]  
      Packet version number.  
      .ns
    * .NOP -Font]count\f[]  
      Packets received from this address.  
      .ns
    * .NOP -Font]rport\f[]  
      Source port of last packet from this address.  
      .ns
    * .NOP -Font]remote\f[] \f\*[B-Font]address\f[]  
      host or DNS name, numeric address, or address followed by
      claimed DNS name which could not be verified in parentheses.  
  .ns
* .NOP -Font]opeers\f[] [\f\*[B-Font]-4\f[] | \f\*[B-Font]-6\f[]]  
  Obtain and print the old-style list of all peers and clients showing
  -Font]dstadr\f[]
  (associated with the given IP version),
  rather than the
  -Font]refid\f[].  
  .ns
* .NOP -Font]passociations\f[]  
  Perform the same function as the
  -Font]associations\f[]
  command,
  except that it uses previously stored data rather than making a new query.  
  .ns
* .NOP -Font]peers\f[]  
  Display a list of peers in the form:
  .Dl [tally]remote refid st t when pool reach delay offset jitter
    * .NOP Variable  
      Description  
      .ns
    * .NOP -Font][tally]\f[]  
      single-character code indicating current value of the
      -Font]select\f[]
      field of the
      .Lk decode.html#peer "peer status word"  
      .ns
    * .NOP -Font]remote\f[]  
      host name (or IP number) of peer.
      The value displayed will be truncated to 15 characters unless the
      -Font]ntpq
      -Font]-w\f[]
      option is given, in which case the full value will be displayed
      on the first line, and if too long,
      the remaining data will be displayed on the next line.  
      .ns
    * .NOP -Font]refid\f[]  
      source IP address or
      .Lk decode.html#kiss "'kiss code"  
      .ns
    * .NOP -Font]st\f[]  
      stratum: 0 for local reference clocks, 1 for servers with local
      reference clocks, ..., 16 for unsynchronized server clocks  
      .ns
    * .NOP -Font]t\f[]  
      -Font]u\f[]:
      unicast or manycast client,
      -Font]b\f[]:
      broadcast or multicast client,
      -Font]p\f[]:
      pool source,
      -Font]l\f[]:
      local (reference clock),
      -Font]s\f[]:
      symmetric (peer),
      -Font]A\f[]:
      manycast server,
      -Font]B\f[]:
      broadcast server,
      -Font]M\f[]:
      multicast server  
      .ns
    * .NOP -Font]when\f[]  
      time in seconds, minutes, hours, or days since the last packet
      was received, or
      \[oq]-\[cq]
      if a packet has never been received  
      .ns
    * .NOP -Font]poll\f[]  
      poll interval (s)  
      .ns
    * .NOP -Font]reach\f[]  
      reach shift register (octal)  
      .ns
    * .NOP -Font]delay\f[]  
      roundtrip delay  
      .ns
    * .NOP -Font]offset\f[]  
      offset of server relative to this host  
      .ns
    * .NOP -Font]jitter\f[]  
      offset RMS error estimate.  
  .ns
* .NOP -Font]pstats\f[] \f\*[I-Font]associd\f[]  
  Display the statistics for the peer with the given
  -Font]associd\f[]:
  associd, status, remote host, local address, time last received,
  time until next send, reachability change, packets sent,
  packets received, bad authentication, bogus origin, duplicate,
  bad dispersion, bad reference time, candidate order.  
  .ns
* .NOP -Font]readlist\f[] [\f\*[I-Font]associd\f[]]    
  .ns
* .NOP -Font]rl\f[] [\f\*[I-Font]associd\f[]]  
  Display all system or peer variables.
  If the
  -Font]associd\f[]
  is omitted, it is assumed to be zero.  
  .ns
* .NOP -Font]readvar\f[] [\f\*[I-Font]associd\f[] \f\*[I-Font]name\f[][=\f\*[I-Font]value\f[]] [, ...]]    
  .ns
* .NOP -Font]rv\f[] [\f\*[I-Font]associd\f[] \f\*[I-Font]name\f[][=\f\*[I-Font]value\f[]] [, ...]]  
  Display the specified system or peer variables.
  If
  -Font]associd\f[]
  is zero, the variables are from the
  System\f[] Variables\f[]
  name space, otherwise they are from the
  Peer\f[] Variables\f[]
  name space.
  The
  -Font]associd\f[]
  is required, as the same name can occur in both spaces.
  If no
  -Font]name\f[]
  is included, all operative variables in the name space are displayed.
  In this case only, if the
  -Font]associd\f[]
  is omitted, it is assumed to be zero.
  Multiple names are specified with comma separators and without whitespace.
  Note that time values are represented in milliseconds
  and frequency values in parts-per-million (PPM).
  Some NTP timestamps are represented in the format
  -Font]YYYY\f[]\f\*[I-Font]MM\f[] \f\*[I-Font]DD\f[] \f\*[I-Font]TTTT\f[],
  where
  -Font]YYYY\f[]
  is the year,
  -Font]MM\f[]
  the month of year,
  -Font]DD\f[]
  the day of month and
  -Font]TTTT\f[]
  the time of day.  
  .ns
* .NOP -Font]reslist\f[]  
  Display the access control (restrict) list for
  -Font]ntpq.
  Authentication is required.  
  .ns
* .NOP -Font]saveconfig\f[] \f\*[I-Font]filename\f[]  
  Save the current configuration,
  including any runtime modifications made by
  -Font]:config\f[]
  or
  -Font]config-from-file\f[],
  to the NTP server host file
  -Font]filename\f[].
  This command will be rejected by the server unless
  .Lk miscopt.html#saveconfigdir "saveconfigdir"
  appears in the
  \fCntpd\f[](8)\f[]
  configuration file.
  -Font]filename\f[]
  can use
  \fCdate\f[](1)\f[]
  format specifiers to substitute the current date and time, for
  example,
  .in +4
  -Font]saveconfig\f[] ntp-%Y%m%d-%H%M%S.conf\f[]. 
  .in -4
  The filename used is stored in system variable
  -Font]savedconfig\f[].
  Authentication is required.  
  .ns
* .NOP -Font]sysinfo\f[]  
  Display system operational summary:
  associd, status, system peer, system peer mode, leap indicator,
  stratum, log2 precision, root delay, root dispersion,
  reference id, reference time, system jitter, clock jitter,
  clock wander, broadcast delay, symm. auth. delay.  
  .ns
* .NOP -Font]sysstats\f[]  
  Display system uptime and packet counts maintained in the
  protocol module:
  uptime, sysstats reset, packets received, current version,
  older version, bad length or format, authentication failed,
  declined, restricted, rate limited, KoD responses,
  processed for time.  
  .ns
* .NOP -Font]timerstats\f[]  
  Display interval timer counters:
  time since reset, timer overruns, calls to transmit.  
  .ns
* .NOP -Font]writelist\f[] \f\*[I-Font]associd\f[]  
  Set all system or peer variables included in the variable list.  
  .ns
* .NOP -Font]writevar\f[] \f\*[I-Font]associd\f[] \f\*[I-Font]name\f[]=\f\*[I-Font]value\f[] [, ...]  
  Set the specified variables in the variable list.
  If the
  -Font]associd\f[]
  is zero, the variables are from the
  System\f[] Variables\f[]
  name space, otherwise they are from the
  Peer\f[] Variables\f[]
  name space.
  The
  -Font]associd\f[]
  is required, as the same name can occur in both spaces.
  Authentication is required.


<a name="status-words-and-kiss-codes"></a>

### Status Words and Kiss Codes

The current state of the operating program is shown
in a set of status words
maintained by the system.
Status information is also available on a per-association basis.
These words are displayed by the
-Font]readlist\f[]
and
-Font]associations\f[]
commands both in hexadecimal and in decoded short tip strings.
The codes, tips and short explanations are documented on the
.Lk decode.html "Event Messages and Status Words"
page.
The page also includes a list of system and peer messages,
the code for the latest of which is included in the status word.

.ne 2

Information resulting from protocol machine state transitions
is displayed using an informal set of ASCII strings called
.Lk decode.html#kiss "kiss codes" .
The original purpose was for kiss-o'-death (KoD) packets
sent by the server to advise the client of an unusual condition.
They are now displayed, when appropriate,
in the reference identifier field in various billboards.

<a name="system-variables"></a>

### System Variables

The following system variables appear in the
-Font]readlist\f[]
billboard.
Not all variables are displayed in some configurations.

.ne 2


* .NOP Variable  
  Description  
  .ns
* .NOP -Font]status\f[]  
  .Lk decode.html#sys "system status word"  
  .ns
* .NOP -Font]version\f[]  
  NTP software version and build time  
  .ns
* .NOP -Font]processor\f[]  
  hardware platform and version  
  .ns
* .NOP -Font]system\f[]  
  operating system and version  
  .ns
* .NOP -Font]leap\f[]  
  leap warning indicator (0-3)  
  .ns
* .NOP -Font]stratum\f[]  
  stratum (1-15)  
  .ns
* .NOP -Font]precision\f[]  
  precision (log2 s)  
  .ns
* .NOP -Font]rootdelay\f[]  
  total roundtrip delay to the primary reference clock  
  .ns
* .NOP -Font]rootdisp\f[]  
  total dispersion to the primary reference clock  
  .ns
* .NOP -Font]refid\f[]  
  reference id or
  .Lk decode.html#kiss "kiss code"  
  .ns
* .NOP -Font]reftime\f[]  
  reference time  
  .ns
* .NOP -Font]clock\f[]  
  date and time of day  
  .ns
* .NOP -Font]peer\f[]  
  system peer association id  
  .ns
* .NOP -Font]tc\f[]  
  time constant and poll exponent (log2 s) (3-17)  
  .ns
* .NOP -Font]mintc\f[]  
  minimum time constant (log2 s) (3-10)  
  .ns
* .NOP -Font]offset\f[]  
  combined offset of server relative to this host  
  .ns
* .NOP -Font]frequency\f[]  
  frequency drift (PPM) relative to hardware clock  
  .ns
* .NOP -Font]sys_jitter\f[]  
  combined system jitter  
  .ns
* .NOP -Font]clk_wander\f[]  
  clock frequency wander (PPM)  
  .ns
* .NOP -Font]clk_jitter\f[]  
  clock jitter  
  .ns
* .NOP -Font]tai\f[]  
  TAI-UTC offset (s)  
  .ns
* .NOP -Font]leapsec\f[]  
  NTP seconds when the next leap second is/was inserted  
  .ns
* .NOP -Font]expire\f[]  
  NTP seconds when the NIST leapseconds file expires

The jitter and wander statistics are exponentially-weighted RMS averages.
The system jitter is defined in the NTPv4 specification;
the clock jitter statistic is computed by the clock discipline module.

.ne 2

When the NTPv4 daemon is compiled with the OpenSSL software library,
additional system variables are displayed,
including some or all of the following,
depending on the particular Autokey dance:

* .NOP Variable  
  Description  
  .ns
* .NOP -Font]host\f[]  
  Autokey host name for this host  
  .ns
* .NOP -Font]ident\f[]  
  Autokey group name for this host  
  .ns
* .NOP -Font]flags\f[]  
  host flags  (see Autokey specification)  
  .ns
* .NOP -Font]digest\f[]  
  OpenSSL message digest algorithm  
  .ns
* .NOP -Font]signature\f[]  
  OpenSSL digest/signature scheme  
  .ns
* .NOP -Font]update\f[]  
  NTP seconds at last signature update  
  .ns
* .NOP -Font]cert\f[]  
  certificate subject, issuer and certificate flags  
  .ns
* .NOP -Font]until\f[]  
  NTP seconds when the certificate expires


<a name="peer-variables"></a>

### Peer Variables

The following peer variables appear in the
-Font]readlist\f[]
billboard for each association.
Not all variables are displayed in some configurations.

.ne 2


* .NOP Variable  
  Description  
  .ns
* .NOP -Font]associd\f[]  
  association id  
  .ns
* .NOP -Font]status\f[]  
  .Lk decode.html#peer "peer status word"  
  .ns
* .NOP -Font]srcadr\f[]  
  source (remote) IP address  
  .ns
* .NOP -Font]srcport\f[]  
  source (remote) port  
  .ns
* .NOP -Font]dstadr\f[]  
  destination (local) IP address  
  .ns
* .NOP -Font]dstport\f[]  
  destination (local) port  
  .ns
* .NOP -Font]leap\f[]  
  leap indicator (0-3)  
  .ns
* .NOP -Font]stratum\f[]  
  stratum (0-15)  
  .ns
* .NOP -Font]precision\f[]  
  precision (log2 s)  
  .ns
* .NOP -Font]rootdelay\f[]  
  total roundtrip delay to the primary reference clock  
  .ns
* .NOP -Font]rootdisp\f[]  
  total root dispersion to the primary reference clock  
  .ns
* .NOP -Font]refid\f[]  
  reference id or
  .Lk decode.html#kiss "kiss code"  
  .ns
* .NOP -Font]reftime\f[]  
  reference time  
  .ns
* .NOP -Font]rec\f[]  
  last packet received time  
  .ns
* .NOP -Font]reach\f[]  
  reach register (octal)  
  .ns
* .NOP -Font]unreach\f[]  
  unreach counter  
  .ns
* .NOP -Font]hmode\f[]  
  host mode (1-6)  
  .ns
* .NOP -Font]pmode\f[]  
  peer mode (1-5)  
  .ns
* .NOP -Font]hpoll\f[]  
  host poll exponent (log2 s) (3-17)  
  .ns
* .NOP -Font]ppoll\f[]  
  peer poll exponent (log2 s) (3-17)  
  .ns
* .NOP -Font]headway\f[]  
  headway (see
  .Lk rate.html "Rate Management and the Kiss-o'-Death Packet" )  
  .ns
* .NOP -Font]flash\f[]  
  .Lk decode.html#flash "flash status word"  
  .ns
* .NOP -Font]keyid\f[]  
  symmetric key id  
  .ns
* .NOP -Font]offset\f[]  
  filter offset  
  .ns
* .NOP -Font]delay\f[]  
  filter delay  
  .ns
* .NOP -Font]dispersion\f[]  
  filter dispersion  
  .ns
* .NOP -Font]jitter\f[]  
  filter jitter  
  .ns
* .NOP -Font]bias\f[]  
  unicast/broadcast bias  
  .ns
* .NOP -Font]xleave\f[]  
  interleave delay (see
  .Lk xleave.html "NTP Interleaved Modes" )

The
-Font]bias\f[]
variable is calculated when the first broadcast packet is received
after the calibration volley.
It represents the offset of the broadcast subgraph relative to the
unicast subgraph.
The
-Font]xleave\f[]
variable appears only for the interleaved symmetric and interleaved modes.
It represents the internal queuing, buffering and transmission delays
for the preceding packet.

.ne 2

When the NTPv4 daemon is compiled with the OpenSSL software library,
additional peer variables are displayed, including the following:

* .NOP Variable  
  Description  
  .ns
* .NOP -Font]flags\f[]  
  peer flags (see Autokey specification)  
  .ns
* .NOP -Font]host\f[]  
  Autokey server name  
  .ns
* .NOP -Font]flags\f[]  
  peer flags (see Autokey specification)  
  .ns
* .NOP -Font]signature\f[]  
  OpenSSL digest/signature scheme  
  .ns
* .NOP -Font]initsequence\f[]  
  initial key id  
  .ns
* .NOP -Font]initkey\f[]  
  initial key index  
  .ns
* .NOP -Font]timestamp\f[]  
  Autokey signature timestamp  
  .ns
* .NOP -Font]ident\f[]  
  Autokey group name for this association


<a name="clock-variables"></a>

### Clock Variables

The following clock variables appear in the
-Font]clocklist\f[]
billboard for each association with a reference clock.
Not all variables are displayed in some configurations.

* .NOP Variable  
  Description  
  .ns
* .NOP -Font]associd\f[]  
  association id  
  .ns
* .NOP -Font]status\f[]  
  .Lk decode.html#clock "clock status word"  
  .ns
* .NOP -Font]device\f[]  
  device description  
  .ns
* .NOP -Font]timecode\f[]  
  ASCII time code string (specific to device)  
  .ns
* .NOP -Font]poll\f[]  
  poll messages sent  
  .ns
* .NOP -Font]noreply\f[]  
  no reply  
  .ns
* .NOP -Font]badformat\f[]  
  bad format  
  .ns
* .NOP -Font]baddata\f[]  
  bad date or time  
  .ns
* .NOP -Font]fudgetime1\f[]  
  fudge time 1  
  .ns
* .NOP -Font]fudgetime2\f[]  
  fudge time 2  
  .ns
* .NOP -Font]stratum\f[]  
  driver stratum  
  .ns
* .NOP -Font]refid\f[]  
  driver reference id  
  .ns
* .NOP -Font]flags\f[]  
  driver flags


<a name="options"></a>

# Options


* .NOP -Font]-4\f[], \f\*[B-Font]--ipv4\f[]  
  Force IPv4 name resolution.
  This option must not appear in combination with any of the following options:
  ipv6.

Force resolution of following host names on the command line
to the IPv4 namespace.

* .NOP -Font]-6\f[], \f\*[B-Font]--ipv6\f[]  
  Force IPv6 name resolution.
  This option must not appear in combination with any of the following options:
  ipv4.

Force resolution of following host names on the command line
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
  command, peers.

Force **ntpq** to operate in interactive mode.
Prompts will be written to the standard output and
commands read from the standard input.

* .NOP -Font]-n\f[], \f\*[B-Font]--numeric\f[]  
  numeric host addresses.

Output all host addresses in dotted-quad numeric format rather than
converting to the canonical host names.

* .NOP -Font]--old-rv\f[]  
  Always output status line with readvar.

By default, **ntpq** now suppresses the **associd=...**
line that precedes the output of **readvar**
(alias **rv**) when a single variable is requested, such as
**ntpq -c "rv 0 offset"**.
This option causes **ntpq** to include both lines of output
for a single-variable **readvar**.
Using an environment variable to
preset this option in a script will enable both older and
newer **ntpq** to behave identically in this regard.

* .NOP -Font]-p\f[], \f\*[B-Font]--peers\f[]  
  Print a list of the peers.
  This option must not appear in combination with any of the following options:
  interactive.

Print a list of the peers known to the server as well as a summary
of their state. This is equivalent to the 'peers' interactive command.

* .NOP -Font]-r\f[] \f\*[I-Font]keyword\f[], \f\*[B-Font]--refid\f[]=\f\*[I-Font]keyword\f[]  
  Set default display type for S2+ refids.
  This option takes a keyword as its argument.  The argument sets an enumeration value that can
  be tested by comparing them against the option value macro.
  The available keywords are:
  .in +4
    .na
    hash ipv4
  or their numeric equivalent.
  .in -4

The default
-Font]keyword\f[]
for this option is:
.ti +4
 ipv4

Set the default display format for S2+ refids.

* .NOP -Font]-w\f[], \f\*[B-Font]--wide\f[]  
  Display the full 'remote' value.

Display the full value of the 'remote' value.  If this requires
more than 15 characters, display the full value, emit a newline,
and continue the data display properly indented on the next line.

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
      NTPQ_<option-name> or NTPQ
The environmental presets take precedence (are processed later than)
the configuration files.
The _homerc_ files are "_$HOME_", and "_._".
If any of these are directories, then the file _.ntprc_
is searched for within those directories.

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


<a name="authors"></a>

# Authors

The University of Delaware and Network Time Foundation

<a name="copyright"></a>

# Copyright

Copyright (C) 1992-2020 The University of Delaware and Network Time Foundation all rights reserved.
This program is released under the terms of the NTP license, &lt;http://ntp.org/license&gt;.

<a name="bugs"></a>

# Bugs

Please send bug reports to: http://bugs.ntp.org, bugs@ntp.org

<a name="notes"></a>

# Notes

This manual page was _AutoGen_-erated from the **ntpq**
option definitions.
