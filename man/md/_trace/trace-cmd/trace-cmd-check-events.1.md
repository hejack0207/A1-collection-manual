# trace\-cmd\-check_ev(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-check-events - parse the event formats on local system

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd check-events [OPTIONS]
```

<a name="description"></a>

# Description


The trace-cmd(1) check-events parses format strings for all the events on the local system. It returns whether all the format strings can be parsed correctly. It will load plugins unless specified otherwise.

This is useful to check for any trace event format strings which may contain some internal kernel function references which cannot be decoded outside of the kernel. This may mean that either the unparsed format strings of the trace events need to be changed or that a plugin needs to be created to parse them.

<a name="options"></a>

# Options


**-N** - Don’t load plugins

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-stop(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1), trace-cmd-start(1)

<a name="author"></a>

# Author


Written by Vaibhav Nagarnaik, &lt;\m[blue]**[vnagarnaik@google.com](mailto:vnagarnaik@google.com)**\m[]\s-2\u[1]\d\s+2&gt;

<a name="resources"></a>

# Resources


git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git

<a name="copying"></a>

# Copying


Copyright (C) 2011 Google, Inc. Free use of this software is granted under the terms of the GNU Public License (GPL).

<a name="notes"></a>

# Notes


*  1.  
  vnagarnaik@google.com
      mailto:vnagarnaik@google.com
