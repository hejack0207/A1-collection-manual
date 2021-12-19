# function::pnlabel(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::pnlabel - Returns the label name parsed from the probe name

<a name="synopsis"></a>

# Synopsis

```


```
        pnlabel:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This returns the label name as parsed from the script-level probe point. This function will only work if called directly from the body of a .label\*(Aq probe point (i.e. no aliases).

<a name="context"></a>

# Context


The current probe point.

<a name="see-alson-"></a>

# See Also\N 

_tapset::pn_(3stap)
