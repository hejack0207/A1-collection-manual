# perf\-report(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-report - Read perf.data (created by perf record) and display the profile

<a name="synopsis"></a>

# Synopsis

```


```
    perf report [-i <file> | --input=file]

<a name="description"></a>

# Description


This command displays the performance counter profile information recorded via perf record.

<a name="options"></a>

# Options


-i, --input=
Input file name. (default: perf.data unless stdin is a fifo)

-v, --verbose
Be more verbose. (show symbol address, etc)

-q, --quiet
Do not show any message. (Suppress -v)

-n, --show-nr-samples
Show the number of samples for each symbol

--show-cpu-utilization
Show sample percentage for different cpu modes.

-T, --threads
Show per-thread event counters. The input data file should be recorded with -s option.

-c, --comms=
Only consider symbols in these comms. CSV that understands
\m[blue]**file://filename**\m[]
entries. This option will affect the percentage of the overhead column. See --percentage for more info.

--pid=
Only show events for given process ID (comma separated list).

--tid=
Only show events for given thread ID (comma separated list).

-d, --dsos=
Only consider symbols in these dsos. CSV that understands
\m[blue]**file://filename**\m[]
entries. This option will affect the percentage of the overhead column. See --percentage for more info.

-S, --symbols=
Only consider these symbols. CSV that understands
\m[blue]**file://filename**\m[]
entries. This option will affect the percentage of the overhead column. See --percentage for more info.

--symbol-filter=
Only show symbols that match (partially) with this filter.

-U, --hide-unresolved
Only display entries resolved to a symbol.

-s, --sort=
Sort histogram entries by given key(s) - multiple keys can be specified in CSV format. Following sort keys are available: pid, comm, dso, symbol, parent, cpu, socket, srcline, weight, local_weight, cgroup_id.

.if n \{.RS 4
.\}
    Each key has following meaning:
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  comm: command (name) of the task which can be read via /proc/&lt;pid&gt;/comm

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  pid: command and tid of the task

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  dso: name of library or module executed at the time of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  dso_size: size of library or module executed at the time of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  symbol: name of function executed at the time of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  symbol_size: size of function executed at the time of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  parent: name of function matched to the parent regex filter. Unmatched entries are displayed as "[other]".

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  cpu: cpu number the task ran at the time of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  socket: processor socket number the task ran at the time of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  srcline: filename and line number executed at the time of sample. The DWARF debugging info must be provided.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  srcfile: file name of the source file of the samples. Requires dwarf information.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  weight: Event specific weight, e.g. memory latency or transaction abort cost. This is the global weight.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  local_weight: Local weight version of the weight above.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  cgroup_id: ID derived from cgroup namespace device and inode numbers.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  transaction: Transaction abort flags.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  overhead: Overhead percentage of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  overhead_sys: Overhead percentage of sample running in system mode

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  overhead_us: Overhead percentage of sample running in user mode

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  overhead_guest_sys: Overhead percentage of sample running in system mode on guest machine

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  overhead_guest_us: Overhead percentage of sample running in user mode on guest machine

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sample: Number of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  period: Raw number of event count of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  time: Separate the samples by time stamp with the resolution specified by --time-quantum (default 100ms). Specify with overhead and before it.

.if n \{.RS 4
.\}
    By default, comm, dso and symbol keys are used.
    (i.e. --sort comm,dso,symbol)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If --branch-stack option is used, following sort keys are also
    available:
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  dso_from: name of library or module branched from

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  dso_to: name of library or module branched to

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  symbol_from: name of function branched from

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  symbol_to: name of function branched to

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  srcline_from: source file and line branched from

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  srcline_to: source file and line branched to

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  mispredict: "N" for predicted branch, "Y" for mispredicted branch

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  in_tx: branch in TSX transaction

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  abort: TSX transaction abort.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  cycles: Cycles in basic block

.if n \{.RS 4
.\}
    And default sort keys are changed to comm, dso_from, symbol_from, dso_to
    and symbol_to, see --branch-stack*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    When the sort key symbol is specified, columns "IPC" and "IPC Coverage"
    are enabled automatically. Column "IPC" reports the average IPC per function
    and column "IPC coverage" reports the percentage of instructions with
    sampled IPC in this function. IPC means Instruction Per Cycle. If its low,
    it indicates there may be a performance bottleneck when the function is
    executed, such as a memory access bottleneck. If a function has high overhead
    and low IPC, its worth further analyzing it to optimize its performance.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If the --mem-mode option is used, the following sort keys are also available
    (incompatible with --branch-stack):
    symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline.
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  symbol_daddr: name of data symbol being executed on at the time of sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  dso_daddr: name of library or module containing the data being executed on at the time of the sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  locked: whether the bus was locked at the time of the sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  tlb: type of tlb access for the data at the time of the sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  mem: type of memory access for the data at the time of the sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  snoop: type of snoop (if any) for the data at the time of the sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  dcacheline: the cacheline the data address is on at the time of the sample

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  phys_daddr: physical address of data being executed on at the time of sample

.if n \{.RS 4
.\}
    And the default sort keys are changed to local_weight, mem, sym, dso,
    symbol_daddr, dso_daddr, snoop, tlb, locked, see --mem-mode*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If the data file has tracepoint event(s), following (dynamic) sort keys
    are also available:
    trace, trace_fields, [<event>.]<field>[/raw]
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  trace: pretty printed trace output in a single column

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  trace_fields: fields in tracepoints in separate columns

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  &lt;field name&gt;: optional event and field name for a specific field

.if n \{.RS 4
.\}
    The last form consists of event and field names.  If event name is
    omitted, it searches all events for matching field name.  The matched
    field will be shown only for the event has the field.  The event name
    supports substring match so user doesnt need to specify full subsystem
    and event name everytime.  For example, sched:sched_switch*(Aq event can
    be shortened to switch*(Aq as long as it*(Aqs not ambiguous.  Also event can
    be specified by its index (starting from 1) preceded by the %*(Aq.
    So %1*(Aq is the first event, *(Aq%2*(Aq is the second, and so on.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The field name can have /raw*(Aq suffix which disables pretty printing
    and shows raw field value like hex numbers.  The --raw-trace option
    has the same effect for all dynamic sort keys.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The default sort keys are changed to trace*(Aq if all events in the data
    file are tracepoint.
.if n \{.RE
.\}

-F, --fields=
Specify output field - multiple keys can be specified in CSV format. Following fields are available: overhead, overhead_sys, overhead_us, overhead_children, sample and period. Also it can contain any sort key(s).

.if n \{.RS 4
.\}
    By default, every sort keys not specified in -F will be appended
    automatically.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If the keys starts with a prefix +*(Aq, then it will append the specified
    field(s) to the default field order. For example: perf report -F +period,sample.
.if n \{.RE
.\}

-p, --parent=&lt;regex&gt;
A regex filter to identify parent. The parent is a caller of this function and searched through the callchain, thus it requires callchain information recorded. The pattern is in the extended regex format and defaults to "^sys_|^do_page_fault", see
_--sort parent_.

-x, --exclude-other
Only display entries with parent-match.

-w, --column-widths=&lt;width[,width...]&gt;
Force each column width to the provided list, for large terminal readability. 0 means no limit (default behavior).

-t, --field-separator=
Use a special separator character and don’t pad with spaces, replacing all occurrences of this separator in symbol names (and other output) with a
_._
character, that thus it’s the only non valid separator.

-D, --dump-raw-trace
Dump raw trace in ASCII.

-g, --call-graph=&lt;print_type,threshold[,print_limit],order,sort_key[,branch],value&gt;
Display call chains using type, min percent threshold, print limit, call order, sort key, optional branch and value. Note that ordering is not fixed so any parameter can be given in an arbitrary order. One exception is the print_limit which should be preceded by threshold.

.if n \{.RS 4
.\}
    print_type can be either:
    - flat: single column, linear exposure of call chains.
    - graph: use a graph tree, displaying absolute overhead rates. (default)
    - fractal: like graph, but displays relative rates. Each branch of
             the tree is considered as a new profiled object.
    - folded: call chains are displayed in a line, separated by semicolons
    - none: disable call chain display.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    threshold is a percentage value which specifies a minimum percent to be
    included in the output call graph.  Default is 0.5 (%).
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    print_limit is only applied when stdio interface is used.  Its to limit
    number of call graph entries in a single hist entry.  Note that it needs
    to be given after threshold (but not necessarily consecutive).
    Default is 0 (unlimited).
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    order can be either:
    - callee: callee based call graph.
    - caller: inverted caller based call graph.
    Default is caller*(Aq when --children is used, otherwise *(Aqcallee*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    sort_key can be:
    - function: compare on functions (default)
    - address: compare on individual code addresses
    - srcline: compare on source filename and line number
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    branch can be:
    - branch: include last branch information in callgraph when available.
              Usually more convenient to use --branch-history for this.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    value can be:
    - percent: display overhead percent (default)
    - period: display event period
    - count: display event count
.if n \{.RE
.\}

--children
Accumulate callchain of children to parent entry so that then can show up in the output. The output will have a new "Children" column and will be sorted on the data. It requires callchains are recorded. See the ‘overhead calculation’ section for more details. Enabled by default, disable with --no-children.

--max-stack
Set the stack depth limit when parsing the callchain, anything beyond the specified depth will be ignored. This is a trade-off between information loss and faster processing especially for workloads that can have a very long callchain stack. Note that when using the --itrace option the synthesized callchain size will override this value if the synthesized callchain size is bigger.

.if n \{.RS 4
.\}
    Default: 127
.if n \{.RE
.\}

-G, --inverted
alias for inverted caller based call graph.

--ignore-callees=&lt;regex&gt;
Ignore callees of the function(s) matching the given regex. This has the effect of collecting the callers of each such function into one place in the call-graph tree.

--pretty=&lt;key&gt;
Pretty printing style. key: normal, raw

--stdio
Use the stdio interface.

--stdio-color
_always_,
_never_
or
_auto_, allowing configuring color output via the command line, in addition to via "color.ui" .perfconfig. Use
_--stdio-color always_
to generate color even when redirecting to a pipe or file. Using just
_--stdio-color_
is equivalent to using
_always_.

--tui
Use the TUI interface, that is integrated with annotate and allows zooming into DSOs or threads, among other features. Use of --tui requires a tty, if one is not present, as when piping to other commands, the stdio interface is used.

--gtk
Use the GTK2 interface.

-k, --vmlinux=&lt;file&gt;
vmlinux pathname

--ignore-vmlinux
Ignore vmlinux files.

--kallsyms=&lt;file&gt;
kallsyms pathname

-m, --modules
Load module symbols. WARNING: This should only be used with -k and a LIVE kernel.

-f, --force
Don’t do ownership validation.

--symfs=&lt;directory&gt;
Look for files with symbols relative to this directory.

-C, --cpu
Only report samples for the list of CPUs provided. Multiple CPUs can be provided as a comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default is to report samples on all CPUs.

-M, --disassembler-style=
Set disassembler style for objdump.

--source
Interleave source code with assembly code. Enabled by default, disable with --no-source.

--asm-raw
Show raw instruction encoding of assembly instructions.

--show-total-period
Show a column with the sum of periods.

-I, --show-info
Display extended information about the perf.data file. This adds information which may be very large and thus may clutter the display. It currently includes: cpu and numa topology of the host system.

-b, --branch-stack
Use the addresses of sampled taken branches instead of the instruction address to build the histograms. To generate meaningful output, the perf.data file must have been obtained using perf record -b or perf record --branch-filter xxx where xxx is a branch filter option. perf report is able to auto-detect whether a perf.data file contains branch stacks and it will automatically switch to the branch view mode, unless --no-branch-stack is used.

--branch-history
Add the addresses of sampled taken branches to the callstack. This allows to examine the path the program took to each sample. The data collection must have used -b (or -j) and -g.

--objdump=&lt;path&gt;
Path to objdump binary.

--prefix=PREFIX, --prefix-strip=N
Remove first N entries from source file path names in executables and add PREFIX. This allows to display source code compiled on systems with different file system layout.

--group
Show event group information together. It forces group output also if there are no groups defined in data file.

--demangle
Demangle symbol names to human readable form. It’s enabled by default, disable with --no-demangle.

--demangle-kernel
Demangle kernel symbol names to human readable form (for C++ kernels).

--mem-mode
Use the data addresses of samples in addition to instruction addresses to build the histograms. To generate meaningful output, the perf.data file must have been obtained using perf record -d -W and using a special event -e cpu/mem-loads/p or -e cpu/mem-stores/p. See
_perf mem_
for simpler access.

--percent-limit
Do not show entries which have an overhead under that percent. (Default: 0). Note that this option also sets the percent limit (threshold) of callchains. However the default value of callchain threshold is different than the default value of hist entries. Please see the --call-graph option for details.

--percentage
Determine how to display the overhead percentage of filtered entries. Filters can be applied by --comms, --dsos and/or --symbols options and Zoom operations on the TUI (thread, dso, etc).

.if n \{.RS 4
.\}
    "relative" means its relative to filtered entries only so that the
    sum of shown entries will be always 100%.  "absolute" means it retains
    the original value before and after the filter is applied.
.if n \{.RE
.\}

--header
Show header information in the perf.data file. This includes various information like hostname, OS and perf version, cpu/mem info, perf command line, event list and so on. Currently only --stdio output supports this feature.

--header-only
Show only perf.data header (forces --stdio).

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
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf report --time 10%/2
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select from 0% to 10% time slice:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf report --time 0%-10%
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select the first and second 10% time slices:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf report --time 10%/1,10%/2
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select from 0% to 10% and 30% to 40% slices:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf report --time 0%-10%,30%-40%
.if n \{.RE
.\}

--switch-on EVENT_NAME
Only consider events after this event is found.

.if n \{.RS 4
.\}
    This may be interesting to measure a workload only after some initialization
    phase is over, i.e. insert a perf probe at that point and then using this
    option with that probe.
.if n \{.RE
.\}

--switch-off EVENT_NAME
Stop considering events after this event is found.

--show-on-off-events
Show the --switch-on/off events too. This has no effect in
_perf report_
now but probably we’ll make the default not to show the switch-on/off events on the --group mode and if there is only one event besides the off/on ones, go straight to the histogram browser, just like
_perf report_
with no events explicitely specified does.

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

--show-ref-call-graph
When multiple events are sampled, it may not be needed to collect callgraphs for all of them. The sample sites are usually nearby, and it’s enough to collect the callgraphs on a reference event. So user can use "call-graph=no" event modifier to disable callgraph for other events to reduce the overhead. However, perf report cannot show callgraphs for the event which disable the callgraph. This option extends the perf report to show reference callgraphs, which collected by reference event, in no callgraph event.

--socket-filter
Only report the samples on the processor socket that match with this filter

--samples=N
Save N individual samples for each histogram entry to show context in perf report tui browser.

--raw-trace
When displaying traceevent output, do not use print fmt or plugins.

--hierarchy
Enable hierarchical output.

--inline
If a callgraph address belongs to an inlined function, the inline stack will be printed. Each entry is function name or file/line. Enabled by default, disable with --no-inline.

--mmaps
Show --tasks output plus mmap information in a format similar to /proc/&lt;PID&gt;/maps.

.if n \{.RS 4
.\}
    Please note that not all mmaps are stored, options affecting which ones
    are include perf record --data*(Aq, for instance.
.if n \{.RE
.\}

--ns
Show time stamps in nanoseconds.

--stats
Display overall events statistics without any further processing. (like the one at the end of the perf report -D command)

--tasks
Display monitored tasks stored in perf data. Displaying pid/tid/ppid plus the command string aligned to distinguish parent and child tasks.

--percent-type
Set annotation percent type from following choices: global-period, local-period, global-hits, local-hits

.if n \{.RS 4
.\}
    The local/global keywords set if the percentage is computed
    in the scope of the function (local) or the whole data (global).
    The period/hits keywords set the base the percentage is computed
    on - the samples period or the number of samples (hits).
.if n \{.RE
.\}

--time-quantum
Configure time quantum for time sort key. Default 100ms. Accepts s, us, ms, ns units.

--total-cycles
When --total-cycles is specified, it supports sorting for all blocks by
_Sampled Cycles%_. This is useful to concentrate on the globally hottest blocks. In output, there are some new columns:

.if n \{.RS 4
.\}
    Sampled Cycles%*(Aq - block sampled cycles aggregation / total sampled cycles
    Sampled Cycles*(Aq  - block sampled cycles aggregation
    Avg Cycles%*(Aq     - block average sampled cycles / sum of total block average
                        sampled cycles
    Avg Cycles*(Aq      - block average sampled cycles
.if n \{.RE
.\}

<a name="overhead-calculation"></a>

# Overhead Calculation


The overhead can be shown in two columns as _Children_ and _Self_ when perf collects callchains. The _self_ overhead is simply calculated by adding all period values of the entry - usually a function (symbol). This is the value that perf shows traditionally and sum of all the _self_ overhead values should be 100%.

The _children_ overhead is calculated by adding all period values of the child functions so that it can show the total overhead of the higher level functions even if they don’t directly execute much. _Children_ here means functions that are called from another (parent) function.

It might be confusing that the sum of all the _children_ overhead values exceeds 100% since each of them is already an accumulation of _self_ overhead of its child functions. But with this enabled, users can find which function has the most overhead even if samples are spread over the children.

Consider the following example; there are three functions like below.

.if n \{.RS 4
.\}
    
    .ft C
    void foo(void) {
        /* do something */
    }
    
    void bar(void) {
        /* do something */
        foo();
    }
    
    int main(void) {
        bar()
        return 0;
    }
    .ft
    
.if n \{.RE
.\}

In this case _foo_ is a child of _bar_, and _bar_ is an immediate child of _main_ so _foo_ also is a child of _main_. In other words, _main_ is a parent of _foo_ and _bar_, and _bar_ is a parent of _foo_.

Suppose all samples are recorded in _foo_ and _bar_ only. When it’s recorded with callchains the output will show something like below in the usual (self-overhead-only) output of perf report:

.if n \{.RS 4
.\}
    
    .ft C
    Overhead  Symbol
    ........  .....................
      60.00%  foo
              |
              --- foo
                  bar
                  main
                  __libc_start_main
    
      40.00%  bar
              |
              --- bar
                  main
                  __libc_start_main
    .ft
    
.if n \{.RE
.\}

When the --children option is enabled, the _self_ overhead values of child functions (i.e. _foo_ and _bar_) are added to the parents to calculate the _children_ overhead. In this case the report could be displayed as:

.if n \{.RS 4
.\}
    
    .ft C
    Children      Self  Symbol
    ........  ........  ....................
     100.00%     0.00%  __libc_start_main
              |
              --- __libc_start_main
    
     100.00%     0.00%  main
              |
              --- main
                  __libc_start_main
    
     100.00%    40.00%  bar
              |
              --- bar
                  main
                  __libc_start_main
    
      60.00%    60.00%  foo
              |
              --- foo
                  bar
                  main
                  __libc_start_main
    .ft
    
.if n \{.RE
.\}

In the above output, the _self_ overhead of _foo_ (60%) was add to the _children_ overhead of _bar_, _main_ and _\_\_libc\_start\_main_. Likewise, the _self_ overhead of _bar_ (40%) was added to the _children_ overhead of _main_ and _\e\_\e\_libc\_start\_main_.

So _\e\_\e\_libc\_start\_main_ and _main_ are shown first since they have same (100%) _children_ overhead (even though they have zero _self_ overhead) and they are the parents of _foo_ and _bar_.

Since v3.16 the _children_ overhead is shown by default and the output is sorted by its values. The _children_ overhead is disabled by specifying --no-children option on the command line or by adding _report.children = false_ or _top.children = false_ in the perf config file.

<a name="see-also"></a>

# See Also


**perf-stat**(1), **perf-annotate**(1), **perf-record**(1)
