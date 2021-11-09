# function::print_ubac(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::print_ubacktrace - Print stack back trace for current user-space task.

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) print_ubacktrace()
<synopsis>


```
    2) print_ubacktrace(pc:long,sp:long,fp:long)

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

2) Equivalent to print\_ustack(**ubacktrace**), except that deeper stack nesting may be supported. Returns nothing. See
**print\_backtrace**
for kernel backtrace.

Equivalent to
**print\_ubacktrace**, but it performs the backtrace using the pc, sp, and fp provided. Useful

<a name="note"></a>

# Note


To get (full) backtraces for user space applications and shared shared libraries not mentioned in the current script run stap with -d /path/to/exe-or-so and/or add --ldd to load all needed unwind data.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-unwind_(3stap)

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-unwind_(3stap)
