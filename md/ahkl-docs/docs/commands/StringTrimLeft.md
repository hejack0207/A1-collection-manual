# StringTrimLeft / StringTrimRight

Removes a number of characters from the left or right-hand side of a
string.

**Deprecated:** These commands are not recommended for use in new scripts. Use the [SubStr](SubStr.htm) function instead.

```
<span class="func">StringTrimLeft</span>, OutputVar, InputVar, Count
<span class="func">StringTrimRight</span>, OutputVar, InputVar, Count

```

## Parameters

OutputVar

The name of the variable in which to store the shortened version of _InputVar_.

InputVar

The name of the variable whose contents will be read from. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.

Count

The number of characters to remove, which can be an [expression](../Variables.htm#Expressions). If _Count_ is less than or equal to zero, _OutputVar_ will be set equal to the entirety of _InputVar_. If _Count_ exceeds the length of _InputVar_, _OutputVar_ will be made empty (blank).

## Remarks

For this and all other commands, _OutputVar_ is allowed to be the same variable as an _InputVar_.

## Related

[SubStr()](SubStr.htm), [StringMid](StringMid.htm), [StringLeft](StringLeft.htm), [StringRight](StringLeft.htm), [IfInString](IfInString.htm), [StringGetPos](StringGetPos.htm), [StringLen](StringLen.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [StringReplace](StringReplace.htm)

## Examples

Removes 5 characters from the left side and stores the string "is a test." in OutputVar.

```
String := "This is a test."
StringTrimLeft, OutputVar, String, 5
```

Removes 6 characters from the right side and stores the string "This is a" in OutputVar.

```
String := "This is a test."
StringTrimRight, OutputVar, String, 6
```

