# perf\-script(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-script - Read perf.data (created by perf record) and display trace output

<a name="synopsis"></a>

# Synopsis

```


```
    perf script [<options>]
    perf script [<options>] record <script> [<record-options>] <command>
    perf script [<options>] report <script> [script-args]
    perf script [<options>] <script> <required-script-args> [<record-options>] <command>
    perf script [<options>] <top-script> [script-args]

<a name="description"></a>

# Description


This command reads the input file and displays the trace recorded.

There are several variants of perf script:

.if n \{.RS 4
.\}
    perf script*(Aq to see a detailed trace of the workload that was
    recorded.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    You can also run a set of pre-canned scripts that aggregate and
    summarize the raw trace data in various ways (the list of scripts is
    available via perf script -l*(Aq).  The following variants allow you to
    record and run those scripts:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf script record <script> <command>*(Aq to record the events required
    for perf script report*(Aq.  <script> is the name displayed in the
    output of perf script --list*(Aq i.e. the actual script name minus any
    language extension.  If <command> is not specified, the events are
    recorded using the -a (system-wide) perf record*(Aq option.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf script report <script> [args]*(Aq to run and display the results
    of <script>.  <script> is the name displayed in the output of perf
    script --list i.e. the actual script name minus any language
    extension.  The perf.data output from a previous run of perf script
    record <script> is used and should be present for this command to
    succeed.  [args] refers to the (mainly optional) args expected by
    the script.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf script <script> <required-script-args> <command>*(Aq to both
    record the events required for <script> and to run the <script>
    using live-mode*(Aq i.e. without writing anything to disk.  <script>
    is the name displayed in the output of perf script --list*(Aq i.e. the
    actual script name minus any language extension.  If <command> is
    not specified, the events are recorded using the -a (system-wide)
    perf record*(Aq option.  If <script> has any required args, they
    should be specified before <command>.  This mode doesnt allow for
    optional script args to be specified; if optional script args are
    desired, they can be specified using separate perf script record*(Aq
    and perf script report*(Aq commands, with the stdout of the record step
    piped to the stdin of the report script, using the -o -*(Aq and *(Aq-i -*(Aq
    options of the corresponding commands.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf script <top-script>*(Aq to both record the events required for
    <top-script> and to run the <top-script> using live-mode*(Aq
    i.e. without writing anything to disk.  <top-script> is the name
    displayed in the output of perf script --list*(Aq i.e. the actual
    script name minus any language extension; a <top-script> is defined
    as any script name ending with the string top*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [<record-options>] can be passed to the record steps of perf script
    record and *(Aqlive-mode*(Aq variants; this isn*(Aqt possible however for
    <top-script> live-mode*(Aq or *(Aqperf script report*(Aq variants.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    See the SEE ALSO*(Aq section for links to language-specific
    information on how to write and run your own trace scripts.
.if n \{.RE
.\}

<a name="options"></a>

# Options


&lt;command&gt;...
Any command you can specify in a shell.

-D, --dump-raw-trace=
Display verbose dump of the trace data.

-L, --Latency=
Show latency attributes (irqs/preemption disabled, etc).

-l, --list=
Display a list of available trace scripts.

-s [_lang_], --script=
Process trace data with the given script ([lang]:script[.ext]). If the string
_lang_
is specified in place of a script name, a list of supported languages will be displayed instead.

-g, --gen-script=
Generate perf-script.[ext] starter script for given language, using current perf.data.

-a
Force system-wide collection. Scripts run without a &lt;command&gt; normally use -a by default, while scripts run with a &lt;command&gt; normally don’t - this option allows the latter to be run in system-wide mode.

-i, --input=
Input file name. (default: perf.data unless stdin is a fifo)

-d, --debug-mode
Do various checks like samples ordering and lost events.

-F, --fields
Comma separated list of fields to print. Options are: comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff, srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output, brstackinsn, brstackoff, callindent, insn, insnlen, synth, phys_addr, metric, misc, srccode, ipc. Field list can be prepended with the type, trace, sw or hw, to indicate to which event type the field list applies. e.g., -F sw:comm,tid,time,ip,sym and -F trace:time,cpu,trace

.if n \{.RS 4
.\}
    perf script -F <fields>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    is equivalent to:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf script -F trace:<fields> -F sw:<fields> -F hw:<fields>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    i.e., the specified fields apply to all event types if the type string
    is not given.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    In addition to overriding fields, it is also possible to add or remove
    fields from the defaults. For example
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    -F -cpu,+insn
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    removes the cpu field and adds the insn field. Adding/removing fields
    cannot be mixed with normal overriding.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The arguments are processed in the order received. A later usage can
    reset a prior request. e.g.:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    -F trace: -F comm,tid,time,ip,sym
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The first -F suppresses trace events (field list is ""), but then the
    second invocation sets the fields to comm,tid,time,ip,sym. In this case a
    warning is given to the user:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "Overriding previous field request for all events."
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Alternatively, consider the order:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    -F comm,tid,time,ip,sym -F trace:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The first -F sets the fields for all events and the second -F
    suppresses trace events. The user is given a warning message about
    the override, and the result of the above is that only S/W and H/W
    events are displayed with the given fields.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Its possible tp add/remove fields only for specific event type:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    -Fsw:-cpu,-period
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    removes cpu and period from software events.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    For the wildcard*(Aq option if a user selected field is invalid for an
    event type, a message is displayed to the user that the option is
    ignored for that type. For example:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    $ perf script -F comm,tid,trace
    trace*(Aq not valid for hardware events. Ignoring.
    trace*(Aq not valid for software events. Ignoring.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Alternatively, if the type is given an invalid field is specified it
    is an error. For example:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf script -v -F sw:comm,tid,trace
    trace*(Aq not valid for software events.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    At this point usage is displayed, and perf-script exits.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The flags field is synthesized and may have a value when Instruction
    Trace decoding. The flags are "bcrosyiABEx" which stand for branch,
    call, return, conditional, system, asynchronous, interrupt,
    transaction abort, trace begin, trace end, and in transaction,
    respectively. Known combinations of flags are printed more nicely e.g.
    "call" for "bc", "return" for "br", "jcc" for "bo", "jmp" for "b",
    "int" for "bci", "iret" for "bri", "syscall" for "bcs", "sysret" for "brs",
    "async" for "by", "hw int" for "bcyi", "tx abrt" for "bA", "tr strt" for "bB",
    "tr end" for "bE". However the "x" flag will be display separately in those
    cases e.g. "jcc     (x)" for a condition branch within a transaction.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The callindent field is synthesized and may have a value when
    Instruction Trace decoding. For calls and returns, it will display the
    name of the symbol indented with spaces to reflect the stack depth.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    When doing instruction trace decoding insn and insnlen give the
    instruction bytes and the instruction length of the current
    instruction.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The synth field is used by synthesized events which may be created when
    Instruction Trace decoding.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The ipc (instructions per cycle) field is synthesized and may have a value when
    Instruction Trace decoding.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Finally, a user may not set fields to none for all event types.
    i.e., -F "" is not allowed.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The brstack output includes branch related information with raw addresses using the
    /v/v/v/v/cycles syntax in the following order:
    FROM: branch source instruction
    TO  : branch target instruction
    M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
    X/- : X=branch inside a transactional region, -=not in transaction region or not supported
    A/- : A=TSX abort entry, -=not aborted region or not supported
    cycles
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    When brstackinsn is specified the full assembler sequences of branch sequences for each sample
    is printed. This is the full execution path leading to the sample. This is only supported when the
    sample was recorded with perf record -b or -j any.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The brstackoff field will print an offset into a specific dso/binary.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    With the metric option perf script can compute metrics for
    sampling periods, similar to perf stat. This requires
    specifying a group with multiple events defining metrics with the :S option
    for perf record. perf will sample on the first event, and
    print computed metrics for all the events in the group. Please note
    that the metric computed is averaged over the whole sampling
    period (since the last sample), not just for the sample point.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    For sample events its possible to display misc field with -F +misc option,
    following letters are displayed for each bit:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    PERF_RECORD_MISC_KERNEL               K
    PERF_RECORD_MISC_USER                 U
    PERF_RECORD_MISC_HYPERVISOR           H
    PERF_RECORD_MISC_GUEST_KERNEL         G
    PERF_RECORD_MISC_GUEST_USER           g
    PERF_RECORD_MISC_MMAP_DATA*           M
    PERF_RECORD_MISC_COMM_EXEC            E
    PERF_RECORD_MISC_SWITCH_OUT           S
    PERF_RECORD_MISC_SWITCH_OUT_PREEMPT   Sp
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    $ perf script -F +misc ...
     sched-messaging  1414 K     28690.636582:       4590 cycles ...
     sched-messaging  1407 U     28690.636600:     325620 cycles ...
     sched-messaging  1414 K     28690.636608:      19473 cycles ...
    misc field ___________/
.if n \{.RE
.\}

-k, --vmlinux=&lt;file&gt;
vmlinux pathname

--kallsyms=&lt;file&gt;
kallsyms pathname

--symfs=&lt;directory&gt;
Look for files with symbols relative to this directory.

-G, --hide-call-graph
When printing symbols do not display call chain.

--stop-bt
Stop display of callgraph at these symbols

-C, --cpu
Only report samples for the list of CPUs provided. Multiple CPUs can be provided as a comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default is to report samples on all CPUs.

-c, --comms=
Only display events for these comms. CSV that understands
\m[blue]**file://filename**\m[]
entries.

--pid=
Only show events for given process ID (comma separated list).

--tid=
Only show events for given thread ID (comma separated list).

-I, --show-info
Display extended information about the perf.data file. This adds information which may be very large and thus may clutter the display. It currently includes: cpu and numa topology of the host system. It can only be used with the perf script report mode.

--show-kernel-path
Try to resolve the path of [kernel.kallsyms]

--show-task-events Display task related events (e.g. FORK, COMM, EXIT).

--show-mmap-events Display mmap related events (e.g. MMAP, MMAP2).

--show-namespace-events Display namespace events i.e. events of type PERF_RECORD_NAMESPACES.

--show-switch-events Display context switch events i.e. events of type PERF_RECORD_SWITCH or PERF_RECORD_SWITCH_CPU_WIDE.

--show-lost-events Display lost events i.e. events of type PERF_RECORD_LOST.

--show-round-events Display finished round events i.e. events of type PERF_RECORD_FINISHED_ROUND.

--show-bpf-events Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT.

--demangle
Demangle symbol names to human readable form. It’s enabled by default, disable with --no-demangle.

--demangle-kernel
Demangle kernel symbol names to human readable form (for C++ kernels).

--header Show perf.data header.

--header-only Show only perf.data header.

--itrace
Options for decoding instruction tracing data. The options are:

.if n \{.RS 4
.\}
    i       synthesize instructions events
    b       synthesize branches events
    c       synthesize branches events (calls only)
    r       synthesize branches events (returns only)
    x       synthesize transactions events
    w       synthesize ptwrite events
    p       synthesize power events
    o       synthesize other events recorded due to the use
            of aux-output (refer to perf record)
    e       synthesize error events
    d       create a debug log
    g       synthesize a call chain (use with i or x)
    l       synthesize last branch entries (use with i or x)
    s       skip initial number of events
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The default is all events i.e. the same as --itrace=ibxwpe,
    except for perf script where it is --itrace=ce
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    In addition, the period (default 100000, except for perf script where it is 1)
    for instructions events can be specified in units of:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    i       instructions
    t       ticks
    ms      milliseconds
    us      microseconds
    ns      nanoseconds (default)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Also the call chain size (default 16, max. 1024) for instructions or
    transactions events can be specified.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Also the number of last branch entries (default 64, max. 1024) for
    instructions or transactions events can be specified.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    It is also possible to skip events generated (instructions, branches, transactions,
    ptwrite, power) at the beginning. This is useful to ignore initialization code.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    --itrace=i0nss1000000
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    skips the first million instructions.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    To disable decoding entirely, use --no-itrace.
.if n \{.RE
.\}

--full-source-path
Show the full path for source files for srcline output.

--max-stack
Set the stack depth limit when parsing the callchain, anything beyond the specified depth will be ignored. This is a trade-off between information loss and faster processing especially for workloads that can have a very long callchain stack. Note that when using the --itrace option the synthesized callchain size will override this value if the synthesized callchain size is bigger.

.if n \{.RS 4
.\}
    Default: 127
.if n \{.RE
.\}

--ns
Use 9 decimal places when displaying time (i.e. show the nanoseconds)

-f, --force
Don’t do ownership validation.

--time
Only analyze samples within given time window: &lt;start&gt;,&lt;stop&gt;. Times have the format seconds.nanoseconds. If start is not given (i.e. time string is
_,x.y_) then analysis starts at the beginning of the file. If stop time is not given (i.e. time string is
_x.y,_) then analysis goes to end of file. Multiple ranges can be separated by spaces, which requires the argument to be quoted e.g. --time "1234.567,1234.789 1235,"

.if n \{.RS 4
.\}
    Also support time percent with multiple time ranges. Time string is
    a%/n,b%/m,...*(Aq or *(Aqa%-b%,c%-%d,...*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    For example:
    Select the second 10% time slice:
    perf script --time 10%/2
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select from 0% to 10% time slice:
    perf script --time 0%-10%
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select the first and second 10% time slices:
    perf script --time 10%/1,10%/2
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select from 0% to 10% and 30% to 40% slices:
    perf script --time 0%-10%,30%-40%
.if n \{.RE
.\}

--max-blocks
Set the maximum number of program blocks to print with brstackinsn for each sample.

--reltime
Print time stamps relative to trace start.

--per-event-dump
Create per event files with a "perf.data.EVENT.dump" name instead of printing to stdout, useful, for instance, for generating flamegraphs.

--inline
If a callgraph address belongs to an inlined function, the inline stack will be printed. Each entry has function name and file/line. Enabled by default, disable with --no-inline.

--insn-trace
Show instruction stream for intel_pt traces. Combine with --xed to show disassembly.

--xed
Run xed disassembler on output. Requires installing the xed disassembler.

--call-trace
Show call stream for intel_pt traces. The CPUs are interleaved, but can be filtered with -C.

--call-ret-trace
Show call and return stream for intel_pt traces.

--graph-function
For itrace only show specified functions and their callees for itrace. Multiple functions can be separated by comma.

--switch-on EVENT_NAME
Only consider events after this event is found.

--switch-off EVENT_NAME
Stop considering events after this event is found.

--show-on-off-events
Show the --switch-on/off events too.

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-script-perl**(1), **perf-script-python**(1)
