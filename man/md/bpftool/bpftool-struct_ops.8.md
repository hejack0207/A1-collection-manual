# bpftool-struct_ops(8) - tool to register/unregister/introspect BPF struct_ops

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
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] struct_ops COMMAND 
 OPTIONS := { { -j | --json } [{ -p | --pretty }] } 
 COMMANDS := { show | list | dump | register | unregister | help } .UNINDENT .UNINDENT
```

<a name="struct_ops-commands"></a>

# Struct_ops Commands

    bpftool struct_ops { show | list } [STRUCT_OPS_MAP]
    bpftool struct_ops dump [STRUCT_OPS_MAP]
    bpftool struct_ops register OBJ
    bpftool struct_ops unregister STRUCT_OPS_MAP
    bpftool struct_ops help
    
    STRUCT_OPS_MAP := { id STRUCT_OPS_MAP_ID | name STRUCT_OPS_MAP_NAME }
    OBJ := /a/file/of/bpf_struct_ops.o


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool struct_ops { show | list }** [_STRUCT\_OPS\_MAP_]</b>  
  Show brief information about the struct_ops in the system.
  If _STRUCT\_OPS\_MAP_ is specified, it shows information only
  for the given struct_ops.  Otherwise, it lists all struct_ops
  currently existing in the system.

Output will start with struct_ops map ID, followed by its map
name and its struct_ops's kernel type.

* <b>**bpftool struct_ops dump** [_STRUCT\_OPS\_MAP_]</b>  
  Dump details information about the struct_ops in the system.
  If _STRUCT\_OPS\_MAP_ is specified, it dumps information only
  for the given struct_ops.  Otherwise, it dumps all struct_ops
  currently existing in the system.
* <b>**bpftool struct_ops register** _OBJ_</b>  
  Register bpf struct_ops from _OBJ_.  All struct_ops under
  the ELF section ".struct_ops" will be registered to
  its kernel subsystem.
* <b>**bpftool struct_ops unregister** _STRUCT\_OPS\_MAP_</b>  
  Unregister the _STRUCT\_OPS\_MAP_ from the kernel subsystem.
* <b>**bpftool struct_ops help**</b>  
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


**# bpftool struct_ops show**
.INDENT 0.0
.INDENT 3.5

    .ft C
    100: dctcp           tcp_congestion_ops
    105: cubic           tcp_congestion_ops
    .ft P
.UNINDENT
.UNINDENT

**# bpftool struct_ops unregister id 105**
.INDENT 0.0
.INDENT 3.5

    .ft C
    Unregistered tcp_congestion_ops cubic id 105
    .ft P
.UNINDENT
.UNINDENT

**# bpftool struct_ops register bpf\_cubic.o**
.INDENT 0.0
.INDENT 3.5

    .ft C
    Registered tcp_congestion_ops cubic id 110
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
**bpftool-prog**(8)
.UNINDENT
.UNINDENT

