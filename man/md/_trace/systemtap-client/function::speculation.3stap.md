# function::speculatio(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::speculation - Allocate a new id for speculative output

<a name="synopsis"></a>

# Synopsis

```


```
        speculation:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description



The
**speculation**
function is called when a new speculation buffer is needed. It returns an id for the speculative output. There can be multiple threads being speculated on concurrently. This id is used by other speculation functions to keep the threads separate.

<a name="see-alson-"></a>

# See Also\N 

_tapset::speculative_(3stap)
