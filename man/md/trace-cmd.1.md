# trace\-cmd(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd - interacts with Ftrace Linux kernel internal tracer

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd COMMAND [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) command interacts with the Ftrace tracer that is built inside the Linux kernel. It interfaces with the Ftrace specific files found in the debugfs file system under the tracing directory. A _COMMAND_ must be specified to tell trace-cmd what to do.

<a name="commands"></a>

# Commands


.if n \{.RS 4
.\}
    record  - record a live trace and write a trace.dat file to the
              local disk or to the network.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    report  - reads a trace.dat file and converts the binary data to a
              ASCII text readable format.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    hist    - show a histogram of the events.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    stat    - show tracing (ftrace) status of the running system
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    options - list the plugin options that are available to *report*
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    start   - start the tracing without recording to a trace.dat file.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    stop    - stop tracing (only disables recording, overhead of tracer
              is still in effect)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    restart - restart tracing from a previous stop (only effects recording)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    extract - extract the data from the kernel buffer and create a trace.dat
              file.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    reset   - disables all tracing and gives back the system performance.
              (clears all data from the kernel buffers)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    split   - splits a trace.dat file into smaller files.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    list    - list the available plugins or events that can be recorded.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    listen  - open up a port to listen for remote tracing connections.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    restore - restore the data files of a crashed run of trace-cmd record
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    stack   - run and display the stack tracer
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    check-events - parse format strings for all trace events and return
                   whether all formats are parseable
.if n \{.RE
.\}

<a name="options"></a>

# Options


**-h**, --help
Display the help text.

Other options see the man page for the corresponding command.

<a name="see-also"></a>

# See Also


trace-cmd-record(1), trace-cmd-report(1), trace-cmd-hist(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-restore(1), trace-cmd-stack(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1), trace-cmd.dat(5), trace-cmd-check-events(1) trace-cmd-stat(1)

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
