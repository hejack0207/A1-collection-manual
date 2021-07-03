# perf\-annotate(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-annotate - Read perf.data (created by perf record) and display annotated code

<a name="synopsis"></a>

# Synopsis

```


```
    perf annotate [-i <file> | --input=file] [symbol_name]

<a name="description"></a>

# Description


This command reads the input file and displays an annotated version of the code. If the object file has debug symbols then the source code will be displayed alongside assembly code.

If there is no debug info in the object, then annotated assembly is displayed.

<a name="options"></a>

# Options


-i, --input=&lt;file&gt;
Input file name. (default: perf.data unless stdin is a fifo)

-d, --dsos=&lt;dso[,dso...]&gt;
Only consider symbols in these dsos.

-s, --symbol=&lt;symbol&gt;
Symbol to annotate.

-f, --force
Don’t do ownership validation.

-v, --verbose
Be more verbose. (Show symbol address, etc)

-q, --quiet
Do not show any message. (Suppress -v)

-n, --show-nr-samples
Show the number of samples for each symbol

-D, --dump-raw-trace
Dump raw trace in ASCII.

-k, --vmlinux=&lt;file&gt;
vmlinux pathname.

--ignore-vmlinux
Ignore vmlinux files.

-m, --modules
Load module symbols. WARNING: use only with -k and LIVE kernel.

-l, --print-line
Print matching source lines (may be slow).

-P, --full-paths
Don’t shorten the displayed pathnames.

--stdio
Use the stdio interface.

--stdio2
Use the stdio2 interface, non-interactive, uses the TUI formatting.

--stdio-color=&lt;mode&gt;
_always_,
_never_
or
_auto_, allowing configuring color output via the command line, in addition to via "color.ui" .perfconfig. Use
_--stdio-color always_
to generate color even when redirecting to a pipe or file. Using just
_--stdio-color_
is equivalent to using
_always_.

--tui
Use the TUI interface. Use of --tui requires a tty, if one is not present, as when piping to other commands, the stdio interface is used. This interfaces starts by centering on the line with more samples, TAB/UNTAB cycles through the lines with more samples.

--gtk
Use the GTK interface.

-C, --cpu=&lt;cpu&gt;
Only report samples for the list of CPUs provided. Multiple CPUs can be provided as a comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default is to report samples on all CPUs.

--asm-raw
Show raw instruction encoding of assembly instructions.

--show-total-period
Show a column with the sum of periods.

--source
Interleave source code with assembly code. Enabled by default, disable with --no-source.

--symfs=&lt;directory&gt;
Look for files with symbols relative to this directory.

-M, --disassembler-style=
Set disassembler style for objdump.

--objdump=&lt;path&gt;
Path to objdump binary.

--prefix=PREFIX, --prefix-strip=N
Remove first N entries from source file path names in executables and add PREFIX. This allows to display source code compiled on systems with different file system layout.

--skip-missing
Skip symbols that cannot be annotated.

--group
Show event group information together

--percent-type
Set annotation percent type from following choices: global-period, local-period, global-hits, local-hits

.if n \{.RS 4
.\}
    The local/global keywords set if the percentage is computed
    in the scope of the function (local) or the whole data (global).
    The period/hits keywords set the base the percentage is computed
    on - the samples period or the number of samples (hits).
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-report**(1)
