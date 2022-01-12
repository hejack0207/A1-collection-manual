# function::print_stac(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::print_stack - Print out kernel stack from string

<a name="synopsis"></a>

# Synopsis

```


```
        print_stack(stk:string)

<a name="arguments"></a>

# Arguments


_stk_
String with list of hexadecimal addresses

<a name="description"></a>

# Description


This function performs a symbolic lookup of the addresses in the given string, which is assumed to be the result of a prior call to
**backtrace**.

Print one line per address, including the address, the name of the function containing the address, and an estimate of its position within that function. Return nothing.

<a name="note"></a>

# Note


it is recommended to use
**print\_syms**
instead of this function.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-symbols_(3stap)
