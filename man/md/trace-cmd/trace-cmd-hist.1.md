# trace\-cmd\-hist(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-hist - show histogram of events in trace.dat file

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd hist [OPTIONS][input-file]
```

<a name="description"></a>

# Description


The trace-cmd(1) hist displays a histogram form from the trace.dat file. Instead of showing the events as they were ordered, it creates a histogram that can be displayed per task or for all tasks where the most common events appear first. It uses the function tracer and call stacks that it finds to try to put together a call graph of the events.

<a name="options"></a>

# Options


**-i** _input-file_
By default, trace-cmd hist will read the file
_trace.dat_. But the
**-i**
option open up the given
_input-file_
instead. Note, the input file may also be specified as the last item on the command line.

**-P**
To compact all events and show the call graphs by ignoring tasks and different PIDs, add the
**-P**
to do so. Instead of showing the task name, it will group all chains together and show "&lt;all pids&gt;".

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


Copyright (C) 2010 Red Hat, Inc. Free use of this software is granted under the terms of the GNU Public License (GPL).

<a name="notes"></a>

# Notes


*  1.  
  rostedt@goodmis.org
      mailto:rostedt@goodmis.org
