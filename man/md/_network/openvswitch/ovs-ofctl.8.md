# ovs\-ofctl(8)

Open vSwitch, 2.10.1


<a name="name"></a>

# Name

ovs-ofctl - administer OpenFlow switches

<a name="synopsis"></a>

# Synopsis

```
ovs-ofctl [options] command [switch] [args...]
```

<a name="description"></a>

# Description

The
**ovs-ofctl**
program is a command line tool for monitoring and administering
OpenFlow switches.  It can also show the current state of an OpenFlow
switch, including features, configuration, and table entries.
It should work with any OpenFlow switch, not just Open vSwitch.

<a name="openflow-switch-management-commands"></a>

### OpenFlow Switch Management Commands


These commands allow **ovs-ofctl** to monitor and administer an OpenFlow
switch.  It is able to show the current state of a switch, including
features, configuration, and table entries.

Most of these commands take an argument that specifies the method for
connecting to an OpenFlow switch.  The following connection methods
are supported:

* **ssl:host**[**:port**]  
  .IQ "**tcp:host**[**:port**]"
  The specified _port_ on the given _host_, which can
  be expressed either as a DNS name (if built with unbound library)
  or an IP address in IPv4 or IPv6 address format.  Wrap IPv6 addresses
  in square brackets, e.g. **tcp:[::1]:6653**.  On Linux, use
  **%device** to designate a scope for IPv6 link-level addresses,
  e.g. **tcp:[fe80::1234%eth0]:6653**.  For **ssl**, the
  **--private-key**, **--certificate**, and **--ca-cert**
  options are mandatory.
* If _port_ is not specified, it defaults to 6653.
* **unix:file**  
  On POSIX, a Unix domain server socket named _file_.
* On Windows, connect to a local named pipe that is represented by a
  file created in the path _file_ to mimic the behavior of a Unix
  domain socket.
* _file_  
  This is short for **unix:_file**, as long as file_ does not
  contain a colon.
* _bridge_  
  This is short for **unix:/var/run/openvswitch/bridge.mgmt**, as long as
  _bridge_ does not contain a colon.
* [_type**@**]dp_  
  Attempts to look up the bridge associated with _dp_ and open as
  above.  If _type_ is given, it specifies the datapath provider of
  _dp_, otherwise the default provider **system** is assumed.

* **show switch**  
  Prints to the console information on _switch_, including
  information on its flow tables and ports.
* **dump-tables switch**  
  Prints to the console statistics for each of the flow tables used by
  _switch_.
* **dump-table-features switch**  
  Prints to the console features for each of the flow tables used by
  _switch_.
* **dump-table-desc switch**  
  Prints to the console configuration for each of the flow tables used
  by _switch_ for OpenFlow 1.4+.
* **mod-table _switch** table_ _setting_  
  This command configures flow table settings in _switch_ for
  OpenFlow table _table_, which may be expressed as a number or
  (unless **--no-names** is specified) a name.
* The available settings depend on
  the OpenFlow version in use.  In OpenFlow 1.1 and 1.2 (which must be
  enabled with the **-O** option) only, **mod-table** configures
  behavior when no flow is found when a packet is looked up in a flow
  table.  The following _setting_ values are available:
    * **drop**  
      Drop the packet.
    * **continue**  
      Continue to the next table in the pipeline.  (This is how an OpenFlow
      1.0 switch always handles packets that do not match any flow, in
      tables other than the last one.)
    * **controller**  
      Send to controller.  (This is how an OpenFlow 1.0 switch always
      handles packets that do not match any flow in the last table.)
* In OpenFlow 1.4 and later (which must be enabled with the **-O**
  option) only, **mod-table** configures the behavior when a
  controller attempts to add a flow to a flow table that is full.  The
  following _setting_ values are available:
    * **evict**  
      Delete some existing flow from the flow table, according to the
      algorithm described for the **Flow\_Table** table in
      **ovs-vswitchd.conf.db**(5).
    * **noevict**  
      Refuse to add the new flow.  (Eviction might still be enabled through
      the **overflow\_policy** column in the **Flow\_Table** table
      documented in **ovs-vswitchd.conf.db**(5).)
    * **vacancy:low,high**  
      Enables sending vacancy events to controllers using **TABLE\_STATUS**
      messages, based on percentage thresholds _low_ and _high_.
    * **novacancy**  
      Disables vacancy events.
* **dump-ports _switch** [netdev_]  
  Prints to the console statistics for network devices associated with 
  _switch_.  If _netdev_ is specified, only the statistics
  associated with that device will be printed.  _netdev_ can be an
  OpenFlow assigned port number or device name, e.g. **eth0**.
* **dump-ports-desc _switch** [port_]  
  Prints to the console detailed information about network devices
  associated with _switch_.  To dump only a specific port, specify
  its number as _port_.  Otherwise, if _port_ is omitted, or if
  it is specified as **ANY**, then all ports are printed.  This is a
  subset of the information provided by the **show** command.
* If the connection to _switch_ negotiates OpenFlow 1.0, 1.2, or
  1.2, this command uses an OpenFlow extension only implemented in Open
  vSwitch (version 1.7 and later).
* Only OpenFlow 1.5 and later support dumping a specific port.  Earlier
  versions of OpenFlow always dump all ports.
* **mod-port _switch** port_ _action_  
  Modify characteristics of port **port** in _switch_.  _port_
  may be an OpenFlow port number or name (unless **--no-names** is
  specified) or the keyword **LOCAL** (the
  preferred way to refer to the OpenFlow local port).  The _action_
  may be any one of the following:
      .IQ **up**
      .IQ **down**
      Enable or disable the interface.  This is equivalent to ip
      link set up or **ip link set down** on a Unix system.
    * **stp**  
      .IQ **no-stp**
      Enable or disable 802.1D spanning tree protocol (STP) on the
      interface.  OpenFlow implementations that don't support STP will
      refuse to enable it.
    * **receive**  
      .IQ **no-receive**
      .IQ **receive-stp**
      .IQ **no-receive-stp**
      Enable or disable OpenFlow processing of packets received on this
      interface.  When packet processing is disabled, packets will be
      dropped instead of being processed through the OpenFlow table.  The
      **receive** or **no-receive** setting applies to all packets
      except 802.1D spanning tree packets, which are separately controlled
      by **receive-stp** or **no-receive-stp**.
    * **forward**  
      .IQ **no-forward**
      Allow or disallow forwarding of traffic to this interface.  By
      default, forwarding is enabled.
    * **flood**  
      .IQ **no-flood**
      Controls whether an OpenFlow **flood** action will send traffic out
      this interface.  By default, flooding is enabled.  Disabling flooding
      is primarily useful to prevent loops when a spanning tree protocol is
      not in use.
    * **packet-in**  
      .IQ **no-packet-in**
      Controls whether packets received on this interface that do not match
      a flow table entry generate a \`\`packet in'' message to the OpenFlow
      controller.  By default, \`\`packet in'' messages are enabled.
* The **show** command displays (among other information) the
  configuration that **mod-port** changes.
* **get-frags switch**  
  Prints _switch_'s fragment handling mode.  See **set-frags**,
  below, for a description of each fragment handling mode.
* The **show** command also prints the fragment handling mode among
  its other output.
* **set-frags switch frag\_mode**  
  Configures _switch_'s treatment of IPv4 and IPv6 fragments.  The
  choices for _frag\_mode_ are:
    * **normal**  
      Fragments pass through the flow table like non-fragmented packets.
      The TCP ports, UDP ports, and ICMP type and code fields are always set
      to 0, even for fragments where that information would otherwise be
      available (fragments with offset 0).  This is the default fragment
      handling mode for an OpenFlow switch.
    * **drop**  
      Fragments are dropped without passing through the flow table.
    * **reassemble**  
      The switch reassembles fragments into full IP packets before passing
      them through the flow table.  Open vSwitch does not implement this
      fragment handling mode.
    * **nx-match**  
      Fragments pass through the flow table like non-fragmented packets.
      The TCP ports, UDP ports, and ICMP type and code fields are available
      for matching for fragments with offset 0, and set to 0 in fragments
      with nonzero offset.  This mode is a Nicira extension.
* See the description of **ip\_frag**, below, for a way to match on
  whether a packet is a fragment and on its fragment offset.
* **dump-flows _switch **[flows_]  
  Prints to the console all flow entries in _switch_'s
  tables that match _flows_.  If _flows_ is omitted, all flows
  in the switch are retrieved.  See **Flow Syntax**, below, for the
  syntax of _flows_.  The output format is described in
  **Table Entry Output**.
* By default, **ovs-ofctl** prints flow entries in the same order
  that the switch sends them, which is unlikely to be intuitive or
  consistent.  Use **--sort** and **--rsort** to control display
  order.  The **--names**/**--no-names** and
  **--stats**/**--no-stats** options also affect output
  formatting.  See the descriptions of these options, under
  **OPTIONS** below, for more information
* **dump-aggregate _switch **[flows_]  
  Prints to the console aggregate statistics for flows in
  _switch_'s tables that match _flows_.  If _flows_ is omitted, 
  the statistics are aggregated across all flows in the switch's flow
  tables.  See **Flow Syntax**, below, for the syntax of _flows_.
  The output format is described in **Table Entry Output**.
* **queue-stats _switch **[port _[_queue_]]  
  Prints to the console statistics for the specified _queue_ on
  _port_ within _switch_.  _port_ can be an OpenFlow port
  number or name, the keyword **LOCAL** (the preferred way to refer to
  the OpenFlow local port), or the keyword **ALL**.  Either of
  _port_ or _queue_ or both may be omitted (or equivalently the
  keyword **ALL**).  If both are omitted, statistics are printed for
  all queues on all ports.  If only _queue_ is omitted, then
  statistics are printed for all queues on _port_; if only
  _port_ is omitted, then statistics are printed for _queue_ on
  every port where it exists.
* **queue-get-config _switch [port **[queue_]]  
  Prints to the console the configuration of _queue_ on _port_
  in _switch_.  If _port_ is omitted or **ANY**, reports
  queues for all port.  If _queue_ is omitted or **ANY**, reports
  all queues.  For OpenFlow 1.3 and earlier, the output always includes
  all queues, ignoring _queue_ if specified.
* This command has limited usefulness, because ports often have no
  configured queues and because the OpenFlow protocol provides only very
  limited information about the configuration of a queue.
* **dump-ipfix-bridge switch**  
  Prints to the console the statistics of bridge IPFIX for _switch_.
  If bridge IPFIX is configured on the _switch_, IPFIX statistics
  can be retrieved.  Otherwise, error message will be printed.
* This command uses an Open vSwitch extension that is only in Open
  vSwitch 2.6 and later.
* **dump-ipfix-flow switch**  
  Prints to the console the statistics of flow-based IPFIX for
  _switch_.  If flow-based IPFIX is configured on the _switch_,
  statistics of all the collector set ids on the _switch_ will be
  printed.  Otherwise, print error message.
* Refer to **ovs-vswitchd.conf.db**(5) for more details on configuring
  flow based IPFIX and collector set ids.
* This command uses an Open vSwitch extension that is only in Open
  vSwitch 2.6 and later.
* Flushes the connection tracking entries in _zone_ on _switch_.
* This command uses an Open vSwitch extension that is only in Open
  vSwitch 2.6 and later.

<a name="openflow-switch-flow-table-commands"></a>

### OpenFlow Switch Flow Table Commands

These commands manage the flow table in an OpenFlow switch.  In each
case, _flow_ specifies a flow entry in the format described in
**Flow Syntax**, below, _file_ is a text file that contains zero
or more flows in the same syntax, one per line, and the optional
**--bundle** option operates the command as a single atomic
transation, see option **--bundle**, below.

* [**--bundle**] **add-flow switch flow**  
  .IQ "[**--bundle**] **add-flow switch - &lt; file**"
  .IQ "[**--bundle**] **add-flows switch file**"
  Add each flow entry to _switch_'s tables.
  Each flow specification (e.g., each line in _file_) may start with
  **add**, **modify**, **delete**, **modify\_strict**, or
  **delete\_strict** keyword to specify whether a flow is to be added,
  modified, or deleted, and whether the modify or delete is strict or
  not.  For backwards compatibility a flow specification without one of
  these keywords is treated as a flow add.  All flow mods are executed
  in the order specified.
* [**--bundle**] [**--strict**] **mod-flows switch flow**  
  .IQ "[**--bundle**] [**--strict**] **mod-flows switch - &lt; file**"
  Modify the actions in entries from _switch_'s tables that match
  the specified flows.  With **--strict**, wildcards are not treated
  as active for matching purposes.
* [**--bundle**] **del-flows switch**  
  .IQ "[**--bundle**] [**--strict**] **del-flows _switch **[flow_]"
  .IQ "[**--bundle**] [**--strict**] **del-flows switch - &lt; file**"
  Deletes entries from _switch_'s flow table.  With only a
  _switch_ argument, deletes all flows.  Otherwise, deletes flow
  entries that match the specified flows.  With **--strict**,
  wildcards are not treated as active for matching purposes.
* [**--bundle**] [**--readd**] **replace-flows switch file**  
  Reads flow entries from _file_ (or **stdin** if _file_ is
  **-**) and queries the flow table from _switch_.  Then it fixes
  up any differences, adding flows from _flow_ that are missing on
  _switch_, deleting flows from _switch_ that are not in
  _file_, and updating flows in _switch_ whose actions, cookie,
  or timeouts differ in _file_.
* With **--readd**, **ovs-ofctl** adds all the flows from
  _file_, even those that exist with the same actions, cookie, and
  timeout in _switch_.  In OpenFlow 1.0 and 1.1, re-adding a flow
  always resets the flow's packet and byte counters to 0, and in
  OpenFlow 1.2 and later, it does so only if the **reset\_counts** flag
  is set.
* **diff-flows source1 source2**  
  Reads flow entries from _source1_ and _source2_ and prints the
  differences.  A flow that is in _source1_ but not in _source2_
  is printed preceded by a **-**, and a flow that is in _source2_
  but not in _source1_ is printed preceded by a **+**.  If a flow
  exists in both _source1_ and _source2_ with different actions,
  cookie, or timeouts, then both versions are printed preceded by
  **-** and **+**, respectively.
* _source1_ and _source2_ may each name a file or a switch.  If
  a name begins with **/** or **.**, then it is considered to be a
  file name.  A name that contains **:** is considered to be a switch.
  Otherwise, it is a file if a file by that name exists, a switch if
  not.
* For this command, an exit status of 0 means that no differences were
  found, 1 means that an error occurred, and 2 means that some
  differences were found.
* **packet-out _switch** packet-out_  
  Connects to _switch_ and instructs it to execute the
  _packet-out_ OpenFlow message, specified as defined in
  **Packet-Out Syntax** section.

<a name="group-table-commands"></a>

### Group Table Commands

These commands manage the group table in an OpenFlow switch.  In each
case, _group_ specifies a group entry in the format described in
**Group Syntax**, below, and _file_ is a text file that contains
zero or more groups in the same syntax, one per line, and the optional
**--bundle** option operates the command as a single atomic
transation, see option **--bundle**, below.

The group commands work only with switches that support OpenFlow 1.1
or later or the Open vSwitch group extensions to OpenFlow 1.0 (added
in Open vSwitch 2.9.90).  For OpenFlow 1.1 or later, it is necessary
to explicitly enable these protocol versions in **ovs-ofctl**
(using **-O**).  For more information, see \`\`Q: What versions of
OpenFlow does Open vSwitch support?'' in the Open vSwitch FAQ.

* [**--bundle**] **add-group switch group**  
  .IQ "[**--bundle**] **add-group switch - &lt; file**"
  .IQ "[**--bundle**] **add-groups switch file**"
  Add each group entry to _switch_'s tables.
  Each group specification (e.g., each line in _file_) may start
  with **add**, **modify**, **add\_or\_mod**, **delete**,
  **insert\_bucket**, or **remove\_bucket** keyword to specify whether
  a flow is to be added, modified, or deleted, or whether a group bucket
  is to be added or removed.  For backwards compatibility a group
  specification without one of these keywords is treated as a group add.
  All group mods are executed in the order specified.
* [**--bundle**] [**--may-create**] **mod-group switch group**  
  .IQ "[**--bundle**] [**--may-create**] **mod-group switch - &lt; file**"
  Modify the action buckets in entries from _switch_'s tables for
  each group entry.  If a specified group does not already exist, then
  without **--may-create**, this command has no effect; with
  **--may-create**, it creates a new group.  The
  **--may-create** option uses an Open vSwitch extension to
  OpenFlow only implemented in Open vSwitch 2.6 and later.
* [**--bundle**] **del-groups switch**  
  .IQ "[**--bundle**] **del-groups _switch **[group_]"
  .IQ "[**--bundle**] **del-groups switch - &lt; file**"
  Deletes entries from _switch_'s group table.  With only a
  _switch_ argument, deletes all groups.  Otherwise, deletes the group
  for each group entry.
* [**--bundle**] **insert-buckets switch group**  
  .IQ "[**--bundle**] **insert-buckets switch - &lt; file**"
  Add buckets to an existing group present in the _switch_'s group table.
  If no _command\_bucket\_id_ is present in the group specification then all
  buckets of the group are removed.
* [**--bundle**] **remove-buckets switch group**  
  .IQ "[**--bundle**] **remove-buckets switch - &lt; file**"
  Remove buckets to an existing group present in the _switch_'s group table.
  If no _command\_bucket\_id_ is present in the group specification then all
  buckets of the group are removed.
* **dump-groups _switch** [group_]  
  Prints group entries in _switch_'s tables to console.  To dump
  only a specific group, specify its number as _group_.  Otherwise,
  if _group_ is omitted, or if it is specified as **ALL**, then
  all groups are printed.
* Only OpenFlow 1.5 and later support dumping a specific group.  Earlier
  versions of OpenFlow always dump all groups.
* dump-group-features switch  
  Prints to the console the group features of the _switch_.
* **dump-group-stats _switch **[group_]  
  Prints to the console statistics for the specified _group_ in
  _switch_'s tables.  If _group_ is omitted then statistics for all
  groups are printed.

<a name="openflow-13-switch-meter-table-commands"></a>

### OpenFlow 1.3+ Switch Meter Table Commands

These commands manage the meter table in an OpenFlow switch.  In each
case, _meter_ specifies a meter entry in the format described in
**Meter Syntax**, below.

OpenFlow 1.3 introduced support for meters, so these commands only work
with switches that support OpenFlow 1.3 or later.  It is necessary to
explicitly enable these protocol versions in **ovs-ofctl** (using
**-O**) and in the switch itself (with the **protocols** column in
the **Bridge** table).  For more information, see \`\`Q: What versions
of OpenFlow does Open vSwitch support?'' in the Open vSwitch FAQ.

* **add-meter switch meter**  
  Add a meter entry to _switch_'s tables. The _meter_ syntax is
  described in section **Meter Syntax**, below.
* **mod-meter switch meter**  
  Modify an existing meter.
* **del-meters _switch** [meter_]  
  Delete entries from _switch_'s meter table.  To delete only a
  specific meter, specify its number as _meter_.  Otherwise, if
  _meter_ is omitted, or if it is specified as **all**, then all
  meters are deleted.
* **dump-meters _switch** [meter_]  
  Print entries from _switch_'s meter table.  To print only a
  specific meter, specify its number as _meter_.  Otherwise, if
  _meter_ is omitted, or if it is specified as **all**, then all
  meters are printed.
* **meter-stats _switch** [meter_]  
  Print meter statistics.  _meter_ can specify a single meter with
  syntax **meter=id**, or all meters with syntax **meter=all**.
* **meter-features switch**  
  Print meter features.

<a name="openflow-switch-bundle-command"></a>

### OpenFlow Switch Bundle Command

Transactional updates to both flow and group tables can be made with
the **bundle** command.  _file_ is a text file that contains
zero or more flow mods, group mods, or packet-outs in Flow
Syntax, **Group Syntax**, or **Packet-Out Syntax**, each line
preceded by **flow**, **group**, or **packet-out** keyword,
correspondingly.  The **flow** keyword may be optionally followed by
one of the keywords **add**, **modify**, **modify\_strict**,
**delete**, or **delete\_strict**, of which the **add** is
assumed if a bare **flow** is given.  Similarly, the **group**
keyword may be optionally followed by one of the keywords **add**,
**modify**, **add\_or\_mod**, **delete**, **insert\_bucket**, or
**remove\_bucket**, of which the **add** is assumed if a bare
**group** is given.

* **bundle switch file**  
  Execute all flow and group mods in _file_ as a single atomic
  transaction against _switch_'s tables.  All bundled mods are
  executed in the order specified.

<a name="openflow-switch-tunnel-tlv-table-commands"></a>

### OpenFlow Switch Tunnel TLV Table Commands

Open vSwitch maintains a mapping table between tunnel option TLVs (defined
by &lt;class, type, length&gt;) and NXM fields **tun\_metadatan**,
where _n_ ranges from 0 to 63, that can be operated on for the
purposes of matches, actions, etc. This TLV table can be used for
Geneve option TLVs or other protocols with options in same TLV format
as Geneve options. This mapping must be explicitly specified by the user
through the following commands.

A TLV mapping is specified with the syntax
**{class=class,type=type,len=length}-&gt;tun\_metadatan**.
When an option mapping exists for a given **tun\_metadatan**,
matching on the defined field becomes possible, e.g.:

ovs-ofctl add-tlv-map br0 "{class=0xffff,type=0,len=4}-&gt;tun_metadata0"

ovs-ofctl add-flow br0 tun_metadata0=1234,actions=controller

A mapping should not be changed while it is in active
use by a flow. The result of doing so is undefined.

These commands are Nicira extensions to OpenFlow and require Open vSwitch
2.5 or later.


* **add-tlv-map switch option**[**,option**]...  
  Add each _option_ to _switch_'s tables. Duplicate fields are
  rejected.
* **del-tlv-map _switch **[option_[**,option**]]...  
  Delete each _option_ from _switch_'s table, or all option TLV
  mapping if no _option_ is specified.
  Fields that aren't mapped are ignored.
* **dump-tlv-map switch**  
  Show the currently mapped fields in the switch's option table as well
  as switch capabilities.

<a name="openflow-switch-monitoring-commands"></a>

### OpenFlow Switch Monitoring Commands


* **snoop switch**  
  Connects to _switch_ and prints to the console all OpenFlow
  messages received.  Unlike other **ovs-ofctl** commands, if
  _switch_ is the name of a bridge, then the **snoop** command
  connects to a Unix domain socket named
  **/var/run/openvswitch/switch.snoop**.  **ovs-vswitchd** listens on
  such a socket for each bridge and sends to it all of the OpenFlow
  messages sent to or received from its configured OpenFlow controller.
  Thus, this command can be used to view OpenFlow protocol activity
  between a switch and its controller.
* When a switch has more than one controller configured, only the
  traffic to and from a single controller is output.  If none of the
  controllers is configured as a master or a slave (using a Nicira
  extension to OpenFlow 1.0 or 1.1, or a standard request in OpenFlow
  1.2 or later), then a controller is chosen arbitrarily among
  them.  If there is a master controller, it is chosen; otherwise, if
  there are any controllers that are not masters or slaves, one is
  chosen arbitrarily; otherwise, a slave controller is chosen
  arbitrarily.  This choice is made once at connection time and does not
  change as controllers reconfigure their roles.
* If a switch has no controller configured, or if
  the configured controller is disconnected, no traffic is sent, so
  monitoring will not show any traffic.
* **monitor _switch** [miss-len_] [**invalid\_ttl**] [**watch:**[_spec_...]]  
  Connects to _switch_ and prints to the console all OpenFlow
  messages received.  Usually, _switch_ should specify the name of a
  bridge in the **ovs-vswitchd** database.
* If _miss-len_ is provided, **ovs-ofctl** sends an OpenFlow \`\`set
  configuration'' message at connection setup time that requests
  _miss-len_ bytes of each packet that misses the flow table.  Open vSwitch
  does not send these and other asynchronous messages to an
  **ovs-ofctl monitor** client connection unless a nonzero value is
  specified on this argument.  (Thus, if _miss-len_ is not
  specified, very little traffic will ordinarily be printed.)
* If **invalid\_ttl** is passed, **ovs-ofctl** sends an OpenFlow \`\`set
  configuration'' message at connection setup time that requests
  **INVALID\_TTL\_TO\_CONTROLLER**, so that **ovs-ofctl monitor** can
  receive \`\`packet-in'' messages when TTL reaches zero on **dec\_ttl** action.
  Only OpenFlow 1.1 and 1.2 support **invalid\_ttl**; Open vSwitch also
  implements it for OpenFlow 1.0 as an extension.
* **watch:**[**spec**...] causes **ovs-ofctl** to send a
  \`\`monitor request'' Nicira extension message to the switch at
  connection setup time.  This message causes the switch to send
  information about flow table changes as they occur.  The following
  comma-separated _spec_ syntax is available:
    * **!initial**  
      Do not report the switch's initial flow table contents.
    * **!add**  
      Do not report newly added flows.
    * **!delete**  
      Do not report deleted flows.
    * **!modify**  
      Do not report modifications to existing flows.
    * **!own**  
      Abbreviate changes made to the flow table by **ovs-ofctl**'s own
      connection to the switch.  (These could only occur using the
      **ofctl/send** command described below under RUNTIME MANAGEMENT
      COMMANDS.)
    * **!actions**  
      Do not report actions as part of flow updates.
    * **table=table**  
      Limits the monitoring to the table with the given _table_, which
      may be expressed as a number between 0 and 254 or (unless
      **--no-names** is specified) a name.  By default, all tables are
      monitored.
    * **out\_port=port**  
      If set, only flows that output to _port_ are monitored.  The
      _port_ may be an OpenFlow port number or keyword
      (e.g. **LOCAL**).
    * field**=value**  
      Monitors only flows that have _field_ specified as the given
      _value_.  Any syntax valid for matching on **dump-flows** may
      be used.
* This command may be useful for debugging switch or controller
  implementations.  With **watch:**, it is particularly useful for
  observing how a controller updates flow tables.

<a name="openflow-switch-and-controller-commands"></a>

### OpenFlow Switch and Controller Commands

The following commands, like those in the previous section, may be
applied to OpenFlow switches, using any of the connection methods
described in that section.  Unlike those commands, these may also be
applied to OpenFlow controllers.

* **probe target**  
  Sends a single OpenFlow echo-request message to _target_ and waits
  for the response.  With the **-t** or **--timeout** option, this
  command can test whether an OpenFlow switch or controller is up and
  running.
* **ping _target **[n_]  
  Sends a series of 10 echo request packets to _target_ and times
  each reply.  The echo request packets consist of an OpenFlow header
  plus _n_ bytes (default: 64) of randomly generated payload.  This
  measures the latency of individual requests.
* **benchmark target n count**  
  Sends _count_ echo request packets that each consist of an
  OpenFlow header plus _n_ bytes of payload and waits for each
  response.  Reports the total time required.  This is a measure of the
  maximum bandwidth to _target_ for round-trips of _n_-byte
  messages.

<a name="other-commands"></a>

### Other Commands


* **ofp-parse** _file_  
  Reads _file_ (or **stdin** if _file_ is **-**) as a
  series of OpenFlow messages in the binary format used on an OpenFlow
  connection, and prints them to the console.  This can be useful for
  printing OpenFlow messages captured from a TCP stream.
* **ofp-parse-pcap** _file_ [_port_...]  
  Reads _file_, which must be in the PCAP format used by network
  capture tools such as **tcpdump** or **wireshark**, extracts all
  the TCP streams for OpenFlow connections, and prints the OpenFlow
  messages in those connections in human-readable format on
  **stdout**.
* OpenFlow connections are distinguished by TCP port number.
  Non-OpenFlow packets are ignored.  By default, data on TCP ports 6633
  and 6653 are considered to be OpenFlow.  Specify one or more
  _port_ arguments to override the default.
* This command cannot usefully print SSL encrypted traffic.  It does not
  understand IPv6.

<a name="flow-syntax"></a>

### Flow Syntax


Some **ovs-ofctl** commands accept an argument that describes a flow or
flows.  Such flow descriptions comprise a series of
field**=value** assignments, separated by commas or white
space.  (Embedding spaces into a flow description normally requires
quoting to prevent the shell from breaking the description into
multiple arguments.)

Flow descriptions should be in **normal form**.  This means that a
flow may only specify a value for an L3 field if it also specifies a
particular L2 protocol, and that a flow may only specify an L4 field
if it also specifies particular L2 and L3 protocol types.  For
example, if the L2 protocol type **dl\_type** is wildcarded, then L3
fields **nw\_src**, **nw\_dst**, and **nw\_proto** must also be
wildcarded.  Similarly, if **dl\_type** or **nw\_proto** (the L3
protocol type) is wildcarded, so must be the L4 fields **tcp\_dst** and
**tcp\_src**.  **ovs-ofctl** will warn about
flows not in normal form.

**ovs-fields**(7) describes the supported fields and how to match
them.  In addition to match fields, commands that operate on flows
accept a few additional key-value pairs:

* **table=table**  
  For flow dump commands, limits the flows dumped to those in
  _table_, which may be expressed as a number between 0 and 255 or
  (unless **--no-names** is specified) a name.  If not specified
  (or if 255 is specified as _table_), then flows in all tables are
  dumped.
* For flow table modification commands, behavior varies based on the
  OpenFlow version used to connect to the switch:
    * OpenFlow 1.0  
      OpenFlow 1.0 does not support **table** for modifying flows.
      **ovs-ofctl** will exit with an error if **table** (other than
      **table=255**) is specified for a switch that only supports OpenFlow
      1.0.
    * In OpenFlow 1.0, the switch chooses the table into which to insert a
      new flow.  The Open vSwitch software switch always chooses table 0.
      Other Open vSwitch datapaths and other OpenFlow implementations may
      choose different tables.
    * The OpenFlow 1.0 behavior in Open vSwitch for modifying or removing
      flows depends on whether **--strict** is used.  Without
      **--strict**, the command applies to matching flows in all tables.
      With **--strict**, the command will operate on any single matching
      flow in any table; it will do nothing if there are matches in more
      than one table.  (The distinction between these behaviors only matters
      if non-OpenFlow 1.0 commands were also used, because OpenFlow 1.0
      alone cannot add flows with the same matching criteria to multiple
      tables.)
    * OpenFlow 1.0 with table_id extension  
      Open vSwitch implements an OpenFlow extension that allows the
      controller to specify the table on which to operate.  **ovs-ofctl**
      automatically enables the extension when **table** is specified and
      OpenFlow 1.0 is used.  **ovs-ofctl** automatically detects whether
      the switch supports the extension.  As of this writing, this extension
      is only known to be implemented by Open vSwitch.
    * With this extension, **ovs-ofctl** operates on the requested table
      when **table** is specified, and acts as described for OpenFlow 1.0
      above when no **table** is specified (or for **table=255**).
    * OpenFlow 1.1  
      OpenFlow 1.1 requires flow table modification commands to specify a
      table.  When **table** is not specified (or **table=255** is
      specified), **ovs-ofctl** defaults to table 0.
    * OpenFlow 1.2 and later  
      OpenFlow 1.2 and later allow flow deletion commands, but not other
      flow table modification commands, to operate on all flow tables, with
      the behavior described above for OpenFlow 1.0.
* **duration=**...  
  .IQ "**n\_packet=**..."
  .IQ "**n\_bytes=**..."
  **ovs-ofctl** ignores assignments to these \`\`fields'' to allow
  output from the **dump-flows** command to be used as input for
  other commands that parse flows.

The **add-flow**, **add-flows**, and **mod-flows** commands
require an additional field, which must be the final field specified:

* **actions=**[_action_][**,_action**...]_  
  Specifies a comma-separated list of actions to take on a packet when the 
  flow entry matches.  If no _action_ is specified, then packets
  matching the flow are dropped.  The following forms of _action_
  are supported:
    * _port_  
      .IQ **output:port**
      Outputs the packet to OpenFlow port number _port_.  If _port_
      is the packet's input port, the packet is not output.
    * output:src[start..end]  
      Outputs the packet to the OpenFlow port number read from _src_,
      which may be an NXM field name, as described above, or a match field name.
      **output:reg0[16..31]** outputs to the OpenFlow port number
      written in the upper half of register 0.  If the port number is the
      packet's input port, the packet is not output.
    * This form of **output** was added in Open vSwitch 1.3.0.  This form
      of **output** uses an OpenFlow extension that is not supported by
      standard OpenFlow switches.
    * **output(port=port****,max\_len=nbytes**)  
      Outputs the packet to the OpenFlow port number read from _port_,
      with maximum packet size set to _nbytes_.  _port_ may be OpenFlow
      port number, **local**, or **in\_port**.  Patch port is not supported.
      Packets larger than _nbytes_ will be trimmed to _nbytes_ while
      packets smaller than _nbytes_ remains the original size.
    * **group:group\_id**  
      Outputs the packet to the OpenFlow group _group\_id_.  OpenFlow 1.1
      introduced support for groups; Open vSwitch 2.6 and later also
      supports output to groups as an extension to OpenFlow 1.0.  See
      **Group Syntax** for more details.
    * **normal**  
      Subjects the packet to the device's normal L2/L3 processing.  (This
      action is not implemented by all OpenFlow switches.)
    * **flood**  
      Outputs the packet on all switch physical ports other than the port on
      which it was received and any ports on which flooding is disabled
      (typically, these would be ports disabled by the IEEE 802.1D spanning
      tree protocol).
    * **all**  
      Outputs the packet on all switch physical ports other than the port on
      which it was received.
    * **local**  
      Outputs the packet on the \`\`local port,'' which corresponds to the
      network device that has the same name as the bridge.
    * **in\_port**  
      Outputs the packet on the port from which it was received.
    * **controller(key=value**...)  
      Sends the packet and its metadata to the OpenFlow controller as a \`\`packet in''
      message.  The supported key-value pairs are:
        * **max\_len=nbytes**  
          Limit to _nbytes_ the number of bytes of the packet to send to
          the controller.  By default the entire packet is sent.
        * **reason=reason**  
          Specify _reason_ as the reason for sending the message in the
          \`\`packet in'' message.  The supported reasons are **action** (the
          default), **no\_match**, and **invalid\_ttl**.
        * **id=controller-id**  
          Specify _controller-id_, a 16-bit integer, as the connection ID of
          the OpenFlow controller or controllers to which the \`\`packet in''
          message should be sent.  The default is zero.  Zero is also the
          default connection ID for each controller connection, and a given
          controller connection will only have a nonzero connection ID if its
          controller uses the **NXT\_SET\_CONTROLLER\_ID** Nicira extension to
          OpenFlow.
        * **userdata=_hh**..._  
          Supplies the bytes represented as hex digits _hh_ as additional
          data to the controller in the packet-in message.  Pairs of hex digits
          may be separated by periods for readability.
        * **pause**  
          Causes the switch to freeze the packet's trip through Open vSwitch
          flow tables and serializes that state into the packet-in message as a
          \`\`continuation,'' an additional property in the **NXT\_PACKET\_IN2**
          message.  The controller can later send the continuation back to the
          switch in an **NXT\_RESUME** message, which will restart the packet's
          traversal from the point where it was interrupted.  This permits an
          OpenFlow controller to interpose on a packet midway through processing
          in Open vSwitch.
        * **meter\_id=id**  
          Use meter _id_ to rate-limit the OpenFlow packet-in messages that
          this action sends to the controller.  By default, packets sent to the
          controller are associated with the "controller" virtual meter, if one
          was configured.
    * If any _reason_ other than **action** or any nonzero
      _controller-id_ is supplied, Open vSwitch extension
      **NXAST\_CONTROLLER**, supported by Open vSwitch 1.6 and later, is
      used.  If **userdata** is supplied, then **NXAST\_CONTROLLER2**,
      supported by Open vSwitch 2.6 and later, is used.
    * **controller**  
      .IQ **controller**[**:nbytes**]
      Shorthand for **controller()** or
      **controller(max\_len=nbytes)**, respectively.
    * **enqueue(port,queue)**  
      Enqueues the packet on the specified _queue_ within port
      _port_, which must be an OpenFlow port number or keyword
      (e.g. **LOCAL**).  The number of supported queues depends on the
      switch; some OpenFlow implementations do not support queuing at all.
    * **drop**  
      Discards the packet, so no further processing or forwarding takes place.
      If a drop action is used, no other actions may be specified.
    * **mod\_vlan\_vid**:_vlan\_vid_  
      Modifies the VLAN id on a packet.  The VLAN tag is added or modified 
      as necessary to match the value specified.  If the VLAN tag is added,
      a priority of zero is used (see the **mod\_vlan\_pcp** action to set
      this).
    * **mod\_vlan\_pcp**:_vlan\_pcp_  
      Modifies the VLAN priority on a packet.  The VLAN tag is added or modified 
      as necessary to match the value specified.  Valid values are between 0
      (lowest) and 7 (highest).  If the VLAN tag is added, a vid of zero is used 
      (see the **mod\_vlan\_vid** action to set this).
    * **strip\_vlan**  
      Strips the VLAN tag from a packet if it is present.
    * **push\_vlan**:_ethertype_  
      Push a new VLAN tag onto the packet.  Ethertype is used as the Ethertype
      for the tag. Only ethertype 0x8100 should be used. (0x88a8 which the spec
      allows isn't supported at the moment.)
      A priority of zero and the tag of zero are used for the new tag.
    * **push\_mpls**:_ethertype_  
      Changes the packet's Ethertype to _ethertype_, which must be either
      **0x8847** or **0x8848**, and pushes an MPLS LSE.
    * If the packet does not already contain any MPLS labels then an initial
      label stack entry is pushed.  The label stack entry's label is 2 if the
      packet contains IPv6 and 0 otherwise, its default traffic control value is
      the low 3 bits of the packet's DSCP value (0 if the packet is not IP), and
      its TTL is copied from the IP TTL (64 if the packet is not IP).
    * If the packet does already contain an MPLS label, pushes a new
      outermost label as a copy of the existing outermost label.
    * A limitation of the implementation is that processing of actions will stop
      if **push\_mpls** follows another **push\_mpls** unless there is a
      **pop\_mpls** in between.
    * **pop\_mpls**:_ethertype_  
      Strips the outermost MPLS label stack entry.
      Currently the implementation restricts _ethertype_ to a non-MPLS Ethertype
      and thus **pop\_mpls** should only be applied to packets with
      an MPLS label stack depth of one. A further limitation is that processing of
      actions will stop if **pop\_mpls** follows another **pop\_mpls** unless
      there is a **push\_mpls** in between.
    * **mod\_dl\_src:mac**  
      Sets the source Ethernet address to _mac_.
    * **mod\_dl\_dst:mac**  
      Sets the destination Ethernet address to _mac_.
    * **mod\_nw\_src:ip**  
      Sets the IPv4 source address to _ip_.
    * **mod\_nw\_dst:ip**  
      Sets the IPv4 destination address to _ip_.
    * **mod\_tp\_src:port**  
      Sets the TCP or UDP or SCTP source port to _port_.
    * **mod\_tp\_dst:port**  
      Sets the TCP or UDP or SCTP destination port to _port_.
    * **mod\_nw\_tos:tos**  
      Sets the DSCP bits in the IPv4 ToS/DSCP or IPv6 traffic class field to
      _tos_, which must be a multiple of 4 between 0 and 255.  This action
      does not modify the two least significant bits of the ToS field (the ECN bits).
    * **mod\_nw\_ecn:ecn**  
      Sets the ECN bits in the IPv4 ToS or IPv6 traffic class field to _ecn_,
      which must be a value between 0 and 3, inclusive.  This action does not modify
      the six most significant bits of the field (the DSCP bits).
    * Requires OpenFlow 1.1 or later.
    * **mod\_nw\_ttl:ttl**  
      Sets the IPv4 TTL or IPv6 hop limit field to _ttl_, which is specified as
      a decimal number between 0 and 255, inclusive.  Switch behavior when setting
      _ttl_ to zero is not well specified, though.
    * Requires OpenFlow 1.1 or later.
* The following actions are Nicira vendor extensions that, as of this writing, are
  only known to be implemented by Open vSwitch:
    * **resubmit:port**  
      .IQ **resubmit(**[_port_]**,**[_table_])
      .IQ **resubmit(**[_port_]**,**[_table_],ct)
      Re-searches this OpenFlow flow table (or table _table_, if
      specified) with the **in\_port** field replaced by
      _port_ (if _port_ is specified) and the packet 5-tuple fields
      swapped with the corresponding conntrack original direction tuple
      fields (if **ct** is specified, see **ct\_nw\_src** above), and
      executes the actions found, if any, in addition to any other actions
      in this flow entry.  The **in\_port** and swapped 5-tuple fields are
      restored immediately after the search, before any actions are
      executed.
    * The _table_ may be expressed as a number between 0 and 254 or
      (unless **--no-names** is specified) a name.
    * The **ct** option requires a valid connection tracking state as a
      match prerequisite in the flow where this action is placed.  Examples
      of valid connection tracking state matches include
      **ct\_state=+new**, **ct\_state=+est**, **ct\_state=+rel**, and
      **ct\_state=+trk-inv**.
    * Recursive **resubmit** actions are obeyed up to
      implementation-defined limits:
        * ·  
          Open vSwitch 1.0.1 and earlier did not support recursion.
        * ·  
          Open vSwitch 1.0.2 and 1.0.3 limited recursion to 8 levels.
        * ·  
          Open vSwitch 1.1 and 1.2 limited recursion to 16 levels.
        * ·  
          Open vSwitch 1.2 through 1.8 limited recursion to 32 levels.
        * ·  
          Open vSwitch 1.9 through 2.0 limited recursion to 64 levels.
        * ·  
          Open vSwitch 2.1 through 2.5 limited recursion to 64 levels and impose
          a total limit of 4,096 resubmits per flow translation (earlier versions
          did not impose any total limit).
        * ·  
          Open vSwitch 2.6 and later imposes the same limits as 2.5, with one
          exception: **resubmit** from table _x_ to any table _y_ &gt;
          _x_ does not count against the recursion limit.
    * Open vSwitch before 1.2.90 did not support _table_.  Open vSwitch
      before 2.7 did not support **ct**.
    * **set\_tunnel:id**  
      .IQ **set\_tunnel64:id**
      If outputting to a port that encapsulates the packet in a tunnel and
      supports an identifier (such as GRE), sets the identifier to _id_.
      If the **set\_tunnel** form is used and _id_ fits in 32 bits,
      then this uses an action extension that is supported by Open vSwitch
      1.0 and later.  Otherwise, if _id_ is a 64-bit value, it requires
      Open vSwitch 1.1 or later.
    * **set\_queue:queue**  
      Sets the queue that should be used to _queue_ when packets are
      output.  The number of supported queues depends on the switch; some
      OpenFlow implementations do not support queuing at all.
    * **pop\_queue**  
      Restores the queue to the value it was before any **set\_queue**
      actions were applied.
    * **ct**  
      .IQ **ct(**[_argument_][**,argument**...])
      Send the packet through the connection tracker.  Refer to the **ct\_state**
      documentation above for possible packet and connection states. A **ct**
      action always sets the packet to an untracked state and clears out the
      **ct\_state** fields for the current processing path.  Those fields are
      only available for the processing path pointed to by the **table**
      argument.  The following arguments are supported:
        * **commit**  
              Commit the connection to the connection tracking module. Information about the
              connection will be stored beyond the lifetime of the packet in the pipeline.
              Some **ct\_state** flags are only available for committed connections.
        * **force**  
              A committed connection always has the directionality of the packet
              that caused the connection to be committed in the first place.  This
              is the \`\`original direction'' of the connection, and the opposite
              direction is the \`\`reply direction''.  If a connection is already
              committed, but it is in the wrong direction, **force** flag may be
              used in addition to **commit** flag to effectively terminate the
              existing connection and start a new one in the current direction.
              This flag has no effect if the original direction of the connection is
              already the same as that of the current packet.
        * **table=table**  
          Fork pipeline processing in two. The original instance of the packet will
          continue processing the current actions list as an untracked packet. An
          additional instance of the packet will be sent to the connection tracker, which
          will be re-injected into the OpenFlow pipeline to resume processing in table
          _number_ (which may be specified as a number between 0 and 254 or,
          unless **--no-names** is specified, a name), with the
          **ct\_state** and other ct match fields set. If
          **table** is not specified, then the packet which is submitted to the
          connection tracker is not re-injected into the OpenFlow pipeline. It is
          strongly recommended to specify a table later than the current table to prevent
          loops.
        * **zone=value**  
          .IQ **zone=src[start..end]**
          A 16-bit context id that can be used to isolate connections into separate
          domains, allowing overlapping network addresses in different zones. If a zone
          is not provided, then the default is to use zone zero. The **zone** may be
          specified either as an immediate 16-bit _value_, or may be provided from an
          NXM field _src_. The _start_ and _end_ pair are inclusive, and must
          specify a 16-bit range within the field. This value is copied to the
          **ct\_zone** match field for packets which are re-injected into the pipeline
          using the **table** option.
        * **exec(**[_action_][**,action**...]**)**  
          Perform actions within the context of connection tracking. This is a restricted
          set of actions which are in the same format as their specifications as part
          of a flow. Only actions which modify the **ct\_mark** or **ct\_label**
          fields are accepted within the **exec** action, and these fields may only be
          modified with this option. For example:
            * **set\_field:_value**[**/mask**]-&gt;ct\_mark_  
              Store a 32-bit metadata value with the connection.  Subsequent lookups
              for packets in this connection will populate the **ct\_mark** flow
              field when the packet is sent to the connection tracker with the
              **table** specified.
            * **set\_field:_value**[**/mask**]-&gt;ct\_label_  
              Store a 128-bit metadata value with the connection.  Subsequent
              lookups for packets in this connection will populate the
              **ct\_label** flow field when the packet is sent to the connection
              tracker with the **table** specified.
        * The **commit** parameter must be specified to use **exec(...)**.
        * **alg=alg**  
          Specify application layer gateway _alg_ to track specific connection
          types. If subsequent related connections are sent through the **ct**
          action, then the **rel** flag in the **ct\_state** field will be set.
          Supported types include:
            * **ftp**  
              Look for negotiation of FTP data connections. Specify this option for FTP
              control connections to detect related data connections and populate the
              **rel** flag for the data connections.
            * **tftp**  
              Look for negotiation of TFTP data connections. Specify this option for TFTP
              control connections to detect related data connections and populate the
              **rel** flag for the data connections.
        * The **commit** parameter must be specified to use **alg=alg**.
        * When committing related connections, the **ct\_mark** for that connection is
          inherited from the current **ct\_mark** stored with the original connection
          (ie, the connection created by **ct(alg=...)**).
        * Note that with the Linux datapath, global sysctl options affect the usage of
          the **ct** action. In particular, if **net.netfilter.nf\_conntrack\_helper**
          is enabled then application layer gateway helpers may be executed even if the
          **alg** option is not specified. This is the default setting until Linux 4.7.
          For security reasons, the netfilter team recommends users to disable this
          option. See this blog post for further details:
          http://www.netfilter.org/news.html#2012-04-03
        * **nat**[**(**(**src**|**dst**)**=addr1**[**-addr2**][**:port1**[**-port2**]][**,flags**]**)**]  
          Specify address and port translation for the connection being tracked.
          For new connections either **src** or **dst** argument must be
          provided to set up either source address/port translation (SNAT) or
          destination address/port translation (DNAT), respectively.  Setting up
          address translation for a new connection takes effect only if the
          **commit** flag is also provided for the enclosing **ct** action.
          A bare **nat** action will only translate the packet being processed
          in the way the connection has been set up with an earlier **ct**
          action.  Also a **nat** action with **src** or **dst**, when
          applied to a packet belonging to an established (rather than new)
          connection, will behave the same as a bare **nat**.
        * **src** and **dst** options take the following arguments:
            * _addr1_[**-addr2**]  
              The address range from which the translated address should be
              selected.  If only one address is given, then that address will always
              be selected, otherwise the address selection can be informed by the
              optional **persistent** flag as described below.  Either IPv4 or
              IPv6 addresses can be provided, but both addresses must be of the same
              type, and the datapath behavior is undefined in case of providing IPv4
              address range for an IPv6 packet, or IPv6 address range for an IPv4
              packet.  IPv6 addresses must be bracketed with '[' and ']' if a port
              range is also given.
            * _port1_[**-port2**]  
              The port range from which the translated port should be selected.  If
              only one port number is provided, then that should be selected.  In
              case of a mapping conflict the datapath may choose any other
              non-conflicting port number instead, even when no port range is
              specified.  The port number selection can be informed by the optional
              **random** and **hash** flags as described below.
        * The optional flags are:
            * **random**  
              The selection of the port from the given range should be done using a
              fresh random number.  This flag is mutually exclusive with **hash**.
            * **hash**  
              The selection of the port from the given range should be done using a
              datapath specific hash of the packet's IP addresses and the other,
              non-mapped port number.  This flag is mutually exclusive with
              **random**.
            * **persistent**  
              The selection of the IP address from the given range should be done so
              that the same mapping can be provided after the system restarts.
        * If an **alg** is specified for the committing **ct** action that
          also includes **nat** with a **src** or **dst** attribute,
          then the datapath tries to set up the helper to be NAT aware.  This
          functionality is datapath specific and may not be supported by all
          datapaths.
        * **nat** was introduced in Open vSwitch 2.6.  The first datapath that
          implements **ct nat** support is the one that ships with Linux 4.6.
    * The **ct** action may be used as a primitive to construct stateful firewalls
      by selectively committing some traffic, then matching the **ct\_state** to
      allow established connections while denying new connections. The following
      flows provide an example of how to implement a simple firewall that allows new
      connections from port 1 to port 2, and only allows established connections to
      send traffic from port 2 to port 1:
          table=0,priority=1,action=drop
          table=0,priority=10,arp,action=normal
          table=0,priority=100,ip,ct_state=-trk,action=ct(table=1)
          table=1,in_port=1,ip,ct_state=+trk+new,action=ct(commit),2
          table=1,in_port=1,ip,ct_state=+trk+est,action=2
          table=1,in_port=2,ip,ct_state=+trk+new,action=drop
          table=1,in\_port=2,ip,ct\_state=+trk+est,action=1
    * If **ct** is executed on IP (or IPv6) fragments, then the message is
      implicitly reassembled before sending to the connection tracker and
      refragmented upon **output**, to the original maximum received fragment size.
      Reassembly occurs within the context of the **zone**, meaning that IP
      fragments in different zones are not assembled together. Pipeline processing
      for the initial fragments is halted; When the final fragment is received, the
      message is assembled and pipeline processing will continue for that flow.
      Because packet ordering is not guaranteed by IP protocols, it is not possible
      to determine which IP fragment will cause message reassembly (and therefore
      continue pipeline processing). As such, it is strongly recommended that
      multiple flows should not execute **ct** to reassemble fragments from the
      same IP message.
    * The **ct** action was introduced in Open vSwitch 2.5.
    * **ct\_clear**  
      Clears connection tracking state from the flow, zeroing
      **ct\_state**, **ct\_zone**, **ct\_mark**, and **ct\_label**.
    * This action was introduced in Open vSwitch 2.6.90.
    * **dec\_ttl**  
      .IQ **dec\_ttl(id1**[**,id2**]...**)**
      Decrement TTL of IPv4 packet or hop limit of IPv6 packet.  If the
      TTL or hop limit is initially zero or decrementing would make it so, no
      decrement occurs, as packets reaching TTL zero must be rejected.  Instead,
      a \`\`packet-in'' message with reason code **OFPR\_INVALID\_TTL** is
      sent to each connected controller that has enabled receiving them,
      if any.  Processing the current set of actions then stops.  However,
      if the current set of actions was reached through \`\`resubmit'' then
      remaining actions in outer levels resume processing.
    * This action also optionally supports the ability to specify a list of
      valid controller ids.  Each of the controllers in the list will receive
      the \`\`packet_in'' message only if they have registered to receive the
      invalid ttl packets.  If controller ids are not specified, the
      \`\`packet_in'' message will be sent only to the controllers having
      controller id zero which have registered for the invalid ttl packets.
    * **set\_mpls\_label**:_label_  
      Set the label of the outer MPLS label stack entry of a packet.
      _label_ should be a 20-bit value that is decimal by default;
      use a **0x** prefix to specify them in hexadecimal.
    * **set\_mpls\_tc**:_tc_  
      Set the traffic-class of the outer MPLS label stack entry of a packet.
      _tc_ should be a in the range 0 to 7 inclusive.
    * **set\_mpls\_ttl**:_ttl_  
      Set the TTL of the outer MPLS label stack entry of a packet.
      _ttl_ should be in the range 0 to 255 inclusive.
    * **dec\_mpls\_ttl**  
      Decrement TTL of the outer MPLS label stack entry of a packet.  If the TTL
      is initially zero or decrementing would make it so, no decrement occurs.
      Instead, a \`\`packet-in'' message with reason code **OFPR\_INVALID\_TTL**
      is sent to the main controller (id zero), if it has enabled receiving them.
      Processing the current set of actions then stops.  However, if the current
      set of actions was reached through \`\`resubmit'' then remaining actions in
      outer levels resume processing.
    * **dec\_nsh\_ttl**  
      Decrement TTL of the outer NSH header of a packet.  If the TTL
      is initially zero or decrementing would make it so, no decrement occurs.
      Instead, a \`\`packet-in'' message with reason code **OFPR\_INVALID\_TTL**
      is sent to the main controller (id zero), if it has enabled receiving them.
      Processing the current set of actions then stops.  However, if the current
      set of actions was reached through \`\`resubmit'' then remaining actions in
      outer levels resume processing.
    * **note:**[_hh_]...  
      Does nothing at all.  Any number of bytes represented as hex digits
      _hh_ may be included.  Pairs of hex digits may be separated by
      periods for readability.
      The **note** action's format doesn't include an exact length for its
      payload, so the provided bytes will be padded on the right by enough
      bytes with value 0 to make the total number 6 more than a multiple of
      8.
    * **move:src[start..end]-&gt;dst[start..end]**  
      Copies the named bits from field _src_ to field _dst_.
      _src_ and _dst_ may be NXM field names as defined in
      **nicira-ext.h**, e.g. **NXM\_OF\_UDP\_SRC** or **NXM\_NX\_REG0**,
      or a match field name, e.g. **reg0**.  Each
      _start_ and _end_ pair, which are inclusive, must specify the
      same number of bits and must fit within its respective field.
      Shorthands for **[start..end]** exist: use
      **[bit]** to specify a single bit or **[]** to specify an
      entire field (in the latter case the brackets can also be left off).
    * Examples: **move:NXM\_NX\_REG0[0..5]-&gt;NXM\_NX\_REG1[26..31]** copies the
      six bits numbered 0 through 5, inclusive, in register 0 into bits 26
      through 31, inclusive;
      **move:reg0[0..15]-&gt;vlan\_tci** copies the least
      significant 16 bits of register 0 into the VLAN TCI field.
    * In OpenFlow 1.0 through 1.4, **move** ordinarily uses an Open
      vSwitch extension to OpenFlow.  In OpenFlow 1.5, **move** uses the
      OpenFlow 1.5 standard **copy\_field** action.  The ONF has
      also made **copy\_field** available as an extension to OpenFlow 1.3.
      Open vSwitch 2.4 and later understands this extension and uses it if a
      controller uses it, but for backward compatibility with older versions
      of Open vSwitch, **ovs-ofctl** does not use it.
    * **set\_field:_value**[/mask_]-&gt;dst  
      .IQ "load:value-&gt;dst[start..end]"
      Loads a literal value into a field or part of a field.  With
      **set\_field**, **value** and the optional **mask** are given in
      the customary syntax for field _dst_, which is expressed as a
      field name.  For example, **set\_field:00:11:22:33:44:55-&gt;eth\_src**
      sets the Ethernet source address to 00:11:22:33:44:55.  With
      **load**, _value_ must be an integer value (in decimal or
      prefixed by **0x** for hexadecimal) and _dst_ can also be the
      NXM or OXM name for the field.  For example,
      **load:0x001122334455-&gt;OXM\_OF\_ETH\_SRC[]** has the same effect as the
      prior **set\_field** example.
    * The two forms exist for historical reasons.  Open vSwitch 1.1
      introduced **NXAST\_REG\_LOAD** as a Nicira extension to OpenFlow 1.0
      and used **load** to express it.  Later, OpenFlow 1.2 introduced a
      standard **OFPAT\_SET\_FIELD** action that was restricted to loading
      entire fields, so Open vSwitch added the form **set\_field** with
      this restriction.  OpenFlow 1.5 extended **OFPAT\_SET\_FIELD** to the
      point that it became a superset of **NXAST\_REG\_LOAD**.  Open vSwitch
      translates either syntax as necessary for the OpenFlow version in use:
      in OpenFlow 1.0 and 1.1, **NXAST\_REG\_LOAD**; in OpenFlow 1.2, 1.3,
      and 1.4, **NXAST\_REG\_LOAD** for **load** or for loading a
      subfield, **OFPAT\_SET\_FIELD** otherwise; and OpenFlow 1.5 and later,
      **OFPAT\_SET\_FIELD**.
    * push:src[start..end]  
      .IQ "pop:dst[start..end]"
      These Open vSwitch extension actions act on bits _start_ to
      _end_, inclusive, in the named field, pushing or popping the bits
      on a general-purpose stack of fields or subfields.  Controllers can
      use this stack for saving and restoring data or metadata around
      **resubmit** actions, for swapping or rearranging data and metadata,
      or for other purposes.  Any data or metadata field, or part of one,
      may be pushed, and any modifiable field or subfield may be popped.
    * The number of bits pushed in a stack entry do not have to match the
      number of bits later popped from that entry.  If more bits are popped
      from an entry than were pushed, then the entry is conceptually
      left-padded with 0-bits as needed.  If fewer bits are popped than
      pushed, then bits are conceptually trimmed from the left side of the
      entry.
    * The stack's size is intended to have a large enough limit that
      \`\`normal'' use will not pose problems.  Stack overflow or underflow is
      an error that causes action execution to stop.
    * Example: **push:NXM\_NX\_REG2[0..5]** or **push:reg2[0..5]** push
      the value stored in register 2 bits 0 through 5, inclusive, on the
      internal stack, and **pop:NXM\_NX\_REG2[0..5]** or
      **pop:reg2[0..5]** pops the value from top of the stack and sets
      register 2 bits 0 through 5, inclusive, based on bits 0 through 5 from
      the value just popped.
    * **multipath(fields, basis, algorithm, n_links, arg, dst[start..end])**  
      Hashes _fields_ using _basis_ as a universal hash parameter,
      then the applies multipath link selection _algorithm_ (with
      parameter _arg_) to choose one of _n\_links_ output links
      numbered 0 through _n\_links_ minus 1, and stores the link into
      dst**[start..end]**, which must be an NXM field as
      described above.
    * _fields_ must be one of the following:
        * **eth\_src**  
          Hashes Ethernet source address only.
        * **symmetric\_l4**  
          Hashes Ethernet source, destination, and type, VLAN ID, IPv4/IPv6
          source, destination, and protocol, and TCP or SCTP (but not UDP)
          ports.  The hash is computed so that pairs of corresponding flows in
          each direction hash to the same value, in environments where L2 paths
          are the same in each direction.  UDP ports are not included in the
          hash to support protocols such as VXLAN that use asymmetric ports in
          each direction.
        * **symmetric\_l3l4**  
          Hashes IPv4/IPv6 source, destination, and protocol, and TCP or SCTP
          (but not UDP) ports.  Like **symmetric\_l4**, this is a symmetric
          hash, but by excluding L2 headers it is more effective in environments
          with asymmetric L2 paths (e.g. paths involving VRRP IP addresses on a
          router).  Not an effective hash function for protocols other than IPv4
          and IPv6, which hash to a constant zero.
        * **symmetric\_l3l4+udp**  
          Like **symmetric\_l3l4+udp**, but UDP ports are included in the hash.
          This is a more effective hash when asymmetric UDP protocols such as
          VXLAN are not a consideration.
        * **nw\_src**  
          Hashes Network source address only.
        * **nw\_dst**  
          Hashes Network destination address only.
    * _algorithm_ must be one of **modulo\_n**,
      **hash\_threshold**, **hrw**, and **iter\_hash**.  Only
      the **iter\_hash** algorithm uses _arg_.
    * Refer to **nicira-ext.h** for more details.
    * **bundle(fields, basis, algorithm, slave_type, slaves:[s1, s2, ...])**  
      Hashes _fields_ using _basis_ as a universal hash parameter, then
      applies the bundle link selection _algorithm_ to choose one of the listed
      slaves represented as _slave\_type_.  Currently the only supported
      _slave\_type_ is **ofport**.  Thus, each _s1_ through _sN_ should
      be an OpenFlow port number. Outputs to the selected slave.
    * Currently, _fields_ must be either **eth\_src**, **symmetric\_l4**, **symmetric\_l3l4**, **symmetric\_l3l4+udp**, 
      **nw\_src**, or **nw\_dst**, and _algorithm_ must be one of **hrw** and **active\_backup**.
    * Example: **bundle(eth\_src,0,hrw,ofport,slaves:4,8)** uses an Ethernet source
      hash with basis 0, to select between OpenFlow ports 4 and 8 using the Highest
      Random Weight algorithm.
    * Refer to **nicira-ext.h** for more details.
    * **bundle\_load(fields, basis, algorithm, slave_type, dst[start..end], slaves:[s1, s2, ...])**  
      Has the same behavior as the **bundle** action, with one exception.  Instead
      of outputting to the selected slave, it writes its selection to
      dst**[start..end]**, which must be an NXM field as described
      above.
    * Example: bundle_load(eth_src, 0, hrw, ofport, NXM_NX_REG0[],
      slaves:4, 8) uses an Ethernet source hash with basis 0, to select
      between OpenFlow ports 4 and 8 using the Highest Random Weight
      algorithm, and writes the selection to **NXM\_NX\_REG0[]**.  Also the
      match field name can be used, for example, instead of 'NXM_NX_REG0'
      the name 'reg0' can be used.  When the while field is indicated the
      empty brackets can also be left off.
    * Refer to **nicira-ext.h** for more details.
    * **learn(argument**[**,argument**]...**)**  
      This action adds or modifies a flow in an OpenFlow table, similar to
      **ovs-ofctl --strict mod-flows**.  The arguments specify the
      flow's match fields, actions, and other properties, as follows.  At
      least one match criterion and one action argument should ordinarily be
      specified.
        * **idle\_timeout=seconds**  
          .IQ **hard\_timeout=seconds**
          .IQ **priority=value**
          .IQ **cookie=value**
          .IQ **send\_flow\_rem**
          These arguments have the same meaning as in the usual **ovs-ofctl**
          flow syntax.
        * **fin\_idle\_timeout=seconds**  
          .IQ **fin\_hard\_timeout=seconds**
          Adds a **fin\_timeout** action with the specified arguments to the
          new flow.  This feature was added in Open vSwitch 1.5.90.
        * **table=table**  
          The table in which the new flow should be inserted.  Specify a decimal
          number between 0 and 254 or (unless **--no-names** is specified)
          a name.  The default, if **table** is unspecified, is table 1.
        * **delete\_learned**  
          This flag enables deletion of the learned flows when the flow with the
          **learn** action is removed.  Specifically, when the last
          **learn** action with this flag and particular **table** and
          **cookie** values is removed, the switch deletes all of the flows in
          the specified table with the specified cookie.
        * This flag was added in Open vSwitch 2.4.
        * **limit=number**  
          If the number of flows in table **table** with cookie id **cookie** exceeds
          _number_, a new flow will not be learned by this action.  By default
          there's no limit. limit=0 is a long-hand for no limit.
        * This flag was added in Open vSwitch 2.8.
        * **result\_dst=field[bit]**  
          If learning failed (because the number of flows exceeds **limit**),
          the action sets field**[bit]** to 0, otherwise it will be set to 1.
          field**[bit]** must be a single bit.
        * This flag was added in Open vSwitch 2.8.
        * field**=value**  
          .IQ field**[start..end]=src[start..end]**
          .IQ field**[start..end]**
          Adds a match criterion to the new flow.
        * The first form specifies that _field_ must match the literal
          _value_, e.g. **dl\_type=0x0800**.  All of the fields and values
          for **ovs-ofctl** flow syntax are available with their usual
          meanings.  Shorthand notation matchers (e.g. **ip** in place of
          **dl\_type=0x0800**) are not currently implemented.
        * The second form specifies that field**[start..end]**
          in the new flow must match src**[start..end]** taken
          from the flow currently being processed.
          For example, NXM\_OF\_UDP\_DST**[]**=NXM\_OF\_UDP\_SRC**[]** on a
          TCP packet for which the UDP src port is **53**, creates a flow which
          matches NXM\_OF\_UDP\_DST**[]**=**53**.
        * The third form is a shorthand for the second form.  It specifies that
          field**[start..end]** in the new flow must match the same
          field**[start..end]** taken from the flow currently
          being processed.
          For example, NXM\_OF\_TCP\_DST**[]** on a TCP packet
          for which the TCP dst port is **80**, creates a flow which
          matches NXM\_OF\_TCP\_DST**[]**=**80**.
        * load:value-&gt;dst[start..end]  
          .IQ load:src[start..end]-&gt;dst[start..end]
          Adds a **load** action to the new flow.
        * The first form loads the literal _value_ into bits _start_
          through _end_, inclusive, in field _dst_.  Its syntax is the
          same as the **load** action described earlier in this section.
        * The second form loads src**[start..end]**, a value
          from the flow currently being processed, into bits _start_
          through _end_, inclusive, in field _dst_.
        * **output:field[start..end]**  
          Add an **output** action to the new flow's actions, that outputs to
          the OpenFlow port taken from field**[start..end]**,
          which must be an NXM field as described above.
    * **clear\_actions**  
      Clears all the actions in the action set immediately.
    * **write\_actions(**[_action_][**,action**...])  
      Add the specific actions to the action set.  The syntax of
      _actions_ is the same as in the **actions=** field.  The action
      set is carried between flow tables and then executed at the end of the
      pipeline.
    * The actions in the action set are applied in the following order, as
      required by the OpenFlow specification, regardless of the order in
      which they were added to the action set.  Except as specified
      otherwise below, the action set only holds at most a single action of
      each type.  When more than one action of a single type is written to
      the action set, the one written later replaces the earlier action:
        * 1.  
          **strip\_vlan**
          .IQ
          **pop\_mpls**
        * 2.  
          **decap**
        * 3.  
          **encap**
        * 4.  
          **push\_mpls**
        * 5.  
          **push\_vlan**
        * 6.  
          **dec\_ttl**
          .IQ
          **dec\_mpls\_ttl**
          .IQ
          **dec\_nsh\_ttl**
        * 7.  
          **load**
          .IQ
          **move**
          .IQ
          **mod\_dl\_dst**
          .IQ
          **mod\_dl\_src**
          .IQ
          **mod\_nw\_dst**
          .IQ
          **mod\_nw\_src**
          .IQ
          **mod\_nw\_tos**
          .IQ
          **mod\_nw\_ecn**
          .IQ
          **mod\_nw\_ttl**
          .IQ
          **mod\_tp\_dst**
          .IQ
          **mod\_tp\_src**
          .IQ
          **mod\_vlan\_pcp**
          .IQ
          **mod\_vlan\_vid**
          .IQ
          **set\_field**
          .IQ
          **set\_tunnel**
          .IQ
          **set\_tunnel64**
          .IQ
          The action set can contain any number of these actions, with
          cumulative effect. They will be applied in the order as added.
          That is, when multiple actions modify the same part of a field,
          the later modification takes effect, and when they modify
          different parts of a field (or different fields), then both
          modifications are applied.
        * 8.  
          **set\_queue**
        * 9.  
          **group**
          .IQ
          **output**
          .IQ
          **resubmit**
          .IQ
          If more than one of these actions is present, then the one listed
          earliest above is executed and the others are ignored, regardless of
          the order in which they were added to the action set.  (If none of these
          actions is present, the action set has no real effect, because the
          modified packet is not sent anywhere and thus the modifications are
          not visible.)
    * Only the actions listed above may be written to the action set.
      **encap**, **decap** and **dec\_nsh\_ttl** actions are nonstandard.
    * **write\_metadata:_value**[/mask_]  
      Updates the metadata field for the flow. If _mask_ is omitted, the
      metadata field is set exactly to _value_; if _mask_ is specified, then
      a 1-bit in _mask_ indicates that the corresponding bit in the metadata
      field will be replaced with the corresponding bit from _value_. Both
      _value_ and _mask_ are 64-bit values that are decimal by default; use
      a **0x** prefix to specify them in hexadecimal.
    * **meter**:_meter\_id_  
      Apply the _meter\_id_ before any other actions. If a meter band rate is
      exceeded, the packet may be dropped, or modified, depending on the meter
      band type. See the description of the **Meter Table Commands**, above,
      for more details.
    * **goto\_table**:_table_  
      Jumps to table\Fr as the next table in the process pipeline.  The
      _table_ may be a number between 0 and 254 or (unless
      **--no-names** is specified) a name.
    * **fin\_timeout(argument**[**,argument**])  
      This action changes the idle timeout or hard timeout, or both, of this
      OpenFlow rule when the rule matches a TCP packet with the FIN or RST
      flag.  When such a packet is observed, the action reduces the rule's
      timeouts to those specified on the action.  If the rule's existing
      timeout is already shorter than the one that the action specifies,
      then that timeout is unaffected.
    * _argument_ takes the following forms:
        * **idle\_timeout=seconds**  
          Causes the flow to expire after the given number of seconds of
          inactivity.
        * **hard\_timeout=seconds**  
          Causes the flow to expire after the given number of seconds,
          regardless of activity.  (_seconds_ specifies time since the
          flow's creation, not since the receipt of the FIN or RST.)
    * This action was added in Open vSwitch 1.5.90.
    * **sample(argument**[**,argument**]...**)**  
      Samples packets and sends one sample for every sampled packet.
    * _argument_ takes the following forms:
        * **probability=packets**  
          The number of sampled packets out of 65535.  Must be greater or equal to 1.
        * **collector\_set\_id=id**  
          The unsigned 32-bit integer identifier of the set of sample collectors
          to send sampled packets to.  Defaults to 0.
        * **obs\_domain\_id=id**  
          When sending samples to IPFIX collectors, the unsigned 32-bit integer
          Observation Domain ID sent in every IPFIX flow record.  Defaults to 0.
        * **obs\_point\_id=id**  
          When sending samples to IPFIX collectors, the unsigned 32-bit integer
          Observation Point ID sent in every IPFIX flow record.  Defaults to 0.
        * **sampling\_port=port**  
          Sample packets on _port_, which should be the ingress or egress
          port.  This option, which was added in Open vSwitch 2.5.90, allows the
          IPFIX implementation to export egress tunnel information.
        * **ingress**  
          .IQ "**egress**"
          Specifies explicitly that the packet is being sampled on ingress to or
          egress from the switch.  IPFIX reports sent by Open vSwitch before
          version 2.5.90 did not include a direction.  From 2.5.90 until 2.6.90,
          IPFIX reports inferred a direction from **sampling\_port**: if it was
          the packet's output port, then the direction was reported as egress,
          otherwise as ingress.  Open vSwitch 2.6.90 introduced these options,
          which allow the inferred direction to be overridden.  This is
          particularly useful when the ingress (or egress) port is not a tunnel.
    * Refer to **ovs-vswitchd.conf.db**(5) for more details on
      configuring sample collector sets.
    * This action was added in Open vSwitch 1.10.90.
    * **exit**  
      This action causes Open vSwitch to immediately halt execution of
      further actions.  Those actions which have already been executed are
      unaffected.  Any further actions, including those which may be in
      other tables, or different levels of the **resubmit** call stack,
      are ignored.  Actions in the action set is still executed (specify
      **clear\_actions** before **exit** to discard them).
    * **conjunction(id, k/n****)**  
      This action allows for sophisticated \`\`conjunctive match'' flows.
      Refer to **CONJUNCTIVE MATCH FIELDS** in **ovs-fields**(7) for details.
    * The **conjunction** action and **conj\_id** field were introduced
      in Open vSwitch 2.4.
    * **clone(**[_action_][**,action**...]**)**  
      Executes each nested _action_, saving much of the packet and
      pipeline state beforehand and then restoring it afterward.  The state
      that is saved and restored includes all flow data and metadata
      (including, for example, **ct\_state**), the stack accessed by
      **push** and **pop** actions, and the OpenFlow action set.
    * This action was added in Open vSwitch 2.6.90.
    * **encap(**_header_[**(**_prop_**=**_value_,_tlv_**(**_class_,_type_,value**)**,...**)**]**)**  
      Encapsulates the packet with a new packet header, e.g., ethernet
      or nsh.
        * _header_  
          Used to specify encapsulation header type.
        * _prop_**=**_value_  
          Used to specify the initial value for the property in the encapsulation header.
        * _tlv_**(**_class_,_type_,value**)**  
          Used to specify the initial value for the TLV (Type Length Value)
          in the encapsulation header.
    * For example, **encap(ethernet)** will encapsulate the L3 packet with
      Ethernet header.
    * **encap(nsh(md\_type=1))** will encapsulate the packet with nsh header
      and nsh metadata type 1.
    * **encap(nsh(md\_type=2,tlv(0x1000,10,0x12345678)))** will encapsulate
      the packet with nsh header and nsh metadata type 2, and the nsh TLV with
      class 0x1000 and type 10 is set to 0x12345678.
    * _prop_**=**_value_ is just used to set some
      necessary fields for encapsulation header initialization. Other fields
      in the encapsulation header must be set by **set\_field** action. New
      encapsulation header implementation must add new match fields and
      corresponding **set** action in order that **set\_field** action can
      change the fields in the encapsulation header on demand.
    * **encap(nsh(md\_type=1)),**
      **set\_field:0x1234-&gt;nsh\_spi,set\_field:0x11223344-&gt;nsh\_c1**
      is an example to encapsulate nsh header and set nsh spi and c1.
    * This action was added in Open vSwitch 2.8.
    * **decap(**[**packet\_type(ns=**_namespace_**,type=**_type_**)**]**)**  
      Decapsulates the outer packet header.
        * **packet\_type(ns=**_namespace_**,type=**_type_**)**  
          It is optional and used to specify the outer header type of the
          decapsulated packet. _namespace_ is 0 for Ethernet packet,
          1 for L3 packet, _type_&nbsp;is L3 protocol type, e.g.,
          0x894f for nsh, 0x0 for Ethernet.
    * By default, **decap()** will decapsulate the outer packet header
      according to the packet header type, if
      **packet\_type(ns=**_namespace_**,type=**_type_**)**
      is given, it will decapsulate the given packet header, it will fail
      if the actual outer packet header type is not of
      **packet\_type(ns=**_namespace_**,type=**_type_**)**.
    * This action was added in Open vSwitch 2.8.

An opaque identifier called a cookie can be used as a handle to identify
a set of flows:

* **cookie=value**  
  A cookie can be associated with a flow using the **add-flow**,
  **add-flows**, and **mod-flows** commands.  _value_ can be any
  64-bit number and need not be unique among flows.  If this field is
  omitted, a default cookie value of 0 is used.
* **cookie=value****/mask**  
  When using NXM, the cookie can be used as a handle for querying,
  modifying, and deleting flows.  _value_ and _mask_ may be
  supplied for the **del-flows**, **mod-flows**, **dump-flows**, and
  **dump-aggregate** commands to limit matching cookies.  A 1-bit in
  _mask_ indicates that the corresponding bit in _cookie_ must
  match exactly, and a 0-bit wildcards that bit.  A mask of -1 may be used
  to exactly match a cookie.
* The **mod-flows** command can update the cookies of flows that
  match a cookie by specifying the _cookie_ field twice (once with a
  mask for matching and once without to indicate the new value):
    * **ovs-ofctl mod-flows br0 cookie=1,actions=normal**  
      Change all flows' cookies to 1 and change their actions to **normal**.
    * **ovs-ofctl mod-flows br0 cookie=1/-1,cookie=2,actions=normal**  
      Update cookies with a value of 1 to 2 and change their actions to
      **normal**.
* The ability to match on cookies was added in Open vSwitch 1.5.0.

The following additional field sets the priority for flows added by
the **add-flow** and **add-flows** commands.  For
**mod-flows** and **del-flows** when **--strict** is
specified, priority must match along with the rest of the flow
specification.  For **mod-flows** without **--strict**,
priority is only significant if the command creates a new flow, that
is, non-strict **mod-flows** does not match on priority and will
not change the priority of existing flows.  Other commands do not
allow priority to be specified.

* **priority=value**  
  The priority at which a wildcarded entry will match in comparison to
  others.  _value_ is a number between 0 and 65535, inclusive.  A higher 
  _value_ will match before a lower one.  An exact-match entry will always 
  have priority over an entry containing wildcards, so it has an implicit 
  priority value of 65535.  When adding a flow, if the field is not specified, 
  the flow's priority will default to 32768.
* OpenFlow leaves behavior undefined when two or more flows with the
  same priority can match a single packet.  Some users expect
  \`\`sensible'' behavior, such as more specific flows taking precedence
  over less specific flows, but OpenFlow does not specify this and Open
  vSwitch does not implement it.  Users should therefore take care to
  use priorities to ensure the behavior that they expect.

The **add-flow**, **add-flows**, and **mod-flows** commands
support the following additional options.  These options affect only
new flows.  Thus, for **add-flow** and **add-flows**, these
options are always significant, but for **mod-flows** they are
significant only if the command creates a new flow, that is, their
values do not update or affect existing flows.

* **idle\_timeout=seconds**  
  Causes the flow to expire after the given number of seconds of
  inactivity.  A value of 0 (the default) prevents a flow from expiring
  due to inactivity.
* **hard\_timeout=seconds**  
  Causes the flow to expire after the given number of seconds,
  regardless of activity.  A value of 0 (the default) gives the flow no
  hard expiration deadline.
* **importance=value**  
  Sets the importance of a flow.  The flow entry eviction mechanism can
  use importance as a factor in deciding which flow to evict.  A value
  of 0 (the default) makes the flow non-evictable on the basis of
  importance.  Specify a value between 0 and 65535.
* Only OpenFlow 1.4 and later support **importance**.
* **send\_flow\_rem**  
  Marks the flow with a flag that causes the switch to generate a \`\`flow
  removed'' message and send it to interested controllers when the flow
  later expires or is removed.
* **check\_overlap**  
  Forces the switch to check that the flow match does not overlap that
  of any different flow with the same priority in the same table.  (This
  check is expensive so it is best to avoid it.)
* **reset\_counts**  
  When this flag is specified on a flow being added to a switch, and the
  switch already has a flow with an identical match, an OpenFlow 1.2 (or
  later) switch resets the flow's packet and byte counters to 0.
  Without the flag, the packet and byte counters are preserved.
* OpenFlow 1.0 and 1.1 switches always reset counters in this situation,
  as if **reset\_counts** were always specified.
* Open vSwitch 1.10 added support for **reset\_counts**.
* **no\_packet\_counts**  
  .IQ "**no\_byte\_counts**"
  Adding these flags to a flow advises an OpenFlow 1.3 (or later) switch
  that the controller does not need packet or byte counters,
  respectively, for the flow.  Some switch implementations might achieve
  higher performance or reduce resource consumption when these flags are
  used.  These flags provide no benefit to the Open vSwitch software
  switch implementation.
* OpenFlow 1.2 and earlier do not support these flags.
* Open vSwitch 1.10 added support for **no\_packet\_counts** and
  **no\_byte\_counts**.

The **dump-flows**, **dump-aggregate**, **del-flow** 
and **del-flows** commands support these additional optional fields:

* **out\_port=port**  
  If set, a matching flow must include an output action to _port_,
  which must be an OpenFlow port number or name (e.g. **local**).
* **out\_group=port**  
  If set, a matching flow must include an **group** action naming
  _group_, which must be an OpenFlow group number.  This field
  is supported in Open vSwitch 2.5 and later and requires OpenFlow 1.1
  or later.

<a name="table-entry-output"></a>

### Table Entry Output

The **dump-tables** and **dump-aggregate** commands print information 
about the entries in a datapath's tables.  Each line of output is a 
flow entry as described in **Flow Syntax**, above, plus some
additional fields:

* **duration=secs**  
  The time, in seconds, that the entry has been in the table.
  _secs_ includes as much precision as the switch provides, possibly
  to nanosecond resolution.
* **n\_packets**  
  The number of packets that have matched the entry.
* **n\_bytes**  
  The total number of bytes from packets that have matched the entry.

The following additional fields are included only if the switch is
Open vSwitch 1.6 or later and the NXM flow format is used to dump the
flow (see the description of the **--flow-format** option below).
The values of these additional fields are approximations only and in
particular **idle\_age** will sometimes become nonzero even for busy
flows.

* **hard\_age=secs**  
  The integer number of seconds since the flow was added or modified.
  **hard\_age** is displayed only if it differs from the integer part
  of **duration**.  (This is separate from **duration** because
  **mod-flows** restarts the **hard\_timeout** timer without zeroing
  **duration**.)
* **idle\_age=secs**  
  The integer number of seconds that have passed without any packets
  passing through the flow.

<a name="packet-out-syntax"></a>

### Packet\-Out Syntax


**ovs-ofctl bundle** command accepts packet-outs to be specified in
the bundle file.  Each packet-out comprises of a series of
field**=value** assignments, separated by commas or white
space.  (Embedding spaces into a packet-out description normally
requires quoting to prevent the shell from breaking the description
into multiple arguments.).  Unless noted otherwise only the last
instance of each field is honoured.  This same syntax is also
supported by the **ovs-ofctl packet-out** command.


* **in\_port=port**  
  The port number to be considered the in_port when processing actions.
  This can be any valid OpenFlow port number, or any of the **LOCAL**,
  **CONTROLLER**, or **NONE**.
  This field is required.
  
* _pipeline\_field_=_value_  
  Optionally, user can specify a list of pipeline fields for a packet-out
  message. The supported pipeline fields includes **tunnel fields** and
  **register fields** as defined in **ovs-fields**(7).
  
* **packet=hex-string**  
  The actual packet to send, expressed as a string of hexadecimal bytes.
  This field is required.
  
* **actions=**[_action_][**,_action**...]_  
  The syntax of actions are identical to the **actions=** field
  described in **Flow Syntax** above.  Specifying **actions=** is
  optional, but omitting actions is interpreted as a drop, so the packet
  will not be sent anywhere from the switch.
  **actions** must be specified at the end of each line, like for flow mods.

<a name="group-syntax"></a>

### Group Syntax


Some **ovs-ofctl** commands accept an argument that describes a group or
groups.  Such flow descriptions comprise a series
field**=value** assignments, separated by commas or white
space.  (Embedding spaces into a group description normally requires
quoting to prevent the shell from breaking the description into
multiple arguments.). Unless noted otherwise only the last instance
of each field is honoured.


* **group\_id=id**  
  The integer group id of group.
  When this field is specified in **del-groups** or **dump-groups**,
  the keyword "all" may be used to designate all groups.
  This field is required.
  
  
* **type=type**  
  The type of the group.  The **add-group**, **add-groups** and
  **mod-groups** commands require this field.  It is prohibited for
  other commands. The following keywords designated the allowed types:
    * **all**  
      Execute all buckets in the group.
    * **select**  
      Execute one bucket in the group, balancing across the buckets
      according to their weights.  To select a bucket, for each live bucket,
      Open vSwitch hashes flow data with the bucket ID and multiplies by the
      bucket weight to obtain a \`\`score,'' and then selects the bucket with
      the highest score.  Use **selection\_method** to control the flow
      data used for selection.
    * **indirect**  
      Executes the one bucket in the group.
    * **ff**  
      .IQ **fast\_failover**
      Executes the first live bucket in the group which is associated with
      a live port or group.
  
* **command\_bucket\_id=id**  
  The bucket to operate on.  The **insert-buckets** and **remove-buckets**
  commands require this field.  It is prohibited for other commands.
  _id_ may be an integer or one of the following keywords:
    * **all**  
      Operate on all buckets in the group.
      Only valid when used with the **remove-buckets** command in which
      case the effect is to remove all buckets from the group.
    * **first**  
      Operate on the first bucket present in the group.
      In the case of the **insert-buckets** command the effect is to
      insert new bucets just before the first bucket already present in the group;
      or to replace the buckets of the group if there are no buckets already present
      in the group.
      In the case of the **remove-buckets** command the effect is to
      remove the first bucket of the group; or do nothing if there are no
      buckets present in the group.
    * **last**  
      Operate on the last bucket present in the group.
      In the case of the **insert-buckets** command the effect is to
      insert new bucets just after the last bucket already present in the group;
      or to replace the buckets of the group if there are no buckets already present
      in the group.
      In the case of the **remove-buckets** command the effect is to
      remove the last bucket of the group; or do nothing if there are no
      buckets present in the group.
* If _id_ is an integer then it should correspond to the **bucket\_id**
  of a bucket present in the group.
  In case of the **insert-buckets** command the effect is to
  insert buckets just before the bucket in the group whose **bucket\_id** is
  _id_.
  In case of the **iremove-buckets** command the effect is to
  remove the in the group whose **bucket\_id** is _id_.
  It is an error if there is no bucket persent group in whose **bucket\_id** is
  _id_.
  
* **selection\_method**=_method_  
  The selection method used to select a bucket for a select group.
  This is a string of 1 to 15 bytes in length known to lower layers.
  This field is optional for **add-group**, **add-groups** and
  **mod-group** commands on groups of type **select**. Prohibited
  otherwise.  If no selection method is specified, Open vSwitch up to
  release 2.9 applies the **hash** method with default fields. From
  2.10 onwards Open vSwitch defaults to the **dp\_hash** method with symmetric
  L3/L4 hash algorithm, unless the weighted group buckets cannot be mapped to
  a maximum of 64 dp_hash values with sufficient accuracy.
  In those rare cases Open vSwitch 2.10 and later fall back to the **hash**
  method with the default set of hash fields.
    * **dp\_hash**  
      Use a datapath computed hash value.  The hash algorithm varies accross
      different datapath implementations.  **dp\_hash** uses the upper 32
      bits of the **selection\_method\_param** as the datapath hash
      algorithm selector.  The supported values are **0** (corresponding to
      hash computation over the IP 5-tuple) and **1** (corresponding to a
      _symmetric_ hash computation over the IP 5-tuple).  Selecting specific
      fields with the **fields** option is not supported with **dp\_hash**).
      The lower 32 bits are used as the hash basis.
    * Using **dp\_hash** has the advantage that it does not require the
      generated datapath flows to exact match any additional packet header
      fields.  For example, even if multiple TCP connections thus hashed to
      different select group buckets have different source port numbers,
      generally all of them would be handled with a small set of already
      established datapath flows, resulting in less latency for TCP SYN
      packets.  The downside is that the shared datapath flows must match
      each packet twice, as the datapath hash value calculation happens only
      when needed, and a second match is required to match some bits of its
      value.  This double-matching incurs a small additional latency cost
      for each packet, but this latency is orders of magnitude less than the
      latency of creating new datapath flows for new TCP connections.
    * **hash**  
      Use a hash computed over the fields specified with the **fields**
      option, see below.  If no hash fields are specified, **hash** defaults
      to a symmetric hash over the combination of MAC addresses, VLAN tags,
      Ether type, IP addresses and L4 port numbers.  **hash** uses the
      **selection\_method\_param** as the hash basis.
    * Note that the hashed fields become exact matched by the datapath
      flows.  For example, if the TCP source port is hashed, the created
      datapath flows will match the specific TCP source port value present
      in the packet received.  Since each TCP connection generally has a
      different source port value, a separate datapath flow will be need to
      be inserted for each TCP connection thus hashed to a select group
      bucket.
* This option uses a Netronome OpenFlow extension which is only supported
  when using Open vSwitch 2.4 and later with OpenFlow 1.5 and later.
  
* **selection\_method\_param**=_param_  
  64-bit integer parameter to the selection method selected by the
  **selection\_method** field.  The parameter's use is defined by the
  lower-layer that implements the **selection\_method**.  It is optional if
  the **selection\_method** field is specified as a non-empty string.
  Prohibited otherwise. The default value is zero.
* This option uses a Netronome OpenFlow extension which is only supported
  when using Open vSwitch 2.4 and later with OpenFlow 1.5 and later.
  
* **fields**=_field_  
  .IQ **fields(_field**[**=mask**]_...**)**
  The field parameters to selection method selected by the
  **selection\_method** field.  The syntax is described in Flow
  Syntax with the additional restrictions that if a value is provided
  it is treated as a wildcard mask and wildcard masks following a slash
  are prohibited. The pre-requisites of fields must be provided by any
  flows that output to the group.  The use of the fields is defined by
  the lower-layer that implements the **selection\_method**.  They are
  optional if the **selection\_method** field is specified as \`\`hash',
  prohibited otherwise.  The default is no fields.
* This option will use a Netronome OpenFlow extension which is only supported
  when using Open vSwitch 2.4 and later with OpenFlow 1.5 and later.
  
* **bucket**=_bucket\_parameters_  
  The **add-group**, **add-groups** and **mod-group** commands
  require at least one bucket field. Bucket fields must appear after
  all other fields.
  Multiple bucket fields to specify multiple buckets.
  The order in which buckets are specified corresponds to their order in
  the group. If the type of the group is "indirect" then only one group may
  be specified.
  _bucket\_parameters_ consists of a list of field**=value**
  assignments, separated by commas or white space followed by a
  comma-separated list of actions.
  The fields for _bucket\_parameters_ are:
    * **bucket\_id=id**  
      The 32-bit integer group id of the bucket.  Values greater than
      0xffffff00 are reserved.
      This field was added in Open vSwitch 2.4 to conform with the OpenFlow
      1.5 specification. It is not supported when earlier versions
      of OpenFlow are used.  Open vSwitch will automatically allocate bucket
      ids when they are not specified.
    * **actions=**[_action_][**,_action**...]_  
      The syntax of actions are identical to the **actions=** field described in
      **Flow Syntax** above. Specifying **actions=** is optional, any unknown
      bucket parameter will be interpreted as an action.
    * **weight=value**  
      The relative weight of the bucket as an integer. This may be used by the switch
      during bucket select for groups whose **type** is **select**.
    * **watch\_port=port**  
      Port used to determine liveness of group.
      This or the **watch\_group** field is required
      for groups whose **type** is **ff** or **fast\_failover**.
    * **watch\_group=group\_id**  
      Group identifier of group used to determine liveness of group.
      This or the **watch\_port** field is required
      for groups whose **type** is **ff** or **fast\_failover**.

<a name="meter-syntax"></a>

### Meter Syntax


The meter table commands accept an argument that describes a meter.
Such meter descriptions comprise a series field**=value**
assignments, separated by commas or white space.
(Embedding spaces into a group description normally requires
quoting to prevent the shell from breaking the description into
multiple arguments.). Unless noted otherwise only the last instance
of each field is honoured.


* **meter=id**  
  The identifier for the meter.  An integer is used to specify a
  user-defined meter.  In addition, the keywords "all", "controller", and
  "slowpath", are also supported as virtual meters.  The "controller" and
  "slowpath" virtual meters apply to packets sent to the controller and to
  the OVS userspace, respectively.
* When this field is specified in **del-meter**, **dump-meter**, or
  **meter-stats**, the keyword "all" may be used to designate all
  meters.  This field is required, except for **meter-stats**, which
  dumps all stats when this field is not specified.
* **kbps**  
  .IQ **pktps**
  The unit for the **rate** and **burst\_size** band parameters.
  **kbps** specifies kilobits per second, and **pktps** specifies
  packets per second.  A unit is required for the **add-meter** and
  **mod-meter** commands.
  
* **burst**  
  If set, enables burst support for meter bands through the **burst\_size**
  parameter.
  
* **stats**  
  If set, enables the collection of meter and band statistics.
  
* **bands**=_band\_parameters_  
  The **add-meter** and **mod-meter** commands require at least one
  band specification. Bands must appear after all other fields.
    * **type=type**  
      The type of the meter band.  This keyword starts a new band specification.
      Each band specifies a rate above which the band is to take some action. The
      action depends on the band type.  If multiple bands' rate is exceeded, then
      the band with the highest rate among the exceeded bands is selected.
      The following keywords designate the allowed
      meter band types:
        * **drop**  
          Drop packets exceeding the band's rate limit.
    * The other _band\_parameters_ are:  
    * **rate=value**  
      The relative rate limit for this band, in kilobits per second or packets per
      second, depending on whether **kbps** or **pktps** was specified.
    * **burst\_size=size**  
      If **burst** is specified for the meter entry, configures the maximum
      burst allowed for the band in kilobits or packets, depending on whether
      **kbps** or **pktps** was specified.  If unspecified, the switch is
      free to select some reasonable value depending on its configuration.

<a name="options"></a>

# Options


* **--strict**  
  Uses strict matching when running flow modification commands.
* **--names**  
  .IQ "**--no-names**"
  Every OpenFlow port has a name and a number, and every OpenFlow flow
  table has a number and sometimes a name.  By default, **ovs-ofctl**
  commands accept both port and table names and numbers, and they
  display port and table names if **ovs-ofctl** is running on an
  interactive console, numbers otherwise.  With **--names**,
  **ovs-ofctl** commands both accept and display port and table
  names; with **--no-names**, commands neither accept nor display
  port and table names.
* If a port or table name contains special characters or might be
  confused with a keyword within a flow, it may be enclosed in double
  quotes (escaped from the shell).  If necessary, JSON-style escape
  sequences may be used inside quotes, as specified in RFC 7159.  When
  it displays port and table names, **ovs-ofctl** quotes any name
  that does not start with a letter followed by letters or digits.
* Open vSwitch added support for port names and these options.  Open
  vSwitch 2.10 added support for table names.  Earlier versions always
  behaved as if **--no-names** were specified.
* Open vSwitch does not place its own limit on the length of port names,
  but OpenFlow 1.0 to 1.5 limit port names to 15 bytes and OpenFlow 1.6
  limits them to 63 bytes.  Because ovs-ofctl uses OpenFlow to
  retrieve the mapping between port names and numbers, names longer than
  this limit will be truncated for both display and acceptance.
  Truncation can also cause long names that are different to appear to
  be the same; when a switch has two ports with the same (truncated)
  name, **ovs-ofctl** refuses to display or accept the name, using
  the number instead.
* OpenFlow and Open vSwitch limit table names to 32 bytes.
* **--stats**  
  .IQ "**--no-stats**"
  The **dump-flows** command by default, or with **--stats**,
  includes flow duration, packet and byte counts, and idle and hard age
  in its output.  With **--no-stats**, it omits all of these, as
  well as cookie values and table IDs if they are zero.
* **--read-only**  
  Do not execute read/write commands.
* **--bundle**  
  Execute flow mods as an OpenFlow 1.4 atomic bundle transaction.
    * ·  
      Within a bundle, all flow mods are processed in the order they appear
      and as a single atomic transaction, meaning that if one of them fails,
      the whole transaction fails and none of the changes are made to the
      _switch_'s flow table, and that each given datapath packet
      traversing the OpenFlow tables sees the flow tables either as before
      the transaction, or after all the flow mods in the bundle have been
      successfully applied.
    * ·  
      The beginning and the end of the flow table modification commands in a
      bundle are delimited with OpenFlow 1.4 bundle control messages, which
      makes it possible to stream the included commands without explicit
      OpenFlow barriers, which are otherwise used after each flow table
      modification command.  This may make large modifications execute
      faster as a bundle.
    * ·  
      Bundles require OpenFlow 1.4 or higher.  An explicit -O
      OpenFlow14 option is not needed, but you may need to enable
      OpenFlow 1.4 support for OVS by setting the OVSDB _protocols_
      column in the _bridge_ table.
* **-O **[_version_[**,_version**]...]_  
  .IQ "**--protocols=**[_version_[**,_version**]...]_"
  Sets the OpenFlow protocol versions that are allowed when establishing
  an OpenFlow session.
* These protocol versions are enabled by default:
    * ·  
      **OpenFlow10**, for OpenFlow 1.0.
  The following protocol versions are generally supported, but for
  compatibility with older versions of Open vSwitch they are not enabled
  by default:
    * ·  
      **OpenFlow11**, for OpenFlow 1.1.
    * ·  
      **OpenFlow12**, for OpenFlow 1.2.
    * ·  
      **OpenFlow13**, for OpenFlow 1.3.
    * ·  
      **OpenFlow14**, for OpenFlow 1.4.
* Support for the following protocol versions is provided for testing
  and development purposes.  They are not enabled by default:
    * ·  
      **OpenFlow15**, for OpenFlow 1.5.
    * ·  
      **OpenFlow16**, for OpenFlow 1.6.
* **-F format**[**,format**...]  
  .IQ "**--flow-format=format**[**,format**...]"
  **ovs-ofctl** supports the following individual flow formats, any
  number of which may be listed as _format_:
    * **OpenFlow10-table\_id**  
      This is the standard OpenFlow 1.0 flow format.  All OpenFlow switches
      and all versions of Open vSwitch support this flow format.
    * **OpenFlow10+table\_id**  
      This is the standard OpenFlow 1.0 flow format plus a Nicira extension
      that allows **ovs-ofctl** to specify the flow table in which a
      particular flow should be placed.  Open vSwitch 1.2 and later supports
      this flow format.
    * **NXM-table\_id** (Nicira Extended Match)  
      This Nicira extension to OpenFlow is flexible and extensible.  It
      supports all of the Nicira flow extensions, such as **tun\_id** and
      registers.  Open vSwitch 1.1 and later supports this flow format.
    * **NXM+table\_id** (Nicira Extended Match)  
      This combines Nicira Extended match with the ability to place a flow
      in a specific table.  Open vSwitch 1.2 and later supports this flow
      format.
    * **OXM-OpenFlow12**  
      .IQ "**OXM-OpenFlow13**"
      .IQ "**OXM-OpenFlow14**"
      .IQ "**OXM-OpenFlow15**"
      .IQ "**OXM-OpenFlow16**"
      These are the standard OXM (OpenFlow Extensible Match) flow format in
      OpenFlow 1.2 and later.
* **ovs-ofctl** also supports the following abbreviations for
  collections of flow formats:
    * **any**  
      Any supported flow format.
    * **OpenFlow10**  
      **OpenFlow10-table\_id** or **OpenFlow10+table\_id**.
    * **NXM**  
      **NXM-table\_id** or **NXM+table\_id**.
    * **OXM**  
      **OXM-OpenFlow12**, **OXM-OpenFlow13**, or **OXM-OpenFlow14**.
* For commands that modify the flow table, **ovs-ofctl** by default
  negotiates the most widely supported flow format that supports the
  flows being added.  For commands that query the flow table,
  **ovs-ofctl** by default uses the most advanced format supported by
  the switch.
* This option, where _format_ is a comma-separated list of one or
  more of the formats listed above, limits **ovs-ofctl**'s choice of
  flow format.  If a command cannot work as requested using one of the
  specified flow formats, **ovs-ofctl** will report a fatal error.
* **-P format**  
  .IQ "**--packet-in-format=format**"
  **ovs-ofctl** supports the following \`\`packet-in'' formats, in order of
  increasing capability:
    * **standard**  
      This uses the **OFPT\_PACKET\_IN** message, the standard \`\`packet-in''
      message for any given OpenFlow version.  Every OpenFlow switch that
      supports a given OpenFlow version supports this format.
    * **nxt\_packet\_in**  
      This uses the **NXT\_PACKET\_IN** message, which adds many of the
      capabilities of the OpenFlow 1.1 and later \`\`packet-in'' messages
      before those OpenFlow versions were available in Open vSwitch.  Open
      vSwitch 1.1 and later support this format.  Only Open vSwitch 2.6 and
      later, however, support it for OpenFlow 1.1 and later (but there is
      little reason to use it with those versions of OpenFlow).
    * **nxt\_packet\_in2**  
      This uses the **NXT\_PACKET\_IN2** message, which is extensible and
      should avoid the need to define new formats later.  In particular,
      this format supports passing arbitrary user-provided data to a
      controller using the **userdata option on the controller**
      action.  Open vSwitch 2.6 and later support this format.
* Without this option, **ovs-ofctl** prefers **nxt\_packet\_in2** if
  the switch supports it.  Otherwise, if OpenFlow 1.0 is in use,
  **ovs-ofctl** prefers **nxt\_packet\_in** if the switch supports
  it.  Otherwise, **ovs-ofctl** falls back to the **standard**
  packet-in format.  When this option is specified, **ovs-ofctl**
  insists on the selected format.  If the switch does not support the
  requested format, **ovs-ofctl** will report a fatal error.
* Before version 2.6, Open vSwitch called **standard** format
  **openflow10** and **nxt\_packet\_in** format **nxm**, and
  **ovs-ofctl** still accepts these names as synonyms.  (The name
  **openflow10** was a misnomer because this format actually varies
  from one OpenFlow version to another; it is not consistently OpenFlow
  1.0 format.  Similarly, when **nxt\_packet\_in2** was introduced, the
  name **nxm** became confusing because it also uses OXM/NXM.)
* This option affects only the **monitor** command.
* **--timestamp**  
  Print a timestamp before each received packet.  This option only
  affects the **monitor**, **snoop**, and **ofp-parse-pcap**
  commands.
* **-m**  
  .IQ "**--more**"
  Increases the verbosity of OpenFlow messages printed and logged by
  **ovs-ofctl** commands.  Specify this option more than once to
  increase verbosity further.
* **--sort**[**=field**]  
  .IQ **--rsort**[**=field**]
  Display output sorted by flow _field_ in ascending
  (**--sort**) or descending (**--rsort**) order, where
  _field_ is any of the fields that are allowed for matching or
  **priority** to sort by priority.  When _field_ is omitted, the
  output is sorted by priority.  Specify these options multiple times to
  sort by multiple fields.
* Any given flow will not necessarily specify a value for a given
  field.  This requires special treatement:
    * ·  
      A flow that does not specify any part of a field that is used for sorting is
      sorted after all the flows that do specify the field.  For example,
      **--sort=tcp\_src** will sort all the flows that specify a TCP
      source port in ascending order, followed by the flows that do not
      specify a TCP source port at all.
    * ·  
      A flow that only specifies some bits in a field is sorted as if the
      wildcarded bits were zero.  For example, **--sort=nw\_src** would
      sort a flow that specifies **nw\_src=192.168.0.0/24** the same as
      **nw\_src=192.168.0.0**.
* These options currently affect only **dump-flows** output.

<a name="daemon-options"></a>

### Daemon Options


The following options are valid on POSIX based platforms.

* **--pidfile**[**=pidfile**]  
  Causes a file (by default, **ovs-ofctl.pid**) to be created indicating
  the PID of the running process.  If the _pidfile_ argument is not
  specified, or
  if it does not begin with **/**, then it is created in
  **/var/run/openvswitch**.
* If **--pidfile** is not specified, no pidfile is created.
* **--overwrite-pidfile**  
  By default, when **--pidfile** is specified and the specified pidfile 
  already exists and is locked by a running process, **ovs-ofctl** refuses 
  to start.  Specify **--overwrite-pidfile** to cause it to instead 
  overwrite the pidfile.
* When **--pidfile** is not specified, this option has no effect.
* **--detach**  
  Runs **ovs-ofctl** as a background process.  The process forks, and in
  the child it starts a new session, closes the standard file
  descriptors (which has the side effect of disabling logging to the
  console), and changes its current directory to the root (unless
  **--no-chdir** is specified).  After the child completes its
  initialization, the parent exits.  **ovs-ofctl** detaches only when executing the **monitor** or **snoop** commands.
* **--monitor**  
  Creates an additional process to monitor the **ovs-ofctl** daemon.  If
  the daemon dies due to a signal that indicates a programming error
  (**SIGABRT**, **SIGALRM**, **SIGBUS**, **SIGFPE**,
  **SIGILL**, **SIGPIPE**, **SIGSEGV**, **SIGXCPU**, or
  **SIGXFSZ**) then the monitor process starts a new copy of it.  If
  the daemon dies or exits for another reason, the monitor process exits.
* This option is normally used with **--detach**, but it also
  functions without it.
* **--no-chdir**  
  By default, when **--detach** is specified, **ovs-ofctl** 
  changes its current working directory to the root directory after it 
  detaches.  Otherwise, invoking **ovs-ofctl** from a carelessly chosen 
  directory would prevent the administrator from unmounting the file 
  system that holds that directory.
* Specifying **--no-chdir** suppresses this behavior, preventing
  **ovs-ofctl** from changing its current working directory.  This may be 
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
  Causes **ovs-ofctl** to run as a different user specified in "user:group", thus
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
* **--unixctl=socket**  
  Sets the name of the control socket on which **ovs-ofctl** listens for
  runtime management commands (see **RUNTIME MANAGEMENT COMMANDS**,
  below).  If _socket_ does not begin with **/**, it is
  interpreted as relative to **/var/run/openvswitch**.  If **--unixctl** is
  not used at all, the default socket is
  **/var/run/openvswitch/ovs-ofctl._pid.ctl**, where pid_ is **ovs-ofctl**'s
  process ID.
* On Windows a local named pipe is used to listen for runtime management
  commands.  A file is created in the absolute path as pointed by
  _socket_ or if **--unixctl** is not used at all, a file is
  created as **ovs-ofctl.ctl** in the configured _OVS\_RUNDIR_
  directory.  The file exists just to mimic the behavior of a Unix domain socket.
* Specifying **none** for _socket_ disables the control socket
  feature.

<a name="public-key-infrastructure-options"></a>

### Public Key Infrastructure Options


* **-p** _privkey.pem_  
  .IQ "**--private-key=privkey.pem**"
  Specifies a PEM file containing the private key used as **ovs-ofctl**'s
  identity for outgoing SSL connections.
* **-c** _cert.pem_  
  .IQ "**--certificate=cert.pem**"
  Specifies a PEM file containing a certificate that certifies the
  private key specified on **-p** or **--private-key** to be
  trustworthy.  The certificate must be signed by the certificate
  authority (CA) that the peer in SSL connections will use to verify it.
* **-C** _cacert.pem_  
  .IQ "**--ca-cert=cacert.pem**"
  Specifies a PEM file containing the CA certificate that **ovs-ofctl**
  should use to verify certificates presented to it by SSL peers.  (This
  may be the same certificate that SSL peers use to verify the
  certificate specified on **-c** or **--certificate**, or it may
  be a different one, depending on the PKI design in use.)
* **-C none**  
  .IQ "**--ca-cert=none**"
  Disables verification of certificates presented by SSL peers.  This
  introduces a security risk, because it means that certificates cannot
  be verified to be those of known trusted hosts.
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
      respectively.  (If **--detach** is specified, **ovs-ofctl** closes
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
  used if _file_ is omitted is **/var/log/openvswitch/ovs-ofctl.log**.
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
* Colorize the output (for some commands); _when_ can be **never**,
  **always**, or **auto** (the default).

Only some commands support output coloring.  Color names and default
colors may change in future releases.

The environment variable **OVS\_COLORS** can be used to specify user-defined
colors and other attributes used to highlight various parts of the output. If
set, its value is a colon-separated list of capabilities that defaults to
**ac:01;31:dr=34:le=31:pm=36:pr=35:sp=33:vl=32**. Supported capabilities were
initially designed for coloring flows from **ovs-ofctl dump-flows**
_switch_ command, and they are as follows.

* **ac=01;31**  
  SGR substring for **actions=** keyword in a flow.
  The default is a bold red text foreground.
* **dr=34**  
  SGR substring for **drop** keyword.
  The default is a dark blue text foreground.
* **le=31**  
  SGR substring for **learn=** keyword in a flow.
  The default is a red text foreground.
* **pm=36**  
  SGR substring for flow match attribute names.
  The default is a cyan text foreground.
* **pr=35**  
  SGR substring for keywords in a flow that are followed by arguments inside
  parenthesis.
  The default is a magenta text foreground.
* **sp=33**  
  SGR substring for some special keywords in a flow, notably: **table=**,
  **priority=**, **load:**, **output:**, **move:**, **group:**,
  **CONTROLLER:**, **set\_field:**, **resubmit:**, **exit**.
  The default is a yellow text foreground.
* **vl=32**  
  SGR substring for a lone flow match attribute with no field name.
  The default is a green text foreground.

See the Select Graphic Rendition (SGR) section in the documentation of the text
terminal that is used for permitted values and their meaning as character
attributes.

* **-h**  
  .IQ "**--help**"
  Prints a brief help message to the console.
* **-V**  
  .IQ "**--version**"
  Prints version information to the console.

<a name="runtime-management-commands"></a>

# Runtime Management Commands

**ovs-appctl**(8) can send commands to a running **ovs-ofctl**
process.  The supported commands are listed below.

* **exit**  
  Causes **ovs-ofctl** to gracefully terminate.  This command applies
  only when executing the **monitor** or **snoop** commands.
* **ofctl/set-output-file file**  
  Causes all subsequent output to go to _file_ instead of stderr.
  This command applies only when executing the **monitor** or
  **snoop** commands.
* **ofctl/send ofmsg**...  
  Sends each _ofmsg_, specified as a sequence of hex digits that
  express an OpenFlow message, on the OpenFlow connection.  This command
  is useful only when executing the **monitor** command.
* **ofctl/packet-out packet-out**  
  Sends an OpenFlow PACKET_OUT message specified in Packet-Out
  Syntax, on the OpenFlow connection.  See **Packet-Out Syntax**
  section for more information.  This command is useful only when
  executing the **monitor** command.
* **ofctl/barrier**  
  Sends an OpenFlow barrier request on the OpenFlow connection and waits
  for a reply.  This command is useful only for the **monitor**
  command.

<a name="examples"></a>

# Examples

The following examples assume that **ovs-vswitchd** has a bridge
named **br0** configured.

* **ovs-ofctl dump-tables br0**  
  Prints out the switch's table stats.  (This is more interesting after
  some traffic has passed through.)
* **ovs-ofctl dump-flows br0**  
  Prints the flow entries in the switch.
* **ovs-ofctl add-flow table=0 actions=learn(table=1,hard_timeout=10, NXM_OF_VLAN_TCI[0..11],output:NXM_OF_IN_PORT[]), resubmit(,1)**  
  **ovs-ofctl add-flow  table=1 priority=0 actions=flood**
  Implements a level 2 MAC learning switch using the learn.
* **ovs-ofctl add-flow br0 'table=0,priority=0 actions=load:3-&gt;NXM\_NX\_REG0[0..15],learn(table=0,priority=1,idle\_timeout=10,NXM\_OF\_ETH\_SRC[],NXM\_OF\_VLAN\_TCI[0..11],output:NXM\_NX\_REG0[0..15]),output:2**  
  In this use of a learn action, the first packet from each source MAC
  will be sent to port 2. Subsequent packets will be output to port 3,
  with an idle timeout of 10 seconds.  NXM field names and match field
  names are both accepted, e.g. **NXM\_NX\_REG0** or **reg0** for the
  first register, and empty brackets may be omitted.
* Additional examples may be found documented as part of related sections.

<a name="see-also"></a>

# See Also

**ovs-fields**(7),
**ovs-appctl**(8),
**ovs-vswitchd**(8),
**ovs-vswitchd.conf.db**(8)
