# ovs\-vswitchd(8)

Open vSwitch, 2.10.1


<a name="name"></a>

# Name

ovs-vswitchd - Open vSwitch daemon

<a name="synopsis"></a>

# Synopsis

```
ovs-vswitchd [database]
```

<a name="description"></a>

# Description

A daemon that manages and controls any number of Open vSwitch switches
on the local machine.

The _database_ argument specifies how **ovs-vswitchd** connects
to **ovsdb-server**.  _database_ may be an OVSDB active or
passive connection method, as described in **ovsdb**(7).  The
default is **unix:/var/run/openvswitch/db.sock**.

**ovs-vswitchd** retrieves its configuration from _database_ at
startup.  It sets up Open vSwitch datapaths and then operates
switching across each bridge described in its configuration files.  As
the database changes, **ovs-vswitchd** automatically updates its
configuration to match.

**ovs-vswitchd** switches may be configured with any of the following
features:

* ·  
  L2 switching with MAC learning.
* ·  
  NIC bonding with automatic fail-over and source MAC-based TX load
  balancing ("SLB").
* ·  
  802.1Q VLAN support.
* ·  
  Port mirroring, with optional VLAN tagging.
* ·  
  NetFlow v5 flow logging.
* ·  
  sFlow(R) monitoring.
* ·  
  Connectivity to an external OpenFlow controller, such as NOX.

Only a single instance of **ovs-vswitchd** is intended to run at a time.
A single **ovs-vswitchd** can manage any number of switch instances, up
to the maximum number of supported Open vSwitch datapaths.

**ovs-vswitchd** does all the necessary management of Open vSwitch
datapaths itself.  Thus, **ovs-dpctl**(8) (and its userspace
datapath counterparts accessible via ovs-appctl
dpctl/_command_) are not needed with **ovs-vswitchd** and should
not be used because they can interfere with its operation.  These
tools are still useful for diagnostics.

An Open vSwitch datapath kernel module must be loaded for **ovs-vswitchd**
to be useful.  Refer to the documentation for instructions on how to build and
load the Open vSwitch kernel module.


<a name="options"></a>

# Options


* **--mlockall**  
  Causes **ovs-vswitchd** to call the **mlockall()** function, to
  attempt to lock all of its process memory into physical RAM,
  preventing the kernel from paging any of its memory to disk.  This
  helps to avoid networking interruptions due to system memory pressure.
* Some systems do not support **mlockall()** at all, and other systems
  only allow privileged users, such as the superuser, to use it.
  **ovs-vswitchd** emits a log message if **mlockall()** is
  unavailable or unsuccessful.

<a name="dpdk-options"></a>

### DPDK Options

For details on initializing the **ovs-vswitchd** DPDK datapath,
refer to the documentation or **ovs-vswitchd.conf.db**(5) for
details.

<a name="daemon-options"></a>

### Daemon Options


The following options are valid on POSIX based platforms.

* **--pidfile**[**=pidfile**]  
  Causes a file (by default, **ovs-vswitchd.pid**) to be created indicating
  the PID of the running process.  If the _pidfile_ argument is not
  specified, or
  if it does not begin with **/**, then it is created in
  **/var/run/openvswitch**.
* If **--pidfile** is not specified, no pidfile is created.
* **--overwrite-pidfile**  
  By default, when **--pidfile** is specified and the specified pidfile 
  already exists and is locked by a running process, **ovs-vswitchd** refuses 
  to start.  Specify **--overwrite-pidfile** to cause it to instead 
  overwrite the pidfile.
* When **--pidfile** is not specified, this option has no effect.
* **--detach**  
  Runs **ovs-vswitchd** as a background process.  The process forks, and in
  the child it starts a new session, closes the standard file
  descriptors (which has the side effect of disabling logging to the
  console), and changes its current directory to the root (unless
  **--no-chdir** is specified).  After the child completes its
  initialization, the parent exits.  **ovs-vswitchd** detaches only after it has connected to the database, retrieved the initial configuration, and set up that configuration.
* **--monitor**  
  Creates an additional process to monitor the **ovs-vswitchd** daemon.  If
  the daemon dies due to a signal that indicates a programming error
  (**SIGABRT**, **SIGALRM**, **SIGBUS**, **SIGFPE**,
  **SIGILL**, **SIGPIPE**, **SIGSEGV**, **SIGXCPU**, or
  **SIGXFSZ**) then the monitor process starts a new copy of it.  If
  the daemon dies or exits for another reason, the monitor process exits.
* This option is normally used with **--detach**, but it also
  functions without it.
* **--no-chdir**  
  By default, when **--detach** is specified, **ovs-vswitchd** 
  changes its current working directory to the root directory after it 
  detaches.  Otherwise, invoking **ovs-vswitchd** from a carelessly chosen 
  directory would prevent the administrator from unmounting the file 
  system that holds that directory.
* Specifying **--no-chdir** suppresses this behavior, preventing
  **ovs-vswitchd** from changing its current working directory.  This may be 
  useful for collecting core files, since it is common behavior to write 
  core dumps into the current working directory and the root directory 
  is not a good directory to use.
* This option has no effect when **--detach** is not specified.
* **--no-self-confinement**  
  By default daemon will try to self-confine itself to work with
  files under well-know, at build-time whitelisted directories.  It
  is better to stick with this default behavior and not to use this
  flag unless some other Access Control is used to confine daemon.
  Note that in contrast to other access control implementations that
  are typically enforced from kernel-space (e.g. DAC or MAC),
  self-confinement is imposed from the user-space daemon itself and
  hence should not be considered as a full confinement strategy, but
  instead should be viewed as an additional layer of security.
* **--user**  
  Causes **ovs-vswitchd** to run as a different user specified in "user:group", thus
  dropping most of the root privileges. Short forms "user" and ":group" are also
  allowed, with current user or group are assumed respectively. Only daemons
  started by the root user accepts this argument.
* On Linux, daemons will be granted CAP_IPC_LOCK and CAP_NET_BIND_SERVICES
  before dropping root privileges. Daemons that interact with a datapath,
  such as **ovs-vswitchd**, will be granted three additional capabilities,
  namely CAP_NET_ADMIN, CAP_NET_BROADCAST and CAP_NET_RAW.  The capability
  change will apply even if the new user is root.
* On Windows, this option is not currently supported. For security reasons,
  specifying this option will cause the daemon process not to start.

<a name="service-options"></a>

### Service Options

The following options are valid only on Windows platform.

* **--service**  
  Causes **ovs-vswitchd** to run as a service in the background. The service
  should already have been created through external tools like **SC.exe**.
* **--service-monitor**  
  Causes the **ovs-vswitchd** service to be automatically restarted by the Windows
  services manager if the service dies or exits for unexpected reasons.
* When **--service** is not specified, this option has no effect.

<a name="public-key-infrastructure-options"></a>

### Public Key Infrastructure Options


* **-p** _privkey.pem_  
  .IQ "**--private-key=privkey.pem**"
  Specifies a PEM file containing the private key used as **ovs-vswitchd**'s
  identity for outgoing SSL connections.
* **-c** _cert.pem_  
  .IQ "**--certificate=cert.pem**"
  Specifies a PEM file containing a certificate that certifies the
  private key specified on **-p** or **--private-key** to be
  trustworthy.  The certificate must be signed by the certificate
  authority (CA) that the peer in SSL connections will use to verify it.
* **-C** _cacert.pem_  
  .IQ "**--ca-cert=cacert.pem**"
  Specifies a PEM file containing the CA certificate that **ovs-vswitchd**
  should use to verify certificates presented to it by SSL peers.  (This
  may be the same certificate that SSL peers use to verify the
  certificate specified on **-c** or **--certificate**, or it may
  be a different one, depending on the PKI design in use.)
* **-C none**  
  .IQ "**--ca-cert=none**"
  Disables verification of certificates presented by SSL peers.  This
  introduces a security risk, because it means that certificates cannot
  be verified to be those of known trusted hosts.
* **--bootstrap-ca-cert=cacert.pem**  
  When _cacert.pem_ exists, this option has the same effect as
  **-C** or **--ca-cert**.  If it does not exist, then
  **ovs-vswitchd** will attempt to obtain the CA certificate from the
  SSL peer on its first SSL connection and save it to the named PEM
  file.  If it is successful, it will immediately drop the connection
  and reconnect, and from then on all SSL connections must be
  authenticated by a certificate signed by the CA certificate thus
  obtained.
* This option exposes the SSL connection to a man-in-the-middle
  attack obtaining the initial CA certificate, but it may be useful
  for bootstrapping.
* This option is only useful if the SSL peer sends its CA certificate as
  part of the SSL certificate chain.  The SSL protocol does not require
  the server to send the CA certificate.
* This option is mutually exclusive with **-C** and
  **--ca-cert**.
* **--peer-ca-cert=peer-cacert.pem**  
  Specifies a PEM file that contains one or more additional certificates
  to send to SSL peers.  _peer-cacert.pem_ should be the CA
  certificate used to sign **ovs-vswitchd**'s own certificate, that is, the
  certificate specified on **-c** or **--certificate**.  If
  **ovs-vswitchd**'s certificate is self-signed, then **--certificate**
  and **--peer-ca-cert** should specify the same file.
* This option is not useful in normal operation, because the SSL peer
  must already have the CA certificate for the peer to have any
  confidence in **ovs-vswitchd**'s identity.  However, this offers a way for
  a new installation to bootstrap the CA certificate on its first SSL
  connection.

<a name="logging-options"></a>

### Logging Options


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
      respectively.  (If **--detach** is specified, **ovs-vswitchd** closes
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
  used if _file_ is omitted is **/var/log/openvswitch/ovs-vswitchd.log**.
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

<a name="other-options"></a>

### Other Options


* **--unixctl=socket**  
  Sets the name of the control socket on which **ovs-vswitchd** listens for
  runtime management commands (see **RUNTIME MANAGEMENT COMMANDS**,
  below).  If _socket_ does not begin with **/**, it is
  interpreted as relative to **/var/run/openvswitch**.  If **--unixctl** is
  not used at all, the default socket is
  **/var/run/openvswitch/ovs-vswitchd._pid.ctl**, where pid_ is **ovs-vswitchd**'s
  process ID.
* On Windows a local named pipe is used to listen for runtime management
  commands.  A file is created in the absolute path as pointed by
  _socket_ or if **--unixctl** is not used at all, a file is
  created as **ovs-vswitchd.ctl** in the configured _OVS\_RUNDIR_
  directory.  The file exists just to mimic the behavior of a Unix domain socket.
* Specifying **none** for _socket_ disables the control socket
  feature.
* **-h**  
  .IQ "**--help**"
  Prints a brief help message to the console.
* **-V**  
  .IQ "**--version**"
  Prints version information to the console.

<a name="runtime-management-commands"></a>

# Runtime Management Commands

**ovs-appctl**(8) can send commands to a running
**ovs-vswitchd** process.  The currently supported commands are
described below.  The command descriptions assume an understanding of
how to configure Open vSwitch.

<a name="general-commands"></a>

### GENERAL COMMANDS


* **exit** _--cleanup_  
  Causes **ovs-vswitchd** to gracefully terminate. If _--cleanup_
  is specified, release datapath resources configured by **ovs-vswitchd**.
  Otherwise, datapath flows and other resources remains undeleted.
* **qos/show-types** _interface_  
  Queries the interface for a list of Quality of Service types that are
  configurable via Open vSwitch for the given _interface_.
* **qos/show** _interface_  
  Queries the kernel for Quality of Service configuration and statistics
  associated with the given _interface_.
* **bfd/show** [_interface_]  
  Displays detailed information about Bidirectional Forwarding Detection
  configured on _interface_.  If _interface_ is not specified,
  then displays detailed information about all interfaces with BFD
  enabled.
* **bfd/set-forwarding** [_interface_] _status_  
  Force the fault status of the BFD module on _interface_ (or all
  interfaces if none is given) to be _status_.  _status_ can be
  "true", "false", or "normal" which reverts to the standard behavior.
* **cfm/show** [_interface_]  
  Displays detailed information about Connectivity Fault Management
  configured on _interface_.  If _interface_ is not specified,
  then displays detailed information about all interfaces with CFM
  enabled.
* **cfm/set-fault** [_interface_] _status_  
  Force the fault status of the CFM module on _interface_ (or all
  interfaces if none is given) to be _status_.  _status_ can be
  "true", "false", or "normal" which reverts to the standard behavior.
* **stp/tcn** [_bridge_]  
  Forces a topology change event on _bridge_ if it's running STP.  This
  may cause it to send Topology Change Notifications to its peers and flush
  its MAC table.  If no _bridge_ is given, forces a topology change
  event on all bridges.
* **stp/show** [_bridge_]  
  Displays detailed information about spanning tree on the _bridge_.  If
  _bridge_ is not specified, then displays detailed information about all
  bridges with STP enabled.
* **rstp/tcn** [_bridge_]  
  Forces a topology change event on _bridge_ if it's running RSTP.  This
  may cause it to send Topology Change Notifications to its peers and flush
  its MAC table.  If no _bridge_ is given, forces a topology change
  event on all bridges.
* **rstp/show** [_bridge_]  
  Displays detailed information about rapid spanning tree on the _bridge_.
  If _bridge_ is not specified, then displays detailed information about all
  bridges with RSTP enabled.

<a name="bridge-commands"></a>

### BRIDGE COMMANDS

These commands manage bridges.

* **fdb/flush** [_bridge_]  
  Flushes _bridge_ MAC address learning table, or all learning tables
  if no _bridge_ is given.
* **fdb/show** _bridge_  
  Lists each MAC address/VLAN pair learned by the specified _bridge_,
  along with the port on which it was learned and the age of the entry,
  in seconds.
* **fdb/stats-clear** [_bridge_]  
  Clear _bridge_ MAC address learning table statistics, or all
  statistics if no _bridge_ is given.
* **fdb/stats-show** _bridge_  
  Show MAC address learning table statistics for the specified _bridge_.
* **mdb/flush** [_bridge_]  
  Flushes _bridge_ multicast snooping table, or all snooping tables
  if no _bridge_ is given.
* **mdb/show** _bridge_  
  Lists each multicast group/VLAN pair learned by the specified _bridge_,
  along with the port on which it was learned and the age of the entry,
  in seconds.
* **bridge/reconnect** [_bridge_]  
  Makes _bridge_ drop all of its OpenFlow controller connections and
  reconnect.  If _bridge_ is not specified, then all bridges drop
  their controller connections and reconnect.
* This command might be useful for debugging OpenFlow controller issues.
* **bridge/dump-flows** _bridge_  
  Lists all flows in _bridge_, including those normally hidden to
  commands such as **ovs-ofctl dump-flows**.  Flows set up by mechanisms
  such as in-band control and fail-open are hidden from the controller
  since it is not allowed to modify or override them.

<a name="bond-commands"></a>

### BOND COMMANDS

These commands manage bonded ports on an Open vSwitch's bridges.  To
understand some of these commands, it is important to understand a
detail of the bonding implementation called \`\`source load balancing''
(SLB).  Instead of directly assigning Ethernet source addresses to
slaves, the bonding implementation computes a function that maps an
48-bit Ethernet source addresses into an 8-bit value (a \`\`MAC hash''
value).  All of the Ethernet addresses that map to a single 8-bit
value are then assigned to a single slave.

* **bond/list**  
  Lists all of the bonds, and their slaves, on each bridge.
* **bond/show** [_port_]  
  Lists all of the bond-specific information (updelay, downdelay, time
  until the next rebalance) about the given bonded _port_, or all
  bonded ports if no _port_ is given.  Also lists information about
  each slave: whether it is enabled or disabled, the time to completion
  of an updelay or downdelay if one is in progress, whether it is the
  active slave, the hashes assigned to the slave.  Any LACP information
  related to this bond may be found using the **lacp/show** command.
* **bond/migrate** _port_ _hash_ _slave_  
  Only valid for SLB bonds.  Assigns a given MAC hash to a new slave.
  _port_ specifies the bond port, _hash_ the MAC hash to be
  migrated (as a decimal number between 0 and 255), and _slave_ the
  new slave to be assigned.
* The reassignment is not permanent: rebalancing or fail-over will
  cause the MAC hash to be shifted to a new slave in the usual
  manner.
* A MAC hash cannot be migrated to a disabled slave.
* **bond/set-active-slave** _port_ _slave_  
  Sets _slave_ as the active slave on _port_.  _slave_ must
  currently be enabled.
* The setting is not permanent: a new active slave will be selected
  if _slave_ becomes disabled.
* **bond/enable-slave** _port_ _slave_  
  .IQ "**bond/disable-slave** _port_ _slave_"
  Enables (or disables) _slave_ on the given bond _port_, skipping any
  updelay (or downdelay).
* This setting is not permanent: it persists only until the carrier
  status of _slave_ changes.
* **bond/hash** _mac_ [_vlan_] [_basis_]  
  Returns the hash value which would be used for _mac_ with _vlan_
  and _basis_ if specified.
* **lacp/show** [_port_]  
  Lists all of the LACP related information about the given _port_:
  active or passive, aggregation key, system id, and system priority.  Also
  lists information about each slave: whether it is enabled or disabled,
  whether it is attached or detached, port id and priority, actor
  information, and partner information.  If _port_ is not specified,
  then displays detailed information about all interfaces with CFM
  enabled.
* **lacp/stats-show** [_port_]  
  Lists various stats about LACP PDUs (number of RX/TX PDUs, bad PDUs received)
  and slave state (number of time slave's state expired/defaulted and carrier
  status changed) for the given _port_.  If _port_ is not specified,
  then displays stats of all interfaces with LACP enabled.

<a name="dpctl-datapath-debugging-commands"></a>

### DPCTL DATAPATH DEBUGGING COMMANDS

The primary way to configure **ovs-vswitchd** is through the Open
vSwitch database, e.g. using **ovs-vsctl**(8).  These commands
provide a debugging interface for managing datapaths.  They implement
the same features (and syntax) as **ovs-dpctl**(8).  Unlike
**ovs-dpctl**(8), these commands work with datapaths that are
integrated into **ovs-vswitchd** (e.g. the **netdev** datapath
type).

Do not use commands to add or remove or modify datapaths if
**ovs-vswitchd** is running because this interferes with
**ovs-vswitchd**'s own datapath management.

* **dpctl/****add-dp _dp** [netdev_[**,option**]...]  
  Creates datapath _dp_, with a local port also named _dp_.
  This will fail if a network device _dp_ already exists.
* If _netdev_s are specified, **ovs-vswitchd** adds them to the
  new datapath, just as if **add-if** was specified.
* **dpctl/****del-dp dp**  
  Deletes datapath _dp_.  If _dp_ is associated with any network
  devices, they are automatically removed.
* **dpctl/****add-if dp netdev**[**,option**]...  
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
* **dpctl/****set-if dp port**[**,option**]...  
  Reconfigures each _port_ in _dp_ as specified.  An
  _option_ of the form key**=value** adds the specified
  key-value option to the port or overrides an existing key's value.  An
  _option_ of the form key**=**, that is, without a value,
  deletes the key-value named _key_.  The type and port number of a
  port cannot be changed, so **type** and **port\_no** are only allowed if
  they match the existing configuration.
* **dpctl/****del-if dp netdev**...  
  Removes each _netdev_ from the list of network devices datapath
  _dp_ monitors.
* **dpctl/****dump-dps**  
  Prints the name of each configured datapath on a separate line.
* .DO "[**-s** | **--statistics**]" "**dpctl/****show" "**[_dp_...]"  
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
  datapaths are displayed.  Otherwise, **ovs-vswitchd** displays information
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

* .DO "[**-m **| **--more**] [**--names **| **--no-names**]" **dpctl/****dump-flows** "[_dp_] [**filter=filter**] [**type=type**]"  
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
* **dpctl/****add-flow** [_dp_] _flow actions_  
* .DO "[**--clear**] [**--may-create**] [**-s** | **--statistics**]" "**dpctl/****mod-flow**" "[_dp_] _flow actions_"  
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

* .DO "[**-s** | **--statistics**]" "**dpctl/****del-flow**" "[_dp_] _flow_"  
  Deletes the flow from _dp_'s flow table that matches _flow_.
  If **-s** or **--statistics** is specified, then
  **del-flow** prints the deleted flow's statistics.
* .DO "[**-m **| **--more**] [**--names **| **--no-names**]" "**dpctl/****get-flow** [_dp_] ufid:_ufid_"  
  Fetches the flow from _dp_'s flow table with unique identifier _ufid_.
  _ufid_ must be specified as a string of 32 hexadecimal characters.
* **dpctl/****del-flows** [_dp_]  
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

* .DO "[**-m** | **--more**] [**-s** | **--statistics**]" "**dpctl/****dump-conntrack**" "[_dp_] [**zone=zone**]"  
  Prints to the console all the connection entries in the tracker used by
  _dp_.  If **zone=zone** is specified, only shows the connections
  in _zone_.  With **--more**, some implementation specific details
  are included. With **--statistics** timeouts and timestamps are
  added to the output.
* **dpctl/****flush-conntrack** [_dp_] [**zone=_zone**] [ct-tuple_]  
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
* .DO "[**-m** | **--more**]" "**dpctl/****ct-stats-show** [_dp_] [**zone=zone**]"  
  Displays the number of connections grouped by protocol used by _dp_.
  If **zone=zone** is specified, numbers refer to the connections in
  _zone_.  With **--more**, groups by connection state for each
  protocol.
* **dpctl/****ct-bkts** [_dp_] [**gt=threshold**]  
  For each conntrack bucket, displays the number of connections used
  by _dp_.
  If **gt=threshold** is specified, bucket numbers are displayed when
  the number of connections in a bucket is greater than _threshold_.
* **dpctl/****ct-set-maxconns** [_dp_] _maxconns_  
  Sets the maximum limit of connection tracker entries to _maxconns_
  on _dp_.  This can be used to reduce the processing load on the
  system due to connection tracking or simply limiting connection
  tracking.  If the number of connections is already over the new maximum
  limit request then the new maximum limit will be enforced when the
  number of connections decreases to that limit, which normally happens
  due to connection expiry.  Only supported for userspace datapath.
* **dpctl/****ct-get-maxconns** [_dp_]  
  Prints the maximum limit of connection tracker entries on _dp_.
  Only supported for userspace datapath.
* **dpctl/****ct-get-nconns** [_dp_]  
  Prints the current number of connection tracker entries on _dp_.
  Only supported for userspace datapath.
* **dpctl/****ct-set-limits** [_dp_] [**default=default\_limit**] [**zone=zone**,**limit=limit**]...  
  Sets the maximum allowed number of connections in a connection tracking
  zone.  A specific _zone_ may be set to _limit_, and multiple zones
  may be specified with a comma-separated list.  If a per-zone limit for a
  particular zone is not specified in the datapath, it defaults to the
  default per-zone limit.  A default zone may be specified with the
  **default=default\_limit** argument.   Initially, the default
  per-zone limit is unlimited.  An unlimited number of entries may be set
  with **0** limit.  Only supported for Linux kernel datapath.
* **dpctl/****ct-del-limits** [_dp_] **zone=zone[,zone]**...  
  Deletes the connection tracking limit for _zone_.  Multiple zones may
  be specified with a comma-separated list.  Only supported for Linux
  kernel datapath.
* **dpctl/****ct-get-limits** [_dp_] [**zone=zone**[**,zone**]...]  
  Retrieves the maximum allowed number of connections and current
  counts per-zone.  If _zone_ is given, only the specified zone(s) are
  printed.  If no zones are specified, all the zone limits and counts are
  provided.  The command always displays the default zone limit.  Only
  supported for Linux kernel datapath.

<a name="dpif-netdev-commands"></a>

### DPIF-NETDEV COMMANDS

These commands are used to expose internal information (mostly statistics)
about the "dpif-netdev" userspace datapath. If there is only one datapath
(as is often the case, unless **dpctl/** commands are used), the _dp_
argument can be omitted. By default the commands present data for all pmd
threads in the datapath. By specifying the "-pmd Core" option one can filter
the output for a single pmd in the datapath.

* **dpif-netdev/pmd-stats-show** [**-pmd** _core_] [_dp_]  
  Shows performance statistics for one or all pmd threads of the datapath
  _dp_. The special thread "main" sums up the statistics of every non pmd
  thread.
  
  The sum of "emc hits", "smc hits", "megaflow hits" and "miss" is the number of
  packet lookups performed by the datapath. Beware that a recirculated packet
  experiences one additional lookup per recirculation, so there may be
  more lookups than forwarded packets in the datapath.
  
  Cycles are counted using the TSC or similar facilities (when available on
  the platform). The duration of one cycle depends on the processing platform.
  
  "idle cycles" refers to cycles spent in PMD iterations not forwarding any
  any packets. "processing cycles" refers to cycles spent in PMD iterations
  forwarding at least one packet, including the cost for polling, processing and
  transmitting said packets.
  
  To reset these counters use **dpif-netdev/pmd-stats-clear**.
* **dpif-netdev/pmd-stats-clear** [_dp_]  
  Resets to zero the per pmd thread performance numbers shown by the
  **dpif-netdev/pmd-stats-show** and **dpif-netdev/pmd-perf-show** commands.
  It will NOT reset datapath or bridge statistics, only the values shown by
  the above commands.
* **dpif-netdev/pmd-perf-show** [**-nh**] [**-it** _iter\_len_] [**-ms** _ms\_len_] [**-pmd** _core_] [_dp_]  
  Shows detailed performance metrics for one or all pmds threads of the
  user space datapath.
  
  The collection of detailed statistics can be controlled by a new
  configuration parameter "other_config:pmd-perf-metrics". By default it
  is disabled. The run-time overhead, when enabled, is in the order of 1%.
  
    *     * —  
used cycles  
    * —  
      forwared packets
    * —  
      number of rx batches
    * —  
      packets/rx batch
    * —  
      max. vhostuser queue fill level
    * —  
      number of upcalls
    * —  
      cycles spent in upcalls
* This raw recorded data is used threefold:
  
    *     * 1.  
In histograms for each of the following metrics:  
        * —  
          cycles/iteration (logarithmic)
        * —  
          packets/iteration (logarithmic)
        * —  
          cycles/packet
        * —  
          packets/batch
        * —  
          max. vhostuser qlen (logarithmic)
        * —  
          upcalls
        * —  
          cycles/upcall (logarithmic)
          The histograms bins are divided linear or logarithmic.
    * 2.  
      A cyclic history of the above metrics for 1024 iterations
    * 3.  
      A cyclic history of the cummulative/average values per millisecond wall
      clock for the last 1024 milliseconds:
        * —  
          number of iterations
        * —  
          avg. cycles/iteration
        * —  
          packets (Kpps)
        * —  
          avg. packets/batch
        * —  
          avg. max vhost qlen
        * —  
          upcalls
        * —  
          avg. cycles/upcall
* The command options are:
    * **-nh**  
      Suppress the histograms
    * **-it** _iter\_len_  
      Display the last iter_len iteration stats
    * **-ms** _ms\_len_  
      Display the last ms_len millisecond stats
* The output always contains the following global PMD statistics:
    * Time: 15:24:55.270 .br
      Measurement duration: 1.008 s
      
      pmd thread numa_id 0 core_id 1:
      
        Cycles:            2419034712  (2.40 GHz)
        Iterations:            572817  (1.76 us/it)
        - idle:                486808  (15.9 % cycles)
        - busy:                 86009  (84.1 % cycles)
        Rx packets:           2399607  (2381 Kpps, 848 cycles/pkt)
        Datapath passes:      3599415  (1.50 passes/pkt)
        - EMC hits:            336472  ( 9.3 %)
        - SMC hits:                 0  ( 0.0 %)
        - Megaflow hits:      3262943  (90.7 %, 1.00 subtbl lookups/hit)
        - Upcalls:                  0  ( 0.0 %, 0.0 us/upcall)
        - Lost upcalls:             0  ( 0.0 %)
        Tx packets:           2399607  (2381 Kpps)
        Tx batches:            171400  (14.00 pkts/batch)
* Here "Rx packets" actually reflects the number of packets forwarded by the
  datapath. "Datapath passes" matches the number of packet lookups as
  reported by the **dpif-netdev/pmd-stats-show** command.
  
  To reset the counters and start a new measurement use
  **dpif-netdev/pmd-stats-clear**.
* **dpif-netdev/pmd-perf-log-set** **on**|**off** [**-b** _before_] [**-a** _after_] [**-e**|**-ne**] [**-us** _usec_] [**-q** _qlen_]  
  The userspace "netdev" datapath is able to supervise the PMD performance
  metrics and detect iterations with suspicious statistics according to the
  following criteria:
    * —  
      The iteration lasts longer than _usec_ microseconds (default 250).
      This can be used to capture events where a PMD is blocked or interrupted for
      such a period of time that there is a risk for dropped packets on any of its Rx
      queues.
    * —  
      The max vhost qlen exceeds a threshold _qlen_ (default 128). This can be
      used to infer virtio queue overruns and dropped packets inside a VM, which are
      not visible in OVS otherwise.
* Such suspicious iterations can be logged together with their iteration
  statistics in the **ovs-vswitchd.log** to be able to correlate them to
  packet drop or other events outside OVS.
  
  The above command enables (**on**) or disables (**off**) supervision and
  logging at run-time and can be used to adjust the above thresholds for
  detecting suspicious iterations. By default supervision and logging is
  disabled.
  
  The command options are:
    * **-b** _before_  
      The number of iterations before the suspicious iteration to be logged
      (default 5).
    * **-a** _after_  
      The number of iterations after the suspicious iteration to be logged
      (default 5).
    * **-e**  
      Extend logging interval if another suspicious iteration is detected
      before logging occurs.
    * **-ne**  
      Do not extend logging interval if another suspicious iteration is detected
      before logging occurs (default).
    * **-q** _qlen_  
      Suspicious vhost queue fill level threshold. Increase this to 512 if the Qemu
      supports 1024 virtio queue length (default 128).
    * **-us** _usec_  
      Change the duration threshold for a suspicious iteration (default 250 us).
  
  Note: Logging of suspicious iterations itself consumes a considerable amount
  of processing cycles of a PMD which may be visible in the iteration history.
  In the worst case this can lead OVS to detect another suspicious iteration
  caused by logging.
  
  If more than 100 iterations around a suspicious iteration have been logged
  once, OVS falls back to the safe default values (-b 5 -a 5 -ne) to avoid
  that logging itself continuously causes logging of further suspicious
  iterations.
* **dpif-netdev/pmd-rxq-show** [**-pmd** _core_] [_dp_]  
  For one or all pmd threads of the datapath _dp_ show the list of queue-ids
  with port names, which this thread polls.
* **dpif-netdev/pmd-rxq-rebalance** [_dp_]  
  Reassigns rxqs to pmds in the datapath _dp_ based on their current usage.

<a name="netdev-dpdk-commands"></a>

### NETDEV-DPDK COMMANDS

These commands manage DPDK related ports (**type=**_dpdk*_).

* **netdev-dpdk/set-admin-state** [_interface_] **up** | **down**  
  Change the admin state for DPDK _interface_ to **up** or **down**.
  If _interface_ is not specified, then it applies to all DPDK ports.
* **netdev-dpdk/detach** _pci-address_  
  Detaches device with corresponding _pci-address_ from DPDK.  This command
  can be used to detach device if it wasn't detached automatically after port
  deletion. Refer to the documentation for details and instructions.
* **netdev-dpdk/get-mempool-info** [_interface_]  
  Prints the debug information about memory pool used by DPDK _interface_.
  If called without arguments, information of all the available mempools will
  be printed. For additional mempool statistics enable
  **CONFIG\_RTE\_LIBRTE\_MEMPOOL\_DEBUG** while building DPDK.

<a name="datapath-debugging-commands"></a>

### DATAPATH DEBUGGING COMMANDS

These commands query and modify datapaths.  They are are similar to
**ovs-dpctl**(8) commands.  **dpif/show** has the additional
functionality, beyond **dpctl/show** of printing OpenFlow port
numbers.  The other commands are redundant and will be removed in a
future release.

* **dpif/dump-dps**  
  Prints the name of each configured datapath on a separate line.
* **dpif/show**  
  Prints a summary of configured datapaths, including statistics and a
  list of connected ports.  The port information includes the OpenFlow
  port number, datapath port number, and the type.  (The local port is
  identified as OpenFlow port 65534.)
* **dpif/dump-flows** [**-m**] _dp_  
  Prints to the console all flow entries in datapath _dp_'s
  flow table. Without **-m**, output omits match fields that a flow
  wildcards entirely; with **-m** output includes all wildcarded fields.
* This command is primarily useful for debugging Open vSwitch.  The flow
  table entries that it displays are not OpenFlow flow entries.  Instead,
  they are different and considerably simpler flows maintained by the
  datapath module.  If you wish to see the OpenFlow flow entries, use
  **ovs-ofctl dump-flows**.
* **dpif/del-flows dp**  
  Deletes all flow entries from datapath _dp_'s flow table and
  underlying datapath implementation (e.g., kernel datapath module).
* This command is primarily useful for debugging Open vSwitch.  As
  discussed in **dpif/dump-flows**, these entries are
  not OpenFlow flow entries.

<a name="ofproto-commands"></a>

### OFPROTO COMMANDS

These commands manage the core OpenFlow switch implementation (called
**ofproto**).

* **ofproto/list**  
  Lists the names of the running ofproto instances.  These are the names
  that may be used on **ofproto/trace**.
* .IQ "**ofproto/trace** [_options_] _bridge_ _br\_flow_ [_packet_]]
  .IQ "**ofproto/trace-packet-out** [_options_] [_dpname_] _odp\_flow_ [_packet_] _actions_"
  .IQ "**ofproto/trace-packet-out** [_options_ _bridge_ _br\_flow_  [_packet_] _actions_"
  Traces the path of an imaginary packet through _switch_ and
  reports the path that it took.  The initial treatment of the packet
  varies based on the command:
    * ·  
      **ofproto/trace** looks the packet up in the OpenFlow flow table, as
      if the packet had arrived on an OpenFlow port.
    * ·  
      **ofproto/trace-packet-out** applies the specified OpenFlow
      _actions_, as if the packet, flow, and actions had been specified
      in an OpenFlow \`\`packet-out'' request.
* The packet's headers (e.g. source and destination) and metadata
  (e.g. input port), together called its \`\`flow,'' are usually all that
  matter for the purpose of tracing a packet.  You can specify the flow
  in the following ways:
    * _dpname_ _odp\_flow_  
      _odp\_flow_ is a flow in the form printed by **ovs-dpctl**(8)'s
      **dump-flows** command.  If all of your bridges have the same type,
      which is the common case, then you can omit _dpname_, but if you
      have bridges of different types (say, both **ovs-netdev** and
      **ovs-system**), then you need to specify a _dpname_ to disambiguate.
    * _bridge_ _br\_flow_  
      _br\_flow_ is a flow in the form similar to that accepted by
      **ovs-ofctl**(8)'s **add-flow** command.  (This is not an
      OpenFlow flow: besides other differences, it never contains
      wildcards.)  _bridge_ names of the bridge through which
      _br\_flow_ should be traced.
* These commands support the following options:
    * **--generate**  
      Generate a packet from the flow (see below for more information).
    * **--l7 payload**  
      .IQ "**--l7-len length**"
      Accepted only with **--generate** (see below for more
      information).
    * **--consistent**  
      Accepted by **ofproto-trace-packet-out** only.  With this option,
      the command rejects _actions_ that are inconsistent with the
      specified packet.  (An example of an inconsistency is attempting to
      strip the VLAN tag from a packet that does not have a VLAN tag.)  Open
      vSwitch ignores most forms of inconsistency in OpenFlow 1.0 and
      rejects inconsistencies in later versions of OpenFlow.  The option is
      necessary because the command does not ordinarily imply a particular
      OpenFlow version.  One exception is that, when _actions_ includes
      an action that only OpenFlow 1.1 and later supports (such as
      **push\_vlan**), **--consistent** is automatically enabled.
    * --ct-next _flags_  
      When the traced flow triggers conntrack actions, **ofproto/trace**
      will automatically trace the forked packet processing pipeline with
      user specified ct_state.  This option sets the ct_state flags that the
      conntrack module will report. The _flags_ must be a comma- or
      space-separated list of the following connection tracking flags:
        * ·  
          **trk**: Include to indicate connection tracking has taken place.
        * ·  
          **new**: Include to indicate a new flow.
        * ·  
          **est**: Include to indicate an established flow.
        * ·  
          **rel**: Include to indicate a related flow.
        * ·  
          **rpl**: Include to indicate a reply flow.
        * ·  
          **inv**: Include to indicate a connection entry in a bad state.
        * ·  
          **dnat**: Include to indicate a packet whose destination IP address has been
          changed.
        * ·  
          **snat**: Include to indicate a packet whose source IP address has been
          changed.
    * When --ct-next is unspecified, or when there are fewer --ct-next options than
      ct actions, the _flags_ default to trk,new.
* Most commonly, one specifies only a flow, using one of the forms
  above, but sometimes one might need to specify an actual packet
  instead of just a flow:
    * Side effects.  
      Some actions have side effects.  For example, the **normal** action
      can update the MAC learning table, and the **learn** action can
      change OpenFlow tables.  The trace commands only perform side
      effects when a packet is specified.  If you want side effects to take
      place, then you must supply a packet.
    * (Side effects when tracing do not have external consequences.  Even if a
      packet is specified, a trace will not output a packet or generate sFlow,
      NetFlow or controller events.)
    * Incomplete information.  
      Most of the time, Open vSwitch can figure out everything about the
      path of a packet using just the flow, but in some special
      circumstances it needs to look at parts of the packet that are not
      included in the flow.  When this is the case, and you do not supply a
      packet, then a trace command will tell you it needs a packet.
* If you wish to include a packet as part of a trace operation, there
  are two ways to do it:
    * **--generate**  
      This option, added to one of the ways to specify a flow already
      described, causes Open vSwitch to internally generate a packet with
      the flow described and then to use that packet.  If your goal is to
      execute side effects, then **--generate** is the easiest way to do
      it, but **--generate** is not a good way to fill in incomplete
      information, because it generates packets based on only the flow
      information, which means that the packets really do not have any more
      information than the flow.
    * By default, for protocols that allow arbitrary L7 payloads, the
      generated packet has 64 bytes of payload.  Use **--l7-len** to
      change the payload length, or **--l7** to specify the exact
      contents of the payload.
    * _packet_  
      This form supplies an explicit _packet_ as a sequence of hex
      digits.  An Ethernet frame is at least 14 bytes long, so there must be
      at least 28 hex digits.  Obviously, it is inconvenient to type in the
      hex digits by hand, so the **ovs-pcap**(1) and
      **ovs-tcpundump**(1) utilities provide easier ways.
    * With this form, packet headers are extracted directly from
      _packet_, so the _odp\_flow_ or _br\_flow_ should specify
      only metadata. The metadata can be:
        * _skb\_priority_  
          Packet QoS priority.
        * _pkt\_mark_  
          Mark of the packet.
        * _ct\_state_  
          Connection state of the packet.
        * _ct\_zone_  
          Connection tracking zone for packet.
        * _ct\_mark_  
          Connection mark of the packet.
        * _ct\_label_  
          Connection label of the packet.
        * _tun\_id_  
          The tunnel ID on which the packet arrived.
        * _in\_port_  
          The port on which the packet arrived.
* The in_port value is kernel datapath port number for the first format
  and OpenFlow port number for the second format. The numbering of these
  two types of port usually differs and there is no relationship.
* Usage examples:  

Trace an unicast ICMP echo request on ingress port 1 to destination MAC
00:00:5E:00:53:01
    ofproto/trace br in_port=1,icmp,icmp_type=8,dl_dst=00:00:5E:00:53:01
    .RE

Trace an unicast ICMP echo reply on ingress port 1 to destination MAC
00:00:5E:00:53:01
    ofproto/trace br in_port=1,icmp,icmp_type=0,dl_dst=00:00:5E:00:53:01

**Trace an ARP request on ingress port 1**
    ofproto/trace br in_port=1,arp,arp_op=1

**Trace an ARP reply on ingress port 1**
    ofproto/trace br in_port=1,arp,arp_op=2

<a name="vlog-commands"></a>

### VLOG COMMANDS

These commands manage **ovs-vswitchd**'s logging settings.

* **vlog/set** [_spec_]  
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
      respectively.
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
  will not take place unless **ovs-vswitchd** was invoked with the
  **--log-file** option.
* For compatibility with older versions of OVS, **any** is accepted as
  a word but has no effect.

* **vlog/set PATTERN:destination:pattern**  
  Sets the log pattern for _destination_ to _pattern_.  Refer to
  **ovs-appctl**(8) for a description of the valid syntax for _pattern_.
* **vlog/list**  
  Lists the supported logging modules and their current levels.
* **vlog/list-pattern**  
  Lists logging patterns used for each destination.
* **vlog/close**  
  Causes **ovs-vswitchd** to close its log file, if it is open.  (Use
  **vlog/reopen** to reopen it later.)
* **vlog/reopen**  
  Causes **ovs-vswitchd** to close its log file, if it is open, and then
  reopen it.  (This is useful after rotating log files, to cause a new
  log file to be used.)
* This has no effect unless **ovs-vswitchd** was invoked with the
  **--log-file** option.
* **vlog/disable-rate-limit **[_module_]...  
  .IQ "**vlog/enable-rate-limit **[_module_]..."
  By default, **ovs-vswitchd** limits the rate at which certain messages can
  be logged.  When a message would appear more frequently than the
  limit, it is suppressed.  This saves disk space, makes logs easier to
  read, and speeds up execution, but occasionally troubleshooting
  requires more detail.  Therefore, **vlog/disable-rate-limit**
  allows rate limits to be disabled at the level of an individual log
  module.  Specify one or more module names, as displayed by the
  **vlog/list** command.  Specifying either no module names at all or
  the keyword **any** disables rate limits for every log module.
* The **vlog/enable-rate-limit** command, whose syntax is the same
  as **vlog/disable-rate-limit**, can be used to re-enable a rate
  limit that was previously disabled.

<a name="memory-commands"></a>

### MEMORY COMMANDS

These commands report memory usage.

* **memory/show**  
  Displays some basic statistics about **ovs-vswitchd**'s memory usage.
  **ovs-vswitchd** also logs this information soon after startup and
  periodically as its memory consumption grows.

<a name="coverage-commands"></a>

### COVERAGE COMMANDS

These commands manage **ovs-vswitchd**'s \`\`coverage counters,'' which count
the number of times particular events occur during a daemon's runtime.
In addition to these commands, **ovs-vswitchd** automatically logs coverage
counter values, at **INFO** level, when it detects that the daemon's
main loop takes unusually long to run.

Coverage counters are useful mainly for performance analysis and
debugging.

* **coverage/show**  
  Displays the averaged per-second rates for the last few seconds, the
  last minute and the last hour, and the total counts of all of the
  coverage counters.

<a name="openvswitch-tunneling-commands"></a>

### OPENVSWITCH TUNNELING COMMANDS

These commands query and modify OVS tunnel components.

* **ovs/route/add ipv4_address/plen output_bridge [GW]**  
  Adds ipv4_address/plen route to vswitchd routing table. output_bridge
  needs to be OVS bridge name.  This command is useful if OVS cached
  routes does not look right.
* **ovs/route/show**  
  Print all routes in OVS routing table, This includes routes cached
  from system routing table and user configured routes.
* **ovs/route/del ipv4\_address/plen**  
  Delete ipv4_address/plen route from OVS routing table.
* **tnl/neigh/show**  
* **tnl/arp/show**  
  OVS builds ARP cache by snooping are messages. This command shows
  ARP cache table.
* **tnl/neigh/set bridge ip mac**  
* **tnl/arp/set bridge ip mac**  
  Adds or modifies an ARP cache entry in _bridge_, mapping _ip_
  to _mac_.
* **tnl/neigh/flush**  
* **tnl/arp/flush**  
  Flush ARP table.
* **tnl/egress_port_range [num1] [num2]**  
  Set range for UDP source port used for UDP based Tunnels. For
  example VxLAN. If case of zero arguments this command prints
  current range in use.

<a name="openflow-implementation"></a>

# Openflow Implementation


This section documents aspects of OpenFlow for which the OpenFlow
specification requires documentation.

<a name="packet-buffering"></a>

### Packet buffering.

The OpenFlow specification, version 1.2, says:

* Switches that implement buffering are expected to expose, through
  documentation, both the amount of available buffering, and the length
  of time before buffers may be reused.

Open vSwitch does not maintains any packet buffers.

<a name="bundle-lifetime"></a>

### Bundle lifetime

The OpenFlow specification, version 1.4, says:

* If the switch does not receive any OFPT_BUNDLE_CONTROL or
  OFPT_BUNDLE_ADD_MESSAGE message for an opened bundle_id for a switch
  defined time greater than 1s, it may send an ofp_error_msg with
  OFPET_BUNDLE_FAILED type and OFPBFC_TIMEOUT code.  If the switch does
  not receive any new message in a bundle apart from echo request and
  replies for a switch defined time greater than 1s, it may send an
  ofp_error_msg with OFPET_BUNDLE_FAILED type and OFPBFC_TIMEOUT code.

Open vSwitch implements default idle bundle lifetime of 10 seconds.
(This is configurable via **other-config:bundle-idle-timeout** in
the **Open\_vSwitch** table. See **ovs-vswitchd.conf.db**(5)
for details.)

<a name="limits"></a>

# Limits


We believe these limits to be accurate as of this writing.  These
limits assume the use of the Linux kernel datapath.

* ·  
  **ovs-vswitchd** started through **ovs-ctl**(8) provides a limit of 65535
  file descriptors.  The limits on the number of bridges and ports is decided by
  the availability of file descriptors.  With the Linux kernel datapath, creation
  of a single bridge consumes three file descriptors and adding a port consumes
  "n-handler-threads" file descriptors per bridge port.  Performance will degrade
  beyond 1,024 ports per bridge due to fixed hash table sizing.  Other platforms
  may have different limitations.
* ·  
  2,048 MAC learning entries per bridge, by default.  (This is
  configurable via **other-config:mac-table-size** in the
  **Bridge** table.  See **ovs-vswitchd.conf.db**(5) for details.)
* ·  
  Kernel flows are limited only by memory available to the kernel.
  Performance will degrade beyond 1,048,576 kernel flows per bridge with
  a 32-bit kernel, beyond 262,144 with a 64-bit kernel.
  (**ovs-vswitchd** should never install anywhere near that many
  flows.)
* ·  
  OpenFlow flows are limited only by available memory.  Performance is
  linear in the number of unique wildcard patterns.  That is, an
  OpenFlow table that contains many flows that all match on the same
  fields in the same way has a constant-time lookup, but a table that
  contains many flows that match on different fields requires lookup
  time linear in the number of flows.
* ·  
  255 ports per bridge participating in 802.1D Spanning Tree Protocol.
* ·  
  32 mirrors per bridge.
* ·  
  15 bytes for the name of a port.  (This is a Linux kernel limitation.)

<a name="see-also"></a>

# See Also

**ovs-appctl**(8),
**ovsdb-server**(1).
