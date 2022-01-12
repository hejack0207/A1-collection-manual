# function::pp(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::pp - Returns the active probe point

<a name="synopsis"></a>

# Synopsis

```


```
        pp:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the fully-resolved probe point associated with a currently running probe handler, including alias and wild-card expansion effects. Context: The current probe point.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
