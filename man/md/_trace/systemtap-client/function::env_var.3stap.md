# function::env_var(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::env_var - Fetch environment variable from current process

<a name="synopsis"></a>

# Synopsis

```


```
        env_var:string(name:string)

<a name="arguments"></a>

# Arguments


_name_
Name of the environment variable to fetch

<a name="description"></a>

# Description


Returns the contents of the specified environment value for the current process. If the variable isnt set an empty string is returned.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-envvar_(3stap)
