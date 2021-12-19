# function::jiffies(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::jiffies - Kernel jiffies count

<a name="synopsis"></a>

# Synopsis

```


```
        jiffies:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the value of the kernel jiffies variable. This value is incremented periodically by timer interrupts, and may wrap around a 32-bit or 64-bit boundary. See
**HZ**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::timestamp_(3stap)
