# trace\-cmd\-stat(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-stat - show the status of the tracing (ftrace) system

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd stat
```

<a name="description"></a>

# Description


The trace-cmd(1) stat displays the various status of the tracing (ftrace) system. The status that it shows is:

**Tracer:** if one of the tracers (like function_graph) is active. Otherwise nothing is displayed.

**Events:** Lists the events that are enable.

**Event filters:** Shows any filters that are set for any events

**Function filters:** Shows any filters for the function tracers

**Graph functions:** Shows any functions that the function graph tracer should graph

**Buffers:** Shows the trace buffer size if they have been expanded. By default, tracing buffers are in a compressed format until they are used. If they are compressed, the buffer display will not be shown.

**Trace clock:** If the tracing clock is anything other than the default "local" it will be displayed.

**Trace CPU mask:** If not all available CPUs are in the tracing CPU mask, then the tracing CPU mask will be displayed.

**Trace max latency:** Shows the value of the trace max latency if it is other than zero.

**Kprobes:** Shows any kprobes that are defined for tracing.

**Uprobes:** Shows any uprobes that are defined for tracing.

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-listen(1)

<a name="author"></a>

# Author


Written by Steven Rostedt, &lt;\m[blue]**[rostedt@goodmis.org](mailto:rostedt@goodmis.org)**\m[]\s-2\u[1]\d\s+2&gt;

<a name="resources"></a>

# Resources


git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git

<a name="copying"></a>

# Copying


Copyright (C) 2014 Red Hat, Inc. Free use of this software is granted under the terms of the GNU Public License (GPL).

<a name="notes"></a>

# Notes


*  1.  
  rostedt@goodmis.org
      mailto:rostedt@goodmis.org
