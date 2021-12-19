# function::bytes_to_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::bytes_to_string - Human readable string for given bytes

<a name="synopsis"></a>

# Synopsis

```


```
        bytes_to_string:string(bytes:long)

<a name="arguments"></a>

# Arguments


_bytes_
Number of bytes to translate.

<a name="description"></a>

# Description


Returns a string representing the number of bytes (up to 1024 bytes), the number of kilobytes (when less than 1024K) postfixed by K\*(Aq, the number of megabytes (when less than 1024M) postfixed by \*(AqM\*(Aq or the number of gigabytes postfixed by \*(AqG\*(Aq. If representing K, M or G, and the number is amount is less than 100, it includes a \*(Aq.\*(Aq plus the remainer. The returned string will be 5 characters wide (padding with whitespace at the front) unless negative or representing more than 9999G bytes.

<a name="see-alson-"></a>

# See Also\N 

_tapset::proc_mem_(3stap)
