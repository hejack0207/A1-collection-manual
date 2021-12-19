# function::target(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::target - Return the process ID of the target process

<a name="synopsis"></a>

# Synopsis

```


```
        target:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the process ID of the target process. This is useful in conjunction with the -x PID or -c CMD command-line options to stap. An example of its use is to create scripts that filter on a specific process.

-x &lt;pid&gt;
**target**
returns the pid specified by -x

-c &lt;command&gt;
**target**
returns the pid for the executed command specified by -c

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
