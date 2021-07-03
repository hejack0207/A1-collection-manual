# perf\-evlist(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-evlist - List the event names in a perf.data file

<a name="synopsis"></a>

# Synopsis

```


```
    perf evlist <options>

<a name="description"></a>

# Description


This command displays the names of events sampled in a perf.data file.

<a name="options"></a>

# Options


-i, --input=
Input file name. (default: perf.data unless stdin is a fifo)

-f, --force
Don’t complain, do it.

-F, --freq=
Show just the sample frequency used for each event.

-v, --verbose=
Show all fields.

-g, --group
Show event group information.

--trace-fields
Show tracepoint field names.

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-list**(1), **perf-report**(1)
