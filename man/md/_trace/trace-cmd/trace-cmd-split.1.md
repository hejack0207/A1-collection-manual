# trace\-cmd\-split(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-split - split a trace.dat file into smaller files

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd split [OPTIONS] [start-time [end-time]]
```

<a name="description"></a>

# Description


The trace-cmd(1) split is used to break up a trace.dat into small files. The _start-time_ specifies where the new file will start at. Using _trace-cmd-report(1)_ and copying the time stamp given at a particular event, can be used as input for either _start-time_ or _end-time_. The split will stop creating files when it reaches an event after _end-time_. If only the end-time is needed, use 0.0 as the start-time.

If start-time is left out, then the split will start at the beginning of the file. If end-time is left out, then split will continue to the end unless it meets one of the requirements specified by the options.

<a name="options"></a>

# Options


**-i** _file_
If this option is not specified, then the split command will look for the file named
_trace.dat_. This options will allow the reading of another file other than
_trace.dat_.

**-o** _file_
By default, the split command will use the input file name as a basis of where to write the split files. The output file will be the input file with an attached .#\e\*(Aq to the end: trace.dat.1, trace.dat.2, etc.

.if n \{.RS 4
.\}
    This option will change the name of the base file used.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    -o file  will create file.1, file.2, etc.
.if n \{.RE
.\}

**-s** _seconds_
This specifies how many seconds should be recorded before the new file should stop.

**-m** _milliseconds_
This specifies how many milliseconds should be recorded before the new file should stop.

**-u** _microseconds_
This specifies how many microseconds should be recorded before the new file should stop.

**-e** _events_
This specifies how many events should be recorded before the new file should stop.

**-p** _pages_
This specifies the number of pages that should be recorded before the new file should stop.

.if n \{.RS 4
.\}
    Note: only one of *-p*, *-e*, *-u*, *-m*, *-s* may be specified at a time.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If *-p* is specified, then *-c* is automatically set.
.if n \{.RE
.\}

**-r**
This option causes the break up to repeat until end-time is reached (or end of the input if end-time is not specified).

.if n \{.RS 4
.\}
    trace-cmd split -r -e 10000
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This will break up trace.dat into several smaller files, each with at most
    10,000 events in it.
.if n \{.RE
.\}

**-c**
This option causes the above break up to be per CPU.

.if n \{.RS 4
.\}
    trace-cmd split -c -p 10
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This will create a file that has 10 pages per each CPU from the input.
.if n \{.RE
.\}

**-C** _cpu_
This option will split for a single CPU. Only the cpu named will be extracted from the file.

.if n \{.RS 4
.\}
    trace-cmd split -C 1
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This will split out all the events for cpu 1 in the file.
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-list(1), trace-cmd-listen(1)

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
