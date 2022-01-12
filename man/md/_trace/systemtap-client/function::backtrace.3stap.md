# function::backtrace(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::backtrace - Hex backtrace of current kernel stack

<a name="synopsis"></a>

# Synopsis

```


```
        backtrace:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns a string of hex addresses that are a backtrace of the kernel stack. Output may be truncated as per maximum string length (MAXSTRINGLEN). See
**ubacktrace**
for user-space backtrace.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-unwind_(3stap)
