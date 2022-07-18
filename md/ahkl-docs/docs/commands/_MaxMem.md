# \#MaxMem

Sets the maximum capacity of each [variable](../Variables.htm) to the specified number of megabytes.

```
<span class="func">#MaxMem</span> Megabytes
```

## Parameters

Megabytes

The number of megabytes to allow for each [variable](../Variables.htm). A value larger than 4095 is considered to be 4095. A value less than 1 is considered to be 1.

## Remarks

If this directive is unspecified in the script, it will behave as though set to 64.

The purpose of limiting each variable's capacity is to prevent a buggy script from consuming all available system memory. Raising or lowering the limit does not affect the performance of a script, nor does it change how much memory the script actually uses (except in the case of [WinGetText](WinGetText.htm) and [ControlGetText](ControlGetText.htm), which will be capable of retrieving more text if #MaxMem is increased).

This setting is global, meaning that it needs to be specified only once (anywhere in the script) to affect the behavior of the entire script.

This setting restricts only the automatic expansion that a variable does on its own. It does not affect [VarSetCapacity()](VarSetCapacity.htm).

Like other directives, #MaxMem cannot be executed conditionally.

## Related

[VarSetCapacity()](VarSetCapacity.htm), [Variables](../Variables.htm), [Sort](Sort.htm), [WinGetText](WinGetText.htm), [ControlGetText](ControlGetText.htm), [#MaxThreads](_MaxThreads.htm)

## Examples

Allows 256 MB instead of 64 MB per variable.

```
#MaxMem 256
```

Allows the maximum amount of MB per variable.

```
#MaxMem 4095
```

