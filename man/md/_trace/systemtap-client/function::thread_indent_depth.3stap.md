# function::thread_ind(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::thread_indent_depth - returns the nested-depth of the current task

<a name="synopsis"></a>

# Synopsis

```


```
        thread_indent_depth:long(delta:long)

<a name="arguments"></a>

# Arguments


_delta_
the amount of depth added/removed for each call

<a name="description"></a>

# Description


This function returns an integer equal to the nested function-call depth starting from the outermost initial level. This function is useful for saving space (consumed by whitespace) in traces with long nested function calls. Use this function in a similar fashion to
**thread\_indent**, i.e., in call-probe, use thread_indent_depth(1) and in return-probe, use thread_indent_depth(-1)

<a name="see-alson-"></a>

# See Also\N 

_tapset::indent_(3stap)
