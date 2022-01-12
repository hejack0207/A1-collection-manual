# function::pages_to_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::pages_to_string - Turns pages into a human readable string

<a name="synopsis"></a>

# Synopsis

```


```
        pages_to_string:string(pages:long)

<a name="arguments"></a>

# Arguments


_pages_
Number of pages to translate.

<a name="description"></a>

# Description


Multiplies pages by
**page\_size**
to get the number of bytes and returns the result of
**bytes\_to\_string**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::proc_mem_(3stap)
