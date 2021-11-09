# function::matched_st(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::matched_str - Return the last matched string.

<a name="synopsis"></a>

# Synopsis

```


```
        matched_str:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


returns the string matched by the last successful use of the =~ regexp matching operator. Returns an error if the last use of =~ led to a failed match.

<a name="see-alson-"></a>

# See Also\N 

_tapset::regex_(3stap)
