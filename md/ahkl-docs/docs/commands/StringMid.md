# StringMid

Retrieves one or more characters from the specified position in a string.

**Deprecated:** This command is not recommended for use in new scripts. Use the [SubStr](SubStr.htm) function instead.

```
<span class="func">StringMid</span>, OutputVar, InputVar, StartChar <span class="optional">, Count, L</span>
```

## Parameters

OutputVar

The name of the variable in which to store the substring extracted from _InputVar_.

InputVar

The name of the variable from whose contents the substring will be extracted. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.

StartChar

The position of the first character to be extracted, which can be an [expression](../Variables.htm#Expressions). Unlike [StringGetPos](StringGetPos.htm), 1 is the first character. If _StartChar_ is less than 1, it will be assumed to be 1. If _StartChar_ is beyond the end of the string, _OutputVar_ is made empty (blank).

Count

[v1.0.43.10+]: This parameter may be omitted or left blank, which is the same as specifying an integer large enough to retrieve all characters from the string.

Otherwise, specify the number of characters to extract, which can be an [expression](../Variables.htm#Expressions). If _Count_ is less than or equal to zero, _OutputVar_ will be made empty (blank). If _Count_ exceeds the length of _InputVar_ measured from _StartChar_, _OutputVar_ will be set equal to the entirety of _InputVar_ starting at _StartChar_.

L

The letter L can be used to extract characters that lie to the left of _StartChar_ rather than to the right. In the following example, _OutputVar_ will be set to _Red_:

```
InputVar := "The Red Fox"
StringMid, OutputVar, InputVar, 7, 3, L
```

If the L option is present and _StartChar_ is less than 1, _OutputVar_ will be made blank. If _StartChar_ is beyond the length of _InputVar_, only those characters within reach of _Count_ will be extracted. For example, the below will set _OutputVar_ to _Fox_:

```
InputVar := "The Red Fox"
StringMid, OutputVar, InputVar, 14, 6, L
```

## Remarks

For this and all other commands, _OutputVar_ is allowed to be the same variable as _InputVar_.

## Related

[SubStr()](SubStr.htm), [StringLeft](StringLeft.htm), [StringRight](StringLeft.htm), [StringTrimLeft](StringTrimLeft.htm), [StringTrimRight](StringTrimLeft.htm), [IfInString](IfInString.htm), [StringGetPos](StringGetPos.htm), [StringLen](StringLen.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [StringReplace](StringReplace.htm)

## Examples

Retrieves a substring with a length of 4 characters at position 7.

```
Source := "Hello this is a test."
StringMid, the_word_this, Source, 7, 4
```

