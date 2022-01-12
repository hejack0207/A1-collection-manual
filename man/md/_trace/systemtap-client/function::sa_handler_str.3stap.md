# function::sa_handler(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::sa_handler_str - Returns the string representation of an sa_handler

<a name="synopsis"></a>

# Synopsis

```


```
        sa_handler_str(handler:)

<a name="arguments"></a>

# Arguments


_handler_
the sa_handler to convert to string.

<a name="description"></a>

# Description


Returns the string representation of an sa_handler. If it is not SIG_DFL, SIG_IGN or SIG_ERR, it will return the address of the handler.
