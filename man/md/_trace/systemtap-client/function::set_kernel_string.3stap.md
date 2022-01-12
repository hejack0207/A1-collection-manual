# function::set_kernel(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_kernel_string - Writes a string to kernel memory

<a name="synopsis"></a>

# Synopsis

```


```
        set_kernel_string(addr:long,val:string)

<a name="arguments"></a>

# Arguments


_addr_
The kernel address to write the string to

_val_
The string which is to be written

<a name="description"></a>

# Description


Writes the given string to a given kernel memory address. Reports an error on string copy fault. Requires the use of guru mode (-g).

<a name="see-alson-"></a>

# See Also\N 

_tapset::conversions-guru_(3stap)
