# function::nsecs_to_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::nsecs_to_string - Human readable string for given nanoseconds

<a name="synopsis"></a>

# Synopsis

```


```
        nsecs_to_string:string(nsecs:long)

<a name="arguments"></a>

# Arguments


_nsecs_
Number of nanoseconds to translate.

<a name="description"></a>

# Description


Returns a string representing the number of nanoseconds as a human readable string consisting of
“XmY.ZZZZZZs”, where X is the number of minutes, Y is the number of seconds and ZZZZZZZZZ is the number of nanoseconds.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_time_(3stap)
