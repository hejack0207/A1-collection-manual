# function::module_nam(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::module_name - The module name of the current script

<a name="synopsis"></a>

# Synopsis

```


```
        module_name:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the name of the stap module. Either generated randomly (stap_[0-9a-f]+_[0-9a-f]+) or set by stap -m &lt;module_name&gt;.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
