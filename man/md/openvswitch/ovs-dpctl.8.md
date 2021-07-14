# ovs\-dpctl(8)

Open vSwitch, 2.10.1


<a name="name"></a>

# Name

ovs-dpctl - administer Open vSwitch datapaths

<a name="synopsis"></a>

# Synopsis

```
ovs-dpctl [options] command [switch] [args...]
```

<a name="description"></a>

# Description


The **ovs-dpctl** program can create, modify, and delete Open vSwitch
datapaths.  A single machine may host any number of datapaths.

This program works only with datapaths that are implemented outside of
**ovs-vswitchd** itself, such as the Linux and Windows kernel-based
datapaths.  To manage datapaths that are integrated into
**ovs-vswitchd**, such as the userspace (**netdev**) datapath,
use **ovs-appctl**(8) to invoke the **dpctl/*** commands, which
are documented in **ovs-vswitchd**(8).

A newly created datapath is associated with only one network device, a
virtual network device sometimes called the datapath's \`\`local port''.
A newly created datapath is not, however, associated with any of the
host's other network devices.  To intercept and process traffic on a
given network device, use the **add-if** command to explicitly add
that network device to the datapath.

If **ovs-vswitchd**(8) is in use, use **ovs-vsctl**(8) instead
of **ovs-dpctl**.

Most **ovs-dpctl** commands that work with datapaths take an
argument that specifies the name of the datapath.  Datapath names take
the form [_type**@**]name_, where _name_ is the network
device associated with the datapath's local port.  If _type_ is
given, it specifies the datapath provider of _name_, otherwise the
default provider **system** is assumed.

The following commands manage datapaths.
.ds DX
Do not use commands to add or remove or modify datapaths if
**ovs-vswitchd** is running because this interferes with
**ovs-vswitchd**'s own datapath management.

* **add-dp _dp** [netdev_[**,option**]...]  
  Creates datapath _dp_, with a local port also named _dp_.
  This will fail if a network device _dp_ already exists.
* If _netdev_s are specified, **ovs-dpctl** adds them to the
  new datapath, just as if **add-if** was specified.
* **del-dp dp**  
  Deletes datapath _dp_.  If _dp_ is associated with any network
  devices, they are automatically removed.
* **add-if dp netdev**[**,option**]...  
  Adds each _netdev_ to the set of network devices datapath
  _dp_ monitors, where _dp_ is the name of an existing
  datapath, and _netdev_ is the name of one of the host's
  network devices, e.g. **eth0**.  Once a network device has been added
  to a datapath, the datapath has complete ownership of the network device's
  traffic and the network device appears silent to the rest of the
  system.
* A _netdev_ may be followed by a comma-separated list of options.
  The following options are currently supported:
    * **type=type**  
      Specifies the type of port to add.  The default type is **system**.
    * **port\_no=port**  
      Requests a specific port number within the datapath.  If this option is
      not specified then one will be automatically assigned.
    * key**=value**  
      Adds an arbitrary key-value option to the port's configuration.
* **ovs-vswitchd.conf.db**(5) documents the available port types and
  options.
* **set-if dp port**[**,option**]...  
  Reconfigures each _port_ in _dp_ as specified.  An
  _option_ of the form key**=value** adds the specified
  key-value option to the port or overrides an existing key's value.  An
  _option_ of the form key**=**, that is, without a value,
  deletes the key-value named _key_.  The type and port number of a
  port cannot be changed, so **type** and **port\_no** are only allowed if
  they match the existing configuration.
* **del-if dp netdev**...  
  Removes each _netdev_ from the list of network devices datapath
  _dp_ monitors.
* **dump-dps**  
  Prints the name of each configured datapath on a separate line.
* .DO "[**-s** | **--statistics**]" "**show" "**[_dp_...]"  
  Prints a summary of configured datapaths, including their datapath
  numbers and a list of ports connected to each datapath.  (The local
  port is identified as port 0.)  If **-s** or **--statistics**
  is specified, then packet and byte counters are also printed for each
  port.
* The datapath numbers consists of flow stats and mega flow mask stats.
* The "lookups" row displays three stats related to flow lookup triggered
  by processing incoming packets in the datapath. "hit" displays number
  of packets matches existing flows. "missed" displays the number of
  packets not matching any existing flow and require user space processing.
  "lost" displays number of packets destined for user space process but
  subsequently dropped before reaching userspace. The sum of "hit" and "miss"
  equals to the total number of packets datapath processed.
* The "flows" row displays the number of flows in datapath.
* The "masks" row displays the mega flow mask stats. This row is omitted
  for datapath not implementing mega flow. "hit" displays the total number
  of masks visited for matching incoming packets. "total" displays number of
  masks in the datapath. "hit/pkt" displays the average number of masks
  visited per packet; the ratio between "hit" and total number of
  packets processed by the datapath.
* If one or more datapaths are specified, information on only those
  datapaths are displayed.  Otherwise, **ovs-dpctl** displays information
  about all configured datapaths.

<a name="datapath-flow-table-debugging-commands"></a>

### DATAPATH FLOW TABLE DEBUGGING COMMANDS

The following commands are primarily useful for debugging Open
vSwitch.  The flow table entries (both matches and actions) that they
work with are not OpenFlow flow entries.  Instead, they are different
and considerably simpler flows maintained by the Open vSwitch kernel
module.  Do not use commands to add or remove or modify datapath flows
if **ovs-vswitchd** is running because it interferes with
**ovs-vswitchd**'s own datapath flow management.  Use
**ovs-ofctl**(8), instead, to work with OpenFlow flow entries.

The _dp_ argument to each of these commands is optional when
exactly one datapath exists, in which case that datapath is the
default.  When multiple datapaths exist, then a datapath name is
required.

* .DO "[**-m **| **--more**] [**--names **| **--no-names**]" **dump-flows** "[_dp_] [**filter=filter**] [**type=type**]"  
  Prints to the console all flow entries in datapath _dp_'s flow
  table.  Without **-m** or **--more**, output omits match fields
  that a flow wildcards entirely; with **-m** or **--more**,
  output includes all wildcarded fields.
* If **filter=filter** is specified, only displays the flows
  that match the _filter_. _filter_ is a flow in the form similiar
  to that accepted by **ovs-ofctl**(8)'s **add-flow** command. (This is
  not an OpenFlow flow: besides other differences, it never contains wildcards.)
  The _filter_ is also useful to match wildcarded fields in the datapath
  flow. As an example, **filter='tcp,tp\_src=100'** will match the
  datapath flow containing '**tcp(src=80/0xff00,dst=8080/0xff)**'.
* If **type=type** is specified, only displays flows of a specific type.
  _type_ can be **offloaded** to display only rules offloaded to the HW
  or **ovs** to display only rules from the OVS tables.
  By default all rules are displayed.
* **add-flow** [_dp_] _flow actions_  
* .DO "[**--clear**] [**--may-create**] [**-s** | **--statistics**]" "**mod-flow**" "[_dp_] _flow actions_"  
  Adds or modifies a flow in _dp_'s flow table that, when a packet
  matching _flow_ arrives, causes _actions_ to be executed.
* The **add-flow** command succeeds only if _flow_ does not
  already exist in _dp_.  Contrariwise, **mod-flow** without
  **--may-create** only modifies the actions for an existing flow.
  With **--may-create**, **mod-flow** will add a new flow or
  modify an existing one.
* If **-s** or **--statistics** is specified, then
  **mod-flow** prints the modified flow's statistics.  A flow's
  statistics are the number of packets and bytes that have passed
  through the flow, the elapsed time since the flow last processed a
  packet (if ever), and (for TCP flows) the union of the TCP flags
  processed through the flow.
* With **--clear**, **mod-flow** zeros out the flow's
  statistics.  The statistics printed if **-s** or
  **--statistics** is also specified are those from just before
  clearing the statistics.
* NOTE:
  _flow_ and _actions_ do not match the syntax used with
  **ovs-ofctl**(8)'s **add-flow** command.
* **Usage Examples**

Forward ARP between ports 1 and 2 on datapath myDP:

* ovs-dpctl add-flow myDP \.
    "in_port(1),eth(),eth_type(0x0806),arp()" 2
* ovs-dpctl add-flow myDP \.
    "in_port(2),eth(),eth_type(0x0806),arp()" 1

Forward all IPv4 traffic between two addresses on ports 1 and 2:

* ovs-dpctl add-flow myDP \.
    "in_port(1),eth(),eth_type(0x800),&nbsp;  ipv4(src=172.31.110.4,dst=172.31.110.5)" 2
* ovs-dpctl add-flow myDP \.
    "in_port(2),eth(),eth_type(0x800),&nbsp;  ipv4(src=172.31.110.5,dst=172.31.110.4)" 1

* .DO "[**-s** | **--statistics**]" "**del-flow**" "[_dp_] _flow_"  
  Deletes the flow from _dp_'s flow table that matches _flow_.
  If **-s** or **--statistics** is specified, then
  **del-flow** prints the deleted flow's statistics.
* .DO "[**-m **| **--more**] [**--names **| **--no-names**]" "**get-flow** [_dp_] ufid:_ufid_"  
  Fetches the flow from _dp_'s flow table with unique identifier _ufid_.
  _ufid_ must be specified as a string of 32 hexadecimal characters.
* **del-flows** [_dp_]  
  Deletes all flow entries from datapath _dp_'s flow table.

<a name="connection-tracking-table-commands"></a>

### CONNECTION TRACKING TABLE COMMANDS

The following commands are useful for debugging and configuring
the connection tracking table in the datapath.

The _dp_ argument to each of these commands is optional when
exactly one datapath exists, in which case that datapath is the
default.  When multiple datapaths exist, then a datapath name is
required.

**N.B.**(Linux specific): the _system_ datapaths (i.e. the Linux
kernel module Open vSwitch datapaths) share a single connection tracking
table (which is also used by other kernel subsystems, such as iptables,
nftables and the regular host stack).  Therefore, the following commands
do not apply specifically to one datapath.

* .DO "[**-m** | **--more**] [**-s** | **--statistics**]" "**dump-conntrack**" "[_dp_] [**zone=zone**]"  
  Prints to the console all the connection entries in the tracker used by
  _dp_.  If **zone=zone** is specified, only shows the connections
  in _zone_.  With **--more**, some implementation specific details
  are included. With **--statistics** timeouts and timestamps are
  added to the output.
* **flush-conntrack** [_dp_] [**zone=_zone**] [ct-tuple_]  
  Flushes the connection entries in the tracker used by _dp_ based on
  _zone_ and connection tracking tuple _ct-tuple_.
  If _ct-tuple_ is not provided, flushes all the connection entries.
  If **zone**=_zone_ is specified, only flushes the connections in
  _zone_.
* If _ct-tuple_ is provided, flushes the connection entry specified by
  _ct-tuple_ in _zone_. The zone defaults to 0 if it is not provided.
  An example of an IPv4 ICMP _ct-tuple_:
* "ct_nw_src=10.1.1.1,ct_nw_dst=10.1.1.2,ct_nw_proto=1,icmp_type=8,icmp_code=0,icmp_id=10"
* An example of an IPv6 TCP _ct-tuple_:
* "ct_ipv6_src=fc00::1,ct_ipv6_dst=fc00::2,ct_nw_proto=6,ct_tp_src=1,ct_tp_dst=2"
* .DO "[**-m** | **--more**]" "**ct-stats-show** [_dp_] [**zone=zone**]"  
  Displays the number of connections grouped by protocol used by _dp_.
  If **zone=zone** is specified, numbers refer to the connections in
  _zone_.  With **--more**, groups by connection state for each
  protocol.
* **ct-bkts** [_dp_] [**gt=threshold**]  
  For each conntrack bucket, displays the number of connections used
  by _dp_.
  If **gt=threshold** is specified, bucket numbers are displayed when
  the number of connections in a bucket is greater than _threshold_.
* **ct-set-maxconns** [_dp_] _maxconns_  
  Sets the maximum limit of connection tracker entries to _maxconns_
  on _dp_.  This can be used to reduce the processing load on the
  system due to connection tracking or simply limiting connection
  tracking.  If the number of connections is already over the new maximum
  limit request then the new maximum limit will be enforced when the
  number of connections decreases to that limit, which normally happens
  due to connection expiry.  Only supported for userspace datapath.
* **ct-get-maxconns** [_dp_]  
  Prints the maximum limit of connection tracker entries on _dp_.
  Only supported for userspace datapath.
* **ct-get-nconns** [_dp_]  
  Prints the current number of connection tracker entries on _dp_.
  Only supported for userspace datapath.
* **ct-set-limits** [_dp_] [**default=default\_limit**] [**zone=zone**,**limit=limit**]...  
  Sets the maximum allowed number of connections in a connection tracking
  zone.  A specific _zone_ may be set to _limit_, and multiple zones
  may be specified with a comma-separated list.  If a per-zone limit for a
  particular zone is not specified in the datapath, it defaults to the
  default per-zone limit.  A default zone may be specified with the
  **default=default\_limit** argument.   Initially, the default
  per-zone limit is unlimited.  An unlimited number of entries may be set
  with **0** limit.  Only supported for Linux kernel datapath.
* **ct-del-limits** [_dp_] **zone=zone[,zone]**...  
  Deletes the connection tracking limit for _zone_.  Multiple zones may
  be specified with a comma-separated list.  Only supported for Linux
  kernel datapath.
* **ct-get-limits** [_dp_] [**zone=zone**[**,zone**]...]  
  Retrieves the maximum allowed number of connections and current
  counts per-zone.  If _zone_ is given, only the specified zone(s) are
  printed.  If no zones are specified, all the zone limits and counts are
  provided.  The command always displays the default zone limit.  Only
  supported for Linux kernel datapath.

<a name="options"></a>

# Options


* **-t**  
  .IQ "**--timeout=secs**"
  Limits **ovs-dpctl** runtime to approximately _secs_ seconds.  If
  the timeout expires, **ovs-dpctl** will exit with a **SIGALRM**
  signal.
* .IQ "**--verbose=**[_spec_]
  Sets logging levels.  Without any _spec_, sets the log level for
  every module and destination to **dbg**.  Otherwise, _spec_ is a
  list of words separated by spaces or commas or colons, up to one from
  each category below:
    * ·  
      A valid module name, as displayed by the **vlog/list** command on
      **ovs-appctl**(8), limits the log level change to the specified
      module.
    * ·  
      **syslog**, **console**, or **file**, to limit the log level
      change to only to the system log, to the console, or to a file,
      respectively.  (If **--detach** is specified, **ovs-dpctl** closes
      its standard file descriptors, so logging to the console will have no
      effect.)
    * On Windows platform, **syslog** is accepted as a word and is only
      useful along with the **--syslog-target** option (the word has no
      effect otherwise).
    * ·  
      **off**, **emer**, **err**, **warn**, **info**, or
      **dbg**, to control the log level.  Messages of the given severity
      or higher will be logged, and messages of lower severity will be
      filtered out.  **off** filters out all messages.  See
      **ovs-appctl**(8) for a definition of each log level.
* Case is not significant within _spec_.
* Regardless of the log levels set for **file**, logging to a file
  will not take place unless **--log-file** is also specified (see
  below).
* For compatibility with older versions of OVS, **any** is accepted as
  a word but has no effect.
* **-v**  
  .IQ "**--verbose**"
  Sets the maximum logging verbosity level, equivalent to
  **--verbose=dbg**.
* **-vPATTERN:destination:pattern**  
  .IQ "**--verbose=PATTERN:destination:pattern**"
  Sets the log pattern for _destination_ to _pattern_.  Refer to
  **ovs-appctl**(8) for a description of the valid syntax for _pattern_.
* **-vFACILITY:facility**  
  .IQ "**--verbose=FACILITY:facility**"
  Sets the RFC5424 facility of the log message. _facility_ can be one of
  **kern**, **user**, **mail**, **daemon**, **auth**, **syslog**,
  **lpr**, **news**, **uucp**, **clock**, **ftp**, **ntp**,
  **audit**, **alert**, **clock2**, **local0**, **local1**,
  **local2**, **local3**, **local4**, **local5**, **local6** or
  **local7**. If this option is not specified, **daemon** is used as
  the default for the local system syslog and **local0** is used while sending
  a message to the target provided via the **--syslog-target** option.
* **--log-file**[**=file**]  
  Enables logging to a file.  If _file_ is specified, then it is
  used as the exact name for the log file.  The default log file name
  used if _file_ is omitted is **/var/log/openvswitch/ovs-dpctl.log**.
* **--syslog-target=host:port**  
  Send syslog messages to UDP _port_ on _host_, in addition to
  the system syslog.  The _host_ must be a numerical IP address, not
  a hostname.
* **--syslog-method=method**  
  Specify _method_ how syslog messages should be sent to syslog daemon.
  Following forms are supported:
    * ·  
      **libc**, use libc **syslog()** function.  This is the default behavior.
      Downside of using this options is that libc adds fixed prefix to every
      message before it is actually sent to the syslog daemon over **/dev/log**
      UNIX domain socket.
    * ·  
      **unix:file**, use UNIX domain socket directly.  It is possible to
      specify arbitrary message format with this option.  However,
      **rsyslogd 8.9** and older versions use hard coded parser function anyway
      that limits UNIX domain socket use.  If you want to use arbitrary message
      format with older **rsyslogd** versions, then use UDP socket to localhost
      IP address instead.
    * ·  
      **udp:_ip**:port_, use UDP socket.  With this method it is
      possible to use arbitrary message format also with older **rsyslogd**.
      When sending syslog messages over UDP socket extra precaution needs to
      be taken into account, for example, syslog daemon needs to be configured
      to listen on the specified UDP port, accidental iptables rules could be
      interfering with local syslog traffic and there are some security
      considerations that apply to UDP sockets, but do not apply to UNIX domain
      sockets.
* **-h**  
  .IQ "**--help**"
  Prints a brief help message to the console.
* **-V**  
  .IQ "**--version**"
  Prints version information to the console.

<a name="see-also"></a>

# See Also

**ovs-appctl**(8),
**ovs-vswitchd**(8)
