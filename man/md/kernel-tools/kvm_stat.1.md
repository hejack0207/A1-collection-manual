# kvm_stat(1)

\ \&, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

kvm_stat - Report KVM kernel module event counters

<a name="synopsis"></a>

# Synopsis

```


```
    kvm_stat [OPTION]...

<a name="description"></a>

# Description


kvm_stat prints counts of KVM kernel module trace events. These events signify state transitions such as guest mode entry and exit.

This tool is useful for observing guest behavior from the host perspective. Often conclusions about performance or buggy behavior can be drawn from the output. While running in regular mode, use any of the keys listed in section _Interactive Commands_ below. Use batch and logging modes for scripting purposes.

The set of KVM kernel module trace events may be specific to the kernel version or architecture. It is best to check the KVM kernel module source code for the meaning of events.

<a name="interactive-commands"></a>

# Interactive Commands

.TS
tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**b**
T}:T{

toggle events by guests (debugfs only, honors filters)
T}
T{

**c**
T}:T{

clear filter
T}
T{

**f**
T}:T{

filter by regular expression
T}
T{

T}:T{

**Note**: Child events pull in their parents, and parents stats summarize all child events, not just the filtered ones
T}
T{

**g**
T}:T{

filter by guest name/PID
T}
T{

**h**
T}:T{

display interactive commands reference
T}
T{

**o**
T}:T{

toggle sorting order (Total vs CurAvg/s)
T}
T{

**p**
T}:T{

filter by guest name/PID
T}
T{

**q**
T}:T{

quit
T}
T{

**r**
T}:T{

reset stats
T}
T{

**s**
T}:T{

set update interval
T}
T{

**x**
T}:T{

toggle reporting of stats for child trace events
T}
T{

T}:T{

**Note**: The stats for the parents summarize the respective child trace events
T}
.TE


Press any other key to refresh statistics immediately.

<a name="options"></a>

# Options


-1, --once, --batch
run in batch mode for one second

-l, --log
run in logging mode (like vmstat)

-t, --tracepoints
retrieve statistics from tracepoints

-d, --debugfs
retrieve statistics from debugfs

-i, --debugfs-include-past
include all available data on past events for debugfs

-p&lt;pid&gt;, --pid=&lt;pid&gt;
limit statistics to one virtual machine (pid)

-g&lt;guest&gt;, --guest=&lt;guest_name&gt;
limit statistics to one virtual machine (guest name)

-f&lt;fields&gt;, --fields=&lt;fields&gt;
fields to display (regex), "-f help" for a list of available events

-h, --help
show help message

<a name="see-also"></a>

# See Also


_perf_(1), _trace-cmd_(1)

<a name="author"></a>

# Author


Stefan Hajnoczi &lt;[stefanha@redhat.com](mailto:stefanha@redhat.com)&gt;
