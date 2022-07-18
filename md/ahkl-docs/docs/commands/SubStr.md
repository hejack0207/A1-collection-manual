# SubStr() [v1.0.46+]

Retrieves one or more characters from the specified position in a string.

```
NewStr := <span class="func">SubStr</span>(String, StartingPos <span class="optional">, Length</span>)
```

## Parameters

String

The string whose content is copied.

StartingPos

Specify 1 to start at the first character, 2 to start at the second, and so on (if _StartingPos_ is beyond _String_'s length, an empty string is returned). If _StartingPos_ is less than 1, it is considered to be an offset from the end of the string. For example, 0 extracts the last character and -1 extracts the two last characters (but if _StartingPos_ tries to go beyond the left end of the string, the extraction starts at the first character).

Length

If this parameter is omitted, it defaults to "all characters". Otherwise, specify the maximum number of characters to retrieve (fewer than the maximum are retrieved whenever the remaining part of the string is too short). You can also specify a negative _Length_ to omit that many characters from the end of the returned string (an empty string is returned if all or too many characters are omitted).

## Return Value

This function returns the requested substring of _String_.

## Remarks

Functionally, the **SubStr** function is almost the same as the [StringMid](StringMid.htm) command. However, it's recommended to use SubStr, because it is more flexible and future-proofed than StringMid.

## Related

[RegExMatch()](RegExMatch.htm), [StringMid](StringMid.htm), [StringLeft/Right](StringLeft.htm), [StringTrimLeft/Right](StringTrimLeft.htm)

## Examples

Retrieves a substring with a length of 3 characters at position 4.

```
MsgBox % SubStr("123abc789", 4, 3) <em>; Returns abc</em>
```

Retrieves a substring from the beginning and end of a string.

```
String := "The Quick Brown Fox Jumps Over the Lazy Dog"
MsgBox % SubStr(String, 1, 19)  <em>; Returns "The Quick Brown Fox"</em>
MsgBox % SubStr(String, -7)  <em>; Returns "Lazy Dog"</em>

```

