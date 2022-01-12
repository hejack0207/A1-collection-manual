# function::symline(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::symline - Return the line number of an address.

<a name="synopsis"></a>

# Synopsis

```


```
        symline:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
The address to translate.

<a name="description"></a>

# Description


Returns the (approximate) line number of the given address, if known. If the line number cannot be found, the hex string representation of the address will be returned.
