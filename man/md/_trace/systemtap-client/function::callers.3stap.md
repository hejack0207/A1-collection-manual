# function::callers(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::callers - Return first n elements of kernel stack backtrace

<a name="synopsis"></a>

# Synopsis

```


```
        callers:string(n:long)

<a name="arguments"></a>

# Arguments


_n_
number of levels to descend in the stack (not counting the top level). If n is -1, print the entire stack.

<a name="description"></a>

# Description


This function returns a string of the first n hex addresses from the backtrace of the kernel stack. Output may be truncated as per maximum string length (MAXSTRINGLEN).

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-caller_(3stap)
