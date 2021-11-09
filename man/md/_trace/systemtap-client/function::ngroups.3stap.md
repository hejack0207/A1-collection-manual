# function::ngroups(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ngroups - Number of subexpressions in the last match.

<a name="synopsis"></a>

# Synopsis

```


```
        ngroups:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


returns the number of subexpressions from the last successful use of the =~ regex matching operator.

Note that this number includes subexpressions which are present in the regex but did not match any string; for example, given the regex
“a|(b)”, the subexpressions will count the group for (b) regardless of whether it matched a string or not. Throws an error if the last use of =~ was a failed match.

<a name="see-alson-"></a>

# See Also\N 

_tapset::regex_(3stap)
