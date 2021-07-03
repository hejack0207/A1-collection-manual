# perf\-sched(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-sched - Tool to trace/measure scheduler properties (latencies)

<a name="synopsis"></a>

# Synopsis

```


```
    perf sched {record|latency|map|replay|script|timehist}

<a name="description"></a>

# Description


There are several variants of _perf sched_:

.if n \{.RS 4
.\}
    perf sched record <command>*(Aq to record the scheduling events
    of an arbitrary workload.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf sched latency*(Aq to report the per task scheduling latencies
    and other scheduling properties of the workload.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf sched script*(Aq to see a detailed trace of the workload that
     was recorded (aliased to perf script*(Aq for now).
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf sched replay*(Aq to simulate the workload that was recorded
    via perf sched record. (this is done by starting up mockup threads
    that mimic the workload based on the events in the trace. These
    threads can then replay the timings (CPU runtime and sleep patterns)
    of the workload as it occurred when it was recorded - and can repeat
    it a number of times, measuring its performance.)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf sched map*(Aq to print a textual context-switching outline of
    workload captured via perf sched record.  Columns stand for
    individual CPUs, and the two-letter shortcuts stand for tasks that
    are running on a CPU. A **(Aq denotes the CPU that had the event, and
    a dot signals an idle CPU.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf sched timehist*(Aq provides an analysis of scheduling events.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Example usage:
        perf sched record -- sleep 1
        perf sched timehist
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    By default it shows the individual schedule events, including the wait
    time (time between sched-out and next sched-in events for the task), the
    task scheduling delay (time between wakeup and actually running) and run
    time for the task:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
                time    cpu  task name             wait time  sch delay   run time
                             [tid/pid]                (msec)     (msec)     (msec)
      -------------- ------  --------------------  ---------  ---------  ---------
        79371.874569 [0011]  gcc[31949]                0.014      0.000      1.148
        79371.874591 [0010]  gcc[31951]                0.000      0.000      0.024
        79371.874603 [0010]  migration/10[59]          3.350      0.004      0.011
        79371.874604 [0011]  <idle>                    1.148      0.000      0.035
        79371.874723 [0005]  <idle>                    0.016      0.000      1.383
        79371.874746 [0005]  gcc[31949]                0.153      0.078      0.022
    ...
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Times are in msec.usec.
.if n \{.RE
.\}

<a name="options"></a>

# Options


-i, --input=&lt;file&gt;
Input file name. (default: perf.data unless stdin is a fifo)

-v, --verbose
Be more verbose. (show symbol address, etc)

-D, --dump-raw-trace=
Display verbose dump of the sched data.

-f, --force
Don’t complain, do it.

<a name="options-for-fiperf-sched-mapfr"></a>

# Options for \Fiperf Sched Map\Fr


--compact
Show only CPUs with activity. Helps visualizing on high core count systems.

--cpus
Show just entries with activities for the given CPUs.

--color-cpus
Highlight the given cpus.

--color-pids
Highlight the given pids.

<a name="options-for-fiperf-sched-timehistfr"></a>

# Options for \Fiperf Sched Timehist\Fr


-k, --vmlinux=&lt;file&gt;
vmlinux pathname

--kallsyms=&lt;file&gt;
kallsyms pathname

-g, --call-graph
Display call chains if present (default on).

--max-stack
Maximum number of functions to display in backtrace, default 5.

-C=, --cpu=
Only show events for the given CPU(s) (comma separated list).

-p=, --pid=
Only show events for given process ID (comma separated list).

-t=, --tid=
Only show events for given thread ID (comma separated list).

-s, --summary
Show only a summary of scheduling by thread with min, max, and average run times (in sec) and relative stddev.

-S, --with-summary
Show all scheduling events followed by a summary by thread with min, max, and average run times (in sec) and relative stddev.

--symfs=&lt;directory&gt;
Look for files with symbols relative to this directory.

-V, --cpu-visual
Show visual aid for sched switches by CPU:
_i_
marks idle time,
_s_
are scheduler events.

-w, --wakeups
Show wakeup events.

-M, --migrations
Show migration events.

-n, --next
Show next task.

-I, --idle-hist
Show idle-related events only.

--time
Only analyze samples within given time window: &lt;start&gt;,&lt;stop&gt;. Times have the format seconds.microseconds. If start is not given (i.e., time string is
_,x.y_) then analysis starts at the beginning of the file. If stop time is not given (i.e, time string is
_x.y,_) then analysis goes to end of file.

--state
Show task state when it switched out.

<a name="see-also"></a>

# See Also


**perf-record**(1)
