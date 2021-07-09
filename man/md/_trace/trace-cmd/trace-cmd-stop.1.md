# trace\-cmd\-stop(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-stop - stop the Ftrace Linux kernel tracer from writing to the ring buffer.

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd stop [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) stop is a complement to _trace-cmd-start(1)_. This will disable Ftrace from writing to the ring buffer. This does not stop the overhead that the tracing may incur. Only the updating of the ring buffer is disabled, the Ftrace tracing may still be inducing overhead.

After stopping the trace, the _trace-cmd-extract(1)_ may strip out the data from the ring buffer and create a trace.dat file. The Ftrace pseudo file system may also be examined.

To disable the tracing completely to remove the overhead it causes, use _trace-cmd-reset(1)_. But after a reset is performed, the data that has been recorded is lost.

<a name="options"></a>

# Options


**-B** _buffer-name_
If the kernel supports multiple buffers, this will stop the trace for only the given buffer. It does not affect any other buffer. This may be used multiple times to specify different buffers. When this option is used, the top level instance will not be stopped unless
**-t**
is given.

**-a**
Stop the trace for all existing buffer instances. When this option is used, the top level instance will not be stopped unless
**-t**
is given.

**-t**
Stops the top level instance buffer. Without the
**-B**
or
**-a**
option this is the same as the default. But if
**-B**
or
**-a**
is used, this is required if the top level instance buffer should also be stopped.

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
