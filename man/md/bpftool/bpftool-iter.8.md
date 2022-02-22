# bpftool-iter(8) - tool to create BPF iterators

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
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] iter COMMAND 
 COMMANDS := { pin | help } .UNINDENT .UNINDENT
```

<a name="iter-commands"></a>

# Iter Commands

    bpftool iter pin OBJ PATH [map MAP]
    bpftool iter help
    
    OBJ := /a/file/of/bpf_iter_target.o
    MAP := { id MAP_ID | pinned FILE }


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool iter pin** _OBJ_ _PATH_ [**map** _MAP_]</b>  
  A bpf iterator combines a kernel iterating of
  particular kernel data (e.g., tasks, bpf_maps, etc.)
  and a bpf program called for each kernel data object
  (e.g., one task, one bpf_map, etc.). User space can
  _read_ kernel iterator output through _read()_ syscall.

The _pin_ command creates a bpf iterator from _OBJ_,
and pin it to _PATH_. The _PATH_ should be located
in _bpffs_ mount. It must not contain a dot
character ('.'), which is reserved for future extensions
of _bpffs_.

Map element bpf iterator requires an additional parameter
_MAP_ so bpf program can iterate over map elements for
that map. User can have a bpf program in kernel to run
with each map element, do checking, filtering, aggregation,
etc. without copying data to user space.

User can then _cat PATH_ to see the bpf iterator output.

* <b>**bpftool iter help**</b>  
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


**# bpftool iter pin bpf_iter_netlink.o /sys/fs/bpf/my\_netlink**
.INDENT 0.0
.INDENT 3.5

    .ft C
    Create a file-based bpf iterator from bpf_iter_netlink.o and pin it
    to /sys/fs/bpf/my_netlink
    .ft P
.UNINDENT
.UNINDENT

**# bpftool iter pin bpf_iter_hashmap.o /sys/fs/bpf/my_hashmap map id 20**
.INDENT 0.0
.INDENT 3.5

    .ft C
    Create a file-based bpf iterator from bpf_iter_hashmap.o and map with
    id 20, and pin it to /sys/fs/bpf/my_hashmap
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
**bpftool-link**(8),
**bpftool-map**(8),
**bpftool-net**(8),
**bpftool-perf**(8),
**bpftool-prog**(8),
**bpftool-struct\_ops**(8)
.UNINDENT
.UNINDENT

