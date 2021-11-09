# function::probefunc(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::probefunc - Return the probe points function name, if known

<a name="synopsis"></a>

# Synopsis

```


```
        probefunc:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the name of the function being probed based on the current address, as computed by symname(**addr**) or usymname(**uaddr**) depending on probe context (whether the probe is a user probe or a kernel probe).

<a name="please-note"></a>

# Please Note


this functions behaviour differs between SystemTap 2.0 and earlier versions. Prior to 2.0,
**probefunc**
obtained the function name from the probe point string as returned by
**pp**, and used the current address as a fallback.

Consider using
**ppfunc**
instead.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-symbols_(3stap)
