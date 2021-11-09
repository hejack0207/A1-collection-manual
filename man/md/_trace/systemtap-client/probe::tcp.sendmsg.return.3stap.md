# probe::tcp\&.sendmsg(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tcp.sendmsg.return - Sending TCP message is done

<a name="synopsis"></a>

# Synopsis

```


```
    tcp.sendmsg.return 

<a name="values"></a>

# Values


_size_
Number of bytes sent or error code if an error occurred.

_name_
Name of this probe

<a name="context"></a>

# Context


The process which sends a tcp message

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcp_(3stap)
