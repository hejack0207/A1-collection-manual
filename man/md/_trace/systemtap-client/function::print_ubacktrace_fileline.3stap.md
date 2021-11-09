# function::print_ubac(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::print_ubacktrace_fileline - Print stack back trace for current user-space task.

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) print_ubacktrace_fileline()
<synopsis>


```
    2) print_ubacktrace_fileline(pc:long,sp:long,fp:long)

<a name="arguments"></a>

# Arguments


_pc_
override PC

_sp_
override SP

_fp_
override FP

<a name="description"></a>

# Description


1)

2) Equivalent to**print\_ubacktrace**, but output for each symbol is longer including file names and line numbers.

Equivalent to
**print\_ubacktrace\_fileline**, but it performs the backtrace using the pc, sp, and fp passed in.

<a name="note"></a>

# Note


To get (full) backtraces for user space applications and shared shared libraries not mentioned in the current script run stap with -d /path/to/exe-or-so and/or add --ldd to load all needed unwind data.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-unwind_(3stap)
