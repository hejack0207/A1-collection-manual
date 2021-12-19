# function::usymdata(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::usymdata - Return the symbol and module offset of an address.

<a name="synopsis"></a>

# Synopsis

```


```
        usymdata:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
The address to translate.

<a name="description"></a>

# Description


Returns the (function) symbol name associated with the given address in the current task if known, the offset from the start and the size of the symbol, plus the module name (between brackets). If symbol is unknown, but module is known, the offset inside the module, plus the size of the module is added. If any element is not known it will be omitted and if the symbol name is unknown it will return the hex string for the given address.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-symbols_(3stap)
