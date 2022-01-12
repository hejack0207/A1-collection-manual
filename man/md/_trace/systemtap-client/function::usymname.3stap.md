# function::usymname(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::usymname - Return the symbol of an address in the current task.

<a name="synopsis"></a>

# Synopsis

```


```
        usymname:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
The address to translate.

<a name="description"></a>

# Description


Returns the (function) symbol name associated with the given address if known. If not known it will return the hex string representation of addr.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-symbols_(3stap)
