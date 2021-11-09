# function::set_kernel(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_kernel_char - Writes a char value to kernel memory

<a name="synopsis"></a>

# Synopsis

```


```
        set_kernel_char(addr:long,val:long)

<a name="arguments"></a>

# Arguments


_addr_
The kernel address to write the char to

_val_
The char which is to be written

<a name="description"></a>

# Description


Writes the char value to a given kernel memory address. Reports an error when writing to the given address fails. Requires the use of guru mode (-g).

<a name="see-alson-"></a>

# See Also\N 

_tapset::conversions-guru_(3stap)
