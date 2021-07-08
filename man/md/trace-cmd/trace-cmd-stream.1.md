# trace\-cmd\-stream(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-stream - stream a trace to stdout as it is happening

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd stream [OPTIONS] [command]
```

<a name="description"></a>

# Description


The trace-cmd(1) stream will start tracing just like trace-cmd-record(1), except it will not record to a file and instead it will read the binary buffer as it is happening, convert it to a human readable format and write it to stdout.

This is basically the same as trace-cmd-start(1) and then doing a trace-cmd-show(1) with the **-p** option. trace-cmd-stream is not as efficient as reading from the pipe file as most of the stream work is done in userspace. This is useful if it is needed to do the work mostly in userspace instead of the kernel, and stream also helps to debug trace-cmd-profile(1) which uses the stream code to perform the live data analysis for the profile.

<a name="options"></a>

# Options


.if n \{.RS 4
.\}
    These are the same as trace-cmd-record(1), except that it does not take
    the *-o* option.
.if n \{.RE
.\}

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


Copyright (C) 2014 Red Hat, Inc. Free use of this software is granted under the terms of the GNU Public License (GPL).

<a name="notes"></a>

# Notes


*  1.  
  rostedt@goodmis.org
      mailto:rostedt@goodmis.org
