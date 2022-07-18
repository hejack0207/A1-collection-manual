# StringLeft / StringRight

Retrieves a number of characters from the left or right-hand side of
a string.

**Deprecated:** These commands are not recommended for use in new scripts. Use the [SubStr](SubStr.htm) function instead.

```
<span class="func">StringLeft</span>, OutputVar, InputVar, Count
<span class="func">StringRight</span>, OutputVar, InputVar, Count

```

## Parameters

OutputVar

The name of the variable in which to store the substring extracted from _InputVar_.

InputVar

The name of the variable whose contents will be extracted from. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.

Count

The number of characters to extract, which can be an [expression](../Variables.htm#Expressions). If _Count_ is less than or equal to zero, _OutputVar_ will be made empty (blank). If _Count_ exceeds the length of _InputVar_, _OutputVar_ will be set equal to the entirety of _InputVar_.

## Remarks

For this and all other commands, _OutputVar_ is allowed to be the same variable as an _InputVar_.

## Related

[SubStr()](SubStr.htm), [StringMid](StringMid.htm), [StringTrimLeft](StringTrimLeft.htm), [StringTrimRight](StringTrimLeft.htm), [IfInString](IfInString.htm), [StringGetPos](StringGetPos.htm), [StringLen](StringLen.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [StringReplace](StringReplace.htm)

## Examples

Stores the string "This" in OutputVar.

```
String := "This is a test."
StringLeft, OutputVar, String, 4
```

Stores the string "test." in OutputVar.

```
String := "This is a test."
StringRight, OutputVar, String, 5
```

