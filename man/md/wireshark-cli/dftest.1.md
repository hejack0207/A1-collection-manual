# dftest(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

dftest - Shows display filter byte-code, for debugging dfilter routines.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" dftest [&nbsp;<filter>&nbsp;]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**dftest** is a simple tool which compiles a display filter and shows its bytecode.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* filter  
  .IX Item "filter"
  The display filter expression. If needed it has to be quoted.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Show how the \s-1IP\s0 protocol is filtered:

.Vb 1
    dftest ip
.Ve

Shows how frame 150 is filtered:

.Vb 1
    dftest "frame.number == 150"
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark-filter**\|(4)
