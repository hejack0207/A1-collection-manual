# perf\-archive(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-archive - Create archive with object files with build-ids found in perf.data file

<a name="synopsis"></a>

# Synopsis

```


```
    perf archive [file]

<a name="description"></a>

# Description


This command runs perf-buildid-list --with-hits, and collects the files with the buildids found so that analysis of perf.data contents can be possible on another machine.

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-buildid-list**(1), **perf-report**(1)
