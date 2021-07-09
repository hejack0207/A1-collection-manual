# kernelshark(1)

\ \&, 02/03/2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

kernelshark - graphical reader for trace-cmd(1) output

<a name="synopsis"></a>

# Synopsis

```

 kernelshark [OPTIONS]
```

<a name="description"></a>

# Description


KernelShark is a front end reader of trace-cmd(1) output. It reads a trace-cmd.dat(5) formatted file and produces a graph and list view of the data.

<a name="options"></a>

# Options


**-h**
Display the help text.

**-v**
Display the kernelshark version and exit.

**-i** _input-file_
Read trace data from the file
_input-file_. By default input is read from
_trace.dat_.

<a name="see-also"></a>

# See Also


trace-cmd(1)

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
