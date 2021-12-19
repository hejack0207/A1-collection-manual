# function::set_user_l(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_user_long - Writes a long value to user memory

<a name="synopsis"></a>

# Synopsis

```


```
        set_user_long(addr:long,val:long)

<a name="arguments"></a>

# Arguments


_addr_
The user address to write the long to

_val_
The long which is to be written

<a name="description"></a>

# Description


Writes the long value to a given user memory address. Reports an error when writing to the given address fails. Requires the use of guru mode (-g).

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions-guru_(3stap)
