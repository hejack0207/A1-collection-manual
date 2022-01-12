# function::stack(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::stack - Return address at given depth of kernel stack backtrace

<a name="synopsis"></a>

# Synopsis

```


```
        stack:long(n:long)

<a name="arguments"></a>

# Arguments


_n_
number of levels to descend in the stack.

<a name="description"></a>

# Description


Performs a simple (kernel) backtrace, and returns the element at the specified position. The results of the backtrace itself are cached, so that the backtrace computation is performed at most once no matter how many times
**stack**
is called, or in what order.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-symbols_(3stap)
