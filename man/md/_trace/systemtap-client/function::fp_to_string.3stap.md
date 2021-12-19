# function::fp_to_stri(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::fp_to_string - Convert 64 bit floating point to string

<a name="synopsis"></a>

# Synopsis

```


```
        fp_to_string:string(infp:long,precision:long)

<a name="arguments"></a>

# Arguments


_infp_
the 64 bit floating point stored in long

_precision_
number of digits after decimal point

<a name="description"></a>

# Description


Given a 64 bit floating point, which is stored in long, use the long value to initiate self-defined float64_t type, then apply the f64_to_i64 function to get the string representation.

<a name="see-alson-"></a>

# See Also\N 

_tapset::floatingpoint_(3stap)
