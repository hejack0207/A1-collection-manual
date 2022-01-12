# function::tokenize(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::tokenize - Return the next non-empty token in a string

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) tokenize:string(delim:string)
<synopsis>


```
    2) tokenize:string(input:string,delim:string)

<a name="arguments"></a>

# Arguments


_delim_
set of characters that delimit the tokens

_input_
string to tokenize. If empty, returns the next non-empty token in the string passed in the previous call to
**tokenize**.

<a name="description"></a>

# Description


1) This function returns the next token in the string passed in the previous call to tokenize. If no delimiter is found, the entire remaining input string is * returned. It returns empty when no more tokens are available.

2) This function returns the next non-empty token in the given input string, where the tokens are delimited by characters in the delim string. If the input string is non-empty, it returns the first token. If the input string is empty, it returns the next token in the string passed in the previous call to tokenize. If no delimiter is found, the entire remaining input string is returned. It returns empty when no more tokens are available.

<a name="see-alson-"></a>

# See Also\N 

_tapset::tokenize_(3stap)
