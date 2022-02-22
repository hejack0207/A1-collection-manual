# bpftool-perf(8) - tool for inspection of perf related bpf prog attachments

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
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] perf COMMAND 
 OPTIONS := { [{ -j | --json }] [{ -p | --pretty }] } 
 COMMANDS := { show | list | help } .UNINDENT .UNINDENT
```

<a name="perf-commands"></a>

# Perf Commands

    bpftool perf { show | list }
    bpftool perf help


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool perf { show | list }**</b>  
  List all raw_tracepoint, tracepoint, kprobe attachment in the system.

Output will start with process id and file descriptor in that process,
followed by bpf program id, attachment information, and attachment point.
The attachment point for raw_tracepoint/tracepoint is the trace probe name.
The attachment point for k[ret]probe is either symbol name and offset,
or a kernel virtual address.
The attachment point for u[ret]probe is the file name and the file offset.

* <b>**bpftool perf help**</b>  
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

    # bpftool perf

.INDENT 0.0
.INDENT 3.5

    .ft C
    pid 21711  fd 5: prog_id 5  kprobe  func __x64_sys_write  offset 0
    pid 21765  fd 5: prog_id 7  kretprobe  func __x64_sys_nanosleep  offset 0
    pid 21767  fd 5: prog_id 8  tracepoint  sys_enter_nanosleep
    pid 21800  fd 5: prog_id 9  uprobe  filename /home/yhs/a.out  offset 1159
    .ft P
.UNINDENT
.UNINDENT
    
    # bpftool -j perf

.INDENT 0.0
.INDENT 3.5

    .ft C
    [{"pid":21711,"fd":5,"prog_id":5,"fd_type":"kprobe","func":"__x64_sys_write","offset":0}, e
     {"pid":21765,"fd":5,"prog_id":7,"fd_type":"kretprobe","func":"__x64_sys_nanosleep","offset":0}, e
     {"pid":21767,"fd":5,"prog_id":8,"fd_type":"tracepoint","tracepoint":"sys_enter_nanosleep"}, e
     {"pid":21800,"fd":5,"prog_id":9,"fd_type":"uprobe","filename":"/home/yhs/a.out","offset":1159}]
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
**bpftool-prog**(8),
**bpftool-struct\_ops**(8)
.UNINDENT
.UNINDENT

