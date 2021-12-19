# function::set_user_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_user_string_arg - Writes a string to user memory.

<a name="synopsis"></a>

# Synopsis

```


```
        set_user_string_arg(addr:long,val:string)

<a name="arguments"></a>

# Arguments


_addr_
The user address to write the string to

_val_
The string which is to be written

<a name="description"></a>

# Description


Writes the given string to a given user memory address. Reports a warning on string copy fault. Requires the use of guru mode (-g).

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions-guru_(3stap)
