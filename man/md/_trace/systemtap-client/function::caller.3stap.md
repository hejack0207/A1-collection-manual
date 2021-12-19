# function::caller(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::caller - Return name and address of calling function

<a name="synopsis"></a>

# Synopsis

```


```
        caller:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the address and name of the calling function. This is equivalent to calling: sprintf("**s**
0x**x**", symname(**caller\_addr**),
**caller\_addr**)

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-caller_(3stap)
