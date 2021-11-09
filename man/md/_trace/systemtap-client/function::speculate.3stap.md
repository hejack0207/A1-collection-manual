# function::speculate(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::speculate - Store a string for possible output later

<a name="synopsis"></a>

# Synopsis

```


```
        speculate(id:long,output:string)

<a name="arguments"></a>

# Arguments


_id_
buffer id to store the information in

_output_
string to write out when commit occurs

<a name="description"></a>

# Description


Add a string to the speculaive buffer for id.

<a name="see-alson-"></a>

# See Also\N 

_tapset::speculative_(3stap)
