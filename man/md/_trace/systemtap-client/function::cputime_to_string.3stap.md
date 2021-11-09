# function::cputime_to(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::cputime_to_string - Human readable string for given cputime

<a name="synopsis"></a>

# Synopsis

```


```
        cputime_to_string:string(cputime:long)

<a name="arguments"></a>

# Arguments


_cputime_
Time to translate.

<a name="description"></a>

# Description


Equivalent to calling: msec_to_string (cputime_to_msecs (cputime).

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_time_(3stap)
