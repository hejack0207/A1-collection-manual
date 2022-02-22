# bpftool-cgroup(8) - tool for inspection and simple manipulation of eBPF progs

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
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] cgroup COMMAND 
 OPTIONS := { { -j | --json } [{ -p | --pretty }] | { -f | --bpffs } } 
 COMMANDS := { show | list | tree | attach | detach | help } .UNINDENT .UNINDENT
```

<a name="cgroup-commands"></a>

# Cgroup Commands

    bpftool cgroup { show | list } CGROUP [effective]
    bpftool cgroup tree [CGROUP_ROOT] [effective]
    bpftool cgroup attach CGROUP ATTACH_TYPE PROG [ATTACH_FLAGS]
    bpftool cgroup detach CGROUP ATTACH_TYPE PROG
    bpftool cgroup help
    
    PROG := { id PROG_ID | pinned FILE | tag PROG_TAG }
    ATTACH_TYPE := { ingress | egress | sock_create | sock_ops | device |
    .in +2
    bind4 | bind6 | post_bind4 | post_bind6 | connect4 | connect6 |
    getpeername4 | getpeername6 | getsockname4 | getsockname6 | sendmsg4 |
    sendmsg6 | recvmsg4 | recvmsg6 | sysctl | getsockopt | setsockopt |
    sock_release }
    .in -2
    ATTACH_FLAGS := { multi | override }


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool cgroup { show | list }** _CGROUP_ [**effective**]</b>  
  List all programs attached to the cgroup _CGROUP_.

Output will start with program ID followed by attach type,
attach flags and program name.

If **effective** is specified retrieve effective programs that
will execute for events within a cgroup. This includes
inherited along with attached ones.

* <b>**bpftool cgroup tree** [_CGROUP\_ROOT_] [**effective**]</b>  
  Iterate over all cgroups in _CGROUP\_ROOT_ and list all
  attached programs. If _CGROUP\_ROOT_ is not specified,
  bpftool uses cgroup v2 mountpoint.

The output is similar to the output of cgroup show/list
commands: it starts with absolute cgroup path, followed by
program ID, attach type, attach flags and program name.

If **effective** is specified retrieve effective programs that
will execute for events within a cgroup. This includes
inherited along with attached ones.

* <b>**bpftool cgroup attach** _CGROUP_ _ATTACH\_TYPE_ _PROG_ [_ATTACH\_FLAGS_]</b>  
  Attach program _PROG_ to the cgroup _CGROUP_ with attach type
  _ATTACH\_TYPE_ and optional _ATTACH\_FLAGS_.

_ATTACH\_FLAGS_ can be one of: **override** if a sub-cgroup installs
some bpf program, the program in this cgroup yields to sub-cgroup
program; **multi** if a sub-cgroup installs some bpf program,
that cgroup program gets run in addition to the program in this
cgroup.

Only one program is allowed to be attached to a cgroup with
no attach flags or the **override** flag. Attaching another
program will release old program and attach the new one.

Multiple programs are allowed to be attached to a cgroup with
**multi**. They are executed in FIFO order (those that were
attached first, run first).

Non-default _ATTACH\_FLAGS_ are supported by kernel version 4.14
and later.

_ATTACH\_TYPE_ can be on of:
**ingress** ingress path of the inet socket (since 4.10);
**egress** egress path of the inet socket (since 4.10);
**sock\_create** opening of an inet socket (since 4.10);
**sock\_ops** various socket operations (since 4.12);
**device** device access (since 4.15);
**bind4** call to bind(2) for an inet4 socket (since 4.17);
**bind6** call to bind(2) for an inet6 socket (since 4.17);
**post\_bind4** return from bind(2) for an inet4 socket (since 4.17);
**post\_bind6** return from bind(2) for an inet6 socket (since 4.17);
**connect4** call to connect(2) for an inet4 socket (since 4.17);
**connect6** call to connect(2) for an inet6 socket (since 4.17);
**sendmsg4** call to sendto(2), sendmsg(2), sendmmsg(2) for an
unconnected udp4 socket (since 4.18);
**sendmsg6** call to sendto(2), sendmsg(2), sendmmsg(2) for an
unconnected udp6 socket (since 4.18);
**recvmsg4** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
an unconnected udp4 socket (since 5.2);
**recvmsg6** call to recvfrom(2), recvmsg(2), recvmmsg(2) for
an unconnected udp6 socket (since 5.2);
**sysctl** sysctl access (since 5.2);
**getsockopt** call to getsockopt (since 5.3);
**setsockopt** call to setsockopt (since 5.3);
**getpeername4** call to getpeername(2) for an inet4 socket (since 5.8);
**getpeername6** call to getpeername(2) for an inet6 socket (since 5.8);
**getsockname4** call to getsockname(2) for an inet4 socket (since 5.8);
**getsockname6** call to getsockname(2) for an inet6 socket (since 5.8).
**sock\_release** closing an userspace inet socket (since 5.9).

* <b>**bpftool cgroup detach** _CGROUP_ _ATTACH\_TYPE_ _PROG_</b>  
  Detach _PROG_ from the cgroup _CGROUP_ and attach type
  _ATTACH\_TYPE_.
* <b>**bpftool prog help**</b>  
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
* **-f, --bpffs**  
  Show file names of pinned programs.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="examples"></a>

# Examples

    
    # mount -t bpf none /sys/fs/bpf/
    # mkdir /sys/fs/cgroup/test.slice
    # bpftool prog load ./device_cgroup.o /sys/fs/bpf/prog
    # bpftool cgroup attach /sys/fs/cgroup/test.slice/ device id 1 allow_multi


**# bpftool cgroup list /sys/fs/cgroup/test.slice/**
.INDENT 0.0
.INDENT 3.5

    .ft C
    ID       AttachType      AttachFlags     Name
    1        device          allow_multi     bpf_prog1
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool cgroup detach /sys/fs/cgroup/test.slice/ device id 1
    # bpftool cgroup list /sys/fs/cgroup/test.slice/

.INDENT 0.0
.INDENT 3.5

    .ft C
    ID       AttachType      AttachFlags     Name
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
**bpftool-feature**(8),
**bpftool-gen**(8),
**bpftool-iter**(8),
**bpftool-link**(8),
**bpftool-map**(8),
**bpftool-net**(8),
**bpftool-perf**(8),
**bpftool-prog**(8),
**bpftool-struct\_ops**(8)
.UNINDENT
.UNINDENT

