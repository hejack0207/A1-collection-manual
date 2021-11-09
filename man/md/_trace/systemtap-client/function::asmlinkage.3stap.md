# function::asmlinkage(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::asmlinkage - Mark function as declared asmlinkage

<a name="synopsis"></a>

# Synopsis

```


```
        asmlinkage()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


Call this function before accessing arguments using the *_arg functions if the probed kernel function was declared asmlinkage in the source.

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
