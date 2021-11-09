# function::fp_to_long(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::fp_to_long - Convert fp to int64

<a name="synopsis"></a>

# Synopsis

```


```
        fp_to_long:long(infp:long,roundingMode:long,exact:long)

<a name="arguments"></a>

# Arguments


_infp_
the 64 bit floating point stored in long

_roundingMode_
through 0-6, which are round to nearest even, minMag, min, max, near maxMag and round to odd

_exact_
the boolean value, if exact is 1 than raising inexact exception, otherwise ignore the exception.

<a name="description"></a>

# Description


Given a 64 bit floating point, which is stored in long, use the long value to initiate self-defined float64_t type, then apply the f64_to_i64 function to get the string representation.

<a name="see-alson-"></a>

# See Also\N 

_tapset::floatingpoint_(3stap)
