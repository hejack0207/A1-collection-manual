# ovs-vswitchd.conf.db(5)

Open vSwitch 2.10.1,  DB Schema 7.16.1

.fp 5 L CR              \\" Make fixed-width font available as \\fL.

<a name="name"></a>

# Name

ovs-vswitchd\[char46]conf\[char46]db - Open_vSwitch database schema




A database with this schema holds the configuration for one Open vSwitch daemon\[char46] The top-level configuration for the daemon is the **Open\_vSwitch** table, which must have exactly one record\[char46] Records in other tables are significant only when they can be reached directly or indirectly from the **Open\_vSwitch** table\[char46] Records that are not reachable from the **Open\_vSwitch** table are automatically deleted from the database, except for records in a few distinguished \`\`root set’’ tables\[char46]

<a name="common-columns"></a>

### Common Columns



Most tables contain two special columns, named **other\_config** and **external\_ids**\[char46] These columns have the same form and purpose each place that they appear, so we describe them here to save space later\[char46]

* **other\_config**: map of string-string pairs  
  Key-value pairs for configuring rarely used features\[char46] Supported keys, along with the forms taken by their values, are documented individually for each table\[char46]
* A few tables do not have **other\_config** columns because no key-value pairs have yet been defined for them\[char46]
* **external\_ids**: map of string-string pairs  
  Key-value pairs for use by external frameworks that integrate with Open vSwitch, rather than by Open vSwitch itself\[char46] System integrators should either use the Open vSwitch development mailing list to coordinate on common key-value definitions, or choose key names that are likely to be unique\[char46] In some cases, where key-value pairs have been defined that are likely to be widely useful, they are documented individually for each table\[char46]

<a name="table-summary"></a>

# Table Summary


The following list summarizes the purpose of each of the tables in the
**Open\_vSwitch** database.  Each table is described in more detail on a later
page.

* Table  
  Purpose
  .TQ 1in
  **Open\_vSwitch**
  Open vSwitch configuration\[char46]
  .TQ 1in
  **Bridge**
  Bridge configuration\[char46]
  .TQ 1in
  **Port**
  Port configuration\[char46]
  .TQ 1in
  **Interface**
  One physical network device in a Port\[char46]
  .TQ 1in
  **Flow\_Table**
  OpenFlow table configuration
  .TQ 1in
  **QoS**
  Quality of Service configuration
  .TQ 1in
  **Queue**
  QoS output queue\[char46]
  .TQ 1in
  **Mirror**
  Port mirroring\[char46]
  .TQ 1in
  **Controller**
  OpenFlow controller configuration\[char46]
  .TQ 1in
  **Manager**
  OVSDB management connection\[char46]
  .TQ 1in
  **NetFlow**
  NetFlow configuration\[char46]
  .TQ 1in
  **SSL**
  SSL configuration\[char46]
  .TQ 1in
  **sFlow**
  sFlow configuration\[char46]
  .TQ 1in
  **IPFIX**
  IPFIX configuration\[char46]
  .TQ 1in
  **Flow\_Sample\_Collector\_Set**
  Flow_Sample_Collector_Set configuration\[char46]
  .TQ 1in
  **AutoAttach**
  AutoAttach configuration\[char46]
  
  .if t \{
  .bp

<a name="table-relationships"></a>

# Table Relationships


The following diagram shows the relationship among tables in the
database.  Each node represents a table.  Tables that are part of the
\`\`root set'' are shown with double borders.  Each edge leads from the
table that contains it and points to the table that its value
represents.  Edges are labeled with their column names, followed by a
constraint on the number of allowed values: **?** for zero or one,
*** for zero or more, +** for one or more.  Thick lines
represent strong references; thin lines represent weak references.
.ps -3
.PS
linethick = 1;
linethick = 1.000000;
box at 2.019802,1.366222 wid 0.319380 height 0.212920 "Bridge"
linethick = 1.000000;
box at 3.258868,0.745220 wid 0.319380 height 0.212920 "Mirror"
linethick = 1.000000;
box at 3.258868,2.004982 wid 0.319380 height 0.212920 "IPFIX"
linethick = 1.000000;
box at 3.258868,0.106460 wid 0.425840 height 0.212920 "Controller"
linethick = 1.000000;
box at 3.258868,2.324362 wid 0.467232 height 0.212920 "AutoAttach"
linethick = 1.000000;
box at 3.258868,1.685602 wid 0.372610 height 0.212920 "NetFlow"
linethick = 1.000000;
box at 3.258868,1.366222 wid 0.319380 height 0.212920 "sFlow"
linethick = 1.000000;
box at 3.258868,0.425840 wid 0.473151 height 0.212920 "Flow_Table"
linethick = 1.000000;
box at 4.394243,0.774773 wid 0.319380 height 0.212920 "Port"
linethick = 0.500000;
box at 5.320019,0.981817 wid 0.319380 height 0.212920 "QoS"
box at 5.320019,0.981817 wid 0.263824 height 0.157364
linethick = 0.500000;
box at 6.340332,0.981817 wid 0.319380 height 0.212920 "Queue"
box at 6.340332,0.981817 wid 0.263824 height 0.157364
linethick = 0.500000;
box at 0.511604,2.058212 wid 1.023208 height 0.212920 "Flow_Sample_Collector_Set"
box at 0.511604,2.058212 wid 0.967653 height 0.157364
linethick = 0.500000;
box at 0.511604,1.046842 wid 0.567772 height 0.212920 "Open_vSwitch"
box at 0.511604,1.046842 wid 0.512217 height 0.157364
linethick = 1.000000;
box at 2.019802,0.727462 wid 0.319380 height 0.212920 "SSL"
linethick = 1.000000;
box at 2.019802,1.046842 wid 0.384440 height 0.212920 "Manager"
linethick = 1.000000;
box at 5.320019,0.662437 wid 0.384440 height 0.212920 "Interface"
linethick = 1.000000;
spline -&gt; from 2.167057,1.259039 to 2.167057,1.259039 to 2.183708,1.242771 to 2.199208,1.225142 to 2.211983,1.206532 to 2.295363,1.085338 to 2.205894,0.987821 to 2.318443,0.893072 to 2.538475,0.707916 to 2.893838,0.706128 to 3.098923,0.724013
"mirrors*" at 2.617127,0.937444
linethick = 1.000000;
spline -&gt; from 2.081974,1.474088 to 2.081974,1.474088 to 2.134693,1.555806 to 2.217647,1.664310 to 2.318443,1.727037 to 2.550185,1.871098 to 2.655581,1.786910 to 2.915812,1.868969 to 2.976324,1.888047 to 3.041307,1.912703 to 3.098284,1.935783
"ipfix?" at 2.617127,1.913342
linethick = 1.000000;
spline -&gt; from 2.172763,1.259464 to 2.172763,1.259464 to 2.188009,1.243325 to 2.201678,1.225610 to 2.211983,1.206532 to 2.309160,1.027424 to 2.180429,0.445642 to 2.318443,0.295720 to 2.501214,0.097270 to 2.829281,0.074194 to 3.045523,0.084005
"controller*" at 2.617127,0.340080
linethick = 1.000000;
spline -&gt; from 2.048546,1.474812 to 2.048546,1.474812 to 2.088532,1.605970 to 2.172849,1.825406 to 2.318443,1.957672 to 2.518205,2.139165 to 2.817954,2.234979 to 3.025082,2.282545
"auto_attach?" at 2.617127,2.297747
linethick = 1.000000;
spline -&gt; from 2.179534,1.431163 to 2.179534,1.431163 to 2.224077,1.447941 to 2.272793,1.465060 to 2.318443,1.478602 to 2.575693,1.554870 to 2.880041,1.616872 to 3.071286,1.652515
"netflow?" at 2.617127,1.658987
linethick = 1.000000;
spline -&gt; from 2.181791,1.366222 to 2.181791,1.366222 to 2.419878,1.366222 to 2.861773,1.366222 to 3.098795,1.366222
"sflow?" at 2.617127,1.410595
linethick = 1.000000;
spline -&gt; from 2.171656,1.258868 to 2.171656,1.258868 to 2.187114,1.242814 to 2.201082,1.225312 to 2.211983,1.206532 to 2.347613,0.973470 to 2.129328,0.801431 to 2.318443,0.609207 to 2.499894,0.424818 to 2.807861,0.396781 to 3.021718,0.403181
"flow_tables value*" at 2.617127,0.653537
linethick = 1.000000;
spline -&gt; from 2.180812,1.324362 to 2.180812,1.324362 to 2.378487,1.273432 to 2.724226,1.185794 to 3.022272,1.117830 to 3.511860,1.006175 to 3.648938,1.036793 to 4.128263,0.887152 to 4.162756,0.876421 to 4.198910,0.862794 to 4.233020,0.848827
"ports*" at 3.258868,1.162203
linethick = 0.500000;
spline -&gt; from 3.419921,0.701444 to 3.419921,0.701444 to 3.476941,0.687987 to 3.541839,0.674999 to 3.601882,0.668313 to 3.834434,0.642593 to 3.898565,0.624111 to 4.128263,0.668313 to 4.163480,0.675127 to 4.199932,0.686497 to 4.234127,0.699357
"select_src_port*" at 3.865094,0.712686
linethick = 0.500000;
spline -&gt; from 3.412213,0.638547 to 3.412213,0.638547 to 3.483542,0.591321 to 3.561470,0.543840 to 3.601882,0.532300 to 3.826896,0.468168 to 3.910105,0.447813 to 4.128263,0.532300 to 4.199379,0.559852 to 4.263084,0.616190 to 4.310352,0.667675
"output_port?" at 3.865094,0.576673
linethick = 0.500000;
spline -&gt; from 3.419410,0.751139 to 3.419410,0.751139 to 3.476941,0.753183 to 3.542350,0.755355 to 3.601882,0.757058 to 3.820636,0.763276 to 4.073373,0.768599 to 4.233531,0.771750
"select_dst_port*" at 3.865094,0.819146
linethick = 1.000000;
spline -&gt; from 4.555636,0.810842 to 4.555636,0.810842 to 4.725121,0.848742 to 4.989993,0.907933 to 5.159052,0.945791
"qos?" at 4.840949,0.955202
linethick = 1.000000;
spline -&gt; from 4.554359,0.735553 to 4.554359,0.735553 to 4.589278,0.728016 to 4.625900,0.720862 to 4.660393,0.715667 to 4.816250,0.692203 to 4.994252,0.678619 to 5.125836,0.671039
"interfaces+" at 4.840949,0.759997
linethick = 1.000000;
spline -&gt; from 5.481838,0.981817 to 5.481838,0.981817 to 5.672615,0.981817 to 5.988588,0.981817 to 6.179364,0.981817
"queues value*" at 5.846357,1.026147
linethick = 1.000000;
spline -&gt; from 0.743942,1.951625 to 0.743942,1.951625 to 1.052975,1.809820 to 1.591321,1.562833 to 1.859047,1.439978
"bridge" at 1.425372,1.812758
linethick = 1.000000;
spline -&gt; from 1.002811,2.165056 to 1.002811,2.165056 to 1.494187,2.253034 to 2.268066,2.340033 to 2.915812,2.182430 to 2.978368,2.167228 to 3.042244,2.138441 to 3.097645,2.108462
"ipfix?" at 2.019802,2.309586
linethick = 1.000000;
spline -&gt; from 0.797045,1.107312 to 0.797045,1.107312 to 1.111315,1.173871 to 1.605502,1.278499 to 1.858621,1.332113
"bridges*" at 1.425372,1.339607
linethick = 1.000000;
spline -&gt; from 0.797045,0.986416 to 0.797045,0.986416 to 1.111315,0.919857 to 1.605502,0.815228 to 1.858621,0.761615
"ssl?" at 1.425372,0.955202
linethick = 1.000000;
spline -&gt; from 0.797045,1.046842 to 0.797045,1.046842 to 1.098497,1.046842 to 1.565516,1.046842 to 1.826470,1.046842
"manager_options*" at 1.425372,1.091215
.ps +3
.PE
.bp

<a name="open_vswitch-table"></a>

# Open_vswitch Table


Configuration for an Open vSwitch daemon\[char46] There must be exactly one record in the **Open\_vSwitch** table\[char46]

<a name="summary"></a>

### "Summary:

.TQ .25in
_Configuration:_
.TQ 2.75in
**bridges**
set of **Bridge**s
.TQ 2.75in
**ssl**
optional **SSL**
.TQ 2.75in
**external_ids : system-id**
optional string
.TQ 2.75in
**external_ids : xs-system-uuid**
optional string
.TQ 2.75in
**external_ids : hostname**
optional string
.TQ 2.75in
**external_ids : rundir**
optional string
.TQ 2.75in
**other_config : stats-update-interval**
optional string, containing an integer, at least 5,000
.TQ 2.75in
**other_config : flow-restore-wait**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : flow-limit**
optional string, containing an integer, at least 0
.TQ 2.75in
**other_config : max-idle**
optional string, containing an integer, at least 500
.TQ 2.75in
**other_config : hw-offload**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : tc-policy**
optional string, one of **none**, **skip\_hw**, or **skip\_sw**
.TQ 2.75in
**other_config : dpdk-init**
optional string, one of **false**, **true**, or **try**
.TQ 2.75in
**other_config : dpdk-lcore-mask**
optional string, containing an integer, at least 1
.TQ 2.75in
**other_config : pmd-cpu-mask**
optional string
.TQ 2.75in
**other_config : dpdk-alloc-mem**
optional string, containing an integer, at least 0
.TQ 2.75in
**other_config : dpdk-socket-mem**
optional string
.TQ 2.75in
**other_config : dpdk-hugepage-dir**
optional string
.TQ 2.75in
**other_config : dpdk-extra**
optional string
.TQ 2.75in
**other_config : vhost-sock-dir**
optional string
.TQ 2.75in
**other_config : vhost-iommu-support**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : per-port-memory**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : tx-flush-interval**
optional string, containing an integer, in range 0 to 1,000,000
.TQ 2.75in
**other_config : pmd-perf-metrics**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : smc-enable**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : n-handler-threads**
optional string, containing an integer, at least 1
.TQ 2.75in
**other_config : n-revalidator-threads**
optional string, containing an integer, at least 1
.TQ 2.75in
**other_config : emc-insert-inv-prob**
optional string, containing an integer, in range 0 to 4,294,967,295
.TQ 2.75in
**other_config : vlan-limit**
optional string, containing an integer, at least 0
.TQ 2.75in
**other_config : bundle-idle-timeout**
optional string, containing an integer, at least 1
.TQ .25in
_Status:_
.TQ 2.75in
**next\_cfg**
integer
.TQ 2.75in
**cur\_cfg**
integer
.TQ 2.75in
**dpdk\_initialized**
boolean
.TQ .25in
_Statistics:_
.TQ 2.50in
**other_config : enable-statistics**
optional string, either **true** or **false**
.TQ 2.50in
**statistics : cpu**
optional string, containing an integer, at least 1
.TQ 2.50in
**statistics : load\_average**
optional string
.TQ 2.50in
**statistics : memory**
optional string
.TQ 2.50in
**statistics : process\_NAME**
optional string
.TQ 2.50in
**statistics : file\_systems**
optional string
.TQ .25in
_Version Reporting:_
.TQ 2.75in
**ovs\_version**
optional string
.TQ 2.75in
**db\_version**
optional string
.TQ 2.75in
**system\_type**
optional string
.TQ 2.75in
**system\_version**
optional string
.TQ 2.75in
**dpdk\_version**
optional string
.TQ .25in
_Capabilities:_
.TQ 2.75in
**datapath\_types**
set of strings
.TQ 2.75in
**iface\_types**
set of strings
.TQ .25in
_Database Configuration:_
.TQ 2.75in
**manager\_options**
set of **Manager**s
.TQ .25in
_Common Columns:_
.TQ 2.75in
**other\_config**
map of string-string pairs
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:

.ST "Configuration:"


* **bridges**: set of **Bridge**s  
  Set of bridges managed by the daemon\[char46]
* **ssl**: optional **SSL**  
  SSL used globally by the daemon\[char46]
* **external_ids : system-id**: optional string  
  A unique identifier for the Open vSwitch’s physical host\[char46] The form of the identifier depends on the type of the host\[char46] On a Citrix XenServer, this will likely be the same as **external\_ids:xs-system-uuid**\[char46]
* **external_ids : xs-system-uuid**: optional string  
  The Citrix XenServer universally unique identifier for the physical host as displayed by **xe host-list**\[char46]
* **external_ids : hostname**: optional string  
  The hostname for the host running Open vSwitch\[char46] This is a fully qualified domain name since version 2\[char46]6\[char46]2\[char46]
* **external_ids : rundir**: optional string  
  In Open vSwitch 2\[char46]8 and later, the run directory of the running Open vSwitch daemon\[char46] This directory is used for runtime state such as control and management sockets\[char46] The value of **other\_config:vhost-sock-dir** is relative to this directory\[char46]
* **other_config : stats-update-interval**: optional string, containing an integer, at least 5,000  
  Interval for updating statistics to the database, in milliseconds\[char46] This option will affect the update of the **statistics** column in the following tables: **Port**, Interface
  , **Mirror**\[char46]
* Default value is 5000 ms\[char46]
* Getting statistics more frequently can be achieved via OpenFlow\[char46]
* **other_config : flow-restore-wait**: optional string, either **true** or **false**  
  When **ovs-vswitchd** starts up, it has an empty flow table and therefore it handles all arriving packets in its default fashion according to its configuration, by dropping them or sending them to an OpenFlow controller or switching them as a standalone switch\[char46] This behavior is ordinarily desirable\[char46] However, if **ovs-vswitchd** is restarting as part of a \`\`hot-upgrade,’’ then this leads to a relatively long period during which packets are mishandled\[char46]
* This option allows for improvement\[char46] When **ovs-vswitchd** starts with this value set as **true**, it will neither flush or expire previously set datapath flows nor will it send and receive any packets to or from the datapath\[char46] When this value is later set to **false**, **ovs-vswitchd** will start receiving packets from the datapath and re-setup the flows\[char46]
* Thus, with this option, the procedure for a hot-upgrade of **ovs-vswitchd** becomes roughly the following:
    * 1.  
      Stop **ovs-vswitchd**\[char46]
    * 2.  
      Set **other\_config:flow-restore-wait** to **true**\[char46]
    * 3.  
      Start **ovs-vswitchd**\[char46]
    * 4.  
      Use **ovs-ofctl** (or some other program, such as an OpenFlow controller) to restore the OpenFlow flow table to the desired state\[char46]
    * 5.  
      Set **other\_config:flow-restore-wait** to **false** (or remove it entirely from the database)\[char46]
* The **ovs-ctl**’s \`\`restart’’ and \`\`force-reload-kmod’’ functions use the above config option during hot upgrades\[char46]
* **other_config : flow-limit**: optional string, containing an integer, at least 0  
  The maximum number of flows allowed in the datapath flow table\[char46] Internally OVS will choose a flow limit which will likely be lower than this number, based on real time network conditions\[char46] Tweaking this value is discouraged unless you know exactly what you’re doing\[char46]
* The default is 200000\[char46]
* **other_config : max-idle**: optional string, containing an integer, at least 500  
  The maximum time (in ms) that idle flows will remain cached in the datapath\[char46] Internally OVS will check the validity and activity for datapath flows regularly and may expire flows quicker than this number, based on real time network conditions\[char46] Tweaking this value is discouraged unless you know exactly what you’re doing\[char46]
* The default is 10000\[char46]
* **other_config : hw-offload**: optional string, either **true** or **false**  
  Set this value to **true** to enable netdev flow offload\[char46]
* The default value is **false**\[char46] Changing this value requires restarting the daemon
* Currently Open vSwitch supports hardware offloading on Linux systems\[char46] On other systems, this value is ignored\[char46] This functionality is considered ’experimental’\[char46] Depending on which OpenFlow matches and actions are configured, which kernel version is used, and what hardware is available, Open vSwitch may not be able to offload functionality to hardware\[char46]
* **other_config : tc-policy**: optional string, one of **none**, **skip\_hw**, or **skip\_sw**  
  Specified the policy used with HW offloading\[char46] Options:
    * **none**  
      Add software rule and offload rule to HW\[char46]
    * **skip\_sw**  
      Offload rule to HW only\[char46]
    * **skip\_hw**  
      Add software rule without offloading rule to HW\[char46]
* This is only relevant if **other\_config:hw-offload** is enabled\[char46]
* The default value is **none**\[char46]
* **other_config : dpdk-init**: optional string, one of **false**, **true**, or **try**  
  Set this value to **true** or **try** to enable runtime support for DPDK ports\[char46] The vswitch must have compile-time support for DPDK as well\[char46]
* A value of **true** will cause the ovs-vswitchd process to abort if DPDK cannot be initialized\[char46] A value of **try** will allow the ovs-vswitchd process to continue running even if DPDK cannot be initialized\[char46]
* The default value is **false**\[char46] Changing this value requires restarting the daemon
* If this value is **false** at startup, any dpdk ports which are configured in the bridge will fail due to memory errors\[char46]
* **other_config : dpdk-lcore-mask**: optional string, containing an integer, at least 1  
  Specifies the CPU cores where dpdk lcore threads should be spawned\[char46] The DPDK lcore threads are used for DPDK library tasks, such as library internal message processing, logging, etc\[char46] Value should be in the form of a hex string (so ’0x123’) similar to the ’taskset’ mask input\[char46]
* The lowest order bit corresponds to the first CPU core\[char46] A set bit means the corresponding core is available and an lcore thread will be created and pinned to it\[char46] If the input does not cover all cores, those uncovered cores are considered not set\[char46]
* For performance reasons, it is best to set this to a single core on the system, rather than allow lcore threads to float\[char46]
* If not specified, the value will be determined by choosing the lowest CPU core from initial cpu affinity list\[char46] Otherwise, the value will be passed directly to the DPDK library\[char46]
* **other_config : pmd-cpu-mask**: optional string  
  Specifies CPU mask for setting the cpu affinity of PMD (Poll Mode Driver) threads\[char46] Value should be in the form of hex string, similar to the dpdk EAL ’-c COREMASK’ option input or the ’taskset’ mask input\[char46]
* The lowest order bit corresponds to the first CPU core\[char46] A set bit means the corresponding core is available and a pmd thread will be created and pinned to it\[char46] If the input does not cover all cores, those uncovered cores are considered not set\[char46]
* If not specified, one pmd thread will be created for each numa node and pinned to any available core on the numa node by default\[char46]
* **other_config : dpdk-alloc-mem**: optional string, containing an integer, at least 0  
  Specifies the amount of memory to preallocate from the hugepage pool, regardless of socket\[char46] It is recommended that dpdk-socket-mem is used instead\[char46]
* **other_config : dpdk-socket-mem**: optional string  
  Specifies the amount of memory to preallocate from the hugepage pool, on a per-socket basis\[char46]
* The specifier is a comma-separated string, in ascending order of CPU socket\[char46] E\[char46]g\[char46] On a four socket system 1024,0,2048 would set socket 0 to preallocate 1024MB, socket 1 to preallocate 0MB, socket 2 to preallocate 2048MB and socket 3 (no value given) to preallocate 0MB\[char46]
* If dpdk-socket-mem and dpdk-alloc-mem are not specified, dpdk-socket-mem will be used and the default value is 1024 for each numa node\[char46] If dpdk-socket-mem and dpdk-alloc-mem are specified at same time, dpdk-socket-mem will be used as default\[char46] Changing this value requires restarting the daemon\[char46]
* **other_config : dpdk-hugepage-dir**: optional string  
  Specifies the path to the hugetlbfs mount point\[char46]
* If not specified, this will be guessed by the DPDK library (default is /dev/hugepages)\[char46] Changing this value requires restarting the daemon\[char46]
* **other_config : dpdk-extra**: optional string  
  Specifies additional eal command line arguments for DPDK\[char46]
* The default is empty\[char46] Changing this value requires restarting the daemon
* **other_config : vhost-sock-dir**: optional string  
  Specifies a relative path from **external\_ids:rundir** to the vhost-user unix domain socket files\[char46] If this value is unset, the sockets are put directly in **external\_ids:rundir**\[char46]
* Changing this value requires restarting the daemon\[char46]
* **other_config : vhost-iommu-support**: optional string, either **true** or **false**  
  vHost IOMMU is a security feature, which restricts the vhost memory that a virtio device may access\[char46] vHost IOMMU support is disabled by default, due to a bug in QEMU implementations of the vhost REPLY_ACK protocol, (on which vHost IOMMU relies) prior to v2\[char46]9\[char46]1\[char46] Setting this value to **true** enables vHost IOMMU support for vHost User Client ports in OvS-DPDK, starting from DPDK v17\[char46]11\[char46]
* Changing this value requires restarting the daemon\[char46]
* **other_config : per-port-memory**: optional string, either **true** or **false**  
  By default OVS DPDK uses a shared memory model wherein devices that have the same MTU and socket values can share the same mempool\[char46] Setting this value to **true** changes this behaviour\[char46] Per port memory allow DPDK devices to use private memory per device\[char46] This can provide greater transparency as regards memory usage but potentially at the cost of greater memory requirements\[char46]
* Changing this value requires restarting the daemon if dpdk-init has already been set to true\[char46]
* **other_config : tx-flush-interval**: optional string, containing an integer, in range 0 to 1,000,000  
  Specifies the time in microseconds that a packet can wait in output batch for sending i\[char46]e\[char46] amount of time that packet can spend in an intermediate output queue before sending to netdev\[char46] This option can be used to configure balance between throughput and latency\[char46] Lower values decreases latency while higher values may be useful to achieve higher performance\[char46]
* Defaults to 0 i\[char46]e\[char46] instant packet sending (latency optimized)\[char46]
* **other_config : pmd-perf-metrics**: optional string, either **true** or **false**  
  Enables recording of detailed PMD performance metrics for analysis and trouble-shooting\[char46] This can have a performance impact in the order of 1%\[char46]
* Defaults to false but can be changed at any time\[char46]
* **other_config : smc-enable**: optional string, either **true** or **false**  
  Signature match cache or SMC is a cache between EMC and megaflow cache\[char46] It does not store the full key of the flow, so it is more memory efficient comparing to EMC cache\[char46] SMC is especially useful when flow count is larger than EMC capacity\[char46]
* Defaults to false but can be changed at any time\[char46]
* **other_config : n-handler-threads**: optional string, containing an integer, at least 1  
  Specifies the number of threads for software datapaths to use for handling new flows\[char46] The default the number of online CPU cores minus the number of revalidators\[char46]
* This configuration is per datapath\[char46] If you have more than one software datapath (e\[char46]g\[char46] some **system** bridges and some **netdev** bridges), then the total number of threads is **n-handler-threads** times the number of software datapaths\[char46]
* **other_config : n-revalidator-threads**: optional string, containing an integer, at least 1  
  Specifies the number of threads for software datapaths to use for revalidating flows in the datapath\[char46] Typically, there is a direct correlation between the number of revalidator threads, and the number of flows allowed in the datapath\[char46] The default is the number of cpu cores divided by four plus one\[char46] If **n-handler-threads** is set, the default changes to the number of cpu cores minus the number of handler threads\[char46]
* This configuration is per datapath\[char46] If you have more than one software datapath (e\[char46]g\[char46] some **system** bridges and some **netdev** bridges), then the total number of threads is **n-handler-threads** times the number of software datapaths\[char46]
* **other_config : emc-insert-inv-prob**: optional string, containing an integer, in range 0 to 4,294,967,295  
  Specifies the inverse probability (1/emc-insert-inv-prob) of a flow being inserted into the Exact Match Cache (EMC)\[char46] On average one in every **emc-insert-inv-prob** packets that generate a unique flow will cause an insertion into the EMC\[char46] A value of 1 will result in an insertion for every flow (1/1 = 100%) whereas a value of zero will result in no insertions and essentially disable the EMC\[char46]
* Defaults to 100 ie\[char46] there is (1/100 =) 1% chance of EMC insertion\[char46]
* **other_config : vlan-limit**: optional string, containing an integer, at least 0  
  Limits the number of VLAN headers that can be matched to the specified number\[char46] Further VLAN headers will be treated as payload, e\[char46]g\[char46] a packet with more 802\[char46]1q headers will match Ethernet type 0x8100\[char46]
* Value **0** means unlimited\[char46] The actual number of supported VLAN headers is the smallest of **vlan-limit**, the number of VLANs supported by Open vSwitch userspace (currently 2), and the number supported by the datapath\[char46]
* If this value is absent, the default is currently 1\[char46] This maintains backward compatibility with controllers that were designed for use with Open vSwitch versions earlier than 2\[char46]8, which only supported one VLAN\[char46]
* **other_config : bundle-idle-timeout**: optional string, containing an integer, at least 1  
  The maximum time (in seconds) that idle bundles will wait to be expired since it was either opened, modified or closed\[char46]
* OpenFlow specification mandates the timeout to be at least one second\[char46] The default is 10 seconds\[char46]
  .ST "Status:"


* **next\_cfg**: integer  
  Sequence number for client to increment\[char46] When a client modifies any part of the database configuration and wishes to wait for Open vSwitch to finish applying the changes, it may increment this sequence number\[char46]
* **cur\_cfg**: integer  
  Sequence number that Open vSwitch sets to the current value of **next\_cfg** after it finishes applying a set of configuration changes\[char46]
* **dpdk\_initialized**: boolean  
  True if **other\_config:dpdk-init** is set to true and the DPDK library is successfully initialized\[char46]
  .ST "Statistics:"



The **statistics** column contains key-value pairs that report statistics about a system running an Open vSwitch\[char46] These are updated periodically (currently, every 5 seconds)\[char46] Key-value pairs that cannot be determined or that do not apply to a platform are omitted\[char46]

* **other_config : enable-statistics**: optional string, either **true** or **false**  
  Statistics are disabled by default to avoid overhead in the common case when statistics gathering is not useful\[char46] Set this value to **true** to enable populating the **statistics** column or to **false** to explicitly disable it\[char46]
* **statistics : cpu**: optional string, containing an integer, at least 1  
  Number of CPU processors, threads, or cores currently online and available to the operating system on which Open vSwitch is running, as an integer\[char46] This may be less than the number installed, if some are not online or if they are not available to the operating system\[char46]
* Open vSwitch userspace processes are not multithreaded, but the Linux kernel-based datapath is\[char46]
* **statistics : load\_average**: optional string  
  A comma-separated list of three floating-point numbers, representing the system load average over the last 1, 5, and 15 minutes, respectively\[char46]
* **statistics : memory**: optional string  
  A comma-separated list of integers, each of which represents a quantity of memory in kilobytes that describes the operating system on which Open vSwitch is running\[char46] In respective order, these values are:
    * 1.  
      Total amount of RAM allocated to the OS\[char46]
    * 2.  
      RAM allocated to the OS that is in use\[char46]
    * 3.  
      RAM that can be flushed out to disk or otherwise discarded if that space is needed for another purpose\[char46] This number is necessarily less than or equal to the previous value\[char46]
    * 4.  
      Total disk space allocated for swap\[char46]
    * 5.  
      Swap space currently in use\[char46]
* On Linux, all five values can be determined and are included\[char46] On other operating systems, only the first two values can be determined, so the list will only have two values\[char46]
* **statistics : process\_NAME**: optional string  
  One such key-value pair, with **NAME** replaced by a process name, will exist for each running Open vSwitch daemon process, with _name_ replaced by the daemon’s name (e\[char46]g\[char46] **process\_ovs-vswitchd**)\[char46] The value is a comma-separated list of integers\[char46] The integers represent the following, with memory measured in kilobytes and durations in milliseconds:
    * 1.  
      The process’s virtual memory size\[char46]
    * 2.  
      The process’s resident set size\[char46]
    * 3.  
      The amount of user and system CPU time consumed by the process\[char46]
    * 4.  
      The number of times that the process has crashed and been automatically restarted by the monitor\[char46]
    * 5.  
      The duration since the process was started\[char46]
    * 6.  
      The duration for which the process has been running\[char46]
* The interpretation of some of these values depends on whether the process was started with the **--monitor**\[char46] If it was not, then the crash count will always be 0 and the two durations will always be the same\[char46] If **--monitor** was given, then the crash count may be positive; if it is, the latter duration is the amount of time since the most recent crash and restart\[char46]
* There will be one key-value pair for each file in Open vSwitch’s \`\`run directory’’ (usually **/var/run/openvswitch**) whose name ends in **\[char46]pid**, whose contents are a process ID, and which is locked by a running process\[char46] The _name_ is taken from the pidfile’s name\[char46]
* Currently Open vSwitch is only able to obtain all of the above detail on Linux systems\[char46] On other systems, the same key-value pairs will be present but the values will always be the empty string\[char46]
* **statistics : file\_systems**: optional string  
  A space-separated list of information on local, writable file systems\[char46] Each item in the list describes one file system and consists in turn of a comma-separated list of the following:
    * 1.  
      Mount point, e\[char46]g\[char46] **/** or **/var/log**\[char46] Any spaces or commas in the mount point are replaced by underscores\[char46]
    * 2.  
      Total size, in kilobytes, as an integer\[char46]
    * 3.  
      Amount of storage in use, in kilobytes, as an integer\[char46]
* This key-value pair is omitted if there are no local, writable file systems or if Open vSwitch cannot obtain the needed information\[char46]
  .ST "Version Reporting:"



These columns report the types and versions of the hardware and software running Open vSwitch\[char46] We recommend in general that software should test whether specific features are supported instead of relying on version number checks\[char46] These values are primarily intended for reporting to human administrators\[char46]

* **ovs\_version**: optional string  
  The Open vSwitch version number, e\[char46]g\[char46] **1\[char46]1\[char46]0**\[char46]
* **db\_version**: optional string  
  The database schema version number, e\[char46]g\[char46] **1\[char46]2\[char46]3**\[char46] See ovsdb-tool(1) for an explanation of the numbering scheme\[char46]
* The schema version is part of the database schema, so it can also be retrieved by fetching the schema using the Open vSwitch database protocol\[char46]
* **system\_type**: optional string  
  An identifier for the type of system on top of which Open vSwitch runs, e\[char46]g\[char46] **XenServer** or **KVM**\[char46]
* System integrators are responsible for choosing and setting an appropriate value for this column\[char46]
* **system\_version**: optional string  
  The version of the system identified by **system\_type**, e\[char46]g\[char46] **5\[char46]6\[char46]100-39265p** on XenServer 5\[char46]6\[char46]100 build 39265\[char46]
* System integrators are responsible for choosing and setting an appropriate value for this column\[char46]
* **dpdk\_version**: optional string  
  The version of the linked DPDK library\[char46]
  .ST "Capabilities:"



These columns report capabilities of the Open vSwitch instance\[char46]

* **datapath\_types**: set of strings  
  This column reports the different dpifs registered with the system\[char46] These are the values that this instance supports in the **datapath\_type** column of the **Bridge** table\[char46]
* **iface\_types**: set of strings  
  This column reports the different netdevs registered with the system\[char46] These are the values that this instance supports in the **type** column of the **Interface** table\[char46]
  .ST "Database Configuration:"



These columns primarily configure the Open vSwitch database (**ovsdb-server**), not the Open vSwitch switch (**ovs-vswitchd**)\[char46] The OVSDB database also uses the **ssl** settings\[char46]


The Open vSwitch switch does read the database configuration to determine remote IP addresses to which in-band control should apply\[char46]

* **manager\_options**: set of **Manager**s  
  Database clients to which the Open vSwitch database server should connect or to which it should listen, along with options for how these connections should be configured\[char46] See the **Manager** table for more information\[char46]
* For this column to serve its purpose, **ovsdb-server** must be configured to honor it\[char46] The easiest way to do this is to invoke **ovsdb-server** with the option **--remote=db:Open\_vSwitch,Open\_vSwitch,manager\_options** The startup scripts that accompany Open vSwitch do this by default\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
* **external\_ids**: map of string-string pairs  
  .bp

<a name="bridge-table"></a>

# Bridge Table




Configuration for a bridge within an **Open\_vSwitch**\[char46]


A **Bridge** record represents an Ethernet switch with one or more \`\`ports,’’ which are the **Port** records pointed to by the **Bridge**’s **ports** column\[char46]

<a name="summary"></a>

### "Summary:

.TQ .25in
_Core Features:_
.TQ 2.75in
**name**
immutable string (must be unique within table)
.TQ 2.75in
**ports**
set of **Port**s
.TQ 2.75in
**mirrors**
set of **Mirror**s
.TQ 2.75in
**netflow**
optional **NetFlow**
.TQ 2.75in
**sflow**
optional **sFlow**
.TQ 2.75in
**ipfix**
optional **IPFIX**
.TQ 2.75in
**flood\_vlans**
set of up to 4,096 integers, in range 0 to 4,095
.TQ 2.75in
**auto\_attach**
optional **AutoAttach**
.TQ .25in
_OpenFlow Configuration:_
.TQ 2.75in
**controller**
set of **Controller**s
.TQ 2.75in
**flow\_tables**
map of integer-**Flow\_Table** pairs, key in range 0 to 254
.TQ 2.75in
**fail\_mode**
optional string, either **secure** or **standalone**
.TQ 2.75in
**datapath\_id**
optional string
.TQ 2.75in
**datapath\_version**
string
.TQ 2.75in
**other_config : datapath-id**
optional string
.TQ 2.75in
**other_config : dp-desc**
optional string
.TQ 2.75in
**other_config : disable-in-band**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : in-band-queue**
optional string, containing an integer, in range 0 to 4,294,967,295
.TQ 2.75in
**protocols**
set of strings, one of **OpenFlow10**, **OpenFlow11**, **OpenFlow12**, **OpenFlow13**, **OpenFlow14**, **OpenFlow15**, or **OpenFlow16**
.TQ .25in
_Spanning Tree Configuration:_
.TQ .25in
_STP Configuration:_
.TQ 2.50in
**stp\_enable**
boolean
.TQ 2.50in
**other_config : stp-system-id**
optional string
.TQ 2.50in
**other_config : stp-priority**
optional string, containing an integer, in range 0 to 65,535
.TQ 2.50in
**other_config : stp-hello-time**
optional string, containing an integer, in range 1 to 10
.TQ 2.50in
**other_config : stp-max-age**
optional string, containing an integer, in range 6 to 40
.TQ 2.50in
**other_config : stp-forward-delay**
optional string, containing an integer, in range 4 to 30
.TQ 2.50in
**other_config : mcast-snooping-aging-time**
optional string, containing an integer, at least 1
.TQ 2.50in
**other_config : mcast-snooping-table-size**
optional string, containing an integer, at least 1
.TQ 2.50in
**other_config : mcast-snooping-disable-flood-unregistered**
optional string, either **true** or **false**
.TQ .25in
_STP Status:_
.TQ 2.50in
**status : stp\_bridge\_id**
optional string
.TQ 2.50in
**status : stp\_designated\_root**
optional string
.TQ 2.50in
**status : stp\_root\_path\_cost**
optional string
.TQ .25in
_Rapid Spanning Tree:_
.TQ .25in
_RSTP Configuration:_
.TQ 2.50in
**rstp\_enable**
boolean
.TQ 2.50in
**other_config : rstp-address**
optional string
.TQ 2.50in
**other_config : rstp-priority**
optional string, containing an integer, in range 0 to 61,440
.TQ 2.50in
**other_config : rstp-ageing-time**
optional string, containing an integer, in range 10 to 1,000,000
.TQ 2.50in
**other_config : rstp-force-protocol-version**
optional string, containing an integer
.TQ 2.50in
**other_config : rstp-max-age**
optional string, containing an integer, in range 6 to 40
.TQ 2.50in
**other_config : rstp-forward-delay**
optional string, containing an integer, in range 4 to 30
.TQ 2.50in
**other_config : rstp-transmit-hold-count**
optional string, containing an integer, in range 1 to 10
.TQ .25in
_RSTP Status:_
.TQ 2.50in
**rstp_status : rstp\_bridge\_id**
optional string
.TQ 2.50in
**rstp_status : rstp\_root\_id**
optional string
.TQ 2.50in
**rstp_status : rstp\_root\_path\_cost**
optional string, containing an integer, at least 0
.TQ 2.50in
**rstp_status : rstp\_designated\_id**
optional string
.TQ 2.50in
**rstp_status : rstp\_designated\_port\_id**
optional string
.TQ 2.50in
**rstp_status : rstp\_bridge\_port\_id**
optional string
.TQ .25in
_Multicast Snooping Configuration:_
.TQ 2.75in
**mcast\_snooping\_enable**
boolean
.TQ .25in
_Other Features:_
.TQ 2.75in
**datapath\_type**
string
.TQ 2.75in
**external_ids : bridge-id**
optional string
.TQ 2.75in
**external_ids : xs-network-uuids**
optional string
.TQ 2.75in
**other_config : hwaddr**
optional string
.TQ 2.75in
**other_config : forward-bpdu**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : mac-aging-time**
optional string, containing an integer, at least 1
.TQ 2.75in
**other_config : mac-table-size**
optional string, containing an integer, at least 1
.TQ .25in
_Common Columns:_
.TQ 2.75in
**other\_config**
map of string-string pairs
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:

.ST "Core Features:"


* **name**: immutable string (must be unique within table)  
  Bridge identifier\[char46] Must be unique among the names of ports, interfaces, and bridges on a host\[char46]
* The name must be alphanumeric and must not contain forward or backward slashes\[char46] The name of a bridge is also the name of an **Interface** (and a **Port**) within the bridge, so the restrictions on the **name** column in the **Interface** table, particularly on length, also apply to bridge names\[char46] Refer to the documentation for **Interface** names for details\[char46]
* **ports**: set of **Port**s  
  Ports included in the bridge\[char46]
* **mirrors**: set of **Mirror**s  
  Port mirroring configuration\[char46]
* **netflow**: optional **NetFlow**  
  NetFlow configuration\[char46]
* **sflow**: optional **sFlow**  
  sFlow(R) configuration\[char46]
* **ipfix**: optional **IPFIX**  
  IPFIX configuration\[char46]
* **flood\_vlans**: set of up to 4,096 integers, in range 0 to 4,095  
  VLAN IDs of VLANs on which MAC address learning should be disabled, so that packets are flooded instead of being sent to specific ports that are believed to contain packets’ destination MACs\[char46] This should ordinarily be used to disable MAC learning on VLANs used for mirroring (RSPAN VLANs)\[char46] It may also be useful for debugging\[char46]
* SLB bonding (see the **bond\_mode** column in the **Port** table) is incompatible with **flood\_vlans**\[char46] Consider using another bonding mode or a different type of mirror instead\[char46]
* **auto\_attach**: optional **AutoAttach**  
  Auto Attach configuration\[char46]
  .ST "OpenFlow Configuration:"


* **controller**: set of **Controller**s  
  OpenFlow controller set\[char46] If unset, then no OpenFlow controllers will be used\[char46]
* If there are primary controllers, removing all of them clears the OpenFlow flow tables, group table, and meter table\[char46] If there are no primary controllers, adding one also clears these tables\[char46] Other changes to the set of controllers, such as adding or removing a service controller, adding another primary controller to supplement an existing primary controller, or removing only one of two primary controllers, have no effect on these tables\[char46]
* **flow\_tables**: map of integer-**Flow\_Table** pairs, key in range 0 to 254  
  Configuration for OpenFlow tables\[char46] Each pair maps from an OpenFlow table ID to configuration for that table\[char46]
* **fail\_mode**: optional string, either **secure** or **standalone**  
  When a controller is configured, it is, ordinarily, responsible for setting up all flows on the switch\[char46] Thus, if the connection to the controller fails, no new network connections can be set up\[char46] If the connection to the controller stays down long enough, no packets can pass through the switch at all\[char46] This setting determines the switch’s response to such a situation\[char46] It may be set to one of the following:
    * **standalone**  
      If no message is received from the controller for three times the inactivity probe interval (see **inactivity\_probe**), then Open vSwitch will take over responsibility for setting up flows\[char46] In this mode, Open vSwitch causes the bridge to act like an ordinary MAC-learning switch\[char46] Open vSwitch will continue to retry connecting to the controller in the background and, when the connection succeeds, it will discontinue its standalone behavior\[char46]
    * **secure**  
      Open vSwitch will not set up flows on its own when the controller connection fails or when no controllers are defined\[char46] The bridge will continue to retry connecting to any defined controllers forever\[char46]
* The default is **standalone** if the value is unset, but future versions of Open vSwitch may change the default\[char46]
* The **standalone** mode can create forwarding loops on a bridge that has more than one uplink port unless STP is enabled\[char46] To avoid loops on such a bridge, configure **secure** mode or enable STP (see **stp\_enable**)\[char46]
* When more than one controller is configured, **fail\_mode** is considered only when none of the configured controllers can be contacted\[char46]
* Changing **fail\_mode** when no primary controllers are configured clears the OpenFlow flow tables, group table, and meter table\[char46]
* **datapath\_id**: optional string  
  Reports the OpenFlow datapath ID in use\[char46] Exactly 16 hex digits\[char46] (Setting this column has no useful effect\[char46] Set **other-config:datapath-id** instead\[char46])
* **datapath\_version**: string  
  Reports the version number of the Open vSwitch datapath in use\[char46] This allows management software to detect and report discrepancies between Open vSwitch userspace and datapath versions\[char46] (The **ovs\_version** column in the **Open\_vSwitch** reports the Open vSwitch userspace version\[char46]) The version reported depends on the datapath in use:
    * ·  
      When the kernel module included in the Open vSwitch source tree is used, this column reports the Open vSwitch version from which the module was taken\[char46]
    * ·  
      When the kernel module that is part of the upstream Linux kernel is used, this column reports **&lt;unknown&gt;**\[char46]
    * ·  
      When the datapath is built into the **ovs-vswitchd** binary, this column reports **&lt;built-in&gt;**\[char46] A built-in datapath is by definition the same version as the rest of the Open VSwitch userspace\[char46]
    * ·  
      Other datapaths (such as the Hyper-V kernel datapath) currently report **&lt;unknown&gt;**\[char46]
* A version discrepancy between **ovs-vswitchd** and the datapath in use is not normally cause for alarm\[char46] The Open vSwitch kernel datapaths for Linux and Hyper-V, in particular, are designed for maximum inter-version compatibility: any userspace version works with with any kernel version\[char46] Some reasons do exist to insist on particular user/kernel pairings\[char46] First, newer kernel versions add new features, that can only be used by new-enough userspace, e\[char46]g\[char46] VXLAN tunneling requires certain minimal userspace and kernel versions\[char46] Second, as an extension to the first reason, some newer kernel versions add new features for enhancing performance that only new-enough userspace versions can take advantage of\[char46]
* **other_config : datapath-id**: optional string  
  Overrides the default OpenFlow datapath ID, setting it to the specified value specified in hex\[char46] The value must either have a **0x** prefix or be exactly 16 hex digits long\[char46] May not be all-zero\[char46]
* **other_config : dp-desc**: optional string  
  Human readable description of datapath\[char46] It is a maximum 256 byte-long free-form string to describe the datapath for debugging purposes, e\[char46]g\[char46] **switch3 in room 3120**\[char46]
* **other_config : disable-in-band**: optional string, either **true** or **false**  
  If set to **true**, disable in-band control on the bridge regardless of controller and manager settings\[char46]
* **other_config : in-band-queue**: optional string, containing an integer, in range 0 to 4,294,967,295  
  A queue ID as a nonnegative integer\[char46] This sets the OpenFlow queue ID that will be used by flows set up by in-band control on this bridge\[char46] If unset, or if the port used by an in-band control flow does not have QoS configured, or if the port does not have a queue with the specified ID, the default queue is used instead\[char46]
* **protocols**: set of strings, one of **OpenFlow10**, **OpenFlow11**, **OpenFlow12**, **OpenFlow13**, **OpenFlow14**, **OpenFlow15**, or **OpenFlow16**  
  List of OpenFlow protocols that may be used when negotiating a connection with a controller\[char46] OpenFlow 1\[char46]0, 1\[char46]1, 1\[char46]2, 1\[char46]3, and 1\[char46]4 are enabled by default if this column is empty\[char46]
* OpenFlow 1\[char46]5 and 1\[char46]6 are not enabled by default because their implementations are missing features\[char46] In addition, the OpenFlow 1\[char46]6 specification is still under development and thus subject to change\[char46]
  .ST "Spanning Tree Configuration:"



The IEEE 802\[char46]1D Spanning Tree Protocol (STP) is a network protocol that ensures loop-free topologies\[char46] It allows redundant links to be included in the network to provide automatic backup paths if the active links fails\[char46]


These settings configure the slower-to-converge but still widely supported version of Spanning Tree Protocol, sometimes known as 802\[char46]1D-1998\[char46] Open vSwitch also supports the newer Rapid Spanning Tree Protocol (RSTP), documented later in the section titled Rapid
Spanning Tree Configuration\[char46]
.ST "STP Configuration:"


* **stp\_enable**: boolean  
  Enable spanning tree on the bridge\[char46] By default, STP is disabled on bridges\[char46] Bond, internal, and mirror ports are not supported and will not participate in the spanning tree\[char46]
* STP and RSTP are mutually exclusive\[char46] If both are enabled, RSTP will be used\[char46]
* **other_config : stp-system-id**: optional string  
  The bridge’s STP identifier (the lower 48 bits of the bridge-id) in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_\[char46] By default, the identifier is the MAC address of the bridge\[char46]
* **other_config : stp-priority**: optional string, containing an integer, in range 0 to 65,535  
  The bridge’s relative priority value for determining the root bridge (the upper 16 bits of the bridge-id)\[char46] A bridge with the lowest bridge-id is elected the root\[char46] By default, the priority is 0x8000\[char46]
* **other_config : stp-hello-time**: optional string, containing an integer, in range 1 to 10  
  The interval between transmissions of hello messages by designated ports, in seconds\[char46] By default the hello interval is 2 seconds\[char46]
* **other_config : stp-max-age**: optional string, containing an integer, in range 6 to 40  
  The maximum age of the information transmitted by the bridge when it is the root bridge, in seconds\[char46] By default, the maximum age is 20 seconds\[char46]
* **other_config : stp-forward-delay**: optional string, containing an integer, in range 4 to 30  
  The delay to wait between transitioning root and designated ports to **forwarding**, in seconds\[char46] By default, the forwarding delay is 15 seconds\[char46]
* **other_config : mcast-snooping-aging-time**: optional string, containing an integer, at least 1  
  The maximum number of seconds to retain a multicast snooping entry for which no packets have been seen\[char46] The default is currently 300 seconds (5 minutes)\[char46] The value, if specified, is forced into a reasonable range, currently 15 to 3600 seconds\[char46]
* **other_config : mcast-snooping-table-size**: optional string, containing an integer, at least 1  
  The maximum number of multicast snooping addresses to learn\[char46] The default is currently 2048\[char46] The value, if specified, is forced into a reasonable range, currently 10 to 1,000,000\[char46]
* **other_config : mcast-snooping-disable-flood-unregistered**: optional string, either **true** or **false**  
  If set to **false**, unregistered multicast packets are forwarded to all ports\[char46] If set to **true**, unregistered multicast packets are forwarded to ports connected to multicast routers\[char46]
  .ST "STP Status:"



These key-value pairs report the status of 802\[char46]1D-1998\[char46] They are present only if STP is enabled (via the **stp\_enable** column)\[char46]

* **status : stp\_bridge\_id**: optional string  
  The bridge ID used in spanning tree advertisements, in the form _xxxx_\[char46]_yyyyyyyyyyyy_ where the _x_s are the STP priority, the _y_s are the STP system ID, and each _x_ and _y_ is a hex digit\[char46]
* **status : stp\_designated\_root**: optional string  
  The designated root for this spanning tree, in the same form as **status:stp\_bridge\_id**\[char46] If this bridge is the root, this will have the same value as **status:stp\_bridge\_id**, otherwise it will differ\[char46]
* **status : stp\_root\_path\_cost**: optional string  
  The path cost of reaching the designated bridge\[char46] A lower number is better\[char46] The value is 0 if this bridge is the root, otherwise it is higher\[char46]
  .ST "Rapid Spanning Tree:"



Rapid Spanning Tree Protocol (RSTP), like STP, is a network protocol that ensures loop-free topologies\[char46] RSTP superseded STP with the publication of 802\[char46]1D-2004\[char46] Compared to STP, RSTP converges more quickly and recovers more quickly from failures\[char46]
.ST "RSTP Configuration:"


* **rstp\_enable**: boolean  
  Enable Rapid Spanning Tree on the bridge\[char46] By default, RSTP is disabled on bridges\[char46] Bond, internal, and mirror ports are not supported and will not participate in the spanning tree\[char46]
* STP and RSTP are mutually exclusive\[char46] If both are enabled, RSTP will be used\[char46]
* **other_config : rstp-address**: optional string  
  The bridge’s RSTP address (the lower 48 bits of the bridge-id) in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_\[char46] By default, the address is the MAC address of the bridge\[char46]
* **other_config : rstp-priority**: optional string, containing an integer, in range 0 to 61,440  
  The bridge’s relative priority value for determining the root bridge (the upper 16 bits of the bridge-id)\[char46] A bridge with the lowest bridge-id is elected the root\[char46] By default, the priority is 0x8000 (32768)\[char46] This value needs to be a multiple of 4096, otherwise it’s rounded to the nearest inferior one\[char46]
* **other_config : rstp-ageing-time**: optional string, containing an integer, in range 10 to 1,000,000  
  The Ageing Time parameter for the Bridge\[char46] The default value is 300 seconds\[char46]
* **other_config : rstp-force-protocol-version**: optional string, containing an integer  
  The Force Protocol Version parameter for the Bridge\[char46] This can take the value 0 (STP Compatibility mode) or 2 (the default, normal operation)\[char46]
* **other_config : rstp-max-age**: optional string, containing an integer, in range 6 to 40  
  The maximum age of the information transmitted by the Bridge when it is the Root Bridge\[char46] The default value is 20\[char46]
* **other_config : rstp-forward-delay**: optional string, containing an integer, in range 4 to 30  
  The delay used by STP Bridges to transition Root and Designated Ports to Forwarding\[char46] The default value is 15\[char46]
* **other_config : rstp-transmit-hold-count**: optional string, containing an integer, in range 1 to 10  
  The Transmit Hold Count used by the Port Transmit state machine to limit transmission rate\[char46] The default value is 6\[char46]
  .ST "RSTP Status:"



These key-value pairs report the status of 802\[char46]1D-2004\[char46] They are present only if RSTP is enabled (via the **rstp\_enable** column)\[char46]

* **rstp_status : rstp\_bridge\_id**: optional string  
  The bridge ID used in rapid spanning tree advertisements, in the form _x_\[char46]_yyy_\[char46]_zzzzzzzzzzzz_ where _x_ is the RSTP priority, the _y_s are a locally assigned system ID extension, the _z_s are the STP system ID, and each _x_, _y_, or _z_ is a hex digit\[char46]
* **rstp_status : rstp\_root\_id**: optional string  
  The root of this spanning tree, in the same form as **rstp\_status:rstp\_bridge\_id**\[char46] If this bridge is the root, this will have the same value as **rstp\_status:rstp\_bridge\_id**, otherwise it will differ\[char46]
* **rstp_status : rstp\_root\_path\_cost**: optional string, containing an integer, at least 0  
  The path cost of reaching the root\[char46] A lower number is better\[char46] The value is 0 if this bridge is the root, otherwise it is higher\[char46]
* **rstp_status : rstp\_designated\_id**: optional string  
  The RSTP designated ID, in the same form as **rstp\_status:rstp\_bridge\_id**\[char46]
* **rstp_status : rstp\_designated\_port\_id**: optional string  
  The RSTP designated port ID, as a 4-digit hex number\[char46]
* **rstp_status : rstp\_bridge\_port\_id**: optional string  
  The RSTP bridge port ID, as a 4-digit hex number\[char46]
  .ST "Multicast Snooping Configuration:"

Multicast snooping (RFC 4541) monitors the Internet Group Management Protocol (IGMP) and Multicast Listener Discovery traffic between hosts and multicast routers\[char46] The switch uses what IGMP and MLD snooping learns to forward multicast traffic only to interfaces that are connected to interested receivers\[char46] Currently it supports IGMPv1, IGMPv2, IGMPv3, MLDv1 and MLDv2 protocols\[char46]

* **mcast\_snooping\_enable**: boolean  
  Enable multicast snooping on the bridge\[char46] For now, the default is disabled\[char46]
  .ST "Other Features:"


* **datapath\_type**: string  
  Name of datapath provider\[char46] The kernel datapath has type **system**\[char46] The userspace datapath has type **netdev**\[char46] A manager may refer to the **datapath\_types** column of the **Open\_vSwitch** table for a list of the types accepted by this Open vSwitch instance\[char46]
* **external_ids : bridge-id**: optional string  
  A unique identifier of the bridge\[char46] On Citrix XenServer this will commonly be the same as **external\_ids:xs-network-uuids**\[char46]
* **external_ids : xs-network-uuids**: optional string  
  Semicolon-delimited set of universally unique identifier(s) for the network with which this bridge is associated on a Citrix XenServer host\[char46] The network identifiers are RFC 4122 UUIDs as displayed by, e\[char46]g\[char46], **xe network-list**\[char46]
* **other_config : hwaddr**: optional string  
  An Ethernet address in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_ to set the hardware address of the local port and influence the datapath ID\[char46]
* **other_config : forward-bpdu**: optional string, either **true** or **false**  
  Controls forwarding of BPDUs and other network control frames when NORMAL action is invoked\[char46] When this option is **false** or unset, frames with reserved Ethernet addresses (see table below) will not be forwarded\[char46] When this option is **true**, such frames will not be treated specially\[char46]
* The above general rule has the following exceptions:
    * ·  
      If STP is enabled on the bridge (see the **stp\_enable** column in the **Bridge** table), the bridge processes all received STP packets and never passes them to OpenFlow or forwards them\[char46] This is true even if STP is disabled on an individual port\[char46]
    * ·  
      If LLDP is enabled on an interface (see the **lldp** column in the **Interface** table), the interface processes received LLDP packets and never passes them to OpenFlow or forwards them\[char46]
* Set this option to **true** if the Open vSwitch bridge connects different Ethernet networks and is not configured to participate in STP\[char46]
* This option affects packets with the following destination MAC addresses:
    * **01:80:c2:00:00:00**  
      IEEE 802\[char46]1D Spanning Tree Protocol (STP)\[char46]
    * **01:80:c2:00:00:01**  
      IEEE Pause frame\[char46]
    * **01:80:c2:00:00:0x**  
      Other reserved protocols\[char46]
    * **00:e0:2b:00:00:00**  
      Extreme Discovery Protocol (EDP)\[char46]
    * **00:e0:2b:00:00:04** and **00:e0:2b:00:00:06**  
      Ethernet Automatic Protection Switching (EAPS)\[char46]
    * **01:00:0c:cc:cc:cc**  
      Cisco Discovery Protocol (CDP), VLAN Trunking Protocol (VTP), Dynamic Trunking Protocol (DTP), Port Aggregation Protocol (PAgP), and others\[char46]
    * **01:00:0c:cc:cc:cd**  
      Cisco Shared Spanning Tree Protocol PVSTP+\[char46]
    * **01:00:0c:cd:cd:cd**  
      Cisco STP Uplink Fast\[char46]
    * **01:00:0c:00:00:00**  
      Cisco Inter Switch Link\[char46]
    * **01:00:0c:cc:cc:cx**  
      Cisco CFM\[char46]
* **other_config : mac-aging-time**: optional string, containing an integer, at least 1  
  The maximum number of seconds to retain a MAC learning entry for which no packets have been seen\[char46] The default is currently 300 seconds (5 minutes)\[char46] The value, if specified, is forced into a reasonable range, currently 15 to 3600 seconds\[char46]
* A short MAC aging time allows a network to more quickly detect that a host is no longer connected to a switch port\[char46] However, it also makes it more likely that packets will be flooded unnecessarily, when they are addressed to a connected host that rarely transmits packets\[char46] To reduce the incidence of unnecessary flooding, use a MAC aging time longer than the maximum interval at which a host will ordinarily transmit packets\[char46]
* **other_config : mac-table-size**: optional string, containing an integer, at least 1  
  The maximum number of MAC addresses to learn\[char46] The default is currently 8192\[char46] The value, if specified, is forced into a reasonable range, currently 10 to 1,000,000\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
* **external\_ids**: map of string-string pairs  
  .bp

<a name="port-table"></a>

# Port Table




A port within a **Bridge**\[char46]


Most commonly, a port has exactly one \`\`interface,’’ pointed to by its **interfaces** column\[char46] Such a port logically corresponds to a port on a physical Ethernet switch\[char46] A port with more than one interface is a \`\`bonded port’’ (see **Bonding Configuration**)\[char46]


Some properties that one might think as belonging to a port are actually part of the port’s **Interface** members\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**name**
immutable string (must be unique within table)
.TQ 3.00in
**interfaces**
set of 1 or more **Interface**s
.TQ .25in
_VLAN Configuration:_
.TQ 2.75in
**vlan\_mode**
optional string, one of **access**, **dot1q-tunnel**, **native-tagged**, **native-untagged**, or **trunk**
.TQ 2.75in
**tag**
optional integer, in range 0 to 4,095
.TQ 2.75in
**trunks**
set of up to 4,096 integers, in range 0 to 4,095
.TQ 2.75in
**cvlans**
set of up to 4,096 integers, in range 0 to 4,095
.TQ 2.75in
**other_config : qinq-ethtype**
optional string, either **802\[char46]1ad** or **802\[char46]1q**
.TQ 2.75in
**other_config : priority-tags**
optional string, either **true** or **false**
.TQ .25in
_Bonding Configuration:_
.TQ 2.75in
**bond\_mode**
optional string, one of **active-backup**, **balance-slb**, or **balance-tcp**
.TQ 2.75in
**other_config : bond-hash-basis**
optional string, containing an integer
.TQ .25in
_Link Failure Detection:_
.TQ 2.50in
**other_config : bond-detect-mode**
optional string, either **carrier** or **miimon**
.TQ 2.50in
**other_config : bond-miimon-interval**
optional string, containing an integer
.TQ 2.50in
**bond\_updelay**
integer
.TQ 2.50in
**bond\_downdelay**
integer
.TQ .25in
_LACP Configuration:_
.TQ 2.50in
**lacp**
optional string, one of **active**, **off**, or **passive**
.TQ 2.50in
**other_config : lacp-system-id**
optional string
.TQ 2.50in
**other_config : lacp-system-priority**
optional string, containing an integer, in range 1 to 65,535
.TQ 2.50in
**other_config : lacp-time**
optional string, either **fast** or **slow**
.TQ 2.50in
**other_config : lacp-fallback-ab**
optional string, either **true** or **false**
.TQ .25in
_Rebalancing Configuration:_
.TQ 2.50in
**other_config : bond-rebalance-interval**
optional string, containing an integer, in range 0 to 10,000
.TQ 2.75in
**bond\_fake\_iface**
boolean
.TQ .25in
_Spanning Tree Protocol:_
.TQ .25in
_STP Configuration:_
.TQ 2.50in
**other_config : stp-enable**
optional string, either **true** or **false**
.TQ 2.50in
**other_config : stp-port-num**
optional string, containing an integer, in range 1 to 255
.TQ 2.50in
**other_config : stp-port-priority**
optional string, containing an integer, in range 0 to 255
.TQ 2.50in
**other_config : stp-path-cost**
optional string, containing an integer, in range 0 to 65,535
.TQ .25in
_STP Status:_
.TQ 2.50in
**status : stp\_port\_id**
optional string
.TQ 2.50in
**status : stp\_state**
optional string, one of **blocking**, **disabled**, **forwarding**, **learning**, or **listening**
.TQ 2.50in
**status : stp\_sec\_in\_state**
optional string, containing an integer, at least 0
.TQ 2.50in
**status : stp\_role**
optional string, one of **alternate**, **designated**, or **root**
.TQ .25in
_Rapid Spanning Tree Protocol:_
.TQ .25in
_RSTP Configuration:_
.TQ 2.50in
**other_config : rstp-enable**
optional string, either **true** or **false**
.TQ 2.50in
**other_config : rstp-port-priority**
optional string, containing an integer, in range 0 to 240
.TQ 2.50in
**other_config : rstp-port-num**
optional string, containing an integer, in range 1 to 4,095
.TQ 2.50in
**other_config : rstp-port-path-cost**
optional string, containing an integer
.TQ 2.50in
**other_config : rstp-port-admin-edge**
optional string, either **true** or **false**
.TQ 2.50in
**other_config : rstp-port-auto-edge**
optional string, either **true** or **false**
.TQ 2.50in
**other_config : rstp-port-mcheck**
optional string, either **true** or **false**
.TQ .25in
_RSTP Status:_
.TQ 2.50in
**rstp_status : rstp\_port\_id**
optional string
.TQ 2.50in
**rstp_status : rstp\_port\_role**
optional string, one of **Alternate**, **Backup**, **Designated**, **Disabled**, or **Root**
.TQ 2.50in
**rstp_status : rstp\_port\_state**
optional string, one of **Disabled**, **Discarding**, **Forwarding**, or **Learning**
.TQ 2.50in
**rstp_status : rstp\_designated\_bridge\_id**
optional string
.TQ 2.50in
**rstp_status : rstp\_designated\_port\_id**
optional string
.TQ 2.50in
**rstp_status : rstp\_designated\_path\_cost**
optional string, containing an integer
.TQ .25in
_RSTP Statistics:_
.TQ 2.50in
**rstp_statistics : rstp\_tx\_count**
optional integer
.TQ 2.50in
**rstp_statistics : rstp\_rx\_count**
optional integer
.TQ 2.50in
**rstp_statistics : rstp\_error\_count**
optional integer
.TQ 2.50in
**rstp_statistics : rstp\_uptime**
optional integer
.TQ .25in
_Multicast Snooping:_
.TQ 2.75in
**other_config : mcast-snooping-flood**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : mcast-snooping-flood-reports**
optional string, either **true** or **false**
.TQ .25in
_Other Features:_
.TQ 2.75in
**qos**
optional **QoS**
.TQ 2.75in
**mac**
optional string
.TQ 2.75in
**fake\_bridge**
boolean
.TQ 2.75in
**protected**
boolean
.TQ 2.75in
**external_ids : fake-bridge-id-***
optional string
.TQ 2.75in
**other_config : transient**
optional string, either **true** or **false**
.TQ 3.00in
**bond\_active\_slave**
optional string
.TQ .25in
_Port Statistics:_
.TQ .25in
_Statistics: STP transmit and receive counters:_
.TQ 2.50in
**statistics : stp\_tx\_count**
optional integer
.TQ 2.50in
**statistics : stp\_rx\_count**
optional integer
.TQ 2.50in
**statistics : stp\_error\_count**
optional integer
.TQ .25in
_Common Columns:_
.TQ 2.75in
**other\_config**
map of string-string pairs
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **name**: immutable string (must be unique within table)  
  Port name\[char46] For a non-bonded port, this should be the same as its interface’s name\[char46] Port names must otherwise be unique among the names of ports, interfaces, and bridges on a host\[char46] Because port and interfaces names are usually the same, the restrictions on the **name** column in the **Interface** table, particularly on length, also apply to port names\[char46] Refer to the documentation for **Interface** names for details\[char46]
* **interfaces**: set of 1 or more **Interface**s  
  The port’s interfaces\[char46] If there is more than one, this is a bonded Port\[char46]
  .ST "VLAN Configuration:"



In short, a VLAN (short for \`\`virtual LAN’’) is a way to partition a single switch into multiple switches\[char46] VLANs can be confusing, so for an introduction, please refer to the question \`\`What’s a VLAN?’’ in the Open vSwitch FAQ\[char46]


A VLAN is sometimes encoded into a packet using a 802\[char46]1Q or 802\[char46]1ad VLAN header, but every packet is part of some VLAN whether or not it is encoded in the packet\[char46] (A packet that appears to have no VLAN is part of VLAN 0, by default\[char46]) As a result, it’s useful to think of a VLAN as a metadata property of a packet, separate from how the VLAN is encoded\[char46] For a given port, this column determines how the encoding of a packet that ingresses or egresses the port maps to the packet’s VLAN\[char46] When a packet enters the switch, its VLAN is determined based on its setting in this column and its VLAN headers, if any, and then, conceptually, the VLAN headers are then stripped off\[char46] Conversely, when a packet exits the switch, its VLAN and the settings in this column determine what VLAN headers, if any, are pushed onto the packet before it egresses the port\[char46]


The VLAN configuration in this column affects Open vSwitch only when it is doing \`\`normal switching\[char46]’’ It does not affect flows set up by an OpenFlow controller, outside of the OpenFlow \`\`normal action\[char46]’’


Bridge ports support the following types of VLAN configuration:

* trunk  
  A trunk port carries packets on one or more specified VLANs specified in the **trunks** column (often, on every VLAN)\[char46] A packet that ingresses on a trunk port is in the VLAN specified in its 802\[char46]1Q header, or VLAN 0 if the packet has no 802\[char46]1Q header\[char46] A packet that egresses through a trunk port will have an 802\[char46]1Q header if it has a nonzero VLAN ID\[char46]
* Any packet that ingresses on a trunk port tagged with a VLAN that the port does not trunk is dropped\[char46]
* access  
  An access port carries packets on exactly one VLAN specified in the **tag** column\[char46] Packets egressing on an access port have no 802\[char46]1Q header\[char46]
* Any packet with an 802\[char46]1Q header with a nonzero VLAN ID that ingresses on an access port is dropped, regardless of whether the VLAN ID in the header is the access port’s VLAN ID\[char46]
* native-tagged  
  A native-tagged port resembles a trunk port, with the exception that a packet without an 802\[char46]1Q header that ingresses on a native-tagged port is in the \`\`native VLAN’’ (specified in the **tag** column)\[char46]
* native-untagged  
  A native-untagged port resembles a native-tagged port, with the exception that a packet that egresses on a native-untagged port in the native VLAN will not have an 802\[char46]1Q header\[char46]
* dot1q-tunnel  
  A dot1q-tunnel port is somewhat like an access port\[char46] Like an access port, it carries packets on the single VLAN specified in the **tag** column and this VLAN, called the service VLAN, does not appear in an 802\[char46]1Q header for packets that ingress or egress on the port\[char46] The main difference lies in the behavior when packets that include a 802\[char46]1Q header ingress on the port\[char46] Whereas an access port drops such packets, a dot1q-tunnel port treats these as double-tagged with the outer service VLAN **tag** and the inner customer VLAN taken from the 802\[char46]1Q header\[char46] Correspondingly, to egress on the port, a packet outer VLAN (or only VLAN) must be **tag**, which is removed before egress, which exposes the inner (customer) VLAN if one is present\[char46]
* If **cvlans** is set, only allows packets in the specified customer VLANs\[char46]


A packet will only egress through bridge ports that carry the VLAN of the packet, as described by the rules above\[char46]

* **vlan\_mode**: optional string, one of **access**, **dot1q-tunnel**, **native-tagged**, **native-untagged**, or **trunk**  
  The VLAN mode of the port, as described above\[char46] When this column is empty, a default mode is selected as follows:
    * ·  
      If **tag** contains a value, the port is an access port\[char46] The **trunks** column should be empty\[char46]
    * ·  
      Otherwise, the port is a trunk port\[char46] The **trunks** column value is honored if it is present\[char46]
* **tag**: optional integer, in range 0 to 4,095  
  For an access port, the port’s implicitly tagged VLAN\[char46] For a native-tagged or native-untagged port, the port’s native VLAN\[char46] Must be empty if this is a trunk port\[char46]
* **trunks**: set of up to 4,096 integers, in range 0 to 4,095  
  For a trunk, native-tagged, or native-untagged port, the 802\[char46]1Q VLAN or VLANs that this port trunks; if it is empty, then the port trunks all VLANs\[char46] Must be empty if this is an access port\[char46]
* A native-tagged or native-untagged port always trunks its native VLAN, regardless of whether **trunks** includes that VLAN\[char46]
* **cvlans**: set of up to 4,096 integers, in range 0 to 4,095  
  For a dot1q-tunnel port, the customer VLANs that this port includes\[char46] If this is empty, the port includes all customer VLANs\[char46]
* For other kinds of ports, this setting is ignored\[char46]
* **other_config : qinq-ethtype**: optional string, either **802\[char46]1ad** or **802\[char46]1q**  
  For a dot1q-tunnel port, this is the TPID for the service tag, that is, for the 802\[char46]1Q header that contains the service VLAN ID\[char46] Because packets that actually ingress and egress a dot1q-tunnel port do not include an 802\[char46]1Q header for the service VLAN, this does not affect packets on the dot1q-tunnel port itself\[char46] Rather, it determines the service VLAN for a packet that ingresses on a dot1q-tunnel port and egresses on a trunk port\[char46]
* The value **802\[char46]1ad** specifies TPID 0x88a8, which is also the default if the setting is omitted\[char46] The value **802\[char46]1q** specifies TPID 0x8100\[char46]
* For other kinds of ports, this setting is ignored\[char46]
* **other_config : priority-tags**: optional string, either **true** or **false**  
  An 802\[char46]1Q header contains two important pieces of information: a VLAN ID and a priority\[char46] A frame with a zero VLAN ID, called a \`\`priority-tagged’’ frame, is supposed to be treated the same way as a frame without an 802\[char46]1Q header at all (except for the priority)\[char46]
* However, some network elements ignore any frame that has 802\[char46]1Q header at all, even when the VLAN ID is zero\[char46] Therefore, by default Open vSwitch does not output priority-tagged frames, instead omitting the 802\[char46]1Q header entirely if the VLAN ID is zero\[char46] Set this key to **true** to enable priority-tagged frames on a port\[char46]
* Regardless of this setting, Open vSwitch omits the 802\[char46]1Q header on output if both the VLAN ID and priority would be zero\[char46]
* All frames output to native-tagged ports have a nonzero VLAN ID, so this setting is not meaningful on native-tagged ports\[char46]
  .ST "Bonding Configuration:"



A port that has more than one interface is a \`\`bonded port\[char46]’’ Bonding allows for load balancing and fail-over\[char46]


The following types of bonding will work with any kind of upstream switch\[char46] On the upstream switch, do not configure the interfaces as a bond:

* **balance-slb**  
  Balances flows among slaves based on source MAC address and output VLAN, with periodic rebalancing as traffic patterns change\[char46]
* **active-backup**  
  Assigns all flows to one slave, failing over to a backup slave when the active slave is disabled\[char46] This is the only bonding mode in which interfaces may be plugged into different upstream switches\[char46]


The following modes require the upstream switch to support 802\[char46]3ad with successful LACP negotiation\[char46] If LACP negotiation fails and other-config:lacp-fallback-ab is true, then **active-backup** mode is used:

* **balance-tcp**  
  Balances flows among slaves based on L3 and L4 protocol information such as IP addresses and TCP/UDP ports\[char46]


These columns apply only to bonded ports\[char46] Their values are otherwise ignored\[char46]

* **bond\_mode**: optional string, one of **active-backup**, **balance-slb**, or **balance-tcp**  
  The type of bonding used for a bonded port\[char46] Defaults to **active-backup** if unset\[char46]
* **other_config : bond-hash-basis**: optional string, containing an integer  
  An integer hashed along with flows when choosing output slaves in load balanced bonds\[char46] When changed, all flows will be assigned different hash values possibly causing slave selection decisions to change\[char46] Does not affect bonding modes which do not employ load balancing such as **active-backup**\[char46]
  .ST "Link Failure Detection:"



An important part of link bonding is detecting that links are down so that they may be disabled\[char46] These settings determine how Open vSwitch detects link failure\[char46]

* **other_config : bond-detect-mode**: optional string, either **carrier** or **miimon**  
  The means used to detect link failures\[char46] Defaults to **carrier** which uses each interface’s carrier to detect failures\[char46] When set to **miimon**, will check for failures by polling each interface’s MII\[char46]
* **other_config : bond-miimon-interval**: optional string, containing an integer  
  The interval, in milliseconds, between successive attempts to poll each interface’s MII\[char46] Relevant only when **other\_config:bond-detect-mode** is **miimon**\[char46]
* **bond\_updelay**: integer  
  The number of milliseconds for which the link must stay up on an interface before the interface is considered to be up\[char46] Specify **0** to enable the interface immediately\[char46]
* This setting is honored only when at least one bonded interface is already enabled\[char46] When no interfaces are enabled, then the first bond interface to come up is enabled immediately\[char46]
* **bond\_downdelay**: integer  
  The number of milliseconds for which the link must stay down on an interface before the interface is considered to be down\[char46] Specify **0** to disable the interface immediately\[char46]
  .ST "LACP Configuration:"



LACP, the Link Aggregation Control Protocol, is an IEEE standard that allows switches to automatically detect that they are connected by multiple links and aggregate across those links\[char46] These settings control LACP behavior\[char46]

* **lacp**: optional string, one of **active**, **off**, or **passive**  
  Configures LACP on this port\[char46] LACP allows directly connected switches to negotiate which links may be bonded\[char46] LACP may be enabled on non-bonded ports for the benefit of any switches they may be connected to\[char46] **active** ports are allowed to initiate LACP negotiations\[char46] **passive** ports are allowed to participate in LACP negotiations initiated by a remote switch, but not allowed to initiate such negotiations themselves\[char46] If LACP is enabled on a port whose partner switch does not support LACP, the bond will be disabled, unless other-config:lacp-fallback-ab is set to true\[char46] Defaults to **off** if unset\[char46]
* **other_config : lacp-system-id**: optional string  
  The LACP system ID of this **Port**\[char46] The system ID of a LACP bond is used to identify itself to its partners\[char46] Must be a nonzero MAC address\[char46] Defaults to the bridge Ethernet address if unset\[char46]
* **other_config : lacp-system-priority**: optional string, containing an integer, in range 1 to 65,535  
  The LACP system priority of this **Port**\[char46] In LACP negotiations, link status decisions are made by the system with the numerically lower priority\[char46]
* **other_config : lacp-time**: optional string, either **fast** or **slow**  
  The LACP timing which should be used on this **Port**\[char46] By default **slow** is used\[char46] When configured to be **fast** LACP heartbeats are requested at a rate of once per second causing connectivity problems to be detected more quickly\[char46] In **slow** mode, heartbeats are requested at a rate of once every 30 seconds\[char46]
* **other_config : lacp-fallback-ab**: optional string, either **true** or **false**  
  Determines the behavior of openvswitch bond in LACP mode\[char46] If the partner switch does not support LACP, setting this option to **true** allows openvswitch to fallback to active-backup\[char46] If the option is set to **false**, the bond will be disabled\[char46] In both the cases, once the partner switch is configured to LACP mode, the bond will use LACP\[char46]
  .ST "Rebalancing Configuration:"



These settings control behavior when a bond is in **balance-slb** or **balance-tcp** mode\[char46]

* **other_config : bond-rebalance-interval**: optional string, containing an integer, in range 0 to 10,000  
  For a load balanced bonded port, the number of milliseconds between successive attempts to rebalance the bond, that is, to move flows from one interface on the bond to another in an attempt to keep usage of each interface roughly equal\[char46] If zero, load balancing is disabled on the bond (link failure still cause flows to move)\[char46] If less than 1000ms, the rebalance interval will be 1000ms\[char46]
* **bond\_fake\_iface**: boolean  
  For a bonded port, whether to create a fake internal interface with the name of the port\[char46] Use only for compatibility with legacy software that requires this\[char46]
  .ST "Spanning Tree Protocol:"



The configuration here is only meaningful, and the status is only populated, when 802\[char46]1D-1998 Spanning Tree Protocol is enabled on the port’s **Bridge** with its **stp\_enable** column\[char46]
.ST "STP Configuration:"


* **other_config : stp-enable**: optional string, either **true** or **false**  
  When STP is enabled on a bridge, it is enabled by default on all of the bridge’s ports except bond, internal, and mirror ports (which do not work with STP)\[char46] If this column’s value is **false**, STP is disabled on the port\[char46]
* **other_config : stp-port-num**: optional string, containing an integer, in range 1 to 255  
  The port number used for the lower 8 bits of the port-id\[char46] By default, the numbers will be assigned automatically\[char46] If any port’s number is manually configured on a bridge, then they must all be\[char46]
* **other_config : stp-port-priority**: optional string, containing an integer, in range 0 to 255  
  The port’s relative priority value for determining the root port (the upper 8 bits of the port-id)\[char46] A port with a lower port-id will be chosen as the root port\[char46] By default, the priority is 0x80\[char46]
* **other_config : stp-path-cost**: optional string, containing an integer, in range 0 to 65,535  
  Spanning tree path cost for the port\[char46] A lower number indicates a faster link\[char46] By default, the cost is based on the maximum speed of the link\[char46]
  .ST "STP Status:"


* **status : stp\_port\_id**: optional string  
  The port ID used in spanning tree advertisements for this port, as 4 hex digits\[char46] Configuring the port ID is described in the **stp-port-num** and **stp-port-priority** keys of the **other\_config** section earlier\[char46]
* **status : stp\_state**: optional string, one of **blocking**, **disabled**, **forwarding**, **learning**, or **listening**  
  STP state of the port\[char46]
* **status : stp\_sec\_in\_state**: optional string, containing an integer, at least 0  
  The amount of time this port has been in the current STP state, in seconds\[char46]
* **status : stp\_role**: optional string, one of **alternate**, **designated**, or **root**  
  STP role of the port\[char46]
  .ST "Rapid Spanning Tree Protocol:"



The configuration here is only meaningful, and the status and statistics are only populated, when 802\[char46]1D-1998 Spanning Tree Protocol is enabled on the port’s **Bridge** with its **stp\_enable** column\[char46]
.ST "RSTP Configuration:"


* **other_config : rstp-enable**: optional string, either **true** or **false**  
  When RSTP is enabled on a bridge, it is enabled by default on all of the bridge’s ports except bond, internal, and mirror ports (which do not work with RSTP)\[char46] If this column’s value is **false**, RSTP is disabled on the port\[char46]
* **other_config : rstp-port-priority**: optional string, containing an integer, in range 0 to 240  
  The port’s relative priority value for determining the root port, in multiples of 16\[char46] By default, the port priority is 0x80 (128)\[char46] Any value in the lower 4 bits is rounded off\[char46] The significant upper 4 bits become the upper 4 bits of the port-id\[char46] A port with the lowest port-id is elected as the root\[char46]
* **other_config : rstp-port-num**: optional string, containing an integer, in range 1 to 4,095  
  The local RSTP port number, used as the lower 12 bits of the port-id\[char46] By default the port numbers are assigned automatically, and typically may not correspond to the OpenFlow port numbers\[char46] A port with the lowest port-id is elected as the root\[char46]
* **other_config : rstp-port-path-cost**: optional string, containing an integer  
  The port path cost\[char46] The Port’s contribution, when it is the Root Port, to the Root Path Cost for the Bridge\[char46] By default the cost is automatically calculated from the port’s speed\[char46]
* **other_config : rstp-port-admin-edge**: optional string, either **true** or **false**  
  The admin edge port parameter for the Port\[char46] Default is **false**\[char46]
* **other_config : rstp-port-auto-edge**: optional string, either **true** or **false**  
  The auto edge port parameter for the Port\[char46] Default is **true**\[char46]
* **other_config : rstp-port-mcheck**: optional string, either **true** or **false**  
  The mcheck port parameter for the Port\[char46] Default is **false**\[char46] May be set to force the Port Protocol Migration state machine to transmit RST BPDUs for a MigrateTime period, to test whether all STP Bridges on the attached LAN have been removed and the Port can continue to transmit RSTP BPDUs\[char46] Setting mcheck has no effect if the Bridge is operating in STP Compatibility mode\[char46]
* Changing the value from **true** to **false** has no effect, but needs to be done if this behavior is to be triggered again by subsequently changing the value from **false** to **true**\[char46]
  .ST "RSTP Status:"


* **rstp_status : rstp\_port\_id**: optional string  
  The port ID used in spanning tree advertisements for this port, as 4 hex digits\[char46] Configuring the port ID is described in the **rstp-port-num** and **rstp-port-priority** keys of the **other\_config** section earlier\[char46]
* **rstp_status : rstp\_port\_role**: optional string, one of **Alternate**, **Backup**, **Designated**, **Disabled**, or **Root**  
  RSTP role of the port\[char46]
* **rstp_status : rstp\_port\_state**: optional string, one of **Disabled**, **Discarding**, **Forwarding**, or **Learning**  
  RSTP state of the port\[char46]
* **rstp_status : rstp\_designated\_bridge\_id**: optional string  
  The port’s RSTP designated bridge ID, in the same form as **rstp\_status:rstp\_bridge\_id** in the **Bridge** table\[char46]
* **rstp_status : rstp\_designated\_port\_id**: optional string  
  The port’s RSTP designated port ID, as 4 hex digits\[char46]
* **rstp_status : rstp\_designated\_path\_cost**: optional string, containing an integer  
  The port’s RSTP designated path cost\[char46] Lower is better\[char46]
  .ST "RSTP Statistics:"


* **rstp_statistics : rstp\_tx\_count**: optional integer  
  Number of RSTP BPDUs transmitted through this port\[char46]
* **rstp_statistics : rstp\_rx\_count**: optional integer  
  Number of valid RSTP BPDUs received by this port\[char46]
* **rstp_statistics : rstp\_error\_count**: optional integer  
  Number of invalid RSTP BPDUs received by this port\[char46]
* **rstp_statistics : rstp\_uptime**: optional integer  
  The duration covered by the other RSTP statistics, in seconds\[char46]
  .ST "Multicast Snooping:"


* **other_config : mcast-snooping-flood**: optional string, either **true** or **false**  
  If set to **true**, multicast packets (except Reports) are unconditionally forwarded to the specific port\[char46]
* **other_config : mcast-snooping-flood-reports**: optional string, either **true** or **false**  
  If set to **true**, multicast Reports are unconditionally forwarded to the specific port\[char46]
  .ST "Other Features:"


* **qos**: optional **QoS**  
  Quality of Service configuration for this port\[char46]
* **mac**: optional string  
  The MAC address to use for this port for the purpose of choosing the bridge’s MAC address\[char46] This column does not necessarily reflect the port’s actual MAC address, nor will setting it change the port’s actual MAC address\[char46]
* **fake\_bridge**: boolean  
  Does this port represent a sub-bridge for its tagged VLAN within the Bridge? See ovs-vsctl(8) for more information\[char46]
* **protected**: boolean  
  The protected ports feature allows certain ports to be designated as protected\[char46] Traffic between protected ports is blocked\[char46] Protected ports can send traffic to unprotected ports\[char46] Unprotected ports can send traffic to any port\[char46] Default is false\[char46]
* **external_ids : fake-bridge-id-***: optional string  
  External IDs for a fake bridge (see the **fake\_bridge** column) are defined by prefixing a **Bridge** **external\_ids** key with **fake-bridge-**, e\[char46]g\[char46] **fake-bridge-xs-network-uuids**\[char46]
* **other_config : transient**: optional string, either **true** or **false**  
  If set to **true**, the port will be removed when **ovs-ctl start --delete-transient-ports** is used\[char46]
* **bond\_active\_slave**: optional string  
  For a bonded port, record the mac address of the current active slave\[char46]
  .ST "Port Statistics:"



Key-value pairs that report port statistics\[char46] The update period is controlled by **other\_config:stats-update-interval** in the **Open\_vSwitch** table\[char46]
.ST "Statistics: STP transmit and receive counters:"


* **statistics : stp\_tx\_count**: optional integer  
  Number of STP BPDUs sent on this port by the spanning tree library\[char46]
* **statistics : stp\_rx\_count**: optional integer  
  Number of STP BPDUs received on this port and accepted by the spanning tree library\[char46]
* **statistics : stp\_error\_count**: optional integer  
  Number of bad STP BPDUs received on this port\[char46] Bad BPDUs include runt packets and those with an unexpected protocol ID\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
* **external\_ids**: map of string-string pairs  
  .bp

<a name="interface-table"></a>

# Interface Table


An interface within a **Port**\[char46]

<a name="summary"></a>

### "Summary:

.TQ .25in
_Core Features:_
.TQ 2.75in
**name**
immutable string (must be unique within table)
.TQ 2.75in
**ifindex**
optional integer, in range 0 to 4,294,967,295
.TQ 2.75in
**mac\_in\_use**
optional string
.TQ 2.75in
**mac**
optional string
.TQ 2.75in
**error**
optional string
.TQ .25in
_OpenFlow Port Number:_
.TQ 2.50in
**ofport**
optional integer
.TQ 2.50in
**ofport\_request**
optional integer, in range 1 to 65,279
.TQ .25in
_System-Specific Details:_
.TQ 2.75in
**type**
string
.TQ .25in
_Tunnel Options:_
.TQ 2.75in
**options : remote\_ip**
optional string
.TQ 2.75in
**options : local\_ip**
optional string
.TQ 2.75in
**options : in\_key**
optional string
.TQ 2.75in
**options : out\_key**
optional string
.TQ 2.75in
**options : dst\_port**
optional string
.TQ 2.75in
**options : key**
optional string
.TQ 2.75in
**options : tos**
optional string
.TQ 2.75in
**options : ttl**
optional string
.TQ 2.75in
**options : df\_default**
optional string, either **true** or **false**
.TQ 2.75in
**options : egress\_pkt\_mark**
optional string
.TQ .25in
_Tunnel Options: lisp only:_
.TQ 2.50in
**options : packet\_type**
optional string, either **legacy\_l3** or **ptap**
.TQ .25in
_Tunnel Options: vxlan only:_
.TQ 2.50in
**options : exts**
optional string
.TQ 2.50in
**options : packet\_type**
optional string, one of **legacy\_l2**, **legacy\_l3**, or **ptap**
.TQ .25in
_Tunnel Options: gre only:_
.TQ 2.50in
**options : packet\_type**
optional string, one of **legacy\_l2**, **legacy\_l3**, or **ptap**
.TQ 2.50in
**options : seq**
optional string, either **true** or **false**
.TQ .25in
_Tunnel Options: gre, geneve, and vxlan:_
.TQ 2.50in
**options : csum**
optional string, either **true** or **false**
.TQ .25in
_Tunnel Options: erspan only:_
.TQ 2.75in
**options : erspan\_idx**
optional string
.TQ 2.75in
**options : erspan\_ver**
optional string
.TQ 2.75in
**options : erspan\_dir**
optional string
.TQ 2.75in
**options : erspan\_hwid**
optional string
.TQ .25in
_Patch Options:_
.TQ 2.75in
**options : peer**
optional string
.TQ .25in
_PMD (Poll Mode Driver) Options:_
.TQ 2.75in
**options : n\_rxq**
optional string, containing an integer, at least 1
.TQ 2.75in
**options : dpdk-devargs**
optional string
.TQ 2.75in
**other_config : pmd-rxq-affinity**
optional string
.TQ 2.75in
**options : vhost-server-path**
optional string
.TQ 2.75in
**options : dq-zero-copy**
optional string, either **true** or **false**
.TQ 2.75in
**options : n\_rxq\_desc**
optional string, containing an integer, in range 1 to 4,096
.TQ 2.75in
**options : n\_txq\_desc**
optional string, containing an integer, in range 1 to 4,096
.TQ .25in
_MTU:_
.TQ 2.75in
**mtu**
optional integer
.TQ 2.75in
**mtu\_request**
optional integer, at least 1
.TQ .25in
_Interface Status:_
.TQ 2.75in
**admin\_state**
optional string, either **down** or **up**
.TQ 2.75in
**link\_state**
optional string, either **down** or **up**
.TQ 2.75in
**link\_resets**
optional integer
.TQ 2.75in
**link\_speed**
optional integer
.TQ 2.75in
**duplex**
optional string, either **full** or **half**
.TQ 2.75in
**lacp\_current**
optional boolean
.TQ 2.75in
**status**
map of string-string pairs
.TQ 2.75in
**status : driver\_name**
optional string
.TQ 2.75in
**status : driver\_version**
optional string
.TQ 2.75in
**status : firmware\_version**
optional string
.TQ 2.75in
**status : source\_ip**
optional string
.TQ 2.75in
**status : tunnel\_egress\_iface**
optional string
.TQ 2.75in
**status : tunnel\_egress\_iface\_carrier**
optional string, either **down** or **up**
.TQ .25in
_dpdk:_
.TQ 2.50in
**status : port\_no**
optional string
.TQ 2.50in
**status : numa\_id**
optional string
.TQ 2.50in
**status : min\_rx\_bufsize**
optional string
.TQ 2.50in
**status : max\_rx\_pktlen**
optional string
.TQ 2.50in
**status : max\_rx\_queues**
optional string
.TQ 2.50in
**status : max\_tx\_queues**
optional string
.TQ 2.50in
**status : max\_mac\_addrs**
optional string
.TQ 2.50in
**status : max\_hash\_mac\_addrs**
optional string
.TQ 2.50in
**status : max\_vfs**
optional string
.TQ 2.50in
**status : max\_vmdq\_pools**
optional string
.TQ 2.50in
**status : if\_type**
optional string
.TQ 2.50in
**status : if\_descr**
optional string
.TQ 2.50in
**status : pci-vendor\_id**
optional string
.TQ 2.50in
**status : pci-device\_id**
optional string
.TQ .25in
_Statistics:_
.TQ .25in
_Statistics: Successful transmit and receive counters:_
.TQ 2.50in
**statistics : rx\_packets**
optional integer
.TQ 2.50in
**statistics : rx\_bytes**
optional integer
.TQ 2.50in
**statistics : tx\_packets**
optional integer
.TQ 2.50in
**statistics : tx\_bytes**
optional integer
.TQ .25in
_Statistics: Receive errors:_
.TQ 2.50in
**statistics : rx\_dropped**
optional integer
.TQ 2.50in
**statistics : rx\_frame\_err**
optional integer
.TQ 2.50in
**statistics : rx\_over\_err**
optional integer
.TQ 2.50in
**statistics : rx\_crc\_err**
optional integer
.TQ 2.50in
**statistics : rx\_errors**
optional integer
.TQ .25in
_Statistics: Transmit errors:_
.TQ 2.50in
**statistics : tx\_dropped**
optional integer
.TQ 2.50in
**statistics : collisions**
optional integer
.TQ 2.50in
**statistics : tx\_errors**
optional integer
.TQ .25in
_Ingress Policing:_
.TQ 2.75in
**ingress\_policing\_rate**
integer, at least 0
.TQ 2.75in
**ingress\_policing\_burst**
integer, at least 0
.TQ .25in
_Bidirectional Forwarding Detection (BFD):_
.TQ .25in
_BFD Configuration:_
.TQ 2.50in
**bfd : enable**
optional string, either **true** or **false**
.TQ 2.50in
**bfd : min\_rx**
optional string, containing an integer, at least 1
.TQ 2.50in
**bfd : min\_tx**
optional string, containing an integer, at least 1
.TQ 2.50in
**bfd : decay\_min\_rx**
optional string, containing an integer
.TQ 2.50in
**bfd : forwarding\_if\_rx**
optional string, either **true** or **false**
.TQ 2.50in
**bfd : cpath\_down**
optional string, either **true** or **false**
.TQ 2.50in
**bfd : check\_tnl\_key**
optional string, either **true** or **false**
.TQ 2.50in
**bfd : bfd\_local\_src\_mac**
optional string
.TQ 2.50in
**bfd : bfd\_local\_dst\_mac**
optional string
.TQ 2.50in
**bfd : bfd\_remote\_dst\_mac**
optional string
.TQ 2.50in
**bfd : bfd\_src\_ip**
optional string
.TQ 2.50in
**bfd : bfd\_dst\_ip**
optional string
.TQ 2.50in
**bfd : oam**
optional string
.TQ 2.50in
**bfd : mult**
optional string, containing an integer, in range 1 to 255
.TQ .25in
_BFD Status:_
.TQ 2.50in
**bfd_status : state**
optional string, one of **admin\_down**, **down**, **init**, or **up**
.TQ 2.50in
**bfd_status : forwarding**
optional string, either **true** or **false**
.TQ 2.50in
**bfd_status : diagnostic**
optional string
.TQ 2.50in
**bfd_status : remote\_state**
optional string, one of **admin\_down**, **down**, **init**, or **up**
.TQ 2.50in
**bfd_status : remote\_diagnostic**
optional string
.TQ 2.50in
**bfd_status : flap\_count**
optional string, containing an integer, at least 0
.TQ .25in
_Connectivity Fault Management:_
.TQ 2.75in
**cfm\_mpid**
optional integer
.TQ 2.75in
**cfm\_flap\_count**
optional integer
.TQ 2.75in
**cfm\_fault**
optional boolean
.TQ 2.75in
**cfm_fault_status : recv**
none
.TQ 2.75in
**cfm_fault_status : rdi**
none
.TQ 2.75in
**cfm_fault_status : maid**
none
.TQ 2.75in
**cfm_fault_status : loopback**
none
.TQ 2.75in
**cfm_fault_status : overflow**
none
.TQ 2.75in
**cfm_fault_status : override**
none
.TQ 2.75in
**cfm_fault_status : interval**
none
.TQ 2.75in
**cfm\_remote\_opstate**
optional string, either **down** or **up**
.TQ 2.75in
**cfm\_health**
optional integer, in range 0 to 100
.TQ 2.75in
**cfm\_remote\_mpids**
set of integers
.TQ 2.75in
**other_config : cfm\_interval**
optional string, containing an integer
.TQ 2.75in
**other_config : cfm\_extended**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : cfm\_demand**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : cfm\_opstate**
optional string, either **down** or **up**
.TQ 2.75in
**other_config : cfm\_ccm\_vlan**
optional string, containing an integer, in range 1 to 4,095
.TQ 2.75in
**other_config : cfm\_ccm\_pcp**
optional string, containing an integer, in range 1 to 7
.TQ .25in
_Bonding Configuration:_
.TQ 2.75in
**other_config : lacp-port-id**
optional string, containing an integer, in range 1 to 65,535
.TQ 2.75in
**other_config : lacp-port-priority**
optional string, containing an integer, in range 1 to 65,535
.TQ 2.75in
**other_config : lacp-aggregation-key**
optional string, containing an integer, in range 1 to 65,535
.TQ .25in
_Virtual Machine Identifiers:_
.TQ 2.75in
**external_ids : attached-mac**
optional string
.TQ 2.75in
**external_ids : iface-id**
optional string
.TQ 2.75in
**external_ids : iface-status**
optional string, either **active** or **inactive**
.TQ 2.75in
**external_ids : xs-vif-uuid**
optional string
.TQ 2.75in
**external_ids : xs-network-uuid**
optional string
.TQ 2.75in
**external_ids : vm-id**
optional string
.TQ 2.75in
**external_ids : xs-vm-uuid**
optional string
.TQ .25in
_Auto Attach Configuration:_
.TQ 2.75in
**lldp : enable**
optional string, either **true** or **false**
.TQ .25in
_Flow control Configuration:_
.TQ 2.75in
**options : rx-flow-ctrl**
optional string, either **true** or **false**
.TQ 2.75in
**options : tx-flow-ctrl**
optional string, either **true** or **false**
.TQ 2.75in
**options : flow-ctrl-autoneg**
optional string, either **true** or **false**
.TQ .25in
_Link State Change detection mode:_
.TQ 2.75in
**options : dpdk-lsc-interrupt**
optional string, either **true** or **false**
.TQ .25in
_Common Columns:_
.TQ 2.75in
**other\_config**
map of string-string pairs
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:

.ST "Core Features:"


* **name**: immutable string (must be unique within table)  
  Interface name\[char46] Should be alphanumeric\[char46] For non-bonded port, this should be the same as the port name\[char46] It must otherwise be unique among the names of ports, interfaces, and bridges on a host\[char46]
* The maximum length of an interface name depends on the underlying datapath:
    * ·  
      The names of interfaces implemented as Linux and BSD network devices, including interfaces with type **internal**, **tap**, or **system** plus the different types of tunnel ports, are limited to 15 bytes\[char46] Windows limits these names to 255 bytes\[char46]
    * ·  
      The names of patch ports are not used in the underlying datapath, so operating system restrictions do not apply\[char46] Thus, they may have arbitrary length\[char46]
* Regardless of other restrictions, OpenFlow only supports 15-byte names, which means that **ovs-ofctl** and OpenFlow controllers will show names truncated to 15 bytes\[char46]
* **ifindex**: optional integer, in range 0 to 4,294,967,295  
  A positive interface index as defined for SNMP MIB-II in RFCs 1213 and 2863, if the interface has one, otherwise 0\[char46] The ifindex is useful for seamless integration with protocols such as SNMP and sFlow\[char46]
* **mac\_in\_use**: optional string  
  The MAC address in use by this interface\[char46]
* **mac**: optional string  
  Ethernet address to set for this interface\[char46] If unset then the default MAC address is used:
    * ·  
      For the local interface, the default is the lowest-numbered MAC address among the other bridge ports, either the value of the **mac** in its **Port** record, if set, or its actual MAC (for bonded ports, the MAC of its slave whose name is first in alphabetical order)\[char46] Internal ports and bridge ports that are used as port mirroring destinations (see the **Mirror** table) are ignored\[char46]
    * ·  
      For other internal interfaces, the default MAC is randomly generated\[char46]
    * ·  
      External interfaces typically have a MAC address associated with their hardware\[char46]
* Some interfaces may not have a software-controllable MAC address\[char46] This option only affects internal ports\[char46] For other type ports, you can change the MAC address outside Open vSwitch, using ip command\[char46]
* **error**: optional string  
  If the configuration of the port failed, as indicated by -1 in **ofport**, Open vSwitch sets this column to an error description in human readable form\[char46] Otherwise, Open vSwitch clears this column\[char46]
  .ST "OpenFlow Port Number:"



When a client adds a new interface, Open vSwitch chooses an OpenFlow port number for the new port\[char46] If the client that adds the port fills in **ofport\_request**, then Open vSwitch tries to use its value as the OpenFlow port number\[char46] Otherwise, or if the requested port number is already in use or cannot be used for another reason, Open vSwitch automatically assigns a free port number\[char46] Regardless of how the port number was obtained, Open vSwitch then reports in **ofport** the port number actually assigned\[char46]


Open vSwitch limits the port numbers that it automatically assigns to the range 1 through 32,767, inclusive\[char46] Controllers therefore have free use of ports 32,768 and up\[char46]

* **ofport**: optional integer  
  OpenFlow port number for this interface\[char46] Open vSwitch sets this column’s value, so other clients should treat it as read-only\[char46]
* The OpenFlow \`\`local’’ port (**OFPP\_LOCAL**) is 65,534\[char46] The other valid port numbers are in the range 1 to 65,279, inclusive\[char46] Value -1 indicates an error adding the interface\[char46]
* **ofport\_request**: optional integer, in range 1 to 65,279  
  Requested OpenFlow port number for this interface\[char46]
* A client should ideally set this column’s value in the same database transaction that it uses to create the interface\[char46] Open vSwitch version 2\[char46]1 and later will honor a later request for a specific port number, althuogh it might confuse some controllers: OpenFlow does not have a way to announce a port number change, so Open vSwitch represents it over OpenFlow as a port deletion followed immediately by a port addition\[char46]
* If **ofport\_request** is set or changed to some other port’s automatically assigned port number, Open vSwitch chooses a new port number for the latter port\[char46]
  .ST "System-Specific Details:"


* **type**: string  
  The interface type\[char46] The types supported by a particular instance of Open vSwitch are listed in the **iface\_types** column in the **Open\_vSwitch** table\[char46] The following types are defined:
    * **system**  
      An ordinary network device, e\[char46]g\[char46] **eth0** on Linux\[char46] Sometimes referred to as \`\`external interfaces’’ since they are generally connected to hardware external to that on which the Open vSwitch is running\[char46] The empty string is a synonym for **system**\[char46]
    * **internal**  
      A simulated network device that sends and receives traffic\[char46] An internal interface whose **name** is the same as its bridge’s **name** is called the \`\`local interface\[char46]’’ It does not make sense to bond an internal interface, so the terms \`\`port’’ and \`\`interface’’ are often used imprecisely for internal interfaces\[char46]
    * **tap**  
      A TUN/TAP device managed by Open vSwitch\[char46]
    * Open vSwitch checks the interface state before send packets to the device\[char46] When it is **down**, the packets are dropped and the tx_dropped statistic is updated accordingly\[char46] Older versions of Open vSwitch did not check the interface state and then the tx_packets was incremented along with tx_dropped\[char46]
    * **geneve**  
      An Ethernet over Geneve (**http://tools\[char46]ietf\[char46]org/html/draft-ietf-nvo3-geneve**) IPv4/IPv6 tunnel\[char46] A description of how to match and set Geneve options can be found in the **ovs-ofctl** manual page\[char46]
    * **gre**  
      Generic Routing Encapsulation (GRE) over IPv4/IPv6 tunnel, configurable to encapsulate layer 2 or layer 3 traffic\[char46]
    * **vxlan**  
      An Ethernet tunnel over the UDP-based VXLAN protocol described in RFC 7348\[char46]
    * Open vSwitch uses IANA-assigned UDP destination port 4789\[char46] The source port used for VXLAN traffic varies on a per-flow basis and is in the ephemeral port range\[char46]
    * **lisp**  
      A layer 3 tunnel over the experimental, UDP-based Locator/ID Separation Protocol (RFC 6830)\[char46]
    * Only IPv4 and IPv6 packets are supported by the protocol, and they are sent and received without an Ethernet header\[char46] Traffic to/from LISP ports is expected to be configured explicitly, and the ports are not intended to participate in learning based switching\[char46] As such, they are always excluded from packet flooding\[char46]
    * **stt**  
      The Stateless TCP Tunnel (STT) is particularly useful when tunnel endpoints are in end-systems, as it utilizes the capabilities of standard network interface cards to improve performance\[char46] STT utilizes a TCP-like header inside the IP header\[char46] It is stateless, i\[char46]e\[char46], there is no TCP connection state of any kind associated with the tunnel\[char46] The TCP-like header is used to leverage the capabilities of existing network interface cards, but should not be interpreted as implying any sort of connection state between endpoints\[char46] Since the STT protocol does not engage in the usual TCP 3-way handshake, so it will have difficulty traversing stateful firewalls\[char46] The protocol is documented at https://tools\[char46]ietf\[char46]org/html/draft-davie-stt All traffic uses a default destination port of 7471\[char46]
    * **patch**  
      A pair of virtual devices that act as a patch cable\[char46]
  .ST "Tunnel Options:"



These options apply to interfaces with **type** of **geneve**, **gre**, **vxlan**, **lisp** and **stt**\[char46]


Each tunnel must be uniquely identified by the combination of **type**, **options:remote\_ip**, **options:local\_ip**, and **options:in\_key**\[char46] If two ports are defined that are the same except one has an optional identifier and the other does not, the more specific one is matched first\[char46] **options:in\_key** is considered more specific than **options:local\_ip** if a port defines one and another port defines the other\[char46]

* **options : remote\_ip**: optional string  
  Required\[char46] The remote tunnel endpoint, one of:
    * ·  
      An IPv4 or IPv6 address (not a DNS name), e\[char46]g\[char46] **192\[char46]168\[char46]0\[char46]123**\[char46] Only unicast endpoints are supported\[char46]
    * ·  
      The word **flow**\[char46] The tunnel accepts packets from any remote tunnel endpoint\[char46] To process only packets from a specific remote tunnel endpoint, the flow entries may match on the **tun\_src** or **tun\_ipv6\_src**field\[char46] When sending packets to a **remote\_ip=flow** tunnel, the flow actions must explicitly set the **tun\_dst** or **tun\_ipv6\_dst** field to the IP address of the desired remote tunnel endpoint, e\[char46]g\[char46] with a **set\_field** action\[char46]
* The remote tunnel endpoint for any packet received from a tunnel is available in the **tun\_src** field for matching in the flow table\[char46]
* **options : local\_ip**: optional string  
  Optional\[char46] The tunnel destination IP that received packets must match\[char46] Default is to match all addresses\[char46] If specified, may be one of:
    * ·  
      An IPv4/IPv6 address (not a DNS name), e\[char46]g\[char46] **192\[char46]168\[char46]12\[char46]3**\[char46]
    * ·  
      The word **flow**\[char46] The tunnel accepts packets sent to any of the local IP addresses of the system running OVS\[char46] To process only packets sent to a specific IP address, the flow entries may match on the **tun\_dst** or **tun\_ipv6\_dst** field\[char46] When sending packets to a **local\_ip=flow** tunnel, the flow actions may explicitly set the **tun\_src** or **tun\_ipv6\_src** field to the desired IP address, e\[char46]g\[char46] with a **set\_field** action\[char46] However, while routing the tunneled packet out, the local system may override the specified address with the local IP address configured for the outgoing system interface\[char46]
    * This option is valid only for tunnels also configured with the **remote\_ip=flow** option\[char46]
* The tunnel destination IP address for any packet received from a tunnel is available in the **tun\_dst** or **tun\_ipv6\_dst** field for matching in the flow table\[char46]
* **options : in\_key**: optional string  
  Optional\[char46] The key that received packets must contain, one of:
    * ·  
      **0**\[char46] The tunnel receives packets with no key or with a key of 0\[char46] This is equivalent to specifying no **options:in\_key** at all\[char46]
    * ·  
      A positive 24-bit (for Geneve, VXLAN, and LISP), 32-bit (for GRE) or 64-bit (for STT) number\[char46] The tunnel receives only packets with the specified key\[char46]
    * ·  
      The word **flow**\[char46] The tunnel accepts packets with any key\[char46] The key will be placed in the **tun\_id** field for matching in the flow table\[char46] The **ovs-ofctl** manual page contains additional information about matching fields in OpenFlow flows\[char46]
* * **options : out\_key**: optional string  
Optional\[char46] The key to be set on outgoing packets, one of:  
    * ·  
      **0**\[char46] Packets sent through the tunnel will have no key\[char46] This is equivalent to specifying no **options:out\_key** at all\[char46]
    * ·  
      A positive 24-bit (for Geneve, VXLAN and LISP), 32-bit (for GRE) or 64-bit (for STT) number\[char46] Packets sent through the tunnel will have the specified key\[char46]
    * ·  
      The word **flow**\[char46] Packets sent through the tunnel will have the key set using the **set\_tunnel** Nicira OpenFlow vendor extension (0 is used in the absence of an action)\[char46] The **ovs-ofctl** manual page contains additional information about the Nicira OpenFlow vendor extensions\[char46]
* **options : dst\_port**: optional string  
  Optional\[char46] The tunnel transport layer destination port, for UDP and TCP based tunnel protocols (Geneve, VXLAN, LISP, and STT)\[char46]
* **options : key**: optional string  
  Optional\[char46] Shorthand to set **in\_key** and **out\_key** at the same time\[char46]
* **options : tos**: optional string  
  Optional\[char46] The value of the ToS bits to be set on the encapsulating packet\[char46] ToS is interpreted as DSCP and ECN bits, ECN part must be zero\[char46] It may also be the word **inherit**, in which case the ToS will be copied from the inner packet if it is IPv4 or IPv6 (otherwise it will be 0)\[char46] The ECN fields are always inherited\[char46] Default is 0\[char46]
* **options : ttl**: optional string  
  Optional\[char46] The TTL to be set on the encapsulating packet\[char46] It may also be the word **inherit**, in which case the TTL will be copied from the inner packet if it is IPv4 or IPv6 (otherwise it will be the system default, typically 64)\[char46] Default is the system default TTL\[char46]
* **options : df\_default**: optional string, either **true** or **false**  
  Optional\[char46] If enabled, the Don’t Fragment bit will be set on tunnel outer headers to allow path MTU discovery\[char46] Default is enabled; set to **false** to disable\[char46]
* **options : egress\_pkt\_mark**: optional string  
  Optional\[char46] The pkt_mark to be set on the encapsulating packet\[char46] This option sets packet mark for the tunnel endpoint for all tunnel packets including tunnel monitoring\[char46]
  .ST "Tunnel Options: lisp only:"


* **options : packet\_type**: optional string, either **legacy\_l3** or **ptap**  
  A LISP tunnel sends and receives only IPv4 and IPv6 packets\[char46] This option controls what how the tunnel represents the packets that it sends and receives:
    * ·  
      By default, or if this option is **legacy\_l3**, the tunnel represents packets as Ethernet frames for compatibility with legacy OpenFlow controllers that expect this behavior\[char46]
    * ·  
      If this option is **ptap**, the tunnel represents packets using the **packet\_type** mechanism introduced in OpenFlow 1\[char46]5\[char46]
  .ST "Tunnel Options: vxlan only:"


* **options : exts**: optional string  
  Optional\[char46] Comma separated list of optional VXLAN extensions to enable\[char46] The following extensions are supported:
    * ·  
      **gbp**: VXLAN-GBP allows to transport the group policy context of a packet across the VXLAN tunnel to other network peers\[char46] See the description of **tun\_gbp\_id** and **tun\_gbp\_flags** in **ovs-fields**(7) for additional information\[char46] (**https://tools\[char46]ietf\[char46]org/html/draft-smith-vxlan-group-policy**)
    * ·  
      **gpe**: Support for Generic Protocol Encapsulation in accordance with IETF draft **https://tools\[char46]ietf\[char46]org/html/draft-ietf-nvo3-vxlan-gpe**\[char46] Without this option, a VXLAN packet always encapsulates an Ethernet frame\[char46] With this option, an VXLAN packet may also encapsulate an IPv4, IPv6, NSH, or MPLS packet\[char46]
* **options : packet\_type**: optional string, one of **legacy\_l2**, **legacy\_l3**, or **ptap**  
  This option controls what types of packets the tunnel sends and receives and how it represents them:
    * ·  
      By default, or if this option is **legacy\_l2**, the tunnel sends and receives only Ethernet frames\[char46]
    * ·  
      If this option is **legacy\_l3**, the tunnel sends and receives only non-Ethernet (L3) packet, but the packets are represented as Ethernet frames for compatibility with legacy OpenFlow controllers that expect this behavior\[char46] This requires enabling **gpe** in **options:exts**\[char46]
    * ·  
      If this option is **ptap**, Open vSwitch represents packets in the tunnel using the **packet\_type** mechanism introduced in OpenFlow 1\[char46]5\[char46] This mechanism supports any kind of packet, but actually sending and receiving non-Ethernet packets requires additionally enabling **gpe** in **options:exts**\[char46]
  .ST "Tunnel Options: gre only:"



**gre** interfaces support these options\[char46]

* **options : packet\_type**: optional string, one of **legacy\_l2**, **legacy\_l3**, or **ptap**  
  This option controls what types of packets the tunnel sends and receives and how it represents them:
    * ·  
      By default, or if this option is **legacy\_l2**, the tunnel sends and receives only Ethernet frames\[char46]
    * ·  
      If this option is **legacy\_l3**, the tunnel sends and receives only non-Ethernet (L3) packet, but the packets are represented as Ethernet frames for compatibility with legacy OpenFlow controllers that expect this behavior\[char46]
    * ·  
      If this option is **ptap**, the tunnel sends and receives any kind of packet\[char46] Open vSwitch represents packets in the tunnel using the **packet\_type** mechanism introduced in OpenFlow 1\[char46]5\[char46]
* **options : seq**: optional string, either **true** or **false**  
  Optional\[char46] A 4-byte sequence number field for GRE tunnel only\[char46] Default is disabled, set to **true** to enable\[char46] Sequence number is incremented by one on each outgoing packet\[char46]
  .ST "Tunnel Options: gre, geneve, and vxlan:"



**gre**, **geneve**, and **vxlan** interfaces support these options\[char46]

* **options : csum**: optional string, either **true** or **false**  
  Optional\[char46] Compute encapsulation header (either GRE or UDP) checksums on outgoing packets\[char46] Default is disabled, set to **true** to enable\[char46] Checksums present on incoming packets will be validated regardless of this setting\[char46]
* When using the upstream Linux kernel module, computation of checksums for **geneve** and **vxlan** requires Linux kernel version 4\[char46]0 or higher\[char46] **gre** supports checksums for all versions of Open vSwitch that support GRE\[char46] The out of tree kernel module distributed as part of OVS can compute all tunnel checksums on any kernel version that it is compatible with\[char46]
  .ST "Tunnel Options: erspan only:"



Only **erspan** interfaces support these options\[char46]

* **options : erspan\_idx**: optional string  
  20 bit index/port number associated with the ERSPAN traffic’s source port and direction (ingress/egress)\[char46] This field is platform dependent\[char46]
* **options : erspan\_ver**: optional string  
  ERSPAN version: 1 for version 1 (type II) or 2 for version 2 (type III)\[char46]
* **options : erspan\_dir**: optional string  
  Specifies the ERSPAN v2 mirrored traffic’s direction\[char46] 1 for egress traffic, and 0 for ingress traffic\[char46]
* **options : erspan\_hwid**: optional string  
  ERSPAN hardware ID is a 6-bit unique identifier of an ERSPAN v2 engine within a system\[char46]
  .ST "Patch Options:"



These options apply only to _patch ports_, that is, interfaces whose **type** column is **patch**\[char46] Patch ports are mainly a way to connect otherwise independent bridges to one another, similar to how one might plug an Ethernet cable (a \`\`patch cable’’) into two physical switches to connect those switches\[char46] The effect of plugging a patch port into two switches is conceptually similar to that of plugging the two ends of a Linux **veth** device into those switches, but the implementation of patch ports makes them much more efficient\[char46]


Patch ports may connect two different bridges (the usual case) or the same bridge\[char46] In the latter case, take special care to avoid loops, e\[char46]g\[char46] by programming appropriate flows with OpenFlow\[char46] Patch ports do not work if its ends are attached to bridges on different datapaths, e\[char46]g\[char46] to connect bridges in **system** and **netdev** datapaths\[char46]


The following command creates and connects patch ports **p0** and **p1** and adds them to bridges **br0** and **br1**, respectively:

      
    ovs-vsctl add-port br0 p0 -- set Interface p0 type=patch options:peer=p1 e  
           -- add-port br1 p1 -- set Interface p1 type=patch options:peer=p0  
          

* **options : peer**: optional string  
  The **name** of the **Interface** for the other side of the patch\[char46] The named **Interface**’s own **peer** option must specify this **Interface**’s name\[char46] That is, the two patch interfaces must have reversed **name** and **peer** values\[char46]
  .ST "PMD (Poll Mode Driver) Options:"



Only PMD netdevs support these options\[char46]

* **options : n\_rxq**: optional string, containing an integer, at least 1  
  Specifies the maximum number of rx queues to be created for PMD netdev\[char46] If not specified or specified to 0, one rx queue will be created by default\[char46] Not supported by DPDK vHost interfaces\[char46]
* **options : dpdk-devargs**: optional string  
  Specifies the PCI address associated with the port for physical devices, or the virtual driver to be used for the port when a virtual PMD is intended to be used\[char46] For the latter, the argument string typically takes the form of **eth\__driver\_namex**, where driver\_name_ is a valid virtual DPDK PMD driver name and _x_ is a unique identifier of your choice for the given port\[char46] Only supported by the dpdk port type\[char46]
* **other_config : pmd-rxq-affinity**: optional string  
  Specifies mapping of RX queues of this interface to CPU cores\[char46]
* Value should be set in the following form:
* **other\_config:pmd-rxq-affinity=&lt;rxq-affinity-list&gt;**
* where
*     * ·  
&lt;rxq-affinity-list&gt; ::= NULL | &lt;non-empty-list&gt;  
    * ·  
      &lt;non-empty-list&gt; ::= &lt;affinity-pair&gt; | &lt;affinity-pair&gt; , &lt;non-empty-list&gt;
    * ·  
      &lt;affinity-pair&gt; ::= &lt;queue-id&gt; : &lt;core-id&gt;
* **options : vhost-server-path**: optional string  
  The value specifies the path to the socket associated with a vHost User client mode device that has been or will be created by QEMU\[char46] Only supported by dpdkvhostuserclient interfaces\[char46]
* **options : dq-zero-copy**: optional string, either **true** or **false**  
  The value specifies whether or not to enable dequeue zero copy on the given interface\[char46] Must be set before vhost-server-path is specified\[char46] Only supported by dpdkvhostuserclient interfaces\[char46] The feature is considered experimental\[char46]
* **options : n\_rxq\_desc**: optional string, containing an integer, in range 1 to 4,096  
  Specifies the rx queue size (number rx descriptors) for dpdk ports\[char46] The value must be a power of 2, less than 4096 and supported by the hardware of the device being configured\[char46] If not specified or an incorrect value is specified, 2048 rx descriptors will be used by default\[char46]
* **options : n\_txq\_desc**: optional string, containing an integer, in range 1 to 4,096  
  Specifies the tx queue size (number tx descriptors) for dpdk ports\[char46] The value must be a power of 2, less than 4096 and supported by the hardware of the device being configured\[char46] If not specified or an incorrect value is specified, 2048 tx descriptors will be used by default\[char46]
  .ST "MTU:"



The MTU (maximum transmission unit) is the largest amount of data that can fit into a single Ethernet frame\[char46] The standard Ethernet MTU is 1500 bytes\[char46] Some physical media and many kinds of virtual interfaces can be configured with higher MTUs\[char46]


A client may change an interface MTU by filling in **mtu\_request**\[char46] Open vSwitch then reports in **mtu** the currently configured value\[char46]

* **mtu**: optional integer  
  The currently configured MTU for the interface\[char46]
* This column will be empty for an interface that does not have an MTU as, for example, some kinds of tunnels do not\[char46]
* Open vSwitch sets this column’s value, so other clients should treat it as read-only\[char46]
* **mtu\_request**: optional integer, at least 1  
  Requested MTU (Maximum Transmission Unit) for the interface\[char46] A client can fill this column to change the MTU of an interface\[char46]
* RFC 791 requires every internet module to be able to forward a datagram of 68 octets without further fragmentation\[char46] The maximum size of an IP packet is 65535 bytes\[char46]
* If this is not set and if the interface has **internal** type, Open vSwitch will change the MTU to match the minimum of the other interfaces in the bridge\[char46]
  .ST "Interface Status:"



Status information about interfaces attached to bridges, updated every 5 seconds\[char46] Not all interfaces have all of these properties; virtual interfaces don’t have a link speed, for example\[char46] Non-applicable columns will have empty values\[char46]

* **admin\_state**: optional string, either **down** or **up**  
  The administrative state of the physical network link\[char46]
* **link\_state**: optional string, either **down** or **up**  
  The observed state of the physical network link\[char46] This is ordinarily the link’s carrier status\[char46] If the interface’s **Port** is a bond configured for miimon monitoring, it is instead the network link’s miimon status\[char46]
* **link\_resets**: optional integer  
  The number of times Open vSwitch has observed the **link\_state** of this **Interface** change\[char46]
* **link\_speed**: optional integer  
  The negotiated speed of the physical network link\[char46] Valid values are positive integers greater than 0\[char46]
* **duplex**: optional string, either **full** or **half**  
  The duplex mode of the physical network link\[char46]
* **lacp\_current**: optional boolean  
  Boolean value indicating LACP status for this interface\[char46] If true, this interface has current LACP information about its LACP partner\[char46] This information may be used to monitor the health of interfaces in a LACP enabled port\[char46] This column will be empty if LACP is not enabled\[char46]
* **status**: map of string-string pairs  
  Key-value pairs that report port status\[char46] Supported status values are **type**-dependent; some interfaces may not have a valid **status:driver\_name**, for example\[char46]
* **status : driver\_name**: optional string  
  The name of the device driver controlling the network adapter\[char46]
* **status : driver\_version**: optional string  
  The version string of the device driver controlling the network adapter\[char46]
* **status : firmware\_version**: optional string  
  The version string of the network adapter’s firmware, if available\[char46]
* **status : source\_ip**: optional string  
  The source IP address used for an IPv4/IPv6 tunnel end-point, such as **gre**\[char46]
* **status : tunnel\_egress\_iface**: optional string  
  Egress interface for tunnels\[char46] Currently only relevant for tunnels on Linux systems, this column will show the name of the interface which is responsible for routing traffic destined for the configured **options:remote\_ip**\[char46] This could be an internal interface such as a bridge port\[char46]
* **status : tunnel\_egress\_iface\_carrier**: optional string, either **down** or **up**  
  Whether carrier is detected on **status:tunnel\_egress\_iface**\[char46]
  .ST "dpdk:"



DPDK specific interface status options\[char46]

* **status : port\_no**: optional string  
  DPDK port ID\[char46]
* **status : numa\_id**: optional string  
  NUMA socket ID to which an Ethernet device is connected\[char46]
* **status : min\_rx\_bufsize**: optional string  
  Minimum size of RX buffer\[char46]
* **status : max\_rx\_pktlen**: optional string  
  Maximum configurable length of RX pkt\[char46]
* **status : max\_rx\_queues**: optional string  
  Maximum number of RX queues\[char46]
* **status : max\_tx\_queues**: optional string  
  Maximum number of TX queues\[char46]
* **status : max\_mac\_addrs**: optional string  
  Maximum number of MAC addresses\[char46]
* **status : max\_hash\_mac\_addrs**: optional string  
  Maximum number of hash MAC addresses for MTA and UTA\[char46]
* **status : max\_vfs**: optional string  
  Maximum number of hash MAC addresses for MTA and UTA\[char46] Maximum number of VFs\[char46]
* **status : max\_vmdq\_pools**: optional string  
  Maximum number of VMDq pools\[char46]
* **status : if\_type**: optional string  
  Interface type ID according to IANA ifTYPE MIB definitions\[char46]
* **status : if\_descr**: optional string  
  Interface description string\[char46]
* **status : pci-vendor\_id**: optional string  
  Vendor ID of PCI device\[char46]
* **status : pci-device\_id**: optional string  
  Device ID of PCI device\[char46]
  .ST "Statistics:"



Key-value pairs that report interface statistics\[char46] The current implementation updates these counters periodically\[char46] The update period is controlled by **other\_config:stats-update-interval** in the **Open\_vSwitch** table\[char46] Future implementations may update them when an interface is created, when they are queried (e\[char46]g\[char46] using an OVSDB **select** operation), and just before an interface is deleted due to virtual interface hot-unplug or VM shutdown, and perhaps at other times, but not on any regular periodic basis\[char46]


These are the same statistics reported by OpenFlow in its struct
ofp\_port\_stats structure\[char46] If an interface does not support a given statistic, then that pair is omitted\[char46]
.ST "Statistics: Successful transmit and receive counters:"


* **statistics : rx\_packets**: optional integer  
  Number of received packets\[char46]
* **statistics : rx\_bytes**: optional integer  
  Number of received bytes\[char46]
* **statistics : tx\_packets**: optional integer  
  Number of transmitted packets\[char46]
* **statistics : tx\_bytes**: optional integer  
  Number of transmitted bytes\[char46]
  .ST "Statistics: Receive errors:"


* **statistics : rx\_dropped**: optional integer  
  Number of packets dropped by RX\[char46]
* **statistics : rx\_frame\_err**: optional integer  
  Number of frame alignment errors\[char46]
* **statistics : rx\_over\_err**: optional integer  
  Number of packets with RX overrun\[char46]
* **statistics : rx\_crc\_err**: optional integer  
  Number of CRC errors\[char46]
* **statistics : rx\_errors**: optional integer  
  Total number of receive errors, greater than or equal to the sum of the above\[char46]
  .ST "Statistics: Transmit errors:"


* **statistics : tx\_dropped**: optional integer  
  Number of packets dropped by TX\[char46]
* **statistics : collisions**: optional integer  
  Number of collisions\[char46]
* **statistics : tx\_errors**: optional integer  
  Total number of transmit errors, greater than or equal to the sum of the above\[char46]
  .ST "Ingress Policing:"



These settings control ingress policing for packets received on this interface\[char46] On a physical interface, this limits the rate at which traffic is allowed into the system from the outside; on a virtual interface (one connected to a virtual machine), this limits the rate at which the VM is able to transmit\[char46]


Policing is a simple form of quality-of-service that simply drops packets received in excess of the configured rate\[char46] Due to its simplicity, policing is usually less accurate and less effective than egress QoS (which is configured using the **QoS** and **Queue** tables)\[char46]


Policing is currently implemented on Linux and OVS with DPDK\[char46] Both implementations use a simple \`\`token bucket’’ approach:

* ·  
  The size of the bucket corresponds to **ingress\_policing\_burst**\[char46] Initially the bucket is full\[char46]
* ·  
  Whenever a packet is received, its size (converted to tokens) is compared to the number of tokens currently in the bucket\[char46] If the required number of tokens are available, they are removed and the packet is forwarded\[char46] Otherwise, the packet is dropped\[char46]
* ·  
  Whenever it is not full, the bucket is refilled with tokens at the rate specified by **ingress\_policing\_rate**\[char46]


Policing interacts badly with some network protocols, and especially with fragmented IP packets\[char46] Suppose that there is enough network activity to keep the bucket nearly empty all the time\[char46] Then this token bucket algorithm will forward a single packet every so often, with the period depending on packet size and on the configured rate\[char46] All of the fragments of an IP packets are normally transmitted back-to-back, as a group\[char46] In such a situation, therefore, only one of these fragments will be forwarded and the rest will be dropped\[char46] IP does not provide any way for the intended recipient to ask for only the remaining fragments\[char46] In such a case there are two likely possibilities for what will happen next: either all of the fragments will eventually be retransmitted (as TCP will do), in which case the same problem will recur, or the sender will not realize that its packet has been dropped and data will simply be lost (as some UDP-based protocols will do)\[char46] Either way, it is possible that no forward progress will ever occur\[char46]

* **ingress\_policing\_rate**: integer, at least 0  
  Maximum rate for data received on this interface, in kbps\[char46] Data received faster than this rate is dropped\[char46] Set to **0** (the default) to disable policing\[char46]
* **ingress\_policing\_burst**: integer, at least 0  
  Maximum burst size for data received on this interface, in kb\[char46] The default burst size if set to **0** is 8000 kbit\[char46] This value has no effect if **ingress\_policing\_rate** is **0**\[char46]
* Specifying a larger burst size lets the algorithm be more forgiving, which is important for protocols like TCP that react severely to dropped packets\[char46] The burst size should be at least the size of the interface’s MTU\[char46] Specifying a value that is numerically at least as large as 80% of **ingress\_policing\_rate** helps TCP come closer to achieving the full rate\[char46]
  .ST "Bidirectional Forwarding Detection (BFD):"



BFD, defined in RFC 5880 and RFC 5881, allows point-to-point detection of connectivity failures by occasional transmission of BFD control messages\[char46] Open vSwitch implements BFD to serve as a more popular and standards compliant alternative to CFM\[char46]


BFD operates by regularly transmitting BFD control messages at a rate negotiated independently in each direction\[char46] Each endpoint specifies the rate at which it expects to receive control messages, and the rate at which it is willing to transmit them\[char46] By default, Open vSwitch uses a detection multiplier of three, meaning that an endpoint signals a connectivity fault if three consecutive BFD control messages fail to arrive\[char46] In the case of a unidirectional connectivity issue, the system not receiving BFD control messages signals the problem to its peer in the messages it transmits\[char46]


The Open vSwitch implementation of BFD aims to comply faithfully with RFC 5880 requirements\[char46] Open vSwitch does not implement the optional Authentication or \`\`Echo Mode’’ features\[char46]
.ST "BFD Configuration:"



A controller sets up key-value pairs in the **bfd** column to enable and configure BFD\[char46]

* **bfd : enable**: optional string, either **true** or **false**  
  True to enable BFD on this **Interface**\[char46] If not specified, BFD will not be enabled by default\[char46]
* **bfd : min\_rx**: optional string, containing an integer, at least 1  
  The shortest interval, in milliseconds, at which this BFD session offers to receive BFD control messages\[char46] The remote endpoint may choose to send messages at a slower rate\[char46] Defaults to **1000**\[char46]
* **bfd : min\_tx**: optional string, containing an integer, at least 1  
  The shortest interval, in milliseconds, at which this BFD session is willing to transmit BFD control messages\[char46] Messages will actually be transmitted at a slower rate if the remote endpoint is not willing to receive as quickly as specified\[char46] Defaults to **100**\[char46]
* **bfd : decay\_min\_rx**: optional string, containing an integer  
  An alternate receive interval, in milliseconds, that must be greater than or equal to **bfd:min\_rx**\[char46] The implementation switches from **bfd:min\_rx** to **bfd:decay\_min\_rx** when there is no obvious incoming data traffic at the interface, to reduce the CPU and bandwidth cost of monitoring an idle interface\[char46] This feature may be disabled by setting a value of 0\[char46] This feature is reset whenever **bfd:decay\_min\_rx** or **bfd:min\_rx** changes\[char46]
* **bfd : forwarding\_if\_rx**: optional string, either **true** or **false**  
  When **true**, traffic received on the **Interface** is used to indicate the capability of packet I/O\[char46] BFD control packets are still transmitted and received\[char46] At least one BFD control packet must be received every 100 * **bfd:min\_rx** amount of time\[char46] Otherwise, even if traffic are received, the **bfd:forwarding** will be **false**\[char46]
* **bfd : cpath\_down**: optional string, either **true** or **false**  
  Set to true to notify the remote endpoint that traffic should not be forwarded to this system for some reason other than a connectivty failure on the interface being monitored\[char46] The typical underlying reason is \`\`concatenated path down,’’ that is, that connectivity beyond the local system is down\[char46] Defaults to false\[char46]
* **bfd : check\_tnl\_key**: optional string, either **true** or **false**  
  Set to true to make BFD accept only control messages with a tunnel key of zero\[char46] By default, BFD accepts control messages with any tunnel key\[char46]
* **bfd : bfd\_local\_src\_mac**: optional string  
  Set to an Ethernet address in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_ to set the MAC used as source for transmitted BFD packets\[char46] The default is the mac address of the BFD enabled interface\[char46]
* **bfd : bfd\_local\_dst\_mac**: optional string  
  Set to an Ethernet address in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_ to set the MAC used as destination for transmitted BFD packets\[char46] The default is **00:23:20:00:00:01**\[char46]
* **bfd : bfd\_remote\_dst\_mac**: optional string  
  Set to an Ethernet address in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_ to set the MAC used for checking the destination of received BFD packets\[char46] Packets with different destination MAC will not be considered as BFD packets\[char46] If not specified the destination MAC address of received BFD packets are not checked\[char46]
* **bfd : bfd\_src\_ip**: optional string  
  Set to an IPv4 address to set the IP address used as source for transmitted BFD packets\[char46] The default is **169\[char46]254\[char46]1\[char46]1**\[char46]
* **bfd : bfd\_dst\_ip**: optional string  
  Set to an IPv4 address to set the IP address used as destination for transmitted BFD packets\[char46] The default is **169\[char46]254\[char46]1\[char46]0**\[char46]
* **bfd : oam**: optional string  
  Some tunnel protocols (such as Geneve) include a bit in the header to indicate that the encapsulated packet is an OAM frame\[char46] By setting this to true, BFD packets will be marked as OAM if encapsulated in one of these tunnels\[char46]
* **bfd : mult**: optional string, containing an integer, in range 1 to 255  
  The BFD detection multiplier, which defaults to 3\[char46] An endpoint signals a connectivity fault if the given number of consecutive BFD control messages fail to arrive\[char46]
  .ST "BFD Status:"



The switch sets key-value pairs in the **bfd\_status** column to report the status of BFD on this interface\[char46] When BFD is not enabled, with **bfd:enable**, the switch clears all key-value pairs from **bfd\_status**\[char46]

* **bfd_status : state**: optional string, one of **admin\_down**, **down**, **init**, or **up**  
  Reports the state of the BFD session\[char46] The BFD session is fully healthy and negotiated if **UP**\[char46]
* **bfd_status : forwarding**: optional string, either **true** or **false**  
  Reports whether the BFD session believes this **Interface** may be used to forward traffic\[char46] Typically this means the local session is signaling **UP**, and the remote system isn’t signaling a problem such as concatenated path down\[char46]
* **bfd_status : diagnostic**: optional string  
  A diagnostic code specifying the local system’s reason for the last change in session state\[char46] The error messages are defined in section 4\[char46]1 of [RFC 5880]\[char46]
* **bfd_status : remote\_state**: optional string, one of **admin\_down**, **down**, **init**, or **up**  
  Reports the state of the remote endpoint’s BFD session\[char46]
* **bfd_status : remote\_diagnostic**: optional string  
  A diagnostic code specifying the remote system’s reason for the last change in session state\[char46] The error messages are defined in section 4\[char46]1 of [RFC 5880]\[char46]
* **bfd_status : flap\_count**: optional string, containing an integer, at least 0  
  Counts the number of **bfd\_status:forwarding** flaps since start\[char46] A flap is considered as a change of the **bfd\_status:forwarding** value\[char46]
  .ST "Connectivity Fault Management:"



802\[char46]1ag Connectivity Fault Management (CFM) allows a group of Maintenance Points (MPs) called a Maintenance Association (MA) to detect connectivity problems with each other\[char46] MPs within a MA should have complete and exclusive interconnectivity\[char46] This is verified by occasionally broadcasting Continuity Check Messages (CCMs) at a configurable transmission interval\[char46]


According to the 802\[char46]1ag specification, each Maintenance Point should be configured out-of-band with a list of Remote Maintenance Points it should have connectivity to\[char46] Open vSwitch differs from the specification in this area\[char46] It simply assumes the link is faulted if no Remote Maintenance Points are reachable, and considers it not faulted otherwise\[char46]


When operating over tunnels which have no **in\_key**, or an **in\_key** of **flow**\[char46] CFM will only accept CCMs with a tunnel key of zero\[char46]

* **cfm\_mpid**: optional integer  
  A Maintenance Point ID (MPID) uniquely identifies each endpoint within a Maintenance Association\[char46] The MPID is used to identify this endpoint to other Maintenance Points in the MA\[char46] Each end of a link being monitored should have a different MPID\[char46] Must be configured to enable CFM on this **Interface**\[char46]
* According to the 802\[char46]1ag specification, MPIDs can only range between [1, 8191]\[char46] However, extended mode (see **other\_config:cfm\_extended**) supports eight byte MPIDs\[char46]
* **cfm\_flap\_count**: optional integer  
  Counts the number of cfm fault flapps since boot\[char46] A flap is considered to be a change of the **cfm\_fault** value\[char46]
* **cfm\_fault**: optional boolean  
  Indicates a connectivity fault triggered by an inability to receive heartbeats from any remote endpoint\[char46] When a fault is triggered on **Interface**s participating in bonds, they will be disabled\[char46]
* Faults can be triggered for several reasons\[char46] Most importantly they are triggered when no CCMs are received for a period of 3\[char46]5 times the transmission interval\[char46] Faults are also triggered when any CCMs indicate that a Remote Maintenance Point is not receiving CCMs but able to send them\[char46] Finally, a fault is triggered if a CCM is received which indicates unexpected configuration\[char46] Notably, this case arises when a CCM is received which advertises the local MPID\[char46]
* **cfm_fault_status : recv**: none  
  Indicates a CFM fault was triggered due to a lack of CCMs received on the **Interface**\[char46]
* **cfm_fault_status : rdi**: none  
  Indicates a CFM fault was triggered due to the reception of a CCM with the RDI bit flagged\[char46] Endpoints set the RDI bit in their CCMs when they are not receiving CCMs themselves\[char46] This typically indicates a unidirectional connectivity failure\[char46]
* **cfm_fault_status : maid**: none  
  Indicates a CFM fault was triggered due to the reception of a CCM with a MAID other than the one Open vSwitch uses\[char46] CFM broadcasts are tagged with an identification number in addition to the MPID called the MAID\[char46] Open vSwitch only supports receiving CCM broadcasts tagged with the MAID it uses internally\[char46]
* **cfm_fault_status : loopback**: none  
  Indicates a CFM fault was triggered due to the reception of a CCM advertising the same MPID configured in the **cfm\_mpid** column of this **Interface**\[char46] This may indicate a loop in the network\[char46]
* **cfm_fault_status : overflow**: none  
  Indicates a CFM fault was triggered because the CFM module received CCMs from more remote endpoints than it can keep track of\[char46]
* **cfm_fault_status : override**: none  
  Indicates a CFM fault was manually triggered by an administrator using an **ovs-appctl** command\[char46]
* **cfm_fault_status : interval**: none  
  Indicates a CFM fault was triggered due to the reception of a CCM frame having an invalid interval\[char46]
* **cfm\_remote\_opstate**: optional string, either **down** or **up**  
  When in extended mode, indicates the operational state of the remote endpoint as either **up** or **down**\[char46] See **other\_config:cfm\_opstate**\[char46]
* **cfm\_health**: optional integer, in range 0 to 100  
  Indicates the health of the interface as a percentage of CCM frames received over 21 **other\_config:cfm\_interval**s\[char46] The health of an interface is undefined if it is communicating with more than one **cfm\_remote\_mpids**\[char46] It reduces if healthy heartbeats are not received at the expected rate, and gradually improves as healthy heartbeats are received at the desired rate\[char46] Every 21 **other\_config:cfm\_interval**s, the health of the interface is refreshed\[char46]
* As mentioned above, the faults can be triggered for several reasons\[char46] The link health will deteriorate even if heartbeats are received but they are reported to be unhealthy\[char46] An unhealthy heartbeat in this context is a heartbeat for which either some fault is set or is out of sequence\[char46] The interface health can be 100 only on receiving healthy heartbeats at the desired rate\[char46]
* **cfm\_remote\_mpids**: set of integers  
  When CFM is properly configured, Open vSwitch will occasionally receive CCM broadcasts\[char46] These broadcasts contain the MPID of the sending Maintenance Point\[char46] The list of MPIDs from which this **Interface** is receiving broadcasts from is regularly collected and written to this column\[char46]
* **other_config : cfm\_interval**: optional string, containing an integer  
  The interval, in milliseconds, between transmissions of CFM heartbeats\[char46] Three missed heartbeat receptions indicate a connectivity fault\[char46]
* In standard operation only intervals of 3, 10, 100, 1,000, 10,000, 60,000, or 600,000 ms are supported\[char46] Other values will be rounded down to the nearest value on the list\[char46] Extended mode (see **other\_config:cfm\_extended**) supports any interval up to 65,535 ms\[char46] In either mode, the default is 1000 ms\[char46]
* We do not recommend using intervals less than 100 ms\[char46]
* **other_config : cfm\_extended**: optional string, either **true** or **false**  
  When **true**, the CFM module operates in extended mode\[char46] This causes it to use a nonstandard destination address to avoid conflicting with compliant implementations which may be running concurrently on the network\[char46] Furthermore, extended mode increases the accuracy of the **cfm\_interval** configuration parameter by breaking wire compatibility with 802\[char46]1ag compliant implementations\[char46] And extended mode allows eight byte MPIDs\[char46] Defaults to **false**\[char46]
* **other_config : cfm\_demand**: optional string, either **true** or **false**  
  When **true**, and **other\_config:cfm\_extended** is true, the CFM module operates in demand mode\[char46] When in demand mode, traffic received on the **Interface** is used to indicate liveness\[char46] CCMs are still transmitted and received\[char46] At least one CCM must be received every 100 * **other\_config:cfm\_interval** amount of time\[char46] Otherwise, even if traffic are received, the CFM module will raise the connectivity fault\[char46]
* Demand mode has a couple of caveats:
    * ·  
      To ensure that ovs-vswitchd has enough time to pull statistics from the datapath, the fault detection interval is set to 3\[char46]5 * MAX(**other\_config:cfm\_interval**, 500) ms\[char46]
    * ·  
      To avoid ambiguity, demand mode disables itself when there are multiple remote maintenance points\[char46]
    * ·  
      If the **Interface** is heavily congested, CCMs containing the **other\_config:cfm\_opstate** status may be dropped causing changes in the operational state to be delayed\[char46] Similarly, if CCMs containing the RDI bit are not received, unidirectional link failures may not be detected\[char46]
* **other_config : cfm\_opstate**: optional string, either **down** or **up**  
  When **down**, the CFM module marks all CCMs it generates as operationally down without triggering a fault\[char46] This allows remote maintenance points to choose not to forward traffic to the **Interface** on which this CFM module is running\[char46] Currently, in Open vSwitch, the opdown bit of CCMs affects **Interface**s participating in bonds, and the bundle OpenFlow action\[char46] This setting is ignored when CFM is not in extended mode\[char46] Defaults to **up**\[char46]
* **other_config : cfm\_ccm\_vlan**: optional string, containing an integer, in range 1 to 4,095  
  When set, the CFM module will apply a VLAN tag to all CCMs it generates with the given value\[char46] May be the string **random** in which case each CCM will be tagged with a different randomly generated VLAN\[char46]
* **other_config : cfm\_ccm\_pcp**: optional string, containing an integer, in range 1 to 7  
  When set, the CFM module will apply a VLAN tag to all CCMs it generates with the given PCP value, the VLAN ID of the tag is governed by the value of **other\_config:cfm\_ccm\_vlan**\[char46] If **other\_config:cfm\_ccm\_vlan** is unset, a VLAN ID of zero is used\[char46]
  .ST "Bonding Configuration:"


* **other_config : lacp-port-id**: optional string, containing an integer, in range 1 to 65,535  
  The LACP port ID of this **Interface**\[char46] Port IDs are used in LACP negotiations to identify individual ports participating in a bond\[char46]
* **other_config : lacp-port-priority**: optional string, containing an integer, in range 1 to 65,535  
  The LACP port priority of this **Interface**\[char46] In LACP negotiations **Interface**s with numerically lower priorities are preferred for aggregation\[char46]
* **other_config : lacp-aggregation-key**: optional string, containing an integer, in range 1 to 65,535  
  The LACP aggregation key of this **Interface**\[char46] **Interface**s with different aggregation keys may not be active within a given **Port** at the same time\[char46]
  .ST "Virtual Machine Identifiers:"



These key-value pairs specifically apply to an interface that represents a virtual Ethernet interface connected to a virtual machine\[char46] These key-value pairs should not be present for other types of interfaces\[char46] Keys whose names end in **-uuid** have values that uniquely identify the entity in question\[char46] For a Citrix XenServer hypervisor, these values are UUIDs in RFC 4122 format\[char46] Other hypervisors may use other formats\[char46]

* **external_ids : attached-mac**: optional string  
  The MAC address programmed into the \`\`virtual hardware’’ for this interface, in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_\[char46] For Citrix XenServer, this is the value of the **MAC** field in the VIF record for this interface\[char46]
* **external_ids : iface-id**: optional string  
  A system-unique identifier for the interface\[char46] On XenServer, this will commonly be the same as **external\_ids:xs-vif-uuid**\[char46]
* **external_ids : iface-status**: optional string, either **active** or **inactive**  
  Hypervisors may sometimes have more than one interface associated with a given **external\_ids:iface-id**, only one of which is actually in use at a given time\[char46] For example, in some circumstances XenServer has both a \`\`tap’’ and a \`\`vif’’ interface for a single **external\_ids:iface-id**, but only uses one of them at a time\[char46] A hypervisor that behaves this way must mark the currently in use interface **active** and the others **inactive**\[char46] A hypervisor that never has more than one interface for a given **external\_ids:iface-id** may mark that interface **active** or omit **external\_ids:iface-status** entirely\[char46]
* During VM migration, a given **external\_ids:iface-id** might transiently be marked **active** on two different hypervisors\[char46] That is, **active** means that this **external\_ids:iface-id** is the active instance within a single hypervisor, not in a broader scope\[char46] There is one exception: some hypervisors support \`\`migration’’ from a given hypervisor to itself (most often for test purposes)\[char46] During such a \`\`migration,’’ two instances of a single **external\_ids:iface-id** might both be briefly marked **active** on a single hypervisor\[char46]
* **external_ids : xs-vif-uuid**: optional string  
  The virtual interface associated with this interface\[char46]
* **external_ids : xs-network-uuid**: optional string  
  The virtual network to which this interface is attached\[char46]
* **external_ids : vm-id**: optional string  
  The VM to which this interface belongs\[char46] On XenServer, this will be the same as **external\_ids:xs-vm-uuid**\[char46]
* **external_ids : xs-vm-uuid**: optional string  
  The VM to which this interface belongs\[char46]
  .ST "Auto Attach Configuration:"



Auto Attach configuration for a particular interface\[char46]

* **lldp : enable**: optional string, either **true** or **false**  
  True to enable LLDP on this **Interface**\[char46] If not specified, LLDP will be disabled by default\[char46]
  .ST "Flow control Configuration:"



Ethernet flow control defined in IEEE 802\[char46]1Qbb provides link level flow control using MAC pause frames\[char46] Implemented only for interfaces with type **dpdk**\[char46]

* **options : rx-flow-ctrl**: optional string, either **true** or **false**  
  Set to **true** to enable Rx flow control on physical ports\[char46] By default, Rx flow control is disabled\[char46]
* **options : tx-flow-ctrl**: optional string, either **true** or **false**  
  Set to **true** to enable Tx flow control on physical ports\[char46] By default, Tx flow control is disabled\[char46]
* **options : flow-ctrl-autoneg**: optional string, either **true** or **false**  
  Set to **true** to enable flow control auto negotiation on physical ports\[char46] By default, auto-neg is disabled\[char46]
  .ST "Link State Change detection mode:"


* **options : dpdk-lsc-interrupt**: optional string, either **true** or **false**  
  Set this value to **true** to configure interrupt mode for Link State Change (LSC) detection instead of poll mode for the DPDK interface\[char46]
* If this value is not set, poll mode is configured\[char46]
* This parameter has an effect only on netdev dpdk interfaces\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
* **external\_ids**: map of string-string pairs  
  .bp

<a name="flow_table-table"></a>

# Flow_table Table




Configuration for a particular OpenFlow table\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**name**
optional string
.TQ .25in
_Eviction Policy:_
.TQ 2.75in
**flow\_limit**
optional integer, at least 0
.TQ 2.75in
**overflow\_policy**
optional string, either **evict** or **refuse**
.TQ 2.75in
**groups**
set of strings
.TQ .25in
_Classifier Optimization:_
.TQ 2.75in
**prefixes**
set of up to 3 strings
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **name**: optional string  
  The table’s name\[char46] Set this column to change the name that controllers will receive when they request table statistics, e\[char46]g\[char46] ovs-ofctl
  dump-tables\[char46] The name does not affect switch behavior\[char46]
  .ST "Eviction Policy:"



Open vSwitch supports limiting the number of flows that may be installed in a flow table, via the **flow\_limit** column\[char46] When adding a flow would exceed this limit, by default Open vSwitch reports an error, but there are two ways to configure Open vSwitch to instead delete (\`\`evict’’) a flow to make room for the new one:

* ·  
  Set the **overflow\_policy** column to **evict**\[char46]
* ·  
  Send an OpenFlow 1\[char46]4+ \`\`table mod request’’ to enable eviction for the flow table (e\[char46]g\[char46] ovs-ofctl -O OpenFlow14 mod-table br0 0
  evict to enable eviction on flow table 0 of bridge **br0**)\[char46]


When a flow must be evicted due to overflow, the flow to evict is chosen through an approximation of the following algorithm\[char46] This algorithm is used regardless of how eviction was enabled:

* 1.  
  Divide the flows in the table into groups based on the values of the fields or subfields specified in the **groups** column, so that all of the flows in a given group have the same values for those fields\[char46] If a flow does not specify a given field, that field’s value is treated as 0\[char46] If **groups** is empty, then all of the flows in the flow table are treated as a single group\[char46]
* 2.  
  Consider the flows in the largest group, that is, the group that contains the greatest number of flows\[char46] If two or more groups all have the same largest number of flows, consider the flows in all of those groups\[char46]
* 3.  
  If the flows under consideration have different importance values, eliminate from consideration any flows except those with the lowest importance\[char46] (\`\`Importance,’’ a 16-bit integer value attached to each flow, was introduced in OpenFlow 1\[char46]4\[char46] Flows inserted with older versions of OpenFlow always have an importance of 0\[char46])
* 4.  
  Among the flows under consideration, choose the flow that expires soonest for eviction\[char46]


The eviction process only considers flows that have an idle timeout or a hard timeout\[char46] That is, eviction never deletes permanent flows\[char46] (Permanent flows do count against **flow\_limit**\[char46])

* **flow\_limit**: optional integer, at least 0  
  If set, limits the number of flows that may be added to the table\[char46] Open vSwitch may limit the number of flows in a table for other reasons, e\[char46]g\[char46] due to hardware limitations or for resource availability or performance reasons\[char46]
* **overflow\_policy**: optional string, either **evict** or **refuse**  
  Controls the switch’s behavior when an OpenFlow flow table modification request would add flows in excess of **flow\_limit**\[char46] The supported values are:
    * **refuse**  
      Refuse to add the flow or flows\[char46] This is also the default policy when **overflow\_policy** is unset\[char46]
    * **evict**  
      Delete a flow chosen according to the algorithm described above\[char46]
* **groups**: set of strings  
  When **overflow\_policy** is **evict**, this controls how flows are chosen for eviction when the flow table would otherwise exceed **flow\_limit** flows\[char46] Its value is a set of NXM fields or sub-fields, each of which takes one of the forms **field[]** or **field[start\[char46]\[char46]end]**, e\[char46]g\[char46] **NXM\_OF\_IN\_PORT[]**\[char46] Please see **meta-flow\[char46]h** for a complete list of NXM field names\[char46]
* Open vSwitch ignores any invalid or unknown field specifications\[char46]
* When eviction is not enabled, via **overflow\_policy** or an OpenFlow 1\[char46]4+ \`\`table mod,’’ this column has no effect\[char46]
  .ST "Classifier Optimization:"


* **prefixes**: set of up to 3 strings  
  This string set specifies which fields should be used for address prefix tracking\[char46] Prefix tracking allows the classifier to skip rules with longer than necessary prefixes, resulting in better wildcarding for datapath flows\[char46]
* Prefix tracking may be beneficial when a flow table contains matches on IP address fields with different prefix lengths\[char46] For example, when a flow table contains IP address matches on both full addresses and proper prefixes, the full address matches will typically cause the datapath flow to un-wildcard the whole address field (depending on flow entry priorities)\[char46] In this case each packet with a different address gets handed to the userspace for flow processing and generates its own datapath flow\[char46] With prefix tracking enabled for the address field in question packets with addresses matching shorter prefixes would generate datapath flows where the irrelevant address bits are wildcarded, allowing the same datapath flow to handle all the packets within the prefix in question\[char46] In this case many userspace upcalls can be avoided and the overall performance can be better\[char46]
* This is a performance optimization only, so packets will receive the same treatment with or without prefix tracking\[char46]
* The supported fields are: **tun\_id**, **tun\_src**, **tun\_dst**, **tun\_ipv6\_src**, **tun\_ipv6\_dst**, **nw\_src**, **nw\_dst** (or aliases **ip\_src** and **ip\_dst**), **ipv6\_src**, and **ipv6\_dst**\[char46] (Using this feature for **tun\_id** would only make sense if the tunnel IDs have prefix structure similar to IP addresses\[char46])
* By default, the **prefixes=ip\_dst,ip\_src** are used on each flow table\[char46] This instructs the flow classifier to track the IP destination and source addresses used by the rules in this specific flow table\[char46]
* The keyword **none** is recognized as an explicit override of the default values, causing no prefix fields to be tracked\[char46]
* To set the prefix fields, the flow table record needs to exist:
    * **ovs-vsctl set Bridge br0 flow_tables:0=@N1 -- --id=@N1 create Flow_Table name=table0**  
      Creates a flow table record for the OpenFlow table number 0\[char46]
    * **ovs-vsctl set Flow_Table table0 prefixes=ip\_dst,ip\_src**  
      Enables prefix tracking for IP source and destination address fields\[char46]
* There is a maximum number of fields that can be enabled for any one flow table\[char46] Currently this limit is 3\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
  .bp

<a name="qos-table"></a>

# Qos Table




Quality of Service (QoS) configuration for each Port that references it\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**type**
string
.TQ 3.00in
**queues**
map of integer-**Queue** pairs, key in range 0 to 4,294,967,295
.TQ .25in
_Configuration for linux-htb and linux-hfsc:_
.TQ 2.75in
**other_config : max-rate**
optional string, containing an integer
.TQ .25in
_Configuration for egress-policer QoS:_
.TQ 2.75in
**other_config : cir**
optional string, containing an integer
.TQ 2.75in
**other_config : cbs**
optional string, containing an integer
.TQ .25in
_Configuration for linux-sfq:_
.TQ 2.75in
**other_config : perturb**
optional string, containing an integer
.TQ 2.75in
**other_config : quantum**
optional string, containing an integer
.TQ .25in
_Common Columns:_
.TQ 2.75in
**other\_config**
map of string-string pairs
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **type**: string  
  The type of QoS to implement\[char46] The currently defined types are listed below:
    * **linux-htb**  
      Linux \`\`hierarchy token bucket’’ classifier\[char46] See tc-htb(8) (also at **http://linux\[char46]die\[char46]net/man/8/tc-htb**) and the HTB manual (**http://luxik\[char46]cdi\[char46]cz/~devik/qos/htb/manual/userg\[char46]htm**) for information on how this classifier works and how to configure it\[char46]
    * **linux-hfsc**  
      Linux "Hierarchical Fair Service Curve" classifier\[char46] See **http://linux-ip\[char46]net/articles/hfsc\[char46]en/** for information on how this classifier works\[char46]
    * **linux-sfq**  
      Linux \`\`Stochastic Fairness Queueing’’ classifier\[char46] See **tc-sfq**(8) (also at **http://linux\[char46]die\[char46]net/man/8/tc-sfq**) for information on how this classifier works\[char46]
    * **linux-codel**  
      Linux \`\`Controlled Delay’’ classifier\[char46] See **tc-codel**(8) (also at **http://man7\[char46]org/linux/man-pages/man8/tc-codel\[char46]8\[char46]html**) for information on how this classifier works\[char46]
    * **linux-fq\_codel**  
      Linux \`\`Fair Queuing with Controlled Delay’’ classifier\[char46] See **tc-fq\_codel**(8) (also at **http://man7\[char46]org/linux/man-pages/man8/tc-fq\_codel\[char46]8\[char46]html**) for information on how this classifier works\[char46]
    * **linux-noop**  
      Linux \`\`No operation\[char46]’’ By default, Open vSwitch manages quality of service on all of its configured ports\[char46] This can be helpful, but sometimes administrators prefer to use other software to manage QoS\[char46] This **type** prevents Open vSwitch from changing the QoS configuration for a port\[char46]
    * **egress-policer**  
      A DPDK egress policer algorithm using the DPDK rte_meter library\[char46] The rte_meter library provides an implementation which allows the metering and policing of traffic\[char46] The implementation in OVS essentially creates a single token bucket used to police traffic\[char46] It should be noted that when the rte_meter is configured as part of QoS there will be a performance overhead as the rte_meter itself will consume CPU cycles in order to police traffic\[char46] These CPU cycles ordinarily are used for packet proccessing\[char46] As such the drop in performance will be noticed in terms of overall aggregate traffic throughput\[char46]
* **queues**: map of integer-**Queue** pairs, key in range 0 to 4,294,967,295  
  A map from queue numbers to **Queue** records\[char46] The supported range of queue numbers depend on **type**\[char46] The queue numbers are the same as the **queue\_id** used in OpenFlow in **struct ofp\_action\_enqueue** and other structures\[char46]
* Queue 0 is the \`\`default queue\[char46]’’ It is used by OpenFlow output actions when no specific queue has been set\[char46] When no configuration for queue 0 is present, it is automatically configured as if a **Queue** record with empty **dscp** and **other\_config** columns had been specified\[char46] (Before version 1\[char46]6, Open vSwitch would leave queue 0 unconfigured in this case\[char46] With some queuing disciplines, this dropped all packets destined for the default queue\[char46])
  .ST "Configuration for linux-htb and linux-hfsc:"



The **linux-htb** and **linux-hfsc** classes support the following key-value pair:

* **other_config : max-rate**: optional string, containing an integer  
  Maximum rate shared by all queued traffic, in bit/s\[char46] Optional\[char46] If not specified, for physical interfaces, the default is the link rate\[char46] For other interfaces or if the link rate cannot be determined, the default is currently 100 Mbps\[char46]
  .ST "Configuration for egress-policer QoS:"



**QoS** **type** **egress-policer** provides egress policing for userspace port types with DPDK\[char46] It has the following key-value pairs defined\[char46]

* **other_config : cir**: optional string, containing an integer  
  The Committed Information Rate (CIR) is measured in bytes of IP packets per second, i\[char46]e\[char46] it includes the IP header, but not link specific (e\[char46]g\[char46] Ethernet) headers\[char46] This represents the bytes per second rate at which the token bucket will be updated\[char46] The cir value is calculated by (pps x packet data size)\[char46] For example assuming a user wishes to limit a stream consisting of 64 byte packets to 1 million packets per second the CIR would be set to to to 46000000\[char46] This value can be broken into ’1,000,000 x 46’\[char46] Where 1,000,000 is the policing rate for the number of packets per second and 46 represents the size of the packet data for a 64 byte ip packet\[char46]
* **other_config : cbs**: optional string, containing an integer  
  The Committed Burst Size (CBS) is measured in bytes and represents a token bucket\[char46] At a minimum this value should be be set to the expected largest size packet in the traffic stream\[char46] In practice larger values may be used to increase the size of the token bucket\[char46] If a packet can be transmitted then the cbs will be decremented by the number of bytes/tokens of the packet\[char46] If there are not enough tokens in the cbs bucket the packet will be dropped\[char46]
  .ST "Configuration for linux-sfq:"



The **linux-sfq** QoS supports the following key-value pairs:

* **other_config : perturb**: optional string, containing an integer  
  Number of seconds between consecutive perturbations in hashing algorithm\[char46] Different flows can end up in the same hash bucket causing unfairness\[char46] Perturbation’s goal is to remove possible unfairness\[char46] The default and recommended value is 10\[char46] Too low a value is discouraged because each perturbation can cause packet reordering\[char46]
* **other_config : quantum**: optional string, containing an integer  
  Number of bytes **linux-sfq** QoS can dequeue in one turn in round-robin from one flow\[char46] The default and recommended value is equal to interface’s MTU\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
* **external\_ids**: map of string-string pairs  
  .bp

<a name="queue-table"></a>

# Queue Table




A configuration for a port output queue, used in configuring Quality of Service (QoS) features\[char46] May be referenced by **queues** column in **QoS** table\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**dscp**
optional integer, in range 0 to 63
.TQ .25in
_Configuration for linux-htb QoS:_
.TQ 2.75in
**other_config : min-rate**
optional string, containing an integer, at least 1
.TQ 2.75in
**other_config : max-rate**
optional string, containing an integer, at least 1
.TQ 2.75in
**other_config : burst**
optional string, containing an integer, at least 1
.TQ 2.75in
**other_config : priority**
optional string, containing an integer, in range 0 to 4,294,967,295
.TQ .25in
_Configuration for linux-hfsc QoS:_
.TQ 2.75in
**other_config : min-rate**
optional string, containing an integer, at least 1
.TQ 2.75in
**other_config : max-rate**
optional string, containing an integer, at least 1
.TQ .25in
_Common Columns:_
.TQ 2.75in
**other\_config**
map of string-string pairs
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **dscp**: optional integer, in range 0 to 63  
  If set, Open vSwitch will mark all traffic egressing this **Queue** with the given DSCP bits\[char46] Traffic egressing the default **Queue** is only marked if it was explicitly selected as the **Queue** at the time the packet was output\[char46] If unset, the DSCP bits of traffic egressing this **Queue** will remain unchanged\[char46]
  .ST "Configuration for linux-htb QoS:"



**QoS** **type** **linux-htb** may use **queue\_id**s less than 61440\[char46] It has the following key-value pairs defined\[char46]

* **other_config : min-rate**: optional string, containing an integer, at least 1  
  Minimum guaranteed bandwidth, in bit/s\[char46]
* **other_config : max-rate**: optional string, containing an integer, at least 1  
  Maximum allowed bandwidth, in bit/s\[char46] Optional\[char46] If specified, the queue’s rate will not be allowed to exceed the specified value, even if excess bandwidth is available\[char46] If unspecified, defaults to no limit\[char46]
* **other_config : burst**: optional string, containing an integer, at least 1  
  Burst size, in bits\[char46] This is the maximum amount of \`\`credits’’ that a queue can accumulate while it is idle\[char46] Optional\[char46] Details of the **linux-htb** implementation require a minimum burst size, so a too-small **burst** will be silently ignored\[char46]
* **other_config : priority**: optional string, containing an integer, in range 0 to 4,294,967,295  
  A queue with a smaller **priority** will receive all the excess bandwidth that it can use before a queue with a larger value receives any\[char46] Specific priority values are unimportant; only relative ordering matters\[char46] Defaults to 0 if unspecified\[char46]
  .ST "Configuration for linux-hfsc QoS:"



**QoS** **type** **linux-hfsc** may use **queue\_id**s less than 61440\[char46] It has the following key-value pairs defined\[char46]

* **other_config : min-rate**: optional string, containing an integer, at least 1  
  Minimum guaranteed bandwidth, in bit/s\[char46]
* **other_config : max-rate**: optional string, containing an integer, at least 1  
  Maximum allowed bandwidth, in bit/s\[char46] Optional\[char46] If specified, the queue’s rate will not be allowed to exceed the specified value, even if excess bandwidth is available\[char46] If unspecified, defaults to no limit\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
* **external\_ids**: map of string-string pairs  
  .bp

<a name="mirror-table"></a>

# Mirror Table




A port mirror within a **Bridge**\[char46]


A port mirror configures a bridge to send selected frames to special \`\`mirrored’’ ports, in addition to their normal destinations\[char46] Mirroring traffic may also be referred to as SPAN or RSPAN, depending on how the mirrored traffic is sent\[char46]


When a packet enters an Open vSwitch bridge, it becomes eligible for mirroring based on its ingress port and VLAN\[char46] As the packet travels through the flow tables, each time it is output to a port, it becomes eligible for mirroring based on the egress port and VLAN\[char46] In Open vSwitch 2\[char46]5 and later, mirroring occurs just after a packet first becomes eligible, using the packet as it exists at that point; in Open vSwitch 2\[char46]4 and earlier, mirroring occurs only after a packet has traversed all the flow tables, using the original packet as it entered the bridge\[char46] This makes a difference only when the flow table modifies the packet: in Open vSwitch 2\[char46]4, the modifications are never visible to mirrors, whereas in Open vSwitch 2\[char46]5 and later modifications made before the first output that makes it eligible for mirroring to a particular destination are visible\[char46]


A packet that enters an Open vSwitch bridge is mirrored to a particular destination only once, even if it is eligible for multiple reasons\[char46] For example, a packet would be mirrored to a particular **output\_port** only once, even if it is selected for mirroring to that port by **select\_dst\_port** and **select\_src\_port** in the same or different **Mirror** records\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**name**
string
.TQ .25in
_Selecting Packets for Mirroring:_
.TQ 2.75in
**select\_all**
boolean
.TQ 2.75in
**select\_dst\_port**
set of weak reference to **Port**s
.TQ 2.75in
**select\_src\_port**
set of weak reference to **Port**s
.TQ 2.75in
**select\_vlan**
set of up to 4,096 integers, in range 0 to 4,095
.TQ .25in
_Mirroring Destination Configuration:_
.TQ 2.75in
**output\_port**
optional weak reference to **Port**
.TQ 2.75in
**output\_vlan**
optional integer, in range 1 to 4,095
.TQ 2.75in
**snaplen**
optional integer, in range 14 to 65,535
.TQ .25in
_Statistics: Mirror counters:_
.TQ 2.75in
**statistics : tx\_packets**
optional integer
.TQ 2.75in
**statistics : tx\_bytes**
optional integer
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **name**: string  
  Arbitrary identifier for the **Mirror**\[char46]
  .ST "Selecting Packets for Mirroring:"



To be selected for mirroring, a given packet must enter or leave the bridge through a selected port and it must also be in one of the selected VLANs\[char46]

* **select\_all**: boolean  
  If true, every packet arriving or departing on any port is selected for mirroring\[char46]
* **select\_dst\_port**: set of weak reference to **Port**s  
  Ports on which departing packets are selected for mirroring\[char46]
* **select\_src\_port**: set of weak reference to **Port**s  
  Ports on which arriving packets are selected for mirroring\[char46]
* **select\_vlan**: set of up to 4,096 integers, in range 0 to 4,095  
  VLANs on which packets are selected for mirroring\[char46] An empty set selects packets on all VLANs\[char46]
  .ST "Mirroring Destination Configuration:"



These columns are mutually exclusive\[char46] Exactly one of them must be nonempty\[char46]

* **output\_port**: optional weak reference to **Port**  
  Output port for selected packets, if nonempty\[char46]
* Specifying a port for mirror output reserves that port exclusively for mirroring\[char46] No frames other than those selected for mirroring via this column will be forwarded to the port, and any frames received on the port will be discarded\[char46]
* The output port may be any kind of port supported by Open vSwitch\[char46] It may be, for example, a physical port (sometimes called SPAN) or a GRE tunnel\[char46]
* **output\_vlan**: optional integer, in range 1 to 4,095  
  Output VLAN for selected packets, if nonempty\[char46]
* The frames will be sent out all ports that trunk **output\_vlan**, as well as any ports with implicit VLAN **output\_vlan**\[char46] When a mirrored frame is sent out a trunk port, the frame’s VLAN tag will be set to **output\_vlan**, replacing any existing tag; when it is sent out an implicit VLAN port, the frame will not be tagged\[char46] This type of mirroring is sometimes called RSPAN\[char46]
* See the documentation for **other\_config:forward-bpdu** in the **Interface** table for a list of destination MAC addresses which will not be mirrored to a VLAN to avoid confusing switches that interpret the protocols that they represent\[char46]
* **Please note:** Mirroring to a VLAN can disrupt a network that contains unmanaged switches\[char46] Consider an unmanaged physical switch with two ports: port 1, connected to an end host, and port 2, connected to an Open vSwitch configured to mirror received packets into VLAN 123 on port 2\[char46] Suppose that the end host sends a packet on port 1 that the physical switch forwards to port 2\[char46] The Open vSwitch forwards this packet to its destination and then reflects it back on port 2 in VLAN 123\[char46] This reflected packet causes the unmanaged physical switch to replace the MAC learning table entry, which correctly pointed to port 1, with one that incorrectly points to port 2\[char46] Afterward, the physical switch will direct packets destined for the end host to the Open vSwitch on port 2, instead of to the end host on port 1, disrupting connectivity\[char46] If mirroring to a VLAN is desired in this scenario, then the physical switch must be replaced by one that learns Ethernet addresses on a per-VLAN basis\[char46] In addition, learning should be disabled on the VLAN containing mirrored traffic\[char46] If this is not done then intermediate switches will learn the MAC address of each end host from the mirrored traffic\[char46] If packets being sent to that end host are also mirrored, then they will be dropped since the switch will attempt to send them out the input port\[char46] Disabling learning for the VLAN will cause the switch to correctly send the packet out all ports configured for that VLAN\[char46] If Open vSwitch is being used as an intermediate switch, learning can be disabled by adding the mirrored VLAN to **flood\_vlans** in the appropriate **Bridge** table or tables\[char46]
* Mirroring to a GRE tunnel has fewer caveats than mirroring to a VLAN and should generally be preferred\[char46]
* **snaplen**: optional integer, in range 14 to 65,535  
  Maximum per-packet number of bytes to mirror\[char46]
* A mirrored packet with size larger than **snaplen** will be truncated in datapath to **snaplen** bytes before sending to the mirror output port\[char46] If omitted, packets are not truncated\[char46]
  .ST "Statistics: Mirror counters:"



Key-value pairs that report mirror statistics\[char46] The update period is controlled by **other\_config:stats-update-interval** in the **Open\_vSwitch** table\[char46]

* **statistics : tx\_packets**: optional integer  
  Number of packets transmitted through this mirror\[char46]
* **statistics : tx\_bytes**: optional integer  
  Number of bytes transmitted through this mirror\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
  .bp

<a name="controller-table"></a>

# Controller Table




An OpenFlow controller\[char46]


Open vSwitch supports two kinds of OpenFlow controllers:

* Primary controllers  
  This is the kind of controller envisioned by the OpenFlow 1\[char46]0 specification\[char46] Usually, a primary controller implements a network policy by taking charge of the switch’s flow table\[char46]
* Open vSwitch initiates and maintains persistent connections to primary controllers, retrying the connection each time it fails or drops\[char46] The **fail\_mode** column in the **Bridge** table applies to primary controllers\[char46]
* Open vSwitch permits a bridge to have any number of primary controllers\[char46] When multiple controllers are configured, Open vSwitch connects to all of them simultaneously\[char46] Because OpenFlow 1\[char46]0 does not specify how multiple controllers coordinate in interacting with a single switch, more than one primary controller should be specified only if the controllers are themselves designed to coordinate with each other\[char46] (The Nicira-defined **NXT\_ROLE** OpenFlow vendor extension may be useful for this\[char46])
* Service controllers  
  These kinds of OpenFlow controller connections are intended for occasional support and maintenance use, e\[char46]g\[char46] with **ovs-ofctl**\[char46] Usually a service controller connects only briefly to inspect or modify some of a switch’s state\[char46]
* Open vSwitch listens for incoming connections from service controllers\[char46] The service controllers initiate and, if necessary, maintain the connections from their end\[char46] The **fail\_mode** column in the **Bridge** table does not apply to service controllers\[char46]
* Open vSwitch supports configuring any number of service controllers\[char46]


The **target** determines the type of controller\[char46]

<a name="summary"></a>

### "Summary:

.TQ .25in
_Core Features:_
.TQ 2.75in
**target**
string
.TQ 2.75in
**connection\_mode**
optional string, either **in-band** or **out-of-band**
.TQ .25in
_Controller Failure Detection and Handling:_
.TQ 2.75in
**max\_backoff**
optional integer, at least 1,000
.TQ 2.75in
**inactivity\_probe**
optional integer
.TQ .25in
_Asynchronous Messages:_
.TQ 2.75in
**enable\_async\_messages**
optional boolean
.TQ .25in
_Controller Rate Limiting:_
.TQ 2.50in
**controller\_rate\_limit**
optional integer, at least 100
.TQ 2.50in
**controller\_burst\_limit**
optional integer, at least 25
.TQ .25in
_Controller Rate Limiting Statistics:_
.TQ 2.25in
**status : packet-in-TYPE-bypassed**
optional string, containing an integer, at least 0
.TQ 2.25in
**status : packet-in-TYPE-queued**
optional string, containing an integer, at least 0
.TQ 2.25in
**status : packet-in-TYPE-dropped**
optional string, containing an integer, at least 0
.TQ 2.25in
**status : packet-in-TYPE-backlog**
optional string, containing an integer, at least 0
.TQ .25in
_Additional In-Band Configuration:_
.TQ 2.75in
**local\_ip**
optional string
.TQ 2.75in
**local\_netmask**
optional string
.TQ 2.75in
**local\_gateway**
optional string
.TQ .25in
_Controller Status:_
.TQ 2.75in
**is\_connected**
boolean
.TQ 2.75in
**role**
optional string, one of **master**, **other**, or **slave**
.TQ 2.75in
**status : last\_error**
optional string
.TQ 2.75in
**status : state**
optional string, one of **ACTIVE**, **BACKOFF**, **CONNECTING**, **IDLE**, or **VOID**
.TQ 2.75in
**status : sec\_since\_connect**
optional string, containing an integer, at least 0
.TQ 2.75in
**status : sec\_since\_disconnect**
optional string, containing an integer, at least 1
.TQ .25in
_Connection Parameters:_
.TQ 2.75in
**other_config : dscp**
optional string, containing an integer
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs
.TQ 2.75in
**other\_config**
map of string-string pairs

<a name="details"></a>

### "Details:

.ST "Core Features:"


* **target**: string  
  Connection method for controller\[char46]
* The following connection methods are currently supported for primary controllers:
    * **ssl:host**[**:port**]  
      The specified SSL _port_ on the host at the given _host_, which can either be a DNS name (if built with unbound library) or an IP address\[char46] The **ssl** column in the **Open\_vSwitch** table must point to a valid SSL configuration when this form is used\[char46]
    * If _port_ is not specified, it defaults to 6653\[char46]
    * SSL support is an optional feature that is not always built as part of Open vSwitch\[char46]
    * **tcp:host**[**:port**]  
      The specified TCP _port_ on the host at the given _host_, which can either be a DNS name (if built with unbound library) or an IP address (IPv4 or IPv6)\[char46] If _host_ is an IPv6 address, wrap it in square brackets, e\[char46]g\[char46] **tcp:[::1]:6653**\[char46]
    * If _port_ is not specified, it defaults to 6653\[char46]
* The following connection methods are currently supported for service controllers:
    * **pssl:**[_port_][**:host**]  
      Listens for SSL connections on the specified TCP _port_\[char46] If _host_, which can either be a DNS name (if built with unbound library) or an IP address, is specified, then connections are restricted to the resolved or specified local IP address (either IPv4 or IPv6)\[char46] If _host_ is an IPv6 address, wrap it in square brackets, e\[char46]g\[char46] **pssl:6653:[::1]**\[char46]
    * If _port_ is not specified, it defaults to 6653\[char46] If _host_ is not specified then it listens only on IPv4 (but not IPv6) addresses\[char46] The **ssl** column in the **Open\_vSwitch** table must point to a valid SSL configuration when this form is used\[char46]
    * If _port_ is not specified, it currently to 6653\[char46]
    * SSL support is an optional feature that is not always built as part of Open vSwitch\[char46]
    * **ptcp:**[_port_][**:host**]  
      Listens for connections on the specified TCP _port_\[char46] If _host_, which can either be a DNS name (if built with unbound library) or an IP address, is specified, then connections are restricted to the resolved or specified local IP address (either IPv4 or IPv6)\[char46] If _host_ is an IPv6 address, wrap it in square brackets, e\[char46]g\[char46] **ptcp:6653:[::1]**\[char46] If _host_ is not specified then it listens only on IPv4 addresses\[char46]
    * If _port_ is not specified, it defaults to 6653\[char46]
* When multiple controllers are configured for a single bridge, the **target** values must be unique\[char46] Duplicate **target** values yield unspecified results\[char46]
* **connection\_mode**: optional string, either **in-band** or **out-of-band**  
  If it is specified, this setting must be one of the following strings that describes how Open vSwitch contacts this OpenFlow controller over the network:
    * **in-band**  
      In this mode, this controller’s OpenFlow traffic travels over the bridge associated with the controller\[char46] With this setting, Open vSwitch allows traffic to and from the controller regardless of the contents of the OpenFlow flow table\[char46] (Otherwise, Open vSwitch would never be able to connect to the controller, because it did not have a flow to enable it\[char46]) This is the most common connection mode because it is not necessary to maintain two independent networks\[char46]
    * **out-of-band**  
      In this mode, OpenFlow traffic uses a control network separate from the bridge associated with this controller, that is, the bridge does not use any of its own network devices to communicate with the controller\[char46] The control network must be configured separately, before or after **ovs-vswitchd** is started\[char46]
* If not specified, the default is implementation-specific\[char46]
  .ST "Controller Failure Detection and Handling:"


* **max\_backoff**: optional integer, at least 1,000  
  Maximum number of milliseconds to wait between connection attempts\[char46] Default is implementation-specific\[char46]
* **inactivity\_probe**: optional integer  
  Maximum number of milliseconds of idle time on connection to controller before sending an inactivity probe message\[char46] If Open vSwitch does not communicate with the controller for the specified number of seconds, it will send a probe\[char46] If a response is not received for the same additional amount of time, Open vSwitch assumes the connection has been broken and attempts to reconnect\[char46] Default is implementation-specific\[char46] A value of 0 disables inactivity probes\[char46]
  .ST "Asynchronous Messages:"



OpenFlow switches send certain messages to controllers spontanenously, that is, not in response to any request from the controller\[char46] These messages are called \`\`asynchronous messages\[char46]’’ These columns allow asynchronous messages to be limited or disabled to ensure the best use of network resources\[char46]

* **enable\_async\_messages**: optional boolean  
  The OpenFlow protocol enables asynchronous messages at time of connection establishment, which means that a controller can receive asynchronous messages, potentially many of them, even if it turns them off immediately after connecting\[char46] Set this column to **false** to change Open vSwitch behavior to disable, by default, all asynchronous messages\[char46] The controller can use the **NXT\_SET\_ASYNC\_CONFIG** Nicira extension to OpenFlow to turn on any messages that it does want to receive, if any\[char46]
  .ST "Controller Rate Limiting:"



A switch can forward packets to a controller over the OpenFlow protocol\[char46] Forwarding packets this way at too high a rate can overwhelm a controller, frustrate use of the OpenFlow connection for other purposes, increase the latency of flow setup, and use an unreasonable amount of bandwidth\[char46] Therefore, Open vSwitch supports limiting the rate of packet forwarding to a controller\[char46]


There are two main reasons in OpenFlow for a packet to be sent to a controller: either the packet \`\`misses’’ in the flow table, that is, there is no matching flow, or a flow table action says to send the packet to the controller\[char46] Open vSwitch limits the rate of each kind of packet separately at the configured rate\[char46] Therefore, the actual rate that packets are sent to the controller can be up to twice the configured rate, when packets are sent for both reasons\[char46]


This feature is specific to forwarding packets over an OpenFlow connection\[char46] It is not general-purpose QoS\[char46] See the **QoS** table for quality of service configuration, and **ingress\_policing\_rate** in the **Interface** table for ingress policing configuration\[char46]

* **controller\_rate\_limit**: optional integer, at least 100  
  The maximum rate at which the switch will forward packets to the OpenFlow controller, in packets per second\[char46] If no value is specified, rate limiting is disabled\[char46]
* **controller\_burst\_limit**: optional integer, at least 25  
  When a high rate triggers rate-limiting, Open vSwitch queues packets to the controller for each port and transmits them to the controller at the configured rate\[char46] This value limits the number of queued packets\[char46] Ports on a bridge share the packet queue fairly\[char46]
* This value has no effect unless **controller\_rate\_limit** is configured\[char46] The current default when this value is not specified is one-quarter of **controller\_rate\_limit**, meaning that queuing can delay forwarding a packet to the controller by up to 250 ms\[char46]
  .ST "Controller Rate Limiting Statistics:"



These values report the effects of rate limiting\[char46] Their values are relative to establishment of the most recent OpenFlow connection, or since rate limiting was enabled, whichever happened more recently\[char46] Each consists of two values, one with **TYPE** replaced by **miss** for rate limiting flow table misses, and the other with **TYPE** replaced by **action** for rate limiting packets sent by OpenFlow actions\[char46]


These statistics are reported only when controller rate limiting is enabled\[char46]

* **status : packet-in-TYPE-bypassed**: optional string, containing an integer, at least 0  
  Number of packets sent directly to the controller, without queuing, because the rate did not exceed the configured maximum\[char46]
* **status : packet-in-TYPE-queued**: optional string, containing an integer, at least 0  
  Number of packets added to the queue to send later\[char46]
* **status : packet-in-TYPE-dropped**: optional string, containing an integer, at least 0  
  Number of packets added to the queue that were later dropped due to overflow\[char46] This value is less than or equal to **status:packet-in-TYPE-queued**\[char46]
* **status : packet-in-TYPE-backlog**: optional string, containing an integer, at least 0  
  Number of packets currently queued\[char46] The other statistics increase monotonically, but this one fluctuates between 0 and the **controller\_burst\_limit** as conditions change\[char46]
  .ST "Additional In-Band Configuration:"



These values are considered only in in-band control mode (see **connection\_mode**)\[char46]


When multiple controllers are configured on a single bridge, there should be only one set of unique values in these columns\[char46] If different values are set for these columns in different controllers, the effect is unspecified\[char46]

* **local\_ip**: optional string  
  The IP address to configure on the local port, e\[char46]g\[char46] **192\[char46]168\[char46]0\[char46]123**\[char46] If this value is unset, then **local\_netmask** and **local\_gateway** are ignored\[char46]
* **local\_netmask**: optional string  
  The IP netmask to configure on the local port, e\[char46]g\[char46] **255\[char46]255\[char46]255\[char46]0**\[char46] If **local\_ip** is set but this value is unset, then the default is chosen based on whether the IP address is class A, B, or C\[char46]
* **local\_gateway**: optional string  
  The IP address of the gateway to configure on the local port, as a string, e\[char46]g\[char46] **192\[char46]168\[char46]0\[char46]1**\[char46] Leave this column unset if this network has no gateway\[char46]
  .ST "Controller Status:"


* **is\_connected**: boolean  
  **true** if currently connected to this controller, **false** otherwise\[char46]
* **role**: optional string, one of **master**, **other**, or **slave**  
  The level of authority this controller has on the associated bridge\[char46] Possible values are:
    * **other**  
      Allows the controller access to all OpenFlow features\[char46]
    * **master**  
      Equivalent to **other**, except that there may be at most one master controller at a time\[char46] When a controller configures itself as **master**, any existing master is demoted to the **slave** role\[char46]
    * **slave**  
      Allows the controller read-only access to OpenFlow features\[char46] Attempts to modify the flow table will be rejected with an error\[char46] Slave controllers do not receive OFPT_PACKET_IN or OFPT_FLOW_REMOVED messages, but they do receive OFPT_PORT_STATUS messages\[char46]
* **status : last\_error**: optional string  
  A human-readable description of the last error on the connection to the controller; i\[char46]e\[char46] **strerror(errno)**\[char46] This key will exist only if an error has occurred\[char46]
* **status : state**: optional string, one of **ACTIVE**, **BACKOFF**, **CONNECTING**, **IDLE**, or **VOID**  
  The state of the connection to the controller:
    * **VOID**  
      Connection is disabled\[char46]
    * **BACKOFF**  
      Attempting to reconnect at an increasing period\[char46]
    * **CONNECTING**  
      Attempting to connect\[char46]
    * **ACTIVE**  
      Connected, remote host responsive\[char46]
    * **IDLE**  
      Connection is idle\[char46] Waiting for response to keep-alive\[char46]
* These values may change in the future\[char46] They are provided only for human consumption\[char46]
* **status : sec\_since\_connect**: optional string, containing an integer, at least 0  
  The amount of time since this controller last successfully connected to the switch (in seconds)\[char46] Value is empty if controller has never successfully connected\[char46]
* **status : sec\_since\_disconnect**: optional string, containing an integer, at least 1  
  The amount of time since this controller last disconnected from the switch (in seconds)\[char46] Value is empty if controller has never disconnected\[char46]
  .ST "Connection Parameters:"



Additional configuration for a connection between the controller and the Open vSwitch\[char46]

* **other_config : dscp**: optional string, containing an integer  
  The Differentiated Service Code Point (DSCP) is specified using 6 bits in the Type of Service (TOS) field in the IP header\[char46] DSCP provides a mechanism to classify the network traffic and provide Quality of Service (QoS) on IP networks\[char46] The DSCP value specified here is used when establishing the connection between the controller and the Open vSwitch\[char46] If no value is specified, a default value of 48 is chosen\[char46] Valid DSCP values must be in the range 0 to 63\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
* **other\_config**: map of string-string pairs  
  .bp

<a name="manager-table"></a>

# Manager Table




Configuration for a database connection to an Open vSwitch database (OVSDB) client\[char46]


This table primarily configures the Open vSwitch database (**ovsdb-server**), not the Open vSwitch switch (**ovs-vswitchd**)\[char46] The switch does read the table to determine what connections should be treated as in-band\[char46]


The Open vSwitch database server can initiate and maintain active connections to remote clients\[char46] It can also listen for database connections\[char46]

<a name="summary"></a>

### "Summary:

.TQ .25in
_Core Features:_
.TQ 2.75in
**target**
string (must be unique within table)
.TQ 2.75in
**connection\_mode**
optional string, either **in-band** or **out-of-band**
.TQ .25in
_Client Failure Detection and Handling:_
.TQ 2.75in
**max\_backoff**
optional integer, at least 1,000
.TQ 2.75in
**inactivity\_probe**
optional integer
.TQ .25in
_Status:_
.TQ 2.75in
**is\_connected**
boolean
.TQ 2.75in
**status : last\_error**
optional string
.TQ 2.75in
**status : state**
optional string, one of **ACTIVE**, **BACKOFF**, **CONNECTING**, **IDLE**, or **VOID**
.TQ 2.75in
**status : sec\_since\_connect**
optional string, containing an integer, at least 0
.TQ 2.75in
**status : sec\_since\_disconnect**
optional string, containing an integer, at least 0
.TQ 2.75in
**status : locks\_held**
optional string
.TQ 2.75in
**status : locks\_waiting**
optional string
.TQ 2.75in
**status : locks\_lost**
optional string
.TQ 2.75in
**status : n\_connections**
optional string, containing an integer, at least 2
.TQ 2.75in
**status : bound\_port**
optional string, containing an integer
.TQ .25in
_Connection Parameters:_
.TQ 2.75in
**other_config : dscp**
optional string, containing an integer
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs
.TQ 2.75in
**other\_config**
map of string-string pairs

<a name="details"></a>

### "Details:

.ST "Core Features:"


* **target**: string (must be unique within table)  
  Connection method for managers\[char46]
* The following connection methods are currently supported:
    * **ssl:host**[**:port**]  
      The specified SSL _port_ on the host at the given _host_, which can either be a DNS name (if built with unbound library) or an IP address\[char46] The **ssl** column in the **Open\_vSwitch** table must point to a valid SSL configuration when this form is used\[char46]
    * If _port_ is not specified, it defaults to 6640\[char46]
    * SSL support is an optional feature that is not always built as part of Open vSwitch\[char46]
    * **tcp:host**[**:port**]  
      The specified TCP _port_ on the host at the given _host_, which can either be a DNS name (if built with unbound library) or an IP address (IPv4 or IPv6)\[char46] If _host_ is an IPv6 address, wrap it in square brackets, e\[char46]g\[char46] **tcp:[::1]:6640**\[char46]
    * If _port_ is not specified, it defaults to 6640\[char46]
    * **pssl:**[_port_][**:host**]  
      Listens for SSL connections on the specified TCP _port_\[char46] Specify 0 for _port_ to have the kernel automatically choose an available port\[char46] If _host_, which can either be a DNS name (if built with unbound library) or an IP address, is specified, then connections are restricted to the resolved or specified local IP address (either IPv4 or IPv6 address)\[char46] If _host_ is an IPv6 address, wrap in square brackets, e\[char46]g\[char46] **pssl:6640:[::1]**\[char46] If _host_ is not specified then it listens only on IPv4 (but not IPv6) addresses\[char46] The **ssl** column in the **Open\_vSwitch** table must point to a valid SSL configuration when this form is used\[char46]
    * If _port_ is not specified, it defaults to 6640\[char46]
    * SSL support is an optional feature that is not always built as part of Open vSwitch\[char46]
    * **ptcp:**[_port_][**:host**]  
      Listens for connections on the specified TCP _port_\[char46] Specify 0 for _port_ to have the kernel automatically choose an available port\[char46] If _host_, which can either be a DNS name (if built with unbound library) or an IP address, is specified, then connections are restricted to the resolved or specified local IP address (either IPv4 or IPv6 address)\[char46] If _host_ is an IPv6 address, wrap it in square brackets, e\[char46]g\[char46] **ptcp:6640:[::1]**\[char46] If _host_ is not specified then it listens only on IPv4 addresses\[char46]
    * If _port_ is not specified, it defaults to 6640\[char46]
* When multiple managers are configured, the **target** values must be unique\[char46] Duplicate **target** values yield unspecified results\[char46]
* **connection\_mode**: optional string, either **in-band** or **out-of-band**  
  If it is specified, this setting must be one of the following strings that describes how Open vSwitch contacts this OVSDB client over the network:
    * **in-band**  
      In this mode, this connection’s traffic travels over a bridge managed by Open vSwitch\[char46] With this setting, Open vSwitch allows traffic to and from the client regardless of the contents of the OpenFlow flow table\[char46] (Otherwise, Open vSwitch would never be able to connect to the client, because it did not have a flow to enable it\[char46]) This is the most common connection mode because it is not necessary to maintain two independent networks\[char46]
    * **out-of-band**  
      In this mode, the client’s traffic uses a control network separate from that managed by Open vSwitch, that is, Open vSwitch does not use any of its own network devices to communicate with the client\[char46] The control network must be configured separately, before or after **ovs-vswitchd** is started\[char46]
* If not specified, the default is implementation-specific\[char46]
  .ST "Client Failure Detection and Handling:"


* **max\_backoff**: optional integer, at least 1,000  
  Maximum number of milliseconds to wait between connection attempts\[char46] Default is implementation-specific\[char46]
* **inactivity\_probe**: optional integer  
  Maximum number of milliseconds of idle time on connection to the client before sending an inactivity probe message\[char46] If Open vSwitch does not communicate with the client for the specified number of seconds, it will send a probe\[char46] If a response is not received for the same additional amount of time, Open vSwitch assumes the connection has been broken and attempts to reconnect\[char46] Default is implementation-specific\[char46] A value of 0 disables inactivity probes\[char46]
  .ST "Status:"



Key-value pair of **is\_connected** is always updated\[char46] Other key-value pairs in the status columns may be updated depends on the **target** type\[char46]


When **target** specifies a connection method that listens for inbound connections (e\[char46]g\[char46] **ptcp:** or **punix:**), both **n\_connections** and **is\_connected** may also be updated while the remaining key-value pairs are omitted\[char46]


On the other hand, when **target** specifies an outbound connection, all key-value pairs may be updated, except the above-mentioned two key-value pairs associated with inbound connection targets\[char46] They are omitted\[char46]

* **is\_connected**: boolean  
  **true** if currently connected to this manager, **false** otherwise\[char46]
* **status : last\_error**: optional string  
  A human-readable description of the last error on the connection to the manager; i\[char46]e\[char46] **strerror(errno)**\[char46] This key will exist only if an error has occurred\[char46]
* **status : state**: optional string, one of **ACTIVE**, **BACKOFF**, **CONNECTING**, **IDLE**, or **VOID**  
  The state of the connection to the manager:
    * **VOID**  
      Connection is disabled\[char46]
    * **BACKOFF**  
      Attempting to reconnect at an increasing period\[char46]
    * **CONNECTING**  
      Attempting to connect\[char46]
    * **ACTIVE**  
      Connected, remote host responsive\[char46]
    * **IDLE**  
      Connection is idle\[char46] Waiting for response to keep-alive\[char46]
* These values may change in the future\[char46] They are provided only for human consumption\[char46]
* **status : sec\_since\_connect**: optional string, containing an integer, at least 0  
  The amount of time since this manager last successfully connected to the database (in seconds)\[char46] Value is empty if manager has never successfully connected\[char46]
* **status : sec\_since\_disconnect**: optional string, containing an integer, at least 0  
  The amount of time since this manager last disconnected from the database (in seconds)\[char46] Value is empty if manager has never disconnected\[char46]
* **status : locks\_held**: optional string  
  Space-separated list of the names of OVSDB locks that the connection holds\[char46] Omitted if the connection does not hold any locks\[char46]
* **status : locks\_waiting**: optional string  
  Space-separated list of the names of OVSDB locks that the connection is currently waiting to acquire\[char46] Omitted if the connection is not waiting for any locks\[char46]
* **status : locks\_lost**: optional string  
  Space-separated list of the names of OVSDB locks that the connection has had stolen by another OVSDB client\[char46] Omitted if no locks have been stolen from this connection\[char46]
* **status : n\_connections**: optional string, containing an integer, at least 2  
  When **target** specifies a connection method that listens for inbound connections (e\[char46]g\[char46] **ptcp:** or **pssl:**) and more than one connection is actually active, the value is the number of active connections\[char46] Otherwise, this key-value pair is omitted\[char46]
* **status : bound\_port**: optional string, containing an integer  
  When **target** is **ptcp:** or **pssl:**, this is the TCP port on which the OVSDB server is listening\[char46] (This is particularly useful when **target** specifies a port of 0, allowing the kernel to choose any available port\[char46])
  .ST "Connection Parameters:"



Additional configuration for a connection between the manager and the Open vSwitch Database\[char46]

* **other_config : dscp**: optional string, containing an integer  
  The Differentiated Service Code Point (DSCP) is specified using 6 bits in the Type of Service (TOS) field in the IP header\[char46] DSCP provides a mechanism to classify the network traffic and provide Quality of Service (QoS) on IP networks\[char46] The DSCP value specified here is used when establishing the connection between the manager and the Open vSwitch\[char46] If no value is specified, a default value of 48 is chosen\[char46] Valid DSCP values must be in the range 0 to 63\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
* **other\_config**: map of string-string pairs  
  .bp

<a name="netflow-table"></a>

# Netflow Table


A NetFlow target\[char46] NetFlow is a protocol that exports a number of details about terminating IP flows, such as the principals involved and duration\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**targets**
set of 1 or more strings
.TQ 3.00in
**engine\_id**
optional integer, in range 0 to 255
.TQ 3.00in
**engine\_type**
optional integer, in range 0 to 255
.TQ 3.00in
**active\_timeout**
integer, at least -1
.TQ 3.00in
**add\_id\_to\_interface**
boolean
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **targets**: set of 1 or more strings  
  NetFlow targets in the form **_ip:port**\[char46] The ip_ must be specified numerically, not as a DNS name\[char46]
* **engine\_id**: optional integer, in range 0 to 255  
  Engine ID to use in NetFlow messages\[char46] Defaults to datapath index if not specified\[char46]
* **engine\_type**: optional integer, in range 0 to 255  
  Engine type to use in NetFlow messages\[char46] Defaults to datapath index if not specified\[char46]
* **active\_timeout**: integer, at least -1  
  The interval at which NetFlow records are sent for flows that are still active, in seconds\[char46] A value of **0** requests the default timeout (currently 600 seconds); a value of **-1** disables active timeouts\[char46]
* The NetFlow passive timeout, for flows that become inactive, is not configurable\[char46] It will vary depending on the Open vSwitch version, the forms and contents of the OpenFlow flow tables, CPU and memory usage, and network activity\[char46] A typical passive timeout is about a second\[char46]
* **add\_id\_to\_interface**: boolean  
  If this column’s value is **false**, the ingress and egress interface fields of NetFlow flow records are derived from OpenFlow port numbers\[char46] When it is **true**, the 7 most significant bits of these fields will be replaced by the least significant 7 bits of the engine id\[char46] This is useful because many NetFlow collectors do not expect multiple switches to be sending messages from the same host, so they do not store the engine information which could be used to disambiguate the traffic\[char46]
* When this option is enabled, a maximum of 508 ports are supported\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
  .bp

<a name="ssl-table"></a>

# Ssl Table


SSL configuration for an Open_vSwitch\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**private\_key**
string
.TQ 3.00in
**certificate**
string
.TQ 3.00in
**ca\_cert**
string
.TQ 3.00in
**bootstrap\_ca\_cert**
boolean
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **private\_key**: string  
  Name of a PEM file containing the private key used as the switch’s identity for SSL connections to the controller\[char46]
* **certificate**: string  
  Name of a PEM file containing a certificate, signed by the certificate authority (CA) used by the controller and manager, that certifies the switch’s private key, identifying a trustworthy switch\[char46]
* **ca\_cert**: string  
  Name of a PEM file containing the CA certificate used to verify that the switch is connected to a trustworthy controller\[char46]
* **bootstrap\_ca\_cert**: boolean  
  If set to **true**, then Open vSwitch will attempt to obtain the CA certificate from the controller on its first SSL connection and save it to the named PEM file\[char46] If it is successful, it will immediately drop the connection and reconnect, and from then on all SSL connections must be authenticated by a certificate signed by the CA certificate thus obtained\[char46] This option exposes the
  SSL connection to a man-in-the-middle attack obtaining the initial
  CA certificate\[char46] It may still be useful for bootstrapping\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
  .bp

<a name="sflow-table"></a>

# Sflow Table




A set of sFlow(R) targets\[char46] sFlow is a protocol for remote monitoring of switches\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**agent**
optional string
.TQ 3.00in
**header**
optional integer
.TQ 3.00in
**polling**
optional integer
.TQ 3.00in
**sampling**
optional integer
.TQ 3.00in
**targets**
set of 1 or more strings
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **agent**: optional string  
  Determines the agent address, that is, the IP address reported to collectors as the source of the sFlow data\[char46] It may be an IP address or the name of a network device\[char46] In the latter case, the network device’s IP address is used,
* If not specified, the agent device is figured from the first target address and the routing table\[char46] If the routing table does not contain a route to the target, the IP address defaults to the **local\_ip** in the collector’s **Controller**\[char46]
* If an agent IP address cannot be determined, sFlow is disabled\[char46]
* **header**: optional integer  
  Number of bytes of a sampled packet to send to the collector\[char46] If not specified, the default is 128 bytes\[char46]
* **polling**: optional integer  
  Polling rate in seconds to send port statistics to the collector\[char46] If not specified, defaults to 30 seconds\[char46]
* **sampling**: optional integer  
  Rate at which packets should be sampled and sent to the collector\[char46] If not specified, defaults to 400, which means one out of 400 packets, on average, will be sent to the collector\[char46]
* **targets**: set of 1 or more strings  
  sFlow targets in the form **ip:port**\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
  .bp

<a name="ipfix-table"></a>

# Ipfix Table




Configuration for sending packets to IPFIX collectors\[char46]


IPFIX is a protocol that exports a number of details about flows\[char46] The IPFIX implementation in Open vSwitch samples packets at a configurable rate, extracts flow information from those packets, optionally caches and aggregates the flow information, and sends the result to one or more collectors\[char46]


IPFIX in Open vSwitch can be configured two different ways:

* ·  
  With **per-bridge sampling**, Open vSwitch performs IPFIX sampling automatically on all packets that pass through a bridge\[char46] To configure per-bridge sampling, create an **IPFIX** record and point a **Bridge** table’s **ipfix** column to it\[char46] The **Flow\_Sample\_Collector\_Set** table is not used for per-bridge sampling\[char46]
* ·  
  With **flow-based sampling**, **sample** actions in the OpenFlow flow table drive IPFIX sampling\[char46] See **ovs-ofctl**(8) for a description of the **sample** action\[char46]
* Flow-based sampling also requires database configuration: create a **IPFIX** record that describes the IPFIX configuration and a **Flow\_Sample\_Collector\_Set** record that points to the **Bridge** whose flow table holds the **sample** actions and to **IPFIX** record\[char46] The **ipfix** in the **Bridge** table is not used for flow-based sampling\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**targets**
set of strings
.TQ 3.00in
**cache\_active\_timeout**
optional integer, in range 0 to 4,200
.TQ 3.00in
**cache\_max\_flows**
optional integer, in range 0 to 4,294,967,295
.TQ 3.00in
**other_config : enable-tunnel-sampling**
optional string, either **true** or **false**
.TQ 3.00in
**other_config : virtual\_obs\_id**
optional string
.TQ .25in
_Per-Bridge Sampling:_
.TQ 2.75in
**sampling**
optional integer, in range 1 to 4,294,967,295
.TQ 2.75in
**obs\_domain\_id**
optional integer, in range 0 to 4,294,967,295
.TQ 2.75in
**obs\_point\_id**
optional integer, in range 0 to 4,294,967,295
.TQ 2.75in
**other_config : enable-input-sampling**
optional string, either **true** or **false**
.TQ 2.75in
**other_config : enable-output-sampling**
optional string, either **true** or **false**
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **targets**: set of strings  
  IPFIX target collectors in the form **ip:port**\[char46]
* **cache\_active\_timeout**: optional integer, in range 0 to 4,200  
  The maximum period in seconds for which an IPFIX flow record is cached and aggregated before being sent\[char46] If not specified, defaults to 0\[char46] If 0, caching is disabled\[char46]
* **cache\_max\_flows**: optional integer, in range 0 to 4,294,967,295  
  The maximum number of IPFIX flow records that can be cached at a time\[char46] If not specified, defaults to 0\[char46] If 0, caching is disabled\[char46]
* **other_config : enable-tunnel-sampling**: optional string, either **true** or **false**  
  Set to **true** to enable sampling and reporting tunnel header 7-tuples in IPFIX flow records\[char46] Tunnel sampling is enabled by default\[char46]
* The following enterprise entities report the sampled tunnel info:
    * tunnelType:  
      ID: 891, and enterprise ID 6876 (VMware)\[char46]
    * type: unsigned 8-bit integer\[char46]
    * data type semantics: identifier\[char46]
    * description: Identifier of the layer 2 network overlay network encapsulation type: 0x01 VxLAN, 0x02 GRE, 0x03 LISP, 0x07 GENEVE\[char46]
    * tunnelKey:  
      ID: 892, and enterprise ID 6876 (VMware)\[char46]
    * type: variable-length octetarray\[char46]
    * data type semantics: identifier\[char46]
    * description: Key which is used for identifying an individual traffic flow within a VxLAN (24-bit VNI), GENEVE (24-bit VNI), GRE (32-bit key), or LISP (24-bit instance ID) tunnel\[char46] The key is encoded in this octetarray as a 3-, 4-, or 8-byte integer ID in network byte order\[char46]
    * tunnelSourceIPv4Address:  
      ID: 893, and enterprise ID 6876 (VMware)\[char46]
    * type: unsigned 32-bit integer\[char46]
    * data type semantics: identifier\[char46]
    * description: The IPv4 source address in the tunnel IP packet header\[char46]
    * tunnelDestinationIPv4Address:  
      ID: 894, and enterprise ID 6876 (VMware)\[char46]
    * type: unsigned 32-bit integer\[char46]
    * data type semantics: identifier\[char46]
    * description: The IPv4 destination address in the tunnel IP packet header\[char46]
    * tunnelProtocolIdentifier:  
      ID: 895, and enterprise ID 6876 (VMware)\[char46]
    * type: unsigned 8-bit integer\[char46]
    * data type semantics: identifier\[char46]
    * description: The value of the protocol number in the tunnel IP packet header\[char46] The protocol number identifies the tunnel IP packet payload type\[char46]
    * tunnelSourceTransportPort:  
      ID: 896, and enterprise ID 6876 (VMware)\[char46]
    * type: unsigned 16-bit integer\[char46]
    * data type semantics: identifier\[char46]
    * description: The source port identifier in the tunnel transport header\[char46] For the transport protocols UDP, TCP, and SCTP, this is the source port number given in the respective header\[char46]
    * tunnelDestinationTransportPort:  
      ID: 897, and enterprise ID 6876 (VMware)\[char46]
    * type: unsigned 16-bit integer\[char46]
    * data type semantics: identifier\[char46]
    * description: The destination port identifier in the tunnel transport header\[char46] For the transport protocols UDP, TCP, and SCTP, this is the destination port number given in the respective header\[char46]
* Before Open vSwitch 2\[char46]5\[char46]90, **other\_config:enable-tunnel-sampling** was only supported with per-bridge sampling, and ignored otherwise\[char46] Open vSwitch 2\[char46]5\[char46]90 and later support **other\_config:enable-tunnel-sampling** for per-bridge and per-flow sampling\[char46]
* **other_config : virtual\_obs\_id**: optional string  
  A string that accompanies each IPFIX flow record\[char46] Its intended use is for the \`\`virtual observation ID,’’ an identifier of a virtual observation point that is locally unique in a virtual network\[char46] It describes a location in the virtual network where IP packets can be observed\[char46] The maximum length is 254 bytes\[char46] If not specified, the field is omitted from the IPFIX flow record\[char46]
* The following enterprise entity reports the specified virtual observation ID:
    * virtualObsID:  
      ID: 898, and enterprise ID 6876 (VMware)\[char46]
    * type: variable-length string\[char46]
    * data type semantics: identifier\[char46]
    * description: A virtual observation domain ID that is locally unique in a virtual network\[char46]
* This feature was introduced in Open vSwitch 2\[char46]5\[char46]90\[char46]
  .ST "Per-Bridge Sampling:"



These values affect only per-bridge sampling\[char46] See above for a description of the differences between per-bridge and flow-based sampling\[char46]

* **sampling**: optional integer, in range 1 to 4,294,967,295  
  The rate at which packets should be sampled and sent to each target collector\[char46] If not specified, defaults to 400, which means one out of 400 packets, on average, will be sent to each target collector\[char46]
* **obs\_domain\_id**: optional integer, in range 0 to 4,294,967,295  
  The IPFIX Observation Domain ID sent in each IPFIX packet\[char46] If not specified, defaults to 0\[char46]
* **obs\_point\_id**: optional integer, in range 0 to 4,294,967,295  
  The IPFIX Observation Point ID sent in each IPFIX flow record\[char46] If not specified, defaults to 0\[char46]
* **other_config : enable-input-sampling**: optional string, either **true** or **false**  
  By default, Open vSwitch samples and reports flows at bridge port input in IPFIX flow records\[char46] Set this column to **false** to disable input sampling\[char46]
* **other_config : enable-output-sampling**: optional string, either **true** or **false**  
  By default, Open vSwitch samples and reports flows at bridge port output in IPFIX flow records\[char46] Set this column to **false** to disable output sampling\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
  .bp

<a name="flow_sample_collector_set-table"></a>

# Flow_sample_collector_set Table




A set of IPFIX collectors of packet samples generated by OpenFlow **sample** actions\[char46] This table is used only for IPFIX flow-based sampling, not for per-bridge sampling (see the **IPFIX** table for a description of the two forms)\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**id**
integer, in range 0 to 4,294,967,295
.TQ 3.00in
**bridge**
**Bridge**
.TQ 3.00in
**ipfix**
optional **IPFIX**
.TQ .25in
_Common Columns:_
.TQ 2.75in
**external\_ids**
map of string-string pairs

<a name="details"></a>

### "Details:


* **id**: integer, in range 0 to 4,294,967,295  
  The ID of this collector set, unique among the bridge’s collector sets, to be used as the **collector\_set\_id** in OpenFlow **sample** actions\[char46]
* **bridge**: **Bridge**  
  The bridge into which OpenFlow **sample** actions can be added to send packet samples to this set of IPFIX collectors\[char46]
* **ipfix**: optional **IPFIX**  
  Configuration of the set of IPFIX collectors to send one flow record per sampled packet to\[char46]
  .ST "Common Columns:"

The overall purpose of these columns is described under Common
Columns at the beginning of this document\[char46]

* **external\_ids**: map of string-string pairs  
  .bp

<a name="autoattach-table"></a>

# Autoattach Table




Auto Attach configuration within a bridge\[char46] The IETF Auto-Attach SPBM draft standard describes a compact method of using IEEE 802\[char46]1AB Link Layer Discovery Protocol (LLDP) together with a IEEE 802\[char46]1aq Shortest Path Bridging (SPB) network to automatically attach network devices to individual services in a SPB network\[char46] The intent here is to allow network applications and devices using OVS to be able to easily take advantage of features offered by industry standard SPB networks\[char46]


Auto Attach (AA) uses LLDP to communicate between a directly connected Auto Attach Client (AAC) and Auto Attach Server (AAS)\[char46] The LLDP protocol is extended to add two new Type-Length-Value tuples (TLVs)\[char46] The first new TLV supports the ongoing discovery of directly connected AA correspondents\[char46] Auto Attach operates by regularly transmitting AA discovery TLVs between the AA client and AA server\[char46] By exchanging these discovery messages, both the AAC and AAS learn the system name and system description of their peer\[char46] In the OVS context, OVS operates as the AA client and the AA server resides on a switch at the edge of the SPB network\[char46]


Once AA discovery has been completed the AAC then uses the second new TLV to deliver identifier mappings from the AAC to the AAS\[char46] A primary feature of Auto Attach is to facilitate the mapping of VLANs defined outside the SPB network onto service ids (ISIDs) defined within the SPM network\[char46] By doing so individual external VLANs can be mapped onto specific SPB network services\[char46] These VLAN id to ISID mappings can be configured and managed locally using new options added to the ovs-vsctl command\[char46]


The Auto Attach OVS feature does not provide a full implementation of the LLDP protocol\[char46] Support for the mandatory TLVs as defined by the LLDP standard and support for the AA TLV extensions is provided\[char46] LLDP protocol support in OVS can be enabled or disabled on a port by port basis\[char46] LLDP support is disabled by default\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**system\_name**
string
.TQ 3.00in
**system\_description**
string
.TQ 3.00in
**mappings**
map of integer-integer pairs, key in range 0 to 16,777,215, value in range 0 to 4,095

<a name="details"></a>

### "Details:


* **system\_name**: string  
  The system_name string is exported in LLDP messages\[char46] It should uniquely identify the bridge in the network\[char46]
* **system\_description**: string  
  The system_description string is exported in LLDP messages\[char46] It should describe the type of software and hardware\[char46]
* **mappings**: map of integer-integer pairs, key in range 0 to 16,777,215, value in range 0 to 4,095  
  A mapping from SPB network Individual Service Identifier (ISID) to VLAN id\[char46]
