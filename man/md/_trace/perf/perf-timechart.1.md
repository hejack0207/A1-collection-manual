# perf\-timechart(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-timechart - Tool to visualize total system behavior during a workload

<a name="synopsis"></a>

# Synopsis

```


```

<a name="description"></a>

# Description


There are two variants of perf timechart:

.if n \{.RS 4
.\}
    perf timechart record <command>*(Aq to record the system level events
    of an arbitrary workload. By default timechart records only scheduler
    and CPU events (task switches, running times, CPU power states, etc),
    but its possible to record IO (disk, network) activity using -I argument.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf timechart*(Aq to turn a trace into a Scalable Vector Graphics file,
    that can be viewed with popular SVG viewers such as Inkscape*(Aq. Depending
    on the events in the perf.data file, timechart will contain scheduler/cpu
    events or IO events.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    In IO mode, every bar has two charts: upper and lower.
    Upper bar shows incoming events (disk reads, ingress network packets).
    Lower bar shows outgoing events (disk writes, egress network packets).
    There are also poll bars which show how much time application spent
    in poll/epoll/select syscalls.
.if n \{.RE
.\}

<a name="timechart-options"></a>

# Timechart Options


-o, --output=
Select the output file (default: output.svg)

-i, --input=
Select the input file (default: perf.data unless stdin is a fifo)

-w, --width=
Select the width of the SVG file (default: 1000)

-P, --power-only
Only output the CPU power section of the diagram

-T, --tasks-only
Don’t output processor state transitions

-p, --process
Select the processes to display, by name or PID

-f, --force
Don’t complain, do it.

--symfs=&lt;directory&gt;
Look for files with symbols relative to this directory.

-n, --proc-num
Print task info for at least given number of tasks.

-t, --topology
Sort CPUs according to topology.

--highlight=&lt;duration_nsecs|task_name&gt;
Highlight tasks (using different color) that run more than given duration or tasks with given name. If number is given it’s interpreted as number of nanoseconds. If non-numeric string is given it’s interpreted as task name.

--io-skip-eagain
Don’t draw EAGAIN IO events.

--io-min-time=&lt;nsecs&gt;
Draw small events as if they lasted min-time. Useful when you need to see very small and fast IO. It’s possible to specify ms or us suffix to specify time in milliseconds or microseconds. Default value is 1ms.

--io-merge-dist=&lt;nsecs&gt;
Merge events that are merge-dist nanoseconds apart. Reduces number of figures on the SVG and makes it more render-friendly. It’s possible to specify ms or us suffix to specify time in milliseconds or microseconds. Default value is 1us.

<a name="record-options"></a>

# Record Options


-P, --power-only
Record only power-related events

-T, --tasks-only
Record only tasks-related events

-I, --io-only
Record only io-related events

-g, --callchain
Do call-graph (stack chain/backtrace) recording

<a name="examples"></a>

# Examples


$ perf timechart record git pull

.if n \{.RS 4
.\}
    [ perf record: Woken up 13 times to write data ]
    [ perf record: Captured and wrote 4.253 MB perf.data (~185801 samples) ]
.if n \{.RE
.\}

$ perf timechart

.if n \{.RS 4
.\}
    Written 10.2 seconds of trace to output.svg.
.if n \{.RE
.\}

Record system-wide timechart:

.if n \{.RS 4
.\}
    $ perf timechart record
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    then generate timechart and highlight gcc*(Aq tasks:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    $ perf timechart --highlight gcc
.if n \{.RE
.\}

Record system-wide IO events:

.if n \{.RS 4
.\}
    $ perf timechart record -I
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    then generate timechart:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    $ perf timechart
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**perf-record**(1)
