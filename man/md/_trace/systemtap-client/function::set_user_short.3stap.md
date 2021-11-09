# function::set_user_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_user_short - Writes a short value to user memory

<a name="synopsis"></a>

# Synopsis

```


```
        set_user_short(addr:long,val:long)

<a name="arguments"></a>

# Arguments


_addr_
The user address to write the short to

_val_
The short which is to be written

<a name="description"></a>

# Description


Writes the short value to a given user memory address. Reports an error when writing to the given address fails. Requires the use of guru mode (-g).

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions-guru_(3stap)
