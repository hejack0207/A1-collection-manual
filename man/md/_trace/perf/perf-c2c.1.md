# perf\-c2c(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-c2c - Shared Data C2C/HITM Analyzer.

<a name="synopsis"></a>

# Synopsis

```


```
    perf c2c record [<options>] <command>
    perf c2c record [<options>] — [<record command options>] <command>
    perf c2c report [<options>]

<a name="description"></a>

# Description


C2C stands for Cache To Cache.

The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows you to track down the cacheline contentions.

On x86, the tool is based on load latency and precise store facility events provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling with thresholding feature.

These events provide: - memory address of the access - type of the access (load and store details) - latency (in cycles) of the load access

The c2c tool provide means to record this data and report back access details for cachelines with highest contention - highest number of HITM accesses.

The basic workflow with this tool follows the standard record/report phase. User uses the record command to record events data and report command to display it.

<a name="record-options"></a>

# Record Options


-e, --event=
Select the PMU event. Use
_perf mem record -e list_
to list available events.

-v, --verbose
Be more verbose (show counter open errors, etc).

-l, --ldlat
Configure mem-loads latency. (x86 only)

-k, --all-kernel
Configure all used events to run in kernel space.

-u, --all-user
Configure all used events to run in user space.

<a name="report-options"></a>

# Report Options


-k, --vmlinux=&lt;file&gt;
vmlinux pathname

-v, --verbose
Be more verbose (show counter open errors, etc).

-i, --input
Specify the input file to process.

-N, --node-info
Show extra node info in report (see NODE INFO section)

-c, --coalesce
Specify sorting fields for single cacheline display. Following fields are available: tid,pid,iaddr,dso (see COALESCE)

-g, --call-graph
Setup callchains parameters. Please refer to perf-report man page for details.

--stdio
Force the stdio output (see STDIO OUTPUT)

--stats
Display only statistic tables and force stdio mode.

--full-symbols
Display full length of symbols.

--no-source
Do not display Source:Line column.

--show-all
Show all captured HITM lines, with no regard to HITM % 0.0005 limit.

-f, --force
Don’t do ownership validation.

-d, --display
Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.

<a name="c2c-record"></a>

# C2c Record


The perf c2c record command setup options related to HITM cacheline analysis and calls standard perf record command.

Following perf record options are configured by default: (check perf record man page for details)

.if n \{.RS 4
.\}
    -W,-d,--phys-data,--sample-cpu
.if n \{.RE
.\}

Unless specified otherwise with _-e_ option, following events are monitored by default on x86:

.if n \{.RS 4
.\}
    cpu/mem-loads,ldlat=30/P
    cpu/mem-stores/P
.if n \{.RE
.\}

and following on PowerPC:

.if n \{.RS 4
.\}
    cpu/mem-loads/
    cpu/mem-stores/
.if n \{.RE
.\}

User can pass any _perf record_ option behind _--_ mark, like (to enable callchains and system wide monitoring):

.if n \{.RS 4
.\}
    $ perf c2c record -- -g -a
.if n \{.RE
.\}

Please check RECORD OPTIONS section for specific c2c record options.

<a name="c2c-report"></a>

# C2c Report


The perf c2c report command displays shared data analysis. It comes in two display modes: stdio and tui (default).

The report command workflow is following: - sort all the data based on the cacheline address - store access details for each cacheline - sort all cachelines based on user settings - display data

In general perf report output consist of 2 basic views: 1) most expensive cachelines list 2) offsets details for each cacheline

For each cacheline in the 1) list we display following data: (Both stdio and TUI modes follow the same fields output)

.if n \{.RS 4
.\}
    Index
    - zero based index to identify the cacheline
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Cacheline
    - cacheline address (hex number)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Total records
    - sum of all cachelines accesses
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Rmt/Lcl Hitm
    - cacheline percentage of all Remote/Local HITM accesses
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    LLC Load Hitm - Total, Lcl, Rmt
    - count of Total/Local/Remote load HITMs
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Store Reference - Total, L1Hit, L1Miss
      Total - all store accesses
      L1Hit - store accesses that hit L1
      L1Hit - store accesses that missed L1
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Load Dram
    - count of local and remote DRAM accesses
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    LLC Ld Miss
    - count of all accesses that missed LLC
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Total Loads
    - sum of all load accesses
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Core Load Hit - FB, L1, L2
    - count of load hits in FB (Fill Buffer), L1 and L2 cache
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    LLC Load Hit - Llc, Rmt
    - count of LLC and Remote load hits
.if n \{.RE
.\}

For each offset in the 2) list we display following data:

.if n \{.RS 4
.\}
    HITM - Rmt, Lcl
    - % of Remote/Local HITM accesses for given offset within cacheline
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Store Refs - L1 Hit, L1 Miss
    - % of store accesses that hit/missed L1 for given offset within cacheline
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Data address - Offset
    - offset address
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Pid
    - pid of the process responsible for the accesses
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Tid
    - tid of the process responsible for the accesses
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Code address
    - code address responsible for the accesses
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    cycles - rmt hitm, lcl hitm, load
      - sum of cycles for given accesses - Remote/Local HITM and generic load
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    cpu cnt
      - number of cpus that participated on the access
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Symbol
      - code symbol related to the Code address*(Aq value
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Shared Object
      - shared object name related to the Code address*(Aq value
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Source:Line
      - source information related to the Code address*(Aq value
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Node
      - nodes participating on the access (see NODE INFO section)
.if n \{.RE
.\}

<a name="node-info"></a>

# Node Info


The _Node_ field displays nodes that accesses given cacheline offset. Its output comes in 3 flavors: - node IDs separated by _,_ - node IDs with stats for each ID, in following format: Node{cpus %hitms %stores} - node IDs with list of affected CPUs in following format: Node{cpu list}

User can switch between above flavors with -N option or use _n_ key to interactively switch in TUI mode.

<a name="coalesce"></a>

# Coalesce


User can specify how to sort offsets for cacheline.

Following fields are available and governs the final output fields set for caheline offsets output:

.if n \{.RS 4
.\}
    tid   - coalesced by process TIDs
    pid   - coalesced by process PIDs
    iaddr - coalesced by code address, following fields are displayed:
               Code address, Code symbol, Shared Object, Source line
    dso   - coalesced by shared object
.if n \{.RE
.\}

By default the coalescing is setup with _pid,iaddr_.

<a name="stdio-output"></a>

# Stdio Output


The stdio output displays data on standard output.

Following tables are displayed: Trace Event Information - overall statistics of memory accesses

.if n \{.RS 4
.\}
    Global Shared Cache Line Event Information
    - overall statistics on shared cachelines
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Shared Data Cache Line Table
    - list of most expensive cachelines
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Shared Cache Line Distribution Pareto
    - list of all accessed offsets for each cacheline
.if n \{.RE
.\}

<a name="tui-output"></a>

# Tui Output


The TUI output provides interactive interface to navigate through cachelines list and to display offset details.

For details please refer to the help window by pressing _?_ key.

<a name="credits"></a>

# Credits


Although Don Zickus, Dick Fowles and Joe Mario worked together to get this implemented, we got lots of early help from Arnaldo Carvalho de Melo, Stephane Eranian, Jiri Olsa and Andi Kleen.

<a name="c2c-blog"></a>

# C2c Blog


Check Joe’s blog on c2c tool for detailed use case explanation: \m[blue]**https://joemario.github.io/blog/2016/09/01/c2c-blog/**\m[]

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-mem**(1)
