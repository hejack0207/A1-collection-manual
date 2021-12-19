# function::usymline(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::usymline - Return the line number of an address.

<a name="synopsis"></a>

# Synopsis

```


```
        usymline:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
The address to translate.

<a name="description"></a>

# Description


Returns the (approximate) line number of the given address, if known. If the line number cannot be found, the hex string representation of the address will be returned.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-symbols_(3stap)

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-symbols_(3stap)
