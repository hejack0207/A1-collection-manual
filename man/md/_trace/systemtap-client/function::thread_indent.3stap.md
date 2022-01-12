# function::thread_ind(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::thread_indent - returns an amount of space with the current task information

<a name="synopsis"></a>

# Synopsis

```


```
        thread_indent:string(delta:long)

<a name="arguments"></a>

# Arguments


_delta_
the amount of space added/removed for each call

<a name="description"></a>

# Description


This function returns a string with appropriate indentation for a thread. Call it with a small positive or matching negative delta. If this is the real outermost, initial level of indentation, then the function resets the relative timestamp base to zero. The timestamp is as per provided by the __indent_timestamp function, which by default measures microseconds.

<a name="see-alson-"></a>

# See Also\N 

_tapset::indent_(3stap)
