# function::dump_stack(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::dump_stack - Send the kernel backtrace to the kernel trace buffer

<a name="synopsis"></a>

# Synopsis

```


```
        dump_stack()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


Print the current kernel backtrace to the kernel trace buffer. not be safely called from all kernel probe contexts, so is restricted to guru mode only. Under the hood, it calls the kernel C API function dump_stack directly.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
