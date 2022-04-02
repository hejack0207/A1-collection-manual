# lli(1) - directly execute programs from LLVM bitcode

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

 lli [options] [filename] [program args]
```

<a name="description"></a>

# Description


**lli** directly executes programs in LLVM bitcode format.  It takes a program
in LLVM bitcode format and executes it using a just-in-time compiler or an
interpreter.

**lli** is _not_ an emulator. It will not execute IR of different architectures
and it can only interpret (or JIT-compile) for the host architecture.

The JIT compiler takes the same arguments as other tools, like **llc**,
but they don't necessarily work for the interpreter.

If _filename_ is not specified, then **lli** reads the LLVM bitcode for the
program from standard input.

The optional _args_ specified on the command line are passed to the program as
arguments.

<a name="general-options"></a>

# General Options

.INDENT 0.0

* **-fake-argv0=executable**  
  Override the **argv[0]** value passed into the executing program.
  .UNINDENT
  .INDENT 0.0
* **-force-interpreter={false,true}**  
  If set to true, use the interpreter even if a just-in-time compiler is available
  for this architecture. Defaults to false.
  .UNINDENT
  .INDENT 0.0
* **-help**  
  Print a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **-load=pluginfilename**  
  Causes **lli** to load the plugin (shared object) named _pluginfilename_ and use
  it for optimization.
  .UNINDENT
  .INDENT 0.0
* **-stats**  
  Print statistics from the code-generation passes. This is only meaningful for
  the just-in-time compiler, at present.
  .UNINDENT
  .INDENT 0.0
* **-time-passes**  
  Record the amount of time needed for each code-generation pass and print it to
  standard error.
  .UNINDENT
  .INDENT 0.0
* **-version**  
  Print out the version of **lli** and exit without doing anything else.
  .UNINDENT

<a name="target-options"></a>

# Target Options

.INDENT 0.0

* **-mtriple=target triple**  
  Override the target triple specified in the input bitcode file with the
  specified string.  This may result in a crash if you pick an
  architecture which is not compatible with the current system.
  .UNINDENT
  .INDENT 0.0
* **-march=arch**  
  Specify the architecture for which to generate assembly, overriding the target
  encoded in the bitcode file.  See the output of **llc -help** for a list of
  valid architectures.  By default this is inferred from the target triple or
  autodetected to the current architecture.
  .UNINDENT
  .INDENT 0.0
* **-mcpu=cpuname**  
  Specify a specific chip in the current architecture to generate code for.
  By default this is inferred from the target triple and autodetected to
  the current architecture.  For a list of available CPUs, use:
  **llvm-as &lt; /dev/null | llc -march=xyz -mcpu=help**
  .UNINDENT
  .INDENT 0.0
* **-mattr=a1,+a2,-a3,...**  
  Override or control specific attributes of the target, such as whether SIMD
  operations are enabled or not.  The default set of attributes is set by the
  current CPU.  For a list of available attributes, use:
  **llvm-as &lt; /dev/null | llc -march=xyz -mattr=help**
  .UNINDENT

<a name="floating-point-options"></a>

# Floating Point Options

.INDENT 0.0

* **-disable-excess-fp-precision**  
  Disable optimizations that may increase floating point precision.
  .UNINDENT
  .INDENT 0.0
* **-enable-no-infs-fp-math**  
  Enable optimizations that assume no Inf values.
  .UNINDENT
  .INDENT 0.0
* **-enable-no-nans-fp-math**  
  Enable optimizations that assume no NAN values.
  .UNINDENT
  .INDENT 0.0
* **-enable-unsafe-fp-math**  
  Causes **lli** to enable optimizations that may decrease floating point
  precision.
  .UNINDENT
  .INDENT 0.0
* **-soft-float**  
  Causes **lli** to generate software floating point library calls instead of
  equivalent hardware instructions.
  .UNINDENT

<a name="code-generation-options"></a>

# Code Generation Options

.INDENT 0.0

* **-code-model=model**  
  Choose the code model from:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    default: Target default code model
    tiny: Tiny code model
    small: Small code model
    kernel: Kernel code model
    medium: Medium code model
    large: Large code model
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-disable-post-RA-scheduler**  
  Disable scheduling after register allocation.
  .UNINDENT
  .INDENT 0.0
* **-disable-spill-fusing**  
  Disable fusing of spill code into instructions.
  .UNINDENT
  .INDENT 0.0
* **-jit-enable-eh**  
  Exception handling should be enabled in the just-in-time compiler.
  .UNINDENT
  .INDENT 0.0
* **-join-liveintervals**  
  Coalesce copies (default=true).
  .UNINDENT
  .INDENT 0.0
* **-nozero-initialized-in-bss**  
  Don't place zero-initialized symbols into the BSS section.
  .UNINDENT
  .INDENT 0.0
* **-pre-RA-sched=scheduler**  
  Instruction schedulers available (before register allocation):
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =default: Best scheduler for the target
    =none: No scheduling: breadth first sequencing
    =simple: Simple two pass scheduling: minimize critical path and maximize processor utilization
    =simple-noitin: Simple two pass scheduling: Same as simple except using generic latency
    =list-burr: Bottom-up register reduction list scheduling
    =list-tdrr: Top-down register reduction list scheduling
    =list-td: Top-down list scheduler -print-machineinstrs - Print generated machine code
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-regalloc=allocator**  
  Register allocator to use (default=linearscan)
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =bigblock: Big-block register allocator
    =linearscan: linear scan register allocator =local -   local register allocator
    =simple: simple register allocator
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-relocation-model=model**  
  Choose relocation model from:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =default: Target default relocation model
    =static: Non-relocatable code =pic -   Fully relocatable, position independent code
    =dynamic-no-pic: Relocatable external references, non-relocatable code
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-spiller**  
  Spiller to use (default=local)
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =simple: simple spiller
    =local: local spiller
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-x86-asm-syntax=syntax**  
  Choose style of code to emit from X86 backend:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    =att: Emit AT&T-style assembly
    =intel: Emit Intel-style assembly
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT

<a name="exit-status"></a>

# Exit Status


If **lli** fails to load the program, it will exit with an exit code of 1.
Otherwise, it will return the exit code of the program it executes.

<a name="see-also"></a>

# See Also


**llc(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

