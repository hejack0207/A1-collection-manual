# systemd\-cat(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-cat - Connect a pipeline or programs output with the journal

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-cat&nbsp;[OPTIONS...]&nbsp;[COMMAND]&nbsp;[ARGUMENTS...]&nbsp;'u systemd-cat [OPTIONS...] [COMMAND] [ARGUMENTS...] .HP \w'systemd-cat&nbsp;[OPTIONS...]&nbsp;'u systemd-cat [OPTIONS...]
```

<a name="description"></a>

# Description


**systemd-cat**
may be used to connect the standard input and output of a process to the journal, or as a filter tool in a shell pipeline to pass the output the previous pipeline element generates to the journal.

If no parameter is passed,
**systemd-cat**
will write everything it reads from standard input (stdin) to the journal.

If parameters are passed, they are executed as command line with standard output (stdout) and standard error output (stderr) connected to the journal, so that all it writes is stored in the journal.

<a name="options"></a>

# Options


The following options are understood:

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

**-t**, **--identifier=**
Specify a short string that is used to identify the logging tool. If not specified, no identification string is written to the journal.

**-p**, **--priority=**
Specify the default priority level for the logged messages. Pass one of
"emerg",
"alert",
"crit",
"err",
"warning",
"notice",
"info",
"debug", or a value between 0 and 7 (corresponding to the same named levels). These priority values are the same as defined by
**syslog**(3). Defaults to
"info". Note that this simply controls the default, individual lines may be logged with different levels if they are prefixed accordingly. For details, see
**--level-prefix=**
below.

**--stderr-priority=**
Specifies the default priority level for messages from the processs standard error output (stderr). Usage of this option is the same as the
**--priority=**
option, above, and both can be used at once. When both are used,
**--priority=**
will specify the default priority for standard output (stdout).

If
**--stderr-priority=**
is not specified, messages from stderr will still be logged, with the same default priority level as stdout.

Also, note that when stdout and stderr use the same default priority, the messages will be strictly ordered, because one channel is used for both. When the default priority differs, two channels are used, and so stdout messages will not be strictly ordered with respect to stderr messages - though they will tend to be approximately ordered.

**--level-prefix=**
Controls whether lines read are parsed for syslog priority level prefixes. If enabled (the default), a line prefixed with a priority prefix such as
"&lt;5&gt;"
is logged at priority 5 ("notice"), and similar for the other priority levels. Takes a boolean argument.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Invoke a program**

This calls
/bin/ls
with standard output and error connected to the journal:

.if n \{.RS 4
.\}
    # systemd-cat ls
.if n \{.RE
.\}

**Example&nbsp;2.&nbsp;Usage in a shell pipeline**

This builds a shell pipeline also invoking
/bin/ls
and writes the output it generates to the journal:

.if n \{.RS 4
.\}
    # ls | systemd-cat
.if n \{.RE
.\}

Even though the two examples have very similar effects the first is preferable since only one process is running at a time, and both stdout and stderr are captured while in the second example, only stdout is captured.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**logger**(1)
