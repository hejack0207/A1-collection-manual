# function::cmdline_ar(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::cmdline_args - Fetch command line arguments from current process

<a name="synopsis"></a>

# Synopsis

```


```
        cmdline_args:string(n:long,m:long,delim:string)

<a name="arguments"></a>

# Arguments


_n_
First argument to get (zero is normally the program itself)

_m_
Last argument to get (or minus one for all arguments after n)

_delim_
String to use to separate arguments when more than one.

<a name="description"></a>

# Description


Returns arguments from the current process starting with argument number n, up to argument m. If there are less than n arguments, or the arguments cannot be retrieved from the current process, the empty string is returned. If m is smaller than n then all arguments starting from argument n are returned. Argument zero is traditionally the command itself.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
