# perf\-kallsyms(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-kallsyms - Searches running kernel for symbols

<a name="synopsis"></a>

# Synopsis

```


```
    perf kallsyms [<options>] symbol_name[,symbol_name...]

<a name="description"></a>

# Description


This command searches the running kernel kallsyms file for the given symbol(s) and prints information about it, including the DSO, the kallsyms begin/end addresses and the addresses in the ELF kallsyms symbol table (for symbols in modules).

<a name="options"></a>

# Options


-v, --verbose=
Increase verbosity level, showing details about symbol table loading, etc.
