# function::print_back(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::print_backtrace - Print kernel stack back trace

<a name="synopsis"></a>

# Synopsis

```


```
        print_backtrace()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function is equivalent to print\_stack(**backtrace**), except that deeper stack nesting may be supported. See print_ubacktrace for user-space backtrace. The function does not return a value.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-unwind_(3stap)
