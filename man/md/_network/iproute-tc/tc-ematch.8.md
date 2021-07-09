# ematch(8)

iproute2, 6 August 2012


<a name="name"></a>

# Name

ematch - extended matches for use with "basic", "cgroup"  or "flow" filters

<a name="synopsis"></a>

# Synopsis

```

 "tc filter add .. basic match" EXPR .. flowid .. 

</synopsis>

<synopsis>
EXPR := TERM [ {  and | or } EXPR ]
</synopsis>

<synopsis>
TERM := [ not ] { MATCH | '(' EXPR ')' } 
</synopsis>

<synopsis>
MATCH := module '(' ARGS ')' 
</synopsis>

<synopsis>
ARGS := ARG1 ARG2..
```


<a name="matches"></a>

# Matches



<a name="cmp"></a>

### cmp

Simple comparison ematch: arithmetic compare of packet data to a given value.

_cmp_( _ALIGN_ at _OFFSET_ [ _ATTRS_ ] { _eq_ | _lt_ | _gt_ } _VALUE_)

_ALIGN_ := { _u8_ | _u16_ | _u32_ } 

_ATTRS_ := [ layer _LAYER_ ] [ mask _MASK_]_[_trans_]_

_LAYER_ := { _link_ | _network_ | _transport_ | _0..2_}


<a name="meta"></a>

### meta

Metadata ematch

_meta_( _OBJECT_ { _eq_ | _lt_ |_gt_ } _OBJECT_)

_OBJECT_ := { _META_ID_ |  _VALUE_}

_META_ID_ := _id_ [ shift _SHIFT_ ] [ mask _MASK_]


* meta attributes:  
  
  **random** 32 bit random value
  
  **loadavg\_1** Load average in last 5 minutes
  
  **nf\_mark** Netfilter mark
  
  **vlan** Vlan tag
  
  **sk\_rcvbuf** Receive buffer size
  
  **sk\_snd\_queue** Send queue length
  

A full list of meta attributes can be obtained via

# tc filter add dev eth1 basic match 'meta(list)'


<a name="nbyte"></a>

### nbyte

match packet data byte sequence

_nbyte_( _NEEDLE_ at _OFFSET_ [ layer _LAYER_]_)_

_NEEDLE_ := { _string_ | _c-escape-sequence_  } 

_OFFSET_ := _int_

_LAYER_ := { _link_ | _network_ | _transport_ | _0..2_}


<a name="u32"></a>

### u32

u32 ematch

_u32_( _ALIGN_ _VALUE_ _MASK_ at [ nexthdr+ ] _OFFSET_)

_ALIGN_ := { _u8_ | _u16_ | _u32_}


<a name="ipset"></a>

### ipset

test packet against ipset membership

_ipset_( _SETNAME_ _FLAGS_)

_SETNAME_ := _string_

_FLAGS_ := { _FLAG_ [, _FLAGS_]_}_

The flag options are the same as those used by the iptables "set" match.

When using the ipset ematch with the "ip_set_hash:net,iface" set type,
the interface can be queried using "src,dst (source ip address, outgoing interface) or
"src,src" (source ip address, incoming interface) syntax.


<a name="ipt"></a>

### ipt

test packet against xtables matches

_ipt_( _[-6]_ _-m_ _MATCH_NAME_ _FLAGS_)

_MATCH_NAME_ := _string_

_FLAGS_ := { _FLAG_ [, _FLAGS_]_}_

The flag options are the same as those used by the xtable match used.


<a name="canid"></a>

### canid

ematch rule to match CAN frames

_canid_( _IDLIST_)

_IDLIST_ :=  _IDSPEC_[_IDLIST_]

_IDSPEC_ := { ’sff’ _CANID_ | ’eff’ _CANID_}

_CANID_ := _ID_[_:MASK_]

_ID_, _MASK_:=_hexadecimal_number_(i.e._0x123)


<a name="caveats"></a>

# Caveats


The ematch syntax uses '(' and ')' to group expressions. All braces need to be
escaped properly to prevent shell commandline from interpreting these directly.

When using the ipset ematch with the "ifb" device, the outgoing device will be the
ifb device itself, e.g. "ifb0".
The original interface (i.e. the device the packet arrived on) is treated as the incoming interface.


<a name="example-usage"></a>

# Example & Usage


# tc filter add .. basic match ...

# 'cmp(u16 at 3 layer 2 mask 0xff00 gt 20)'

# 'meta(nfmark gt 24)' and 'meta(tcindex mask 0xf0 eq 0xf0)'

# 'nbyte("ababa" at 12 layer 1)'

# 'u32(u16 0x1122 0xffff at nexthdr+4)'

Check if packet source ip address is member of set named **bulk**:

# 'ipset(bulk src)'

Check if packet source ip and the interface the packet arrived on is member of "hash:net,iface" set named **interactive**:

# 'ipset(interactive src,src)'

Check if packet matches an IPSec state with reqid 1:

# 'ipt(-m policy --dir in --pol ipsec --reqid 1)'


<a name="author"></a>

# Author


The extended match infrastructure was added by Thomas Graf.
