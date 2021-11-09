# function::returnval(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::returnval - Possible return value of probed function

<a name="synopsis"></a>

# Synopsis

```


```
        returnval:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


Return the value of the register in which function values are typically returned. Can be used in probes where
**$return**
isnt available. This is only a guess of the actual return value and can be totally wrong. Normally only used in dwarfless probes.

<a name="see-alson-"></a>

# See Also\N 

_tapset::errno_(3stap)
