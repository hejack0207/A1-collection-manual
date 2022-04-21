# llvm-exegesis(1) - LLVM Machine Instruction Benchmark

11, 2020-10-15

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

 llvm-exegesis [options]
```

<a name="description"></a>

# Description


**llvm-exegesis** is a benchmarking tool that uses information available
in LLVM to measure host machine instruction characteristics like latency,
throughput, or port decomposition.

Given an LLVM opcode name and a benchmarking mode, **llvm-exegesis**
generates a code snippet that makes execution as serial (resp. as parallel) as
possible so that we can measure the latency (resp. inverse throughput/uop decomposition)
of the instruction.
The code snippet is jitted and executed on the host subtarget. The time taken
(resp. resource usage) is measured using hardware performance counters. The
result is printed out as YAML to the standard output.

The main goal of this tool is to automatically (in)validate the LLVM's TableDef
scheduling models. To that end, we also provide analysis of the results.

**llvm-exegesis** can also benchmark arbitrary user-provided code
snippets.

<a name="example-1-benchmarking-instructions"></a>

# Example 1: Benchmarking Instructions


Assume you have an X86-64 machine. To measure the latency of a single
instruction, run:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ llvm-exegesis -mode=latency -opcode-name=ADD64rr
    .ft P
.UNINDENT
.UNINDENT

Measuring the uop decomposition or inverse throughput of an instruction works similarly:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ llvm-exegesis -mode=uops -opcode-name=ADD64rr
    $ llvm-exegesis -mode=inverse_throughput -opcode-name=ADD64rr
    .ft P
.UNINDENT
.UNINDENT

The output is a YAML document (the default is to write to stdout, but you can
redirect the output to a file using _-benchmarks-file_):
.INDENT 0.0
.INDENT 3.5

    .ft C
    ---
    key:
      opcode_name:     ADD64rr
      mode:            latency
      config:          ''
    cpu_name:        haswell
    llvm_triple:     x86_64-unknown-linux-gnu
    num_repetitions: 10000
    measurements:
      - { key: latency, value: 1.0058, debug_string: '' }
    error:           ''
    info:            'explicit self cycles, selecting one aliasing configuration.
    Snippet:
    ADD64rr R8, R8, R10
    '
    ...
    .ft P
.UNINDENT
.UNINDENT

To measure the latency of all instructions for the host architecture, run:
.INDENT 0.0
.INDENT 3.5

    .ft C
    #!/bin/bash
    readonly INSTRUCTIONS=$(($(grep INSTRUCTION_LIST_END build/lib/Target/X86/X86GenInstrInfo.inc | cut -f2 -d=) - 1))
    for INSTRUCTION in $(seq 1 ${INSTRUCTIONS});
    do
      ./build/bin/llvm-exegesis -mode=latency -opcode-index=${INSTRUCTION} | sed -n '/---/,$p'
    done
    .ft P
.UNINDENT
.UNINDENT

FIXME: Provide an **llvm-exegesis** option to test all instructions.

<a name="example-2-benchmarking-a-custom-code-snippet"></a>

# Example 2: Benchmarking a Custom Code Snippet


To measure the latency/uops of a custom piece of code, you can specify the
_snippets-file_ option (_-_ reads from standard input).
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ echo "vzeroupper" | llvm-exegesis -mode=uops -snippets-file=-
    .ft P
.UNINDENT
.UNINDENT

Real-life code snippets typically depend on registers or memory.
**llvm-exegesis** checks the liveliness of registers (i.e. any register
use has a corresponding def or is a "live in"). If your code depends on the
value of some registers, you have two options:
.INDENT 0.0

* ·  
  Mark the register as requiring a definition. **llvm-exegesis** will
  automatically assign a value to the register. This can be done using the
  directive _LLVM-EXEGESIS-DEFREG &lt;reg name&gt; &lt;hex\_value&gt;_, where _&lt;hex\_value&gt;_
  is a bit pattern used to fill _&lt;reg\_name&gt;_. If _&lt;hex\_value&gt;_ is smaller than
  the register width, it will be sign-extended.
* ·  
  Mark the register as a "live in". **llvm-exegesis** will benchmark
  using whatever value was in this registers on entry. This can be done using
  the directive _LLVM-EXEGESIS-LIVEIN &lt;reg name&gt;_.
  .UNINDENT

For example, the following code snippet depends on the values of XMM1 (which
will be set by the tool) and the memory buffer passed in RDI (live in).
.INDENT 0.0
.INDENT 3.5

    .ft C
    # LLVM-EXEGESIS-LIVEIN RDI
    # LLVM-EXEGESIS-DEFREG XMM1 42
    vmulps        (%rdi), %xmm1, %xmm2
    vhaddps       %xmm2, %xmm2, %xmm3
    addq $0x10, %rdi
    .ft P
.UNINDENT
.UNINDENT

<a name="example-3-analysis"></a>

# Example 3: Analysis


Assuming you have a set of benchmarked instructions (either latency or uops) as
YAML in file _/tmp/benchmarks.yaml_, you can analyze the results using the
following command:
.INDENT 0.0
.INDENT 3.5

    .ft C
      $ llvm-exegesis -mode=analysis e
    -benchmarks-file=/tmp/benchmarks.yaml e
    -analysis-clusters-output-file=/tmp/clusters.csv e
    -analysis-inconsistencies-output-file=/tmp/inconsistencies.html
    .ft P
.UNINDENT
.UNINDENT

This will group the instructions into clusters with the same performance
characteristics. The clusters will be written out to _/tmp/clusters.csv_ in the
following format:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cluster_id,opcode_name,config,sched_class
    ...
    2,ADD32ri8_DB,,WriteALU,1.00
    2,ADD32ri_DB,,WriteALU,1.01
    2,ADD32rr,,WriteALU,1.01
    2,ADD32rr_DB,,WriteALU,1.00
    2,ADD32rr_REV,,WriteALU,1.00
    2,ADD64i32,,WriteALU,1.01
    2,ADD64ri32,,WriteALU,1.01
    2,MOVSX64rr32,,BSWAP32r_BSWAP64r_MOVSX64rr32,1.00
    2,VPADDQYrr,,VPADDBYrr_VPADDDYrr_VPADDQYrr_VPADDWYrr_VPSUBBYrr_VPSUBDYrr_VPSUBQYrr_VPSUBWYrr,1.02
    2,VPSUBQYrr,,VPADDBYrr_VPADDDYrr_VPADDQYrr_VPADDWYrr_VPSUBBYrr_VPSUBDYrr_VPSUBQYrr_VPSUBWYrr,1.01
    2,ADD64ri8,,WriteALU,1.00
    2,SETBr,,WriteSETCC,1.01
    ...
    .ft P
.UNINDENT
.UNINDENT

**llvm-exegesis** will also analyze the clusters to point out
inconsistencies in the scheduling information. The output is an html file. For
example, _/tmp/inconsistencies.html_ will contain messages like the following :
[image]

Note that the scheduling class names will be resolved only when
**llvm-exegesis** is compiled in debug mode, else only the class id will
be shown. This does not invalidate any of the analysis results though.

<a name="options"></a>

# Options

.INDENT 0.0

* **-help**  
  Print a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **-opcode-index=&lt;LLVM opcode index&gt;**  
  Specify the opcode to measure, by index. Specifying _-1_ will result
  in measuring every existing opcode. See example 1 for details.
  Either _opcode-index_, _opcode-name_ or _snippets-file_ must be set.
  .UNINDENT
  .INDENT 0.0
* **-opcode-name=&lt;opcode name 1&gt;,&lt;opcode name 2&gt;,...**  
  Specify the opcode to measure, by name. Several opcodes can be specified as
  a comma-separated list. See example 1 for details.
  Either _opcode-index_, _opcode-name_ or _snippets-file_ must be set.
  .UNINDENT
  .INDENT 0.0
* **-snippets-file=&lt;filename&gt;**  
  Specify the custom code snippet to measure. See example 2 for details.
  Either _opcode-index_, _opcode-name_ or _snippets-file_ must be set.
  .UNINDENT
  .INDENT 0.0
* **-mode=[latency|uops|inverse_throughput|analysis]**  
  Specify the run mode. Note that if you pick _analysis_ mode, you also need
  to specify at least one of the _-analysis-clusters-output-file=_ and
  _-analysis-inconsistencies-output-file=_.
  .UNINDENT
  .INDENT 0.0
* **-repetition-mode=[duplicate|loop|min]**  
  Specify the repetition mode. _duplicate_ will create a large, straight line
  basic block with _num-repetitions_ copies of the snippet. _loop_ will wrap
  the snippet in a loop which will be run _num-repetitions_ times. The _loop_
  mode tends to better hide the effects of the CPU frontend on architectures
  that cache decoded instructions, but consumes a register for counting
  iterations. If performing an analysis over many opcodes, it may be best
  to instead use the _min_ mode, which will run each other mode, and produce
  the minimal measured result.
  .UNINDENT
  .INDENT 0.0
* **-num-repetitions=&lt;Number of repetitions&gt;**  
  Specify the number of repetitions of the asm snippet.
  Higher values lead to more accurate measurements but lengthen the benchmark.
  .UNINDENT
  .INDENT 0.0
* **-max-configs-per-opcode=&lt;value&gt;**  
  Specify the maximum configurations that can be generated for each opcode.
  By default this is _1_, meaning that we assume that a single measurement is
  enough to characterize an opcode. This might not be true of all instructions:
  for example, the performance characteristics of the LEA instruction on X86
  depends on the value of assigned registers and immediates. Setting a value of
  _-max-configs-per-opcode_ larger than _1_ allows _llvm-exegesis_ to explore
  more configurations to discover if some register or immediate assignments
  lead to different performance characteristics.
  .UNINDENT
  .INDENT 0.0
* **-benchmarks-file=&lt;/path/to/file&gt;**  
  File to read (_analysis_ mode) or write (_latency_/_uops_/_inverse\_throughput_
  modes) benchmark results. "-" uses stdin/stdout.
  .UNINDENT
  .INDENT 0.0
* **-analysis-clusters-output-file=&lt;/path/to/file&gt;**  
  If provided, write the analysis clusters as CSV to this file. "-" prints to
  stdout. By default, this analysis is not run.
  .UNINDENT
  .INDENT 0.0
* **-analysis-inconsistencies-output-file=&lt;/path/to/file&gt;**  
  If non-empty, write inconsistencies found during analysis to this file. _-_
  prints to stdout. By default, this analysis is not run.
  .UNINDENT
  .INDENT 0.0
* **-analysis-clustering=[dbscan,naive]**  
  Specify the clustering algorithm to use. By default DBSCAN will be used.
  Naive clustering algorithm is better for doing further work on the
  _-analysis-inconsistencies-output-file=_ output, it will create one cluster
  per opcode, and check that the cluster is stable (all points are neighbours).
  .UNINDENT
  .INDENT 0.0
* **-analysis-numpoints=&lt;dbscan numPoints parameter&gt;**  
  Specify the numPoints parameters to be used for DBSCAN clustering
  (_analysis_ mode, DBSCAN only).
  .UNINDENT
  .INDENT 0.0
* **-analysis-clustering-epsilon=&lt;dbscan epsilon parameter&gt;**  
  Specify the epsilon parameter used for clustering of benchmark points
  (_analysis_ mode).
  .UNINDENT
  .INDENT 0.0
* **-analysis-inconsistency-epsilon=&lt;epsilon&gt;**  
  Specify the epsilon parameter used for detection of when the cluster
  is different from the LLVM schedule profile values (_analysis_ mode).
  .UNINDENT
  .INDENT 0.0
* **-analysis-display-unstable-clusters**  
  If there is more than one benchmark for an opcode, said benchmarks may end up
  not being clustered into the same cluster if the measured performance
  characteristics are different. by default all such opcodes are filtered out.
  This flag will instead show only such unstable opcodes.
  .UNINDENT
  .INDENT 0.0
* **-ignore-invalid-sched-class=false**  
  If set, ignore instructions that do not have a sched class (class idx = 0).
  .UNINDENT
  .INDENT 0.0
* **-mcpu=&lt;cpu name&gt;**  
  If set, measure the cpu characteristics using the counters for this CPU. This
  is useful when creating new sched models (the host CPU is unknown to LLVM).
  .UNINDENT
  .INDENT 0.0
* **--dump-object-to-disk=true**  
  By default, llvm-exegesis will dump the generated code to a temporary file to
  enable code inspection. You may disable it to speed up the execution and save
  disk space.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-exegesis** returns 0 on success. Otherwise, an error message is
printed to standard error, and the tool returns a non 0 value.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

