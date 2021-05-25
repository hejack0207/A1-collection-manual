# nft(8) - Administration tool of the nftables framework for packet filtering and classification 

"", 17 February 2019

```
'nh nft \kx .if (\nx>(\n(.l/2)) .nr x (\n(.l/5) 'in \n(.iu+\nxu [ -nNscae ] [ -I directory ] [ -f filename | -i |  cmd ...] 'in \n(.iu-\nxu 'hy 'nh nft -h \kx .if (\nx>(\n(.l/2)) .nr x (\n(.l/5) 'in \n(.iu+\nxu 'in \n(.iu-\nxu 'hy 'nh nft -v \kx .if (\nx>(\n(.l/2)) .nr x (\n(.l/5) 'in \n(.iu+\nxu 'in \n(.iu-\nxu 'hy
```

<a name="description"></a>

# Description

nft is the command line tool used to set up, maintain and inspect packet
filtering and classification rules in the Linux kernel, in the nftables framework.
The Linux kernel subsystem is known as nf_tables, and 'nf' stands for Netfilter.

<a name="options"></a>

# Options

For a full summary of options, run **nft --help**.

* **-h, --help**\*(T&gt;  
  Show help message and all options.
* **-v, --version**\*(T&gt;  
  Show version.
* **-n, --numeric**\*(T&gt;  
  Show data numerically. When used once (the default behaviour), skip
  lookup of addresses to symbolic names. Use twice to also show Internet
  services (port numbers) numerically. Use three times to also show
  protocols and UIDs/GIDs numerically.
* **-N, --reversedns**\*(T&gt;  
  Translate IP addresses to names. Usually requires network traffic for DNS lookup.
* **-s, --stateless**\*(T&gt;  
  Omit stateful information of rules and stateful objects.
* **-c, --check**\*(T&gt;  
  Check commands validity without actually applying the changes.
* **-a, --handle**\*(T&gt;  
  Show object handles in output.
* **-e, --echo**\*(T&gt;  
  When inserting items into the ruleset using **add**,
  **insert** or **replace** commands,
  print notifications just like **nft monitor**.
* **-I, --includepath **\*(T&gt;_directory_  
  Add the directory _directory_ to the list of directories to be searched for included files. This option may be specified multiple times.
* **-f, --file **\*(T&gt;_filename_  
  Read input from _filename_. If _filename_ is -\*(T&gt;, read from \*(T&lt;stdin\*(T&gt;.
  
  nft scripts must start **#!/usr/sbin/nft -f**
* **-i, --interactive**\*(T&gt;  
  Read input from an interactive readline CLI. You can use **quit** to exit, or use the EOF\*(T&gt; marker, normally this is \*(T&lt;CTRL-D\*(T&gt;.

<a name="input-file-format"></a>

# Input File Format


<a name="lexical-conventions"></a>

### LEXICAL CONVENTIONS

Input is parsed line-wise. When the last character of a line, just before
the newline character, is a non-quoted backslash (\e\*(T&gt;),
the next line is treated as a continuation. Multiple commands on the
same line can be separated using a semicolon (;\*(T&gt;).

A hash sign (#\*(T&gt;) begins a comment. All following characters
on the same line are ignored.

Identifiers begin with an alphabetic character (a-z,A-Z\*(T&gt;),
followed zero or more alphanumeric characters (a-z,A-Z,0-9\*(T&gt;)
and the characters slash (/\*(T&gt;), backslash (\*(T&lt;\e\*(T&gt;),
underscore (_\*(T&gt;) and dot (\*(T&lt;.\*(T&gt;). Identifiers
using different characters or clashing with a keyword need to be enclosed in
double quotes ("\*(T&gt;).


<a name="include-files"></a>

### INCLUDE FILES

'nh
**include** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
_filename_
'in \n(.iu-\nxu
'hy

Other files can be included by using the **include** statement.
The directories to be searched for include files can be specified using
the **-I/--includepath**\*(T&gt; option. You can override this behaviour
either by prepending ./ to your path to force inclusion of files located in the
current working directory (i.e. relative path) or / for file location expressed
as an absolute path.

If -I/--includepath is not specified, then nft relies on the default directory
that is specified at compile time. You can retrieve this default directory via
-h/--help option.

Include statements support the usual shell wildcard symbols
(*,?,[]\*(T&gt;). Having no matches for an include statement is not
an error, if wildcard symbols are used in the include statement. This allows having
potentially empty include directories for statements like
include "/etc/firewall/rules/*"\*(T&gt;. The wildcard matches are
loaded in alphabetical order. Files beginning with dot (.\*(T&gt;) are
not matched by include statements.

<a name="symbolic-variables"></a>

### SYMBOLIC VARIABLES

'nh
**define** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
variable _expr_
'in \n(.iu-\nxu
'hy
'nh
**$variable** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
'in \n(.iu-\nxu
'hy

Symbolic variables can be defined using the **define** statement.
Variable references are expressions and can be used initialize other variables.
The scope of a definition is the current block and all blocks contained within.

**Using symbolic variables**

    
    define int_if1 = eth0
    define int_if2 = eth1
    define int_ifs = { $int_if1, $int_if2 }
    
    filter input iif $int_ifs accept
    					

<a name="address-families"></a>

# Address Families

Address families determine the type of packets which are processed. For each address
family the kernel contains so called hooks at specific stages of the packet processing
paths, which invoke nftables if rules for these hooks exist.


* **ip**\*(T&gt;  
  IPv4 address family.
* **ip6**\*(T&gt;  
  IPv6 address family.
* **inet**\*(T&gt;  
  Internet (IPv4/IPv6) address family.
* **arp**\*(T&gt;  
  ARP address family, handling IPv4 ARP packets.
* **bridge**\*(T&gt;  
  Bridge address family, handling packets which traverse a bridge device.
* **netdev**\*(T&gt;  
  Netdev address family, handling packets from ingress.

All nftables objects exist in address family specific namespaces, therefore
all identifiers include an address family. If an identifier is specified without
an address family, the ip\*(T&gt; family is used by default.

<a name="ipv4ipv6inet-address-families"></a>

### IPV4/IPV6/INET ADDRESS FAMILIES

The IPv4/IPv6/Inet address families handle IPv4, IPv6 or both types of packets. They
contain five hooks at different packet processing stages in the network stack.

**IPv4/IPv6/Inet address family hooks**
.TS
allbox ;
l | l.
T{
Hook
T}	T{
Description
T}
.T&
l | l.
T{
prerouting
T}	T{
All packets entering the system are processed by the prerouting hook. It is invoked
before the routing process and is used for early filtering or changing packet
attributes that affect routing.
T}
T{
input
T}	T{
Packets delivered to the local system are processed by the input hook.
T}
T{
forward
T}	T{
Packets forwarded to a different host are processed by the forward hook.
T}
T{
output
T}	T{
Packets sent by local processes are processed by the output hook.
T}
T{
postrouting
T}	T{
All packets leaving the system are processed by the postrouting hook.
T}
.TE

<a name="arp-address-family"></a>

### ARP ADDRESS FAMILY

The ARP address family handles ARP packets received and sent by the system. It is commonly used
to mangle ARP packets for clustering.

**ARP address family hooks**
.TS
allbox ;
l | l.
T{
Hook
T}	T{
Description
T}
.T&
l | l
l | l.
T{
input
T}	T{
Packets delivered to the local system are processed by the input hook.
T}
T{
output
T}	T{
Packets send by the local system are processed by the output hook.
T}
.TE

<a name="bridge-address-family"></a>

### BRIDGE ADDRESS FAMILY

The bridge address family handles Ethernet packets traversing bridge devices.

The list of supported hooks is identical to IPv4/IPv6/Inet address families above.

<a name="netdev-address-family"></a>

### NETDEV ADDRESS FAMILY

The Netdev address family handles packets from ingress.

**Netdev address family hooks**
.TS
allbox ;
l | l.
T{
Hook
T}	T{
Description
T}
.T&
l | l.
T{
ingress
T}	T{
All packets entering the system are processed by this hook. It is invoked
before layer 3 protocol handlers and it can be used for early filtering and
policing.
T}
.TE

<a name="ruleset"></a>

# Ruleset

'nh
{list | flush} **ruleset** [_family_]
'hy
'nh
export [**ruleset**] _format_ 
'hy

The **ruleset** keyword is used to identify the whole
set of tables, chains, etc. currently in place in kernel. The
following **ruleset** commands exist:

* **list**\*(T&gt;  
  Print the ruleset in human-readable format.
* **flush**\*(T&gt;  
  Clear the whole ruleset. Note that unlike iptables, this
  will remove all tables and whatever they contain,
  effectively leading to an empty ruleset - no packet
  filtering will happen anymore, so the kernel accepts any
  valid packet it receives.
* **export**\*(T&gt;  
  Print the ruleset in machine readable format. The
  mandatory _format_ parameter
  may be either xml\*(T&gt; or
  json\*(T&gt;.

It is possible to limit **list** and
**flush** to a specific address family only. For a
list of valid family names, see ADDRESS FAMILIES\*(T&gt; above.

Note that contrary to what one might assume, the output generated
by **export** is not parseable by
**nft -f**. Instead, the output of
**list** command serves well for that purpose.

<a name="tables"></a>

# Tables

'nh
{add | create} **table** [_family_] _table_ [
{
flags _flags_
}
]
'hy
'nh
{delete | list | flush} **table** [_family_] _table_
'hy
'nh
delete **table** [_family_] handle _handle_
'hy

Tables are containers for chains, sets and stateful objects. They are identified by their address family
and their name. The address family must be one of
ip\*(T&gt;, \*(T&lt;ip6\*(T&gt;, \*(T&lt;inet\*(T&gt;, \*(T&lt;arp\*(T&gt;, \*(T&lt;bridge\*(T&gt;, \*(T&lt;netdev\*(T&gt;.
The inet\*(T&gt; address family is a dummy family which is used to create
hybrid IPv4/IPv6 tables. The meta\*(T&gt; expression \*(T&lt;nfproto\*(T&gt;
keyword can be used to test which family (IPv4 or IPv6) context the packet is being processed in.
When no address family is specified, ip\*(T&gt; is used by default.
The only difference between **add** and **create** is that the former will
not return an error if the specified table already exists while **create** will return an error.

**Table flags**
.TS
allbox ;
l | l.
T{
Flag
T}	T{
Description
T}
.T&
l | l.
T{
dormant
T}	T{
table is not evaluated any more (base chains are unregistered)
T}
.TE

**Add, change, delete a table**

    
    # start nft in interactive mode
    nft --interactive
    
    # create a new table.
    create table inet mytable
    
    # add a new base chain: get input packets
    add chain inet mytable myin { type filter hook input priority 0; }
    
    # add a single counter to the chain
    add rule inet mytable myin counter
    
    # disable the table temporarily -- rules are not evaluated anymore
    add table inet mytable { flags dormant; }
    
    # make table active again:
    add table inet mytable
    				

* **add**\*(T&gt;  
  Add a new table for the given family with the given name.
* **delete**\*(T&gt;  
  Delete the specified table.
* **list**\*(T&gt;  
  List all chains and rules of the specified table.
* **flush**\*(T&gt;  
  Flush all chains and rules of the specified table.

<a name="chains"></a>

# Chains

'nh
{add | create} **chain** [_family_] _table_ _chain_ [
{
type _type_
hook _hook_
[device _device_]
priority _priority_ ;
[policy _policy_ ;]
}
]
'hy
'nh
{delete | list | flush} **chain** [_family_] _table_ _chain_
'hy
'nh
delete **chain** [_family_] _table_ handle _handle_
'hy
'nh
rename **chain** [_family_] _table_ _chain_ _newname_
'hy

Chains are containers for rules. They exist in two kinds,
base chains and regular chains. A base chain is an entry point for
packets from the networking stack, a regular chain may be used
as jump target and is used for better rule organization.

* **add**\*(T&gt;  
  Add a new chain in the specified table. When a hook and priority
  value are specified, the chain is created as a base chain and hooked
  up to the networking stack.
* **create**\*(T&gt;  
  Similar to the **add** command, but returns an error if the
  chain already exists.
* **delete**\*(T&gt;  
  Delete the specified chain. The chain must not contain any rules or be
  used as jump target.
* **rename**\*(T&gt;  
  Rename the specified chain.
* **list**\*(T&gt;  
  List all rules of the specified chain.
* **flush**\*(T&gt;  
  Flush all rules of the specified chain.

For base chains, **type**, **hook** and **priority** parameters are mandatory.

**Supported chain types**
.TS
allbox ;
l | l | l | l.
T{
Type
T}	T{
Families
T}	T{
Hooks
T}	T{
Description
T}
.T&
l | l | l | l
l | l | l | l
l | l | l | l.
T{
filter
T}	T{
all
T}	T{
all
T}	T{
Standard chain type to use in doubt.
T}
T{
nat
T}	T{
ip, ip6
T}	T{
prerouting, input, output, postrouting
T}	T{
Chains of this type perform Network Address Translation based on conntrack entries. Only the first packet of a connection actually traverses this chain - its rules usually define details of the created conntrack entry (NAT statements for instance).
T}
T{
route
T}	T{
ip, ip6
T}	T{
output
T}	T{
If a packet has traversed a chain of this
type and is about to be accepted, a new route
lookup is performed if relevant parts of the IP
header have changed. This allows to e.g.
implement policy routing selectors in
nftables.
T}
.TE

Apart from the special cases illustrated above (e.g. nat\*(T&gt; type not supporting \*(T&lt;forward\*(T&gt; hook or \*(T&lt;route\*(T&gt; type only supporting \*(T&lt;output\*(T&gt; hook), there are two further quirks worth noticing:

* ·  
  netdev\*(T&gt; family supports merely a single
  combination, namely filter\*(T&gt; type and
  ingress\*(T&gt; hook. Base chains in this family also require the \*(T&lt;device\*(T&gt; parameter to be present since they exist per incoming interface only.
* ·  
  arp\*(T&gt; family supports only
  input\*(T&gt; and \*(T&lt;output\*(T&gt;
  hooks, both in chains of type
  filter\*(T&gt;.

The priority\*(T&gt; parameter accepts a signed integer value which specifies the order in which chains with same \*(T&lt;hook\*(T&gt; value are traversed. The ordering is ascending, i.e. lower priority values have precedence over higher ones.

Base chains also allow to set the chain's policy\*(T&gt;, i.e. what happens to packets not explicitly accepted or refused in contained rules. Supported policy values are \*(T&lt;accept\*(T&gt; (which is the default) or \*(T&lt;drop\*(T&gt;.

<a name="rules"></a>

# Rules

'nh
[add | insert] **rule** [_family_] _table_ _chain_ [
{handle | position}
_handle_
| 
index
_index_
] _statement_...
'hy
'nh
replace **rule** [_family_] _table_ _chain_ handle _handle_ _statement_...
'hy
'nh
delete **rule** [_family_] _table_ _chain_ handle _handle_
'hy

Rules are added to chain\*(T&gt; in the given \*(T&lt;table\*(T&gt;.
If the family\*(T&gt; is not specified, the \*(T&lt;ip\*(T&gt; family
is used.
Rules are constructed from two kinds of components according to a set
of grammatical rules: expressions and statements.

The add\*(T&gt; and \*(T&lt;insert\*(T&gt; commands support an optional
location specifier, which is either a _handle_ of an existing
rule or an _index_ (starting at zero). Internally,
rule locations are always identified by _handle_ and the
translation from _index_ happens in userspace. This has two
potential implications in case a concurrent ruleset change happens after the translation
was done: The effective rule index might change if a rule was inserted or deleted before
the referred one. If the referred rule was deleted, the command is rejected by the
kernel just as if an invalid _handle_ was given.

* **add**\*(T&gt;  
  Add a new rule described by the list of statements. The rule is appended to the
  given chain unless a handle\*(T&gt; is specified, in which case the
  rule is appended to the rule given by the _handle_.
  The alternative name position\*(T&gt; is deprecated and should not be
  used anymore.
* **insert**\*(T&gt;  
  Similar to the **add** command, but the rule is prepended to the
  beginning of the chain or before the rule with the given
  _handle_.
* **replace**\*(T&gt;  
  Similar to the **add** command, but the rule replaces the specified rule.
* **delete**\*(T&gt;  
  Delete the specified rule.

**add a rule to ip table input chain**

    
    nft add rule filter output ip daddr 192.168.0.0/24 accept # 'ip filter' is assumed
    # same command, slightly more verbose
    nft add rule ip filter output ip daddr 192.168.0.0/24 accept
    
    				

**delete rule from inet table**

    
    # nft -a list ruleset
    table inet filter {
            chain input {
                    type filter hook input priority 0; policy accept;
                    ct state established,related accept # handle 4
                    ip saddr 10.1.1.1 tcp dport ssh accept # handle 5
    		...
    # delete the rule with handle 5
    # nft delete rule inet filter input handle 5
    				

<a name="sets"></a>

# Sets

nftables offers two kinds of set concepts.
Anonymous sets are sets that have no specific name. The set members are enclosed in curly braces,
with commas to separate elements when creating the rule the set is used in.
Once that rule is removed, the set is removed as well.
They cannot be updated, i.e. once an anonymous set is declared it cannot be changed anymore except by
removing/altering the rule that uses the anonymous set.

**Using anonymous sets to accept particular subnets and ports**

    
            nft add rule filter input ip saddr { 10.0.0.0/8, 192.168.0.0/16 } tcp dport { 22, 443 } accept
    			

Named sets are sets that need to be defined first before they can be referenced
in rules. Unlike anonymous sets, elements can be added to or removed from a named set at any time.
Sets are referenced from rules using an @\*(T&gt; prefixed to the sets name.

**Using named sets to accept addresses and ports**

    
            nft add rule filter input ip saddr @allowed_hosts tcp dport @allowed_ports accept
    				

The sets allowed_hosts\*(T&gt; and \*(T&lt;allowed_ports\*(T&gt; need to
be created first. The next section describes nft set syntax in more detail.

'nh
add **set** [_family_] _table_ _set_
{ type
_type_ ;
[flags _flags_ ;] [timeout _timeout_ ;] [gc-interval _gc-interval_ ;] [elements = { _element_[,...] } ;] [size _size_ ;] [policy _policy_ ;] [auto-merge _auto-merge_ ;]
}
'hy
'nh
{delete | list | flush} **set** [_family_] _table_ _set_
'hy
'nh
delete **set** [_family_] _table_ handle _handle_
'hy
'nh
{add | delete} **element** [_family_] _table_ _set_
{
_element_[,...] }
'hy

Sets are elements containers of an user-defined data type, they are uniquely identified by an user-defined name and attached to tables.

* **add**\*(T&gt;  
  Add a new set in the specified table.
* **delete**\*(T&gt;  
  Delete the specified set.
* **list**\*(T&gt;  
  Display the elements in the specified set.
* **flush**\*(T&gt;  
  Remove all elements from the specified set.
* **add element**\*(T&gt;  
  Comma-separated list of elements to add into the specified set.
* **delete element**\*(T&gt;  
  Comma-separated list of elements to delete from the specified set.

**Set specifications**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
type
T}	T{
data type of set elements
T}	T{
string: ipv4_addr, ipv6_addr, ether_addr, inet_proto, inet_service, mark
T}
T{
flags
T}	T{
set flags
T}	T{
string: constant, interval, timeout
T}
T{
timeout
T}	T{
time an element stays in the set, mandatory if set is added to from the packet path (ruleset).
T}	T{
string, decimal followed by unit. Units are: d, h, m, s
T}
T{
gc-interval
T}	T{
garbage collection interval, only available when timeout or flag timeout are active
T}	T{
string, decimal followed by unit. Units are: d, h, m, s
T}
T{
elements
T}	T{
elements contained by the set
T}	T{
set data type
T}
T{
size
T}	T{
maximum number of elements in the set, mandatory if set is added to from the packet path (ruleset).
T}	T{
unsigned integer (64 bit)
T}
T{
policy
T}	T{
set policy
T}	T{
string: performance [default], memory
T}
T{
auto-merge
T}	T{
automatic merge of adjacent/overlapping set elements (only for interval sets)
T}	T{
T}
.TE

<a name="maps"></a>

# Maps

'nh
add **map** [_family_] _table_ _map_
{ type
_type_ [flags _flags_ ;] [elements = { _element_[,...] } ;] [size _size_ ;] [policy _policy_ ;]
}
'hy
'nh
{delete | list | flush} **map** [_family_] _table_ _map_
'hy
'nh
{add | delete} **element** [_family_] _table_ _map_
{
elements = { _element_[,...] } ;
}
'hy

Maps store data based on some specific key used as input, they are uniquely identified by an user-defined name and attached to tables.

* **add**\*(T&gt;  
  Add a new map in the specified table.
* **delete**\*(T&gt;  
  Delete the specified map.
* **list**\*(T&gt;  
  Display the elements in the specified map.
* **flush**\*(T&gt;  
  Remove all elements from the specified map.
* **add element**\*(T&gt;  
  Comma-separated list of elements to add into the specified map.
* **delete element**\*(T&gt;  
  Comma-separated list of element keys to delete from the specified map.

**Map specifications**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
type
T}	T{
data type of map elements
T}	T{
string ':' string: ipv4_addr, ipv6_addr, ether_addr, inet_proto, inet_service, mark, counter, quota. Counter and quota can't be used as keys
T}
T{
flags
T}	T{
map flags
T}	T{
string: constant, interval
T}
T{
elements
T}	T{
elements contained by the map
T}	T{
map data type
T}
T{
size
T}	T{
maximum number of elements in the map
T}	T{
unsigned integer (64 bit)
T}
T{
policy
T}	T{
map policy
T}	T{
string: performance [default], memory
T}
.TE

<a name="flowtables"></a>

# Flowtables

'nh
{add | create} **flowtable** [_family_] _table_ _flowtable_ {
hook _hook_
priority _priority_ ;
devices = { _device_[,...] } ;
}
'hy
'nh
{delete | list} **flowtable** [_family_] _table_ _flowtable_
'hy

Flowtables allow you to accelerate packet forwarding in software.
Flowtables entries are represented through a tuple that is composed of the
input interface, source and destination address, source and destination
port; and layer 3/4 protocols. Each entry also caches the destination
interface and the gateway address - to update the destination link-layer
address - to forward packets. The ttl and hoplimit fields are also
decremented. Hence, flowtables provides an alternative path that allow
packets to bypass the classic forwarding path. Flowtables reside in the
ingress hook, that is located before the prerouting hook. You can select
what flows you want to offload through the flow offload\*(T&gt;
expression from the forward\*(T&gt; chain. Flowtables are
identified by their address family and their name. The address family
must be one of
ip\*(T&gt;, \*(T&lt;ip6\*(T&gt;, \*(T&lt;inet\*(T&gt;.
The inet\*(T&gt; address family is a dummy family which is used to create
hybrid IPv4/IPv6 tables.
When no address family is specified, ip\*(T&gt; is used by default.

* **add**\*(T&gt;  
  Add a new flowtable for the given family with the given name.
* **delete**\*(T&gt;  
  Delete the specified flowtable.
* **list**\*(T&gt;  
  List all flowtables.

<a name="stateful-objects"></a>

# Stateful Objects

'nh
{add | delete | list | reset} **type** [_family_] _table_ _object_
'hy
'nh
delete **type** [_family_] _table_ handle _handle_
'hy

Stateful objects are attached to tables and are identified by an unique name. They group stateful information from rules, to reference them in rules the keywords "type name" are used e.g. "counter name".

* **add**\*(T&gt;  
  Add a new stateful object in the specified table.
* **delete**\*(T&gt;  
  Delete the specified object.
* **list**\*(T&gt;  
  Display stateful information the object holds.
* **reset**\*(T&gt;  
  List-and-reset stateful object.

<a name="ct"></a>

### CT

'nh
**ct** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
helper _helper_ { type _type_ protocol _protocol_ ; [l3proto _family_ ;] }
'in \n(.iu-\nxu
'hy

Ct helper is used to define connection tracking helpers that can then be used in combination with the "ct helper set"\*(T&gt; statement.
type and protocol are mandatory, l3proto is derived from the table family by default, i.e. in the inet table the kernel will
try to load both the IPv4 and IPv6 helper backends, if they are supported by the kernel.

**conntrack helper specifications**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l
l | l | l.
T{
type
T}	T{
name of helper type
T}	T{
quoted string (e.g. "ftp")
T}
T{
protocol
T}	T{
layer 4 protocol of the helper
T}	T{
string (e.g. tcp)
T}
T{
l3proto
T}	T{
layer 3 protocol of the helper
T}	T{
address family (e.g. ip)
T}
.TE

**defining and assigning ftp helper**

Unlike iptables, helper assignment needs to be performed after the conntrack lookup has completed, for example
with the default 0 hook priority.

    
    table inet myhelpers {
      ct helper ftp-standard {
         type "ftp" protocol tcp
      }
      chain prerouting {
          type filter hook prerouting priority 0;
          tcp dport 21 ct helper set "ftp-standard"
      }
    }
    				

<a name="counter"></a>

### COUNTER

'nh
**counter** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[packets bytes]
'in \n(.iu-\nxu
'hy

**Counter specifications**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l.
T{
packets
T}	T{
initial count of packets
T}	T{
unsigned integer (64 bit)
T}
T{
bytes
T}	T{
initial count of bytes
T}	T{
unsigned integer (64 bit)
T}
.TE

<a name="quota"></a>

### QUOTA

'nh
**quota** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[over | until] [used]
'in \n(.iu-\nxu
'hy

**Quota specifications**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l.
T{
quota
T}	T{
quota limit, used as the quota name
T}	T{
Two arguments, unsigned integer (64 bit) and string: bytes, kbytes, mbytes. "over" and "until" go before these arguments
T}
T{
used
T}	T{
initial value of used quota
T}	T{
Two arguments, unsigned integer (64 bit) and string: bytes, kbytes, mbytes
T}
.TE

<a name="expressions"></a>

# Expressions

Expressions represent values, either constants like network addresses, port numbers etc. or data
gathered from the packet during ruleset evaluation. Expressions can be combined using binary,
logical, relational and other types of expressions to form complex or relational (match) expressions.
They are also used as arguments to certain types of operations, like NAT, packet marking etc.

Each expression has a data type, which determines the size, parsing and representation of
symbolic values and type compatibility with other expressions.

<a name="describe-command"></a>

### DESCRIBE COMMAND

'nh
**describe** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
_expression_
'in \n(.iu-\nxu
'hy

The **describe** command shows information about the type of an expression and
its data type.

**The describe command**

    
    $ nft describe tcp flags
    payload expression, datatype tcp_flag (TCP flag) (basetype bitmask, integer), 8 bits
    
    predefined symbolic constants:
    fin                           	0x01
    syn                           	0x02
    rst                           	0x04
    psh                           	0x08
    ack                           	0x10
    urg                           	0x20
    ecn                           	0x40
    cwr                           	0x80
    				

<a name="data-types"></a>

# Data Types

Data types determine the size, parsing and representation of symbolic values and type compatibility
of expressions. A number of global data types exist, in addition some expression types define further
data types specific to the expression type. Most data types have a fixed size, some however may have
a dynamic size, f.i. the string type.

Types may be derived from lower order types, f.i. the IPv4 address type is derived from the integer
type, meaning an IPv4 address can also be specified as an integer value.

In certain contexts (set and map definitions) it is necessary to explicitly specify a data type.
Each type has a name which is used for this.

<a name="integer-type"></a>

### INTEGER TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
Integer
T}	T{
integer
T}	T{
variable
T}	T{
-
T}
.TE

The integer type is used for numeric values. It may be specified as decimal, hexadecimal
or octal number. The integer type doesn't have a fixed size, its size is determined by the
expression for which it is used.

<a name="bitmask-type"></a>

### BITMASK TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
Bitmask
T}	T{
bitmask
T}	T{
variable
T}	T{
integer
T}
.TE

The bitmask type (**bitmask**) is used for bitmasks. 

<a name="string-type"></a>

### STRING TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
String
T}	T{
string
T}	T{
variable
T}	T{
-
T}
.TE

The string type is used to for character strings. A string begins with an alphabetic character
(a-zA-Z) followed by zero or more alphanumeric characters or the characters /\*(T&gt;,
-\*(T&gt;, \*(T&lt;_\*(T&gt; and \*(T&lt;.\*(T&gt;. In addition anything enclosed
in double quotes ("\*(T&gt;) is recognized as a string.

**String specification**

    
    # Interface name
    filter input iifname eth0
    
    # Weird interface name
    filter input iifname "(eth0)"
    				

<a name="link-layer-address-type"></a>

### LINK LAYER ADDRESS TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
Link layer address
T}	T{
lladdr
T}	T{
variable
T}	T{
integer
T}
.TE

The link layer address type is used for link layer addresses. Link layer addresses are specified
as a variable amount of groups of two hexadecimal digits separated using colons (:\*(T&gt;).

**Link layer address specification**

    
    # Ethernet destination MAC address
    filter input ether daddr 20:c9:d0:43:12:d9
    				

<a name="ipv4-address-type"></a>

### IPV4 ADDRESS TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
IPv4 address
T}	T{
ipv4_addr
T}	T{
32 bit
T}	T{
integer
T}
.TE

The IPv4 address type is used for IPv4 addresses. Addresses are specified in either dotted decimal,
dotted hexadecimal, dotted octal, decimal, hexadecimal, octal notation or as a host name. A host name
will be resolved using the standard system resolver.

**IPv4 address specification**

    
    # dotted decimal notation
    filter output ip daddr 127.0.0.1
    
    # host name
    filter output ip daddr localhost
    				

<a name="ipv6-address-type"></a>

### IPV6 ADDRESS TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
IPv6 address
T}	T{
ipv6_addr
T}	T{
128 bit
T}	T{
integer
T}
.TE

The IPv6 address type is used for IPv6 addresses.
Addresses are specified as a host name or as hexadecimal halfwords separated
by colons. Addresses might be enclosed in square brackets ("[]") to differentiate them
from port numbers.

**IPv6 address specificationIPv6 address specification with bracket notation**

    
    # abbreviated loopback address
    filter output ip6 daddr ::1
    				

    
    # without [] the port number (22) would be parsed as part of ipv6 address
    ip6 nat prerouting tcp dport 2222 dnat to [1ce::d0]:22
    				

<a name="boolean-type"></a>

### BOOLEAN TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
Boolean
T}	T{
boolean
T}	T{
1 bit
T}	T{
integer
T}
.TE

The boolean type is a syntactical helper type in user space.
It's use is in the right-hand side of a (typically implicit)
relational expression to change the expression on the left-hand
side into a boolean check (usually for existence).

The following keywords will automatically resolve into a boolean
type with given value:
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l
l | l.
T{
exists
T}	T{
1
T}
T{
missing
T}	T{
0
T}
.TE

**Boolean specification**

The following expressions support a boolean comparison:
.TS
allbox ;
l | l.
T{
Expression
T}	T{
Behaviour
T}
.T&
l | l
l | l
l | l.
T{
fib
T}	T{
Check route existence.
T}
T{
exthdr
T}	T{
Check IPv6 extension header existence.
T}
T{
tcp option
T}	T{
Check TCP option header existence.
T}
.TE

    
    # match if route exists
    filter input fib daddr . iif oif exists
    
    # match only non-fragmented packets in IPv6 traffic
    filter input exthdr frag missing
    
    # match if TCP timestamp option is present
    filter input tcp option timestamp exists
    				

<a name="icmp-type-type"></a>

### ICMP TYPE TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
ICMP Type
T}	T{
icmp_type
T}	T{
8 bit
T}	T{
integer
T}
.TE

The ICMP Type type is used to conveniently specify the ICMP header's type field.

The following keywords may be used when specifying the ICMP type:
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l.
T{
echo-reply
T}	T{
0
T}
T{
destination-unreachable
T}	T{
3
T}
T{
source-quench
T}	T{
4
T}
T{
redirect
T}	T{
5
T}
T{
echo-request
T}	T{
8
T}
T{
router-advertisement
T}	T{
9
T}
T{
router-solicitation
T}	T{
10
T}
T{
time-exceeded
T}	T{
11
T}
T{
parameter-problem
T}	T{
12
T}
T{
timestamp-request
T}	T{
13
T}
T{
timestamp-reply
T}	T{
14
T}
T{
info-request
T}	T{
15
T}
T{
info-reply
T}	T{
16
T}
T{
address-mask-request
T}	T{
17
T}
T{
address-mask-reply
T}	T{
18
T}
.TE

**ICMP Type specification**

    
    # match ping packets
    filter output icmp type { echo-request, echo-reply }
    				

<a name="icmp-code-type"></a>

### ICMP CODE TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
ICMP Code
T}	T{
icmp_code
T}	T{
8 bit
T}	T{
integer
T}
.TE

The ICMP Code type is used to conveniently specify the ICMP header's code field.

The following keywords may be used when specifying the ICMP code:
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l.
T{
net-unreachable
T}	T{
0
T}
T{
host-unreachable
T}	T{
1
T}
T{
prot-unreachable
T}	T{
2
T}
T{
port-unreachable
T}	T{
3
T}
T{
net-prohibited
T}	T{
9
T}
T{
host-prohibited
T}	T{
10
T}
T{
admin-prohibited
T}	T{
13
T}
.TE

<a name="icmpv6-type-type"></a>

### ICMPV6 TYPE TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
ICMPv6 Type
T}	T{
icmpv6_type
T}	T{
8 bit
T}	T{
integer
T}
.TE

The ICMPv6 Type type is used to conveniently specify the ICMPv6 header's type field.

The following keywords may be used when specifying the ICMPv6 type:
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l.
T{
destination-unreachable
T}	T{
1
T}
T{
packet-too-big
T}	T{
2
T}
T{
time-exceeded
T}	T{
3
T}
T{
parameter-problem
T}	T{
4
T}
T{
echo-request
T}	T{
128
T}
T{
echo-reply
T}	T{
129
T}
T{
mld-listener-query
T}	T{
130
T}
T{
mld-listener-report
T}	T{
131
T}
T{
mld-listener-done
T}	T{
132
T}
T{
mld-listener-reduction
T}	T{
132
T}
T{
nd-router-solicit
T}	T{
133
T}
T{
nd-router-advert
T}	T{
134
T}
T{
nd-neighbor-solicit
T}	T{
135
T}
T{
nd-neighbor-advert
T}	T{
136
T}
T{
nd-redirect
T}	T{
137
T}
T{
router-renumbering
T}	T{
138
T}
T{
ind-neighbor-solicit
T}	T{
141
T}
T{
ind-neighbor-advert
T}	T{
142
T}
T{
mld2-listener-report
T}	T{
143
T}
.TE

**ICMPv6 Type specification**

    
    # match ICMPv6 ping packets
    filter output icmpv6 type { echo-request, echo-reply }
    				

<a name="icmpv6-code-type"></a>

### ICMPV6 CODE TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
ICMPv6 Code
T}	T{
icmpv6_code
T}	T{
8 bit
T}	T{
integer
T}
.TE

The ICMPv6 Code type is used to conveniently specify the ICMPv6 header's code field.

The following keywords may be used when specifying the ICMPv6 code:
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l.
T{
no-route
T}	T{
0
T}
T{
admin-prohibited
T}	T{
1
T}
T{
addr-unreachable
T}	T{
3
T}
T{
port-unreachable
T}	T{
4
T}
T{
policy-fail
T}	T{
5
T}
T{
reject-route
T}	T{
6
T}
.TE

<a name="icmpvx-code-type"></a>

### ICMPVX CODE TYPE

.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
ICMPvX Code
T}	T{
icmpx_code
T}	T{
8 bit
T}	T{
integer
T}
.TE

The ICMPvX Code type abstraction is a set of values which
overlap between ICMP and ICMPv6 Code types to be used from the
inet family.

The following keywords may be used when specifying the ICMPvX code:
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l.
T{
no-route
T}	T{
0
T}
T{
port-unreachable
T}	T{
1
T}
T{
host-unreachable
T}	T{
2
T}
T{
admin-prohibited
T}	T{
3
T}
.TE

<a name="conntrack-types"></a>

### CONNTRACK TYPES

This is an overview of types used in **ct**
expression and statement:
.TS
allbox ;
l | l | l | l.
T{
Name
T}	T{
Keyword
T}	T{
Size
T}	T{
Base type
T}
.T&
l | l | l | l.
T{
conntrack state
T}	T{
ct_state
T}	T{
4 byte
T}	T{
bitmask
T}
T{
conntrack direction
T}	T{
ct_dir
T}	T{
8 bit
T}	T{
integer
T}
T{
conntrack status
T}	T{
ct_status
T}	T{
4 byte
T}	T{
bitmask
T}
T{
conntrack event bits
T}	T{
ct_event
T}	T{
4 byte
T}	T{
bitmask
T}
T{
conntrack label
T}	T{
ct_label
T}	T{
128 bit
T}	T{
bitmask
T}
.TE

For each of the types above, keywords are available for convenience:

**conntrack state (ct\_state)**
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l.
T{
invalid
T}	T{
1
T}
T{
established
T}	T{
2
T}
T{
related
T}	T{
4
T}
T{
new
T}	T{
8
T}
T{
untracked
T}	T{
64
T}
.TE

**conntrack direction (ct\_dir)**
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l
l | l.
T{
original
T}	T{
0
T}
T{
reply
T}	T{
1
T}
.TE

**conntrack status (ct\_status)**
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l.
T{
expected
T}	T{
1
T}
T{
seen-reply
T}	T{
2
T}
T{
assured
T}	T{
4
T}
T{
confirmed
T}	T{
8
T}
T{
snat
T}	T{
16
T}
T{
dnat
T}	T{
32
T}
T{
dying
T}	T{
512
T}
.TE

**conntrack event bits (ct\_event)**
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Value
T}
.T&
l | l.
T{
new
T}	T{
1
T}
T{
related
T}	T{
2
T}
T{
destroy
T}	T{
4
T}
T{
reply
T}	T{
8
T}
T{
assured
T}	T{
16
T}
T{
protoinfo
T}	T{
32
T}
T{
helper
T}	T{
64
T}
T{
mark
T}	T{
128
T}
T{
seqadj
T}	T{
256
T}
T{
secmark
T}	T{
512
T}
T{
label
T}	T{
1024
T}
.TE

Possible keywords for conntrack label type
(**ct\_label**) are read at runtime from
/etc/connlabel.conf\*(T&gt;.

<a name="primary-expressions"></a>

# Primary Expressions

The lowest order expression is a primary expression, representing either a constant or a single
datum from a packet's payload, meta data or a stateful module. 

<a name="meta-expressions"></a>

### META EXPRESSIONS

'nh
**meta** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{length | nfproto | l4proto | protocol | priority}
'in \n(.iu-\nxu
'hy
'nh
[meta] {mark | iif | iifname | iiftype | oif | oifname | oiftype | skuid | skgid | nftrace | rtclassid | ibrname | obrname | pkttype | cpu | iifgroup | oifgroup | cgroup | random | secpath}
'hy

A meta expression refers to meta data associated with a packet.

There are two types of meta expressions: unqualified and qualified meta expressions.
Qualified meta expressions require the **meta** keyword before the
meta key, unqualified meta expressions can be specified by using the meta key directly
or as qualified meta expressions.
Meta l4proto is useful to match a particular transport protocol that is part of either
an IPv4 or IPv6 packet. It will also skip any IPv6 extension headers present in an IPv6 packet.

**Meta expression types**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
length
T}	T{
Length of the packet in bytes
T}	T{
integer (32 bit)
T}
T{
nfproto
T}	T{
real hook protocol family, useful only in inet table
T}	T{
integer (32 bit)
T}
T{
l4proto
T}	T{
layer 4 protocol, skips ipv6 extension headers
T}	T{
integer (8 bit)
T}
T{
protocol
T}	T{
EtherType protocol value
T}	T{
ether_type
T}
T{
priority
T}	T{
TC packet priority
T}	T{
tc_handle
T}
T{
mark
T}	T{
Packet mark
T}	T{
mark
T}
T{
iif
T}	T{
Input interface index
T}	T{
iface_index
T}
T{
iifname
T}	T{
Input interface name
T}	T{
ifname
T}
T{
iiftype
T}	T{
Input interface type
T}	T{
iface_type
T}
T{
oif
T}	T{
Output interface index
T}	T{
iface_index
T}
T{
oifname
T}	T{
Output interface name
T}	T{
ifname
T}
T{
oiftype
T}	T{
Output interface hardware type
T}	T{
iface_type
T}
T{
skuid
T}	T{
UID associated with originating socket
T}	T{
uid
T}
T{
skgid
T}	T{
GID associated with originating socket
T}	T{
gid
T}
T{
rtclassid
T}	T{
Routing realm
T}	T{
realm
T}
T{
ibrname
T}	T{
Input bridge interface name
T}	T{
ifname
T}
T{
obrname
T}	T{
Output bridge interface name
T}	T{
ifname
T}
T{
pkttype
T}	T{
packet type
T}	T{
pkt_type
T}
T{
cpu
T}	T{
cpu number processing the packet
T}	T{
integer (32 bits)
T}
T{
iifgroup
T}	T{
incoming device group
T}	T{
devgroup
T}
T{
oifgroup
T}	T{
outgoing device group
T}	T{
devgroup
T}
T{
cgroup
T}	T{
control group id
T}	T{
integer (32 bits)
T}
T{
random
T}	T{
pseudo-random number
T}	T{
integer (32 bits)
T}
T{
secpath
T}	T{
boolean
T}	T{
boolean (1 bit)
T}
.TE

**Meta expression specific types**
.TS
allbox ;
l | l.
T{
Type
T}	T{
Description
T}
.T&
l | l.
T{
iface_index
T}	T{
Interface index (32 bit number). Can be specified numerically
or as name of an existing interface.
T}
T{
ifname
T}	T{
Interface name (16 byte string). Does not have to exist.
T}
T{
iface_type
T}	T{
Interface type (16 bit number).
T}
T{
uid
T}	T{
User ID (32 bit number). Can be specified numerically or as
user name.
T}
T{
gid
T}	T{
Group ID (32 bit number). Can be specified numerically or as
group name.
T}
T{
realm
T}	T{
Routing Realm (32 bit number). Can be specified numerically
or as symbolic name defined in /etc/iproute2/rt_realms.
T}
T{
devgroup_type
T}	T{
Device group (32 bit number). Can be specified numerically
or as symbolic name defined in /etc/iproute2/group.
T}
T{
pkt_type
T}	T{
Packet type: Unicast (addressed to local host),
Broadcast (to all), Multicast (to group).
T}
.TE

**Using meta expressions**

    
    # qualified meta expression
    filter output meta oif eth0
    
    # unqualified meta expression
    filter output oif eth0
    
    # packed was subject to ipsec processing
    raw prerouting meta secpath exists accept
    					

<a name="fib-expressions"></a>

### FIB EXPRESSIONS

'nh
**fib** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{saddr | daddr | {mark | iif | oif}} {oif | oifname | type}
'in \n(.iu-\nxu
'hy

A fib expression queries the fib (forwarding information base)
to obtain information such as the output interface index a particular address would use. The input is a tuple of elements that is used as input to the fib lookup
functions.

**fib expression specific types**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l
l | l | l.
T{
oif
T}	T{
Output interface index
T}	T{
integer (32 bit)
T}
T{
oifname
T}	T{
Output interface name
T}	T{
string
T}
T{
type
T}	T{
Address type
T}	T{
fib_addrtype
T}
.TE

**Using fib expressions**

    
    # drop packets without a reverse path
    filter prerouting fib saddr . iif oif missing drop
    
    # drop packets to address not configured on ininterface
    filter prerouting fib daddr . iif type != { local, broadcast, multicast } drop
    
    # perform lookup in a specific 'blackhole' table (0xdead, needs ip appropriate ip rule)
    filter prerouting meta mark set 0xdead fib daddr . mark type vmap { blackhole : drop, prohibit : jump prohibited, unreachable : drop }
    					

<a name="routing-expressions"></a>

### ROUTING EXPRESSIONS

'nh
**rt** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{classid | nexthop}
'in \n(.iu-\nxu
'hy

A routing expression refers to routing data associated with a packet.

**Routing expression types**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l
l | l | l.
T{
classid
T}	T{
Routing realm
T}	T{
realm
T}
T{
nexthop
T}	T{
Routing nexthop
T}	T{
ipv4_addr/ipv6_addr
T}
T{
mtu
T}	T{
TCP maximum segment size of route
T}	T{
integer (16 bit)
T}
.TE

**Routing expression specific types**
.TS
allbox ;
l | l.
T{
Type
T}	T{
Description
T}
.T&
l | l.
T{
realm
T}	T{
Routing Realm (32 bit number). Can be specified numerically
or as symbolic name defined in /etc/iproute2/rt_realms.
T}
.TE

**Using routing expressions**

    
    # IP family independent rt expression
    filter output rt classid 10
    
    # IP family dependent rt expressions
    ip filter output rt nexthop 192.168.0.1
    ip6 filter output rt nexthop fd00::1
    inet filter output rt ip nexthop 192.168.0.1
    inet filter output rt ip6 nexthop fd00::1
    					

<a name="payload-expressions"></a>

# Payload Expressions

Payload expressions refer to data from the packet's payload.

<a name="ethernet-header-expression"></a>

### ETHERNET HEADER EXPRESSION

'nh
**ether** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_Ethernet header field_]
'in \n(.iu-\nxu
'hy

**Ethernet header expression types**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l
l | l | l.
T{
daddr
T}	T{
Destination MAC address
T}	T{
ether_addr
T}
T{
saddr
T}	T{
Source MAC address
T}	T{
ether_addr
T}
T{
type
T}	T{
EtherType
T}	T{
ether_type
T}
.TE

<a name="vlan-header-expression"></a>

### VLAN HEADER EXPRESSION

'nh
**vlan** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_VLAN header field_]
'in \n(.iu-\nxu
'hy

**VLAN header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
id
T}	T{
VLAN ID (VID)
T}	T{
integer (12 bit)
T}
T{
cfi
T}	T{
Canonical Format Indicator
T}	T{
integer (1 bit)
T}
T{
pcp
T}	T{
Priority code point
T}	T{
integer (3 bit)
T}
T{
type
T}	T{
EtherType
T}	T{
ether_type
T}
.TE

<a name="arp-header-expression"></a>

### ARP HEADER EXPRESSION

'nh
**arp** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_ARP header field_]
'in \n(.iu-\nxu
'hy

**ARP header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
htype
T}	T{
ARP hardware type
T}	T{
integer (16 bit)
T}
T{
ptype
T}	T{
EtherType
T}	T{
ether_type
T}
T{
hlen
T}	T{
Hardware address len
T}	T{
integer (8 bit)
T}
T{
plen
T}	T{
Protocol address len
T}	T{
integer (8 bit)
T}
T{
operation
T}	T{
Operation
T}	T{
arp_op
T}
.TE

<a name="ipv4-header-expression"></a>

### IPV4 HEADER EXPRESSION

'nh
**ip** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_IPv4 header field_]
'in \n(.iu-\nxu
'hy

**IPv4 header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
version
T}	T{
IP header version (4)
T}	T{
integer (4 bit)
T}
T{
hdrlength
T}	T{
IP header length including options
T}	T{
integer (4 bit) FIXME scaling
T}
T{
dscp
T}	T{
Differentiated Services Code Point
T}	T{
dscp
T}
T{
ecn
T}	T{
Explicit Congestion Notification
T}	T{
ecn
T}
T{
length
T}	T{
Total packet length
T}	T{
integer (16 bit)
T}
T{
id
T}	T{
IP ID
T}	T{
integer (16 bit)
T}
T{
frag-off
T}	T{
Fragment offset
T}	T{
integer (16 bit)
T}
T{
ttl
T}	T{
Time to live
T}	T{
integer (8 bit)
T}
T{
protocol
T}	T{
Upper layer protocol
T}	T{
inet_proto
T}
T{
checksum
T}	T{
IP header checksum
T}	T{
integer (16 bit)
T}
T{
saddr
T}	T{
Source address
T}	T{
ipv4_addr
T}
T{
daddr
T}	T{
Destination address
T}	T{
ipv4_addr
T}
.TE

<a name="icmp-header-expression"></a>

### ICMP HEADER EXPRESSION

'nh
**icmp** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_ICMP header field_]
'in \n(.iu-\nxu
'hy

**ICMP header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
type
T}	T{
ICMP type field
T}	T{
icmp_type
T}
T{
code
T}	T{
ICMP code field
T}	T{
integer (8 bit)
T}
T{
checksum
T}	T{
ICMP checksum field
T}	T{
integer (16 bit)
T}
T{
id
T}	T{
ID of echo request/response
T}	T{
integer (16 bit)
T}
T{
sequence
T}	T{
sequence number of echo request/response
T}	T{
integer (16 bit)
T}
T{
gateway
T}	T{
gateway of redirects
T}	T{
integer (32 bit)
T}
T{
mtu
T}	T{
MTU of path MTU discovery
T}	T{
integer (16 bit)
T}
.TE

<a name="ipv6-header-expression"></a>

### IPV6 HEADER EXPRESSION

'nh
**ip6** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_IPv6 header field_]
'in \n(.iu-\nxu
'hy

This expression refers to the ipv6 header fields.
Caution when using **ip6 nexthdr**, the value only refers to
the next header, i.e. **ip6 nexthdr tcp** will only match if the ipv6 packet does not
contain any extension headers. Packets that are fragmented or e.g. contain a routing extension headers
will not be matched.
Please use **meta l4proto** if you wish to match the real transport header and
ignore any additional extension headers instead.

**IPv6 header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
version
T}	T{
IP header version (6)
T}	T{
integer (4 bit)
T}
T{
dscp
T}	T{
Differentiated Services Code Point
T}	T{
dscp
T}
T{
ecn
T}	T{
Explicit Congestion Notification
T}	T{
ecn
T}
T{
flowlabel
T}	T{
Flow label
T}	T{
integer (20 bit)
T}
T{
length
T}	T{
Payload length
T}	T{
integer (16 bit)
T}
T{
nexthdr
T}	T{
Nexthdr protocol
T}	T{
inet_proto
T}
T{
hoplimit
T}	T{
Hop limit
T}	T{
integer (8 bit)
T}
T{
saddr
T}	T{
Source address
T}	T{
ipv6_addr
T}
T{
daddr
T}	T{
Destination address
T}	T{
ipv6_addr
T}
.TE

**matching if first extension header indicates a fragment**

    
    ip6 nexthdr ipv6-frag counter
    					

<a name="icmpv6-header-expression"></a>

### ICMPV6 HEADER EXPRESSION

'nh
**icmpv6** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_ICMPv6 header field_]
'in \n(.iu-\nxu
'hy

**ICMPv6 header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
type
T}	T{
ICMPv6 type field
T}	T{
icmpv6_type
T}
T{
code
T}	T{
ICMPv6 code field
T}	T{
integer (8 bit)
T}
T{
checksum
T}	T{
ICMPv6 checksum field
T}	T{
integer (16 bit)
T}
T{
parameter-problem
T}	T{
pointer to problem
T}	T{
integer (32 bit)
T}
T{
packet-too-big
T}	T{
oversized MTU
T}	T{
integer (32 bit)
T}
T{
id
T}	T{
ID of echo request/response
T}	T{
integer (16 bit)
T}
T{
sequence
T}	T{
sequence number of echo request/response
T}	T{
integer (16 bit)
T}
T{
max-delay
T}	T{
maximum response delay of MLD queries
T}	T{
integer (16 bit)
T}
.TE

<a name="tcp-header-expression"></a>

### TCP HEADER EXPRESSION

'nh
**tcp** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_TCP header field_]
'in \n(.iu-\nxu
'hy

**TCP header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
sport
T}	T{
Source port
T}	T{
inet_service
T}
T{
dport
T}	T{
Destination port
T}	T{
inet_service
T}
T{
sequence
T}	T{
Sequence number
T}	T{
integer (32 bit)
T}
T{
ackseq
T}	T{
Acknowledgement number
T}	T{
integer (32 bit)
T}
T{
doff
T}	T{
Data offset
T}	T{
integer (4 bit) FIXME scaling
T}
T{
reserved
T}	T{
Reserved area
T}	T{
integer (4 bit)
T}
T{
flags
T}	T{
TCP flags
T}	T{
tcp_flag
T}
T{
window
T}	T{
Window
T}	T{
integer (16 bit)
T}
T{
checksum
T}	T{
Checksum
T}	T{
integer (16 bit)
T}
T{
urgptr
T}	T{
Urgent pointer
T}	T{
integer (16 bit)
T}
.TE

<a name="udp-header-expression"></a>

### UDP HEADER EXPRESSION

'nh
**udp** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_UDP header field_]
'in \n(.iu-\nxu
'hy

**UDP header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
sport
T}	T{
Source port
T}	T{
inet_service
T}
T{
dport
T}	T{
Destination port
T}	T{
inet_service
T}
T{
length
T}	T{
Total packet length
T}	T{
integer (16 bit)
T}
T{
checksum
T}	T{
Checksum
T}	T{
integer (16 bit)
T}
.TE

<a name="udp-lite-header-expression"></a>

### UDP-LITE HEADER EXPRESSION

'nh
**udplite** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_UDP-Lite header field_]
'in \n(.iu-\nxu
'hy

**UDP-Lite header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l
l | l | l.
T{
sport
T}	T{
Source port
T}	T{
inet_service
T}
T{
dport
T}	T{
Destination port
T}	T{
inet_service
T}
T{
checksum
T}	T{
Checksum
T}	T{
integer (16 bit)
T}
.TE

<a name="sctp-header-expression"></a>

### SCTP HEADER EXPRESSION

'nh
**sctp** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_SCTP header field_]
'in \n(.iu-\nxu
'hy

**SCTP header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
sport
T}	T{
Source port
T}	T{
inet_service
T}
T{
dport
T}	T{
Destination port
T}	T{
inet_service
T}
T{
vtag
T}	T{
Verification Tag
T}	T{
integer (32 bit)
T}
T{
checksum
T}	T{
Checksum
T}	T{
integer (32 bit)
T}
.TE

<a name="dccp-header-expression"></a>

### DCCP HEADER EXPRESSION

'nh
**dccp** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_DCCP header field_]
'in \n(.iu-\nxu
'hy

**DCCP header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l.
T{
sport
T}	T{
Source port
T}	T{
inet_service
T}
T{
dport
T}	T{
Destination port
T}	T{
inet_service
T}
.TE

<a name="authentication-header-expression"></a>

### AUTHENTICATION HEADER EXPRESSION

'nh
**ah** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_AH header field_]
'in \n(.iu-\nxu
'hy

**AH header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
nexthdr
T}	T{
Next header protocol
T}	T{
inet_proto
T}
T{
hdrlength
T}	T{
AH Header length
T}	T{
integer (8 bit)
T}
T{
reserved
T}	T{
Reserved area
T}	T{
integer (16 bit)
T}
T{
spi
T}	T{
Security Parameter Index
T}	T{
integer (32 bit)
T}
T{
sequence
T}	T{
Sequence number
T}	T{
integer (32 bit)
T}
.TE

<a name="encrypted-security-payload-header-expression"></a>

### ENCRYPTED SECURITY PAYLOAD HEADER EXPRESSION

'nh
**esp** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_ESP header field_]
'in \n(.iu-\nxu
'hy

**ESP header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l.
T{
spi
T}	T{
Security Parameter Index
T}	T{
integer (32 bit)
T}
T{
sequence
T}	T{
Sequence number
T}	T{
integer (32 bit)
T}
.TE

<a name="ipcomp-header-expression"></a>

### IPCOMP HEADER EXPRESSION

'nh
**comp** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_IPComp header field_]
'in \n(.iu-\nxu
'hy

**IPComp header expression**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l
l | l | l.
T{
nexthdr
T}	T{
Next header protocol
T}	T{
inet_proto
T}
T{
flags
T}	T{
Flags
T}	T{
bitmask
T}
T{
cpi
T}	T{
Compression Parameter Index
T}	T{
integer (16 bit)
T}
.TE

<a name="raw-payload-expression"></a>

### RAW PAYLOAD EXPRESSION

'nh
**@** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[_base,offset,length_]
'in \n(.iu-\nxu
'hy

The raw payload expression instructs to load _length_bits starting at _offset_bits.
Bit 0 refers the the very first bit -- in the C programming language, this corresponds to the topmost bit, i.e. 0x80 in case of an octet.
They are useful to match headers that do not have a human-readable template expression yet.
Note that nft will not add dependencies for Raw payload expressions.
If you e.g. want to match protocol fields of a transport header with protocol number 5, you need to manually
exclude packets that have a different transport header, for instance my using meta l4proto 5\*(T&gt; before
the raw expression.

**Supported payload protocol bases**
.TS
allbox ;
l | l.
T{
Base
T}	T{
Description
T}
.T&
l | l
l | l
l | l.
T{
ll
T}	T{
Link layer, for example the Ethernet header
T}
T{
nh
T}	T{
Network header, for example IPv4 or IPv6
T}
T{
th
T}	T{
Transport Header, for example TCP
T}
.TE

**Matching destination port of both UDP and TCP**

    
    inet filter input meta l4proto {tcp, udp} @th,16,16 { dns, http }
    					

**Rewrite arp packet target hardware address if target protocol address matches a given address**

    
    input meta iifname enp2s0 arp ptype 0x0800 arp htype 1 arp hlen 6 arp plen 4 @nh,192,32 0xc0a88f10 @nh,144,48 set 0x112233445566 accept
    					

<a name="extension-header-expressions"></a>

### EXTENSION HEADER EXPRESSIONS

Extension header expressions refer to data from variable-sized protocol headers, such as IPv6 extension headers and
TCP options.

nftables currently supports matching (finding) a given ipv6 extension header or TCP option.
'nh
**hbh** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{nexthdr | hdrlength}
'in \n(.iu-\nxu
'hy
'nh
**frag** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{nexthdr | frag-off | more-fragments | id}
'in \n(.iu-\nxu
'hy
'nh
**rt** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{nexthdr | hdrlength | type | seg-left}
'in \n(.iu-\nxu
'hy
'nh
**dst** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{nexthdr | hdrlength}
'in \n(.iu-\nxu
'hy
'nh
**mh** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{nexthdr | hdrlength | checksum | type}
'in \n(.iu-\nxu
'hy
'nh
**srh** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{flags | tag | sid | seg-left}
'in \n(.iu-\nxu
'hy
'nh
**tcp option** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{eol | noop | maxseg | window | sack-permitted | sack | sack0 | sack1 | sack2 | sack3 | timestamp} _tcp\_option\_field_
'in \n(.iu-\nxu
'hy

The following syntaxes are valid only in a relational expression
with boolean type on right-hand side for checking header existence only:
'nh
**exthdr** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{hbh | frag | rt | dst | mh}
'in \n(.iu-\nxu
'hy
'nh
**tcp option** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{eol | noop | maxseg | window | sack-permitted | sack | sack0 | sack1 | sack2 | sack3 | timestamp}
'in \n(.iu-\nxu
'hy

**IPv6 extension headers**
.TS
allbox ;
l | l.
T{
Keyword
T}	T{
Description
T}
.T&
l | l.
T{
hbh
T}	T{
Hop by Hop
T}
T{
rt
T}	T{
Routing Header
T}
T{
frag
T}	T{
Fragmentation header
T}
T{
dst
T}	T{
dst options
T}
T{
mh
T}	T{
Mobility Header
T}
T{
srh
T}	T{
Segment Routing Header
T}
.TE

**TCP Options**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
TCP option fields
T}
.T&
l | l | l.
T{
eol
T}	T{
End of option list
T}	T{
kind
T}
T{
noop
T}	T{
1 Byte TCP No-op options
T}	T{
kind
T}
T{
maxseg
T}	T{
TCP Maximum Segment Size
T}	T{
kind, length, size
T}
T{
window
T}	T{
TCP Window Scaling
T}	T{
kind, length, count
T}
T{
sack-permitted
T}	T{
TCP SACK permitted
T}	T{
kind, length
T}
T{
sack
T}	T{
TCP Selective Acknowledgement (alias of block 0)
T}	T{
kind, length, left, right
T}
T{
sack0
T}	T{
TCP Selective Acknowledgement (block 0)
T}	T{
kind, length, left, right
T}
T{
sack1
T}	T{
TCP Selective Acknowledgement (block 1)
T}	T{
kind, length, left, right
T}
T{
sack2
T}	T{
TCP Selective Acknowledgement (block 2)
T}	T{
kind, length, left, right
T}
T{
sack3
T}	T{
TCP Selective Acknowledgement (block 3)
T}	T{
kind, length, left, right
T}
T{
timestamp
T}	T{
TCP Timestamps
T}	T{
kind, length, tsval, tsecr
T}
.TE

**finding TCP options**

    
    filter input tcp option sack-permitted kind 1 counter
    					

**matching IPv6 exthdr**

    
    ip6 filter input frag more-fragments 1 counter
    					

<a name="conntrack-expressions"></a>

### CONNTRACK EXPRESSIONS

Conntrack expressions refer to meta data of the connection tracking entry associated with a packet.

There are three types of conntrack expressions. Some conntrack expressions require the flow
direction before the conntrack key, others must be used directly because they are direction agnostic.
The **packets**, **bytes** and **avgpkt** keywords can be
used with or without a direction. If the direction is omitted, the sum of the original and the reply
direction is returned. The same is true for the **zone**, if a direction is given, the zone
is only matched if the zone id is tied to the given direction.

'nh
**ct** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{state | direction | status | mark | expiration | helper | label | l3proto | protocol | bytes | packets | avgpkt | zone}
'in \n(.iu-\nxu
'hy
'nh
**ct** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{original | reply} {l3proto | protocol | proto-src | proto-dst | bytes | packets | avgpkt | zone}
'in \n(.iu-\nxu
'hy
'nh
**ct** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{original | reply} {ip | ip6} {saddr | daddr}
'in \n(.iu-\nxu
'hy

**Conntrack expressions**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
state
T}	T{
State of the connection
T}	T{
ct_state
T}
T{
direction
T}	T{
Direction of the packet relative to the connection
T}	T{
ct_dir
T}
T{
status
T}	T{
Status of the connection
T}	T{
ct_status
T}
T{
mark
T}	T{
Connection mark
T}	T{
mark
T}
T{
expiration
T}	T{
Connection expiration time
T}	T{
time
T}
T{
helper
T}	T{
Helper associated with the connection
T}	T{
string
T}
T{
label
T}	T{
Connection tracking label bit or symbolic name defined in connlabel.conf in the nftables include path
T}	T{
ct_label
T}
T{
l3proto
T}	T{
Layer 3 protocol of the connection
T}	T{
nf_proto
T}
T{
saddr
T}	T{
Source address of the connection for the given direction
T}	T{
ipv4_addr/ipv6_addr
T}
T{
daddr
T}	T{
Destination address of the connection for the given direction
T}	T{
ipv4_addr/ipv6_addr
T}
T{
protocol
T}	T{
Layer 4 protocol of the connection for the given direction
T}	T{
inet_proto
T}
T{
proto-src
T}	T{
Layer 4 protocol source for the given direction
T}	T{
integer (16 bit)
T}
T{
proto-dst
T}	T{
Layer 4 protocol destination for the given direction
T}	T{
integer (16 bit)
T}
T{
packets
T}	T{
packet count seen in the given direction or sum of original and reply
T}	T{
integer (64 bit)
T}
T{
bytes
T}	T{
byte count seen, see description for **packets** keyword
T}	T{
integer (64 bit)
T}
T{
avgpkt
T}	T{
average bytes per packet, see description for **packets** keyword
T}	T{
integer (64 bit)
T}
T{
zone
T}	T{
conntrack zone
T}	T{
integer (16 bit)
T}
.TE

A description of conntrack-specific types listed above can be
found sub-section CONNTRACK TYPES\*(T&gt; above.

<a name="statements"></a>

# Statements

Statements represent actions to be performed. They can alter control flow (return, jump
to a different chain, accept or drop the packet) or can perform actions, such as logging,
rejecting a packet, etc.

Statements exist in two kinds. Terminal statements unconditionally terminate evaluation
of the current rule, non-terminal statements either only conditionally or never terminate
evaluation of the current rule, in other words, they are passive from the ruleset evaluation
perspective. There can be an arbitrary amount of non-terminal statements in a rule, but
only a single terminal statement as the final statement.

<a name="verdict-statement"></a>

### VERDICT STATEMENT

The verdict statement alters control flow in the ruleset and issues
policy decisions for packets.

'nh
{accept | drop | queue | continue | return}
'hy
'nh
{jump | goto} _chain_
'hy


* **accept**\*(T&gt;  
  Terminate ruleset evaluation and accept the packet.
* **drop**\*(T&gt;  
  Terminate ruleset evaluation and drop the packet.
* **queue**\*(T&gt;  
  Terminate ruleset evaluation and queue the packet to userspace.
* **continue**\*(T&gt;  
  Continue ruleset evaluation with the next rule. FIXME
* **return**\*(T&gt;  
  Return from the current chain and continue evaluation at the
  next rule in the last chain. If issued in a base chain, it is
  equivalent to **accept**.
* **jump **\*(T&gt;_chain_  
  Continue evaluation at the first rule in _chain_.
  The current position in the ruleset is pushed to a call stack and evaluation
  will continue there when the new chain is entirely evaluated of a
  **return** verdict is issued.
* **goto **\*(T&gt;_chain_  
  Similar to **jump**, but the current position is not pushed
  to the call stack, meaning that after the new chain evaluation will continue
  at the last chain instead of the one containing the goto statement.

**Verdict statements**

    
    # process packets from eth0 and the internal network in from_lan
    # chain, drop all packets from eth0 with different source addresses.
    
    filter input iif eth0 ip saddr 192.168.0.0/24 jump from_lan
    filter input iif eth0 drop
    					

<a name="payload-statement"></a>

### PAYLOAD STATEMENT

The payload statement alters packet content.
It can be used for example to set ip DSCP (differv) header field or ipv6 flow labels.

**route some packets instead of bridging**

    
    # redirect tcp:http from 192.160.0.0/16 to local machine for routing instead of bridging
    # assumes 00:11:22:33:44:55 is local MAC address.
    bridge input meta iif eth0 ip saddr 192.168.0.0/16 tcp dport 80 meta pkttype set unicast ether daddr set 00:11:22:33:44:55
    					

**Set IPv4 DSCP header field**

    
    ip forward ip dscp set 42
    					

<a name="extension-header-statement"></a>

### EXTENSION HEADER STATEMENT

The extension header statement alters packet content in variable-sized headers.
This can currently be used to alter the TCP Maximum segment size of packets,
similar to TCPMSS.

**change tcp mss**

    
    tcp flags syn tcp option maxseg size set 1360
    # set a size based on route information:
    tcp flags syn tcp option maxseg size set rt mtu
    					

<a name="log-statement"></a>

### LOG STATEMENT

'nh
**log** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[prefix
_quoted\_string_] [level
_syslog-level_] [flags
_log-flags_]
'in \n(.iu-\nxu
'hy
'nh
**log** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
group
_nflog\_group_ [prefix
_quoted\_string_] [queue-threshold
_value_] [snaplen
_size_]
'in \n(.iu-\nxu
'hy

The log statement enables logging of matching packets. When this statement is used from a rule, the Linux kernel will print some information on all matching packets, such as header fields, via the kernel log (where it can be read with dmesg(1) or read in the syslog). If the group number is specified, the Linux kernel will pass the packet to nfnetlink_log which will multicast the packet through a netlink socket to the specified multicast group. One or more userspace processes may subscribe to the group to receive the packets, see libnetfilter_queue documentation for details. This is a non-terminating statement, so the rule evaluation continues after the packet is logged.

**log statement options**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l.
T{
prefix
T}	T{
Log message prefix
T}	T{
quoted string
T}
T{
level
T}	T{
Syslog level of logging
T}	T{
string: emerg, alert, crit, err, warn [default], notice, info, debug
T}
T{
group
T}	T{
NFLOG group to send messages to
T}	T{
unsigned integer (16 bit)
T}
T{
snaplen
T}	T{
Length of packet payload to include in netlink message
T}	T{
unsigned integer (32 bit)
T}
T{
queue-threshold
T}	T{
Number of packets to queue inside the kernel before sending them to userspace
T}	T{
unsigned integer (32 bit)
T}
.TE

**log-flags**
.TS
allbox ;
l | l.
T{
Flag
T}	T{
Description
T}
.T&
l | l.
T{
tcp sequence
T}	T{
Log TCP sequence numbers.
T}
T{
tcp options
T}	T{
Log options from the TCP packet header.
T}
T{
ip options
T}	T{
Log options from the IP/IPv6 packet header.
T}
T{
skuid
T}	T{
Log the userid of the process which generated the packet.
T}
T{
ether
T}	T{
Decode MAC addresses and protocol.
T}
T{
all
T}	T{
Enable all log flags listed above.
T}
.TE

**Using log statement**

    
    # log the UID which generated the packet and ip options
    ip filter output log flags skuid flags ip options
    
    # log the tcp sequence numbers and tcp options from the TCP packet
    ip filter output log flags tcp sequence,options
    
    # enable all supported log flags
    ip6 filter output log flags all
    					

<a name="reject-statement"></a>

### REJECT STATEMENT

'nh
**reject** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[
with
{icmp | icmpv6 | icmpx}
type
{icmp_code | icmpv6_code | icmpx_code}
]
'in \n(.iu-\nxu
'hy
'nh
**reject** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[
with tcp reset 
]
'in \n(.iu-\nxu
'hy

A reject statement is used to send back an error packet in response to the matched packet otherwise it is equivalent to drop so it is a terminating statement, ending rule traversal. This statement is only valid in the input, forward and output chains, and user-defined chains which are only called from those chains.

The different ICMP reject variants are meant for use in different table families:
.TS
allbox ;
l | l | l.
T{
Variant
T}	T{
Family
T}	T{
Type
T}
.T&
l | l | l
l | l | l
l | l | l.
T{
icmp
T}	T{
ip
T}	T{
icmp_code
T}
T{
icmpv6
T}	T{
ip6
T}	T{
icmpv6_code
T}
T{
icmpx
T}	T{
inet
T}	T{
icmpx_code
T}
.TE

For a description of the different types and a list of supported
keywords refer to DATA TYPES\*(T&gt; section above.
The common default reject value is
**port-unreachable**.

Note that in bridge family, reject statement is only allowed in base chains which
hook into input\*(T&gt; or \*(T&lt;prerouting\*(T&gt;.

<a name="counter-statement"></a>

### COUNTER STATEMENT

A counter statement sets the hit count of packets along with the number of bytes.

'nh
**counter** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[
packets
_number_
bytes
_number_
]
'in \n(.iu-\nxu
'hy

<a name="conntrack-statement"></a>

### CONNTRACK STATEMENT

The conntrack statement can be used to set the conntrack mark and conntrack labels.

'nh
**ct** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{mark | event | label | zone} set _value_
'in \n(.iu-\nxu
'hy

The ct statement sets meta data associated with a connection.
The zone id has to be assigned before a conntrack lookup takes place,
i.e. this has to be done in prerouting and possibly output (if locally
generated packets need to be placed in a distinct zone), with a hook
priority of -300.

**Conntrack statement types**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Value
T}
.T&
l | l | l.
T{
event
T}	T{
conntrack event bits
T}	T{
bitmask, integer (32 bit)
T}
T{
helper
T}	T{
name of ct helper object to assign to the connection
T}	T{
quoted string
T}
T{
mark
T}	T{
Connection tracking mark
T}	T{
mark
T}
T{
label
T}	T{
Connection tracking label
T}	T{
label
T}
T{
zone
T}	T{
conntrack zone
T}	T{
integer (16 bit)
T}
.TE

**save packet nfmark in conntrack**

    
    ct mark set meta mark
    					

**set zone mapped via interface**

    
    table inet raw {
      chain prerouting {
          type filter hook prerouting priority -300;
          ct zone set iif map { "eth1" : 1, "veth1" : 2 }
      }
      chain output {
          type filter hook output priority -300;
          ct zone set oif map { "eth1" : 1, "veth1" : 2 }
      }
    }
    				

**restrict events reported by ctnetlink**

    
    ct event set new,related,destroy
    				

<a name="meta-statement"></a>

### META STATEMENT

A meta statement sets the value of a meta expression.
The existing meta fields are: priority, mark, pkttype, nftrace.

'nh
**meta** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
{mark | priority | pkttype | nftrace} set _value_
'in \n(.iu-\nxu
'hy

A meta statement sets meta data associated with a packet.

**Meta statement types**
.TS
allbox ;
l | l | l.
T{
Keyword
T}	T{
Description
T}	T{
Value
T}
.T&
l | l | l.
T{
priority
T}	T{
TC packet priority
T}	T{
tc_handle
T}
T{
mark
T}	T{
Packet mark
T}	T{
mark
T}
T{
pkttype
T}	T{
packet type
T}	T{
pkt_type
T}
T{
nftrace
T}	T{
ruleset packet tracing on/off. Use **monitor trace** command to watch traces
T}	T{
0, 1
T}
.TE

<a name="limit-statement"></a>

### LIMIT STATEMENT

'nh
**limit** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
rate [over] _packet\_number_ / {second | minute | hour | day} [burst _packet\_number_ packets]
'in \n(.iu-\nxu
'hy
'nh
**limit** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
rate [over] _byte\_number_ {bytes | kbytes | mbytes} / {second | minute | hour | day | week} [burst _byte\_number_ bytes]
'in \n(.iu-\nxu
'hy

A limit statement matches at a limited rate using a token bucket filter. A rule using this statement will match until this limit is reached. It can be used in combination with the log statement to give limited logging. The **over** keyword, that is optional, makes it match over the specified rate.

**limit statement values**
.TS
allbox ;
l | l | l.
T{
Value
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l.
T{
packet_number
T}	T{
Number of packets
T}	T{
unsigned integer (32 bit)
T}
T{
byte_number
T}	T{
Number of bytes
T}	T{
unsigned integer (32 bit)
T}
.TE

<a name="nat-statements"></a>

### NAT STATEMENTS

'nh
**snat** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
_address_
[:port] [persistent, random, fully-random]
'in \n(.iu-\nxu
'hy
'nh
**snat** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
_address_ - _address_
[:_port_ - _port_] [persistent, random, fully-random]
'in \n(.iu-\nxu
'hy
'nh
**dnat** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
_address_
[:_port_] [persistent, random, fully-random]
'in \n(.iu-\nxu
'hy
'nh
**dnat** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
_address_
[:_port_ - _port_] [persistent, random, fully-random]
'in \n(.iu-\nxu
'hy
'nh
**masquerade** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
[:_port_] [persistent, random, fully-random]
'in \n(.iu-\nxu
'hy
'nh
**masquerade** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
[:_port_ - _port_] [persistent, random, fully-random]
'in \n(.iu-\nxu
'hy
'nh
**redirect** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
[:_port_] [persistent, random, fully-random]
'in \n(.iu-\nxu
'hy
'nh
**redirect** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
[:_port_ - _port_] [persistent, random, fully-random]
'in \n(.iu-\nxu
'hy

The nat statements are only valid from nat chain types.

The **snat** and **masquerade** statements specify that the source address of the packet should be modified. While **snat** is only valid in the postrouting and input chains, **masquerade** makes sense only in postrouting. The **dnat** and **redirect** statements are only valid in the prerouting and output chains, they specify that the destination address of the packet should be modified. You can use non-base chains which are called from base chains of nat chain type too. All future packets in this connection will also be mangled, and rules should cease being examined.

The **masquerade** statement is a special form of **snat** which always uses the outgoing interface's IP address to translate to. It is particularly useful on gateways with dynamic (public) IP addresses.

The **redirect** statement is a special form of **dnat** which always translates the destination address to the local host's one. It comes in handy if one only wants to alter the destination port of incoming traffic on different interfaces.

Note that all nat statements require both prerouting and postrouting base chains to be present since otherwise packets on the return path won't be seen by netfilter and therefore no reverse translation will take place.

**NAT statement values**
.TS
allbox ;
l | l | l.
T{
Expression
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l.
T{
address
T}	T{
Specifies that the source/destination address of the packet should be modified. You may specify a mapping to relate a list of tuples composed of arbitrary expression key with address value.
T}	T{
ipv4_addr, ipv6_addr, e.g. abcd::1234, or you can use a mapping, e.g. meta mark map { 10 : 192.168.1.2, 20 : 192.168.1.3 }
T}
T{
port
T}	T{
Specifies that the source/destination address of the packet should be modified.
T}	T{
port number (16 bits)
T}
.TE

**NAT statement flags**
.TS
allbox ;
l | l.
T{
Flag
T}	T{
Description
T}
.T&
l | l
l | l
l | l.
T{
persistent
T}	T{
Gives a client the same source-/destination-address for each connection.
T}
T{
random
T}	T{
If used then port mapping will be randomized using a random seeded MD5 hash mix using source and destination address and destination port.
T}
T{
fully-random
T}	T{
If used then port mapping is generated based on a 32-bit pseudo-random algorithm.
T}
.TE

**Using NAT statements**

    
    # create a suitable table/chain setup for all further examples
    add table nat
    add chain nat prerouting { type nat hook prerouting priority 0; }
    add chain nat postrouting { type nat hook postrouting priority 100; }
    
    # translate source addresses of all packets leaving via eth0 to address 1.2.3.4
    add rule nat postrouting oif eth0 snat to 1.2.3.4
    
    # redirect all traffic entering via eth0 to destination address 192.168.1.120
    add rule nat prerouting iif eth0 dnat to 192.168.1.120
    
    # translate source addresses of all packets leaving via eth0 to whatever
    # locally generated packets would use as source to reach the same destination
    add rule nat postrouting oif eth0 masquerade
    
    # redirect incoming TCP traffic for port 22 to port 2222
    add rule nat prerouting tcp dport 22 redirect to :2222
    					

<a name="flow-offload-statement"></a>

### FLOW OFFLOAD STATEMENT

A flow offload statement allows us to select what flows
you want to accelerate forwarding through layer 3 network
stack bypass. You have to specify the flowtable name where
you want to offload this flow.

'nh
**flow offload** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
@flowtable
'in \n(.iu-\nxu
'hy

<a name="queue-statement"></a>

### QUEUE STATEMENT

This statement passes the packet to userspace using the nfnetlink_queue handler. The packet is put into the queue identified by its 16-bit queue number. Userspace can inspect and modify the packet if desired. Userspace must then drop or re-inject the packet into the kernel. See libnetfilter_queue documentation for details.

'nh
**queue** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[num
_queue\_number_] [bypass]
'in \n(.iu-\nxu
'hy
'nh
**queue** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
[num
_queue\_number\_from_ - _queue\_number\_to_] [bypass,fanout]
'in \n(.iu-\nxu
'hy

**queue statement values**
.TS
allbox ;
l | l | l.
T{
Value
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l
l | l | l.
T{
queue_number
T}	T{
Sets queue number, default is 0.
T}	T{
unsigned integer (16 bit)
T}
T{
queue_number_from
T}	T{
Sets initial queue in the range, if fanout is used.
T}	T{
unsigned integer (16 bit)
T}
T{
queue_number_to
T}	T{
Sets closing queue in the range, if fanout is used.
T}	T{
unsigned integer (16 bit)
T}
.TE

**queue statement flags**
.TS
allbox ;
l | l.
T{
Flag
T}	T{
Description
T}
.T&
l | l
l | l.
T{
bypass
T}	T{
Let packets go through if userspace application cannot back off. Before using this flag, read libnetfilter_queue documentation for performance tuning recommendations.
T}
T{
fanout
T}	T{
Distribute packets between several queues.
T}
.TE

<a name="dup-statement"></a>

### DUP STATEMENT

The dup statement is used to duplicate a packet and send the copy to a different destination.

'nh
**dup** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
_device_
'in \n(.iu-\nxu
'hy
'nh
**dup** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
_address_
device
_device_
'in \n(.iu-\nxu
'hy

**Dup statement values**
.TS
allbox ;
l | l | l.
T{
Expression
T}	T{
Description
T}	T{
Type
T}
.T&
l | l | l
l | l | l.
T{
address
T}	T{
Specifies that the copy of the packet should be sent to a new gateway.
T}	T{
ipv4_addr, ipv6_addr, e.g. abcd::1234, or you can use a mapping, e.g. ip saddr map { 192.168.1.2 : 10.1.1.1 }
T}
T{
device
T}	T{
Specifies that the copy should be transmitted via device.
T}	T{
string
T}
.TE

**Using the dup statement**

    
    # send to machine with ip address 10.2.3.4 on eth0
    ip filter forward dup to 10.2.3.4 device "eth0"
    
    # copy raw frame to another interface
    netdetv ingress dup to "eth0"
    dup to "eth0"
    
    # combine with map dst addr to gateways
    dup to ip daddr map { 192.168.7.1 : "eth0", 192.168.7.2 : "eth1" }
    					

<a name="fwd-statement"></a>

### FWD STATEMENT

The fwd statement is used to redirect a raw packet to another interface. Its is only available in the netdev family ingress hook.
It is similar to the dup statement except that no copy is made.

'nh
**fwd** \kx
.if (\nx&gt;(\n(.l/2)) .nr x (\n(.l/5)
'in \n(.iu+\nxu
to
_device_
'in \n(.iu-\nxu
'hy

<a name="set-statement"></a>

### SET STATEMENT

The set statement is used to dynamically add or update elements in a set from the packet path.
The set setname\*(T&gt; must already exist in the given table.
Furthermore, any set that will be dynamically updated from the nftables ruleset must specify
both a maximum set size (to prevent memory exhaustion) and a timeout (so that number of entries in
set will not grow indefinitely).
The set statement can be used to e.g. create dynamic blacklists.

'nh
{add | update} _@setname_ _{ expression _[timeout _timeout_] [comment _string_] _}_
'hy

**Example for simple blacklist**

    
        # declare a set, bound to table "filter", in family "ip".  Timeout and size are mandatory because we will add elements from packet path.
        nft add set ip filter blackhole "{ type ipv4_addr; flags timeout; size 65536; }"
    
        # whitelist internal interface.
        nft add rule ip filter input meta iifname "internal" accept
    
        # drop packets coming from blacklisted ip addresses.
        nft add rule ip filter input ip saddr @blackhole counter drop
    
        # add source ip addresses to the blacklist if more than 10 tcp connection requests occurred per second and ip address.
        # entries will timeout after one minute, after which they might be re-added if limit condition persists.
        nft add rule ip filter input tcp flags syn tcp dport ssh meter flood size 128000 { ip saddr timeout 10s limit rate over 10/second} add @blackhole { ip saddr timeout 1m } drop
    
        # inspect state of the rate limit meter:
        nft list meter ip filter flood
    
        # inspect content of blackhole:
        nft list set ip filter blackhole
    
        # manually add two addresses to the set:
        nft add element filter blackhole { 10.2.3.4, 10.23.1.42 }
    					

<a name="additional-commands"></a>

# Additional Commands

These are some additional commands included in nft.

<a name="monitor"></a>

### MONITOR

The monitor command allows you to listen to Netlink events produced
by the nf_tables subsystem, related to creation and deletion of objects.
When they occur, nft will print to stdout the monitored events in either
XML, JSON or native nft format.

To filter events related to a concrete object, use one of the keywords 'tables', 'chains', 'sets', 'rules', 'elements', 'ruleset'.

To filter events related to a concrete action, use keyword 'new' or 'destroy'.

Hit ^C to finish the monitor operation.

**Listen to all events, report in native nft format**

    
    % nft monitor
    				

**Listen to added tables, report in XML format**

    
    % nft monitor new tables xml
    				

**Listen to deleted rules, report in JSON format**

    
    % nft monitor destroy rules json
    				

**Listen to both new and destroyed chains, in native nft format**

    
    % nft monitor chains
    				

**Listen to ruleset events such as table, chain, rule, set, counters and quotas, in native nft format**

    
    % nft monitor ruleset
    				

<a name="error-reporting"></a>

# Error Reporting

When an error is detected, nft shows the line(s) containing the error, the position
of the erroneous parts in the input stream and marks up the erroneous parts using
carets (^\*(T&gt;). If the error results from the combination of two
expressions or statements, the part imposing the constraints which are violated is
marked using tildes (~\*(T&gt;).

For errors returned by the kernel, nft can't detect which parts of the input caused
the error and the entire command is marked.

**Error caused by single incorrect expression**

    
    <cmdline>:1:19-22: Error: Interface does not exist
    filter output oif eth0
                      ^^^^
    			

**Error caused by invalid combination of two expressions**

    
    <cmdline>:1:28-36: Error: Right hand side of relational expression (==) must be constant
    filter output tcp dport == tcp dport
                            ~~ ^^^^^^^^^
    			

**Error returned by the kernel**

    
    <cmdline>:0:0-23: Error: Could not process rule: Operation not permitted
    filter output oif wlan0
    ^^^^^^^^^^^^^^^^^^^^^^^
    			

<a name="exit-status"></a>

# Exit Status

On success, nft exits with a status of 0. Unspecified
errors cause it to exit with a status of 1, memory allocation
errors with a status of 2, unable to open Netlink socket with 3.

<a name="see-also"></a>

# See Also

iptables(8), ip6tables(8), arptables(8), ebtables(8), ip(8), tc(8)

There is an official wiki at: https://wiki.nftables.org

<a name="authors"></a>

# Authors

nftables was written by Patrick McHardy and Pablo Neira Ayuso, among many other contributors from the Netfilter community.

<a name="copyright"></a>

# Copyright

    
    Copyright  2008-2014 Patrick McHardy <kaber@trash.net*(T>>
    Copyright  2013-2016 Pablo Neira Ayuso <pablo@netfilter.org*(T>>
    		

nftables is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License version 2 as
published by the Free Software Foundation.

This documentation is licensed under the terms of the Creative
Commons Attribution-ShareAlike 4.0 license,
.URL http://creativecommons.org/licenses/by-sa/4.0/ "CC BY-SA 4.0"
.
