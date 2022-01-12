# function::tz_ctime(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::tz_ctime - Convert seconds since epoch into human readable date/time string, with local time zone

<a name="synopsis"></a>

# Synopsis

```


```
        tz_ctime(epochsecs:)

<a name="arguments"></a>

# Arguments


_epochsecs_
number of seconds since epoch (as returned by
**gettimeofday\_s**)

<a name="description"></a>

# Description


Takes an argument of seconds since the epoch as returned by
**gettimeofday\_s**. Returns a string of the same form as
**ctime**, but offsets the epoch time for the local time zone, and appends the name of the local time zone. The string length may vary. The time zone information is passed by staprun at script startup only.

<a name="see-alson-"></a>

# See Also\N 

_tapset::tzinfo_(3stap)
