# trace\-cmd\&.dat(5)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd.dat - trace-cmd file format

<a name="description"></a>

# Description


The trace-cmd(1) utility produces a "trace.dat" file. The file may also be named anything depending if the user specifies a different output name, but it must have a certain binary format. The file is used by trace-cmd to save kernel traces into it and be able to extract the trace from it at a later point (see **trace-cmd-report(1)**).

<a name="initial-format"></a>

# Initial Format


.if n \{.RS 4
.\}
    The first three bytes contain the magic value:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    0x17 0x08  0x44
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 7 bytes contain the characters:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "tracing"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next set of characters contain a null e0*(Aq terminated string
    that contains the version of the file (for example):
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "6e0"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 1 byte contains the flags for the file endianess:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    0 = little endian
    1 = big endian
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next byte contains the number of bytes per "long" value:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    4 - 32-bit long values
    8 - 64-bit long values
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Note: This is the long size of the targets userspace. Not the
    kernel space size.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [ Now all numbers are written in file defined endianess. ]
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 4 bytes are a 32-bit word that defines what the traced
    host machine page size was.
.if n \{.RE
.\}

<a name="header-info-format"></a>

# Header Info Format


.if n \{.RS 4
.\}
    Directly after the initial format comes information about the
    trace headers recorded from the target box.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 12 bytes contain the string:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "header_pagee0"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 8 bytes are a 64-bit word containing the size of the
    page header information stored next.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next set of data is of the size read from the previous 8 bytes,
    and contains the data retrieved from debugfs/tracing/events/header_page.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Note: The size of the second field efBcommitefR contains the target
    kernel long size. For example:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    field: local_t commit;        offset:8;       efBsize:8;efR   signed:1;
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    shows the kernel has a 64-bit long.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 13 bytes contain the string:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "header_evente0"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 8 bytes are a 64-bit word containing the size of the
    event header information stored next.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next set of data is of the size read from the previous 8 bytes
    and contains the data retrieved from debugfs/tracing/events/header_event.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This data allows the trace-cmd tool to know if the ring buffer format
    of the kernel made any changes.
.if n \{.RE
.\}

<a name="ftrace-event-formats"></a>

# Ftrace Event Formats


.if n \{.RS 4
.\}
    Directly after the header information comes the information about
    the Ftrace specific events. These are the events used by the Ftrace plugins
    and are not enabled by the event tracing.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 4 bytes contain a 32-bit word of the number of Ftrace event
    format files that are stored in the file.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    For the number of times defined by the previous 4 bytes is the
    following:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    8 bytes for the size of the Ftrace event format file.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The Ftrace event format file copied from the target machine:
    debugfs/tracing/events/ftrace/<event>/format
.if n \{.RE
.\}

<a name="event-formats"></a>

# Event Formats


.if n \{.RS 4
.\}
    Directly after the Ftrace formats comes the information about
    the event layout.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 4 bytes are a 32-bit word containing the number of
    event systems that are stored in the file. These are the
    directories in debugfs/tracing/events excluding the efBftraceefR
    directory.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    For the number of times defined by the previous 4 bytes is the
    following:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    A null-terminated string containing the system name.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    4 bytes containing a 32-bit word containing the number
    of events within the system.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    For the number of times defined in the previous 4 bytes is the
    following:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    8 bytes for the size of the event format file.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The event format file copied from the target machine:
    debugfs/tracing/events/<system>/<event>/format
.if n \{.RE
.\}

<a name="kallsyms-information"></a>

# Kallsyms Information


.if n \{.RS 4
.\}
    Directly after the event formats comes the information of the mapping
    of function addresses to the function names.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 4 bytes are a 32-bit word containing the size of the
    data holding the function mappings.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next set of data is of the size defined by the previous 4 bytes
    and contains the information from the target machines file:
    /proc/kallsyms
.if n \{.RE
.\}

<a name="trace_printk-information"></a>

# Trace_printk Information


.if n \{.RS 4
.\}
    If a developer used trace_printk() within the kernel, it may
    store the format string outside the ring buffer.
    This information can be found in:
    debugfs/tracing/printk_formats
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 4 bytes are a 32-bit word containing the size of the
    data holding the printk formats.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next set of data is of the size defined by the previous 4 bytes
    and contains the information from debugfs/tracing/printk_formats.
.if n \{.RE
.\}

<a name="process-information"></a>

# Process Information


.if n \{.RS 4
.\}
    Directly after the trace_printk formats comes the information mapping
    a PID to a process name.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 8 bytes contain a 64-bit word that holds the size of the
    data mapping the PID to a process name.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next set of data is of the size defined by the previous 8 bytes
    and contains the information from debugfs/tracing/saved_cmdlines.
.if n \{.RE
.\}

<a name="rest-of-trace-cmd-header"></a>

# Rest of Trace\-Cmd Header


.if n \{.RS 4
.\}
    Directly after the process information comes the last bit of the
    trace.dat file header.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 4 bytes are a 32-bit word defining the number of CPUs that
    were discovered on the target machine (and has matching trace data
    for it).
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 10 bytes are one of the following:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "options  e0"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "latency  e0"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "flyrecorde0"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If it is "options  e0" then:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 2 bytes are a 16-bit word defining the current option.
    If the the value is zero then there are no more options.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Otherwise, the next 4 bytes contain a 32-bit word containing the
    option size. If the reader does not know how to handle the option
    it can simply skip it. Currently there are no options defined,
    but this is here to extend the data.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next option will be directly after the previous option, and
    the options ends with a zero in the option type field.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The next 10 bytes after the options are one of the following:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "latency  e0"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    "flyrecorde0"
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    which would follow the same as if options were not present.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If the value is "latency  e0", then the rest of the file is
    simply ASCII text that was taken from the targets:
    debugfs/tracing/trace
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If the value is "flyrecorde0", the following is present:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    For the number of CPUs that were read earlier, the
    following is present:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    8 bytes that are a 64-bit word containing the offset into the file
    that holds the data for the CPU.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    8 bytes that are a 64-bit word containing the size of the CPU
    data at that offset.
.if n \{.RE
.\}

<a name="cpu-data"></a>

# Cpu Data


.if n \{.RS 4
.\}
    The CPU data is located in the part of the file that is specified
    in the end of the header. Padding is placed between the header and
    the CPU data, placing the CPU data at a page aligned (target page) position
    in the file.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This data is copied directly from the Ftrace ring buffer and is of the
    same format as the ring buffer specified by the event header files
    loaded in the header format file.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The trace-cmd tool will try to efBmmap(2)efR the data page by page with the
    targets page size if possible. If it fails to mmap, it will just read the
    data instead.
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1), trace-cmd.dat(5)

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
