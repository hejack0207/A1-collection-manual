# bpftool-prog(8) - tool for inspection and simple manipulation of eBPF progs

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
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] prog COMMAND 
 OPTIONS := { { -j | --json } [{ -p | --pretty }] | { -f | --bpffs } } 
 COMMANDS := { show | list | dump xlated | dump jited | pin | load | loadall | help } .UNINDENT .UNINDENT
```

<a name="prog-commands"></a>

# Prog Commands

    bpftool prog { show | list } [PROG]
    bpftool prog dump xlated PROG [{file FILE | opcodes | visual | linum}]
    bpftool prog dump jited  PROG [{file FILE | opcodes | linum}]
    bpftool prog pin PROG FILE
    bpftool prog { load | loadall } OBJ PATH [type TYPE] [map {idx IDX | name NAME} MAP] [dev NAME] [pinmaps MAP_DIR]
    bpftool prog attach PROG ATTACH_TYPE [MAP]
    bpftool prog detach PROG ATTACH_TYPE [MAP]
    bpftool prog tracelog
    bpftool prog run PROG data_in FILE [data_out FILE [data_size_out L]] [ctx_in FILE [ctx_out FILE [ctx_size_out M]]] [repeat N]
    bpftool prog profile PROG [duration DURATION] METRICs
    bpftool prog help
    
    MAP := { id MAP_ID | pinned FILE }
    PROG := { id PROG_ID | pinned FILE | tag PROG_TAG | name PROG_NAME }
    TYPE := {
    .in +2
    socket | kprobe | kretprobe | classifier | action |
    tracepoint | raw_tracepoint | xdp | perf_event | cgroup/skb |
    cgroup/sock | cgroup/dev | lwt_in | lwt_out | lwt_xmit |
    lwt_seg6local | sockops | sk_skb | sk_msg | lirc_mode2 |
    cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 | cgroup/post_bind6 |
    cgroup/connect4 | cgroup/connect6 | cgroup/getpeername4 | cgroup/getpeername6 |
    cgroup/getsockname4 | cgroup/getsockname6 | cgroup/sendmsg4 | cgroup/sendmsg6 |
    cgroup/recvmsg4 | cgroup/recvmsg6 | cgroup/sysctl |
    cgroup/getsockopt | cgroup/setsockopt | cgroup/sock_release |
    struct_ops | fentry | fexit | freplace | sk_lookup
    .in -2
    }
    ATTACH_TYPE := {
    .in +2
    msg_verdict | stream_verdict | stream_parser | flow_dissector
    .in -2
    }
    METRICs := {
    .in +2
    cycles | instructions | l1d_loads | llc_misses
    .in -2
    }


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool prog { show | list }** [_PROG_]</b>  
  Show information about loaded programs.  If _PROG_ is
  specified show information only about given programs,
  otherwise list all programs currently loaded on the system.
  In case of **tag** or **name**, _PROG_ may match several
  programs which will all be shown.

Output will start with program ID followed by program type and
zero or more named attributes (depending on kernel version).

Since Linux 5.1 the kernel can collect statistics on BPF
programs (such as the total time spent running the program,
and the number of times it was run). If available, bpftool
shows such statistics. However, the kernel does not collect
them by defaults, as it slightly impacts performance on each
program run. Activation or deactivation of the feature is
performed via the **kernel.bpf\_stats\_enabled** sysctl knob.

Since Linux 5.8 bpftool is able to discover information about
processes that hold open file descriptors (FDs) against BPF
programs. On such kernels bpftool will automatically emit this
information as well.

* <b>**bpftool prog dump xlated** _PROG_ [{ **file** _FILE_ | **opcodes** | **visual** | **linum** }]</b>  
  Dump eBPF instructions of the programs from the kernel. By
  default, eBPF will be disassembled and printed to standard
  output in human-readable format. In this case, **opcodes**
  controls if raw opcodes should be printed as well.

In case of **tag** or **name**, _PROG_ may match several
programs which will all be dumped.  However, if **file** or
**visual** is specified, _PROG_ must match a single program.

If **file** is specified, the binary image will instead be
written to _FILE_.

If **visual** is specified, control flow graph (CFG) will be
built instead, and eBPF instructions will be presented with
CFG in DOT format, on standard output.

If the programs have line_info available, the source line will
be displayed by default.  If **linum** is specified,
the filename, line number and line column will also be
displayed on top of the source line.

* <b>**bpftool prog dump jited** _PROG_ [{ **file** _FILE_ | **opcodes** | **linum** }]</b>  
  Dump jited image (host machine code) of the program.

If _FILE_ is specified image will be written to a file,
otherwise it will be disassembled and printed to stdout.
_PROG_ must match a single program when **file** is specified.

**opcodes** controls if raw opcodes will be printed.

If the prog has line_info available, the source line will
be displayed by default.  If **linum** is specified,
the filename, line number and line column will also be
displayed on top of the source line.

* <b>**bpftool prog pin** _PROG_ _FILE_</b>  
  Pin program _PROG_ as _FILE_.

Note: _FILE_ must be located in _bpffs_ mount. It must not
contain a dot character ('.'), which is reserved for future
extensions of _bpffs_.

* <b>**bpftool prog { load | loadall }** _OBJ_ _PATH_ [**type** _TYPE_] [**map** {**idx** _IDX_ | **name** _NAME_} _MAP_] [**dev** _NAME_] [**pinmaps** _MAP\_DIR_]</b>  
  Load bpf program(s) from binary _OBJ_ and pin as _PATH_.
  **bpftool prog load** pins only the first program from the
  _OBJ_ as _PATH_. **bpftool prog loadall** pins all programs
  from the _OBJ_ under _PATH_ directory.
  **type** is optional, if not specified program type will be
  inferred from section names.
  By default bpftool will create new maps as declared in the ELF
  object being loaded.  **map** parameter allows for the reuse
  of existing maps.  It can be specified multiple times, each
  time for a different map.  _IDX_ refers to index of the map
  to be replaced in the ELF file counting from 0, while _NAME_
  allows to replace a map by name.  _MAP_ specifies the map to
  use, referring to it by **id** or through a **pinned** file.
  If **dev** _NAME_ is specified program will be loaded onto
  given networking device (offload).
  Optional **pinmaps** argument can be provided to pin all
  maps under _MAP\_DIR_ directory.

Note: _PATH_ must be located in _bpffs_ mount. It must not
contain a dot character ('.'), which is reserved for future
extensions of _bpffs_.

* <b>**bpftool prog attach** _PROG_ _ATTACH\_TYPE_ [_MAP_]</b>  
  Attach bpf program _PROG_ (with type specified by
  _ATTACH\_TYPE_). Most _ATTACH\_TYPEs_ require a _MAP_
  parameter, with the exception of _flow\_dissector_ which is
  attached to current networking name space.
* <b>**bpftool prog detach** _PROG_ _ATTACH\_TYPE_ [_MAP_]</b>  
  Detach bpf program _PROG_ (with type specified by
  _ATTACH\_TYPE_). Most _ATTACH\_TYPEs_ require a _MAP_
  parameter, with the exception of _flow\_dissector_ which is
  detached from the current networking name space.
* <b>**bpftool prog tracelog**</b>  
  Dump the trace pipe of the system to the console (stdout).
  Hit &lt;Ctrl+C&gt; to stop printing. BPF programs can write to this
  trace pipe at runtime with the **bpf\_trace\_printk**() helper.
  This should be used only for debugging purposes. For
  streaming data from BPF programs to user space, one can use
  perf events (see also **bpftool-map**(8)).
* <b>**bpftool prog run** _PROG_ **data\_in** _FILE_ [**data\_out** _FILE_ [**data\_size\_out** _L_]] [**ctx\_in** _FILE_ [**ctx\_out** _FILE_ [**ctx\_size\_out** _M_]]] [**repeat** _N_]</b>  
  Run BPF program _PROG_ in the kernel testing infrastructure
  for BPF, meaning that the program works on the data and
  context provided by the user, and not on actual packets or
  monitored functions etc. Return value and duration for the
  test run are printed out to the console.

Input data is read from the _FILE_ passed with **data\_in**.
If this _FILE_ is "**-**", input data is read from standard
input. Input context, if any, is read from _FILE_ passed with
**ctx\_in**. Again, "**-**" can be used to read from standard
input, but only if standard input is not already in use for
input data. If a _FILE_ is passed with **data\_out**, output
data is written to that file. Similarly, output context is
written to the _FILE_ passed with **ctx\_out**. For both
output flows, "**-**" can be used to print to the standard
output (as plain text, or JSON if relevant option was
passed). If output keywords are omitted, output data and
context are discarded. Keywords **data\_size\_out** and
**ctx\_size\_out** are used to pass the size (in bytes) for the
output buffers to the kernel, although the default of 32 kB
should be more than enough for most cases.

Keyword **repeat** is used to indicate the number of
consecutive runs to perform. Note that output data and
context printed to files correspond to the last of those
runs. The duration printed out at the end of the runs is an
average over all runs performed by the command.

Not all program types support test run. Among those which do,
not all of them can take the **ctx\_in**/**ctx\_out**
arguments. bpftool does not perform checks on program types.

* <b>**bpftool prog profile** _PROG_ [**duration** _DURATION_] _METRICs_</b>  
  Profile _METRICs_ for bpf program _PROG_ for _DURATION_
  seconds or until user hits &lt;Ctrl+C&gt;. _DURATION_ is optional.
  If _DURATION_ is not specified, the profiling will run up to
  **UINT\_MAX** seconds.
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
  When showing BPF programs, show file names of pinned
  programs.
* **-m, --mapcompat**  
  Allow loading maps with unknown map definitions.
* **-n, --nomount**  
  Do not automatically attempt to mount any virtual file system
  (such as tracefs or BPF virtual file system) when necessary.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="examples"></a>

# Examples


**# bpftool prog show**
.INDENT 0.0
.INDENT 3.5

    .ft C
    10: xdp  name some_prog  tag 005a3d2123620c8b  gpl run_time_ns 81632 run_cnt 10
            loaded_at 2017-09-29T20:11:00+0000  uid 0
            xlated 528B  jited 370B  memlock 4096B  map_ids 10
            pids systemd(1)
    .ft P
.UNINDENT
.UNINDENT

**# bpftool --json --pretty prog show**
.INDENT 0.0
.INDENT 3.5

    .ft C
    [{
            "id": 10,
            "type": "xdp",
            "tag": "005a3d2123620c8b",
            "gpl_compatible": true,
            "run_time_ns": 81632,
            "run_cnt": 10,
            "loaded_at": 1506715860,
            "uid": 0,
            "bytes_xlated": 528,
            "jited": true,
            "bytes_jited": 370,
            "bytes_memlock": 4096,
            "map_ids": [10
            ],
            "pids": [{
                    "pid": 1,
                    "comm": "systemd"
                }
            ]
        }
    ]
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool prog dump xlated id 10 file /tmp/t
    $ ls -l /tmp/t

.INDENT 0.0
.INDENT 3.5

    .ft C
    -rw------- 1 root root 560 Jul 22 01:42 /tmp/t
    .ft P
.UNINDENT
.UNINDENT

**# bpftool prog dump jited tag 005a3d2123620c8b**
.INDENT 0.0
.INDENT 3.5

    .ft C
    0:   push   %rbp
    1:   mov    %rsp,%rbp
    2:   sub    $0x228,%rsp
    3:   sub    $0x28,%rbp
    4:   mov    %rbx,0x0(%rbp)
    .ft P
.UNINDENT
.UNINDENT
    
    # mount -t bpf none /sys/fs/bpf/
    # bpftool prog pin id 10 /sys/fs/bpf/prog
    # bpftool prog load ./my_prog.o /sys/fs/bpf/prog2
    # ls -l /sys/fs/bpf/

.INDENT 0.0
.INDENT 3.5

    .ft C
    -rw------- 1 root root 0 Jul 22 01:43 prog
    -rw------- 1 root root 0 Jul 22 01:44 prog2
    .ft P
.UNINDENT
.UNINDENT

**# bpftool prog dump jited pinned /sys/fs/bpf/prog opcodes**
.INDENT 0.0
.INDENT 3.5

    .ft C
    0:   push   %rbp
         55
    1:   mov    %rsp,%rbp
         48 89 e5
    4:   sub    $0x228,%rsp
         48 81 ec 28 02 00 00
    b:   sub    $0x28,%rbp
         48 83 ed 28
    f:   mov    %rbx,0x0(%rbp)
         48 89 5d 00
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool prog load xdp1_kern.o /sys/fs/bpf/xdp1 type xdp map name rxcnt id 7
    # bpftool prog show pinned /sys/fs/bpf/xdp1

.INDENT 0.0
.INDENT 3.5

    .ft C
    9: xdp  name xdp_prog1  tag 539ec6ce11b52f98  gpl
            loaded_at 2018-06-25T16:17:31-0700  uid 0
            xlated 488B  jited 336B  memlock 4096B  map_ids 7
    .ft P
.UNINDENT
.UNINDENT

**# rm /sys/fs/bpf/xdp1**
    
    # bpftool prog profile id 337 duration 10 cycles instructions llc_misses

.INDENT 0.0
.INDENT 3.5

    .ft C
       51397 run_cnt
    40176203 cycles                                                 (83.05%)
    42518139 instructions    #   1.06 insns per cycle               (83.39%)
         123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
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
**bpftool-net**(8),
**bpftool-perf**(8),
**bpftool-struct\_ops**(8)
.UNINDENT
.UNINDENT

