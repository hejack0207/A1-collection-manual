# function::sprint_sta(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::sprint_stack - Return stack for kernel addresses from string

<a name="synopsis"></a>

# Synopsis

```


```
        sprint_stack:string(stk:string)

<a name="arguments"></a>

# Arguments


_stk_
String with list of hexadecimal (kernel) addresses

<a name="description"></a>

# Description


Perform a symbolic lookup of the addresses in the given string, which is assumed to be the result of a prior call to
**backtrace**.

Returns a simple backtrace from the given hex string. One line per address. Includes the symbol name (or hex address if symbol couldnt be resolved) and module name (if found). Includes the offset from the start of the function if found, otherwise the offset will be added to the module (if found, between brackets). Returns the backtrace as string (each line terminated by a newline character). Note that the returned stack will be truncated to MAXSTRINGLEN, to print fuller and richer stacks use print_stack.

<a name="note"></a>

# Note


it is recommended to use
**sprint\_syms**
instead of this function.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-symbols_(3stap)
