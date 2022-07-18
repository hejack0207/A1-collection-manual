# StringLen

Retrieves the count of how many characters are in a string.

**Deprecated:** This command is not recommended for use in new scripts. Use the [StrLen](StrLen.htm) function instead.

```
<span class="func">StringLen</span>, OutputVar, InputVar
```

## Parameters

OutputVarThe name of the variable in which to store the length.InputVarThe name of the variable whose contents will be measured. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.

## Remarks

If InputVar is a variable to which [ClipboardAll](../misc/Clipboard.htm#ClipboardAll) was previously assigned, StringLen will retrieve its total size.

## Related

[StrLen()](StrLen.htm), [IfInString](IfInString.htm), [StringGetPos](StringGetPos.htm), [StringMid](StringMid.htm), [StringTrimLeft](StringTrimLeft.htm), [StringTrimRight](StringTrimLeft.htm), [StringLeft](StringLeft.htm), [StringRight](StringLeft.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [StringReplace](StringReplace.htm)

## Examples

Retrieves and reports the count of how many characters are in a string.

```
StrValue := "The quick brown fox jumps over the lazy dog"
StringLen, Length, StrValue
MsgBox, The length of the string is %Length%.
```

