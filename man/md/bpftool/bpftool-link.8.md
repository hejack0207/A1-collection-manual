# bpftool-link(8) - tool for inspection and simple manipulation of eBPF links

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
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] link COMMAND 
 OPTIONS := { { -j | --json } [{ -p | --pretty }] | { -f | --bpffs } } 
 COMMANDS := { show | list | pin | help } .UNINDENT .UNINDENT
```

<a name="link-commands"></a>

# Link Commands

    bpftool link { show | list } [LINK]
    bpftool link pin LINK FILE
    bpftool link detach LINK
    bpftool link help
    
    LINK := { id LINK_ID | pinned FILE }


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool link { show | list }** [_LINK_]</b>  
  Show information about active links. If _LINK_ is
  specified show information only about given link,
  otherwise list all links currently active on the system.

Output will start with link ID followed by link type and
zero or more named attributes, some of which depend on type
of link.

Since Linux 5.8 bpftool is able to discover information about
processes that hold open file descriptors (FDs) against BPF
links. On such kernels bpftool will automatically emit this
information as well.

* <b>**bpftool link pin** _LINK_ _FILE_</b>  
  Pin link _LINK_ as _FILE_.

Note: _FILE_ must be located in _bpffs_ mount. It must not
contain a dot character ('.'), which is reserved for future
extensions of _bpffs_.

* <b>**bpftool link detach** _LINK_</b>  
  Force-detach link _LINK_. BPF link and its underlying BPF
  program will stay valid, but they will be detached from the
  respective BPF hook and BPF link will transition into
  a defunct state until last open file descriptor for that
  link is closed.
* <b>**bpftool link help**</b>  
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
  When showing BPF links, show file names of pinned
  links.
* **-n, --nomount**  
  Do not automatically attempt to mount any virtual file system
  (such as tracefs or BPF virtual file system) when necessary.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="examples"></a>

# Examples


**# bpftool link show**
.INDENT 0.0
.INDENT 3.5

    .ft C
    10: cgroup  prog 25
            cgroup_id 614  attach_type egress
            pids test_progs(223)
    .ft P
.UNINDENT
.UNINDENT

**# bpftool --json --pretty link show**
.INDENT 0.0
.INDENT 3.5

    .ft C
    [{
            "type": "cgroup",
            "prog_id": 25,
            "cgroup_id": 614,
            "attach_type": "egress",
            "pids": [{
                    "pid": 223,
                    "comm": "test_progs"
                }
            ]
        }
    ]
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool link pin id 10 /sys/fs/bpf/link
    # ls -l /sys/fs/bpf/

.INDENT 0.0
.INDENT 3.5

    .ft C
    -rw------- 1 root root 0 Apr 23 21:39 link
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
**bpftool-map**(8),
**bpftool-net**(8),
**bpftool-perf**(8),
**bpftool-prog**(8),
**bpftool-struct\_ops**(8)
.UNINDENT
.UNINDENT

