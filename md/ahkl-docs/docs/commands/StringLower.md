# StringLower / StringUpper

Converts a string to lowercase or uppercase.

```
<span class="func">StringLower</span>, OutputVar, InputVar <span class="optional">, T</span>
<span class="func">StringUpper</span>, OutputVar, InputVar <span class="optional">, T</span>

```

## Parameters

OutputVar

The name of the variable in which to store newly converted string.

InputVar

The name of the variable whose contents will be read from. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.

T

If this parameter is the letter T, the string will be converted to title case. For example, "GONE with the WIND" would become "Gone With The Wind".

## Remarks

To detect whether a character or string is entirely uppercase or lowercase, use ["if var is [not] upper/lower](IfIs.htm)".

For this and all other commands, _OutputVar_ is allowed to be the same variable as an _InputVar_.

[v1.1.20+]: [Format()](Format.htm) can also be used for case conversions, as shown below:

```
MsgBox % Format("{:U}, {:L} and {:T}", "upper", "LOWER", "title")
```

## Related

[Format()](Format.htm), [IfInString](IfInString.htm), [StringGetPos](StringGetPos.htm), [StringMid](StringMid.htm), [StringTrimLeft](StringTrimLeft.htm), [StringTrimRight](StringTrimLeft.htm), [StringLeft](StringLeft.htm), [StringRight](StringLeft.htm), [StringLen](StringLen.htm), [StrReplace()](StrReplace.htm), [StringReplace](StringReplace.htm)

## Examples

Converts to lower case and stores the string "this is a test." in String1.

```
String1 := "This is a test."
StringLower, String1, String1  <em>; i.e. output can be the same as input.</em>
```

Converts to upper case and stores the string "THIS IS A TEST." in String2.

```
String2 := "This is a test."
StringUpper, String2, String2
```

Converts to title case and stores the string "This Is A Test." in String3. Note that the same effect would be achieved by using StringLower instead of StringUpper.

```
String3 := "This is a test."
StringUpper, String3, String3, T
```

