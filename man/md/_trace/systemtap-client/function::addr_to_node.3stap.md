# function::addr_to_no(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::addr_to_node - Returns which node a given address belongs to within a NUMA system

<a name="synopsis"></a>

# Synopsis

```


```
        addr_to_node:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
the address of the faulting memory access

<a name="description"></a>

# Description


This function accepts an address, and returns the node that the given address belongs to in a NUMA system.

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
