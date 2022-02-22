# bpftool-net(8) - tool for inspection of netdev/tc related bpf prog attachments

"", ""

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

```
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] net COMMAND 
 OPTIONS := { [{ -j | --json }] [{ -p | --pretty }] } 
 COMMANDS := { show | list | attach | detach | help } .UNINDENT .UNINDENT
```

<a name="net-commands"></a>

# Net Commands

    bpftool net { show | list } [ dev NAME ]
    bpftool net attach ATTACH_TYPE PROG dev NAME [ overwrite ]
    bpftool net detach ATTACH_TYPE dev NAME
    bpftool net help
    
    PROG := { id PROG_ID | pinned FILE | tag PROG_TAG }
    ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool net { show | list }** [ **dev** _NAME_ ]</b>  
  List bpf program attachments in the kernel networking subsystem.

Currently, only device driver xdp attachments and tc filter
classification/action attachments are implemented, i.e., for
program types **BPF\_PROG\_TYPE\_SCHED\_CLS**,
**BPF\_PROG\_TYPE\_SCHED\_ACT** and **BPF\_PROG\_TYPE\_XDP**.
For programs attached to a particular cgroup, e.g.,
**BPF\_PROG\_TYPE\_CGROUP\_SKB**, **BPF\_PROG\_TYPE\_CGROUP\_SOCK**,
**BPF\_PROG\_TYPE\_SOCK\_OPS** and **BPF\_PROG\_TYPE\_CGROUP\_SOCK\_ADDR**,
users can use **bpftool cgroup** to dump cgroup attachments.
For sk_{filter, skb, msg, reuseport} and lwt/seg6
bpf programs, users should consult other tools, e.g., iproute2.

The current output will start with all xdp program attachments, followed by
all tc class/qdisc bpf program attachments. Both xdp programs and
tc programs are ordered based on ifindex number. If multiple bpf
programs attached to the same networking device through **tc filter**,
the order will be first all bpf programs attached to tc classes, then
all bpf programs attached to non clsact qdiscs, and finally all
bpf programs attached to root and clsact qdisc.

* <b>**bpftool** **net attach** _ATTACH\_TYPE_ _PROG_ **dev** _NAME_ [ **overwrite** ]</b>  
  Attach bpf program _PROG_ to network interface _NAME_ with
  type specified by _ATTACH\_TYPE_. Previously attached bpf program
  can be replaced by the command used with **overwrite** option.
  Currently, only XDP-related modes are supported for _ATTACH\_TYPE_.

_ATTACH\_TYPE_ can be of:
**xdp** - try native XDP and fallback to generic XDP if NIC driver does not support it;
**xdpgeneric** - Generic XDP. runs at generic XDP hook when packet already enters receive path as skb;
**xdpdrv** - Native XDP. runs earliest point in driver's receive path;
**xdpoffload** - Offload XDP. runs directly on NIC on each packet reception;

* <b>**bpftool** **net detach** _ATTACH\_TYPE_ **dev** _NAME_</b>  
  Detach bpf program attached to network interface _NAME_ with
  type specified by _ATTACH\_TYPE_. To detach bpf program, same
  _ATTACH\_TYPE_ previously used for attach must be specified.
  Currently, only XDP-related modes are supported for _ATTACH\_TYPE_.
* <b>**bpftool net help**</b>  
  Print short help message.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* **-h, --help**  
  Print short help message (similar to **bpftool help**).
* **-V, --version**  
  Print version number (similar to **bpftool version**), and optional
  features that were included when bpftool was compiled. Optional
  features include linking against libbfd to provide the disassembler
  for JIT-ted programs (**bpftool prog dump jited**) and usage of BPF
  skeletons (some features like **bpftool prog profile** or showing
  pids associated to BPF objects may rely on it).
* **-j, --json**  
  Generate JSON output. For commands that cannot produce JSON, this
  option has no effect.
* **-p, --pretty**  
  Generate human-readable JSON output. Implies **-j**.
* **-d, --debug**  
  Print all logs available, even debug-level information. This includes
  logs from libbpf as well as from the verifier, when attempting to
  load programs.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="examples"></a>

# Examples

    # bpftool net

.INDENT 0.0
.INDENT 3.5

    .ft C
    xdp:
    eth0(2) driver id 198
    
    tc:
    eth0(2) htb name prefix_matcher.o:[cls_prefix_matcher_htb] id 111727 act []
    eth0(2) clsact/ingress fbflow_icmp id 130246 act []
    eth0(2) clsact/egress prefix_matcher.o:[cls_prefix_matcher_clsact] id 111726
    eth0(2) clsact/egress cls_fg_dscp id 108619 act []
    eth0(2) clsact/egress fbflow_egress id 130245
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool -jp net

.INDENT 0.0
.INDENT 3.5

    .ft C
    [{
            "xdp": [{
                    "devname": "eth0",
                    "ifindex": 2,
                    "mode": "driver",
                    "id": 198
                }
            ],
            "tc": [{
                    "devname": "eth0",
                    "ifindex": 2,
                    "kind": "htb",
                    "name": "prefix_matcher.o:[cls_prefix_matcher_htb]",
                    "id": 111727,
                    "act": []
                },{
                    "devname": "eth0",
                    "ifindex": 2,
                    "kind": "clsact/ingress",
                    "name": "fbflow_icmp",
                    "id": 130246,
                    "act": []
                },{
                    "devname": "eth0",
                    "ifindex": 2,
                    "kind": "clsact/egress",
                    "name": "prefix_matcher.o:[cls_prefix_matcher_clsact]",
                    "id": 111726,
                },{
                    "devname": "eth0",
                    "ifindex": 2,
                    "kind": "clsact/egress",
                    "name": "cls_fg_dscp",
                    "id": 108619,
                    "act": []
                },{
                    "devname": "eth0",
                    "ifindex": 2,
                    "kind": "clsact/egress",
                    "name": "fbflow_egress",
                    "id": 130245,
                }
            ]
        }
    ]
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool net attach xdpdrv id 16 dev enp6s0np0
    # bpftool net

.INDENT 0.0
.INDENT 3.5

    .ft C
    xdp:
    enp6s0np0(4) driver id 16
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool net attach xdpdrv id 16 dev enp6s0np0
    # bpftool net attach xdpdrv id 20 dev enp6s0np0 overwrite
    # bpftool net

.INDENT 0.0
.INDENT 3.5

    .ft C
    xdp:
    enp6s0np0(4) driver id 20
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool net attach xdpdrv id 16 dev enp6s0np0
    # bpftool net detach xdpdrv dev enp6s0np0
    # bpftool net

.INDENT 0.0
.INDENT 3.5

    .ft C
    xdp:
    .ft P
.UNINDENT
.UNINDENT

<a name="see-also"></a>

# See Also

.INDENT 0.0
.INDENT 3.5
**bpf**(2),
**bpf-helpers**(7),
**bpftool**(8),
**bpftool-btf**(8),
**bpftool-cgroup**(8),
**bpftool-feature**(8),
**bpftool-gen**(8),
**bpftool-iter**(8),
**bpftool-link**(8),
**bpftool-map**(8),
**bpftool-perf**(8),
**bpftool-prog**(8),
**bpftool-struct\_ops**(8)
.UNINDENT
.UNINDENT

