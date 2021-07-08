# trace\-cmd\-stack(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

trace-cmd-stack - read, enable or disable Ftrace Linux kernel stack tracing.

<a name="synopsis"></a>

# Synopsis

```

 trace-cmd stack
```

<a name="description"></a>

# Description


The trace-cmd(1) stack enables the Ftrace stack tracer within the kernel. The stack tracer enables the function tracer and at each function call within the kernel, the stack is checked. When a new maximum usage stack is discovered, it is recorded.

When no option is used, the current stack is displayed.

To enable the stack tracer, use the option **--start**, and to disable the stack tracer, use the option **--stop**. The output will be the maximum stack found since the start was enabled.

Use **--reset** to reset the stack counter to zero.

<a name="see-also"></a>

# See Also


trace-cmd(1), trace-cmd-record(1), trace-cmd-report(1), trace-cmd-start(1), trace-cmd-extract(1), trace-cmd-reset(1), trace-cmd-split(1), trace-cmd-list(1), trace-cmd-listen(1)

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
