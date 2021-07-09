# perf\-mem(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-mem - Profile memory accesses

<a name="synopsis"></a>

# Synopsis

```


```
    perf mem [<options>] (record [<command>] | report)

<a name="description"></a>

# Description


"perf mem record" runs a command and gathers memory operation data from it, into perf.data. Perf record options are accepted and are passed through.

"perf mem report" displays the result. It invokes perf report with the right set of options to display a memory access profile. By default, loads and stores are sampled. Use the -t option to limit to loads or stores.

Note that on Intel systems the memory latency reported is the use-latency, not the pure load (or store latency). Use latency includes any pipeline queueing delays in addition to the memory subsystem latency.

<a name="options"></a>

# Options


&lt;command&gt;...
Any command you can specify in a shell.

-i, --input=&lt;file&gt;
Input file name.

-f, --force
Don’t do ownership validation

-t, --type=&lt;type&gt;
Select the memory operation type: load or store (default: load,store)

-D, --dump-raw-samples
Dump the raw decoded samples on the screen in a format that is easy to parse with one sample per line.

-x, --field-separator=&lt;separator&gt;
Specify the field separator used when dump raw samples (-D option). By default, The separator is the space character.

-C, --cpu=&lt;cpu&gt;
Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default is to monitor all CPUS.

-U, --hide-unresolved
Only display entries resolved to a symbol.

-p, --phys-data
Record/Report sample physical addresses

<a name="record-options"></a>

# Record Options


-e, --event &lt;event&gt;
Event selector. Use
_perf mem record -e list_
to list available events.

-K, --all-kernel
Configure all used events to run in kernel space.

-U, --all-user
Configure all used events to run in user space.

-v, --verbose
Be more verbose (show counter open errors, etc)

--ldlat &lt;n&gt;
Specify desired latency for loads event. (x86 only)

In addition, for report all perf report options are valid, and for record all perf record options.

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-report**(1)
