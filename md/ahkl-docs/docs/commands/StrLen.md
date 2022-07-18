# StrLen()

Retrieves the count of how many characters are in a string.

```
Length := <span class="func">StrLen</span>(String)
```

## Parameters

StringThe string whose contents will be measured.

## Return Value

This function returns the length of the string.

## Remarks

If String is a variable to which [ClipboardAll](../misc/Clipboard.htm#ClipboardAll) was previously assigned, StrLen() will retrieve its total size.

## Related

[StringLen](StringLen.htm), [InStr()](InStr.htm), [SubStr()](SubStr.htm), [Trim()](Trim.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [StrPut()](StrPut.htm), [StrGet()](StrGet.htm), [StrReplace()](StrReplace.htm), [StrSplit()](StrSplit.htm)

## Examples

Retrieves and reports the count of how many characters are in a string.

```
StrValue := "The quick brown fox jumps over the lazy dog"
MsgBox % "The length of the string is " StrLen(StrValue) <em>; Result: 43</em>
```

