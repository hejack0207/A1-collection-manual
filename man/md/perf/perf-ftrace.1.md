# perf\-ftrace(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-ftrace - simple wrapper for kernels ftrace functionality

<a name="synopsis"></a>

# Synopsis

```


```
    perf ftrace <command>

<a name="description"></a>

# Description


The _perf ftrace_ command is a simple wrapper of kernel’s ftrace functionality. It only supports single thread tracing currently and just reads trace_pipe in text and then write it to stdout.

The following options apply to perf ftrace.

<a name="options"></a>

# Options


-t, --tracer=
Tracer to use: function_graph or function.

-v, --verbose=
Verbosity level.

-p, --pid=
Trace on existing process id (comma separated list).

-a, --all-cpus
Force system-wide collection. Scripts run without a &lt;command&gt; normally use -a by default, while scripts run with a &lt;command&gt; normally don’t - this option allows the latter to be run in system-wide mode.

-C, --cpu=
Only trace for the list of CPUs provided. Multiple CPUs can be provided as a comma separated list with no space like: 0,1. Ranges of CPUs are specified with -: 0-2. Default is to trace on all online CPUs.

-T, --trace-funcs=
Only trace functions given by the argument. Multiple functions can be given by using this option more than once. The function argument also can be a glob pattern. It will be passed to
_set\_ftrace\_filter_
in tracefs.

-N, --notrace-funcs=
Do not trace functions given by the argument. Like -T option, this can be used more than once to specify multiple functions (or glob patterns). It will be passed to
_set\_ftrace\_notrace_
in tracefs.

-G, --graph-funcs=
Set graph filter on the given function (or a glob pattern). This is useful for the function_graph tracer only and enables tracing for functions executed from the given function. This can be used more than once to specify multiple functions. It will be passed to
_set\_graph\_function_
in tracefs.

-g, --nograph-funcs=
Set graph notrace filter on the given function (or a glob pattern). Like -G option, this is useful for the function_graph tracer only and disables tracing for function executed from the given function. This can be used more than once to specify multiple functions. It will be passed to
_set\_graph\_notrace_
in tracefs.

-D, --graph-depth=
Set max depth for function graph tracer to follow

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-trace**(1)
