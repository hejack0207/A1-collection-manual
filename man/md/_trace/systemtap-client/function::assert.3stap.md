# function::assert(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::assert - evaluate assertion

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) assert(expression:long)
<synopsis>


```
    2) assert(expression:long,msg:string)

<a name="arguments"></a>

# Arguments


_expression_
The expression to evaluate

_msg_
The formatted message string

<a name="description"></a>

# Description


1) This function checks the expression and aborts the current running probe if expression evaluates to zero. Uses**error**
and may be caught by try{} catch{}. A default message will be displayed.

2) This function checks the expression and aborts the current running probe if expression evaluates to zero. Uses**error**
and may be caught by try{} catch{}. The specified message will be displayed.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
