# ferror(1)

Frysk 0\&.4\-63\&.fc30, April 2008

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ferror - print a stack trace when the given message is printed by the traced program

<a name="synopsis"></a>

# Synopsis

```
.HP \w'ferror&nbsp;'u ferror [options] {program&nbsp;arg&nbsp;...  | pid...}
```

<a name="description"></a>

# Description


**ferror**
monitors the processes write system call for the specified MESSAGE, printing a stack trace of the process at the point of the write.

<a name="stack-print-options"></a>

### Stack Print Options


**-number-of-frames ****count**
Limit the back-trace to
_count_
frames. The default is to limit the back-trace to 10 frames. Specify 0 or "all" to print all frames.

**-lite**
Perform a light-weight stack backtrace containing only minimal information. Equivalent to
**-print -**.

**-rich**
Perform a detailed stack back-trace that includes, where possible, inlined function calls, parameter names and values, and debug-names. Equivalent to
**-print inline,params,debug-names**.

**-print ****print-option****,...**
Specify the level of detail to include in a stack back-trace.
_print-option_
can be any of:

debug-names: use debug information, such as DWARF, to determine the name of functions

paths: include the full path to source files and libraries

inline: include in-line function in back-trace

locals: to include local variables from each frame

params: include the function parameters

To negate a
_print-option_
prefix it with "-".

<a name="standard-frysk-options"></a>

### Standard Frysk Options


**-exe**
The full path of the executable to read.

**-noexe**
Do not attempt to read the corresponding executable when loading a core file.

**-sysroot ****directory**
The system root directory under which all executables, libraries, and source are located.

**-debug ****class****=****level****...**
Set internal debug-tracing of the specified Java
_class_
to
_level_
(level can be NONE, INFO, WARNING, FINE, and FINEST). If the
_level_
is absent, FINE is assumed; if the
_class_
is absent, the global level is set.

<a name="example"></a>

# Example


.if n \{.RS 4
.\}
    ferror -e "No such file or directory" -- ls fake
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


frysk(7)

<a name="bugs"></a>

# Bugs


Report bugs to
\m[blue]**http://sourceware.org/frysk**\m[]
