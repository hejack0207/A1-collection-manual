# function::probe_type(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::probe_type - The low level probe handler type of the current probe.

<a name="synopsis"></a>

# Synopsis

```


```
        probe_type:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


Returns a short string describing the low level probe handler type for the current probe point. This is for informational purposes only. Depending on the low level probe handler different context functions can or cannot provide information about the current event (for example some probe handlers only trigger in user space and have no associated kernel context). High-level probes might map to the same or different low-level probes (depending on systemtap version and/or kernel used).

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
