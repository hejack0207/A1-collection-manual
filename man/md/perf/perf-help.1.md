# perf\-help(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-help - display help information about perf

<a name="synopsis"></a>

# Synopsis

```

 perf help [-a|--all] [COMMAND]
```

<a name="description"></a>

# Description


With no options and no COMMAND given, the synopsis of the _perf_ command and a list of the most commonly used perf commands are printed on the standard output.

If the option _--all_ or _-a_ is given, then all available commands are printed on the standard output.

If a perf command is named, a manual page for that command is brought up. The _man_ program is used by default for this purpose, but this can be overridden by other options or configuration variables.

Note that perf --help ... is identical to perf help ... because the former is internally converted into the latter.

<a name="options"></a>

# Options


-a, --all
Prints all the available commands on the standard output. This option supersedes any other option.

<a name="perf"></a>

# Perf


Part of the **perf**(1) suite
