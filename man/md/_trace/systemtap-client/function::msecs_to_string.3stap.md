# function::msecs_to_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::msecs_to_string - Human readable string for given milliseconds

<a name="synopsis"></a>

# Synopsis

```


```
        msecs_to_string:string(msecs:long)

<a name="arguments"></a>

# Arguments


_msecs_
Number of milliseconds to translate.

<a name="description"></a>

# Description


Returns a string representing the number of milliseconds as a human readable string consisting of
“XmY.ZZZs”, where X is the number of minutes, Y is the number of seconds and ZZZ is the number of milliseconds.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_time_(3stap)
