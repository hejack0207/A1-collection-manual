# coredumpctl(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

coredumpctl - Retrieve and process saved core dumps and metadata

<a name="synopsis"></a>

# Synopsis

```
.HP \w'coredumpctl&nbsp;'u coredumpctl [OPTIONS...] {COMMAND} [PID|COMM|EXE|MATCH...]
```

<a name="description"></a>

# Description


**coredumpctl**
is a tool that can be used to retrieve and process core dumps and metadata which were saved by
**systemd-coredump**(8).

<a name="options"></a>

# Options


The following options are understood:

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

**--no-legend**
Do not print column headers.

**--no-pager**
Do not pipe output into a pager.

**-1**
Show information of a single core dump only, instead of listing all known core dumps.

**-S**, **--since**
Only print entries which are since the specified date.

**-U**, **--until**
Only print entries which are until the specified date.

**-r**, **--reverse**
Reverse output so that the newest entries are displayed first.

**-F** _FIELD_, **--field=**_FIELD_
Print all possible data values the specified field takes in matching core dump entries of the journal.

**-o** _FILE_, **--output=**_FILE_
Write the core to
**FILE**.

**--debugger=**_DEBUGGER_
Use the given debugger for the
**debug**
command. If not given and
_$SYSTEMD\_DEBUGGER_
is unset, then
**gdb**(1)
will be used.

**-D** _DIR_, **--directory=**_DIR_
Use the journal files in the specified
**DIR**.

**-q**, **--quiet**
Suppresses informational messages about lack of access to journal files and possible in-flight coredumps.

<a name="commands"></a>

# Commands


The following commands are understood:

**list**
List core dumps captured in the journal matching specified characteristics. If no command is specified, this is the implied default.

The output is designed to be human readable and contains list contains a table with the following columns:

TIME
The timestamp of the crash, as reported by the kernel.

PID
The identifier of the process that crashed.

UID, GID
The user and group identifiers of the process that crashed.

SIGNAL
The signal that caused the process to crash, when applicable.

COREFILE
Information whether the coredump was stored, and whether it is still accessible:
"none"
means the core was not stored,
"-"
means that it was not available (for example because the process was not terminated by a signal),
"present"
means that the core file is accessible by the current user,
"journal"
means that the core was stored in the
"journal",
"truncated"
is the same as one of the previous two, but the core was too large and was not stored in its entirety,
"error"
means that the core file cannot be accessed, most likely because of insufficient permissions, and
"missing"
means that the core was stored in a file, but this file has since been removed.

EXE
The full path to the executable. For backtraces of scripts this is the name of the interpreter.

Its worth noting that different restrictions apply to data saved in the journal and core dump files saved in
/var/lib/systemd/coredump, see overview in
**systemd-coredump**(8). Thus it may very well happen that a particular core dump is still listed in the journal while its corresponding core dump file has already been removed.

**info**
Show detailed information about the last core dump or core dumps matching specified characteristics captured in the journal.

**dump**
Extract the last core dump matching specified characteristics. The core dump will be written on standard output, unless an output file is specified with
**--output=**.

**debug**
Invoke a debugger on the last core dump matching specified characteristics. By default,
**gdb**(1)
will be used. This may be changed using the
**--debugger=**
option or the
_$SYSTEMD\_DEBUGGER_
environment variable.

<a name="matching"></a>

# Matching


A match can be:

_PID_
Process ID of the process that dumped core. An integer.

_COMM_
Name of the executable (matches
**COREDUMP\_COMM=**). Must not contain slashes.

_EXE_
Path to the executable (matches
**COREDUMP\_EXE=**). Must contain at least one slash.

_MATCH_
General journalctl match filter, must contain an equals sign ("="). See
**journalctl**(1).

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned; otherwise, a non-zero failure code is returned. Not finding any matching core dumps is treated as failure.

<a name="environment"></a>

# Environment


_$SYSTEMD\_DEBUGGER_
Use the given debugger for the
**debug**
command. See the
**--debugger=**
option.

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;List all the core dumps of a program named foo**

.if n \{.RS 4
.\}
    # coredumpctl list foo
.if n \{.RE
.\}

**Example&nbsp;2.&nbsp;Invoke gdb on the last core dump**

.if n \{.RS 4
.\}
    # coredumpctl debug
.if n \{.RE
.\}

**Example&nbsp;3.&nbsp;Show information about a process that dumped core, matching by its PID 6654**

.if n \{.RS 4
.\}
    # coredumpctl info 6654
.if n \{.RE
.\}

**Example&nbsp;4.&nbsp;Extract the last core dump of /usr/bin/bar to a file named bar.coredump**

.if n \{.RS 4
.\}
    # coredumpctl -o bar.coredump dump /usr/bin/bar
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd-coredump**(8),
**coredump.conf**(5),
**systemd-journald.service**(8),
**gdb**(1)
