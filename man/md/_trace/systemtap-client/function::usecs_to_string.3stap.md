# function::usecs_to_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::usecs_to_string - Human readable string for given microseconds

<a name="synopsis"></a>

# Synopsis

```


```
        usecs_to_string:string(usecs:long)

<a name="arguments"></a>

# Arguments


_usecs_
Number of microseconds to translate.

<a name="description"></a>

# Description


Returns a string representing the number of microseconds as a human readable string consisting of
“XmY.ZZZZZZs”, where X is the number of minutes, Y is the number of seconds and ZZZZZZ is the number of microseconds.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_time_(3stap)
