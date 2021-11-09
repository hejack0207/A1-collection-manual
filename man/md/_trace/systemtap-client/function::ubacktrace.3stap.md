# function::ubacktrace(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ubacktrace - Hex backtrace of current user-space task stack.

<a name="synopsis"></a>

# Synopsis

```


```
        ubacktrace:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description



Return a string of hex addresses that are a backtrace of the stack of the current task. Output may be truncated as per maximum string length. Returns empty string when current probe point cannot determine user backtrace. See
**backtrace**
for kernel traceback.

<a name="note"></a>

# Note


To get (full) backtraces for user space applications and shared shared libraries not mentioned in the current script run stap with -d /path/to/exe-or-so and/or add --ldd to load all needed unwind data.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext-unwind_(3stap)
