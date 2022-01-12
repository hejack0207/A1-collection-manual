# function::ucallers(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ucallers - Return first n elements of user stack backtrace

<a name="synopsis"></a>

# Synopsis

```


```
        ucallers:string(n:long)

<a name="arguments"></a>

# Arguments


_n_
number of levels to descend in the stack (not counting the top level). If n is -1, print the entire stack.

<a name="description"></a>

# Description


This function returns a string of the first n hex addresses from the backtrace of the user stack. Output may be truncated as per maximum string length (MAXSTRINGLEN).

<a name="note"></a>

# Note


To get (full) backtraces for user space applications and shared shared libraries not mentioned in the current script run stap with -d /path/to/exe-or-so and/or add --ldd to load all needed unwind data.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext_(3stap)
