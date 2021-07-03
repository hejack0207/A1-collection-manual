# perf\-data(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-data - Data file related processing

<a name="synopsis"></a>

# Synopsis

```


```
    perf data [<common options>] <command> [<options>]",

<a name="description"></a>

# Description


Data file related processing.

<a name="commands"></a>

# Commands


convert
Converts perf data file into another format (only CTF [1] format is support by now). It’s possible to set data-convert debug variable to get debug messages from conversion, like: perf --debug data-convert data convert ...

<a name="options-for-ficonvertfr"></a>

# Options for \Ficonvert\Fr


--to-ctf
Triggers the CTF conversion, specify the path of CTF data directory.

-i
Specify input perf data file path.

-f, --force
Don’t complain, do it.

-v, --verbose
Be more verbose (show counter open errors, etc).

--all
Convert all events, including non-sample events (comm, fork, ...), to output. Default is off, only convert samples.

<a name="see-also"></a>

# See Also


**perf**(1) [1] Common Trace Format - \m[blue]**http://www.efficios.com/ctf**\m[]
