# nft(8)

\ \&, 07/28/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nft - Administration tool of the nftables framework for packet filtering and classification

<a name="synopsis"></a>

# Synopsis

```


```
    nft [ -nNscaeSupyjt ] [ -I directory ] [ -f filename | -i | cmd ...]
    nft -h
    nft -v

<a name="description"></a>

# Description


nft is the command line tool used to set up, maintain and inspect packet filtering and classification rules in the Linux kernel, in the nftables framework. The Linux kernel subsystem is known as nf_tables, and ‘nf’ stands for Netfilter.

<a name="options"></a>

# Options


For a full summary of options, run **nft --help**.

**-h**, **--help**
Show help message and all options.

**-v**, **--version**
Show version.

**-n**, **--numeric**
Print fully numerical output.

**-s**, **--stateless**
Omit stateful information of rules and stateful objects.

**-N**, **--reversedns**
Translate IP address to names via reverse DNS lookup. This may slow down your listing since it generates network traffic.

**-S**, **--service**
Translate ports to service names as defined by /etc/services.

**-u**, **--guid**
Translate numeric UID/GID to names as defined by /etc/passwd and /etc/group.

**-p**, **--numeric-protocol**
Display layer 4 protocol numerically.

**-y**, **--numeric-priority**
Display base chain priority numerically.

**-c**, **--check**
Check commands validity without actually applying the changes.

**-a**, **--handle**
Show object handles in output.

**-e**, **--echo**
When inserting items into the ruleset using
**add**,
**insert**
or
**replace**
commands, print notifications just like
**nft monitor**.

**-j**, **--json**
Format output in JSON. See libnftables-json(5) for a schema description.

**-I**, **--includepath directory**
Add the directory
_directory_
to the list of directories to be searched for included files. This option may be specified multiple times.

**-f**, **--file ****filename**
Read input from
_filename_. If
_filename_
is -, read from stdin.

**-i**, **--interactive**
Read input from an interactive readline CLI. You can use quit to exit, or use the EOF marker, normally this is CTRL-D.

**-T**, **--numeric-time**
Show time, day and hour values in numeric format.

**-t**, **--terse**
Omit contents of sets from output.

<a name="input-file-formats"></a>

# Input File Formats


<a name="lexical-conventions"></a>

### LEXICAL CONVENTIONS


Input is parsed line-wise. When the last character of a line, just before the newline character, is a non-quoted backslash (\e), the next line is treated as a continuation. Multiple commands on the same line can be separated using a semicolon (;).

A hash sign (#) begins a comment. All following characters on the same line are ignored.

Identifiers begin with an alphabetic character (a-z,A-Z), followed zero or more alphanumeric characters (a-z,A-Z,0-9) and the characters slash (/), backslash (\e), underscore (_) and dot (.). Identifiers using different characters or clashing with a keyword need to be enclosed in double quotes (").

<a name="include-files"></a>

### INCLUDE FILES


.if n \{.RS 4
.\}
    include filename
.if n \{.RE
.\}

Other files can be included by using the **include** statement. The directories to be searched for include files can be specified using the **-I**/**--includepath** option. You can override this behaviour either by prepending ‘./’ to your path to force inclusion of files located in the current working directory (i.e. relative path) or / for file location expressed as an absolute path.

If **-I**/**--includepath** is not specified, then nft relies on the default directory that is specified at compile time. You can retrieve this default directory via **-h**/**--help** option.

Include statements support the usual shell wildcard symbols (\e*,?,[]). Having no matches for an include statement is not an error, if wildcard symbols are used in the include statement. This allows having potentially empty include directories for statements like **include "/etc/firewall/rules/"**. The wildcard matches are loaded in alphabetical order. Files beginning with dot (.) are not matched by include statements.

<a name="symbolic-variables"></a>

### SYMBOLIC VARIABLES


.if n \{.RS 4
.\}
    define variable = expr
    $variable
.if n \{.RE
.\}

Symbolic variables can be defined using the **define** statement. Variable references are expressions and can be used initialize other variables. The scope of a definition is the current block and all blocks contained within.

**Using symbolic variables**. 

.if n \{.RS 4
.\}
    define int_if1 = eth0
    define int_if2 = eth1
    define int_ifs = { $int_if1, $int_if2 }
    
    filter input iif $int_ifs accept
.if n \{.RE
.\}


<a name="address-families"></a>

# Address Families


Address families determine the type of packets which are processed. For each address family, the kernel contains so called hooks at specific stages of the packet processing paths, which invoke nftables if rules for these hooks exist.
.TS
tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**ip**
T}:T{

IPv4 address family.
T}
T{

**ip6**
T}:T{

IPv6 address family.
T}
T{

**inet**
T}:T{

Internet (IPv4/IPv6) address family.
T}
T{

**arp**
T}:T{

ARP address family, handling IPv4 ARP packets.
T}
T{

**bridge**
T}:T{

Bridge address family, handling packets which traverse a bridge device.
T}
T{

**netdev**
T}:T{

Netdev address family, handling packets from ingress.
T}
.TE


All nftables objects exist in address family specific namespaces, therefore all identifiers include an address family. If an identifier is specified without an address family, the **ip** family is used by default.

<a name="ipv4ipv6inet-address-families"></a>

### IPV4/IPV6/INET ADDRESS FAMILIES


The IPv4/IPv6/Inet address families handle IPv4, IPv6 or both types of packets. They contain five hooks at different packet processing stages in the network stack.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;IPv4/IPv6/Inet address family hooks**
.TS
allbox tab(:);
ltB ltB.
T{
Hook
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

prerouting
T}:T{

All packets entering the system are processed by the prerouting hook. It is invoked before the routing process and is used for early filtering or changing packet attributes that affect routing.
T}
T{

input
T}:T{

Packets delivered to the local system are processed by the input hook.
T}
T{

forward
T}:T{

Packets forwarded to a different host are processed by the forward hook.
T}
T{

output
T}:T{

Packets sent by local processes are processed by the output hook.
T}
T{

postrouting
T}:T{

All packets leaving the system are processed by the postrouting hook.
T}
.TE


<a name="arp-address-family"></a>

### ARP ADDRESS FAMILY


The ARP address family handles ARP packets received and sent by the system. It is commonly used to mangle ARP packets for clustering.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;2.&nbsp;ARP address family hooks**
.TS
allbox tab(:);
ltB ltB.
T{
Hook
T}:T{
Description
T}
.T&
lt lt
lt lt.
T{

input
T}:T{

Packets delivered to the local system are processed by the input hook.
T}
T{

output
T}:T{

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

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;3.&nbsp;Netdev address family hooks**
.TS
allbox tab(:);
ltB ltB.
T{
Hook
T}:T{
Description
T}
.T&
lt lt.
T{

ingress
T}:T{

All packets entering the system are processed by this hook. It is invoked before layer 3 protocol handlers and it can be used for early filtering and policing.
T}
.TE


<a name="ruleset"></a>

# Ruleset


.if n \{.RS 4
.\}
    {list | flush} ruleset [family]
.if n \{.RE
.\}

The **ruleset** keyword is used to identify the whole set of tables, chains, etc. currently in place in kernel. The following **ruleset** commands exist:
.TS
tab(:);
lt lt
lt lt.
T{

**list**
T}:T{

Print the ruleset in human-readable format.
T}
T{

**flush**
T}:T{

Clear the whole ruleset. Note that, unlike iptables, this will remove all tables and whatever they contain, effectively leading to an empty ruleset - no packet filtering will happen anymore, so the kernel accepts any valid packet it receives.
T}
.TE


It is possible to limit **list** and **flush** to a specific address family only. For a list of valid family names, see the section called “ADDRESS FAMILIES” above.

By design, **list ruleset** command output may be used as input to **nft -f**. Effectively, this is the nft-equivalent of **iptables-save** and **iptables-restore**.

<a name="tables"></a>

# Tables


.if n \{.RS 4
.\}
    {add | create} table [family] table [{ flags flags ; }]
    {delete | list | flush} table [family] table
    list tables [family]
    delete table [family] handle handle
.if n \{.RE
.\}

Tables are containers for chains, sets and stateful objects. They are identified by their address family and their name. The address family must be one of **ip**, **ip6**, **inet**, **arp**, **bridge**, **netdev**. The **inet** address family is a dummy family which is used to create hybrid IPv4/IPv6 tables. The **meta expression nfproto** keyword can be used to test which family (ipv4 or ipv6) context the packet is being processed in. When no address family is specified, **ip** is used by default. The only difference between add and create is that the former will not return an error if the specified table already exists while **create** will return an error.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;4.&nbsp;Table flags**
.TS
allbox tab(:);
ltB ltB.
T{
Flag
T}:T{
Description
T}
.T&
lt lt.
T{

dormant
T}:T{

table is not evaluated any more (base chains are unregistered).
T}
.TE


**Add, change, delete a table**. 

.if n \{.RS 4
.\}
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
.if n \{.RE
.\}

.TS
tab(:);
lt lt
lt lt
lt lt
lt lt.
T{

**add**
T}:T{

Add a new table for the given family with the given name.
T}
T{

**delete**
T}:T{

Delete the specified table.
T}
T{

**list**
T}:T{

List all chains and rules of the specified table.
T}
T{

**flush**
T}:T{

Flush all chains and rules of the specified table.
T}
.TE


<a name="chains"></a>

# Chains


.if n \{.RS 4
.\}
    {add | create} chain [family] table chain [{ type type hook hook [device device] priority priority ; [policy policy ;] }]
    {delete | list | flush} chain [family] table chain
    list chains [family]
    delete chain [family] table handle handle
    rename chain [family] table chain newname
.if n \{.RE
.\}

Chains are containers for rules. They exist in two kinds, base chains and regular chains. A base chain is an entry point for packets from the networking stack, a regular chain may be used as jump target and is used for better rule organization.
.TS
tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**add**
T}:T{

Add a new chain in the specified table. When a hook and priority value are specified, the chain is created as a base chain and hooked up to the networking stack.
T}
T{

**create**
T}:T{

Similar to the **add** command, but returns an error if the chain already exists.
T}
T{

**delete**
T}:T{

Delete the specified chain. The chain must not contain any rules or be used as jump target.
T}
T{

**rename**
T}:T{

Rename the specified chain.
T}
T{

**list**
T}:T{

List all rules of the specified chain.
T}
T{

**flush**
T}:T{

Flush all rules of the specified chain.
T}
.TE


For base chains, **type**, **hook** and **priority** parameters are mandatory.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;5.&nbsp;Supported chain types**
.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Type
T}:T{
Families
T}:T{
Hooks
T}:T{
Description
T}
.T&
lt lt lt lt
lt lt lt lt
lt lt lt lt.
T{

filter
T}:T{

all
T}:T{

all
T}:T{

Standard chain type to use in doubt.
T}
T{

nat
T}:T{

ip, ip6, inet
T}:T{

prerouting, input, output, postrouting
T}:T{

Chains of this type perform Native Address Translation based on conntrack entries. Only the first packet of a connection actually traverses this chain - its rules usually define details of the created conntrack entry (NAT statements for instance).
T}
T{

route
T}:T{

ip, ip6
T}:T{

output
T}:T{

If a packet has traversed a chain of this type and is about to be accepted, a new route lookup is performed if relevant parts of the IP header have changed. This allows to e.g. implement policy routing selectors in nftables.
T}
.TE


Apart from the special cases illustrated above (e.g. **nat** type not supporting **forward** hook or **route** type only supporting **output** hook), there are two further quirks worth noticing:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The netdev family supports merely a single combination, namely
  **filter**
  type and
  **ingress**
  hook. Base chains in this family also require the
  **device**
  parameter to be present since they exist per incoming interface only.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The arp family supports only the
  **input**
  and
  **output**
  hooks, both in chains of type
  **filter**.

The **priority** parameter accepts a signed integer value or a standard priority name which specifies the order in which chains with same **hook** value are traversed. The ordering is ascending, i.e. lower priority values have precedence over higher ones.

Standard priority values can be replaced with easily memorizable names. Not all names make sense in every family with every hook (see the compatibility matrices below) but their numerical value can still be used for prioritizing chains.

These names and values are defined and made available based on what priorities are used by xtables when registering their default chains.

Most of the families use the same values, but bridge uses different ones from the others. See the following tables that describe the values and compatibility.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;6.&nbsp;Standard priority names, family and hook compatibility matrix**
.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Value
T}:T{
Families
T}:T{
Hooks
T}
.T&
lt lt lt lt
lt lt lt lt
lt lt lt lt
lt lt lt lt
lt lt lt lt
lt lt lt lt.
T{

raw
T}:T{

-300
T}:T{

ip, ip6, inet
T}:T{

all
T}
T{

mangle
T}:T{

-150
T}:T{

ip, ip6, inet
T}:T{

all
T}
T{

dstnat
T}:T{

-100
T}:T{

ip, ip6, inet
T}:T{

prerouting
T}
T{

filter
T}:T{

0
T}:T{

ip, ip6, inet, arp, netdev
T}:T{

all
T}
T{

security
T}:T{

50
T}:T{

ip, ip6, inet
T}:T{

all
T}
T{

srcnat
T}:T{

100
T}:T{

ip, ip6, inet
T}:T{

postrouting
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;7.&nbsp;Standard priority names and hook compatibility for the bridge family**
.TS
allbox tab(:);
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

Name
T}:T{

Value
T}:T{

Hooks
T}
T{

dstnat
T}:T{

-300
T}:T{

prerouting
T}
T{

filter
T}:T{

-200
T}:T{

all
T}
T{

out
T}:T{

100
T}:T{

output
T}
T{

srcnat
T}:T{

300
T}:T{

postrouting
T}
.TE


Basic arithmetic expressions (addition and subtraction) can also be achieved with these standard names to ease relative prioritizing, e.g. **mangle - 5** stands for **-155**. Values will also be printed like this until the value is not further than 10 form the standard value.

Base chains also allow to set the chain’s **policy**, i.e. what happens to packets not explicitly accepted or refused in contained rules. Supported policy values are **accept** (which is the default) or **drop**.

<a name="rules"></a>

# Rules


.if n \{.RS 4
.\}
    {add | insert} rule [family] table chain [handle handle | index index] statement ... [comment comment]
    replace rule [family] table chain handle handle statement ... [comment comment]
    delete rule [family] table chain handle handle
.if n \{.RE
.\}

Rules are added to chains in the given table. If the family is not specified, the ip family is used. Rules are constructed from two kinds of components according to a set of grammatical rules: expressions and statements.

The add and insert commands support an optional location specifier, which is either a _handle_ or the _index_ (starting at zero) of an existing rule. Internally, rule locations are always identified by _handle_ and the translation from _index_ happens in userspace. This has two potential implications in case a concurrent ruleset change happens after the translation was done: The effective rule index might change if a rule was inserted or deleted before the referred one. If the referred rule was deleted, the command is rejected by the kernel just as if an invalid _handle_ was given.

A _comment_ is a single word or a double-quoted (") multi-word string which can be used to make notes regarding the actual rule. **Note:** If you use bash for adding rules, you have to escape the quotation marks, e.g. \e"enable ssh for servers\e".
.TS
tab(:);
lt lt
lt lt
lt lt
lt lt.
T{

**add**
T}:T{

Add a new rule described by the list of statements. The rule is appended to the given chain unless a location is specified, in which case the rule is inserted after the specified rule.
T}
T{

**insert**
T}:T{

Same as **add** except the rule is inserted at the beginning of the chain or before the specified rule.
T}
T{

**replace**
T}:T{

Similar to **add**, but the rule replaces the specified rule.
T}
T{

**delete**
T}:T{

Delete the specified rule.
T}
.TE


**add a rule to ip table input chain**. 

.if n \{.RS 4
.\}
    nft add rule filter output ip daddr 192.168.0.0/24 accept # ip filter*(Aq is assumed
    # same command, slightly more verbose
    nft add rule ip filter output ip daddr 192.168.0.0/24 accept
.if n \{.RE
.\}

**delete rule from inet table**. 

.if n \{.RS 4
.\}
    # nft -a list ruleset
    table inet filter {
            chain input {
                    type filter hook input priority 0; policy accept;
                    ct state established,related accept # handle 4
                    ip saddr 10.1.1.1 tcp dport ssh accept # handle 5
              ...
    # delete the rule with handle 5
    # nft delete rule inet filter input handle 5
.if n \{.RE
.\}


<a name="sets"></a>

# Sets


nftables offers two kinds of set concepts. Anonymous sets are sets that have no specific name. The set members are enclosed in curly braces, with commas to separate elements when creating the rule the set is used in. Once that rule is removed, the set is removed as well. They cannot be updated, i.e. once an anonymous set is declared it cannot be changed anymore except by removing/altering the rule that uses the anonymous set.

**Using anonymous sets to accept particular subnets and ports**. 

.if n \{.RS 4
.\}
    nft add rule filter input ip saddr { 10.0.0.0/8, 192.168.0.0/16 } tcp dport { 22, 443 } accept
.if n \{.RE
.\}

Named sets are sets that need to be defined first before they can be referenced in rules. Unlike anonymous sets, elements can be added to or removed from a named set at any time. Sets are referenced from rules using an @ prefixed to the sets name.

**Using named sets to accept addresses and ports**. 

.if n \{.RS 4
.\}
    nft add rule filter input ip saddr @allowed_hosts tcp dport @allowed_ports accept
.if n \{.RE
.\}

The sets allowed_hosts and allowed_ports need to be created first. The next section describes nft set syntax in more detail.

.if n \{.RS 4
.\}
    add set [family] table set { type type ; [flags flags ;] [timeout timeout ;] [gc-interval gc-interval ;] [elements = { element[, ...] } ;] [size size ;] [policy policy ;] [auto-merge ;] }
    {delete | list | flush} set [family] table set
    list sets [family]
    delete set [family] table handle handle
    {add | delete} element [family] table set { element[, ...] }
.if n \{.RE
.\}

Sets are element containers of a user-defined data type, they are uniquely identified by a user-defined name and attached to tables. Their behaviour can be tuned with the flags that can be specified at set creation time.
.TS
tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**add**
T}:T{

Add a new set in the specified table. See the Set specification table below for more information about how to specify a sets properties.
T}
T{

**delete**
T}:T{

Delete the specified set.
T}
T{

**list**
T}:T{

Display the elements in the specified set.
T}
T{

**flush**
T}:T{

Remove all elements from the specified set.
T}
T{

**add element**
T}:T{

Comma-separated list of elements to add into the specified set.
T}
T{

**delete element**
T}:T{

Comma-separated list of elements to delete from the specified set.
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;8.&nbsp;Set specifications**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

type
T}:T{

data type of set elements
T}:T{

string: ipv4_addr, ipv6_addr, ether_addr, inet_proto, inet_service, mark
T}
T{

flags
T}:T{

set flags
T}:T{

string: constant, dynamic, interval, timeout
T}
T{

timeout
T}:T{

time an element stays in the set, mandatory if set is added to from the packet path (ruleset).
T}:T{

string, decimal followed by unit. Units are: d, h, m, s
T}
T{

gc-interval
T}:T{

garbage collection interval, only available when timeout or flag timeout are active
T}:T{

string, decimal followed by unit. Units are: d, h, m, s
T}
T{

elements
T}:T{

elements contained by the set
T}:T{

set data type
T}
T{

size
T}:T{

maximum number of elements in the set, mandatory if set is added to from the packet path (ruleset).
T}:T{

unsigned integer (64 bit)
T}
T{

policy
T}:T{

set policy
T}:T{

string: performance [default], memory
T}
T{

auto-merge
T}:T{

automatic merge of adjacent/overlapping set elements (only for interval sets)
T}:T{

T}
.TE


<a name="maps"></a>

# Maps


.if n \{.RS 4
.\}
    add map [family] table map { type type [flags flags ;] [elements = { element[, ...] } ;] [size size ;] [policy policy ;] }
    {delete | list | flush} map [family] table map
    list maps [family]
    {add | delete} element [family] table map { elements = { element[, ...] } ; }
.if n \{.RE
.\}

Maps store data based on some specific key used as input. They are uniquely identified by a user-defined name and attached to tables.
.TS
tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**add**
T}:T{

Add a new map in the specified table.
T}
T{

**delete**
T}:T{

Delete the specified map.
T}
T{

**list**
T}:T{

Display the elements in the specified map.
T}
T{

**flush**
T}:T{

Remove all elements from the specified map.
T}
T{

**add element**
T}:T{

Comma-separated list of elements to add into the specified map.
T}
T{

**delete element**
T}:T{

Comma-separated list of element keys to delete from the specified map.
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;9.&nbsp;Map specifications**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

type
T}:T{

data type of map elements
T}:T{

string ‘:’ string: ipv4_addr, ipv6_addr, ether_addr, inet_proto, inet_service, mark, counter, quota. Counter and quota can’t be used as keys
T}
T{

flags
T}:T{

map flags
T}:T{

string: constant, interval
T}
T{

elements
T}:T{

elements contained by the map
T}:T{

map data type
T}
T{

size
T}:T{

maximum number of elements in the map
T}:T{

unsigned integer (64 bit)
T}
T{

policy
T}:T{

map policy
T}:T{

string: performance [default], memory
T}
.TE


<a name="flowtables"></a>

# Flowtables


.if n \{.RS 4
.\}
    {add | create} flowtable [family] table flowtable { hook hook priority priority ; devices = { device[, ...] } ; }
    list flowtables [family]
    {delete | list} flowtable [family] table flowtable
    delete flowtable [family] table handle handle
.if n \{.RE
.\}

Flowtables allow you to accelerate packet forwarding in software. Flowtables entries are represented through a tuple that is composed of the input interface, source and destination address, source and destination port; and layer 3/4 protocols. Each entry also caches the destination interface and the gateway address - to update the destination link-layer address - to forward packets. The ttl and hoplimit fields are also decremented. Hence, flowtables provides an alternative path that allow packets to bypass the classic forwarding path. Flowtables reside in the ingress hook that is located before the prerouting hook. You can select which flows you want to offload through the flow expression from the forward chain. Flowtables are identified by their address family and their name. The address family must be one of ip, ip6, or inet. The inet address family is a dummy family which is used to create hybrid IPv4/IPv6 tables. When no address family is specified, ip is used by default.

The **priority** can be a signed integer or **filter** which stands for 0. Addition and subtraction can be used to set relative priority, e.g. filter + 5 equals to 5.
.TS
tab(:);
lt lt
lt lt
lt lt.
T{

**add**
T}:T{

Add a new flowtable for the given family with the given name.
T}
T{

**delete**
T}:T{

Delete the specified flowtable.
T}
T{

**list**
T}:T{

List all flowtables.
T}
.TE


<a name="stateful-objects"></a>

# Stateful Objects


.if n \{.RS 4
.\}
    {add | delete | list | reset} type [family] table object
    delete type [family] table handle handle
    list counters [family]
    list quotas [family]
.if n \{.RE
.\}

Stateful objects are attached to tables and are identified by an unique name. They group stateful information from rules, to reference them in rules the keywords "type name" are used e.g. "counter name".
.TS
tab(:);
lt lt
lt lt
lt lt
lt lt.
T{

**add**
T}:T{

Add a new stateful object in the specified table.
T}
T{

**delete**
T}:T{

Delete the specified object.
T}
T{

**list**
T}:T{

Display stateful information the object holds.
T}
T{

**reset**
T}:T{

List-and-reset stateful object.
T}
.TE


<a name="ct-helper"></a>

### CT HELPER


.if n \{.RS 4
.\}
    ct helper helper { type type protocol protocol ; [l3proto family ;] }
.if n \{.RE
.\}

Ct helper is used to define connection tracking helpers that can then be used in combination with the **ct helper set** statement. _type_ and _protocol_ are mandatory, l3proto is derived from the table family by default, i.e. in the inet table the kernel will try to load both the ipv4 and ipv6 helper backends, if they are supported by the kernel.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;10.&nbsp;conntrack helper specifications**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt.
T{

type
T}:T{

name of helper type
T}:T{

quoted string (e.g. "ftp")
T}
T{

protocol
T}:T{

layer 4 protocol of the helper
T}:T{

string (e.g. ip)
T}
T{

l3proto
T}:T{

layer 3 protocol of the helper
T}:T{

address family (e.g. ip)
T}
.TE


**defining and assigning ftp helper**. 

.if n \{.RS 4
.\}
    Unlike iptables, helper assignment needs to be performed after the conntrack
    lookup has completed, for example with the default 0 hook priority.
    
    table inet myhelpers {
      ct helper ftp-standard {
         type "ftp" protocol tcp
      }
      chain prerouting {
          type filter hook prerouting priority 0;
          tcp dport 21 ct helper set "ftp-standard"
      }
    }
.if n \{.RE
.\}


<a name="ct-timeout"></a>

### CT TIMEOUT


.if n \{.RS 4
.\}
    ct timeout name { protocol protocol ; policy = { state: value [, ...] } ; [l3proto family ;] }
.if n \{.RE
.\}

Ct timeout is used to update connection tracking timeout values.Timeout policies are assigned with the **ct timeout set** statement. _protocol_ and _policy_ are mandatory, l3proto is derived from the table family by default.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;11.&nbsp;conntrack timeout specifications**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

protocol
T}:T{

layer 4 protocol of the timeout object
T}:T{

string (e.g. ip)
T}
T{

state
T}:T{

connection state name
T}:T{

string (e.g. "established")
T}
T{

value
T}:T{

timeout value for connection state
T}:T{

unsigned integer
T}
T{

l3proto
T}:T{

layer 3 protocol of the timeout object
T}:T{

address family (e.g. ip)
T}
.TE


**defining and assigning ct timeout policy**. 

.if n \{.RS 4
.\}
    table ip filter {
            ct timeout customtimeout {
                    protocol tcp;
                    l3proto ip
                    policy = { established: 120, close: 20 }
            }
    
            chain output {
                    type filter hook output priority filter; policy accept;
                    ct timeout set "customtimeout"
            }
    }
.if n \{.RE
.\}

**testing the updated timeout policy**. 

.if n \{.RS 4
.\}
    % conntrack -E
    
    It should display:
    
    [UPDATE] tcp      6 120 ESTABLISHED src=172.16.19.128 dst=172.16.19.1
    sport=22 dport=41360 [UNREPLIED] src=172.16.19.1 dst=172.16.19.128
    sport=41360 dport=22
.if n \{.RE
.\}


<a name="ct-expectation"></a>

### CT EXPECTATION


.if n \{.RS 4
.\}
    ct expectation name { protocol protocol ; dport dport ; timeout timeout ; size size ; [*l3proto family ;] }
.if n \{.RE
.\}

Ct expectation is used to create connection expectations. Expectations are assigned with the **ct expectation set** statement. _protocol_, _dport_, _timeout_ and _size_ are mandatory, l3proto is derived from the table family by default.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;12.&nbsp;conntrack expectation specifications**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

protocol
T}:T{

layer 4 protocol of the expectation object
T}:T{

string (e.g. ip)
T}
T{

dport
T}:T{

destination port of expected connection
T}:T{

unsigned integer
T}
T{

timeout
T}:T{

timeout value for expectation
T}:T{

unsigned integer
T}
T{

size
T}:T{

size value for expectation
T}:T{

unsigned integer
T}
T{

l3proto
T}:T{

layer 3 protocol of the expectation object
T}:T{

address family (e.g. ip)
T}
.TE


**defining and assigning ct expectation policy**. 

.if n \{.RS 4
.\}
    table ip filter {
            ct expectation expect {
                    protocol udp
                    dport 9876
                    timeout 2m
                    size 8
                    l3proto ip
            }
    
            chain input {
                    type filter hook input priority filter; policy accept;
                    ct expectation set "expect"
            }
    }
.if n \{.RE
.\}


<a name="counter"></a>

### COUNTER


.if n \{.RS 4
.\}
    counter [packets bytes]
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;13.&nbsp;Counter specifications**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt.
T{

packets
T}:T{

initial count of packets
T}:T{

unsigned integer (64 bit)
T}
T{

bytes
T}:T{

initial count of bytes
T}:T{

unsigned integer (64 bit)
T}
.TE


<a name="quota"></a>

### QUOTA


.if n \{.RS 4
.\}
    quota [over | until] [used]
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;14.&nbsp;Quota specifications**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt.
T{

quota
T}:T{

quota limit, used as the quota name
T}:T{

Two arguments, unsigned integer (64 bit) and string: bytes, kbytes, mbytes. "over" and "until" go before these arguments
T}
T{

used
T}:T{

initial value of used quota
T}:T{

Two arguments, unsigned integer (64 bit) and string: bytes, kbytes, mbytes
T}
.TE


<a name="expressions"></a>

# Expressions


Expressions represent values, either constants like network addresses, port numbers, etc., or data gathered from the packet during ruleset evaluation. Expressions can be combined using binary, logical, relational and other types of expressions to form complex or relational (match) expressions. They are also used as arguments to certain types of operations, like NAT, packet marking etc.

Each expression has a data type, which determines the size, parsing and representation of symbolic values and type compatibility with other expressions.

<a name="describe-command"></a>

### DESCRIBE COMMAND


.if n \{.RS 4
.\}
    describe expression | data type
.if n \{.RE
.\}

The **describe** command shows information about the type of an expression and its data type. A data type may also be given, in which nft will display more information about the type.

**The describe command**. 

.if n \{.RS 4
.\}
    $ nft describe tcp flags
    payload expression, datatype tcp_flag (TCP flag) (basetype bitmask, integer), 8 bits
    
    predefined symbolic constants:
    fin                           0x01
    syn                           0x02
    rst                           0x04
    psh                           0x08
    ack                           0x10
    urg                           0x20
    ecn                           0x40
    cwr                           0x80
.if n \{.RE
.\}


<a name="data-types"></a>

# Data Types


Data types determine the size, parsing and representation of symbolic values and type compatibility of expressions. A number of global data types exist, in addition some expression types define further data types specific to the expression type. Most data types have a fixed size, some however may have a dynamic size, f.i. the string type. Some types also have predefined symbolic constants. Those can be listed using the nft **describe** command:

.if n \{.RS 4
.\}
    $ nft describe ct_state
    datatype ct_state (conntrack state) (basetype bitmask, integer), 32 bits
    
    pre-defined symbolic constants (in hexadecimal):
    invalid                         0x00000001
    new ...
.if n \{.RE
.\}

Types may be derived from lower order types, f.i. the IPv4 address type is derived from the integer type, meaning an IPv4 address can also be specified as an integer value.

In certain contexts (set and map definitions), it is necessary to explicitly specify a data type. Each type has a name which is used for this.

<a name="integer-type"></a>

### INTEGER TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

Integer
T}:T{

integer
T}:T{

variable
T}:T{

-
T}
.TE


The integer type is used for numeric values. It may be specified as a decimal, hexadecimal or octal number. The integer type does not have a fixed size, its size is determined by the expression for which it is used.

<a name="bitmask-type"></a>

### BITMASK TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

Bitmask
T}:T{

bitmask
T}:T{

variable
T}:T{

integer
T}
.TE


The bitmask type (**bitmask**) is used for bitmasks.

<a name="string-type"></a>

### STRING TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

String
T}:T{

string
T}:T{

variable
T}:T{

-
T}
.TE


The string type is used for character strings. A string begins with an alphabetic character (a-zA-Z) followed by zero or more alphanumeric characters or the characters /, -, _ and .. In addition, anything enclosed in double quotes (") is recognized as a string.

**String specification**. 

.if n \{.RS 4
.\}
    # Interface name
    filter input iifname eth0
    
    # Weird interface name
    filter input iifname "(eth0)"
.if n \{.RE
.\}


<a name="link-layer-address-type"></a>

### LINK LAYER ADDRESS TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

Link layer address
T}:T{

lladdr
T}:T{

variable
T}:T{

integer
T}
.TE


The link layer address type is used for link layer addresses. Link layer addresses are specified as a variable amount of groups of two hexadecimal digits separated using colons (:).

**Link layer address specification**. 

.if n \{.RS 4
.\}
    # Ethernet destination MAC address
    filter input ether daddr 20:c9:d0:43:12:d9
.if n \{.RE
.\}


<a name="ipv4-address-type"></a>

### IPV4 ADDRESS TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

IPV4 address
T}:T{

ipv4_addr
T}:T{

32 bit
T}:T{

integer
T}
.TE


The IPv4 address type is used for IPv4 addresses. Addresses are specified in either dotted decimal, dotted hexadecimal, dotted octal, decimal, hexadecimal, octal notation or as a host name. A host name will be resolved using the standard system resolver.

**IPv4 address specification**. 

.if n \{.RS 4
.\}
    # dotted decimal notation
    filter output ip daddr 127.0.0.1
    
    # host name
    filter output ip daddr localhost
.if n \{.RE
.\}


<a name="ipv6-address-type"></a>

### IPV6 ADDRESS TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

IPv6 address
T}:T{

ipv6_addr
T}:T{

128 bit
T}:T{

integer
T}
.TE


The IPv6 address type is used for IPv6 addresses. Addresses are specified as a host name or as hexadecimal halfwords separated by colons. Addresses might be enclosed in square brackets ("[]") to differentiate them from port numbers.

**IPv6 address specification**. 

.if n \{.RS 4
.\}
    # abbreviated loopback address
    filter output ip6 daddr ::1
.if n \{.RE
.\}

**IPv6 address specification with bracket notation**. 

.if n \{.RS 4
.\}
    # without [] the port number (22) would be parsed as part of the
    # ipv6 address
    ip6 nat prerouting tcp dport 2222 dnat to [1ce::d0]:22
.if n \{.RE
.\}


<a name="boolean-type"></a>

### BOOLEAN TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

Boolean
T}:T{

boolean
T}:T{

1 bit
T}:T{

integer
T}
.TE


The boolean type is a syntactical helper type in userspace. Its use is in the right-hand side of a (typically implicit) relational expression to change the expression on the left-hand side into a boolean check (usually for existence).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;15.&nbsp;The following keywords will automatically resolve into a boolean type with given value**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt.
T{

exists
T}:T{

1
T}
T{

missing
T}:T{

0
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;16.&nbsp;expressions support a boolean comparison**
.TS
allbox tab(:);
ltB ltB.
T{
Expression
T}:T{
Behaviour
T}
.T&
lt lt
lt lt
lt lt.
T{

fib
T}:T{

Check route existence.
T}
T{

exthdr
T}:T{

Check IPv6 extension header existence.
T}
T{

tcp option
T}:T{

Check TCP option header existence.
T}
.TE


**Boolean specification**. 

.if n \{.RS 4
.\}
    # match if route exists
    filter input fib daddr . iif oif exists
    
    # match only non-fragmented packets in IPv6 traffic
    filter input exthdr frag missing
    
    # match if TCP timestamp option is present
    filter input tcp option timestamp exists
.if n \{.RE
.\}


<a name="icmp-type-type"></a>

### ICMP TYPE TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

ICMP Type
T}:T{

icmp_type
T}:T{

8 bit
T}:T{

integer
T}
.TE


The ICMP Type type is used to conveniently specify the ICMP header’s type field.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;17.&nbsp;Keywords may be used when specifying the ICMP type**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

echo-reply
T}:T{

0
T}
T{

destination-unreachable
T}:T{

3
T}
T{

source-quench
T}:T{

4
T}
T{

redirect
T}:T{

5
T}
T{

echo-request
T}:T{

8
T}
T{

router-advertisement
T}:T{

9
T}
T{

router-solicitation
T}:T{

10
T}
T{

time-exceeded
T}:T{

11
T}
T{

parameter-problem
T}:T{

12
T}
T{

timestamp-request
T}:T{

13
T}
T{

timestamp-reply
T}:T{

14
T}
T{

info-request
T}:T{

15
T}
T{

info-reply
T}:T{

16
T}
T{

address-mask-request
T}:T{

17
T}
T{

address-mask-reply
T}:T{

18
T}
.TE


**ICMP Type specification**. 

.if n \{.RS 4
.\}
    # match ping packets
    filter output icmp type { echo-request, echo-reply }
.if n \{.RE
.\}


<a name="icmp-code-type"></a>

### ICMP CODE TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

ICMP Code
T}:T{

icmp_code
T}:T{

8 bit
T}:T{

integer
T}
.TE


The ICMP Code type is used to conveniently specify the ICMP header’s code field.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;18.&nbsp;Keywords may be used when specifying the ICMP code**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

net-unreachable
T}:T{

0
T}
T{

host-unreachable
T}:T{

1
T}
T{

prot-unreachable
T}:T{

2
T}
T{

port-unreachable
T}:T{

3
T}
T{

net-prohibited
T}:T{

9
T}
T{

host-prohibited
T}:T{

10
T}
T{

admin-prohibited
T}:T{

13
T}
.TE


<a name="icmpv6-type-type"></a>

### ICMPV6 TYPE TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

ICMPv6 Type
T}:T{

icmpx_code
T}:T{

8 bit
T}:T{

integer
T}
.TE


The ICMPv6 Type type is used to conveniently specify the ICMPv6 header’s type field.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;19.&nbsp;keywords may be used when specifying the ICMPv6 type:**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

destination-unreachable
T}:T{

1
T}
T{

packet-too-big
T}:T{

2
T}
T{

time-exceeded
T}:T{

3
T}
T{

parameter-problem
T}:T{

4
T}
T{

echo-request
T}:T{

128
T}
T{

echo-reply
T}:T{

129
T}
T{

mld-listener-query
T}:T{

130
T}
T{

mld-listener-report
T}:T{

131
T}
T{

mld-listener-done
T}:T{

132
T}
T{

mld-listener-reduction
T}:T{

132
T}
T{

nd-router-solicit
T}:T{

133
T}
T{

nd-router-advert
T}:T{

134
T}
T{

nd-neighbor-solicit
T}:T{

135
T}
T{

nd-neighbor-advert
T}:T{

136
T}
T{

nd-redirect
T}:T{

137
T}
T{

router-renumbering
T}:T{

138
T}
T{

ind-neighbor-solicit
T}:T{

141
T}
T{

ind-neighbor-advert
T}:T{

142
T}
T{

mld2-listener-report
T}:T{

143
T}
.TE


**ICMPv6 Type specification**. 

.if n \{.RS 4
.\}
    # match ICMPv6 ping packets
    filter output icmpv6 type { echo-request, echo-reply }
.if n \{.RE
.\}


<a name="icmpv6-code-type"></a>

### ICMPV6 CODE TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

ICMPv6 Code
T}:T{

icmpv6_code
T}:T{

8 bit
T}:T{

integer
T}
.TE


The ICMPv6 Code type is used to conveniently specify the ICMPv6 header’s code field.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;20.&nbsp;keywords may be used when specifying the ICMPv6 code**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

no-route
T}:T{

0
T}
T{

admin-prohibited
T}:T{

1
T}
T{

addr-unreachable
T}:T{

3
T}
T{

port-unreachable
T}:T{

4
T}
T{

policy-fail
T}:T{

5
T}
T{

reject-route
T}:T{

6
T}
.TE


<a name="icmpvx-code-type"></a>

### ICMPVX CODE TYPE

.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt.
T{

ICMPvX Code
T}:T{

icmpv6_type
T}:T{

8 bit
T}:T{

integer
T}
.TE


The ICMPvX Code type abstraction is a set of values which overlap between ICMP and ICMPv6 Code types to be used from the inet family.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;21.&nbsp;keywords may be used when specifying the ICMPvX code**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt
lt lt
lt lt.
T{

no-route
T}:T{

0
T}
T{

port-unreachable
T}:T{

1
T}
T{

host-unreachable
T}:T{

2
T}
T{

admin-prohibited
T}:T{

3
T}
.TE


<a name="conntrack-types"></a>

### CONNTRACK TYPES


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;22.&nbsp;overview of types used in ct expression and statement**
.TS
allbox tab(:);
ltB ltB ltB ltB.
T{
Name
T}:T{
Keyword
T}:T{
Size
T}:T{
Base type
T}
.T&
lt lt lt lt
lt lt lt lt
lt lt lt lt
lt lt lt lt
lt lt lt lt.
T{

conntrack state
T}:T{

ct_state
T}:T{

4 byte
T}:T{

bitmask
T}
T{

conntrack direction
T}:T{

ct_dir
T}:T{

8 bit
T}:T{

integer
T}
T{

conntrack status
T}:T{

ct_status
T}:T{

4 byte
T}:T{

bitmask
T}
T{

conntrack event bits
T}:T{

ct_event
T}:T{

4 byte
T}:T{

bitmask
T}
T{

conntrack label
T}:T{

ct_label
T}:T{

128 bit
T}:T{

bitmask
T}
.TE


For each of the types above, keywords are available for convenience:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;23.&nbsp;conntrack state (ct_state)**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

invalid
T}:T{

1
T}
T{

established
T}:T{

2
T}
T{

related
T}:T{

4
T}
T{

new
T}:T{

8
T}
T{

untracked
T}:T{

64
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;24.&nbsp;conntrack direction (ct_dir)**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt.
T{

original
T}:T{

0
T}
T{

reply
T}:T{

1
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;25.&nbsp;conntrack status (ct_status)**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

expected
T}:T{

1
T}
T{

seen-reply
T}:T{

2
T}
T{

assured
T}:T{

4
T}
T{

confirmed
T}:T{

8
T}
T{

snat
T}:T{

16
T}
T{

dnat
T}:T{

32
T}
T{

dying
T}:T{

512
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;26.&nbsp;conntrack event bits (ct_event)**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Value
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

new
T}:T{

1
T}
T{

related
T}:T{

2
T}
T{

destroy
T}:T{

4
T}
T{

reply
T}:T{

8
T}
T{

assured
T}:T{

16
T}
T{

protoinfo
T}:T{

32
T}
T{

helper
T}:T{

64
T}
T{

mark
T}:T{

128
T}
T{

seqadj
T}:T{

256
T}
T{

secmark
T}:T{

512
T}
T{

label
T}:T{

1024
T}
.TE


Possible keywords for conntrack label type (ct_label) are read at runtime from /etc/connlabel.conf.

<a name="primary-expressions"></a>

# Primary Expressions


The lowest order expression is a primary expression, representing either a constant or a single datum from a packet’s payload, meta data or a stateful module.

<a name="meta-expressions"></a>

### META EXPRESSIONS


.if n \{.RS 4
.\}
    meta {length | nfproto | l4proto | protocol | priority}
    [meta] {mark | iif | iifname | iiftype | oif | oifname | oiftype | skuid | skgid | nftrace | rtclassid | ibrname | obrname | pkttype | cpu | iifgroup | oifgroup | cgroup | random | ipsec | iifkind | oifkind | time | hour | day }
.if n \{.RE
.\}

A meta expression refers to meta data associated with a packet.

There are two types of meta expressions: unqualified and qualified meta expressions. Qualified meta expressions require the meta keyword before the meta key, unqualified meta expressions can be specified by using the meta key directly or as qualified meta expressions. Meta l4proto is useful to match a particular transport protocol that is part of either an IPv4 or IPv6 packet. It will also skip any IPv6 extension headers present in an IPv6 packet.

meta iif, oif, iifname and oifname are used to match the interface a packet arrived on or is about to be sent out on.

iif and oif are used to match on the interface index, whereas iifname and oifname are used to match on the interface name. This is not the same — assuming the rule

.if n \{.RS 4
.\}
    filter input meta iif "foo"
.if n \{.RE
.\}

Then this rule can only be added if the interface "foo" exists. Also, the rule will continue to match even if the interface "foo" is renamed to "bar".

This is because internally the interface index is used. In case of dynamically created interfaces, such as tun/tap or dialup interfaces (ppp for example), it might be better to use iifname or oifname instead.

In these cases, the name is used so the interface doesn’t have to exist to add such a rule, it will stop matching if the interface gets renamed and it will match again in case interface gets deleted and later a new interface with the same name is created.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;27.&nbsp;Meta expression types**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

length
T}:T{

Length of the packet in bytes
T}:T{

integer (32-bit)
T}
T{

nfproto
T}:T{

real hook protocol family, useful only in inet table
T}:T{

integer (32 bit)
T}
T{

l4proto
T}:T{

layer 4 protocol, skips ipv6 extension headers
T}:T{

integer (8 bit)
T}
T{

protocol
T}:T{

EtherType protocol value
T}:T{

ether_type
T}
T{

priority
T}:T{

TC packet priority
T}:T{

tc_handle
T}
T{

mark
T}:T{

Packet mark
T}:T{

mark
T}
T{

iif
T}:T{

Input interface index
T}:T{

iface_index
T}
T{

iifname
T}:T{

Input interface name
T}:T{

ifname
T}
T{

iiftype
T}:T{

Input interface type
T}:T{

iface_type
T}
T{

oif
T}:T{

Output interface index
T}:T{

iface_index
T}
T{

oifname
T}:T{

Output interface name
T}:T{

ifname
T}
T{

oiftype
T}:T{

Output interface hardware type
T}:T{

iface_type
T}
T{

skuid
T}:T{

UID associated with originating socket
T}:T{

uid
T}
T{

skgid
T}:T{

GID associated with originating socket
T}:T{

gid
T}
T{

rtclassid
T}:T{

Routing realm
T}:T{

realm
T}
T{

ibrname
T}:T{

Input bridge interface name
T}:T{

ifname
T}
T{

obrname
T}:T{

Output bridge interface name
T}:T{

ifname
T}
T{

pkttype
T}:T{

packet type
T}:T{

pkt_type
T}
T{

cpu
T}:T{

cpu number processing the packet
T}:T{

integer (32 bit)
T}
T{

iifgroup
T}:T{

incoming device group
T}:T{

devgroup
T}
T{

oifgroup
T}:T{

outgoing device group
T}:T{

devgroup
T}
T{

cgroup
T}:T{

control group id
T}:T{

integer (32 bit)
T}
T{

random
T}:T{

pseudo-random number
T}:T{

integer (32 bit)
T}
T{

ipsec
T}:T{

boolean
T}:T{

boolean (1 bit)
T}
T{

iifkind
T}:T{

Input interface kind
T}:T{

T}
T{

oifkind
T}:T{

Output interface kind
T}:T{

T}
T{

time
T}:T{

Absolute time of packet reception
T}:T{

Integer (32 bit) or string
T}
T{

day
T}:T{

Day of week
T}:T{

Integer (8 bit) or string
T}
T{

hour
T}:T{

Hour of day
T}:T{

String
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;28.&nbsp;Meta expression specific types**
.TS
allbox tab(:);
ltB ltB.
T{
Type
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

iface_index
T}:T{

Interface index (32 bit number). Can be specified numerically or as name of an existing interface.
T}
T{

ifname
T}:T{

Interface name (16 byte string). Does not have to exist.
T}
T{

iface_type
T}:T{

Interface type (16 bit number).
T}
T{

uid
T}:T{

User ID (32 bit number). Can be specified numerically or as user name.
T}
T{

gid
T}:T{

Group ID (32 bit number). Can be specified numerically or as group name.
T}
T{

realm
T}:T{

Routing Realm (32 bit number). Can be specified numerically or as symbolic name defined in /etc/iproute2/rt_realms.
T}
T{

devgroup_type
T}:T{

Device group (32 bit number). Can be specified numerically or as symbolic name defined in /etc/iproute2/group.
T}
T{

pkt_type
T}:T{

Packet type: **host** (addressed to local host), **broadcast** (to all), **multicast** (to group), **other** (addressed to another host).
T}
T{

ifkind
T}:T{

Interface kind (16 byte string). Does not have to exist.
T}
T{

time
T}:T{

Either an integer or a date in ISO format. For example: "2019-06-06 17:00". Hour and seconds are optional and can be omitted if desired. If omitted, midnight will be assumed. The following three would be equivalent: "2019-06-06", "2019-06-06 00:00" and "2019-06-06 00:00:00". When an integer is given, it is assumed to be a UNIX timestamp.
T}
T{

day
T}:T{

Either a day of week ("Monday", "Tuesday", etc.), or an integer between 0 and 6. Strings are matched case-insensitively, and a full match is not expected (e.g. "Mon" would match "Monday"). When an integer is given, 0 is Sunday and 6 is Saturday.
T}
T{

hour
T}:T{

A string representing an hour in 24-hour format. Seconds can optionally be specified. For example, 17:00 and 17:00:00 would be equivalent.
T}
.TE


**Using meta expressions**. 

.if n \{.RS 4
.\}
    # qualified meta expression
    filter output meta oif eth0
    
    # unqualified meta expression
    filter output oif eth0
    
    # packet was subject to ipsec processing
    raw prerouting meta ipsec exists accept
.if n \{.RE
.\}


<a name="socket-expression"></a>

### SOCKET EXPRESSION


.if n \{.RS 4
.\}
    socket {transparent | mark}
.if n \{.RE
.\}

Socket expression can be used to search for an existing open TCP/UDP socket and its attributes that can be associated with a packet. It looks for an established or non-zero bound listening socket (possibly with a non-local address).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;29.&nbsp;Available socket attributes**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Name
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt.
T{

transparent
T}:T{

Value of the IP_TRANSPARENT socket option in the found socket. It can be 0 or 1.
T}:T{

boolean (1 bit)
T}
T{

mark
T}:T{

Value of the socket mark (SOL_SOCKET, SO_MARK).
T}:T{

mark
T}
.TE


**Using socket expression**. 

.if n \{.RS 4
.\}
    # Mark packets that correspond to a transparent socket
    table inet x {
        chain y {
            type filter hook prerouting priority -150; policy accept;
            socket transparent 1 mark set 0x00000001 accept
        }
    }
    
    # Trace packets that corresponds to a socket with a mark value of 15
    table inet x {
        chain y {
            type filter hook prerouting priority -150; policy accept;
            socket mark 0x0000000f nftrace set 1
        }
    }
    
    # Set packet mark to socket mark
    table inet x {
        chain y {
            type filter hook prerouting priority -150; policy accept;
            tcp dport 8080 mark set socket mark
        }
    }
.if n \{.RE
.\}


<a name="osf-expression"></a>

### OSF EXPRESSION


.if n \{.RS 4
.\}
    osf [ttl {loose | skip}] {name | version}
.if n \{.RE
.\}

The osf expression does passive operating system fingerprinting. This expression compares some data (Window Size, MSS, options and their order, DF, and others) from packets with the SYN bit set.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;30.&nbsp;Available osf attributes**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Name
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt.
T{

ttl
T}:T{

Do TTL checks on the packet to determine the operating system.
T}:T{

string
T}
T{

version
T}:T{

Do OS version checks on the packet.
T}:T{

T}
T{

name
T}:T{

Name of the OS signature to match. All signatures can be found at pf.os file. Use "unknown" for OS signatures that the expression could not detect.
T}:T{

string
T}
.TE


**Available ttl values**. 

.if n \{.RS 4
.\}
    If no TTL attribute is passed, make a true IP header and fingerprint TTL true comparison. This generally works for LANs.
    
    * loose: Check if the IP headers TTL is less than the fingerprint one. Works for globally-routable addresses.
    * skip: Do not compare the TTL at all.
.if n \{.RE
.\}

**Using osf expression**. 

.if n \{.RS 4
.\}
    # Accept packets that match the "Linux" OS genre signature without comparing TTL.
    table inet x {
        chain y {
            type filter hook input priority 0; policy accept;
            osf ttl skip name "Linux"
        }
    }
.if n \{.RE
.\}


<a name="fib-expressions"></a>

### FIB EXPRESSIONS


.if n \{.RS 4
.\}
    fib {saddr | daddr | mark | iif | oif} [. ...] {oif | oifname | type}
.if n \{.RE
.\}

A fib expression queries the fib (forwarding information base) to obtain information such as the output interface index a particular address would use. The input is a tuple of elements that is used as input to the fib lookup functions.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;31.&nbsp;fib expression specific types**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt.
T{

oif
T}:T{

Output interface index
T}:T{

integer (32 bit)
T}
T{

oifname
T}:T{

Output interface name
T}:T{

string
T}
T{

type
T}:T{

Address type
T}:T{

fib_addrtype
T}
.TE


Use **nft** **describe** **fib\_addrtype** to get a list of all address types.

**Using fib expressions**. 

.if n \{.RS 4
.\}
    # drop packets without a reverse path
    filter prerouting fib saddr . iif oif missing drop
    
    In this example, saddr . iif*(Aq looks up routing information based on the source address and the input interface.
    oif picks the output interface index from the routing information.
    If no route was found for the source address/input interface combination, the output interface index is zero.
    In case the input interface is specified as part of the input key, the output interface index is always the same as the input interface index or zero.
    If only saddr oif*(Aq is given, then oif can be any interface index or zero.
    
    In this example, saddr . iif*(Aq lookups up routing information based on the source address and the input interface.
    oif picks the output interface index from the routing information.
    If no route was found for the source address/input interface combination, the output interface index is zero.
    In case the input interface is specified as part of the input key, the output interface index is always the same as the input interface index or zero.
    If only saddr oif*(Aq is given, then oif can be any interface index or zero.
    
    # drop packets to address not configured on ininterface
    filter prerouting fib daddr . iif type != { local, broadcast, multicast } drop
    
    # perform lookup in a specific blackhole*(Aq table (0xdead, needs ip appropriate ip rule)
    filter prerouting meta mark set 0xdead fib daddr . mark type vmap { blackhole : drop, prohibit : jump prohibited, unreachable : drop }
.if n \{.RE
.\}


<a name="routing-expressions"></a>

### ROUTING EXPRESSIONS


.if n \{.RS 4
.\}
    rt [ip | ip6] {classid | nexthop | mtu | ipsec}
.if n \{.RE
.\}

A routing expression refers to routing data associated with a packet.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;32.&nbsp;Routing expression types**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

classid
T}:T{

Routing realm
T}:T{

realm
T}
T{

nexthop
T}:T{

Routing nexthop
T}:T{

ipv4_addr/ipv6_addr
T}
T{

mtu
T}:T{

TCP maximum segment size of route
T}:T{

integer (16 bit)
T}
T{

ipsec
T}:T{

route via ipsec tunnel or transport
T}:T{

boolean
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;33.&nbsp;Routing expression specific types**
.TS
allbox tab(:);
ltB ltB.
T{
Type
T}:T{
Description
T}
.T&
lt lt.
T{

realm
T}:T{

Routing Realm (32 bit number). Can be specified numerically or as symbolic name defined in /etc/iproute2/rt_realms.
T}
.TE


**Using routing expressions**. 

.if n \{.RS 4
.\}
    # IP family independent rt expression
    filter output rt classid 10
    filter output rt ipsec missing
    
    # IP family dependent rt expressions
    ip filter output rt nexthop 192.168.0.1
    ip6 filter output rt nexthop fd00::1
    inet filter output rt ip nexthop 192.168.0.1
    inet filter output rt ip6 nexthop fd00::1
.if n \{.RE
.\}


<a name="ipsec-expressions"></a>

### IPSEC EXPRESSIONS


.if n \{.RS 4
.\}
    ipsec {in | out} [ spnum NUM ]  {reqid | spi}
    ipsec {in | out} [ spnum NUM ]  {ip | ip6} {saddr | daddr}
.if n \{.RE
.\}

An ipsec expression refers to ipsec data associated with a packet.

The _in_ or _out_ keyword needs to be used to specify if the expression should examine inbound or outbound policies. The _in_ keyword can be used in the prerouting, input and forward hooks. The _out_ keyword applies to forward, output and postrouting hooks. The optional keyword spnum can be used to match a specific state in a chain, it defaults to 0.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;34.&nbsp;Ipsec expression types**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

reqid
T}:T{

Request ID
T}:T{

integer (32 bit)
T}
T{

spi
T}:T{

Security Parameter Index
T}:T{

integer (32 bit)
T}
T{

saddr
T}:T{

Source address of the tunnel
T}:T{

ipv4_addr/ipv6_addr
T}
T{

daddr
T}:T{

Destination address of the tunnel
T}:T{

ipv4_addr/ipv6_addr
T}
.TE


<a name="numgen-expression"></a>

### NUMGEN EXPRESSION


.if n \{.RS 4
.\}
    numgen {inc | random} mod NUM [ offset NUM ]
.if n \{.RE
.\}

Create a number generator. The **inc** or **random** keywords control its operation mode: In **inc** mode, the last returned value is simply incremented. In **random** mode, a new random number is returned. The value after **mod** keyword specifies an upper boundary (read: modulus) which is not reached by returned numbers. The optional **offset** allows to increment the returned value by a fixed offset.

A typical use-case for **numgen** is load-balancing:

**Using numgen expression**. 

.if n \{.RS 4
.\}
    # round-robin between 192.168.10.100 and 192.168.20.200:
    add rule nat prerouting dnat to numgen inc mod 2 map e
            { 0 : 192.168.10.100, 1 : 192.168.20.200 }
    
    # probability-based with odd bias using intervals:
    add rule nat prerouting dnat to numgen random mod 10 map e
            { 0-2 : 192.168.10.100, 3-9 : 192.168.20.200 }
.if n \{.RE
.\}


<a name="payload-expressions"></a>

# Payload Expressions


Payload expressions refer to data from the packet’s payload.

<a name="ethernet-header-expression"></a>

### ETHERNET HEADER EXPRESSION


.if n \{.RS 4
.\}
    ether {daddr | saddr | type}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;35.&nbsp;Ethernet header expression types**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt.
T{

daddr
T}:T{

Destination MAC address
T}:T{

ether_addr
T}
T{

saddr
T}:T{

Source MAC address
T}:T{

ether_addr
T}
T{

type
T}:T{

EtherType
T}:T{

ether_type
T}
.TE


<a name="vlan-header-expression"></a>

### VLAN HEADER EXPRESSION


.if n \{.RS 4
.\}
    vlan {id | cfi | pcp | type}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;36.&nbsp;VLAN header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

id
T}:T{

VLAN ID (VID)
T}:T{

integer (12 bit)
T}
T{

cfi
T}:T{

Canonical Format Indicator
T}:T{

integer (1 bit)
T}
T{

pcp
T}:T{

Priority code point
T}:T{

integer (3 bit)
T}
T{

type
T}:T{

EtherType
T}:T{

ether_type
T}
.TE


<a name="arp-header-expression"></a>

### ARP HEADER EXPRESSION


.if n \{.RS 4
.\}
    arp {htype | ptype | hlen | plen | operation | saddr { ip | ether } | daddr { ip | ether }
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;37.&nbsp;ARP header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

htype
T}:T{

ARP hardware type
T}:T{

integer (16 bit)
T}
T{

ptype
T}:T{

EtherType
T}:T{

ether_type
T}
T{

hlen
T}:T{

Hardware address len
T}:T{

integer (8 bit)
T}
T{

plen
T}:T{

Protocol address len
T}:T{

integer (8 bit)
T}
T{

operation
T}:T{

Operation
T}:T{

arp_op
T}
T{

saddr ether
T}:T{

Ethernet sender address
T}:T{

ether_addr
T}
T{

daddr ether
T}:T{

Ethernet target address
T}:T{

ether_addr
T}
T{

saddr ip
T}:T{

IPv4 sender address
T}:T{

ipv4_addr
T}
T{

daddr ip
T}:T{

IPv4 target address
T}:T{

ipv4_addr
T}
.TE


<a name="ipv4-header-expression"></a>

### IPV4 HEADER EXPRESSION


.if n \{.RS 4
.\}
    ip {version | hdrlength | dscp | ecn | length | id | frag-off | ttl | protocol | checksum | saddr | daddr }
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;38.&nbsp;IPv4 header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

version
T}:T{

IP header version (4)
T}:T{

integer (4 bit)
T}
T{

hdrlength
T}:T{

IP header length including options
T}:T{

integer (4 bit) FIXME scaling
T}
T{

dscp
T}:T{

Differentiated Services Code Point
T}:T{

dscp
T}
T{

ecn
T}:T{

Explicit Congestion Notification
T}:T{

ecn
T}
T{

length
T}:T{

Total packet length
T}:T{

integer (16 bit)
T}
T{

id
T}:T{

IP ID
T}:T{

integer (16 bit)
T}
T{

frag-off
T}:T{

Fragment offset
T}:T{

integer (16 bit)
T}
T{

ttl
T}:T{

Time to live
T}:T{

integer (8 bit)
T}
T{

protocol
T}:T{

Upper layer protocol
T}:T{

inet_proto
T}
T{

checksum
T}:T{

IP header checksum
T}:T{

integer (16 bit)
T}
T{

saddr
T}:T{

Source address
T}:T{

ipv4_addr
T}
T{

daddr
T}:T{

Destination address
T}:T{

ipv4_addr
T}
.TE


<a name="icmp-header-expression"></a>

### ICMP HEADER EXPRESSION


.if n \{.RS 4
.\}
    icmp {type | code | checksum | id | sequence | gateway | mtu}
.if n \{.RE
.\}

This expression refers to ICMP header fields. When using it in **inet**, **bridge** or **netdev** families, it will cause an implicit dependency on IPv4 to be created. To match on unusual cases like ICMP over IPv6, one has to add an explicit **meta protocol ip6** match to the rule.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;39.&nbsp;ICMP header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

type
T}:T{

ICMP type field
T}:T{

icmp_type
T}
T{

code
T}:T{

ICMP code field
T}:T{

integer (8 bit)
T}
T{

checksum
T}:T{

ICMP checksum field
T}:T{

integer (16 bit)
T}
T{

id
T}:T{

ID of echo request/response
T}:T{

integer (16 bit)
T}
T{

sequence
T}:T{

sequence number of echo request/response
T}:T{

integer (16 bit)
T}
T{

gateway
T}:T{

gateway of redirects
T}:T{

integer (32 bit)
T}
T{

mtu
T}:T{

MTU of path MTU discovery
T}:T{

integer (16 bit)
T}
.TE


<a name="igmp-header-expression"></a>

### IGMP HEADER EXPRESSION


.if n \{.RS 4
.\}
    igmp {type | mrt | checksum | group}
.if n \{.RE
.\}

This expression refers to IGMP header fields. When using it in **inet**, **bridge** or **netdev** families, it will cause an implicit dependency on IPv4 to be created. To match on unusual cases like IGMP over IPv6, one has to add an explicit **meta protocol ip6** match to the rule.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;40.&nbsp;IGMP header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

type
T}:T{

IGMP type field
T}:T{

igmp_type
T}
T{

mrt
T}:T{

IGMP maximum response time field
T}:T{

integer (8 bit)
T}
T{

checksum
T}:T{

ICMP checksum field
T}:T{

integer (16 bit)
T}
T{

group
T}:T{

Group address
T}:T{

integer (32 bit)
T}
.TE


<a name="ipv6-header-expression"></a>

### IPV6 HEADER EXPRESSION


.if n \{.RS 4
.\}
    ip6 {version | dscp | ecn | flowlabel | length | nexthdr | hoplimit | saddr | daddr}
.if n \{.RE
.\}

This expression refers to the ipv6 header fields. Caution when using **ip6 nexthdr**, the value only refers to the next header, i.e. **ip6 nexthdr tcp** will only match if the ipv6 packet does not contain any extension headers. Packets that are fragmented or e.g. contain a routing extension headers will not be matched. Please use **meta l4proto** if you wish to match the real transport header and ignore any additional extension headers instead.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;41.&nbsp;IPv6 header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

version
T}:T{

IP header version (6)
T}:T{

integer (4 bit)
T}
T{

dscp
T}:T{

Differentiated Services Code Point
T}:T{

dscp
T}
T{

ecn
T}:T{

Explicit Congestion Notification
T}:T{

ecn
T}
T{

flowlabel
T}:T{

Flow label
T}:T{

integer (20 bit)
T}
T{

length
T}:T{

Payload length
T}:T{

integer (16 bit)
T}
T{

nexthdr
T}:T{

Nexthdr protocol
T}:T{

inet_proto
T}
T{

hoplimit
T}:T{

Hop limit
T}:T{

integer (8 bit)
T}
T{

saddr
T}:T{

Source address
T}:T{

ipv6_addr
T}
T{

daddr
T}:T{

Destination address
T}:T{

ipv6_addr
T}
.TE


**Using ip6 header expressions**. 

.if n \{.RS 4
.\}
    # matching if first extension header indicates a fragment
    ip6 nexthdr ipv6-frag
.if n \{.RE
.\}


<a name="icmpv6-header-expression"></a>

### ICMPV6 HEADER EXPRESSION


.if n \{.RS 4
.\}
    icmpv6 {type | code | checksum | parameter-problem | packet-too-big | id | sequence | max-delay}
.if n \{.RE
.\}

This expression refers to ICMPv6 header fields. When using it in **inet**, **bridge** or **netdev** families, it will cause an implicit dependency on IPv6 to be created. To match on unusual cases like ICMPv6 over IPv4, one has to add an explicit **meta protocol ip** match to the rule.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;42.&nbsp;ICMPv6 header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

type
T}:T{

ICMPv6 type field
T}:T{

icmpv6_type
T}
T{

code
T}:T{

ICMPv6 code field
T}:T{

integer (8 bit)
T}
T{

checksum
T}:T{

ICMPv6 checksum field
T}:T{

integer (16 bit)
T}
T{

parameter-problem
T}:T{

pointer to problem
T}:T{

integer (32 bit)
T}
T{

packet-too-big
T}:T{

oversized MTU
T}:T{

integer (32 bit)
T}
T{

id
T}:T{

ID of echo request/response
T}:T{

integer (16 bit)
T}
T{

sequence
T}:T{

sequence number of echo request/response
T}:T{

integer (16 bit)
T}
T{

max-delay
T}:T{

maximum response delay of MLD queries
T}:T{

integer (16 bit)
T}
.TE


<a name="tcp-header-expression"></a>

### TCP HEADER EXPRESSION


.if n \{.RS 4
.\}
    tcp {sport | dport | sequence | ackseq | doff | reserved | flags | window | checksum | urgptr}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;43.&nbsp;TCP header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

sport
T}:T{

Source port
T}:T{

inet_service
T}
T{

dport
T}:T{

Destination port
T}:T{

inet_service
T}
T{

sequence
T}:T{

Sequence number
T}:T{

integer (32 bit)
T}
T{

ackseq
T}:T{

Acknowledgement number
T}:T{

integer (32 bit)
T}
T{

doff
T}:T{

Data offset
T}:T{

integer (4 bit) FIXME scaling
T}
T{

reserved
T}:T{

Reserved area
T}:T{

integer (4 bit)
T}
T{

flags
T}:T{

TCP flags
T}:T{

tcp_flag
T}
T{

window
T}:T{

Window
T}:T{

integer (16 bit)
T}
T{

checksum
T}:T{

Checksum
T}:T{

integer (16 bit)
T}
T{

urgptr
T}:T{

Urgent pointer
T}:T{

integer (16 bit)
T}
.TE


<a name="udp-header-expression"></a>

### UDP HEADER EXPRESSION


.if n \{.RS 4
.\}
    udp {sport | dport | length | checksum}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;44.&nbsp;UDP header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

sport
T}:T{

Source port
T}:T{

inet_service
T}
T{

dport
T}:T{

Destination port
T}:T{

inet_service
T}
T{

length
T}:T{

Total packet length
T}:T{

integer (16 bit)
T}
T{

checksum
T}:T{

Checksum
T}:T{

integer (16 bit)
T}
.TE


<a name="udp-lite-header-expression"></a>

### UDP\-LITE HEADER EXPRESSION


.if n \{.RS 4
.\}
    udplite {sport | dport | checksum}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;45.&nbsp;UDP-Lite header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt.
T{

sport
T}:T{

Source port
T}:T{

inet_service
T}
T{

dport
T}:T{

Destination port
T}:T{

inet_service
T}
T{

checksum
T}:T{

Checksum
T}:T{

integer (16 bit)
T}
.TE


<a name="sctp-header-expression"></a>

### SCTP HEADER EXPRESSION


.if n \{.RS 4
.\}
    sctp {sport | dport | vtag | checksum}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;46.&nbsp;SCTP header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

sport
T}:T{

Source port
T}:T{

inet_service
T}
T{

dport
T}:T{

Destination port
T}:T{

inet_service
T}
T{

vtag
T}:T{

Verification Tag
T}:T{

integer (32 bit)
T}
T{

checksum
T}:T{

Checksum
T}:T{

integer (32 bit)
T}
.TE


<a name="dccp-header-expression"></a>

### DCCP HEADER EXPRESSION


.if n \{.RS 4
.\}
    dccp {sport | dport}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;47.&nbsp;DCCP header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt.
T{

sport
T}:T{

Source port
T}:T{

inet_service
T}
T{

dport
T}:T{

Destination port
T}:T{

inet_service
T}
.TE


<a name="authentication-header-expression"></a>

### AUTHENTICATION HEADER EXPRESSION


.if n \{.RS 4
.\}
    ah {nexthdr | hdrlength | reserved | spi | sequence}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;48.&nbsp;AH header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

nexthdr
T}:T{

Next header protocol
T}:T{

inet_proto
T}
T{

hdrlength
T}:T{

AH Header length
T}:T{

integer (8 bit)
T}
T{

reserved
T}:T{

Reserved area
T}:T{

integer (16 bit)
T}
T{

spi
T}:T{

Security Parameter Index
T}:T{

integer (32 bit)
T}
T{

sequence
T}:T{

Sequence number
T}:T{

integer (32 bit)
T}
.TE


<a name="encrypted-security-payload-header-expression"></a>

### ENCRYPTED SECURITY PAYLOAD HEADER EXPRESSION


.if n \{.RS 4
.\}
    esp {spi | sequence}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;49.&nbsp;ESP header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt.
T{

spi
T}:T{

Security Parameter Index
T}:T{

integer (32 bit)
T}
T{

sequence
T}:T{

Sequence number
T}:T{

integer (32 bit)
T}
.TE


<a name="ipcomp-header-expression"></a>

### IPCOMP HEADER EXPRESSION


**comp** {**nexthdr** | **flags** | **cpi**}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;50.&nbsp;IPComp header expression**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt.
T{

nexthdr
T}:T{

Next header protocol
T}:T{

inet_proto
T}
T{

flags
T}:T{

Flags
T}:T{

bitmask
T}
T{

cpi
T}:T{

compression Parameter Index
T}:T{

integer (16 bit)
T}
.TE


<a name="raw-payload-expression"></a>

### RAW PAYLOAD EXPRESSION


.if n \{.RS 4
.\}
    @base,offset,length
.if n \{.RE
.\}

The raw payload expression instructs to load _length_ bits starting at _offset_ bits. Bit 0 refers to the very first bit — in the C programming language, this corresponds to the topmost bit, i.e. 0x80 in case of an octet. They are useful to match headers that do not have a human-readable template expression yet. Note that nft will not add dependencies for Raw payload expressions. If you e.g. want to match protocol fields of a transport header with protocol number 5, you need to manually exclude packets that have a different transport header, for instance by using **meta l4proto 5** before the raw expression.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;51.&nbsp;Supported payload protocol bases**
.TS
allbox tab(:);
ltB ltB.
T{
Base
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt.
T{

ll
T}:T{

Link layer, for example the Ethernet header
T}
T{

nh
T}:T{

Network header, for example IPv4 or IPv6
T}
T{

th
T}:T{

Transport Header, for example TCP
T}
.TE


**Matching destination port of both UDP and TCP**. 

.if n \{.RS 4
.\}
    inet filter input meta l4proto {tcp, udp} @th,16,16 { 53, 80 }
.if n \{.RE
.\}

The above can also be written as

.if n \{.RS 4
.\}
    inet filter input meta l4proto {tcp, udp} th dport { 53, 80 }
.if n \{.RE
.\}

it is more convenient, but like the raw expression notation no dependencies are created or checked. It is the users responsibility to restrict matching to those header types that have a notion of ports. Otherwise, rules using raw expressions will errnously match unrelated packets, e.g. mis-interpreting ESP packets SPI field as a port.

**Rewrite arp packet target hardware address if target protocol address matches a given address**. 

.if n \{.RS 4
.\}
    input meta iifname enp2s0 arp ptype 0x0800 arp htype 1 arp hlen 6 arp plen 4 @nh,192,32 0xc0a88f10 @nh,144,48 set 0x112233445566 accept
.if n \{.RE
.\}


<a name="extension-header-expressions"></a>

### EXTENSION HEADER EXPRESSIONS


Extension header expressions refer to data from variable-sized protocol headers, such as IPv6 extension headers, TCP options and IPv4 options.

nftables currently supports matching (finding) a given ipv6 extension header, TCP option or IPv4 option.

.if n \{.RS 4
.\}
    hbh {nexthdr | hdrlength}
    frag {nexthdr | frag-off | more-fragments | id}
    rt {nexthdr | hdrlength | type | seg-left}
    dst {nexthdr | hdrlength}
    mh {nexthdr | hdrlength | checksum | type}
    srh {flags | tag | sid | seg-left}
    tcp option {eol | noop | maxseg | window | sack-permitted | sack | sack0 | sack1 | sack2 | sack3 | timestamp} tcp_option_field
    ip option { lsrr | ra | rr | ssrr } ip_option_field
.if n \{.RE
.\}

The following syntaxes are valid only in a relational expression with boolean type on right-hand side for checking header existence only:

.if n \{.RS 4
.\}
    exthdr {hbh | frag | rt | dst | mh}
    tcp option {eol | noop | maxseg | window | sack-permitted | sack | sack0 | sack1 | sack2 | sack3 | timestamp}
    ip option { lsrr | ra | rr | ssrr }
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;52.&nbsp;IPv6 extension headers**
.TS
allbox tab(:);
ltB ltB.
T{
Keyword
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

hbh
T}:T{

Hop by Hop
T}
T{

rt
T}:T{

Routing Header
T}
T{

frag
T}:T{

Fragmentation header
T}
T{

dst
T}:T{

dst options
T}
T{

mh
T}:T{

Mobility Header
T}
T{

srh
T}:T{

Segment Routing Header
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;53.&nbsp;TCP Options**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
TCP option fields
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

eol
T}:T{

End if option list
T}:T{

kind
T}
T{

noop
T}:T{

1 Byte TCP No-op options
T}:T{

kind
T}
T{

maxseg
T}:T{

TCP Maximum Segment Size
T}:T{

kind, length, size
T}
T{

window
T}:T{

TCP Window Scaling
T}:T{

kind, length, count
T}
T{

sack-permitted
T}:T{

TCP SACK permitted
T}:T{

kind, length
T}
T{

sack
T}:T{

TCP Selective Acknowledgement (alias of block 0)
T}:T{

kind, length, left, right
T}
T{

sack0
T}:T{

TCP Selective Acknowledgement (block 0)
T}:T{

kind, length, left, right
T}
T{

sack1
T}:T{

TCP Selective Acknowledgement (block 1)
T}:T{

kind, length, left, right
T}
T{

sack2
T}:T{

TCP Selective Acknowledgement (block 2)
T}:T{

kind, length, left, right
T}
T{

sack3
T}:T{

TCP Selective Acknowledgement (block 3)
T}:T{

kind, length, left, right
T}
T{

timestamp
T}:T{

TCP Timestamps
T}:T{

kind, length, tsval, tsecr
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;54.&nbsp;IP Options**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
IP option fields
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

lsrr
T}:T{

Loose Source Route
T}:T{

type, length, ptr, addr
T}
T{

ra
T}:T{

Router Alert
T}:T{

type, length, value
T}
T{

rr
T}:T{

Record Route
T}:T{

type, length, ptr, addr
T}
T{

ssrr
T}:T{

Strict Source Route
T}:T{

type, length, ptr, addr
T}
.TE


**finding TCP options**. 

.if n \{.RS 4
.\}
    filter input tcp option sack-permitted kind 1 counter
.if n \{.RE
.\}

**matching IPv6 exthdr**. 

.if n \{.RS 4
.\}
    ip6 filter input frag more-fragments 1 counter
.if n \{.RE
.\}

**finding IP option**. 

.if n \{.RS 4
.\}
    filter input ip option lsrr exists counter
.if n \{.RE
.\}


<a name="conntrack-expressions"></a>

### CONNTRACK EXPRESSIONS


Conntrack expressions refer to meta data of the connection tracking entry associated with a packet.

There are three types of conntrack expressions. Some conntrack expressions require the flow direction before the conntrack key, others must be used directly because they are direction agnostic. The **packets**, **bytes** and **avgpkt** keywords can be used with or without a direction. If the direction is omitted, the sum of the original and the reply direction is returned. The same is true for the **zone**, if a direction is given, the zone is only matched if the zone id is tied to the given direction.

.if n \{.RS 4
.\}
    ct {state | direction | status | mark | expiration | helper | label}
    ct [original | reply] {l3proto | protocol | bytes | packets | avgpkt | zone}
    ct {original | reply} {proto-src | proto-dst}
    ct {original | reply} {ip | ip6} {saddr | daddr}
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;55.&nbsp;Conntrack expressions**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

state
T}:T{

State of the connection
T}:T{

ct_state
T}
T{

direction
T}:T{

Direction of the packet relative to the connection
T}:T{

ct_dir
T}
T{

status
T}:T{

Status of the connection
T}:T{

ct_status
T}
T{

mark
T}:T{

Connection mark
T}:T{

mark
T}
T{

expiration
T}:T{

Connection expiration time
T}:T{

time
T}
T{

helper
T}:T{

Helper associated with the connection
T}:T{

string
T}
T{

label
T}:T{

Connection tracking label bit or symbolic name defined in connlabel.conf in the nftables include path
T}:T{

ct_label
T}
T{

l3proto
T}:T{

Layer 3 protocol of the connection
T}:T{

nf_proto
T}
T{

saddr
T}:T{

Source address of the connection for the given direction
T}:T{

ipv4_addr/ipv6_addr
T}
T{

daddr
T}:T{

Destination address of the connection for the given direction
T}:T{

ipv4_addr/ipv6_addr
T}
T{

protocol
T}:T{

Layer 4 protocol of the connection for the given direction
T}:T{

inet_proto
T}
T{

proto-src
T}:T{

Layer 4 protocol source for the given direction
T}:T{

integer (16 bit)
T}
T{

proto-dst
T}:T{

Layer 4 protocol destination for the given direction
T}:T{

integer (16 bit)
T}
T{

packets
T}:T{

packet count seen in the given direction or sum of original and reply
T}:T{

integer (64 bit)
T}
T{

bytes
T}:T{

byte count seen, see description for **packets** keyword
T}:T{

integer (64 bit)
T}
T{

avgpkt
T}:T{

average bytes per packet, see description for **packets** keyword
T}:T{

integer (64 bit)
T}
T{

zone
T}:T{

conntrack zone
T}:T{

integer (16 bit)
T}
.TE


A description of conntrack-specific types listed above can be found sub-section CONNTRACK TYPES above.

**restrict the number of parallel connections to a server**. 

.if n \{.RS 4
.\}
    filter input tcp dport 22 meter test { ip saddr ct count over 2 } reject
.if n \{.RE
.\}


<a name="statements"></a>

# Statements


Statements represent actions to be performed. They can alter control flow (return, jump to a different chain, accept or drop the packet) or can perform actions, such as logging, rejecting a packet, etc.

Statements exist in two kinds. Terminal statements unconditionally terminate evaluation of the current rule, non-terminal statements either only conditionally or never terminate evaluation of the current rule, in other words, they are passive from the ruleset evaluation perspective. There can be an arbitrary amount of non-terminal statements in a rule, but only a single terminal statement as the final statement.

<a name="verdict-statement"></a>

### VERDICT STATEMENT


The verdict statement alters control flow in the ruleset and issues policy decisions for packets.

.if n \{.RS 4
.\}
    {accept | drop | queue | continue | return}
    {jump | goto} chain
.if n \{.RE
.\}

**accept** and **drop** are absolute verdicts — they terminate ruleset evaluation immediately.
.TS
tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**accept**
T}:T{

Terminate ruleset evaluation and accept the packet. The packet can still be dropped later by another hook, for instance accept in the forward hook still allows to drop the packet later in the postrouting hook, or another forward base chain that has a higher priority number and is evaluated afterwards in the processing pipeline.
T}
T{

**drop**
T}:T{

Terminate ruleset evaluation and drop the packet. The drop occurs instantly, no further chains or hooks are evaluated. It is not possible to accept the packet in a later chain again, as those are not evaluated anymore for the packet.
T}
T{

**queue**
T}:T{

Terminate ruleset evaluation and queue the packet to userspace. Userspace must provide a drop or accept verdict. In case of accept, processing resumes with the next base chain hook, not the rule following the queue verdict.
T}
T{

**continue**
T}:T{

Continue ruleset evaluation with the next rule. This is the default behaviour in case a rule issues no verdict.
T}
T{

**return**
T}:T{

Return from the current chain and continue evaluation at the next rule in the last chain. If issued in a base chain, it is equivalent to the base chain policy.
T}
T{

**jump** _chain_
T}:T{

Continue evaluation at the first rule in _chain_. The current position in the ruleset is pushed to a call stack and evaluation will continue there when the new chain is entirely evaluated or a **return** verdict is issued. In case an absolute verdict is issued by a rule in the chain, ruleset evaluation terminates immediately and the specific action is taken.
T}
T{

**goto** _chain_
T}:T{

Similar to **jump**, but the current position is not pushed to the call stack, meaning that after the new chain evaluation will continue at the last chain instead of the one containing the goto statement.
T}
.TE


**Using verdict statements**. 

.if n \{.RS 4
.\}
    # process packets from eth0 and the internal network in from_lan
    # chain, drop all packets from eth0 with different source addresses.
    
    filter input iif eth0 ip saddr 192.168.0.0/24 jump from_lan
    filter input iif eth0 drop
.if n \{.RE
.\}


<a name="payload-statement"></a>

### PAYLOAD STATEMENT


.if n \{.RS 4
.\}
    payload_expression set value
.if n \{.RE
.\}

The payload statement alters packet content. It can be used for example to set ip DSCP (diffserv) header field or ipv6 flow labels.

**route some packets instead of bridging**. 

.if n \{.RS 4
.\}
    # redirect tcp:http from 192.160.0.0/16 to local machine for routing instead of bridging
    # assumes 00:11:22:33:44:55 is local MAC address.
    bridge input meta iif eth0 ip saddr 192.168.0.0/16 tcp dport 80 meta pkttype set unicast ether daddr set 00:11:22:33:44:55
.if n \{.RE
.\}

**Set IPv4 DSCP header field**. 

.if n \{.RS 4
.\}
    ip forward ip dscp set 42
.if n \{.RE
.\}


<a name="extension-header-statement"></a>

### EXTENSION HEADER STATEMENT


.if n \{.RS 4
.\}
    extension_header_expression set value
.if n \{.RE
.\}

The extension header statement alters packet content in variable-sized headers. This can currently be used to alter the TCP Maximum segment size of packets, similar to TCPMSS.

**change tcp mss**. 

.if n \{.RS 4
.\}
    tcp flags syn tcp option maxseg size set 1360
    # set a size based on route information:
    tcp flags syn tcp option maxseg size set rt mtu
.if n \{.RE
.\}


<a name="log-statement"></a>

### LOG STATEMENT


.if n \{.RS 4
.\}
    log [prefix quoted_string] [level syslog-level] [flags log-flags]
    log group nflog_group [prefix quoted_string] [queue-threshold value] [snaplen size]
    log level audit
.if n \{.RE
.\}

The log statement enables logging of matching packets. When this statement is used from a rule, the Linux kernel will print some information on all matching packets, such as header fields, via the kernel log (where it can be read with dmesg(1) or read in the syslog).

In the second form of invocation (if _nflog\_group_ is specified), the Linux kernel will pass the packet to nfnetlink_log which will multicast the packet through a netlink socket to the specified multicast group. One or more userspace processes may subscribe to the group to receive the packets, see libnetfilter_queue documentation for details.

In the third form of invocation (if level audit is specified), the Linux kernel writes a message into the audit buffer suitably formatted for reading with auditd. Therefore no further formatting options (such as prefix or flags) are allowed in this mode.

This is a non-terminating statement, so the rule evaluation continues after the packet is logged.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;56.&nbsp;log statement options**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

prefix
T}:T{

Log message prefix
T}:T{

quoted string
T}
T{

level
T}:T{

Syslog level of logging
T}:T{

string: emerg, alert, crit, err, warn [default], notice, info, debug, audit
T}
T{

group
T}:T{

NFLOG group to send messages to
T}:T{

unsigned integer (16 bit)
T}
T{

snaplen
T}:T{

Length of packet payload to include in netlink message
T}:T{

unsigned integer (32 bit)
T}
T{

queue-threshold
T}:T{

Number of packets to queue inside the kernel before sending them to userspace
T}:T{

unsigned integer (32 bit)
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;57.&nbsp;log-flags**
.TS
allbox tab(:);
ltB ltB.
T{
Flag
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

tcp sequence
T}:T{

Log TCP sequence numbers.
T}
T{

tcp options
T}:T{

Log options from the TCP packet header.
T}
T{

ip options
T}:T{

Log options from the IP/IPv6 packet header.
T}
T{

skuid
T}:T{

Log the userid of the process which generated the packet.
T}
T{

ether
T}:T{

Decode MAC addresses and protocol.
T}
T{

all
T}:T{

Enable all log flags listed above.
T}
.TE


**Using log statement**. 

.if n \{.RS 4
.\}
    # log the UID which generated the packet and ip options
    ip filter output log flags skuid flags ip options
    
    # log the tcp sequence numbers and tcp options from the TCP packet
    ip filter output log flags tcp sequence,options
    
    # enable all supported log flags
    ip6 filter output log flags all
.if n \{.RE
.\}


<a name="reject-statement"></a>

### REJECT STATEMENT


.if n \{.RS 4
.\}
    reject [ with REJECT_WITH ]
    
    REJECT_WITH := icmp type icmp_code |
                     icmpv6 type icmpv6_code |
                     icmpx type icmpx_code |
                     tcp reset
.if n \{.RE
.\}

A reject statement is used to send back an error packet in response to the matched packet otherwise it is equivalent to drop so it is a terminating statement, ending rule traversal. This statement is only valid in the input, forward and output chains, and user-defined chains which are only called from those chains.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;58.&nbsp;different ICMP reject variants are meant for use in different table families**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Variant
T}:T{
Family
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt.
T{

icmp
T}:T{

ip
T}:T{

icmp_code
T}
T{

icmpv6
T}:T{

ip6
T}:T{

icmpv6_code
T}
T{

icmpx
T}:T{

inet
T}:T{

icmpx_code
T}
.TE


For a description of the different types and a list of supported keywords refer to DATA TYPES section above. The common default reject value is **port-unreachable**.

Note that in bridge family, reject statement is only allowed in base chains which hook into input or prerouting.

<a name="counter-statement"></a>

### COUNTER STATEMENT


A counter statement sets the hit count of packets along with the number of bytes.

.if n \{.RS 4
.\}
    counter packets number bytes number
    counter { packets number | bytes number }
.if n \{.RE
.\}

<a name="conntrack-statement"></a>

### CONNTRACK STATEMENT


The conntrack statement can be used to set the conntrack mark and conntrack labels.

.if n \{.RS 4
.\}
    ct {mark | event | label | zone} set value
.if n \{.RE
.\}

The ct statement sets meta data associated with a connection. The zone id has to be assigned before a conntrack lookup takes place, i.e. this has to be done in prerouting and possibly output (if locally generated packets need to be placed in a distinct zone), with a hook priority of -300.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;59.&nbsp;Conntrack statement types**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Value
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

event
T}:T{

conntrack event bits
T}:T{

bitmask, integer (32 bit)
T}
T{

helper
T}:T{

name of ct helper object to assign to the connection
T}:T{

quoted string
T}
T{

mark
T}:T{

Connection tracking mark
T}:T{

mark
T}
T{

label
T}:T{

Connection tracking label
T}:T{

label
T}
T{

zone
T}:T{

conntrack zone
T}:T{

integer (16 bit)
T}
.TE


**save packet nfmark in conntrack**. 

.if n \{.RS 4
.\}
    ct mark set meta mark
.if n \{.RE
.\}

**set zone mapped via interface**. 

.if n \{.RS 4
.\}
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
.if n \{.RE
.\}

**restrict events reported by ctnetlink**. 

.if n \{.RS 4
.\}
    ct event set new,related,destroy
.if n \{.RE
.\}


<a name="meta-statement"></a>

### META STATEMENT


A meta statement sets the value of a meta expression. The existing meta fields are: priority, mark, pkttype, nftrace.

.if n \{.RS 4
.\}
    meta {mark | priority | pkttype | nftrace} set value
.if n \{.RE
.\}

A meta statement sets meta data associated with a packet.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;60.&nbsp;Meta statement types**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Keyword
T}:T{
Description
T}:T{
Value
T}
.T&
lt lt lt
lt lt lt
lt lt lt
lt lt lt.
T{

priority
T}:T{

TC packet priority
T}:T{

tc_handle
T}
T{

mark
T}:T{

Packet mark
T}:T{

mark
T}
T{

pkttype
T}:T{

packet type
T}:T{

pkt_type
T}
T{

nftrace
T}:T{

ruleset packet tracing on/off. Use **monitor trace** command to watch traces
T}:T{

0, 1
T}
.TE


<a name="limit-statement"></a>

### LIMIT STATEMENT


.if n \{.RS 4
.\}
    limit rate [over] packet_number / TIME_UNIT [burst packet_number packets]
    limit rate [over] byte_number BYTE_UNIT / TIME_UNIT [burst byte_number BYTE_UNIT]
    
    TIME_UNIT := second | minute | hour | day
    BYTE_UNIT := bytes | kbytes | mbytes
.if n \{.RE
.\}

A limit statement matches at a limited rate using a token bucket filter. A rule using this statement will match until this limit is reached. It can be used in combination with the log statement to give limited logging. The optional **over** keyword makes it match over the specified rate.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;61.&nbsp;limit statement values**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Value
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt.
T{

packet_number
T}:T{

Number of packets
T}:T{

unsigned integer (32 bit)
T}
T{

byte_number
T}:T{

Number of bytes
T}:T{

unsigned integer (32 bit)
T}
.TE


<a name="nat-statements"></a>

### NAT STATEMENTS


.if n \{.RS 4
.\}
    snat to address [:port] [PRF_FLAGS]
    snat to address - address [:port - port] [PRF_FLAGS]
    snat { ip | ip6 } to address - address [:port - port] [PR_FLAGS]
    dnat to address [:port] [PRF_FLAGS]
    dnat to address [:port - port] [PR_FLAGS]
    dnat { ip | ip6 } to address [:port - port] [PR_FLAGS]
    masquerade to [:port] [PRF_FLAGS]
    masquerade to [:port - port] [PRF_FLAGS]
    redirect to [:port] [PRF_FLAGS]
    redirect to [:port - port] [PRF_FLAGS]
    
    PRF_FLAGS := PRF_FLAG [, PRF_FLAGS]
    PR_FLAGS  := PR_FLAG [, PR_FLAGS]
    PRF_FLAG  := PR_FLAG | fully-random
    PR_FLAG   := persistent | random
.if n \{.RE
.\}

The nat statements are only valid from nat chain types.

The **snat** and **masquerade** statements specify that the source address of the packet should be modified. While **snat** is only valid in the postrouting and input chains, **masquerade** makes sense only in postrouting. The dnat and redirect statements are only valid in the prerouting and output chains, they specify that the destination address of the packet should be modified. You can use non-base chains which are called from base chains of nat chain type too. All future packets in this connection will also be mangled, and rules should cease being examined.

The **masquerade** statement is a special form of snat which always uses the outgoing interface’s IP address to translate to. It is particularly useful on gateways with dynamic (public) IP addresses.

The **redirect** statement is a special form of dnat which always translates the destination address to the local host’s one. It comes in handy if one only wants to alter the destination port of incoming traffic on different interfaces.

When used in the inet family (available with kernel 5.2), the dnat and snat statements require the use of the ip and ip6 keyword in case an address is provided, see the examples below.

Before kernel 4.18 nat statements require both prerouting and postrouting base chains to be present since otherwise packets on the return path won’t be seen by netfilter and therefore no reverse translation will take place.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;62.&nbsp;NAT statement values**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Expression
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt.
T{

address
T}:T{

Specifies that the source/destination address of the packet should be modified. You may specify a mapping to relate a list of tuples composed of arbitrary expression key with address value.
T}:T{

ipv4_addr, ipv6_addr, e.g. abcd::1234, or you can use a mapping, e.g. meta mark map { 10 : 192.168.1.2, 20 : 192.168.1.3 }
T}
T{

port
T}:T{

Specifies that the source/destination address of the packet should be modified.
T}:T{

port number (16 bit)
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;63.&nbsp;NAT statement flags**
.TS
allbox tab(:);
ltB ltB.
T{
Flag
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt.
T{

persistent
T}:T{

Gives a client the same source-/destination-address for each connection.
T}
T{

random
T}:T{

In kernel 5.0 and newer this is the same as fully-random. In earlier kernels the port mapping will be randomized using a seeded MD5 hash mix using source and destination address and destination port.
T}
T{

fully-random
T}:T{

If used then port mapping is generated based on a 32-bit pseudo-random algorithm.
T}
.TE


**Using NAT statements**. 

.if n \{.RS 4
.\}
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
    
    # inet family:
    # handle ip dnat:
    add rule inet nat prerouting dnat ip to 10.0.2.99
    # handle ip6 dnat:
    add rule inet nat prerouting dnat ip6 to fe80::dead
    # this masquerades both ipv4 and ipv6:
    add rule inet nat postrouting meta oif ppp0 masquerade
.if n \{.RE
.\}


<a name="tproxy-statement"></a>

### TPROXY STATEMENT


Tproxy redirects the packet to a local socket without changing the packet header in any way. If any of the arguments is missing the data of the incoming packet is used as parameter. Tproxy matching requires another rule that ensures the presence of transport protocol header is specified.

.if n \{.RS 4
.\}
    tproxy to address:port
    tproxy to {address | :port}
.if n \{.RE
.\}

This syntax can be used in **ip/ip6** tables where network layer protocol is obvious. Either IP address or port can be specified, but at least one of them is necessary.

.if n \{.RS 4
.\}
    tproxy {ip | ip6} to address[:port]
    tproxy to :port
.if n \{.RE
.\}

This syntax can be used in **inet** tables. The **ip/ip6** parameter defines the family the rule will match. The **address** parameter must be of this family. When only **port** is defined, the address family should not be specified. In this case the rule will match for both families.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;64.&nbsp;tproxy attributes**
.TS
allbox tab(:);
ltB ltB.
T{
Name
T}:T{
Description
T}
.T&
lt lt
lt lt.
T{

address
T}:T{

IP address the listening socket with IP_TRANSPARENT option is bound to.
T}
T{

port
T}:T{

Port the listening socket with IP_TRANSPARENT option is bound to.
T}
.TE


**Example ruleset for tproxy statement**. 

.if n \{.RS 4
.\}
    table ip x {
        chain y {
            type filter hook prerouting priority -150; policy accept;
            tcp dport ntp tproxy to 1.1.1.1
            udp dport ssh tproxy to :2222
        }
    }
    table ip6 x {
        chain y {
           type filter hook prerouting priority -150; policy accept;
           tcp dport ntp tproxy to [dead::beef]
           udp dport ssh tproxy to :2222
        }
    }
    table inet x {
        chain y {
            type filter hook prerouting priority -150; policy accept;
            tcp dport 321 tproxy to :ssh
            tcp dport 99 tproxy ip to 1.1.1.1:999
            udp dport 155 tproxy ip6 to [dead::beef]:smux
        }
    }
.if n \{.RE
.\}


<a name="synproxy-statement"></a>

### SYNPROXY STATEMENT


This statement will process TCP three-way-handshake parallel in netfilter context to protect either local or backend system. This statement requires connection tracking because sequence numbers need to be translated.

.if n \{.RS 4
.\}
    synproxy [mss mss_value] [wscale wscale_value] [SYNPROXY_FLAGS]
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;65.&nbsp;synproxy statement attributes**
.TS
allbox tab(:);
ltB ltB.
T{
Name
T}:T{
Description
T}
.T&
lt lt
lt lt.
T{

mss
T}:T{

Maximum segment size announced to clients. This must match the backend.
T}
T{

wscale
T}:T{

Window scale announced to clients. This must match the backend.
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;66.&nbsp;synproxy statement flags**
.TS
allbox tab(:);
ltB ltB.
T{
Flag
T}:T{
Description
T}
.T&
lt lt
lt lt.
T{

sack-perm
T}:T{

Pass client selective acknowledgement option to backend (will be disabled if not present).
T}
T{

timestamp
T}:T{

Pass client timestamp option to backend (will be disabled if not present, also needed for selective acknowledgement and window scaling).
T}
.TE


**Example ruleset for synproxy statement**. 

.if n \{.RS 4
.\}
    Determine tcp options used by backend, from an external system
    
                  tcpdump -pni eth0 -c 1 tcp[tcpflags] == (tcp-syn|tcp-ack)*(Aq
                      port 80 &
                  telnet 192.0.2.42 80
                  18:57:24.693307 IP 192.0.2.42.80 > 192.0.2.43.48757:
                      Flags [S.], seq 360414582, ack 788841994, win 14480,
                      options [mss 1460,sackOK,
                      TS val 1409056151 ecr 9690221,
                      nop,wscale 9],
                      length 0
    
    Switch tcp_loose mode off, so conntrack will mark out-of-flow packets as state INVALID.
    
                  echo 0 > /proc/sys/net/netfilter/nf_conntrack_tcp_loose
    
    Make SYN packets untracked.
    
            table ip x {
                    chain y {
                            type filter hook prerouting priority raw; policy accept;
                            tcp flags syn notrack
                    }
            }
    
    Catch UNTRACKED (SYN  packets) and INVALID (3WHS ACK packets) states and send
    them to SYNPROXY. This rule will respond to SYN packets with SYN+ACK
    syncookies, create ESTABLISHED for valid client response (3WHS ACK packets) and
    drop incorrect cookies. Flags combinations not expected during  3WHS will not
    match and continue (e.g. SYN+FIN, SYN+ACK). Finally, drop invalid packets, this
    will be out-of-flow packets that were not matched by SYNPROXY.
    
        table ip foo {
                chain z {
                        type filter hook input priority filter; policy accept;
                        ct state { invalid, untracked } synproxy mss 1460 wscale 9 timestamp sack-perm
                        ct state invalid drop
                }
        }
    
    The outcome ruleset of the steps above should be similar to the one below.
    
            table ip x {
                    chain y {
                            type filter hook prerouting priority raw; policy accept;
                            tcp flags syn notrack
                    }
    
                    chain z {
                            type filter hook input priority filter; policy accept;
                            ct state { invalid, untracked } synproxy mss 1460 wscale 9 timestamp sack-perm
                            ct state invalid drop
                    }
            }
.if n \{.RE
.\}


<a name="flow-statement"></a>

### FLOW STATEMENT


A flow statement allows us to select what flows you want to accelerate forwarding through layer 3 network stack bypass. You have to specify the flowtable name where you want to offload this flow.

**flow add @**_flowtable_

<a name="queue-statement"></a>

### QUEUE STATEMENT


This statement passes the packet to userspace using the nfnetlink_queue handler. The packet is put into the queue identified by its 16-bit queue number. Userspace can inspect and modify the packet if desired. Userspace must then drop or re-inject the packet into the kernel. See libnetfilter_queue documentation for details.

.if n \{.RS 4
.\}
    queue [num queue_number] [bypass]
    queue [num queue_number_from - queue_number_to] [QUEUE_FLAGS]
    
    QUEUE_FLAGS := QUEUE_FLAG [, QUEUE_FLAGS]
    QUEUE_FLAG  := bypass | fanout
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;67.&nbsp;queue statement values**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Value
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt
lt lt lt.
T{

queue_number
T}:T{

Sets queue number, default is 0.
T}:T{

unsigned integer (16 bit)
T}
T{

queue_number_from
T}:T{

Sets initial queue in the range, if fanout is used.
T}:T{

unsigned integer (16 bit)
T}
T{

queue_number_to
T}:T{

Sets closing queue in the range, if fanout is used.
T}:T{

unsigned integer (16 bit)
T}
.TE


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;68.&nbsp;queue statement flags**
.TS
allbox tab(:);
ltB ltB.
T{
Flag
T}:T{
Description
T}
.T&
lt lt
lt lt.
T{

bypass
T}:T{

Let packets go through if userspace application cannot back off. Before using this flag, read libnetfilter_queue documentation for performance tuning recommendations.
T}
T{

fanout
T}:T{

Distribute packets between several queues.
T}
.TE


<a name="dup-statement"></a>

### DUP STATEMENT


The dup statement is used to duplicate a packet and send the copy to a different destination.

.if n \{.RS 4
.\}
    dup to device
    dup to address device device
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;69.&nbsp;Dup statement values**
.TS
allbox tab(:);
ltB ltB ltB.
T{
Expression
T}:T{
Description
T}:T{
Type
T}
.T&
lt lt lt
lt lt lt.
T{

address
T}:T{

Specifies that the copy of the packet should be sent to a new gateway.
T}:T{

ipv4_addr, ipv6_addr, e.g. abcd::1234, or you can use a mapping, e.g. ip saddr map { 192.168.1.2 : 10.1.1.1 }
T}
T{

device
T}:T{

Specifies that the copy should be transmitted via device.
T}:T{

string
T}
.TE


**Using the dup statement**. 

.if n \{.RS 4
.\}
    # send to machine with ip address 10.2.3.4 on eth0
    ip filter forward dup to 10.2.3.4 device "eth0"
    
    # copy raw frame to another interface
    netdetv ingress dup to "eth0"
    dup to "eth0"
    
    # combine with map dst addr to gateways
    dup to ip daddr map { 192.168.7.1 : "eth0", 192.168.7.2 : "eth1" }
.if n \{.RE
.\}


<a name="fwd-statement"></a>

### FWD STATEMENT


The fwd statement is used to redirect a raw packet to another interface. It is only available in the netdev family ingress hook. It is similar to the dup statement except that no copy is made.

**fwd to** _device_

<a name="set-statement"></a>

### SET STATEMENT


The set statement is used to dynamically add or update elements in a set from the packet path. The set setname must already exist in the given table and must have been created with one or both of the dynamic and the timeout flags. The dynamic flag is required if the set statement expression includes a stateful object. The timeout flag is implied if the set is created with a timeout, and is required if the set statement updates elements, rather than adding them. Furthermore, these sets should specify both a maximum set size (to prevent memory exhaustion), and their elements should have a timeout (so their number will not grow indefinitely) either from the set definition or from the statement that adds or updates them. The set statement can be used to e.g. create dynamic blacklists.

.if n \{.RS 4
.\}
    {add | update} @setname { expression [timeout timeout] [comment string] }
.if n \{.RE
.\}

**Example for simple blacklist**. 

.if n \{.RS 4
.\}
    # declare a set, bound to table "filter", in family "ip". Timeout and size are mandatory because we will add elements from packet path.
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
.if n \{.RE
.\}


<a name="map-statement"></a>

### MAP STATEMENT


The map statement is used to lookup data based on some specific input key.

.if n \{.RS 4
.\}
    expression map { MAP_ELEMENTS }
    
    MAP_ELEMENTS := MAP_ELEMENT [, MAP_ELEMENTS]
    MAP_ELEMENT  := key : value
.if n \{.RE
.\}

The _key_ is a value returned by _expression_.

**Using the map statement**. 

.if n \{.RS 4
.\}
    # select DNAT target based on TCP dport:
    # connections to port 80 are redirected to 192.168.1.100,
    # connections to port 8888 are redirected to 192.168.1.101
    nft add rule ip nat prerouting dnat tcp dport map { 80 : 192.168.1.100, 8888 : 192.168.1.101 }
    
    # source address based SNAT:
    # packets from net 192.168.1.0/24 will appear as originating from 10.0.0.1,
    # packets from net 192.168.2.0/24 will appear as originating from 10.0.0.2
    nft add rule ip nat postrouting snat to ip saddr map { 192.168.1.0/24 : 10.0.0.1, 192.168.2.0/24 : 10.0.0.2 }
.if n \{.RE
.\}


<a name="vmap-statement"></a>

### VMAP STATEMENT


The verdict map (vmap) statement works analogous to the map statement, but contains verdicts as values.

.if n \{.RS 4
.\}
    expression vmap { VMAP_ELEMENTS }
    
    VMAP_ELEMENTS := VMAP_ELEMENT [, VMAP_ELEMENTS]
    VMAP_ELEMENT  := key : verdict
.if n \{.RE
.\}

**Using the vmap statement**. 

.if n \{.RS 4
.\}
    # jump to different chains depending on layer 4 protocol type:
    nft add rule ip filter input ip protocol vmap { tcp : jump tcp-chain, udp : jump udp-chain , icmp : jump icmp-chain }
.if n \{.RE
.\}


<a name="additional-commands"></a>

# Additional Commands


These are some additional commands included in nft.

<a name="monitor"></a>

### MONITOR


The monitor command allows you to listen to Netlink events produced by the nf_tables subsystem, related to creation and deletion of objects. When they occur, nft will print to stdout the monitored events in either JSON or native nft format.

To filter events related to a concrete object, use one of the keywords _tables_, _chains_, _sets_, _rules_, _elements_, _ruleset_.

To filter events related to a concrete action, use keyword _new_ or _destroy_.

Hit ^C to finish the monitor operation.

**Listen to all events, report in native nft format**. 

.if n \{.RS 4
.\}
    % nft monitor
.if n \{.RE
.\}

**Listen to deleted rules, report in JSON format**. 

.if n \{.RS 4
.\}
    % nft -j monitor destroy rules
.if n \{.RE
.\}

**Listen to both new and destroyed chains, in native nft format**. 

.if n \{.RS 4
.\}
    % nft monitor chains
.if n \{.RE
.\}

**Listen to ruleset events such as table, chain, rule, set, counters and quotas, in native nft format**. 

.if n \{.RS 4
.\}
    % nft monitor ruleset
.if n \{.RE
.\}


<a name="error-reporting"></a>

# Error Reporting


When an error is detected, nft shows the line(s) containing the error, the position of the erroneous parts in the input stream and marks up the erroneous parts using carets (^). If the error results from the combination of two expressions or statements, the part imposing the constraints which are violated is marked using tildes (~).

For errors returned by the kernel, nft cannot detect which parts of the input caused the error and the entire command is marked.

**Error caused by single incorrect expression**. 

.if n \{.RS 4
.\}
    <cmdline>:1:19-22: Error: Interface does not exist
    filter output oif eth0
                      ^^^^
.if n \{.RE
.\}

**Error caused by invalid combination of two expressions**. 

.if n \{.RS 4
.\}
    <cmdline>:1:28-36: Error: Right hand side of relational expression (==) must be constant
    filter output tcp dport == tcp dport
                            ~~ ^^^^^^^^^
.if n \{.RE
.\}

**Error returned by the kernel**. 

.if n \{.RS 4
.\}
    <cmdline>:0:0-23: Error: Could not process rule: Operation not permitted
    filter output oif wlan0
    ^^^^^^^^^^^^^^^^^^^^^^^
.if n \{.RE
.\}


<a name="exit-status"></a>

# Exit Status


On success, nft exits with a status of 0. Unspecified errors cause it to exit with a status of 1, memory allocation errors with a status of 2, unable to open Netlink socket with 3.

<a name="see-also"></a>

# See Also


.if n \{.RS 4
.\}
    libnftables(3), libnftables-json(5), iptables(8), ip6tables(8), arptables(8), ebtables(8), ip(8), tc(8)
.if n \{.RE
.\}

There is an official wiki at: https://wiki.nftables.org

<a name="authors"></a>

# Authors


nftables was written by Patrick McHardy and Pablo Neira Ayuso, among many other contributors from the Netfilter community.

<a name="copyright"></a>

# Copyright


Copyright © 2008-2014 Patrick McHardy &lt;kaber@trash.net&gt; Copyright © 2013-2018 Pablo Neira Ayuso &lt;pablo@netfilter.org&gt;

nftables is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License version 2 as published by the Free Software Foundation.

This documentation is licensed under the terms of the Creative Commons Attribution-ShareAlike 4.0 license, CC BY-SA 4.0 http://creativecommons.org/licenses/by-sa/4.0/.
