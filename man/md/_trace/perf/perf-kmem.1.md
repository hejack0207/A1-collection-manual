# perf\-kmem(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-kmem - Tool to trace/measure kernel memory properties

<a name="synopsis"></a>

# Synopsis

```


```
    perf kmem {record|stat} [<options>]

<a name="description"></a>

# Description


There are two variants of perf kmem:

.if n \{.RS 4
.\}
    perf kmem record <command>*(Aq to record the kmem events
    of an arbitrary workload.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf kmem stat*(Aq to report kernel memory statistics.
.if n \{.RE
.\}

<a name="options"></a>

# Options


-i &lt;file&gt;, --input=&lt;file&gt;
Select the input file (default: perf.data unless stdin is a fifo)

-f, --force
Don’t do ownership validation

-v, --verbose
Be more verbose. (show symbol address, etc)

--caller
Show per-callsite statistics

--alloc
Show per-allocation statistics

-s &lt;key[,key2...]&gt;, --sort=&lt;key[,key2...]&gt;
Sort the output (default:
_frag,hit,bytes_
for slab and
_bytes,hit_
for page). Available sort keys are
_ptr, callsite, bytes, hit, pingpong, frag_
for slab and
_page, callsite, bytes, hit, order, migtype, gfp_
for page. This option should be preceded by one of the mode selection options - i.e. --slab, --page, --alloc and/or --caller.

-l &lt;num&gt;, --line=&lt;num&gt;
Print n lines only

--raw-ip
Print raw ip instead of symbol

--slab
Analyze SLAB allocator events.

--page
Analyze page allocator events

--live
Show live page stat. The perf kmem shows total allocation stat by default, but this option shows live (currently allocated) pages instead. (This option works with --page option only)

--time=&lt;start&gt;,&lt;stop&gt;
Only analyze samples within given time window: &lt;start&gt;,&lt;stop&gt;. Times have the format seconds.microseconds. If start is not given (i.e., time string is
_,x.y_) then analysis starts at the beginning of the file. If stop time is not given (i.e, time string is
_x.y,_) then analysis goes to end of file.

<a name="see-also"></a>

# See Also


**perf-record**(1)
