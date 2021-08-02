# vtep(5)

Open vSwitch 2.10.1,  DB Schema 1.7.0

.fp 5 L CR              \\" Make fixed-width font available as \\fL.

<a name="name"></a>

# Name

vtep - hardware_vtep database schema




This schema specifies relations that a VTEP can use to integrate physical ports into logical switches maintained by a network virtualization controller such as NSX\[char46]


Glossary:

* VTEP  
  VXLAN Tunnel End Point, an entity which originates and/or terminates VXLAN tunnels\[char46]
* HSC  
  Hardware Switch Controller\[char46]
* NVC  
  Network Virtualization Controller, e\[char46]g\[char46] NSX\[char46]
* VRF  
  Virtual Routing and Forwarding instance\[char46]

<a name="common-column"></a>

### Common Column



Some tables contain a column, named **other\_config**\[char46] This column has the same form and purpose each place that it appears, so we describe it here to save space later\[char46]

* **other\_config**: map of string-string pairs  
  Key-value pairs for configuring rarely used or proprietary features\[char46]
* Some tables do not have **other\_config** column because no key-value pairs have yet been defined for them\[char46]

<a name="table-summary"></a>

# Table Summary


The following list summarizes the purpose of each of the tables in the
**hardware\_vtep** database.  Each table is described in more detail on a later
page.

* Table  
  Purpose
  .TQ 1in
  **Global**
  Top-level configuration\[char46]
  .TQ 1in
  **Manager**
  OVSDB management connection\[char46]
  .TQ 1in
  **Physical\_Switch**
  A physical switch\[char46]
  .TQ 1in
  **Tunnel**
  A tunnel created by a physical switch\[char46]
  .TQ 1in
  **Physical\_Port**
  A port within a physical switch\[char46]
  .TQ 1in
  **Logical\_Binding\_Stats**
  Statistics for a VLAN on a physical port bound to a logical network\[char46]
  .TQ 1in
  **Logical\_Switch**
  A layer-2 domain\[char46]
  .TQ 1in
  **Ucast\_Macs\_Local**
  Unicast MACs (local)
  .TQ 1in
  **Ucast\_Macs\_Remote**
  Unicast MACs (remote)
  .TQ 1in
  **Mcast\_Macs\_Local**
  Multicast MACs (local)
  .TQ 1in
  **Mcast\_Macs\_Remote**
  Multicast MACs (remote)
  .TQ 1in
  **Logical\_Router**
  A logical L3 router\[char46]
  .TQ 1in
  **Arp\_Sources\_Local**
  ARP source addresses for logical routers
  .TQ 1in
  **Arp\_Sources\_Remote**
  ARP source addresses for logical routers
  .TQ 1in
  **Physical\_Locator\_Set**
  Physical_Locator_Set configuration\[char46]
  .TQ 1in
  **Physical\_Locator**
  Physical_Locator configuration\[char46]
  .TQ 1in
  **ACL\_entry**
  ACL_entry configuration\[char46]
  .TQ 1in
  **ACL**
  ACL configuration\[char46]
  
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
linethick = 0.500000;
box at 1.415154,1.542063 wid 0.891405 height 0.234235 "Mcast_Macs_Remote"
box at 1.415154,1.542063 wid 0.835849 height 0.178679
linethick = 1.000000;
box at 2.931170,3.019008 wid 0.871870 height 0.234235 "Physical_Locator_Set"
linethick = 0.500000;
box at 4.870214,1.411922 wid 0.657170 height 0.234235 "Logical_Switch"
box at 4.870214,1.411922 wid 0.601614 height 0.178679
linethick = 0.500000;
box at 2.931170,0.904428 wid 0.657170 height 0.234235 "Logical_Router"
box at 2.931170,0.904428 wid 0.601614 height 0.178679
linethick = 0.500000;
box at 4.870214,0.663681 wid 0.351353 height 0.234235 "ACL"
box at 4.870214,0.663681 wid 0.295797 height 0.178679
linethick = 0.500000;
box at 2.931170,2.316303 wid 0.793776 height 0.234235 "Ucast_Macs_Local"
box at 2.931170,2.316303 wid 0.738220 height 0.178679
linethick = 1.000000;
box at 4.870214,2.914914 wid 0.715728 height 0.234235 "Physical_Locator"
linethick = 1.000000;
box at 2.931170,2.667656 wid 0.351353 height 0.234235 "Tunnel"
linethick = 0.500000;
box at 0.175676,0.754752 wid 0.351353 height 0.234235 "Global"
box at 0.175676,0.754752 wid 0.295797 height 0.178679
linethick = 1.000000;
box at 1.415154,0.982475 wid 0.676658 height 0.234235 "Physical_Switch"
linethick = 1.000000;
box at 1.415154,0.631123 wid 0.422925 height 0.234235 "Manager"
linethick = 0.500000;
box at 6.249390,0.663681 wid 0.500982 height 0.234235 "ACL_entry"
box at 6.249390,0.663681 wid 0.445426 height 0.178679
linethick = 1.000000;
box at 2.931170,0.481493 wid 0.585588 height 0.234235 "Physical_Port"
linethick = 0.500000;
box at 1.415154,2.296815 wid 0.813311 height 0.234235 "Mcast_Macs_Local"
box at 1.415154,2.296815 wid 0.757755 height 0.178679
linethick = 0.500000;
box at 2.931170,1.633133 wid 0.871870 height 0.234235 "Ucast_Macs_Remote"
box at 2.931170,1.633133 wid 0.816314 height 0.178679
linethick = 0.500000;
box at 2.931170,3.760783 wid 0.891405 height 0.234235 "Arp_Sources_Remote"
box at 2.931170,3.760783 wid 0.835849 height 0.178679
linethick = 0.500000;
box at 2.931170,3.409431 wid 0.813311 height 0.234235 "Arp_Sources_Local"
box at 2.931170,3.409431 wid 0.757755 height 0.178679
linethick = 1.000000;
box at 4.870214,0.117117 wid 0.917405 height 0.234235 "Logical_Binding_Stats"
linethick = 1.000000;
spline -&gt; from 1.579166,1.660398 to 1.579166,1.660398 to 1.790820,1.821365 to 2.156883,2.128821 to 2.368397,2.472491 to 2.458952,2.619684 to 2.367601,2.716939 to 2.485514,2.843332 to 2.505940,2.865256 to 2.529410,2.884463 to 2.554707,2.901328
"locator_set" at 2.173185,2.521259
linethick = 1.000000;
spline -&gt; from 1.818928,1.424570 to 1.818928,1.424570 to 1.872053,1.412062 to 1.926114,1.400866 to 1.977974,1.392387 to 2.895988,1.242429 to 3.999844,1.319727 to 4.539896,1.373882
"logical_switch" at 2.931170,1.376131
linethick = 1.000000;
spline -&gt; from 3.367925,3.038824 to 3.367925,3.038824 to 3.635843,3.046086 to 3.985555,3.046695 to 4.294324,3.019008 to 4.365157,3.012684 to 4.440299,3.002003 to 4.512116,2.989869
"locators+" at 3.894157,3.087358
linethick = 1.000000;
spline -&gt; from 3.260504,0.942140 to 3.260504,0.942140 to 3.600754,0.983412 to 4.107686,1.051715 to 4.294324,1.112616 to 4.430321,1.157027 to 4.573110,1.230999 to 4.682451,1.294336
"switch_binding value*" at 3.894157,1.161431
linethick = 1.000000;
spline -&gt; from 3.260130,0.863578 to 3.260130,0.863578 to 3.673929,0.812186 to 4.369560,0.725801 to 4.693601,0.685559
"acl_binding value*" at 3.894157,0.881614
linethick = 1.000000;
spline -&gt; from 5.047764,0.663681 to 5.047764,0.663681 to 5.289026,0.663681 to 5.722830,0.663681 to 5.997821,0.663681
"acl_entries+" at 5.663802,0.712449
linethick = 1.000000;
spline -&gt; from 3.330306,2.216659 to 3.330306,2.216659 to 3.385164,2.203777 to 3.440912,2.191081 to 3.493990,2.179697 to 3.847778,2.103711 to 3.977263,2.204432 to 4.294324,2.030021 to 4.514036,1.909156 to 4.697349,1.673984 to 4.794322,1.531147
"logical_switch" at 3.894157,2.228465
linethick = 1.000000;
spline -&gt; from 3.329978,2.303467 to 3.329978,2.303467 to 3.609468,2.307777 to 3.986586,2.340991 to 4.294324,2.465979 to 4.477543,2.540372 to 4.651251,2.690798 to 4.759187,2.797000
"locator" at 3.894157,2.514794
linethick = 1.000000;
spline -&gt; from 3.108017,2.704103 to 3.108017,2.704103 to 3.218623,2.725980 to 3.364177,2.753058 to 3.493990,2.771796 to 3.837519,2.821361 to 4.231690,2.860572 to 4.509867,2.885307
"remote" at 3.894157,2.911682
linethick = 1.000000;
spline -&gt; from 3.108064,2.639594 to 3.108064,2.639594 to 3.370595,2.603616 to 3.877105,2.556207 to 4.294324,2.648167 to 4.426667,2.677306 to 4.564772,2.740034 to 4.672520,2.797328
"local" at 3.894157,2.696935
linethick = 1.000000;
spline -&gt; from 0.353264,0.787404 to 0.353264,0.787404 to 0.541364,0.821931 to 0.842871,0.877351 to 1.076591,0.920262
"switches*" at 0.660402,0.920684
linethick = 1.000000;
spline -&gt; from 0.351362,0.711044 to 0.351362,0.711044 to 0.389753,0.702799 to 0.430313,0.695069 to 0.468470,0.689682 to 0.719570,0.654265 to 1.011146,0.640258 to 1.203640,0.634730
"managers*" at 0.660402,0.738496
linethick = 1.000000;
spline -&gt; from 1.597014,1.100670 to 1.597014,1.100670 to 1.818882,1.255546 to 2.186724,1.549090 to 2.368397,1.899927 to 2.491745,2.138097 to 2.313633,2.286040 to 2.485514,2.491979 to 2.552646,2.572462 to 2.661659,2.616264 to 2.755072,2.640016
"tunnels*" at 2.173185,1.948695
linethick = 1.000000;
spline -&gt; from 1.755404,0.870042 to 1.755404,0.870042 to 2.020792,0.782345 to 2.385543,0.661808 to 2.638095,0.578326
"ports*" at 2.173185,0.836078
linethick = 1.000000;
spline -&gt; from 3.226587,0.477277 to 3.226587,0.477277 to 3.574379,0.477839 to 4.126050,0.497609 to 4.294324,0.611634 to 4.388533,0.675440 to 4.349510,0.743837 to 4.411441,0.839358 to 4.519517,1.006086 to 4.666195,1.182231 to 4.764340,1.294383
"vlan_bindings value*" at 3.894157,0.660402
linethick = 1.000000;
spline -&gt; from 3.225135,0.405100 to 3.225135,0.405100 to 3.503968,0.344897 to 3.932946,0.284282 to 4.294324,0.370874 to 4.436083,0.404847 to 4.582386,0.479807 to 4.692196,0.545393
"acl_bindings value*" at 3.894157,0.419669
linethick = 1.000000;
spline -&gt; from 3.127084,0.363149 to 3.127084,0.363149 to 3.232068,0.305813 to 3.365910,0.242157 to 3.493990,0.208207 to 3.792593,0.129087 to 4.139682,0.106572 to 4.410551,0.103710
"vlan_stats value*" at 3.894157,0.257007
linethick = 1.000000;
spline -&gt; from 1.629479,2.413979 to 1.629479,2.413979 to 1.843429,2.529129 to 2.183117,2.706913 to 2.485514,2.843332 to 2.528707,2.862867 to 2.574758,2.882355 to 2.620293,2.900954
"locator_set" at 2.173185,2.833588
linethick = 1.000000;
spline -&gt; from 1.823145,2.198530 to 1.823145,2.198530 to 2.242097,2.097902 to 2.913181,1.937498 to 3.493990,1.802298 to 3.849277,1.719613 to 3.944283,1.722845 to 4.294324,1.620110 to 4.384083,1.593782 to 4.480166,1.560942 to 4.567629,1.529227
"logical_switch" at 2.931170,2.078836
linethick = 1.000000;
spline -&gt; from 3.369752,1.541922 to 3.369752,1.541922 to 3.411633,1.534755 to 3.453561,1.528102 to 3.493990,1.522528 to 3.850168,1.473385 to 4.261391,1.443871 to 4.540880,1.427803
"logical_switch" at 3.894157,1.571342
linethick = 1.000000;
spline -&gt; from 3.368393,1.681105 to 3.368393,1.681105 to 3.709158,1.725656 to 4.148255,1.801033 to 4.294324,1.906392 to 4.606606,2.131726 to 4.773241,2.582207 to 4.837890,2.796485
"locator" at 3.894157,1.955206
linethick = 1.000000;
spline -&gt; from 3.378559,3.720917 to 3.378559,3.720917 to 3.655143,3.681987 to 4.010291,3.605345 to 4.294324,3.454966 to 4.492955,3.349795 to 4.673410,3.157722 to 4.777457,3.033296
"locator" at 3.894157,3.744528
linethick = 1.000000;
spline -&gt; from 3.339488,3.359961 to 3.339488,3.359961 to 3.613262,3.320843 to 3.979934,3.256850 to 4.294324,3.162173 to 4.407881,3.127974 to 4.529121,3.078082 to 4.630920,3.032032
"locator" at 3.894157,3.380152
.ps +3
.PE
.bp

<a name="global-table"></a>

# Global Table


Top-level configuration for a hardware VTEP\[char46] There must be exactly one record in the **Global** table\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**switches**
set of **Physical\_Switch**s
.TQ .25in
_Database Configuration:_
.TQ 2.75in
**managers**
set of **Manager**s
.TQ .25in
_Common Column:_
.TQ 2.75in
**other\_config**
map of string-string pairs

<a name="details"></a>

### "Details:


* **switches**: set of **Physical\_Switch**s  
  The physical switch or switches managed by the VTEP\[char46]
* When a physical switch integrates support for this VTEP schema, which is expected to be the most common case, this column should point to one **Physical\_Switch** record that represents the switch itself\[char46] In another possible implementation, a server or a VM presents a VTEP schema front-end interface to one or more physical switches, presumably communicating with those physical switches over a proprietary protocol\[char46] In that case, this column would point to one **Physical\_Switch** for each physical switch, and the set might change over time as the front-end server comes to represent a differing set of switches\[char46]
  .ST "Database Configuration:"



These columns primarily configure the database server (**ovsdb-server**), not the hardware VTEP itself\[char46]

* **managers**: set of **Manager**s  
  Database clients to which the database server should connect or to which it should listen, along with options for how these connection should be configured\[char46] See the **Manager** table for more information\[char46]
  .ST "Common Column:"

The overall purpose of this column is described under Common
Column at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
  .bp

<a name="manager-table"></a>

# Manager Table




Configuration for a database connection to an Open vSwitch Database (OVSDB) client\[char46]


The database server can initiate and maintain active connections to remote clients\[char46] It can also listen for database connections\[char46]

<a name="summary"></a>

### "Summary:

.TQ .25in
_Core Features:_
.TQ 2.75in
**target**
string (must be unique within table)
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
.TQ .25in
_Connection Parameters:_
.TQ 2.75in
**other_config : dscp**
optional string, containing an integer

<a name="details"></a>

### "Details:

.ST "Core Features:"


* **target**: string (must be unique within table)  
  Connection method for managers\[char46]
* The following connection methods are currently supported:
    * **ssl:host**[**:port**]  
      The specified SSL _port_ (default: 6640) on the given _host_, which can either be a DNS name (if built with unbound library) or an IP address\[char46]
    * SSL key and certificate configuration happens outside the database\[char46]
    * **tcp:host**[**:port**]  
      The specified TCP _port_ (default: 6640) on the given _host_, which can either be a DNS name (if built with unbound library) or an IP address\[char46]
    * **pssl:**[_port_][**:host**]  
      Listens for SSL connections on the specified TCP _port_ (default: 6640)\[char46] If _host_, which can either be a DNS name (if built with unbound library) or an IP address, is specified, then connections are restricted to the resolved or specified local IP address\[char46]
    * **ptcp:**[_port_][**:host**]  
      Listens for connections on the specified TCP _port_ (default: 6640)\[char46] If _host_, which can either be a DNS name (if built with unbound library) or an IP address, is specified, then connections are restricted to the resolved or specified local IP address\[char46]
  .ST "Client Failure Detection and Handling:"


* **max\_backoff**: optional integer, at least 1,000  
  Maximum number of milliseconds to wait between connection attempts\[char46] Default is implementation-specific\[char46]
* **inactivity\_probe**: optional integer  
  Maximum number of milliseconds of idle time on connection to the client before sending an inactivity probe message\[char46] If the Open vSwitch database does not communicate with the client for the specified number of seconds, it will send a probe\[char46] If a response is not received for the same additional amount of time, the database server assumes the connection has been broken and attempts to reconnect\[char46] Default is implementation-specific\[char46] A value of 0 disables inactivity probes\[char46]
  .ST "Status:"


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
* When multiple connections are active, status columns and key-value pairs (other than this one) report the status of one arbitrarily chosen connection\[char46]
  .ST "Connection Parameters:"



Additional configuration for a connection between the manager and the database server\[char46]

* **other_config : dscp**: optional string, containing an integer  
  The Differentiated Service Code Point (DSCP) is specified using 6 bits in the Type of Service (TOS) field in the IP header\[char46] DSCP provides a mechanism to classify the network traffic and provide Quality of Service (QoS) on IP networks\[char46] The DSCP value specified here is used when establishing the connection between the manager and the database server\[char46] If no value is specified, a default value of 48 is chosen\[char46] Valid DSCP values must be in the range 0 to 63\[char46]
  .bp

<a name="physical_switch-table"></a>

# Physical_switch Table


A physical switch that implements a VTEP\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**ports**
set of **Physical\_Port**s
.TQ 3.00in
**tunnels**
set of **Tunnel**s
.TQ .25in
_Network Status:_
.TQ 2.75in
**management\_ips**
set of strings
.TQ 2.75in
**tunnel\_ips**
set of strings
.TQ .25in
_Identification:_
.TQ 2.75in
**name**
string (must be unique within table)
.TQ 2.75in
**description**
string
.TQ .25in
_Error Notification:_
.TQ 2.75in
**switch_fault_status : mac\_table\_exhaustion**
none
.TQ 2.75in
**switch_fault_status : tunnel\_exhaustion**
none
.TQ 2.75in
**switch_fault_status : lr\_switch\_bindings\_fault**
none
.TQ 2.75in
**switch_fault_status : lr\_static\_routes\_fault**
none
.TQ 2.75in
**switch_fault_status : lr\_creation\_fault**
none
.TQ 2.75in
**switch_fault_status : lr\_support\_fault**
none
.TQ 2.75in
**switch_fault_status : unspecified\_fault**
none
.TQ 2.75in
**switch_fault_status : unsupported\_source\_node\_replication**
none
.TQ .25in
_Common Column:_
.TQ 2.75in
**other\_config**
map of string-string pairs

<a name="details"></a>

### "Details:


* **ports**: set of **Physical\_Port**s  
  The physical ports within the switch\[char46]
* **tunnels**: set of **Tunnel**s  
  Tunnels created by this switch as instructed by the NVC\[char46]
  .ST "Network Status:"


* **management\_ips**: set of strings  
  IPv4 or IPv6 addresses at which the switch may be contacted for management purposes\[char46]
* **tunnel\_ips**: set of strings  
  IPv4 or IPv6 addresses on which the switch may originate or terminate tunnels\[char46]
* This column is intended to allow a **Manager** to determine the **Physical\_Switch** that terminates the tunnel represented by a **Physical\_Locator**\[char46]
  .ST "Identification:"


* **name**: string (must be unique within table)  
  Symbolic name for the switch, such as its hostname\[char46]
* **description**: string  
  An extended description for the switch, such as its switch login banner\[char46]
  .ST "Error Notification:"



An entry in this column indicates to the NVC that this switch has encountered a fault\[char46] The switch must clear this column when the fault has been cleared\[char46]

* **switch_fault_status : mac\_table\_exhaustion**: none  
  Indicates that the switch has been unable to process MAC entries requested by the NVC due to lack of table resources\[char46]
* **switch_fault_status : tunnel\_exhaustion**: none  
  Indicates that the switch has been unable to create tunnels requested by the NVC due to lack of resources\[char46]
* **switch_fault_status : lr\_switch\_bindings\_fault**: none  
  Indicates that the switch has been unable to create the logical router interfaces requested by the NVC due to conflicting configurations or a lack of hardware resources\[char46]
* **switch_fault_status : lr\_static\_routes\_fault**: none  
  Indicates that the switch has been unable to create the static routes requested by the NVC due to conflicting configurations or a lack of hardware resources\[char46]
* **switch_fault_status : lr\_creation\_fault**: none  
  Indicates that the switch has been unable to create the logical router requested by the NVC due to conflicting configurations or a lack of hardware resources\[char46]
* **switch_fault_status : lr\_support\_fault**: none  
  Indicates that the switch does not support logical routing\[char46]
* **switch_fault_status : unspecified\_fault**: none  
  Indicates that an error has occurred in the switch but that no more specific information is available\[char46]
* **switch_fault_status : unsupported\_source\_node\_replication**: none  
  Indicates that the requested source node replication mode cannot be supported by the physical switch; this specifically means in this context that the physical switch lacks the capability to support source node replication mode\[char46] This error occurs when a controller attempts to set source node replication mode for one of the logical switches that the physical switch is keeping context for\[char46] An NVC that observes this error should take appropriate action (for example reverting the logical switch to service node replication mode)\[char46] It is recommended that an NVC be proactive and test for support of source node replication by using a test logical switch on vtep physical switch nodes and then trying to change the replication mode to source node on this logical switch, checking for error\[char46] The NVC could remember this capability per vtep physical switch\[char46] Using mixed replication modes on a given logical switch is not recommended\[char46] Service node replication mode is considered a basic requirement since it only requires sending a packet to a single transport node, hence it is not expected that a switch should report that service node mode cannot be supported\[char46]
  .ST "Common Column:"

The overall purpose of this column is described under Common
Column at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
  .bp

<a name="tunnel-table"></a>

# Tunnel Table


A tunnel created by a **Physical\_Switch**\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**local**
**Physical\_Locator**
.TQ 3.00in
**remote**
**Physical\_Locator**
.TQ .25in
_Bidirectional Forwarding Detection (BFD):_
.TQ .25in
_BFD Local Configuration:_
.TQ 2.50in
**bfd_config_local : bfd\_dst\_mac**
optional string
.TQ 2.50in
**bfd_config_local : bfd\_dst\_ip**
optional string
.TQ .25in
_BFD Remote Configuration:_
.TQ 2.50in
**bfd_config_remote : bfd\_dst\_mac**
optional string
.TQ 2.50in
**bfd_config_remote : bfd\_dst\_ip**
optional string
.TQ .25in
_BFD Parameters:_
.TQ 2.50in
**bfd_params : enable**
optional string, either **true** or **false**
.TQ 2.50in
**bfd_params : min\_rx**
optional string, containing an integer, at least 1
.TQ 2.50in
**bfd_params : min\_tx**
optional string, containing an integer, at least 1
.TQ 2.50in
**bfd_params : decay\_min\_rx**
optional string, containing an integer
.TQ 2.50in
**bfd_params : forwarding\_if\_rx**
optional string, either **true** or **false**
.TQ 2.50in
**bfd_params : cpath\_down**
optional string, either **true** or **false**
.TQ 2.50in
**bfd_params : check\_tnl\_key**
optional string, either **true** or **false**
.TQ .25in
_BFD Status:_
.TQ 2.50in
**bfd_status : enabled**
optional string, either **true** or **false**
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
**bfd_status : info**
optional string

<a name="details"></a>

### "Details:


* **local**: **Physical\_Locator**  
  Tunnel end-point local to the physical switch\[char46]
* **remote**: **Physical\_Locator**  
  Tunnel end-point remote to the physical switch\[char46]
  .ST "Bidirectional Forwarding Detection (BFD):"



BFD, defined in RFC 5880, allows point to point detection of connectivity failures by occasional transmission of BFD control messages\[char46] VTEPs are expected to implement BFD\[char46]


BFD operates by regularly transmitting BFD control messages at a rate negotiated independently in each direction\[char46] Each endpoint specifies the rate at which it expects to receive control messages, and the rate at which it’s willing to transmit them\[char46] An endpoint which fails to receive BFD control messages for a period of three times the expected reception rate will signal a connectivity fault\[char46] In the case of a unidirectional connectivity issue, the system not receiving BFD control messages will signal the problem to its peer in the messages it transmits\[char46]


A hardware VTEP is expected to use BFD to determine reachability of devices at the end of the tunnels with which it exchanges data\[char46] This can enable the VTEP to choose a functioning service node among a set of service nodes providing high availability\[char46] It also enables the NVC to report the health status of tunnels\[char46]


In many cases the BFD peer of a hardware VTEP will be an Open vSwitch instance\[char46] The Open vSwitch implementation of BFD aims to comply faithfully with the requirements put forth in RFC 5880\[char46] Open vSwitch does not implement the optional Authentication or \`\`Echo Mode’’ features\[char46]
.ST "BFD Local Configuration:"



The HSC writes the key-value pairs in the **bfd\_config\_local** column to specify the local configurations to be used for BFD sessions on this tunnel\[char46]

* **bfd_config_local : bfd\_dst\_mac**: optional string  
  Set to an Ethernet address in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_ to set the MAC expected as destination for received BFD packets\[char46] The default is **00:23:20:00:00:01**\[char46]
* **bfd_config_local : bfd\_dst\_ip**: optional string  
  Set to an IPv4 address to set the IP address that is expected as destination for received BFD packets\[char46] The default is **169\[char46]254\[char46]1\[char46]0**\[char46]
  .ST "BFD Remote Configuration:"



The **bfd\_config\_remote** column is the remote counterpart of the **bfd\_config\_local** column\[char46] The NVC writes the key-value pairs in this column\[char46]

* **bfd_config_remote : bfd\_dst\_mac**: optional string  
  Set to an Ethernet address in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_ to set the destination MAC to be used for transmitted BFD packets\[char46] The default is **00:23:20:00:00:01**\[char46]
* **bfd_config_remote : bfd\_dst\_ip**: optional string  
  Set to an IPv4 address to set the IP address used as destination for transmitted BFD packets\[char46] The default is **169\[char46]254\[char46]1\[char46]1**\[char46]
  .ST "BFD Parameters:"



The NVC sets up key-value pairs in the **bfd\_params** column to enable and configure BFD\[char46]

* **bfd_params : enable**: optional string, either **true** or **false**  
  True to enable BFD on this **Tunnel**\[char46] If not specified, BFD will not be enabled by default\[char46]
* **bfd_params : min\_rx**: optional string, containing an integer, at least 1  
  The shortest interval, in milliseconds, at which this BFD session offers to receive BFD control messages\[char46] The remote endpoint may choose to send messages at a slower rate\[char46] Defaults to **1000**\[char46]
* **bfd_params : min\_tx**: optional string, containing an integer, at least 1  
  The shortest interval, in milliseconds, at which this BFD session is willing to transmit BFD control messages\[char46] Messages will actually be transmitted at a slower rate if the remote endpoint is not willing to receive as quickly as specified\[char46] Defaults to **100**\[char46]
* **bfd_params : decay\_min\_rx**: optional string, containing an integer  
  An alternate receive interval, in milliseconds, that must be greater than or equal to **bfd\_params:min\_rx**\[char46] The implementation should switch from **bfd\_params:min\_rx** to **bfd\_params:decay\_min\_rx** when there is no obvious incoming data traffic at the tunnel, to reduce the CPU and bandwidth cost of monitoring an idle tunnel\[char46] This feature may be disabled by setting a value of 0\[char46] This feature is reset whenever **bfd\_params:decay\_min\_rx** or **bfd\_params:min\_rx** changes\[char46]
* **bfd_params : forwarding\_if\_rx**: optional string, either **true** or **false**  
  When **true**, traffic received on the **Tunnel** is used to indicate the capability of packet I/O\[char46] BFD control packets are still transmitted and received\[char46] At least one BFD control packet must be received every 100 * **bfd\_params:min\_rx** amount of time\[char46] Otherwise, even if traffic is received, the **bfd\_params:forwarding** will be **false**\[char46]
* **bfd_params : cpath\_down**: optional string, either **true** or **false**  
  Set to true to notify the remote endpoint that traffic should not be forwarded to this system for some reason other than a connectivity failure on the interface being monitored\[char46] The typical underlying reason is \`\`concatenated path down,’’ that is, that connectivity beyond the local system is down\[char46] Defaults to false\[char46]
* **bfd_params : check\_tnl\_key**: optional string, either **true** or **false**  
  Set to true to make BFD accept only control messages with a tunnel key of zero\[char46] By default, BFD accepts control messages with any tunnel key\[char46]
  .ST "BFD Status:"



The VTEP sets key-value pairs in the **bfd\_status** column to report the status of BFD on this tunnel\[char46] When BFD is not enabled, with **bfd\_params:enable**, the HSC clears all key-value pairs from **bfd\_status**\[char46]

* **bfd_status : enabled**: optional string, either **true** or **false**  
  Set to true if the BFD session has been successfully enabled\[char46] Set to false if the VTEP cannot support BFD or has insufficient resources to enable BFD on this tunnel\[char46] The NVC will disable the BFD monitoring on the other side of the tunnel once this value is set to false\[char46]
* **bfd_status : state**: optional string, one of **admin\_down**, **down**, **init**, or **up**  
  Reports the state of the BFD session\[char46] The BFD session is fully healthy and negotiated if **UP**\[char46]
* **bfd_status : forwarding**: optional string, either **true** or **false**  
  Reports whether the BFD session believes this **Tunnel** may be used to forward traffic\[char46] Typically this means the local session is signaling **UP**, and the remote system isn’t signaling a problem such as concatenated path down\[char46]
* **bfd_status : diagnostic**: optional string  
  A diagnostic code specifying the local system’s reason for the last change in session state\[char46] The error messages are defined in section 4\[char46]1 of [RFC 5880]\[char46]
* **bfd_status : remote\_state**: optional string, one of **admin\_down**, **down**, **init**, or **up**  
  Reports the state of the remote endpoint’s BFD session\[char46]
* **bfd_status : remote\_diagnostic**: optional string  
  A diagnostic code specifying the remote system’s reason for the last change in session state\[char46] The error messages are defined in section 4\[char46]1 of [RFC 5880]\[char46]
* **bfd_status : info**: optional string  
  A short message providing further information about the BFD status (possibly including reasons why BFD could not be enabled)\[char46]
  .bp

<a name="physical_port-table"></a>

# Physical_port Table


A port within a **Physical\_Switch**\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**vlan\_bindings**
map of integer-**Logical\_Switch** pairs, key in range 0 to 4,095
.TQ 3.00in
**acl\_bindings**
map of integer-**ACL** pairs, key in range 0 to 4,095
.TQ 3.00in
**vlan\_stats**
map of integer-**Logical\_Binding\_Stats** pairs, key in range 0 to 4,095
.TQ .25in
_Identification:_
.TQ 2.75in
**name**
string
.TQ 2.75in
**description**
string
.TQ .25in
_Error Notification:_
.TQ 2.75in
**port_fault_status : invalid\_vlan\_map**
none
.TQ 2.75in
**port_fault_status : invalid\_ACL\_binding**
none
.TQ 2.75in
**port_fault_status : unspecified\_fault**
none
.TQ .25in
_Common Column:_
.TQ 2.75in
**other\_config**
map of string-string pairs

<a name="details"></a>

### "Details:


* **vlan\_bindings**: map of integer-**Logical\_Switch** pairs, key in range 0 to 4,095  
  Identifies how VLANs on the physical port are bound to logical switches\[char46] If, for example, the map contains a (VLAN, logical switch) pair, a packet that arrives on the port in the VLAN is considered to belong to the paired logical switch\[char46] A value of zero in the VLAN field means that untagged traffic on the physical port is mapped to the logical switch\[char46]
* **acl\_bindings**: map of integer-**ACL** pairs, key in range 0 to 4,095  
  Attach Access Control Lists (ACLs) to the physical port\[char46] The column consists of a map of VLAN tags to **ACL**s\[char46] If the value of the VLAN tag in the map is 0, this means that the ACL is associated with the entire physical port\[char46] Non-zero values mean that the ACL is to be applied only on packets carrying that VLAN tag value\[char46] Switches will not necessarily support matching on the VLAN tag for all ACLs, and unsupported ACL bindings will cause errors to be reported\[char46] The binding of an ACL to a specific VLAN and the binding of an ACL to the entire physical port should not be combined on a single physical port\[char46] That is, a mix of zero and non-zero keys in the map is not recommended\[char46]
* **vlan\_stats**: map of integer-**Logical\_Binding\_Stats** pairs, key in range 0 to 4,095  
  Statistics for VLANs bound to logical switches on the physical port\[char46] An implementation that fully supports such statistics would populate this column with a mapping for every VLAN that is bound in **vlan\_bindings**\[char46] An implementation that does not support such statistics or only partially supports them would not populate this column or partially populate it, respectively\[char46] A value of zero in the VLAN field refers to untagged traffic on the physical port\[char46]
  .ST "Identification:"


* **name**: string  
  Symbolic name for the port\[char46] The name ought to be unique within a given **Physical\_Switch**, but the database is not capable of enforcing this\[char46]
* **description**: string  
  An extended description for the port\[char46]
  .ST "Error Notification:"



An entry in this column indicates to the NVC that the physical port has encountered a fault\[char46] The switch must clear this column when the error has been cleared\[char46]

* **port_fault_status : invalid\_vlan\_map**: none  
  Indicates that a VLAN-to-logical-switch mapping requested by the controller could not be instantiated by the switch because of a conflict with local configuration\[char46]
* **port_fault_status : invalid\_ACL\_binding**: none  
  Indicates that an error has occurred in associating an ACL with a port\[char46]
* **port_fault_status : unspecified\_fault**: none  
  Indicates that an error has occurred on the port but that no more specific information is available\[char46]
  .ST "Common Column:"

The overall purpose of this column is described under Common
Column at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
  .bp

<a name="logical_binding_stats-table"></a>

# Logical_binding_stats Table


Reports statistics for the **Logical\_Switch** with which a VLAN on a **Physical\_Port** is associated\[char46]

<a name="summary"></a>

### "Summary:

.TQ .25in
_Statistics:_
.TQ 2.75in
**packets\_from\_local**
integer
.TQ 2.75in
**bytes\_from\_local**
integer
.TQ 2.75in
**packets\_to\_local**
integer
.TQ 2.75in
**bytes\_to\_local**
integer

<a name="details"></a>

### "Details:

.ST "Statistics:"

These statistics count only packets to which the binding applies\[char46]

* **packets\_from\_local**: integer  
  Number of packets sent by the **Physical\_Switch**\[char46]
* **bytes\_from\_local**: integer  
  Number of bytes in packets sent by the **Physical\_Switch**\[char46]
* **packets\_to\_local**: integer  
  Number of packets received by the **Physical\_Switch**\[char46]
* **bytes\_to\_local**: integer  
  Number of bytes in packets received by the **Physical\_Switch**\[char46]
  .bp

<a name="logical_switch-table"></a>

# Logical_switch Table


A logical Ethernet switch, whose implementation may span physical and virtual media, possibly crossing L3 domains via tunnels; a logical layer-2 domain; an Ethernet broadcast domain\[char46]

<a name="summary"></a>

### "Summary:

.TQ .25in
_Per Logical-Switch Tunnel Key:_
.TQ 2.75in
**tunnel\_key**
optional integer
.TQ .25in
_Replication Mode:_
.TQ 2.75in
**replication\_mode**
optional string, either **service\_node** or **source\_node**
.TQ .25in
_Identification:_
.TQ 2.75in
**name**
string (must be unique within table)
.TQ 2.75in
**description**
string
.TQ .25in
_Common Column:_
.TQ 2.75in
**other\_config**
map of string-string pairs

<a name="details"></a>

### "Details:

.ST "Per Logical-Switch Tunnel Key:"



Tunnel protocols tend to have a field that allows the tunnel to be partitioned into sub-tunnels: VXLAN has a VNI, GRE and STT have a key, CAPWAP has a WSI, and so on\[char46] We call these generically \`\`tunnel keys\[char46]’’ Given that one needs to use a tunnel key at all, there are at least two reasonable ways to assign their values:

* ·  
  Per **Logical\_Switch**+**Physical\_Locator** pair\[char46] That is, each logical switch may be assigned a different tunnel key on every **Physical\_Locator**\[char46] This model is especially flexible\[char46]
* In this model, **Physical\_Locator** carries the tunnel key\[char46] Therefore, one **Physical\_Locator** record will exist for each logical switch carried at a given IP destination\[char46]
* ·  
  Per **Logical\_Switch**\[char46] That is, every tunnel associated with a particular logical switch carries the same tunnel key, regardless of the **Physical\_Locator** to which the tunnel is addressed\[char46] This model may ease switch implementation because it imposes fewer requirements on the hardware datapath\[char46]
* In this model, **Logical\_Switch** carries the tunnel key\[char46] Therefore, one **Physical\_Locator** record will exist for each IP destination\[char46]

* **tunnel\_key**: optional integer  
  This column is used only in the tunnel key per **Logical\_Switch** model (see above), because only in that model is there a tunnel key associated with a logical switch\[char46]
* For **vxlan\_over\_ipv4** encapsulation, when the tunnel key per **Logical\_Switch** model is in use, this column is the VXLAN VNI that identifies a logical switch\[char46] It must be in the range 0 to 16,777,215\[char46]
  .ST "Replication Mode:"



For handling L2 broadcast, multicast and unknown unicast traffic, packets can be sent to all members of a logical switch referenced by a physical switch\[char46] There are different modes to replicate the packets\[char46] The default mode of replication is to send the traffic to a service node, which can be a hypervisor, server or appliance, and let the service node handle replication to other transport nodes (hypervisors or other VTEP physical switches)\[char46] This mode is called service node replication\[char46] An alternate mode of replication, called source node replication involves the source node sending to all other transport nodes\[char46] Hypervisors are always responsible for doing their own replication for locally attached VMs in both modes\[char46] Service node replication mode is the default and considered a basic requirement because it only requires sending the packet to a single transport node\[char46]

* **replication\_mode**: optional string, either **service\_node** or **source\_node**  
  This optional column defines the replication mode per **Logical\_Switch**\[char46] There are 2 valid values, **service\_node** and **source\_node**\[char46] If the column is not set, the replication mode defaults to service_node\[char46]
  .ST "Identification:"


* **name**: string (must be unique within table)  
  Symbolic name for the logical switch\[char46]
* **description**: string  
  An extended description for the logical switch, such as its switch login banner\[char46]
  .ST "Common Column:"

The overall purpose of this column is described under Common
Column at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
  .bp

<a name="ucast_macs_local-table"></a>

# Ucast_macs_local Table




Mapping of unicast MAC addresses to tunnels (physical locators)\[char46] This table is written by the HSC, so it contains the MAC addresses that have been learned on physical ports by a VTEP\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**MAC**
string
.TQ 3.00in
**logical\_switch**
**Logical\_Switch**
.TQ 3.00in
**locator**
**Physical\_Locator**
.TQ 3.00in
**ipaddr**
string

<a name="details"></a>

### "Details:


* **MAC**: string  
  A MAC address that has been learned by the VTEP\[char46]
* **logical\_switch**: **Logical\_Switch**  
  The Logical switch to which this mapping applies\[char46]
* **locator**: **Physical\_Locator**  
  The physical locator to be used to reach this MAC address\[char46] In this table, the physical locator will be one of the tunnel IP addresses of the appropriate VTEP\[char46]
* **ipaddr**: string  
  The IP address to which this MAC corresponds\[char46] Optional field for the purpose of ARP supression\[char46]
  .bp

<a name="ucast_macs_remote-table"></a>

# Ucast_macs_remote Table




Mapping of unicast MAC addresses to tunnels (physical locators)\[char46] This table is written by the NVC, so it contains the MAC addresses that the NVC has learned\[char46] These include VM MAC addresses, in which case the physical locators will be hypervisor IP addresses\[char46] The NVC will also report MACs that it has learned from other HSCs in the network, in which case the physical locators will be tunnel IP addresses of the corresponding VTEPs\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**MAC**
string
.TQ 3.00in
**logical\_switch**
**Logical\_Switch**
.TQ 3.00in
**locator**
**Physical\_Locator**
.TQ 3.00in
**ipaddr**
string

<a name="details"></a>

### "Details:


* **MAC**: string  
  A MAC address that has been learned by the NVC\[char46]
* **logical\_switch**: **Logical\_Switch**  
  The Logical switch to which this mapping applies\[char46]
* **locator**: **Physical\_Locator**  
  The physical locator to be used to reach this MAC address\[char46] In this table, the physical locator will be either a hypervisor IP address or a tunnel IP addresses of another VTEP\[char46]
* **ipaddr**: string  
  The IP address to which this MAC corresponds\[char46] Optional field for the purpose of ARP supression\[char46]
  .bp

<a name="mcast_macs_local-table"></a>

# Mcast_macs_local Table




Mapping of multicast MAC addresses to tunnels (physical locators)\[char46] This table is written by the HSC, so it contains the MAC addresses that have been learned on physical ports by a VTEP\[char46] These may be learned by IGMP snooping, for example\[char46] This table also specifies how to handle unknown unicast and broadcast packets\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**MAC**
string
.TQ 3.00in
**logical\_switch**
**Logical\_Switch**
.TQ 3.00in
**locator\_set**
**Physical\_Locator\_Set**
.TQ 3.00in
**ipaddr**
string

<a name="details"></a>

### "Details:


* **MAC**: string  
  A MAC address that has been learned by the VTEP\[char46]
* The keyword **unknown-dst** is used as a special \`\`Ethernet address’’ that indicates the locations to which packets in a logical switch whose destination addresses do not otherwise appear in **Ucast\_Macs\_Local** (for unicast addresses) or **Mcast\_Macs\_Local** (for multicast addresses) should be sent\[char46]
* **logical\_switch**: **Logical\_Switch**  
  The Logical switch to which this mapping applies\[char46]
* **locator\_set**: **Physical\_Locator\_Set**  
  The physical locator set to be used to reach this MAC address\[char46] In this table, the physical locator set will be contain one or more tunnel IP addresses of the appropriate VTEP(s)\[char46]
* **ipaddr**: string  
  The IP address to which this MAC corresponds\[char46] Optional field for the purpose of ARP supression\[char46]
  .bp

<a name="mcast_macs_remote-table"></a>

# Mcast_macs_remote Table




Mapping of multicast MAC addresses to tunnels (physical locators)\[char46] This table is written by the NVC, so it contains the MAC addresses that the NVC has learned\[char46] This table also specifies how to handle unknown unicast and broadcast packets\[char46]


Multicast packet replication may be handled by a service node, in which case the physical locators will be IP addresses of service nodes\[char46] If the VTEP supports replication onto multiple tunnels, using source node replication, then this may be used to replicate directly onto VTEP-hypervisor or VTEP-VTEP tunnels\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**MAC**
string
.TQ 3.00in
**logical\_switch**
**Logical\_Switch**
.TQ 3.00in
**locator\_set**
**Physical\_Locator\_Set**
.TQ 3.00in
**ipaddr**
string

<a name="details"></a>

### "Details:


* **MAC**: string  
  A MAC address that has been learned by the NVC\[char46]
* The keyword **unknown-dst** is used as a special \`\`Ethernet address’’ that indicates the locations to which packets in a logical switch whose destination addresses do not otherwise appear in **Ucast\_Macs\_Remote** (for unicast addresses) or **Mcast\_Macs\_Remote** (for multicast addresses) should be sent\[char46]
* **logical\_switch**: **Logical\_Switch**  
  The Logical switch to which this mapping applies\[char46]
* **locator\_set**: **Physical\_Locator\_Set**  
  The physical locator set to be used to reach this MAC address\[char46] In this table, the physical locator set will be either a set of service nodes when service node replication is used or the set of transport nodes (defined as hypervisors or VTEPs) participating in the associated logical switch, when source node replication is used\[char46] When service node replication is used, the VTEP should send packets to one member of the locator set that is known to be healthy and reachable, which could be determined by BFD\[char46] When source node replication is used, the VTEP should send packets to all members of the locator set\[char46]
* **ipaddr**: string  
  The IP address to which this MAC corresponds\[char46] Optional field for the purpose of ARP supression\[char46]
  .bp

<a name="logical_router-table"></a>

# Logical_router Table




A logical router, or VRF\[char46] A logical router may be connected to one or more logical switches\[char46] Subnet addresses and interface addresses may be configured on the interfaces\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**switch\_binding**
map of string-**Logical\_Switch** pairs
.TQ 3.00in
**static\_routes**
map of string-string pairs
.TQ 3.00in
**acl\_binding**
map of string-**ACL** pairs
.TQ .25in
_Identification:_
.TQ 2.75in
**name**
string (must be unique within table)
.TQ 2.75in
**description**
string
.TQ .25in
_Error Notification:_
.TQ 2.75in
**LR_fault_status : invalid\_ACL\_binding**
none
.TQ 2.75in
**LR_fault_status : unspecified\_fault**
none
.TQ .25in
_Common Column:_
.TQ 2.75in
**other\_config**
map of string-string pairs

<a name="details"></a>

### "Details:


* **switch\_binding**: map of string-**Logical\_Switch** pairs  
  Maps from an IPv4 or IPv6 address prefix in CIDR notation to a logical switch\[char46] Multiple prefixes may map to the same switch\[char46] By writing a 32-bit (or 128-bit for v6) address with a /N prefix length, both the router’s interface address and the subnet prefix can be configured\[char46] For example, 192\[char46]68\[char46]1\[char46]1/24 creates a /24 subnet for the logical switch attached to the interface and assigns the address 192\[char46]68\[char46]1\[char46]1 to the router interface\[char46]
* **static\_routes**: map of string-string pairs  
  One or more static routes, mapping IP prefixes to next hop IP addresses\[char46]
* **acl\_binding**: map of string-**ACL** pairs  
  Maps ACLs to logical router interfaces\[char46] The router interfaces are indicated using IP address notation, and must be the same interfaces created in the **switch\_binding** column\[char46] For example, an ACL could be associated with the logical router interface with an address of 192\[char46]68\[char46]1\[char46]1 as defined in the example above\[char46]
  .ST "Identification:"


* **name**: string (must be unique within table)  
  Symbolic name for the logical router\[char46]
* **description**: string  
  An extended description for the logical router\[char46]
  .ST "Error Notification:"



An entry in this column indicates to the NVC that the HSC has encountered a fault in configuring state related to the logical router\[char46]

* **LR_fault_status : invalid\_ACL\_binding**: none  
  Indicates that an error has occurred in associating an ACL with a logical router port\[char46]
* **LR_fault_status : unspecified\_fault**: none  
  Indicates that an error has occurred in configuring the logical router but that no more specific information is available\[char46]
  .ST "Common Column:"

The overall purpose of this column is described under Common
Column at the beginning of this document\[char46]

* **other\_config**: map of string-string pairs  
  .bp

<a name="arp_sources_local-table"></a>

# Arp_sources_local Table




MAC address to be used when a VTEP issues ARP requests on behalf of a logical router\[char46]


A distributed logical router is implemented by a set of VTEPs (both hardware VTEPs and vswitches)\[char46] In order for a given VTEP to populate the local ARP cache for a logical router, it issues ARP requests with a source MAC address that is unique to the VTEP\[char46] A single per-VTEP MAC can be re-used across all logical networks\[char46] This table contains the MACs that are used by the VTEPs of a given HSC\[char46] The table provides the mapping from MAC to physical locator for each VTEP so that replies to the ARP requests can be sent back to the correct VTEP using the appropriate physical locator\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**src\_mac**
string
.TQ 3.00in
**locator**
**Physical\_Locator**

<a name="details"></a>

### "Details:


* **src\_mac**: string  
  The source MAC to be used by a given VTEP\[char46]
* **locator**: **Physical\_Locator**  
  The **Physical\_Locator** to use for replies to ARP requests from this MAC address\[char46]
  .bp

<a name="arp_sources_remote-table"></a>

# Arp_sources_remote Table




MAC address to be used when a remote VTEP issues ARP requests on behalf of a logical router\[char46]


This table is the remote counterpart of **Arp\_sources\_local**\[char46] The NVC writes this table to notify the HSC of the MACs that will be used by remote VTEPs when they issue ARP requests on behalf of a distributed logical router\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**src\_mac**
string
.TQ 3.00in
**locator**
**Physical\_Locator**

<a name="details"></a>

### "Details:


* **src\_mac**: string  
  The source MAC to be used by a given VTEP\[char46]
* **locator**: **Physical\_Locator**  
  The **Physical\_Locator** to use for replies to ARP requests from this MAC address\[char46]
  .bp

<a name="physical_locator_set-table"></a>

# Physical_locator_set Table




A set of one or more **Physical\_Locator**s\[char46]


This table exists only because OVSDB does not have a way to express the type \`\`map from string to one or more **Physical\_Locator** records\[char46]’’

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**locators**
immutable set of 1 or more **Physical\_Locator**s

<a name="details"></a>

### "Details:


* **locators**: immutable set of 1 or more **Physical\_Locator**s  
  .bp

<a name="physical_locator-table"></a>

# Physical_locator Table




Identifies an endpoint to which logical switch traffic may be encapsulated and forwarded\[char46]


The **vxlan\_over\_ipv4** encapsulation, the only encapsulation defined so far, can use either tunnel key model described in the \`\`Per Logical-Switch Tunnel Key’’ section in the **Logical\_Switch** table\[char46] When the tunnel key per **Logical\_Switch** model is in use, the **tunnel\_key** column in the **Logical\_Switch** table is filled with a VNI and the **tunnel\_key** column in this table is empty; in the key-per-tunnel model, the opposite is true\[char46] The former model is older, and thus likely to be more widely supported\[char46] See the \`\`Per Logical-Switch Tunnel Key’’ section in the **Logical\_Switch** table for further discussion of the model\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**encapsulation\_type**
immutable string, must be **vxlan\_over\_ipv4**
.TQ 3.00in
**dst\_ip**
immutable string
.TQ 3.00in
**tunnel\_key**
optional integer

<a name="details"></a>

### "Details:


* **encapsulation\_type**: immutable string, must be **vxlan\_over\_ipv4**  
  The type of tunneling encapsulation\[char46]
* **dst\_ip**: immutable string  
  For **vxlan\_over\_ipv4** encapsulation, the IPv4 address of the VXLAN tunnel endpoint\[char46]
* We expect that this column could be used for IPv4 or IPv6 addresses in encapsulations to be introduced later\[char46]
* **tunnel\_key**: optional integer  
  This column is used only in the tunnel key per **Logical\_Switch**+**Physical\_Locator** model (see above)\[char46]
* For **vxlan\_over\_ipv4** encapsulation, when the **Logical\_Switch**+**Physical\_Locator** model is in use, this column is the VXLAN VNI\[char46] It must be in the range 0 to 16,777,215\[char46]
  .bp

<a name="acl_entry-table"></a>

# Acl_entry Table




Describes the individual entries that comprise an Access Control List\[char46]


Each entry in the table is a single rule to match on certain header fields\[char46] While there are a large number of fields that can be matched on, most hardware cannot match on arbitrary combinations of fields\[char46] It is common to match on either L2 fields (described below in the L2 group of columns) or L3/L4 fields (the L3/L4 group of columns) but not both\[char46] The hardware switch controller may log an error if an ACL entry requires it to match on an incompatible mixture of fields\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**sequence**
integer
.TQ .25in
_L2 fields:_
.TQ 2.75in
**source\_mac**
optional string
.TQ 2.75in
**dest\_mac**
optional string
.TQ 2.75in
**ethertype**
optional string
.TQ .25in
_L3/L4 fields:_
.TQ 2.75in
**source\_ip**
optional string
.TQ 2.75in
**source\_mask**
optional string
.TQ 2.75in
**dest\_ip**
optional string
.TQ 2.75in
**dest\_mask**
optional string
.TQ 2.75in
**protocol**
optional integer
.TQ 2.75in
**source\_port\_min**
optional integer
.TQ 2.75in
**source\_port\_max**
optional integer
.TQ 2.75in
**dest\_port\_min**
optional integer
.TQ 2.75in
**dest\_port\_max**
optional integer
.TQ 2.75in
**tcp\_flags**
optional integer
.TQ 2.75in
**tcp\_flags\_mask**
optional integer
.TQ 2.75in
**icmp\_type**
optional integer
.TQ 2.75in
**icmp\_code**
optional integer
.TQ 3.00in
**direction**
string, either **egress** or **ingress**
.TQ 3.00in
**action**
string, either **deny** or **permit**
.TQ .25in
_Error Notification:_
.TQ 2.75in
**acle_fault_status : invalid\_acl\_entry**
none
.TQ 2.75in
**acle_fault_status : unspecified\_fault**
none

<a name="details"></a>

### "Details:


* **sequence**: integer  
  The sequence number for the ACL entry for the purpose of ordering entries in an ACL\[char46] Lower numbered entries are matched before higher numbered entries\[char46]
  .ST "L2 fields:"


* **source\_mac**: optional string  
  Source MAC address, in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_
* **dest\_mac**: optional string  
  Destination MAC address, in the form _xx_:_xx_:_xx_:_xx_:_xx_:_xx_
* **ethertype**: optional string  
  Ethertype in hexadecimal, in the form _0xAAAA_
  .ST "L3/L4 fields:"


* **source\_ip**: optional string  
  Source IP address, in the form _xx\[char46]xx\[char46]xx\[char46]xx_ for IPv4 or appropriate colon-separated hexadecimal notation for IPv6\[char46]
* **source\_mask**: optional string  
  Mask that determines which bits of source_ip to match on, in the form _xx\[char46]xx\[char46]xx\[char46]xx_ for IPv4 or appropriate colon-separated hexadecimal notation for IPv6\[char46]
* **dest\_ip**: optional string  
  Destination IP address, in the form _xx\[char46]xx\[char46]xx\[char46]xx_ for IPv4 or appropriate colon-separated hexadecimal notation for IPv6\[char46]
* **dest\_mask**: optional string  
  Mask that determines which bits of dest_ip to match on, in the form _xx\[char46]xx\[char46]xx\[char46]xx_ for IPv4 or appropriate colon-separated hexadecimal notation for IPv6\[char46]
* **protocol**: optional integer  
  Protocol number in the IPv4 header, or value of the "next header" field in the IPv6 header\[char46]
* **source\_port\_min**: optional integer  
  Lower end of the range of source port values\[char46] The value specified is included in the range\[char46]
* **source\_port\_max**: optional integer  
  Upper end of the range of source port values\[char46] The value specified is included in the range\[char46]
* **dest\_port\_min**: optional integer  
  Lower end of the range of destination port values\[char46] The value specified is included in the range\[char46]
* **dest\_port\_max**: optional integer  
  Upper end of the range of destination port values\[char46] The value specified is included in the range\[char46]
* **tcp\_flags**: optional integer  
  Integer representing the value of TCP flags to match\[char46] For example, the SYN flag is the second least significant bit in the TCP flags\[char46] Hence a value of 2 would indicate that the "SYN" flag should be set (assuming an appropriate mask)\[char46]
* **tcp\_flags\_mask**: optional integer  
  Integer representing the mask to apply when matching TCP flags\[char46] For example, a value of 2 would imply that the "SYN" flag should be matched and all other flags ignored\[char46]
* **icmp\_type**: optional integer  
  ICMP type to be matched\[char46]
* **icmp\_code**: optional integer  
  ICMP code to be matched\[char46]
* **direction**: string, either **egress** or **ingress**  
  Direction of traffic to match on the specified port, either "ingress" (toward the logical switch or router) or "egress" (leaving the logical switch or router)\[char46]
* **action**: string, either **deny** or **permit**  
  Action to take for this rule, either "permit" or "deny"\[char46]
  .ST "Error Notification:"



An entry in this column indicates to the NVC that the ACL could not be configured as requested\[char46] The switch must clear this column when the error has been cleared\[char46]

* **acle_fault_status : invalid\_acl\_entry**: none  
  Indicates that an ACL entry requested by the controller could not be instantiated by the switch, e\[char46]g\[char46] because it requires an unsupported combination of fields to be matched\[char46]
* **acle_fault_status : unspecified\_fault**: none  
  Indicates that an error has occurred in configuring the ACL entry but no more specific information is available\[char46]
  .bp

<a name="acl-table"></a>

# Acl Table




Access Control List table\[char46] Each ACL is constructed as a set of entries from the **ACL\_entry** table\[char46] Packets that are not matched by any entry in the ACL are allowed by default\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**acl\_entries**
set of 1 or more **ACL\_entry**s
.TQ 3.00in
**acl\_name**
string (must be unique within table)
.TQ .25in
_Error Notification:_
.TQ 2.75in
**acl_fault_status : invalid\_acl**
none
.TQ 2.75in
**acl_fault_status : resource\_shortage**
none
.TQ 2.75in
**acl_fault_status : unspecified\_fault**
none

<a name="details"></a>

### "Details:


* **acl\_entries**: set of 1 or more **ACL\_entry**s  
  A set of references to entries in the **ACL\_entry** table\[char46]
* **acl\_name**: string (must be unique within table)  
  A human readable name for the ACL, which may (for example) be displayed on the switch CLI\[char46]
  .ST "Error Notification:"



An entry in this column indicates to the NVC that the ACL could not be configured as requested\[char46] The switch must clear this column when the error has been cleared\[char46]

* **acl_fault_status : invalid\_acl**: none  
  Indicates that an ACL requested by the controller could not be instantiated by the switch, e\[char46]g\[char46], because it requires an unsupported combination of fields to be matched\[char46]
* **acl_fault_status : resource\_shortage**: none  
  Indicates that an ACL requested by the controller could not be instantiated by the switch due to a shortage of resources (e\[char46]g\[char46] TCAM space)\[char46]
* **acl_fault_status : unspecified\_fault**: none  
  Indicates that an error has occurred in configuring the ACL but no more specific information is available\[char46]
