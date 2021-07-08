# trace\-cmd\-restore(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-restore - restore a failed trace record

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd restore [OPTIONS] [command] cpu-file [cpu-file ...]
```

<a name="description"></a>

# Description


The trace-cmd(1) restore command will restore a crashed trace-cmd-record(1) file. If for some reason a trace-cmd record fails, it will leave a the per-cpu data files and not create the final trace.dat file. The trace-cmd restore will append the files to create a working trace.dat file that can be read with trace-cmd-report(1).

When trace-cmd record runs, it spawns off a process per CPU and writes to a per cpu file usually called _trace.dat.cpuX_, where X represents the CPU number that it is tracing. If the -o option was used in the trace-cmd record, then the CPU data files will have that name instead of the _trace.dat_ name. If a unexpected crash occurs before the tracing is finished, then the per CPU files will still exist but there will not be any trace.dat file to read from. trace-cmd restore will allow you to create a trace.dat file with the existing data files.

<a name="options"></a>

# Options


**-c**
Create a partial trace.dat file from the machine, to be used with a full trace-cmd restore at another time. This option is useful for embedded devices. If a server contains the cpu files of a crashed trace-cmd record (or trace-cmd listen), trace-cmd restore can be executed on the embedded device with the -c option to get all the stored information of that embedded device. Then the file created could be copied to the server to run the trace-cmd restore there with the cpu files.

.if n \{.RS 4
.\}
    If *-o* is not specified, then the file created will be called
    trace-partial.dat*(Aq. This is because the file is not a full version
    of something that trace-cmd-report(1) could use.
.if n \{.RE
.\}

**-t** tracing_dir
Used with
**-c**, it overrides the location to read the events from. By default, tracing information is read from the debugfs/tracing directory.
**-t**
will use that location instead. This can be useful if the trace.dat file to create is from another machine. Just tar -cvf events.tar debugfs/tracing and copy and untar that file locally, and use that directory instead.

**-k** kallsyms
Used with
**-c**, it overrides where to read the kallsyms file from. By default, /proc/kallsyms is used.
**-k**
will override the file to read the kallsyms from. This can be useful if the trace.dat file to create is from another machine. Just copy the /proc/kallsyms file locally, and use
**-k**
to point to that file.

**-o** output
By default, trace-cmd restore will create a
_trace.dat_
file (or
_trace-partial.dat_
if
**-c**
is specified). You can specify a different file to write to with the
**-o**
option.

**-i** input
By default, trace-cmd restore will read the information of the current system to create the initial data stored in the
_trace.dat_
file. If the crash was on another machine, then that machine should have the trace-cmd restore run with the
**-c**
option to create the trace.dat partial file. Then that file can be copied to the current machine where trace-cmd restore will use
**-i**
to load that file instead of reading from the current system.

<a name="examples"></a>

# Examples


If a crash happened on another box, you could run:

.if n \{.RS 4
.\}
    $ trace-cmd restore -c -o box-partial.dat
.if n \{.RE
.\}

Then on the server that has the cpu files:

.if n \{.RS 4
.\}
    $ trace-cmd restore -i box-partial.dat trace.dat.cpu0 trace.dat.cpu1
.if n \{.RE
.\}

This would create a trace.dat file for the embedded box.

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1)

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
