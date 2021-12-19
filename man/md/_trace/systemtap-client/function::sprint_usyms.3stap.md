# function::sprint_usy(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::sprint_usyms - Return stack for user addresses from string

<a name="synopsis"></a>

# Synopsis

```


```
        sprint_usyms(callers:string)

<a name="arguments"></a>

# Arguments


_callers_
String with list of hexadecimal (user) addresses

<a name="description"></a>

# Description


Perform a symbolic lookup of the addresses in the given string, which are assumed to be the result of a prior calls to
**ustack**,
**ucallers**, and similar functions.

Returns a simple backtrace from the given hex string. One line per address. Includes the symbol name (or hex address if symbol couldnt be resolved) and module name (if found), as obtained from
**usymdata**. Includes the offset from the start of the function if found, otherwise the offset will be added to the module (if found, between brackets). Returns the backtrace as string (each line terminated by a newline character). Note that the returned stack will be truncated to MAXSTRINGLEN, to print fuller and richer stacks use
**print\_usyms**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-symbols_(3stap)
