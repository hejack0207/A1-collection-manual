# perf\-inject(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-inject - Filter to augment the events stream with additional information

<a name="synopsis"></a>

# Synopsis

```


```
    perf inject <options>

<a name="description"></a>

# Description


perf-inject reads a perf-record event stream and repipes it to stdout. At any point the processing code can inject other events into the event stream - in this case build-ids (-b option) are read and injected as needed into the event stream.

Build-ids are just the first user of perf-inject - potentially anything that needs userspace processing to augment the events stream with additional information could make use of this facility.

<a name="options"></a>

# Options


-b, --build-ids=
Inject build-ids into the output stream

-v, --verbose
Be more verbose.

-i, --input=
Input file name. (default: stdin)

-o, --output=
Output file name. (default: stdout)

-s, --sched-stat
Merge sched_stat and sched_switch for getting events where and how long tasks slept. sched_switch contains a callchain where a task slept and sched_stat contains a timeslice how long a task slept.

--kallsyms=&lt;file&gt;
kallsyms pathname

--itrace
Decode Instruction Tracing data, replacing it with synthesized events. Options are:

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

--strip
Use with --itrace to strip out non-synthesized events.

-j, --jit
Process jitdump files by injecting the mmap records corresponding to jitted functions. This option also generates the ELF images for each jitted function found in the jitdumps files captured in the input perf.data file. Use this option if you are monitoring environment using JIT runtimes, such as Java, DART or V8.

-f, --force
Don’t complain, do it.

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-report**(1), **perf-archive**(1)
