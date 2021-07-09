# trace\-cmd\-extract(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-extract - extract out the data from the Ftrace Linux tracer.

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd extract [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) extract is usually used after _trace-cmd-start(1)_ and _trace-cmd-stop(1)_. It can be used after the Ftrace tracer has been started manually through the Ftrace pseudo file system.

The extract command creates a trace.dat file that can be used by _trace-cmd-report(1)_ to read from. It reads the kernel internal ring buffer to produce the trace.dat file.

<a name="options"></a>

# Options


**-p** _plugin_
Although
**extract**
does not start any traces, some of the plugins require just reading the output in ASCII format. These are the latency tracers, since the latency tracers have a separate internal buffer. The plugin option is therefore only necessary for the
_wakeup_,
_wakeup-rt_,
_irqsoff_,
_preemptoff_
and
_preemptirqsoff_
plugins.

.if n \{.RS 4
.\}
    With out this option, the extract command will extract from the internal
    Ftrace buffers.
.if n \{.RE
.\}

**-O** _option_
If a latency tracer is being extracted, and the
**-p**
option is used, then there are some Ftrace options that can change the format. This will update those options before extracting. To see the list of options see
_trace-cmd-list_. To enable an option, write its name, to disable the option append the characters
_no_
to it. For example:
_noprint-parent_
will disable the
_print-parent_
option that prints the parent function in printing a function event.

**-o** _outputfile_
By default, the extract command will create a
_trace.dat_
file. This option will change where the file is written to.

**-s**
Extract from the snapshot buffer (if the kernel supports it).

**--date**
This is the same as the trace-cmd-record(1) --date option, but it does cause the extract routine to disable all tracing. That is, the end of the extract will perform something similar to trace-cmd-reset(1).

**-B** _buffer-name_
If the kernel supports multiple buffers, this will extract the trace for only the given buffer. It does not affect any other buffer. This may be used multiple times to specify different buffers. When this option is used, the top level instance will not be extracted unless
**-t**
is given.

**-a**
Extract all existing buffer instances. When this option is used, the top level instance will not be extracted unless
**-t**
is given.

**-t**
Extracts the top level instance buffer. Without the
**-B**
or
**-a**
option this is the same as the default. But if
**-B**
or
**-a**
is used, this is required if the top level instance buffer should also be extracted.

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1)

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
