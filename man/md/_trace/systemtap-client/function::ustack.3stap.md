# function::ustack(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ustack - Return address at given depth of user stack backtrace

<a name="synopsis"></a>

# Synopsis

```


```
        ustack:long(n:long)

<a name="arguments"></a>

# Arguments


_n_
number of levels to descend in the stack.

<a name="description"></a>

# Description


Performs a simple (user space) backtrace, and returns the element at the specified position. The results of the backtrace itself are cached, so that the backtrace computation is performed at most once no matter how many times
**ustack**
is called, or in what order.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-symbols_(3stap)
