# perf(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf - Performance analysis tools for Linux

<a name="synopsis"></a>

# Synopsis

```


```
    perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

<a name="options"></a>

# Options


--debug
Setup debug variable (see list below) in value range (0, 10). Use like: --debug verbose # sets verbose = 1 --debug verbose=2 # sets verbose = 2

.if n \{.RS 4
.\}
    List of debug variables allowed to set:
      verbose          - general debug messages
      ordered-events   - ordered events object debug messages
      data-convert     - data convert command debug messages
      stderr           - write debug output (option -v) to stderr
                         in browser mode
      perf-event-open  - Print perf_event_open() arguments and
                         return value
.if n \{.RE
.\}

--buildid-dir
Setup buildid cache directory. It has higher priority than buildid.dir config file option.

-v, --version
Display perf version.

-h, --help
Run perf help command.

<a name="description"></a>

# Description


Performance counters for Linux are a new kernel-based subsystem that provide a framework for all things performance analysis. It covers hardware level (CPU/PMU, Performance Monitoring Unit) features and software features (software counters, tracepoints) as well.

<a name="see-also"></a>

# See Also


**perf-stat**(1), **perf-top**(1), **perf-record**(1), **perf-report**(1), **perf-list**(1)
