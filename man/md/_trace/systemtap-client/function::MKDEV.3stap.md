# function::mkdev(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::MKDEV - Creates a value that can be compared to a kernel device number (kdev_t)

<a name="synopsis"></a>

# Synopsis

```


```
        MKDEV:long(major:long,minor:long)

<a name="arguments"></a>

# Arguments


_major_
Intended major device number.

_minor_
Intended minor device number.
