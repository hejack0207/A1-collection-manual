# function::cmdline_st(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::cmdline_str - Fetch all command line arguments from current process

<a name="synopsis"></a>

# Synopsis

```


```
        cmdline_str:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


Returns all arguments from the current process delimited by spaces. Returns the empty string when the arguments cannot be retrieved.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
