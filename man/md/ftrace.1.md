# ftrace(1)

Frysk 0\&.4\-63\&.fc30, April 2008

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ftrace - trace system calls, function calls and signals

<a name="synopsis"></a>

# Synopsis

```
.HP \w'ftrace&nbsp;'u ftrace [-f] [-follow] [-dl] [-m] [-o=FILE] [-p=PID...] [-pc] [-sys=SYSCALL[,SYSCALL...]] [-sig=SIG[,SIG...]] [-sym=RULE[,RULE...]] [-addr=RULE[,RULE...]] [-stack] [--] command&nbsp;[arguments...] 
```

<a name="description"></a>

# Description


**ftrace**
starts given
_command_
and according to tracing script given via command-line arguments, it traces its system calls, symbol entry points in general, and possibly other events as well. It uses the Frysk framework to implement tracing.

The working set of events
**ftrace**
should trace is defined by the following arguments.

<a name="process-selection-options"></a>

### Process Selection Options


-p=_PID_
Attach to a process with given
_PID_.

-f, -follow
Follow children: automatically attach to forks of traced process.

<a name="symbol-tracing"></a>

### Symbol Tracing


-dl
Trace inside dynamic linker. When this option is not present,
**ftrace**
will function as if -#INTERP#* rule was present at the end of each tracing script.

-sym=_SYMBOL_[,_SYMBOL_...]
Trace calls through the symbol entry points. Ftrace displays a message each time a thread of execution hits entry point of one of the traced functions, and then when (if) the function returns.

If
_SYMBOL_
references PLT slot, calls done through that PLT slot are recorded. You then effectively trace calls done FROM given library or executable, and generally cant say which library the call leads TO.

When tracing ordinary symbol, catch all calls that end up at this symbol. That includes the calls that dont go through PLT and as such are not intended as inter-library calls, but rather intra-library calls.

See below for detailed description of
_SYMBOL_
rule syntax.

<a name="other-traceable-events"></a>

### Other Traceable Events


-sys=_SYSCALL_[,_SYSCALL_...]
Trace system calls that match given
_SYSCALL_
ruleset. See below for description of
_SYSCALL_
syntax.

-sig=_SIGNAL_[,_SIGNAL_...]
Trace signals that match given
_SIGNAL_
ruleset. See below for description of
_SIGNAL_
syntax.

-addr=_RULE_[,_RULE_...]
Trace addresses given by
_RULE_s. See below for description of address
_RULE_
syntax.

<a name="other-options"></a>

### Other Options


-m
Print each file mapped to or unmapped from address space of the traced process.

-pc
Show the value of instruction pointer at each reported event.

-stack
Stack trace when traced symbol is hit. Note that this option also applies to traced system calls. If you need to cherry-pick which event should stack trace, use # operator described in sections below.

<a name="stack-print-options"></a>

### Stack Print Options


**-number-of-frames ****count**
Limit the back-trace to
_count_
frames. The default is to limit the back-trace to 10 frames. Specify 0 or "all" to print all frames.

**-lite**
Perform a light-weight stack backtrace containing only minimal information. Equivalent to
**-print -**.

**-rich**
Perform a detailed stack back-trace that includes, where possible, inlined function calls, parameter names and values, and debug-names. Equivalent to
**-print inline,params,debug-names**.

**-print ****print-option****,...**
Specify the level of detail to include in a stack back-trace.
_print-option_
can be any of:

debug-names: use debug information, such as DWARF, to determine the name of functions

paths: include the full path to source files and libraries

inline: include in-line function in back-trace

locals: to include local variables from each frame

params: include the function parameters

To negate a
_print-option_
prefix it with "-".

<a name="standard-frysk-options"></a>

### Standard Frysk Options


**-exe**
The full path of the executable to read.

**-noexe**
Do not attempt to read the corresponding executable when loading a core file.

**-sysroot ****directory**
The system root directory under which all executables, libraries, and source are located.

**-debug ****class****=****level****...**
Set internal debug-tracing of the specified Java
_class_
to
_level_
(level can be NONE, INFO, WARNING, FINE, and FINEST). If the
_level_
is absent, FINE is assumed; if the
_class_
is absent, the global level is set.

<a name="symbol-rule-syntax"></a>

# Symbol Rule Syntax


To decide which PLT slots or entry points should be traced, following process takes place. A set of symbols to trace ("working set") is initially empty. Rules, if present, are then enumerated from left to right, and set is modified depending on the rules. Rules are delimited by a comma. Syntax of each rule is following:

[-]_pattern_[/_options_]

Without the optional "-" all symbols that match the
_pattern_
are added to the working set. With "-", matching symbols are removed.

If "/" is present at the end of the rule, following letters are interpreted as rule flags. Currently only one flag is available, "s". When present, it means ftrace should show a stack trace when it hits a symbol that matches this rule.

When a "-" rule has an "/s" flag, the call should still be traced, but stack trace shouldnt be generated.

_pattern_
defines which symbols or PLT slots from which libraries should be added or removed from working set. Syntax of pattern is as follows:

[#_soname_#][_filename.c_#][(_proc_|_line_)#][plt:]symbol[@_version_]

_soname_
component is matched against a soname of a library in which we wish to trace the call. If the library has no associated soname (such as is usual in case of main executable), the match is done against the file name (without a path). Two special sonames are distinguished: "MAIN", which always matches main executable; and "INTERP", which always matches ELF interpreter (dynamic linker) of the main executable. If the component is missing, then the rule is applicable in all libraries and in main executable.

_filename.c_
component is matched against the name of a file where the symbol is defined. NOTE: This is currently not implemented.

_proc_
component is matched against the name of block surrounding the definition we wish to trace. If the block doesnt have a name, you can instead refer to it with the
_line_
number that the block surrounds. NOTE: This is currently not implemented.

_symbol_
component is matched against the name of symbol under consideration. If "plt:" prefix is present, the rule matches PLT entry associated with the symbol instead of the symbol itself.

_version_
component is matched against version associated with symbol. If the symbol has no associated version, it is considered to be an empty string. (It is possible to request symbol without a version with the pattern "foo@".) NOTE: This is currently not implemented.

All components are presented in glob syntax. See glob(7) manual page for more details. See below for examples.

<a name="syscall-and-signal-rule-syntax"></a>

# Syscall and Signal Rule Syntax


Under the presence of the
**-sys**
(or
**-sig**) option, ALL system calls (or signals) are ALWAYS traced. This is a limitation of the ptrace layer. The system call and signal rules however serve as a simple way of filtering out the output that you are not interested in. In following paragraphs, the word "event" will be used to mean "signal or syscall, whatever applies".

The system call and signal rule syntax and semantics are the same as the symbol rule syntax:

[-]_pattern_[/_options_]

Event selection pattern syntax is then as follows:

[_event name_|_event number_]

When the pattern is empty, it matches all events known to frysk. When the pattern is simple number (e.g. "12"), then the pattern matches the event with the given number. Otherwise the pattern is considered to be case-insensitive glob, and matched against event names. Whole name has to match for event to be a part of working set.

Signal can be given both with and without leading "sig" (e.g. "sigkill" as well as "kill").

<a name="address-rule-syntax"></a>

# Address Rule Syntax


The process of establishing a working set of addresses that should be traced is the same as for symbol rules, and the general syntax reflects that. Each rule looks like this:

[-]_pattern_[/_options_]

Each pattern then looks like this:

[#_soname_#][0x]_address_

Addresses are always given in hexadecimal notation, even if initial 0x is missing.

_soname_
component is the same as in symbol tracing, i.e. its matched against a soname of a library in which we wish to trace the address. Same rules apply regarding INTERP and MAIN meta-sonames. Refer to the chapter "SYMBOL RULE SYNTAX" for detailed description.

Even though
_soname_
is optional, at least one soname has to be specified at the beginning of the
**-addr**
command. Thats because in general it makes no sense to want to trace the same address in ALL object files at once. The components that are soname-less are assumed to have a soname of the previous component that has soname.

For example, this will trace two addresses from the main binary, and stack trace one of them:
.HP \w'**ftrace&nbsp;-addr=#MAIN#0x08052780/s,08049314&nbsp;--&nbsp;ls**&nbsp;'u
**ftrace -addr=#MAIN#0x08052780/s,08049314 -- ls**

If you need to trace the same address in several files, you can use the fact that the soname pattern is a glob.

The addresses are assumed to be copied from readelf or objdump. ftrace biases the value accordingly depending on where the module is actually mapped.

<a name="examples"></a>

# Examples


Trace all system calls:
.HP \w'**ftrace&nbsp;-sys=&nbsp;ls**&nbsp;'u
**ftrace -sys= ls**

Trace variants of stat system call and moreover a system call #3:
.HP \w'**ftrace&nbsp;-sys=*stat*,3\*(Aq&nbsp;ls**&nbsp;'u
**ftrace -sys=*stat*,3\*(Aq ls**

Various ways to tell ftrace that you want to stack trace on SIGUSR1:
.HP \w'**ftrace&nbsp;-sig=USR1/s,usr1/s,SIGUSR1/s,sigusr1/s,10/s&nbsp;~/sig**&nbsp;'u
**ftrace -sig=USR1/s,usr1/s,SIGUSR1/s,sigusr1/s,10/s ~/sig**

Trace all library calls:
.HP \w'**ftrace&nbsp;-sym=plt:*&nbsp;ls**&nbsp;'u
**ftrace -sym=plt:* ls**

Trace all library calls to functions that contain substring "write" in their names:
.HP \w'**ftrace&nbsp;-sym=plt:*write*&nbsp;ls**&nbsp;'u
**ftrace -sym=plt:*write* ls**

Trace memory functions done from libraries, i.e. not from main executable:
.HP \w'**ftrace&nbsp;-sym=plt:*alloc,plt:free,-#MAIN#plt:*\*(Aq&nbsp;ls**&nbsp;'u
**ftrace -sym=plt:*alloc,plt:free,-#MAIN#plt:*\*(Aq ls**

Stack trace on everything, except for memory allocation functions (which should still be traced):
.HP \w'**ftrace&nbsp;-sym=plt:*/s,-plt:*alloc/s,-plt:free/s\*(Aq&nbsp;ls**&nbsp;'u
**ftrace -sym=plt:*/s,-plt:*alloc/s,-plt:free/s\*(Aq ls**

<a name="see-also"></a>

# See Also


frysk(7), glob(7)

<a name="bugs"></a>

# Bugs


The option parser is greedy when looking for options so running ftrace on a program that uses options can be a problem, use -- to split between ftrace and the program. So change from:

.if n \{.RS 4
.\}
    ~/prefix/bin/ftrace ~/prefix/lib64/frysk/funit --arch 32 frysk.proc.TestAbandon
.if n \{.RE
.\}

to

.if n \{.RS 4
.\}
    ~/prefix/bin/ftrace -- ~/prefix/lib64/frysk/funit --arch 32 frysk.proc.TestAbandon
.if n \{.RE
.\}

Report bugs to
\m[blue]**http://sourceware.org/frysk**\m[]
