# function::printk(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::printk - Send a message to the kernel trace buffer

<a name="synopsis"></a>

# Synopsis

```


```
        printk(level:long,msg:string)

<a name="arguments"></a>

# Arguments


_level_
an integer for the severity level (0=KERN_EMERG ... 7=KERN_DEBUG)

_msg_
The formatted message string

<a name="description"></a>

# Description


Print a line of text to the kernel dmesg/console with the given severity. An implicit end-of-line is added. This function may not be safely called from all kernel probe contexts, so is restricted to guru mode only.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
