# function::print_syms(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::print_syms - Print out kernel stack from string

<a name="synopsis"></a>

# Synopsis

```


```
        print_syms(callers:string)

<a name="arguments"></a>

# Arguments


_callers_
String with list of hexadecimal (kernel) addresses

<a name="description"></a>

# Description


This function performs a symbolic lookup of the addresses in the given string, which are assumed to be the result of prior calls to
**stack**,
**callers**, and similar functions.

Prints one line per address, including the address, the name of the function containing the address, and an estimate of its position within that function, as obtained by
**symdata**. Returns nothing.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-symbols_(3stap)
