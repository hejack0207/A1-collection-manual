# libnftables\-json(5)

\ \&, 07/28/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

libnftables-json - Supported JSON schema by libnftables

<a name="synopsis"></a>

# Synopsis

```

 { "nftables": [ OBJECTS ] } 
 OBJECTS := LIST_OBJECTS | CMD_OBJECTS 
 LIST_OBJECTS := LIST_OBJECT [ , LIST_OBJECTS ] 
 CMD_OBJECTS := CMD_OBJECT [ , CMD_OBJECTS ] 
 CMD_OBJECT := { CMD: LIST_OBJECT } | METAINFO_OBJECT 
 CMD := "add" | "replace" | "create" | "insert" | "delete" | "list" | "reset" | "flush" | "rename" 
 LIST_OBJECT := TABLE | CHAIN | RULE | SET | MAP | ELEMENT | FLOWTABLE | COUNTER | QUOTA | CT_HELPER | LIMIT | METAINFO_OBJECT | CT_TIMEOUT | CT_EXPECTATION
```

<a name="description"></a>

# Description


libnftables supports JSON formatted input and output. This is implemented as an alternative frontend to the standard CLI syntax parser, therefore basic behaviour is identical and, for (almost) any operation available in standard syntax, there should be an equivalent one in JSON.

JSON input may be provided in a single string as parameter to **nft\_run\_cmd\_from\_buffer()** or in a file identified by the _filename_ parameter of the **nft\_run\_cmd\_from\_filename()** function.

JSON output has to be enabled via the **nft\_ctx\_output\_set\_json()** function, turning library standard output into JSON format. Error output remains unaffected.

<a name="global-structure"></a>

# Global Structure


In general, any JSON input or output is enclosed in an object with a single property named _nftables_. Its value is an array containing commands (for input) or ruleset elements (for output).

A command is an object with a single property whose name identifies the command. Its value is a ruleset element - basically identical to output elements, apart from certain properties which may be interpreted differently or are required when output generally omits them.

<a name="metainfo-object"></a>

# Metainfo Object


In output, the first object in an **nftables** array is a special one containing library information. Its content is as follows:

.if n \{.RS 4
.\}
    { "metainfo": {
            "version": STRING,
            "release_name": STRING,
            "json_schema_version": NUMBER
    }}
.if n \{.RE
.\}

The values of **version** and **release\_name** properties are equal to the package version and release name as printed by **nft -v**. The value of the **json\_schema\_version** property is an integer indicating the schema version.

If supplied in library input, the parser will verify the **json\_schema\_version** value to not exceed the internally hardcoded one (to make sure the given schema is fully understood). In future, a lower number than the internal one may activate compatibility mode to parse outdated and incompatible JSON input.

<a name="command-objects"></a>

# Command Objects


The structure accepts an arbitrary amount of commands which are interpreted in order of appearance. For instance, the following standard syntax input:

.if n \{.RS 4
.\}
    flush ruleset
    add table inet mytable
    add chain inet mytable mychain
    add rule inet mytable mychain tcp dport 22 accept
.if n \{.RE
.\}

translates into JSON as such:

.if n \{.RS 4
.\}
    { "nftables": [
            { "flush": { "ruleset": null }},
            { "add": { "table": {
                            "family": "inet",
                            "name": "mytable"
            }}},
            { "add": { "chain": {
                            "family": "inet",
                            "table": "mytable",
                            "chain": "mychain"
            }}}
            { "add": { "rule": {
                            "family": "inet",
                            "table": "mytable",
                            "chain": "mychain",
                            "expr": [
                                    { "match": {
                                            "left": { "payload": {
                                                            "protocol": "tcp",
                                                            "field": "dport"
                                            }},
                                            "right": 22
                                    }},
                                    { "accept": null }
                            ]
            }}}
    ]}
.if n \{.RE
.\}

<a name="add"></a>

### ADD


.if n \{.RS 4
.\}
    { "add": ADD_OBJECT }
    
    ADD_OBJECT := TABLE | CHAIN | RULE | SET | MAP | ELEMENT |
                    FLOWTABLE | COUNTER | QUOTA | CT_HELPER | LIMIT |
                    CT_TIMEOUT | CT_EXPECTATION
.if n \{.RE
.\}

Add a new ruleset element to the kernel.

<a name="replace"></a>

### REPLACE


.if n \{.RS 4
.\}
    { "replace": RULE }
.if n \{.RE
.\}

Replace a rule. In _RULE_, the **handle** property is mandatory and identifies the rule to be replaced.

<a name="create"></a>

### CREATE


.if n \{.RS 4
.\}
    { "create": ADD_OBJECT }
.if n \{.RE
.\}

Identical to **add** command, but returns an error if the object already exists.

<a name="insert"></a>

### INSERT


.if n \{.RS 4
.\}
    { "insert": RULE }
.if n \{.RE
.\}

This command is identical to **add** for rules, but instead of appending the rule to the chain by default, it inserts at first position. If a **handle** or **index** property is given, the rule is inserted before the rule identified by those properties.

<a name="delete"></a>

### DELETE


.if n \{.RS 4
.\}
    { "delete": ADD_OBJECT }
.if n \{.RE
.\}

Delete an object from the ruleset. Only the minimal number of properties required to uniquely identify an object is generally needed in _ADD\_OBJECT_. For most ruleset elements, this is **family** and **table** plus either **handle** or **name** (except rules since they don’t have a name).

<a name="list"></a>

### LIST


.if n \{.RS 4
.\}
    { "list": LIST_OBJECT }
    
    LIST_OBJECT := TABLE | TABLES | CHAIN | CHAINS | SET | SETS |
                     MAP | MAPS | COUNTER | COUNTERS | QUOTA | QUOTAS |
                     CT_HELPER | CT_HELPERS | LIMIT | LIMITS | RULESET |
                     METER | METERS | FLOWTABLE | FLOWTABLES |
                     CT_TIMEOUT | CT_EXPECTATION
.if n \{.RE
.\}

List ruleset elements. The plural forms are used to list all objects of that kind, optionally filtered by **family** and for some, also **table**.

<a name="reset"></a>

### RESET


.if n \{.RS 4
.\}
    { "reset": RESET_OBJECT }
    
    RESET_OBJECT := COUNTER | COUNTERS | QUOTA | QUOTAS
.if n \{.RE
.\}

Reset state in suitable objects, i.e. zero their internal counter.

<a name="flush"></a>

### FLUSH


.if n \{.RS 4
.\}
    { "flush": FLUSH_OBJECT }
    
    FLUSH_OBJECT := TABLE | CHAIN | SET | MAP | METER | RULESET
.if n \{.RE
.\}

Empty contents in given object, e.g. remove all chains from given **table** or remove all elements from given **set**.

<a name="rename"></a>

### RENAME


.if n \{.RS 4
.\}
    { "rename": CHAIN }
.if n \{.RE
.\}

Rename a chain. The new name is expected in a dedicated property named **newname**.

<a name="ruleset-elements"></a>

# Ruleset Elements


<a name="table"></a>

### TABLE


.if n \{.RS 4
.\}
    { "table": {
            "family": STRING,
            "name": STRING,
            "handle": NUMBER
    }}
.if n \{.RE
.\}

This object describes a table.

**family**
The table’s family, e.g.
**"ip"**
or
**"ip6"**.

**name**
The table’s name.

**handle**
The table’s handle. In input, it is used only in
**delete**
command as alternative to
**name**.

<a name="chain"></a>

### CHAIN


.if n \{.RS 4
.\}
    { "chain": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "newname": STRING,
            "handle": NUMBER,
            "type": STRING,
            "hook": STRING,
            "prio": NUMBER,
            "dev": STRING,
            "policy": STRING
    }}
.if n \{.RE
.\}

This object describes a chain.

**family**
The table’s family.

**table**
The table’s name.

**name**
The chain’s name.

**handle**
The chain’s handle. In input, it is used only in
**delete**
command as alternative to
**name**.

**newname**
A new name for the chain, only relevant in the
**rename**
command.

The following properties are required for base chains:

**type**
The chain’s type.

**hook**
The chain’s hook.

**prio**
The chain’s priority.

**dev**
The chain’s bound interface (if in the netdev family).

**policy**
The chain’s policy.

<a name="rule"></a>

### RULE


.if n \{.RS 4
.\}
    { "rule": {
            "family": STRING,
            "table": STRING,
            "chain": STRING,
            "expr": [ STATEMENTS ],
            "handle": NUMBER,
            "index": NUMBER,
            "comment": STRING
    }}
    
    STATEMENTS := STATEMENT [, STATEMENTS ]
.if n \{.RE
.\}

This object describes a rule. Basic building blocks of rules are statements. Each rule consists of at least one.

**family**
The table’s family.

**table**
The table’s name.

**chain**
The chain’s name.

**expr**
An array of statements this rule consists of. In input, it is used in
**add**/**insert**/**replace**
commands only.

**handle**
The rule’s handle. In
**delete**/**replace**
commands, it serves as an identifier of the rule to delete/replace. In
**add**/**insert**
commands, it serves as an identifier of an existing rule to append/prepend the rule to.

**index**
The rule’s position for
**add**/**insert**
commands. It is used as an alternative to
**handle**
then.

**comment**
Optional rule comment.

<a name="set-map"></a>

### SET / MAP


.if n \{.RS 4
.\}
    { "set": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": NUMBER,
            "type": SET_TYPE,
            "policy": SET_POLICY,
            "flags": [ SET_FLAG_LIST ],
            "elem": SET_ELEMENTS,
            "timeout": NUMBER,
            "gc-interval": NUMBER,
            "size": NUMBER
    }}
    
    { "map": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": NUMBER,
            "type": SET_TYPE,
            "map": STRING,
            "policy": SET_POLICY,
            "flags": [ SET_FLAG_LIST ],
            "elem": SET_ELEMENTS,
            "timeout": NUMBER,
            "gc-interval": NUMBER,
            "size": NUMBER
    }}
    
    SET_TYPE := STRING | [ SET_TYPE_LIST ]
    SET_TYPE_LIST := STRING [, SET_TYPE_LIST ]
    SET_POLICY := "performance" | "memory"
    SET_FLAG_LIST := SET_FLAG [, SET_FLAG_LIST ]
    SET_FLAG := "constant" | "interval" | "timeout"
    SET_ELEMENTS := EXPRESSION | [ EXPRESSION_LIST ]
    EXPRESSION_LIST := EXPRESSION [, EXPRESSION_LIST ]
.if n \{.RE
.\}

These objects describe a named set or map. Maps are a special form of sets in that they translate a unique key to a value.

**family**
The table’s family.

**table**
The table’s name.

**name**
The set’s name.

**handle**
The set’s handle. For input, it is used in the
**delete**
command only.

**type**
The set’s datatype, see below.

**map**
Type of values this set maps to (i.e. this set is a map).

**policy**
The set’s policy.

**flags**
The set’s flags.

**elem**
Initial set element(s), see below.

**timeout**
Element timeout in seconds.

**gc-interval**
Garbage collector interval in seconds.

**size**
Maximum number of elements supported.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**TYPE**

The set type might be a string, such as **"ipv4\_addr"** or an array consisting of strings (for concatenated types).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**ELEM**

A single set element might be given as string, integer or boolean value for simple cases. If additional properties are required, a formal **elem** object may be used.

Multiple elements may be given in an array.

<a name="element"></a>

### ELEMENT


.if n \{.RS 4
.\}
    { "element": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "elem": SET_ELEM
    }}
    
    SET_ELEM := EXPRESSION | [ EXPRESSION_LIST ]
    EXPRESSION_LIST := EXPRESSION [, EXPRESSION ]
.if n \{.RE
.\}

Manipulate element(s) in a named set.

**family**
The table’s family.

**table**
The table’s name.

**name**
The set’s name.

**elem**
See elem property of set object.

<a name="flowtable"></a>

### FLOWTABLE


.if n \{.RS 4
.\}
    { "flowtable": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": NUMBER,
            "hook": STRING,
            "prio": NUMBER,
            "dev": FT_INTERFACE
    }}
    
    FT_INTERFACE := STRING | [ FT_INTERFACE_LIST ]
    FT_INTERFACE_LIST := STRING [, STRING ]
.if n \{.RE
.\}

This object represents a named flowtable.

**family**
The table’s family.

**table**
The table’s name.

**name**
The flow table’s name.

**handle**
The flow table’s handle. In input, it is used by the
**delete**
command only.

**hook**
The flow table’s hook.

**prio**
The flow table’s priority.

**dev**
The flow table’s interface(s).

<a name="counter"></a>

### COUNTER


.if n \{.RS 4
.\}
    { "counter": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": NUMBER,
            "packets": NUMBER,
            "bytes": NUMBER
    }}
.if n \{.RE
.\}

This object represents a named counter.

**family**
The table’s family.

**table**
The table’s name.

**name**
The counter’s name.

**handle**
The counter’s handle. In input, it is used by the
**delete**
command only.

**packets**
Packet counter value.

**bytes**
Byte counter value.

<a name="quota"></a>

### QUOTA


.if n \{.RS 4
.\}
    { "quota": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": NUMBER,
            "bytes": NUMBER,
            "used": NUMBER,
            "inv": BOOLEAN
    }}
.if n \{.RE
.\}

This object represents a named quota.

**family**
The table’s family.

**table**
The table’s name.

**name**
The quota’s name.

**handle**
The quota’s handle. In input, it is used by the
**delete**
command only.

**bytes**
Quota threshold.

**used**
Quota used so far.

**inv**
If true, match if the quota has been exceeded.

<a name="ct-helper"></a>

### CT HELPER


.if n \{.RS 4
.\}
    { "ct helper": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": ... ,
            "type": STRING,
            "protocol": CTH_PROTO,
            "l3proto": STRING
    }}
    
    CTH_PROTO := "tcp" | "udp"
.if n \{.RE
.\}

This object represents a named conntrack helper.

**family**
The table’s family.

**table**
The table’s name.

**name**
The ct helper’s name.

**handle**
The ct helper’s handle. In input, it is used by the
**delete**
command only.

**type**
The ct helper type name, e.g.
**"ftp"**
or
**"tftp"**.

**protocol**
The ct helper’s layer 4 protocol.

**l3proto**
The ct helper’s layer 3 protocol, e.g.
**"ip"**
or
**"ip6"**.

<a name="limit"></a>

### LIMIT


.if n \{.RS 4
.\}
    { "limit": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": NUMBER,
            "rate": NUMBER,
            "per": STRING,
            "burst": NUMBER,
            "unit": LIMIT_UNIT,
            "inv": BOOLEAN
    }}
    
    LIMIT_UNIT := "packets" | "bytes"
.if n \{.RE
.\}

This object represents a named limit.

**family**
The table’s family.

**table**
The table’s name.

**name**
The limit’s name.

**handle**
The limit’s handle. In input, it is used by the
**delete**
command only.

**rate**
The limit’s rate value.

**per**
Time unit to apply the limit to, e.g.
**"week"**,
**"day"**,
**"hour"**, etc. If omitted, defaults to
**"second"**.

**burst**
The limit’s burst value. If omitted, defaults to
**0**.

**unit**
Unit of rate and burst values. If omitted, defaults to
**"packets"**.

**inv**
If true, match if limit was exceeded. If omitted, defaults to
**false**.

<a name="ct-timeout"></a>

### CT TIMEOUT


.if n \{.RS 4
.\}
    { "ct timeout": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": NUMBER,
            "protocol": CTH_PROTO,
            "state": STRING,
            "value: NUMBER,
            "l3proto": STRING
    }}
    
    CTH_PROTO := "tcp" | "udp" | "dccp" | "sctp" | "gre" | "icmpv6" | "icmp" | "generic"
.if n \{.RE
.\}

This object represents a named conntrack timeout policy.

**family**
The table’s family.

**table**
The table’s name.

**name**
The ct timeout object’s name.

**handle**
The ct timeout object’s handle. In input, it is used by
**delete**
command only.

**protocol**
The ct timeout object’s layer 4 protocol.

**state**
The connection state name, e.g.
**"established"**,
**"syn\_sent"**,
**"close"**
or
**"close\_wait"**, for which the timeout value has to be updated.

**value**
The updated timeout value for the specified connection state.

**l3proto**
The ct timeout object’s layer 3 protocol, e.g.
**"ip"**
or
**"ip6"**.

<a name="ct-expectation"></a>

### CT EXPECTATION


.if n \{.RS 4
.\}
    { "ct expectation": {
            "family": STRING,
            "table": STRING,
            "name": STRING,
            "handle": NUMBER,
            "l3proto": STRING
            "protocol":* CTH_PROTO,
            "dport": NUMBER,
            "timeout: NUMBER,
            "size: NUMBER,
    *}}
    
    CTH_PROTO := "tcp" | "udp" | "dccp" | "sctp" | "gre" | "icmpv6" | "icmp" | "generic"
.if n \{.RE
.\}

This object represents a named conntrack expectation.

**family**
The table’s family.

**table**
The table’s name.

**name**
The ct expectation object’s name.

**handle**
The ct expectation object’s handle. In input, it is used by
**delete**
command only.

**l3proto**
The ct expectation object’s layer 3 protocol, e.g.
**"ip"**
or
**"ip6"**.

**protocol**
The ct expectation object’s layer 4 protocol.

**dport**
The destination port of the expected connection.

**timeout**
The time in millisecond that this expectation will live.

**size**
The maximum count of expectations to be living in the same time.

<a name="statements"></a>

# Statements


Statements are the building blocks for rules. Each rule consists of at least one.

<a name="verdict"></a>

### VERDICT


.if n \{.RS 4
.\}
    { "accept": null }
    { "drop": null }
    { "continue": null }
    { "return": null }
    { "jump": { "target": * STRING *}}
    { "goto": { "target": * STRING *}}
.if n \{.RE
.\}

A verdict either terminates packet traversal through the current chain or delegates to a different one.

**jump** and **goto** statements expect a target chain name.

<a name="match"></a>

### MATCH


.if n \{.RS 4
.\}
    { "match": {
            "left": EXPRESSION,
            "right": EXPRESSION,
            "op": STRING
    }}
.if n \{.RE
.\}

This matches the expression on left hand side (typically a packet header or packet meta info) with the expression on right hand side (typically a constant value). If the statement evaluates to true, the next statement in this rule is considered. If not, processing continues with the next rule in the same chain.

**left**
Left hand side of this match.

**right**
Right hand side of this match.

**op**
Operator indicating the type of comparison.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**OPERATORS**
.TS
tab(:);
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

**&**
T}:T{

Binary AND
T}
T{

**|**
T}:T{

Binary OR
T}
T{

**^**
T}:T{

Binary XOR
T}
T{

**&lt;&lt;**
T}:T{

Left shift
T}
T{

**&gt;&gt;**
T}:T{

Right shift
T}
T{

**==**
T}:T{

Equal
T}
T{

**!=**
T}:T{

Not equal
T}
T{

**&lt;**
T}:T{

Less than
T}
T{

**&gt;**
T}:T{

Greater than
T}
T{

**⇐**
T}:T{

Less than or equal to
T}
T{

**&gt;=**
T}:T{

Greater than or equal to
T}
T{

**in**
T}:T{

Perform a lookup, i.e. test if bits on RHS are contained in LHS value
T}
.TE


Unlike with the standard API, the operator is mandatory here. In the standard API, a missing operator may be resolved in two ways, depending on the type of expression on the RHS:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If the RHS is a bitmask or a list of bitmasks, the expression resolves into a binary operation with the inequality operator, like this:
  _LHS & RHS != 0_.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  In any other case, the equality operator is simply inserted.

For the non-trivial first case, the JSON API supports the **in** operator.

<a name="counter"></a>

### COUNTER


.if n \{.RS 4
.\}
    { "counter": {
            "packets": NUMBER,
            "bytes": NUMBER
    }}
    
    { "counter": STRING }
.if n \{.RE
.\}

This object represents a byte/packet counter. In input, no properties are required. If given, they act as initial values for the counter.

The first form creates an anonymous counter which lives in the rule it appears in. The second form specifies a reference to a named counter object.

**packets**
Packets counted.

**bytes**
Bytes counted.

<a name="mangle"></a>

### MANGLE


.if n \{.RS 4
.\}
    { "mangle": {
            "key": EXPRESSION,
            "value": EXPRESSION
    }}
.if n \{.RE
.\}

This changes the packet data or meta info.

**key**
The packet data to be changed, given as an
**exthdr**,
**payload**,
**meta**,
**ct**
or
**ct helper**
expression.

**value**
Value to change data to.

<a name="quota"></a>

### QUOTA


.if n \{.RS 4
.\}
    { "quota": {
            "val": NUMBER,
            "val_unit": STRING,
            "used": NUMBER,
            "used_unit": STRING,
            "inv": BOOLEAN
    }}
    
    { "quota": STRING }
.if n \{.RE
.\}

The first form creates an anonymous quota which lives in the rule it appears in. The second form specifies a reference to a named quota object.

**val**
Quota value.

**val\_unit**
Unit of
**val**, e.g.
**"kbytes"**
or
**"mbytes"**. If omitted, defaults to
**"bytes"**.

**used**
Quota used so far. Optional on input. If given, serves as initial value.

**used\_unit**
Unit of
**used**. Defaults to
**"bytes"**.

**inv**
If
**true**, will match if quota was exceeded. Defaults to
**false**.

<a name="limit"></a>

### LIMIT


.if n \{.RS 4
.\}
    { "limit": {
            "rate": NUMBER,
            "rate_unit": STRING,
            "per": STRING,
            "burst": NUMBER,
            "burst_unit": STRING,
            "inv": BOOLEAN
    }}
    
    { "limit": STRING }
.if n \{.RE
.\}

The first form creates an anonymous limit which lives in the rule it appears in. The second form specifies a reference to a named limit object.

**rate**
Rate value to limit to.

**rate\_unit**
Unit of
**rate**, e.g.
**"packets"**
or
**"mbytes"**. Defaults to
**"packets"**.

**per**
Denominator of
**rate**, e.g.
**"week"**
or
**"minutes"**.

**burst**
Burst value. Defaults to
**0**.

**burst\_unit**
Unit of
**burst**, ignored if
**rate\_unit**
is
**"packets"**. Defaults to
**"bytes"**.

**inv**
If
**true**, matches if the limit was exceeded. Defaults to
**false**.

<a name="fwd"></a>

### FWD


.if n \{.RS 4
.\}
    { "fwd": {
            "dev": EXPRESSION,
            "family": FWD_FAMILY,
            "addr": EXPRESSION
    }}
    
    FWD_FAMILY := "ip" | "ip6"
.if n \{.RE
.\}

Forward a packet to a different destination.

**dev**
Interface to forward the packet on.

**family**
Family of
**addr**.

**addr**
IP(v6) address to forward the packet to.

Both **family** and **addr** are optional, but if at least one is given, both must be present.

<a name="notrack"></a>

### NOTRACK


.if n \{.RS 4
.\}
    { "notrack": null }
.if n \{.RE
.\}

Disable connection tracking for the packet.

<a name="dup"></a>

### DUP


.if n \{.RS 4
.\}
    { "dup": {
            "addr": EXPRESSION,
            "dev": EXPRESSION
    }}
.if n \{.RE
.\}

Duplicate a packet to a different destination.

**addr**
Address to duplicate packet to.

**dev**
Interface to duplicate packet on. May be omitted to not specify an interface explicitly.

<a name="network-address-translation"></a>

### NETWORK ADDRESS TRANSLATION


.if n \{.RS 4
.\}
    { "snat": {
            "addr": EXPRESSION,
            "family": STRING,
            "port": EXPRESSION,
            "flags": FLAGS
    }}
    
    { "dnat": {
            "addr": EXPRESSION,
            "family": STRING,
            "port": EXPRESSION,
            "flags": FLAGS
    }}
    
    { "masquerade": {
            "port": EXPRESSION,
            "flags": FLAGS
    }}
    
    { "redirect": {
            "port": EXPRESSION,
            "flags": FLAGS
    }}
    
    FLAGS := FLAG | [ FLAG_LIST ]
    FLAG_LIST := FLAG [, FLAG_LIST ]
    FLAG := "random" | "fully-random" | "persistent"
.if n \{.RE
.\}

Perform Network Address Translation.

**addr**
Address to translate to.

**family**
Family of
**addr**, either
**ip**
or
**ip6**. Required in
**inet**
table family.

**port**
Port to translate to.

**flags**
Flag(s).

All properties are optional and default to none.

<a name="reject"></a>

### REJECT


.if n \{.RS 4
.\}
    { "reject": {
            "type": STRING,
            "expr": EXPRESSION
    }}
.if n \{.RE
.\}

Reject the packet and send the given error reply.

**type**
Type of reject, either
**"tcp reset"**,
**"icmpx"**,
**"icmp"**
or
**"icmpv6"**.

**expr**
ICMP type to reject with.

All properties are optional.

<a name="set"></a>

### SET


.if n \{.RS 4
.\}
    { "set": {
            "op": STRING,
            "elem": EXPRESSION,
            "set": STRING
    }}
.if n \{.RE
.\}

Dynamically add/update elements to a set.

**op**
Operator on set, either
**"add"**
or
**"update"**.

**elem**
Set element to add or update.

**set**
Set reference.

<a name="log"></a>

### LOG


.if n \{.RS 4
.\}
    { "log": {
            "prefix": STRING,
            "group": NUMBER,
            "snaplen": NUMBER,
            "queue-threshold": NUMBER,
            "level": LEVEL,
            "flags": FLAGS
    }}
    
    LEVEL := "emerg" | "alert" | "crit" | "err" | "warn" | "notice" |
               "info" | "debug" | "audit"
    
    FLAGS := FLAG | [ FLAG_LIST ]
    FLAG_LIST := FLAG [, FLAG_LIST ]
    FLAG := "tcp sequence" | "tcp options" | "ip options" | "skuid" |
              "ether" | "all"
.if n \{.RE
.\}

Log the packet.

**prefix**
Prefix for log entries.

**group**
Log group.

**snaplen**
Snaplen for logging.

**queue-threshold**
Queue threshold.

**level**
Log level. Defaults to
**"warn"**.

**flags**
Log flags.

All properties are optional.

<a name="ct-helper"></a>

### CT HELPER


.if n \{.RS 4
.\}
    { "ct helper": EXPRESSION }
.if n \{.RE
.\}

Enable the specified conntrack helper for this packet.

**ct helper**
CT helper reference.

<a name="meter"></a>

### METER


.if n \{.RS 4
.\}
    { "meter": {
            "name": STRING,
            "key": EXPRESSION,
            "stmt": STATEMENT
    }}
.if n \{.RE
.\}

Apply a given statement using a meter.

**name**
Meter name.

**key**
Meter key.

**stmt**
Meter statement.

<a name="queue"></a>

### QUEUE


.if n \{.RS 4
.\}
    { "queue": {
            "num": EXPRESSION,
            "flags": FLAGS
    }}
    
    FLAGS := FLAG | [ FLAG_LIST ]
    FLAG_LIST := FLAG [, FLAG_LIST ]
    FLAG := "bypass" | "fanout"
.if n \{.RE
.\}

Queue the packet to userspace.

**num**
Queue number.

**flags**
Queue flags.

<a name="verdict-map"></a>

### VERDICT MAP


.if n \{.RS 4
.\}
    { "vmap": {
            "key": EXPRESSION,
            "data": EXPRESSION
    }}
.if n \{.RE
.\}

Apply a verdict conditionally.

**key**
Map key.

**data**
Mapping expression consisting of value/verdict pairs.

<a name="ct-count"></a>

### CT COUNT


.if n \{.RS 4
.\}
    { "ct count": {
            "val": NUMBER,
            "inv": BOOLEAN
    }}
.if n \{.RE
.\}

Limit the number of connections using conntrack.

**val**
Connection count threshold.

**inv**
If
**true**, match if
**val**
was exceeded. If omitted, defaults to
**false**.

<a name="ct-timeout"></a>

### CT TIMEOUT


.if n \{.RS 4
.\}
    { "ct timeout": EXPRESSION }
.if n \{.RE
.\}

Assign connection tracking timeout policy.

**ct timeout**
CT timeout reference.

<a name="ct-expectation"></a>

### CT EXPECTATION


.if n \{.RS 4
.\}
    { "ct expectation": EXPRESSION }
.if n \{.RE
.\}

Assign connection tracking expectation.

**ct expectation**
CT expectation reference.

<a name="xt"></a>

### XT


.if n \{.RS 4
.\}
    { "xt": null }
.if n \{.RE
.\}

This represents an xt statement from xtables compat interface. Sadly, at this point, it is not possible to provide any further information about its content.

<a name="expressions"></a>

# Expressions


Expressions are the building blocks of (most) statements. In their most basic form, they are just immediate values represented as a JSON string, integer or boolean type.

<a name="immediates"></a>

### IMMEDIATES


.if n \{.RS 4
.\}
    STRING
    NUMBER
    BOOLEAN
.if n \{.RE
.\}

Immediate expressions are typically used for constant values. For strings, there are two special cases:

**@STRING**
The remaining part is taken as set name to create a set reference.

**\e***
Construct a wildcard expression.

<a name="lists"></a>

### LISTS


.if n \{.RS 4
.\}
    ARRAY
.if n \{.RE
.\}

List expressions are constructed by plain arrays containing of an arbitrary number of expressions.

<a name="concat"></a>

### CONCAT


.if n \{.RS 4
.\}
    { "concat": CONCAT }
    
    CONCAT := [ EXPRESSION_LIST ]
    EXPRESSION_LIST := EXPRESSION [, EXPRESSION_LIST ]
.if n \{.RE
.\}

Concatenate several expressions.

<a name="set"></a>

### SET


.if n \{.RS 4
.\}
    { "set": SET }
    
    SET := EXPRESSION | [ EXPRESSION_LIST ]
.if n \{.RE
.\}

This object constructs an anonymous set. For mappings, an array of arrays with exactly two elements is expected.

<a name="map"></a>

### MAP


.if n \{.RS 4
.\}
    { "map": {
            "key": EXPRESSION,
            "data": EXPRESSION
    }}
.if n \{.RE
.\}

Map a key to a value.

**key**
Map key.

**data**
Mapping expression consisting of value/target pairs.

<a name="prefix"></a>

### PREFIX


.if n \{.RS 4
.\}
    { "prefix": {
            "addr": EXPRESSION,
            "len": NUMBER
    }}
.if n \{.RE
.\}

Construct an IPv4 or IPv6 prefix consisting of address part in **addr** and prefix length in **len**.

<a name="range"></a>

### RANGE


.if n \{.RS 4
.\}
    { "range": [ EXPRESSION , EXPRESSION ] }
.if n \{.RE
.\}

Construct a range of values. The first array item denotes the lower boundary, the second one the upper boundary.

<a name="payload"></a>

### PAYLOAD


.if n \{.RS 4
.\}
    { "payload": {
            "base": BASE,
            "offset": NUMBER,
            "len": NUMBER
    }}
    
    { "payload": {
            "protocol": STRING,
            "field": STRING
    }}
    
    BASE := "ll" | "nh" | "th"
.if n \{.RE
.\}

Construct a payload expression, i.e. a reference to a certain part of packet data. The first form creates a raw payload expression to point at a random number (**len**) of bytes at a certain offset (**offset**) from a given reference point (**base**). The following **base** values are accepted:

**"ll"**
The offset is relative to Link Layer header start offset.

**"nh"**
The offset is relative to Network Layer header start offset.

**"th"**
The offset is relative to Transport Layer header start offset.

The second form allows to reference a field by name (**field**) in a named packet header (**protocol**).

<a name="exthdr"></a>

### EXTHDR


.if n \{.RS 4
.\}
    { "exthdr": {
            "name": STRING,
            "field": STRING,
            "offset": NUMBER
    }}
.if n \{.RE
.\}

Create a reference to a field (**field**) in an IPv6 extension header (**name**). **offset** is used only for **rt0** protocol.

If the **field** property is not given, the expression is to be used as a header existence check in a **match** statement with a boolean on the right hand side.

<a name="tcp-option"></a>

### TCP OPTION


.if n \{.RS 4
.\}
    { "tcp option": {
            "name": STRING,
            "field": STRING
    }}
.if n \{.RE
.\}

Create a reference to a field (**field**) of a TCP option header (**name**).

If the **field** property is not given, the expression is to be used as a TCP option existence check in a **match** statement with a boolean on the right hand side.

<a name="meta"></a>

### META


.if n \{.RS 4
.\}
    { "meta": {
            "key": META_KEY
    }}
    
    META_KEY := "length" | "protocol" | "priority" | "random" | "mark" |
                  "iif" | "iifname" | "iiftype" | "oif" | "oifname" |
                  "oiftype" | "skuid" | "skgid" | "nftrace" |
                  "rtclassid" | "ibriport" | "obriport" | "ibridgename" |
                  "obridgename" | "pkttype" | "cpu" | "iifgroup" |
                  "oifgroup" | "cgroup" | "nfproto" | "l4proto" |
                  "secpath"
.if n \{.RE
.\}

Create a reference to packet meta data.

<a name="rt"></a>

### RT


.if n \{.RS 4
.\}
    { "rt": {
            "key": RT_KEY,
            "family": RT_FAMILY
    }}
    
    RT_KEY := "classid" | "nexthop" | "mtu"
    RT_FAMILY := "ip" | "ip6"
.if n \{.RE
.\}

Create a reference to packet routing data.

The **family** property is optional and defaults to unspecified.

<a name="ct"></a>

### CT


.if n \{.RS 4
.\}
    { "ct": {
            "key": STRING,
            "family": CT_FAMILY,
            "dir": CT_DIRECTION
    }}
    
    CT_FAMILY := "ip" | "ip6"
    CT_DIRECTION := "original" | "reply"
.if n \{.RE
.\}

Create a reference to packet conntrack data.

Some CT keys do not support a direction. In this case, **dir** must not be given.

<a name="numgen"></a>

### NUMGEN


.if n \{.RS 4
.\}
    { "numgen": {
            "mode": NG_MODE,
            "mod": NUMBER,
            "offset": NUMBER
    }}
    
    NG_MODE := "inc" | "random"
.if n \{.RE
.\}

Create a number generator.

The **offset** property is optional and defaults to 0.

<a name="hash"></a>

### HASH


.if n \{.RS 4
.\}
    { "jhash": {
            "mod": NUMBER,
            "offset": NUMBER,
            "expr": EXPRESSION,
            "seed": NUMBER
    }}
    
    { "symhash": {
            "mod": NUMBER,
            "offset": NUMBER
    }}
.if n \{.RE
.\}

Hash packet data.

The **offset** and **seed** properties are optional and default to 0.

<a name="fib"></a>

### FIB


.if n \{.RS 4
.\}
    { "fib": {
            "result": FIB_RESULT,
            "flags": FIB_FLAGS
    }}
    
    FIB_RESULT := "oif" | "oifname" | "type"
    
    FIB_FLAGS := FIB_FLAG | [ FIB_FLAG_LIST ]
    FIB_FLAG_LIST := FIB_FLAG [, FIB_FLAG_LIST ]
    FIB_FLAG := "saddr" | "daddr" | "mark" | "iif" | "oif"
.if n \{.RE
.\}

Perform kernel Forwarding Information Base lookups.

<a name="binary-operation"></a>

### BINARY OPERATION


.if n \{.RS 4
.\}
    { "|": [ EXPRESSION, EXPRESSION ] }
    { "^": [ EXPRESSION, EXPRESSION ] }
    { "&": [ EXPRESSION, EXPRESSION ] }
    { "<<": [ EXPRESSION, EXPRESSION ] }
    { ">>": [ EXPRESSION, EXPRESSION ] }
.if n \{.RE
.\}

All binary operations expect an array of exactly two expressions, of which the first element denotes the left hand side and the second one the right hand side.

<a name="verdict"></a>

### VERDICT


.if n \{.RS 4
.\}
    { "accept": null }
    { "drop": null }
    { "continue": null }
    { "return": null }
    { "jump": { "target": STRING }}
    { "goto": { "target": STRING }}
.if n \{.RE
.\}

Same as the **verdict** statement, but for use in verdict maps.

**jump** and **goto** verdicts expect a target chain name.

<a name="elem"></a>

### ELEM


.if n \{.RS 4
.\}
    { "elem": {
            "val": EXPRESSION,
            "timeout": NUMBER,
            "expires": NUMBER,
            "comment": STRING
    }}
.if n \{.RE
.\}

Explicitly set element object, in case **timeout**, **expires** or **comment** are desired. Otherwise, it may be replaced by the value of **val**.

<a name="socket"></a>

### SOCKET


.if n \{.RS 4
.\}
    { "socket": {
            "key": SOCKET_KEY
    }}
    
    SOCKET_KEY := "transparent"
.if n \{.RE
.\}

Construct a reference to packet’s socket.

<a name="osf"></a>

### OSF


.if n \{.RS 4
.\}
    { "osf": {
            "key": OSF_KEY,
            "ttl": OSF_TTL
    }}
    
    OSF_KEY := "name"
    OSF_TTL := "loose" | "skip"
.if n \{.RE
.\}

Perform OS fingerprinting. This expression is typically used in the LHS of a **match** statement.

**key**
Which part of the fingerprint info to match against. At this point, only the OS name is supported.

**ttl**
Define how the packet’s TTL value is to be matched. This property is optional. If omitted, the TTL value has to match exactly. A value of
**loose**
accepts TTL values less than the fingerprint one. A value of
**skip**
omits TTL value comparison entirely.

<a name="author"></a>

# Author


**Phil Sutter** &lt;[phil@nwl.cc](mailto:phil@nwl.cc)&gt;
Author.
