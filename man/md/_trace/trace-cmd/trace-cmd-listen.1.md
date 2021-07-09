# trace\-cmd\-listen(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-listen - listen for incoming connection to record tracing.

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd listen -p port [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) listen sets up a port to listen to waiting for connections from other hosts that run _trace-cmd-record(1)_ with the **-N** option. When a connection is made, and the remote host sends data, it will create a file called _trace.HOST:PORT.dat_. Where HOST is the name of the remote host, and PORT is the port that the remote host used to connect with.

<a name="options"></a>

# Options


**-p** _port_
This option will specify the port to listen to.

**-D**
This options causes trace-cmd listen to go into a daemon mode and run in the background.

**-d** _dir_
This option specifies a directory to write the data files into.

**-o** _filename_
This option overrides the default
_trace_
in the
_trace.HOST:PORT.dat_
that is created when a remote host connects.

**-l** _filename_
This option writes the output messages to a log file instead of standard output.

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1)

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
