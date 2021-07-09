# trace\-cmd\-list(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-list - list available plugins, events or options for Ftrace.

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd list [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) list displays the available plugins, events or Ftrace options that are configured on the current machine. If no option is given, then it lists all plugins, events and Ftrace options to standard output.

<a name="options"></a>

# Options


**-e** [_regex_]
This option will list the available events that are enabled on the local system.

.if n \{.RS 4
.\}
    It takes an optional argument that uses regcomp(3)*(Aq expressions to seach.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    trace-cmd list -e ^sys.**(Aq
.if n \{.RE
.\}

**-F**
Used with
**-e**
_regex_
to show those events formats.

**-l**
Used with
**-e**
_regex_
to show those events filters.

**-R**
Used with
**-e**
_regex_
to show those events triggers.

**-t**
This option will list the available tracers that are enabled on the local system.

**-p**
Same as
**-t**
and only for legacy purposes.

**-o**
This option will list the available Ftrace options that are configured on the local system.

**-f** [_regex_]
This option will list the available filter functions. These are the list of functions on the system that you can trace, or filter on. It takes an optional argument that uses
_regcomp(3)_
expressions to seach.

.if n \{.RS 4
.\}
    trace-cmd list -f ^sched.**(Aq
.if n \{.RE
.\}

**-P**
List the plugin files that get loaded on trace-cmd report.

**-O**
List plugin options that can be used by trace-cmd report
**-O**
option.

**-B**
List defined buffer instances (sub buffers).

**-C**
List defined clocks that can be used with trace-cmd record -C. The one in brackets ([]) is the active clock.

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-listen(1)

<a name="author"></a>

# Author


Written by Steven Rostedt, &lt;\m[blue]**[rostedt@goodmis.org](mailto:rostedt@goodmis.org)**\m[]\s-2\u[1]\d\s+2&gt;

<a name="resources"></a>

# Resources


git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git

<a name="copying"></a>

# Copying


Copyright (C) 2010 Red Hat, Inc. Free use of this software is granted under the terms of the GNU Public License (GPL).

<a name="notes"></a>

# Notes


*  1.  
  rostedt@goodmis.org
      mailto:rostedt@goodmis.org
