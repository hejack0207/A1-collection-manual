# function::nfsderror(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::nfsderror - Convert nfsd error number into string

<a name="synopsis"></a>

# Synopsis

```


```
        nfsderror:string(err:long)

<a name="arguments"></a>

# Arguments


_err_
errnum

<a name="description"></a>

# Description


This function returns a string for the error number passed into the function.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsderrno_(3stap)
