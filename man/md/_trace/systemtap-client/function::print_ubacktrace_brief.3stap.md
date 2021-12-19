# function::print_ubac(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::print_ubacktrace_brief - Print stack back trace for current user-space task.

<a name="synopsis"></a>

# Synopsis

```


```
        print_ubacktrace_brief()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description



Equivalent to
**print\_ubacktrace**, but output for each symbol is shorter (just name and offset, or just the hex address of no symbol could be found).

<a name="note"></a>

# Note


To get (full) backtraces for user space applications and shared shared libraries not mentioned in the current script run stap with -d /path/to/exe-or-so and/or add --ldd to load all needed unwind data.
