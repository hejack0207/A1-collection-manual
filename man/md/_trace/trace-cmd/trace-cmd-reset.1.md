# trace\-cmd\-reset(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-reset - turn off all Ftrace tracing to bring back full performance

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd reset [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) reset command turns off all tracing of Ftrace. This will bring back the performance of the system before tracing was enabled. This is necessary since _trace-cmd-record(1)_, _trace-cmd-stop(1)_ and _trace-cmd-extract(1)_ do not disable the tracer, event after the data has been pulled from the buffers. The rational is that the user may want to manually enable the tracer with the Ftrace pseudo file system, or examine other parts of Ftrace to see what trace-cmd did. After the reset command happens, the data in the ring buffer, and the options that were used are all lost.

<a name="options"></a>

# Options


Please note that the order that options are specified on the command line is significant. See EXAMPLES.

**-b** _buffer\_size_
When the kernel boots, the Ftrace ring buffer is of a minimal size (3 pages per CPU). The first time the tracer is used, the ring buffer size expands to what it was set for (default 1.4 Megs per CPU).

.if n \{.RS 4
.\}
    If no more tracing is to be done, this option allows you to shrink the
    ring buffer down to free up available memory.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    trace-cmd reset -b 1
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The buffer instance affected is the one (or ones) specified by the most
    recently preceding *-B*, *-t*, or *-a* option:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    When used after *-B*, resizes the buffer instance that precedes it on
    the command line.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    When used after *-a*, resizes all buffer instances except the top one.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    When used after *-t* or before any *-B* or *-a*, resizes the top
    instance.
.if n \{.RE
.\}

**-B** _buffer-name_
If the kernel supports multiple buffers, this will reset the trace for only the given buffer. It does not affect any other buffer. This may be used multiple times to specify different buffers. The top level buffer will not be reset if this option is given (unless the
**-t**
option is also supplied).

**-a**
Reset the trace for all existing buffer instances. When this option is used, the top level instance will not be reset unless
**-t**
is given.

**-d**
This option deletes the instance buffer(s) specified by the most recently preceding
**-B**
or
**-a**
option. Because the top-level instance buffer cannot be deleted, it is invalid to use this immediatly following
**-t**
or prior to any
**-B**
or
**-a**
option on the command line.

**-t**
Resets the top level instance buffer. Without the
**-B**
or
**-a**
option this is the same as the default. But if
**-B**
or
**-a**
is used, this is required if the top level instance buffer should also be reset.

<a name="examples"></a>

# Examples


Reset tracing for instance-one and set its per-cpu buffer size to 4096kb. Also deletes instance-two. The top level instance and any other instances remain unaffected:

.if n \{.RS 4
.\}
    trace-cmd reset -B instance-one -b 4096 -B instance-two -d
.if n \{.RE
.\}

Delete all instance buffers. Top level instance remains unaffected:

.if n \{.RS 4
.\}
    trace-cmd reset -a -d
.if n \{.RE
.\}

Delete all instance buffers and also reset the top instance:

.if n \{.RS 4
.\}
    trace-cmd reset -t -a -d
.if n \{.RE
.\}

Invalid. This command implies an attempt to delete the top instance:

.if n \{.RS 4
.\}
    trace-cmd reset -a -t -d
.if n \{.RE
.\}

Reset the top instance and set its per-cpu buffer size to 1024kb. If any instance buffers exist, they will be unaffected:

.if n \{.RS 4
.\}
    trace-cmd reset -b 1024
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1)

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
