# perf\-buildid\-list(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-buildid-list - List the buildids in a perf.data file

<a name="synopsis"></a>

# Synopsis

```


```
    perf buildid-list <options>

<a name="description"></a>

# Description


This command displays the buildids found in a perf.data file, so that other tools can be used to fetch packages with matching symbol tables for use by perf report.

It can also be used to show the build id of the running kernel or in an ELF file using -i/--input.

<a name="options"></a>

# Options


-H, --with-hits
Show only DSOs with hits.

-i, --input=
Input file name. (default: perf.data unless stdin is a fifo)

-f, --force
Don’t do ownership validation.

-k, --kernel
Show running kernel build id.

-v, --verbose
Be more verbose.

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-top**(1), **perf-report**(1)
