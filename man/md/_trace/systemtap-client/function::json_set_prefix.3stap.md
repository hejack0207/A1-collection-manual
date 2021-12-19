# function::json_set_p(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::json_set_prefix - Set the metric prefix.

<a name="synopsis"></a>

# Synopsis

```


```
        json_set_prefix:long(prefix:string)

<a name="arguments"></a>

# Arguments


_prefix_
The prefix name to be used.

<a name="description"></a>

# Description


This function sets the
“prefix”, which is the name of the base of the metric hierarchy. Calling this function is optional, by default the name of the systemtap module is used.

<a name="see-alson-"></a>

# See Also\N 

_tapset::json_(3stap)
