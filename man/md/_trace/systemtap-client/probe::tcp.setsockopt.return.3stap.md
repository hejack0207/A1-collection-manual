# probe::tcp\&.setsock(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tcp.setsockopt.return - Return from **setsockopt**

<a name="synopsis"></a>

# Synopsis

```


```
    tcp.setsockopt.return 

<a name="values"></a>

# Values


_ret_
Error code (0: no error)

_name_
Name of this probe

<a name="context"></a>

# Context


The process which calls setsockopt

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcp_(3stap)
