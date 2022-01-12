# function::regparm(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::regparm - Specify regparm value used to compile function

<a name="synopsis"></a>

# Synopsis

```


```
        regparm(n:long)

<a name="arguments"></a>

# Arguments


_n_
original regparm value

<a name="description"></a>

# Description


Call this function with argument n before accessing function arguments using the *_arg function is the function was build with the gcc -mregparm=n option.

(The i386 kernel is built with \e-mregparm=3, so systemtap considers regparm(3) the default for kernel functions on that architecture.) Only valid on i386 and x86_64 (when probing 32bit applications). Produces an error on other architectures.

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
