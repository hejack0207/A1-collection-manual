# trace\-cmd\-show(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-show - show the contents of the Ftrace Linux kernel tracing buffer.

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd show [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) show displays the contents of one of the Ftrace Linux kernel tracing files: trace, snapshot, or trace_pipe. It is basically the equivalent of doing:

.if n \{.RS 4
.\}
    cat /sys/kernel/debug/tracing/trace
.if n \{.RE
.\}

<a name="options"></a>

# Options


**-p**
Instead of displaying the contents of the "trace" file, use the "trace_pipe" file. The difference between the two is that the "trace" file is static. That is, if tracing is stopped, the "trace" file will show the same contents each time.

.if n \{.RS 4
.\}
    The "trace_pipe" file is a consuming read, where a read of the file
    will consume the output of what was read and it will not read the
    same thing a second time even if tracing is stopped. This file
    als will block. If no data is available, trace-cmd show will stop
    and wait for data to appear.
.if n \{.RE
.\}

**-s**
Instead of reading the "trace" file, read the snapshot file. The snapshot is made by an application writing into it and the kernel will perform as swap between the currently active buffer and the current snapshot buffer. If no more swaps are made, the snapshot will remain static. This is not a consuming read.

**-c** _cpu_
Read only the trace file for a specified CPU.

**-f**
Display the full path name of the file that is being displayed.

**-B** _buf_
If a buffer instance was created, then the
**-B**
option will access the files associated with the given buffer.

**--tracing\_on**
Show if tracing is on for the given instance.

**--current\_tracer**
Show what the current tracer is.

**--buffer\_size**
Show the current buffer size (per-cpu)

**--buffer\_total\_size**
Show the total size of all buffers.

**--ftrace\_filter**
Show what function filters are set.

**--ftrace\_notrace**
Show what function disabled filters are set.

**--ftrace\_pid**
Show the PIDs the function tracer is limited to (if any).

**--graph\_function**
Show the functions that will be graphed.

**--graph\_notrace**
Show the functions that will not be graphed.

**--cpumask**
Show the mask of CPUs that tracing will trace.

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1)

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
