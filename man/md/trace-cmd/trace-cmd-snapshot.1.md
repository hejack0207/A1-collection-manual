# trace\-cmd\-snapshot(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-snapshot - take, reset, free, or show a Ftrace kernel snapshot

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd snapshot [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) snapshot controls or displays the Ftrace Linux kernel snapshot feature (if the kernel supports it). This is useful to "freeze" an instance of a live trace but without stopping the trace.

.if n \{.RS 4
.\}
     trace-cmd start -p function
     trace-cmd snapshot -s
     trace-cmd snapshot
    [ dumps the content of buffer at trace-cmd snapshot -s*(Aq ]
     trace-cmd snapshot -s
     trace-cmd snapshot
    [ dumps the new content of the buffer at the last -s operation ]
.if n \{.RE
.\}

<a name="options"></a>

# Options


**-s**
Take a snapshot of the currently running buffer.

**-r**
Clear out the buffer.

**-f**
Free the snapshot buffer. The buffer takes up memory inside the kernel. It is best to free it when not in use. The first -s operation will allocate it if it is not already allocated.

**-c** _cpu_
Operate on a per cpu snapshot (may not be fully supported by all kernels)

**-B** _buf_
If a buffer instance was created, then the
**-B**
option will operate on the snapshot within the buffer.

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
