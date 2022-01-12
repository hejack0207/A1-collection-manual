# function::json_add_a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::json_add_array - Add an array

<a name="synopsis"></a>

# Synopsis

```


```
        json_add_array:long(name:string,description:string)

<a name="arguments"></a>

# Arguments


_name_
The name of the array.

_description_
Array description. An empty string can be used.

<a name="description"></a>

# Description


This function adds a array, setting up everything needed. Arrays contain other metrics, added with
**json\_add\_array\_numeric\_metric**
or
**json\_add\_array\_string\_metric**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::json_(3stap)
