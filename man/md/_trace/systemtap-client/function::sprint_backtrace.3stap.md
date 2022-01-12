# function::sprint_bac(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::sprint_backtrace - Return stack back trace as string

<a name="synopsis"></a>

# Synopsis

```


```
        sprint_backtrace:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description



Returns a simple (kernel) backtrace. One line per address. Includes the symbol name (or hex address if symbol couldnt be resolved) and module name (if found). Includes the offset from the start of the function if found, otherwise the offset will be added to the module (if found, between brackets). Returns the backtrace as string (each line terminated by a newline character). Note that the returned stack will be truncated to MAXSTRINGLEN, to print fuller and richer stacks use
**print\_backtrace**. Equivalent to sprint\_stack(**backtrace**), but more efficient (no need to translate between hex strings and final backtrace string).

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-unwind_(3stap)
