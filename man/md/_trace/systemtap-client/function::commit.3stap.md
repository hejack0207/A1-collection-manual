# function::commit(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::commit - Write out all output related to a speculation buffer

<a name="synopsis"></a>

# Synopsis

```


```
        commit(id:long)

<a name="arguments"></a>

# Arguments


_id_
of the buffer to store the information in

<a name="description"></a>

# Description


Output all the output for
_id_
in the order that it was entered into the speculative buffer by
**speculative**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::speculative_(3stap)
