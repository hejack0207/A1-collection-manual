# perf\-top(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-top - System profiling tool.

<a name="synopsis"></a>

# Synopsis

```


```
    perf top [-e <EVENT> | --event=EVENT] [<options>]

<a name="description"></a>

# Description


This command generates and displays a performance counter profile in real time.

<a name="options"></a>

# Options


-a, --all-cpus
System-wide collection. (default)

-c &lt;count&gt;, --count=&lt;count&gt;
Event period to sample.

-C &lt;cpu-list&gt;, --cpu=&lt;cpu&gt;
Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default is to monitor all CPUS.

-d &lt;seconds&gt;, --delay=&lt;seconds&gt;
Number of seconds to delay between refreshes.

-e &lt;event&gt;, --event=&lt;event&gt;
Select the PMU event. Selection can be a symbolic event name (use
_perf list_
to list all events) or a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a hexadecimal event descriptor.

-E &lt;entries&gt;, --entries=&lt;entries&gt;
Display this many functions.

-f &lt;count&gt;, --count-filter=&lt;count&gt;
Only display functions with more events than this.

--group
Put the counters into a counter group.

-F &lt;freq&gt;, --freq=&lt;freq&gt;
Profile at this frequency. Use
_max_
to use the currently maximum allowed frequency, i.e. the value in the kernel.perf_event_max_sample_rate sysctl.

-i, --inherit
Child tasks do not inherit counters.

-k &lt;path&gt;, --vmlinux=&lt;path&gt;
Path to vmlinux. Required for annotation functionality.

--ignore-vmlinux
Ignore vmlinux files.

--kallsyms=&lt;file&gt;
kallsyms pathname

-m &lt;pages&gt;, --mmap-pages=&lt;pages&gt;
Number of mmap data pages (must be a power of two) or size specification with appended unit character - B/K/M/G. The size is rounded up to have nearest pages power of two value.

-p &lt;pid&gt;, --pid=&lt;pid&gt;
Profile events on existing Process ID (comma separated list).

-t &lt;tid&gt;, --tid=&lt;tid&gt;
Profile events on existing thread ID (comma separated list).

-u, --uid=
Record events in threads owned by uid. Name or number.

-r &lt;priority&gt;, --realtime=&lt;priority&gt;
Collect data with this RT SCHED_FIFO priority.

--sym-annotate=&lt;symbol&gt;
Annotate this symbol.

-K, --hide_kernel_symbols
Hide kernel symbols.

-U, --hide_user_symbols
Hide user symbols.

--demangle-kernel
Demangle kernel symbols.

-D, --dump-symtab
Dump the symbol table used for profiling.

-v, --verbose
Be more verbose (show counter open errors, etc).

-z, --zero
Zero history across display updates.

-s, --sort
Sort by key(s): pid, comm, dso, symbol, parent, srcline, weight, local_weight, abort, in_tx, transaction, overhead, sample, period. Please see description of --sort in the perf-report man page.

--fields=
Specify output field - multiple keys can be specified in CSV format. Following fields are available: overhead, overhead_sys, overhead_us, overhead_children, sample and period. Also it can contain any sort key(s).

.if n \{.RS 4
.\}
    By default, every sort keys not specified in --field will be appended
    automatically.
.if n \{.RE
.\}

-n, --show-nr-samples
Show a column with the number of samples.

--show-total-period
Show a column with the sum of periods.

--dsos
Only consider symbols in these dsos. This option will affect the percentage of the overhead column. See --percentage for more info.

--comms
Only consider symbols in these comms. This option will affect the percentage of the overhead column. See --percentage for more info.

--symbols
Only consider these symbols. This option will affect the percentage of the overhead column. See --percentage for more info.

-M, --disassembler-style=
Set disassembler style for objdump.

--prefix=PREFIX, --prefix-strip=N
Remove first N entries from source file path names in executables and add PREFIX. This allows to display source code compiled on systems with different file system layout.

--source
Interleave source code with assembly code. Enabled by default, disable with --no-source.

--asm-raw
Show raw instruction encoding of assembly instructions.

-g
Enables call-graph (stack chain/backtrace) recording.

--call-graph [mode,type,min[,limit],order[,key][,branch]]
Setup and enable call-graph (stack chain/backtrace) recording, implies -g. See
--call-graph
section in perf-record and perf-report man pages for details.

--children
Accumulate callchain of children to parent entry so that then can show up in the output. The output will have a new "Children" column and will be sorted on the data. It requires -g/--call-graph option enabled. See the ‘overhead calculation’ section for more details. Enabled by default, disable with --no-children.

--max-stack
Set the stack depth limit when parsing the callchain, anything beyond the specified depth will be ignored. This is a trade-off between information loss and faster processing especially for workloads that can have a very long callchain stack.

.if n \{.RS 4
.\}
    Default: /proc/sys/kernel/perf_event_max_stack when present, 127 otherwise.
.if n \{.RE
.\}

--ignore-callees=&lt;regex&gt;
Ignore callees of the function(s) matching the given regex. This has the effect of collecting the callers of each such function into one place in the call-graph tree.

--percent-limit
Do not show entries which have an overhead under that percent. (Default: 0).

--percentage
Determine how to display the overhead percentage of filtered entries. Filters can be applied by --comms, --dsos and/or --symbols options and Zoom operations on the TUI (thread, dso, etc).

.if n \{.RS 4
.\}
    "relative" means its relative to filtered entries only so that the
    sum of shown entries will be always 100%. "absolute" means it retains
    the original value before and after the filter is applied.
.if n \{.RE
.\}

-w, --column-widths=&lt;width[,width...]&gt;
Force each column width to the provided list, for large terminal readability. 0 means no limit (default behavior).

--proc-map-timeout
When processing pre-existing threads /proc/XXX/mmap, it may take a long time, because the file may be huge. A time out is needed in such cases. This option sets the time out limit. The default value is 500 ms.

-b, --branch-any
Enable taken branch stack sampling. Any type of taken branch may be sampled. This is a shortcut for --branch-filter any. See --branch-filter for more infos.

-j, --branch-filter
Enable taken branch stack sampling. Each sample captures a series of consecutive taken branches. The number of branches captured with each sample depends on the underlying hardware, the type of branches of interest, and the executed code. It is possible to select the types of branches captured by enabling filters. For a full list of modifiers please see the perf record manpage.

.if n \{.RS 4
.\}
    The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
    The privilege levels may be omitted, in which case, the privilege levels of the associated
    event are applied to the branch filter. Both kernel (k) and hypervisor (hv) privilege
    levels are subject to permissions.  When sampling on multiple events, branch stack sampling
    is enabled for all the sampling events. The sampled branch type is the same for all events.
    The various filters must be specified as a comma separated list: --branch-filter any_ret,u,k
    Note that this feature may not be available on all processors.
.if n \{.RE
.\}

--raw-trace
When displaying traceevent output, do not use print fmt or plugins.

--hierarchy
Enable hierarchy output.

--overwrite
Enable this to use just the most recent records, which helps in high core count machines such as Knights Landing/Mill, but right now is disabled by default as the pausing used in this technique is leading to loss of metadata events such as PERF_RECORD_MMAP which makes
_perf top_
unable to resolve samples, leading to lots of unknown samples appearing on the UI. Enable this if you are in such machines and profiling a workload that doesn’t creates short lived threads and/or doesn’t uses many executable mmap operations. Work is being planed to solve this situation, till then, this will remain disabled by default.

--force
Don’t do ownership validation.

--num-thread-synthesize
The number of threads to run when synthesizing events for existing processes. By default, the number of threads equals to the number of online CPUs.

--namespaces
Record events of type PERF_RECORD_NAMESPACES and display it with the
_cgroup\_id_
sort key.

--switch-on EVENT_NAME
Only consider events after this event is found.

.if n \{.RS 4
.\}
    E.g.:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Find out where broadcast packets are handled
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf probe -L icmp_rcv
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Insert a probe there:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf probe icmp_rcv:59
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Start perf top and ask it to only consider the cycles events when a
    broadcast packet arrives This will show a menu with two entries and
    will start counting when a broadcast packet arrives:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf top -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Alternatively one can ask for --group and then two overhead columns
    will appear, the first for cycles and the second for the switch-on event.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf top --group -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This may be interesting to measure a workload only after some initialization
    phase is over, i.e. insert a perf probe at that point and use the above
    examples replacing probe:icmp_rcv with the just-after-init probe.
.if n \{.RE
.\}

--switch-off EVENT_NAME
Stop considering events after this event is found.

--show-on-off-events
Show the --switch-on/off events too. This has no effect in
_perf top_
now but probably we’ll make the default not to show the switch-on/off events on the --group mode and if there is only one event besides the off/on ones, go straight to the histogram browser, just like
_perf top_
with no events explicitely specified does.

<a name="interactive-prompting-keys"></a>

# Interactive Prompting Keys


[d]
Display refresh delay.

[e]
Number of entries to display.

[E]
Event to display when multiple counters are active.

[f]
Profile display filter (&gt;= hit count).

[F]
Annotation display filter (&gt;= % of total).

[s]
Annotate symbol.

[S]
Stop annotation, return to full profile display.

[K]
Hide kernel symbols.

[U]
Hide user symbols.

[z]
Toggle event count zeroing across display updates.

[qQ]
Quit.

Pressing any unmapped key displays a menu, and prompts for input.

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


**perf-stat**(1), **perf-list**(1), **perf-report**(1)
