# perf\-lock(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-lock - Analyze lock events

<a name="synopsis"></a>

# Synopsis

```


```
    perf lock {record|report|script|info}

<a name="description"></a>

# Description


You can analyze various lock behaviours and statistics with this _perf lock_ command.

.if n \{.RS 4
.\}
    perf lock record <command>*(Aq records lock events
    between start and end <command>. And this command
    produces the file "perf.data" which contains tracing
    results of lock events.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf lock report*(Aq reports statistical data.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf lock script*(Aq shows raw lock events.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf lock info*(Aq shows metadata like threads or addresses
    of lock instances.
.if n \{.RE
.\}

<a name="common-options"></a>

# Common Options


-i, --input=&lt;file&gt;
Input file name. (default: perf.data unless stdin is a fifo)

-v, --verbose
Be more verbose (show symbol address, etc).

-D, --dump-raw-trace
Dump raw trace in ASCII.

-f, --force
Don’t complan, do it.

<a name="report-options"></a>

# Report Options


-k, --key=&lt;value&gt;
Sorting key. Possible values: acquired (default), contended, avg_wait, wait_total, wait_max, wait_min.

<a name="info-options"></a>

# Info Options


-t, --threads
dump thread list in perf.data

-m, --map
dump map of lock instances (address:name table)

<a name="see-also"></a>

# See Also


**perf**(1)
