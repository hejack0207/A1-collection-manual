# trace\-cmd\-record(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-record - record a trace from the Ftrace Linux internal tracer

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd record [OPTIONS] [command]
```

<a name="description"></a>

# Description


The trace-cmd(1) record command will set up the Ftrace Linux kernel tracer to record the specified plugins or events that happen while the _command_ executes. If no command is given, then it will record until the user hits Ctrl-C.

The record command of trace-cmd will set up the Ftrace tracer to start tracing the various events or plugins that are given on the command line. It will then create a number of tracing processes (one per CPU) that will start recording from the kernel ring buffer straight into temporary files. When the command is complete (or Ctrl-C is hit) all the files will be combined into a trace.dat file that can later be read (see trace-cmd-report(1)).

<a name="options"></a>

# Options


**-p** _tracer_
Specify a tracer. Tracers usually do more than just trace an event. Common tracers are:
**function**,
**function\_graph**,
**preemptirqsoff**,
**irqsoff**,
**preemptoff**
and
**wakeup**. A tracer must be supported by the running kernel. To see a list of available tracers, see trace-cmd-list(1).

**-e** _event_
Specify an event to trace. Various static trace points have been added to the Linux kernel. They are grouped by subsystem where you can enable all events of a given subsystem or specify specific events to be enabled. The
_event_
is of the format "subsystem:event-name". You can also just specify the subsystem without the
_:event-name_
or the event-name without the "subsystem:". Using "-e sched_switch" will enable the "sched_switch" event where as, "-e sched" will enable all events under the "sched" subsystem.

.if n \{.RS 4
.\}
    The event*(Aq can also contain glob expressions. That is, "*stat*" will
    select all events (or subsystems) that have the characters "stat" in their
    names.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The keyword all*(Aq can be used to enable all events.
.if n \{.RE
.\}

**-a**
Every event that is being recorded has its output format file saved in the output file to be able to display it later. But if other events are enabled in the trace without trace-cmd’s knowledge, the formats of those events will not be recorded and trace-cmd report will not be able to display them. If this is the case, then specify the
**-a**
option and the format for all events in the system will be saved.

**-T**
Enable a stacktrace on each event. For example:

.if n \{.RS 4
.\}
              <idle>-0     [003] 58549.289091: sched_switch:         kworker/0:1:0 [120] R ==> trace-cmd:2603 [120]
              <idle>-0     [003] 58549.289092: kernel_stack:         <stack trace>
    => schedule (ffffffff814b260e)
    => cpu_idle (ffffffff8100a38c)
    => start_secondary (ffffffff814ab828)
.if n \{.RE
.\}

**--func-stack**
Enable a stack trace on all functions. Note this is only applicable for the "function" plugin tracer, and will only take effect if the -l option is used and succeeds in limiting functions. If the function tracer is not filtered, and the stack trace is enabled, you can live lock the machine.

**-f** _filter_
Specify a filter for the previous event. This must come after a
**-e**. This will filter what events get recorded based on the content of the event. Filtering is passed to the kernel directly so what filtering is allowed may depend on what version of the kernel you have. Basically, it will let you use C notation to check if an event should be processed or not.

.if n \{.RS 4
.\}
        ==, >=, <=, >, <, &, |, && and ||
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The above are usually safe to use to compare fields.
.if n \{.RE
.\}

**-R** _trigger_
Specify a trigger for the previous event. This must come after a
**-e**. This will add a given trigger to the given event. To only enable the trigger and not the event itself, then place the event after the
**-v**
option.

.if n \{.RS 4
.\}
    See Documentation/trace/events.txt in the Linux kernel source for more
    information on triggers.
.if n \{.RE
.\}

**-v**
This will cause all events specified after it on the command line to not be traced. This is useful for selecting a subsystem to be traced but to leave out various events. For Example: "-e sched -v -e "*stat\e*"" will enable all events in the sched subsystem except those that have "stat" in their names.

.if n \{.RS 4
.\}
    Note: the *-v* option was taken from the way grep(1) inverts the following
    matches.
.if n \{.RE
.\}

**-F**
This will filter only the executable that is given on the command line. If no command is given, then it will filter itself (pretty pointless). Using
**-F**
will let you trace only events that are caused by the given command.

**-P** _pid_
Similar to
**-F**
but lets you specify a process ID to trace.

**-c**
Used with either
**-F**
(or
**-P**
if kernel supports it) to trace the process children too.

**-C** _clock_
Set the trace clock to "clock".

.if n \{.RS 4
.\}
    Use trace-cmd(1) list -C to see what clocks are available.
.if n \{.RE
.\}

**-o** _output-file_
By default, trace-cmd report will create a
_trace.dat_
file. You can specify a different file to write to with the
**-o**
option.

**-l** _function-name_
This will limit the
_function_
and
_function\_graph_
tracers to only trace the given function name. More than one
**-l**
may be specified on the command line to trace more than one function. The limited use of glob expressions are also allowed. These are
_match*_
to only filter functions that start with
_match_.
_*match_
to only filter functions that end with
_match_.
_*match\e*_
to only filter on functions that contain
_match_.

**-g** _function-name_
This option is for the function_graph plugin. It will graph the given function. That is, it will only trace the function and all functions that it calls. You can have more than one
**-g**
on the command line.

**-n** _function-name_
This has the opposite effect of
**-l**. The function given with the
**-n**
option will not be traced. This takes precedence, that is, if you include the same function for both
**-n**
and
**-l**, it will not be traced.

**-d**
Some tracer plugins enable the function tracer by default. Like the latency tracers. This option prevents the function tracer from being enabled at start up.

**-D**
The option
**-d**
will try to use the function-trace option to disable the function tracer (if available), otherwise it defaults to the proc file: /proc/sys/kernel/ftrace_enabled, but will not touch it if the function-trace option is available. The
**-D**
option will disable both the ftrace_enabled proc file as well as the function-trace option if it exists.

.if n \{.RS 4
.\}
    Note, this disable function tracing for all users, which includes users
    outside of ftrace tracers (stack_tracer, perf, etc).
.if n \{.RE
.\}

**-O** _option_
Ftrace has various options that can be enabled or disabled. This allows you to set them. Appending the text
_no_
to an option disables it. For example: "-O nograph-time" will disable the "graph-time" Ftrace option.

**-s** _interval_
The processes that trace-cmd creates to record from the ring buffer need to wake up to do the recording. Setting the
_interval_
to zero will cause the processes to wakeup every time new data is written into the buffer. But since Ftrace is recording kernel activity, the act of this processes going back to sleep may cause new events into the ring buffer which will wake the process back up. This will needlessly add extra data into the ring buffer.

.if n \{.RS 4
.\}
    The interval*(Aq metric is microseconds. The default is set to 1000 (1 ms).
    This is the time each recording process will sleep before waking up to
    record any new data that was written to the ring buffer.
.if n \{.RE
.\}

**-r** _priority_
The priority to run the capture threads at. In a busy system the trace capturing threads may be staved and events can be lost. This increases the priority of those threads to the real time (FIFO) priority. But use this option with care, it can also change the behaviour of the system being traced.

**-b** _size_
This sets the ring buffer size to
_size_
kilobytes. Because the Ftrace ring buffer is per CPU, this size is the size of each per CPU ring buffer inside the kernel. Using "-b 10000" on a machine with 4 CPUs will make Ftrace have a total buffer size of 40 Megs.

**-B** _buffer-name_
If the kernel supports multiple buffers, this will add a buffer with the given name. If the buffer name already exists, that buffer is just reset and will not be deleted at the end of record execution. If the buffer is created, it will be removed at the end of execution (unless the
**-k**
is set, or
_start_
command was used).

.if n \{.RS 4
.\}
    After a buffer name is stated, all events added after that will be
    associated with that buffer. If no buffer is specified, or an event
    is specified before a buffer name, it will be associated with the
    main (toplevel) buffer.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    trace-cmd record -e sched -B block -e block -B time -e timer sleep 1
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The above is will enable all sched events in the main buffer. It will
    then create a block*(Aq buffer instance and enable all block events within
    that buffer. A time*(Aq buffer instance is created and all timer events
    will be enabled for that event.
.if n \{.RE
.\}

**-m** _size_
The max size in kilobytes that a per cpu buffer should be. Note, due to rounding to page size, the number may not be totally correct. Also, this is performed by switching between two buffers that are half the given size thus the output may not be of the given size even if much more was written.

.if n \{.RS 4
.\}
    Use this to prevent running out of diskspace for long runs.
.if n \{.RE
.\}

**-M** _cpumask_
Set the cpumask for to trace. It only affects the last buffer instance given. If supplied before any buffer instance, then it affects the main buffer. The value supplied must be a hex number.

.if n \{.RS 4
.\}
    trace-cmd record -p function -M c -B events13 -e all -M 5
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If the -M is left out, then the mask stays the same. To enable all
    CPUs, pass in a value of -1*(Aq.
.if n \{.RE
.\}

**-k**
By default, when trace-cmd is finished tracing, it will reset the buffers and disable all the tracing that it enabled. This option keeps trace-cmd from disabling the tracer and reseting the buffer. This option is useful for debugging trace-cmd.

.if n \{.RS 4
.\}
    Note: usually trace-cmd will set the "tracing_on" file back to what it
    was before it was called. This option will leave that file set to zero.
.if n \{.RE
.\}

**-i**
By default, if an event is listed that trace-cmd does not find, it will exit with an error. This option will just ignore events that are listed on the command line but are not found on the system.

**-N** _host:port_
If another machine is running "trace-cmd listen", this option is used to have the data sent to that machine with UDP packets. Instead of writing to an output file, the data is sent off to a remote box. This is ideal for embedded machines with little storage, or having a single machine that will keep all the data in a single repository.

.if n \{.RS 4
.\}
    Note: This option is not supported with latency tracer plugins:
      wakeup, wakeup_rt, irqsoff, preemptoff and preemptirqsoff
.if n \{.RE
.\}

**-t**
This option is used with
**-N**, when there’s a need to send the live data with TCP packets instead of UDP. Although TCP is not nearly as fast as sending the UDP packets, but it may be needed if the network is not that reliable, the amount of data is not that intensive, and a guarantee is needed that all traced information is transfered successfully.

**-q** | **--quiet**
For use with recording an application. Suppresses normal output (except for errors) to allow only the application’s output to be displayed.

**--date**
With the
**--date**
option, "trace-cmd" will write timestamps into the trace buffer after it has finished recording. It will then map the timestamp to gettimeofday which will allow wall time output from the timestamps reading the created
_trace.dat_
file.

**--max-graph-depth** _depth_
Set the maximum depth the function_graph tracer will trace into a function. A value of one will only show where userspace enters the kernel but not any functions called in the kernel. The default is zero, which means no limit.

**--module** _module_
Filter a module’s name in function tracing. It is equivalent to adding
_:mod:module_
after all other functions being filtered. If no other function filter is listed, then all modules functions will be filtered in the filter.

.if n \{.RS 4
.\}
    --module snd*(Aq  is equivalent to  *(Aq-l :mod:snd*(Aq
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    --module snd -l "*jack*"*(Aq is equivalent to *(Aq-l "*jack*:mod:snd"*(Aq
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    --module snd -n "*"*(Aq is equivalent to *(Aq-n :mod:snd*(Aq
.if n \{.RE
.\}

**--profile**
With the
**--profile**
option, "trace-cmd" will enable tracing that can be used with trace-cmd-report(1) --profile option. If a tracer
**-p**
is not set, and function graph depth is supported by the kernel, then the function_graph tracer will be enabled with a depth of one (only show where userspace enters into the kernel). It will also enable various tracepoints with stack tracing such that the report can show where tasks have been blocked for the longest time.

.if n \{.RS 4
.\}
    See trace-cmd-profile(1) for more details and examples.
.if n \{.RE
.\}

**-H** _event-hooks_
Add custom event matching to connect any two events together. When not used with
**--profile**, it will save the parameter and this will be used by trace-cmd report --profile, too. That is:

.if n \{.RS 4
.\}
    trace-cmd record -H hrtimer_expire_entry,hrtimer/hrtimer_expire_exit,hrtimer,sp
    trace-cmd report --profile
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Will profile hrtimer_expire_entry and hrtimer_expire_ext times.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    See trace-cmd-profile(1) for format.
.if n \{.RE
.\}

**-S**
(for --profile only) Only enable the tracer or events speficied on the command line. With this option, the function_graph tracer is not enabled, nor are any events (like sched_switch), unless they are specifically specified on the command line (i.e. -p function -e sched_switch -e sched_wakeup)

**--ts-offset offset**
Add an offset for the timestamp in the trace.dat file. This will add a offset option into the trace.dat file such that a trace-cmd report will offset all the timestamps of the events by the given offset. The offset is in raw units. That is, if the event timestamps are in nanoseconds the offset will also be in nanoseconds even if the displayed units are in microseconds.

**--stderr**
Have output go to stderr instead of stdout, but the output of the command executed will not be changed. This is useful if you want to monitor the output of the command being executed, but not see the output from trace-cmd.

<a name="examples"></a>

# Examples


The basic way to trace all events:

.if n \{.RS 4
.\}
     # trace-cmd record -e all ls > /dev/null
     # trace-cmd report
           trace-cmd-13541 [003] 106260.693809: filemap_fault: address=0x128122 offset=0xce
           trace-cmd-13543 [001] 106260.693809: kmalloc: call_site=81128dd4 ptr=0xffff88003dd83800 bytes_req=768 bytes_alloc=1024 gfp_flags=GFP_KERNEL|GFP_ZERO
                  ls-13545 [002] 106260.693809: kfree: call_site=810a7abb ptr=0x0
                  ls-13545 [002] 106260.693818: sys_exit_write:       0x1
.if n \{.RE
.\}

To use the function tracer with sched switch tracing:

.if n \{.RS 4
.\}
     # trace-cmd record -p function -e sched_switch ls > /dev/null
     # trace-cmd report
                  ls-13587 [002] 106467.860310: function: hrtick_start_fair <-- pick_next_task_fair
                  ls-13587 [002] 106467.860313: sched_switch: prev_comm=trace-cmd prev_pid=13587 prev_prio=120 prev_state=R ==> next_comm=trace-cmd next_pid=13583 next_prio=120
           trace-cmd-13585 [001] 106467.860314: function: native_set_pte_at <-- __do_fault
           trace-cmd-13586 [003] 106467.860314: function:             up_read <-- do_page_fault
                  ls-13587 [002] 106467.860317: function:             __phys_addr <-- schedule
           trace-cmd-13585 [001] 106467.860318: function: _raw_spin_unlock <-- __do_fault
                  ls-13587 [002] 106467.860320: function: native_load_sp0 <-- __switch_to
           trace-cmd-13586 [003] 106467.860322: function: down_read_trylock <-- do_page_fault
.if n \{.RE
.\}

Here is a nice way to find what interrupts have the highest latency:

.if n \{.RS 4
.\}
     # trace-cmd record -p function_graph -e irq_handler_entry  -l do_IRQ sleep 10
     # trace-cmd report
              <idle>-0     [000] 157412.933969: funcgraph_entry:                  |  do_IRQ() {
              <idle>-0     [000] 157412.933974: irq_handler_entry:    irq=48 name=eth0
              <idle>-0     [000] 157412.934004: funcgraph_exit:       + 36.358 us |  }
              <idle>-0     [000] 157413.895004: funcgraph_entry:                  |  do_IRQ() {
              <idle>-0     [000] 157413.895011: irq_handler_entry:    irq=48 name=eth0
              <idle>-0     [000] 157413.895026: funcgraph_exit:                        + 24.014 us |  }
              <idle>-0     [000] 157415.891762: funcgraph_entry:                  |  do_IRQ() {
              <idle>-0     [000] 157415.891769: irq_handler_entry:    irq=48 name=eth0
              <idle>-0     [000] 157415.891784: funcgraph_exit:       + 22.928 us |  }
              <idle>-0     [000] 157415.934869: funcgraph_entry:                  |  do_IRQ() {
              <idle>-0     [000] 157415.934874: irq_handler_entry:    irq=48 name=eth0
              <idle>-0     [000] 157415.934906: funcgraph_exit:       + 37.512 us |  }
              <idle>-0     [000] 157417.888373: funcgraph_entry:                  |  do_IRQ() {
              <idle>-0     [000] 157417.888381: irq_handler_entry:    irq=48 name=eth0
              <idle>-0     [000] 157417.888398: funcgraph_exit:       + 25.943 us |  }
.if n \{.RE
.\}

An example of the profile:

.if n \{.RS 4
.\}
     # trace-cmd record --profile sleep 1
     # trace-cmd report --profile --comm sleep
    task: sleep-21611
      Event: sched_switch:R (1) Total: 99442 Avg: 99442 Max: 99442 Min:99442
         <stack> 1 total:99442 min:99442 max:99442 avg=99442
           => ftrace_raw_event_sched_switch (0xffffffff8105f812)
           => __schedule (0xffffffff8150810a)
           => preempt_schedule (0xffffffff8150842e)
           => ___preempt_schedule (0xffffffff81273354)
           => cpu_stop_queue_work (0xffffffff810b03c5)
           => stop_one_cpu (0xffffffff810b063b)
           => sched_exec (0xffffffff8106136d)
           => do_execve_common.isra.27 (0xffffffff81148c89)
           => do_execve (0xffffffff811490b0)
           => SyS_execve (0xffffffff811492c4)
           => return_to_handler (0xffffffff8150e3c8)
           => stub_execve (0xffffffff8150c699)
      Event: sched_switch:S (1) Total: 1000506680 Avg: 1000506680 Max: 1000506680 Min:1000506680
         <stack> 1 total:1000506680 min:1000506680 max:1000506680 avg=1000506680
           => ftrace_raw_event_sched_switch (0xffffffff8105f812)
           => __schedule (0xffffffff8150810a)
           => schedule (0xffffffff815084b8)
           => do_nanosleep (0xffffffff8150b22c)
           => hrtimer_nanosleep (0xffffffff8108d647)
           => SyS_nanosleep (0xffffffff8108d72c)
           => return_to_handler (0xffffffff8150e3c8)
           => tracesys_phase2 (0xffffffff8150c304)
      Event: sched_wakeup:21611 (1) Total: 30326 Avg: 30326 Max: 30326 Min:30326
         <stack> 1 total:30326 min:30326 max:30326 avg=30326
           => ftrace_raw_event_sched_wakeup_template (0xffffffff8105f653)
           => ttwu_do_wakeup (0xffffffff810606eb)
           => ttwu_do_activate.constprop.124 (0xffffffff810607c8)
           => try_to_wake_up (0xffffffff8106340a)
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1), trace-cmd-profile(1)

<a name="author"></a>

# Author


Written by Steven Rostedt, &lt;\m[blue]**[rostedt@goodmis.org](mailto:rostedt@goodmis.org)**\m[]\s-2\u[1]\d\s+2&gt;

<a name="resources"></a>

# Resources


git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git

<a name="copying"></a>

# Copying


Copyright (C) 2010 Red Hat, Inc. Free use of this software is granted under the terms of the GNU Public License (GPL).

<a name="notes"></a>

# Notes


*  1.  
  rostedt@goodmis.org
      mailto:rostedt@goodmis.org
