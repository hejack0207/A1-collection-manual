# bpftool-feature(8) - tool for inspection of eBPF-related parameters for Linux kernel or net device

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
.INDENT 0.0 .INDENT 3.5 bpftool [OPTIONS] feature COMMAND 
 OPTIONS := { { -j | --json } [{ -p | --pretty }] } 
 COMMANDS := { probe | help } .UNINDENT .UNINDENT
```

<a name="feature-commands"></a>

# Feature Commands

    bpftool feature probe [COMPONENT] [full] [unprivileged] [macros [prefix PREFIX]]
    bpftool feature help
    
    COMPONENT := { kernel | dev NAME }


<a name="description"></a>

# Description

.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**bpftool feature probe** [**kernel**] [**full**] [**macros** [**prefix** _PREFIX_]]</b>  
  Probe the running kernel and dump a number of eBPF-related
  parameters, such as availability of the **bpf**() system call,
  JIT status, eBPF program types availability, eBPF helper
  functions availability, and more.

By default, bpftool **does not run probes** for
**bpf\_probe\_write\_user**() and **bpf\_trace\_printk**()
helpers which print warnings to kernel logs. To enable them
and run all probes, the **full** keyword should be used.

If the **macros** keyword (but not the **-j** option) is
passed, a subset of the output is dumped as a list of
**#define** macros that are ready to be included in a C
header file, for example. If, additionally, **prefix** is
used to define a _PREFIX_, the provided string will be used
as a prefix to the names of the macros: this can be used to
avoid conflicts on macro names when including the output of
this command as a header file.

Keyword **kernel** can be omitted. If no probe target is
specified, probing the kernel is the default behaviour.

When the **unprivileged** keyword is used, bpftool will dump
only the features available to a user who does not have the
**CAP\_SYS\_ADMIN** capability set. The features available in
that case usually represent a small subset of the parameters
supported by the system. Unprivileged users MUST use the
**unprivileged** keyword: This is to avoid misdetection if
bpftool is inadvertently run as non-root, for example. This
keyword is unavailable if bpftool was compiled without
libcap.

* <b>**bpftool feature probe dev** _NAME_ [**full**] [**macros** [**prefix** _PREFIX_]]</b>  
  Probe network device for supported eBPF features and dump
  results to the console.

The keywords **full**, **macros** and **prefix** have the
same role as when probing the kernel.

* <b>**bpftool feature help**</b>  
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

<a name="see-also"></a>

# See Also

.INDENT 0.0
.INDENT 3.5
**bpf**(2),
**bpf-helpers**(7),
**bpftool**(8),
**bpftool-btf**(8),
**bpftool-cgroup**(8),
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

