# function::addr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::addr - Address of the current probe point.

<a name="synopsis"></a>

# Synopsis

```


```
        addr:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


Returns the instruction pointer from the current probes register state. Not all probe types have registers though, in which case zero is returned. The returned address is suitable for use with functions like
**symname**
and
**symdata**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
