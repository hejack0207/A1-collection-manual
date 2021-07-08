# trace\-cmd\-start(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-start - start the Ftrace Linux kernel tracer without recording

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd start [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) start enables all the Ftrace tracing the same way trace-cmd-record(1) does. The difference is that it does not run threads to create a trace.dat file. This is useful just to enable Ftrace and you are only interested in the trace after some event has occurred and the trace is stopped. Then the trace can be read straight from the Ftrace pseudo file system or can be extracted with trace-cmd-extract(1).

<a name="options"></a>

# Options


The options are the same as _trace-cmd-record(1)_, except that it does not take options specific to recording (**-s**, **-o**, **-F**, **-N**, and **-t**).

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1)

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
