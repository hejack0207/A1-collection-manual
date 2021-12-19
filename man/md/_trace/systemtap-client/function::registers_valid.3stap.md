# function::registers_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::registers_valid - Determines validity of **register** and **u\_register** in current context

<a name="synopsis"></a>

# Synopsis

```


```
        registers_valid:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns 1 if
**register**
and
**u\_register**
can be used in the current context, or 0 otherwise. For example,
**registers\_valid**
returns 0 when called from a begin or end probe.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
