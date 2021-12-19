# function::sprint_uba(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::sprint_ubacktrace - Return stack back trace for current user-space task as string.

<a name="synopsis"></a>

# Synopsis

```


```
        sprint_ubacktrace:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description



Returns a simple backtrace for the current task. One line per address. Includes the symbol name (or hex address if symbol couldnt be resolved) and module name (if found). Includes the offset from the start of the function if found, otherwise the offset will be added to the module (if found, between brackets). Returns the backtrace as string (each line terminated by a newline character). Note that the returned stack will be truncated to MAXSTRINGLEN, to print fuller and richer stacks use
**print\_ubacktrace**. Equivalent to sprint\_ustack(**ubacktrace**), but more efficient (no need to translate between hex strings and final backtrace string).

<a name="note"></a>

# Note


To get (full) backtraces for user space applications and shared shared libraries not mentioned in the current script run stap with -d /path/to/exe-or-so and/or add --ldd to load all needed unwind data.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-unwind_(3stap)
