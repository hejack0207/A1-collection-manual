# function::matched(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::matched - Return a given matched subexpression.

<a name="synopsis"></a>

# Synopsis

```


```
        matched:string(n:long)

<a name="arguments"></a>

# Arguments


_n_
index to the subexpression to return. 0 corresponds to the entire regular expression.

<a name="description"></a>

# Description


returns the content of the nth subexpression of the last successful use of the =~ regex matching operator. Returns an empty string if the n\*(Aqth subexpression was not matched (e.g. due to alternation). Throws an error if the last use of =~ was a failed match, or if fewer than n subexpressions are present in the original regexp.

<a name="see-alson-"></a>

# See Also\N 

_tapset::regex_(3stap)
