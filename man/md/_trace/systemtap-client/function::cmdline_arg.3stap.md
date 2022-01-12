# function::cmdline_ar(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::cmdline_arg - Fetch a command line argument

<a name="synopsis"></a>

# Synopsis

```


```
        cmdline_arg:string(n:long)

<a name="arguments"></a>

# Arguments


_n_
Argument to get (zero is the program itself)

<a name="description"></a>

# Description


Returns argument the requested argument from the current process or the empty string when there are not that many arguments or there is a problem retrieving the argument. Argument zero is traditionally the command itself.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
