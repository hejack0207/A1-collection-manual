# perf\-config(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-config - Get and set variables in a configuration file.

<a name="synopsis"></a>

# Synopsis

```


```
    perf config [<file-option>] [section.name[=value] ...]
    or
    perf config [<file-option>] -l | --list

<a name="description"></a>

# Description


You can manage variables in a configuration file with this command.

<a name="options"></a>

# Options


-l, --list
Show current config variables, name and value, for all sections.

--user
For writing and reading options: write to user
_$HOME/.perfconfig_
file or read it.

--system
For writing and reading options: write to system-wide
_$(sysconfdir)/perfconfig_
or read it.

<a name="configuration-file"></a>

# Configuration File


The perf configuration file contains many variables to change various aspects of each of its tools, including output, disk usage, etc. The _$HOME/.perfconfig_ file is used to store a per-user configuration. The file _$(sysconfdir)/perfconfig_ can be used to store a system-wide default configuration.

One an disable reading config files by setting the PERF_CONFIG environment variable to /dev/null, or provide an alternate config file by setting that variable.

When reading or writing, the values are read from the system and user configuration files by default, and options _--system_ and _--user_ can be used to tell the command to read from or write to only that location.

<a name="syntax"></a>

### Syntax


The file consist of sections. A section starts with its name surrounded by square brackets and continues till the next section begins. Each variable must be in a section, and have the form _name = value_, for example:

.if n \{.RS 4
.\}
    [section]
            name1 = value1
            name2 = value2
.if n \{.RE
.\}

Section names are case sensitive and can contain any characters except newline (double quote " and backslash have to be escaped as \e" and \e\e, respectively). Section headers can’t span multiple lines.

<a name="example"></a>

### Example


Given a $HOME/.perfconfig like this:

# # This is the config file, and # a _#_ and _;_ character indicates a comment #

.if n \{.RS 4
.\}
    [colors]
            # Color variables
            top = red, default
            medium = green, default
            normal = lightgray, default
            selected = white, lightgray
            jump_arrows = blue, default
            addr = magenta, default
            root = white, blue
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [tui]
            # Defaults if linked with libslang
            report = on
            annotate = on
            top = on
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [buildid]
            # Default, disable using /dev/null
            dir = ~/.debug
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [annotate]
            # Defaults
            hide_src_code = false
            use_offset = true
            jump_arrows = true
            show_nr_jumps = false
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [help]
            # Format can be man, info, web or html
            format = man
            autocorrect = 0
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [ui]
            show-headers = true
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [call-graph]
            # fp (framepointer), dwarf
            record-mode = fp
            print-type = graph
            order = caller
            sort-key = function
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [report]
            # Defaults
            sort_order = comm,dso,symbol
            percent-limit = 0
            queue-size = 0
            children = true
            group = true
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    [llvm]
            dump-obj = true
            clang-opt = -g
.if n \{.RE
.\}

You can hide source code of annotate feature setting the config to false with

.if n \{.RS 4
.\}
    % perf config annotate.hide_src_code=true
.if n \{.RE
.\}

If you want to add or modify several config items, you can do like

.if n \{.RS 4
.\}
    % perf config ui.show-headers=false kmem.default=slab
.if n \{.RE
.\}

To modify the sort order of report functionality in user config file(i.e. ~/.perfconfig), do

.if n \{.RS 4
.\}
    % perf config --user report sort-order=srcline
.if n \{.RE
.\}

To change colors of selected line to other foreground and background colors in system config file (i.e. $(sysconf)/perfconfig), do

.if n \{.RS 4
.\}
    % perf config --system colors.selected=yellow,green
.if n \{.RE
.\}

To query the record mode of call graph, do

.if n \{.RS 4
.\}
    % perf config call-graph.record-mode
.if n \{.RE
.\}

If you want to know multiple config key/value pairs, you can do like

.if n \{.RS 4
.\}
    % perf config report.queue-size call-graph.order report.children
.if n \{.RE
.\}

To query the config value of sort order of call graph in user config file (i.e. ~/.perfconfig), do

.if n \{.RS 4
.\}
    % perf config --user call-graph.sort-order
.if n \{.RE
.\}

To query the config value of buildid directory in system config file (i.e. $(sysconf)/perfconfig), do

.if n \{.RS 4
.\}
    % perf config --system buildid.dir
.if n \{.RE
.\}

<a name="variables"></a>

### Variables


colors.*
The variables for customizing the colors used in the output for the
_report_,
_top_
and
_annotate_
in the TUI. They should specify the foreground and background colors, separated by a comma, for example:

.if n \{.RS 4
.\}
    medium = green, lightgray
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If you want to use the color configured for you terminal, just leave it
    as default*(Aq, for example:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    medium = default, lightgray
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Available colors:
    red, yellow, green, cyan, gray, black, blue,
    white, default, magenta, lightgray
.if n \{.RE
.\}

colors.top
_top_
means a overhead percentage which is more than 5%. And values of this variable specify percentage colors. Basic key values are foreground-color
_red_
and background-color
_default_.

colors.medium
_medium_
means a overhead percentage which has more than 0.5%. Default values are
_green_
and
_default_.

colors.normal
_normal_
means the rest of overhead percentages except
_top_,
_medium_,
_selected_. Default values are
_lightgray_
and
_default_.

colors.selected
This selects the colors for the current entry in a list of entries from sub-commands (top, report, annotate). Default values are
_black_
and
_lightgray_.

colors.jump_arrows
Colors for jump arrows on assembly code listings such as
_jns_,
_jmp_,
_jane_, etc. Default values are
_blue_,
_default_.

colors.addr
This selects colors for addresses from
_annotate_. Default values are
_magenta_,
_default_.

colors.root
Colors for headers in the output of a sub-commands (top, report). Default values are
_white_,
_blue_.

core.*, core.proc-map-timeout
Sets a timeout (in milliseconds) for parsing /proc/&lt;pid&gt;/maps files. Can be overridden by the --proc-map-timeout option on supported subcommands. The default timeout is 500ms.

tui.**, gtk.**
Subcommands that can be configured here are
_top_,
_report_
and
_annotate_. These values are booleans, for example:

.if n \{.RS 4
.\}
    [tui]
            top = true
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    will make the TUI be the default for the top*(Aq subcommand. Those will be
    available if the required libs were detected at tool build time.
.if n \{.RE
.\}

buildid.*, buildid.dir
Each executable and shared library in modern distributions comes with a content based identifier that, if available, will be inserted in a
_perf.data_
file header to, at analysis time find what is needed to do symbol resolution, code annotation, etc.

.if n \{.RS 4
.\}
    The recording tools also stores a hard link or copy in a per-user
    directory, $HOME/.debug/, of binaries, shared libraries, /proc/kallsyms
    and /proc/kcore files to be used at analysis time.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The buildid.dir variable can be used to either change this directory
    cache location, or to disable it altogether. If you want to disable it,
    set buildid.dir to /dev/null. The default is $HOME/.debug
.if n \{.RE
.\}

annotate.*
These are in control of addresses, jump function, source code in lines of assembly code from a specific program.

annotate.hide_src_code
If a program which is analyzed has source code, this option lets
_annotate_
print a list of assembly code with the source code. For example, let’s see a part of a program. There’re four lines. If this option is
_true_, they can be printed without source code from a program as below.

.if n \{.RS 4
.\}
    │        push   %rbp
    │        mov    %rsp,%rbp
    │        sub    $0x10,%rsp
    │        mov    (%rdi),%rdx
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    But if this option is false*(Aq, source code of the part
    can be also printed as below. Default is false*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    │      struct rb_node *rb_next(const struct rb_node *node)
    │      {
    │        push   %rbp
    │        mov    %rsp,%rbp
    │        sub    $0x10,%rsp
    │              struct rb_node *parent;
    │
    │              if (RB_EMPTY_NODE(node))
    │        mov    (%rdi),%rdx
    │              return n;
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This option works with tui, stdio2 browsers.
.if n \{.RE
.\}

annotate.use_offset
Basing on a first address of a loaded function, offset can be used. Instead of using original addresses of assembly code, addresses subtracted from a base address can be printed. Let’s illustrate an example. If a base address is 0XFFFFFFFF81624d50 as below,

.if n \{.RS 4
.\}
    ffffffff81624d50 <load0>
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    an address on assembly code has a specific absolute address as below
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    ffffffff816250b8:│  mov    0x8(%r14),%rdi
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    but if use_offset is true*(Aq, an address subtracted from a base address is printed.
    Default is true. This option is only applied to TUI.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    368:│  mov    0x8(%r14),%rdi
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This option works with tui, stdio2 browsers.
.if n \{.RE
.\}

annotate.jump_arrows
There can be jump instruction among assembly code. Depending on a boolean value of jump_arrows, arrows can be printed or not which represent where do the instruction jump into as below.

.if n \{.RS 4
.\}
    │     ┌──jmp    1333
    │     │  xchg   %ax,%ax
    │1330:│  mov    %r15,%r10
    │1333:└─(->cmp    %r15,%r14
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If jump_arrow is false*(Aq, the arrows isn*(Aqt printed as below.
    Default is false*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    │      (da jmp    1333
    │        xchg   %ax,%ax
    │1330:   mov    %r15,%r10
    │1333:   cmp    %r15,%r14
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This option works with tui browser.
.if n \{.RE
.\}

annotate.show_linenr
When showing source code if this option is
_true_, line numbers are printed as below.

.if n \{.RS 4
.\}
    │1628         if (type & PERF_SAMPLE_IDENTIFIER) {
    │     (da jne    508
    │1628                 data->id = *array;
    │1629                 array++;
    │1630         }
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    However if this option is false*(Aq, they aren*(Aqt printed as below.
    Default is false*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    │             if (type & PERF_SAMPLE_IDENTIFIER) {
    │     (da jne    508
    │                     data->id = *array;
    │                     array++;
    │             }
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This option works with tui, stdio2 browsers.
.if n \{.RE
.\}

annotate.show_nr_jumps
Let’s see a part of assembly code.

.if n \{.RS 4
.\}
    │1382:   movb   $0x1,-0x270(%rbp)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    If use this, the number of branches jumping to that address can be printed as below.
    Default is false*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    │1 1382:   movb   $0x1,-0x270(%rbp)
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This option works with tui, stdio2 browsers.
.if n \{.RE
.\}

annotate.show_total_period
To compare two records on an instruction base, with this option provided, display total number of samples that belong to a line in assembly code. If this option is
_true_, total periods are printed instead of percent values as below.

.if n \{.RS 4
.\}
    302 │      mov    %eax,%eax
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    But if this option is false*(Aq, percent values for overhead are printed i.e.
    Default is false*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    99.93 │      mov    %eax,%eax
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This option works with tui, stdio2, stdio browsers.
.if n \{.RE
.\}

annotate.show_nr_samples
By default perf annotate shows percentage of samples. This option can be used to print absolute number of samples. Ex, when set as false:

.if n \{.RS 4
.\}
    Percent│
     74.03 │      mov    %fs:0x28,%rax
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    When set as true:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Samples│
         6 │      mov    %fs:0x28,%rax
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This option works with tui, stdio2, stdio browsers.
.if n \{.RE
.\}

annotate.offset_level
Default is
_1_, meaning just jump targets will have offsets show right beside the instruction. When set to
_2_
_call_
instructions will also have its offsets shown, 3 or higher will show offsets for all instructions.

.if n \{.RS 4
.\}
    This option works with tui, stdio2 browsers.
.if n \{.RE
.\}

hist.*, hist.percentage
This option control the way to calculate overhead of filtered entries - that means the value of this option is effective only if there’s a filter (by comm, dso or symbol name). Suppose a following example:

.if n \{.RS 4
.\}
    Overhead  Symbols
    ........  .......
     33.33%     foo
     33.33%     bar
     33.33%     baz
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This is an original overhead and well filter out the first *(Aqfoo*(Aq
    entry. The value of relative*(Aq would increase the overhead of *(Aqbar*(Aq
    and baz*(Aq to 50.00% for each, while *(Aqabsolute*(Aq would show their
    current overhead (33.33%).
.if n \{.RE
.\}

ui.*, ui.show-headers
This option controls display of column headers (like
_Overhead_
and
_Symbol_) in
_report_
and
_top_. If this option is false, they are hidden. This option is only applied to TUI.

call-graph.*
When sub-commands
_top_
and
_report_
work with -g/—-children there’re options in control of call-graph.

call-graph.record-mode
The record-mode can be
_fp_
(frame pointer),
_dwarf_
and
_lbr_. The value of
_dwarf_
is effective only if perf detect needed library (libunwind or a recent version of libdw).
_lbr_
only work for cpus that support it.

call-graph.dump-size
The size of stack to dump in order to do post-unwinding. Default is 8192 (byte). When using dwarf into record-mode, the default size will be used if omitted.

call-graph.print-type
The print-types can be graph (graph absolute), fractal (graph relative), flat and folded. This option controls a way to show overhead for each callchain entry. Suppose a following example.

.if n \{.RS 4
.\}
    Overhead  Symbols
    ........  .......
      40.00%  foo
              |
              ---foo
                 |
                 |--50.00%--bar
                 |          main
                 |
                  --50.00%--baz
                            main
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    This output is a fractal*(Aq format. The *(Aqfoo*(Aq came from *(Aqbar*(Aq and *(Aqbaz*(Aq exactly
    half and half so fractal*(Aq shows 50.00% for each
    (meaning that it assumes 100% total overhead of foo*(Aq).
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    The graph*(Aq uses absolute overhead value of *(Aqfoo*(Aq as total so each of
    bar*(Aq and *(Aqbaz*(Aq callchain will have 20.00% of overhead.
    If flat*(Aq is used, single column and linear exposure of call chains.
    folded*(Aq mean call chains are displayed in a line, separated by semicolons.
.if n \{.RE
.\}

call-graph.order
This option controls print order of callchains. The default is
_callee_
which means callee is printed at top and then followed by its caller and so on. The
_caller_
prints it in reverse order.

.if n \{.RS 4
.\}
    If this option is not set and report.children or top.children is
    set to true (or the equivalent command line option is given),
    the default value of this option is changed to caller*(Aq for the
    execution of perf report*(Aq or *(Aqperf top*(Aq. Other commands will
    still default to callee*(Aq.
.if n \{.RE
.\}

call-graph.sort-key
The callchains are merged if they contain same information. The sort-key option determines a way to compare the callchains. A value of
_sort-key_
can be
_function_
or
_address_. The default is
_function_.

call-graph.threshold
When there’re many callchains it’d print tons of lines. So perf omits small callchains under a certain overhead (threshold) and this option control the threshold. Default is 0.5 (%). The overhead is calculated by value depends on call-graph.print-type.

call-graph.print-limit
This is a maximum number of lines of callchain printed for a single histogram entry. Default is 0 which means no limitation.

report.*, report.sort_order
Allows changing the default sort order from "comm,dso,symbol" to some other default, for instance "sym,dso" may be more fitting for kernel developers.

report.percent-limit
This one is mostly the same as call-graph.threshold but works for histogram entries. Entries having an overhead lower than this percentage will not be printed. Default is
_0_. If percent-limit is
_10_, only entries which have more than 10% of overhead will be printed.

report.queue-size
This option sets up the maximum allocation size of the internal event queue for ordering events. Default is 0, meaning no limit.

report.children
_Children_
means functions called from another function. If this option is true,
_perf report_
cumulates callchains of children and show (accumulated) total overhead as well as
_Self_
overhead. Please refer to the
_perf report_
manual. The default is
_true_.

report.group
This option is to show event group information together. Example output with this turned on, notice that there is one column per event in the group, ref-cycles and cycles:

.if n \{.RS 4
.\}
    # group: {ref-cycles,cycles}
    # ========
    #
    # Samples: 7K of event anon group { ref-cycles, cycles }*(Aq
    # Event count (approx.): 6876107743
    #
    #         Overhead  Command      Shared Object               Symbol
    # ................  .......  .................  ...................
    #
        99.84%  99.76%  noploop  noploop            [.] main
         0.07%   0.00%  noploop  ld-2.15.so         [.] strcmp
         0.03%   0.00%  noploop  [kernel.kallsyms]  [k] timerqueue_del
.if n \{.RE
.\}

top.*, top.children
Same as
_report.children_. So if it is enabled, the output of
_top_
command will have
_Children_
overhead column as well as
_Self_
overhead column by default. The default is
_true_.

top.call-graph
This is identical to
_call-graph.record-mode_, except it is applicable only for
_top_
subcommand. This option ONLY setup the unwind method. To enable
_perf top_
to actually use it, the command line option -g must be specified.

man.*, man.viewer
This option can assign a tool to view manual pages when
_help_
subcommand was invoked. Supported tools are
_man_,
_woman_
(with emacs client) and
_konqueror_. Default is
_man_.

.if n \{.RS 4
.\}
    New man viewer tool can be also added using man.<tool>.cmd*(Aq
    or use different path using man.<tool>.path*(Aq config option.
.if n \{.RE
.\}

pager.*, pager.&lt;subcommand&gt;
When the subcommand is run on stdio, determine whether it uses pager or not based on this value. Default is
_unspecified_.

kmem.*, kmem.default
This option decides which allocator is to be analyzed if neither
_--slab_
nor
_--page_
option is used. Default is
_slab_.

record.*, record.build-id
This option can be
_cache_,
_no-cache_
or
_skip_.
_cache_
is to post-process data and save/update the binaries into the build-id cache (in ~/.debug). This is the default. But if this option is
_no-cache_, it will not update the build-id cache.
_skip_
skips post-processing and does not update the cache.

record.call-graph
This is identical to
_call-graph.record-mode_, except it is applicable only for
_record_
subcommand. This option ONLY setup the unwind method. To enable
_perf record_
to actually use it, the command line option -g must be specified.

record.aio
Use
_n_
control blocks in asynchronous (Posix AIO) trace writing mode (_n_
default: 1, max: 4).

diff.*, diff.order
This option sets the number of columns to sort the result. The default is 0, which means sorting by baseline. Setting it to 1 will sort the result by delta (or other compute method selected).

diff.compute
This options sets the method for computing the diff result. Possible values are
_delta_,
_delta-abs_,
_ratio_
and
_wdiff_. Default is
_delta_.

trace.*, trace.add_events
Allows adding a set of events to add to the ones specified by the user, or use as a default one if none was specified. The initial use case is to add augmented_raw_syscalls.o to activate the
_perf trace_
logic that looks for syscall pointer contents after the normal tracepoint payload.

trace.args_alignment
Number of columns to align the argument list, default is 70, use 40 for the strace default, zero to no alignment.

trace.no_inherit
Do not follow children threads.

trace.show_arg_names
Should syscall argument names be printed? If not then trace.show_zeros will be set.

trace.show_duration
Show syscall duration.

trace.show_prefix
If set to
_yes_
will show common string prefixes in tables. The default is to remove the common prefix in things like "MAP_SHARED", showing just "SHARED".

trace.show_timestamp
Show syscall start timestamp.

trace.show_zeros
Do not suppress syscall arguments that are equal to zero.

trace.tracepoint_beautifiers
Use "libtraceevent" to use that library to augment the tracepoint arguments, "libbeauty", the default, to use the same argument beautifiers used in the strace-like sys_enter+sys_exit lines.

ftrace.*, ftrace.tracer
Can be used to select the default tracer. Possible values are
_function_
and
_function\_graph_.

llvm.*, llvm.clang-path
Path to clang. If omit, search it from $PATH.

llvm.clang-bpf-cmd-template
Cmdline template. Below lines show its default value. Environment variable is used to pass options. "$CLANG_EXEC -D_KERNEL_
-D_NR\_CPUS_=$NR_CPUS "\e "-DLINUX_VERSION_CODE=$LINUX_VERSION_CODE " \e "$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \e "-Wno-unused-value -Wno-pointer-sign " \e "-working-directory $WORKING_DIR " \e "-c \e"$CLANG_SOURCE\e" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"

llvm.clang-opt
Options passed to clang.

llvm.kbuild-dir
kbuild directory. If not set, use /lib/modules/uname -r/build. If set to "" deliberately, skip kernel header auto-detector.

llvm.kbuild-opts
Options passed to
_make_
when detecting kernel header options.

llvm.dump-obj
Enable perf dump BPF object files compiled by LLVM.

llvm.opts
Options passed to llc.

samples.*, samples.context
Define how many ns worth of time to show around samples in perf report sample context browser.

scripts.*
Any option defines a script that is added to the scripts menu in the interactive perf browser and whose output is displayed. The name of the option is the name, the value is a script command line. The script gets the same options passed as a full perf script, in particular -i perfdata file, --cpu, --tid

convert.*, convert.queue-size
Limit the size of ordered_events queue, so we could control allocation size of perf data files without proper finished round events.

intel-pt.*, intel-pt.cache-divisor, intel-pt.mispred-all
If set, Intel PT decoder will set the mispred flag on all branches.

auxtrace.*, auxtrace.dumpdir
s390 only. The directory to save the auxiliary trace buffer can be changed using this option. Ex, auxtrace.dumpdir=/tmp. If the directory does not exist or has the wrong file type, the current directory is used.

<a name="see-also"></a>

# See Also


**perf**(1)
